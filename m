Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A1F4440E6
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 12:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbhKCL62 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Nov 2021 07:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbhKCL62 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Nov 2021 07:58:28 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6BBC061714
        for <bpf@vger.kernel.org>; Wed,  3 Nov 2021 04:55:51 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id v23so3341754ljk.5
        for <bpf@vger.kernel.org>; Wed, 03 Nov 2021 04:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ZoxxWrtpRa5WvnKLrUEc5Gx8dWgUhwiGLzXKYTTW/XQ=;
        b=KOqM2ZP6+cagTvbNLl6JRPpAJzVkHEkdEyJw3toRb0HrHzi4BnDfw6o7ByqpDJo6fH
         +DjGXr3Bqx9muExsYeTA7CdXSfyVXjLFmE5fVyMwX4a85uAjuP3gG+Qx/sq/zAAvg8zS
         O4d3ibppYcHe7LbQU3Uydj4pQ6zj68GiXjl60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ZoxxWrtpRa5WvnKLrUEc5Gx8dWgUhwiGLzXKYTTW/XQ=;
        b=5i096mW1i/uDD20nnUMdbWOHIGEZKcWNSRvJDyop9zEJyX3uGuHNtrFWbJvXjXI4Pa
         +cBsTNNK5YWJQ57ouoX+AbDfEYz7loYqCmN6+3Y9ThLKTmQtrFUQK4z92mWhUP+tUNzW
         ecGXVp/qvjMMNbGK6lY59bNHBjGQ5LzHbELStx9oIiEa5RW2CYCWgjdsx9Ie3ZXel02L
         UCZqtwjkOsBZ8doRuA2aJGg9zhBfizkDgkHCGxo0xUiAowVyKdlZGxEcR7mLJTkded3d
         gTz76mhNrFbf/JGG51UlzR8xQl0icL1hF1NtpeU/wQua5avUZYUQaDgkgvte1pjACkVC
         uMGA==
X-Gm-Message-State: AOAM532JFsITMnSnrUTyswZeaTbO4h68OHDJjpcffzoHy0WSQ4uMsCAw
        1eVlKiWVmkLCt+I67pYmEw6Ru2jnPNZQB2KkE+4ZZuTMEfDobA==
X-Google-Smtp-Source: ABdhPJwGzxHagauSEuk98D+b6HibExKkwS4bcdbSid0Ait0IipRrhBnQNg16YIldqRRvT9Q0fiz/NoPB9/MY6cw0A6g=
X-Received: by 2002:a2e:9c02:: with SMTP id s2mr12100613lji.121.1635940549790;
 Wed, 03 Nov 2021 04:55:49 -0700 (PDT)
MIME-Version: 1.0
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 3 Nov 2021 11:55:39 +0000
Message-ID: <CACAyw99hVEJFoiBH_ZGyy=+oO-jyydoz6v1DeKPKs2HVsUH28w@mail.gmail.com>
Subject: Verifier rejects previously accepted program
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     kernel-team <kernel-team@cloudflare.com>,
        bpf <bpf@vger.kernel.org>, regressions@lists.linux.dev,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Alexei,

I started testing our load balancer on 5.15 today, unfortunately BPF
which is happy on 5.10 gets rejected on the latest kernel.

    BPF program is too large. Processed 1000001 insn
    processed 1000001 insns (limit 1000000) max_states_per_insn 28
total_states 40641 peak_states 1104 mark_read 53

It looks like the verifier has to spend more instructions on verifying
a gnarly loop we have (start and end are u8*):

#pragma clang loop unroll(full)
    for (int b = 1 << 10; b >= 4; b >>= 1) {
        if (start + b > end) {
            continue;
        }

        // If we do 8 byte reads, we have to handle overflows which is
slower than 4 byte reads.
        for (int i = 0; i < b; i += 4) {
            csum += *(uint32_t *)(start + i);
        }

        start += b;
    }
    if (start + 2 <= end) {
        csum += *(uint16_t *)(start);
        start += 2;
    }
    if (start + 1 <= end) {
        csum += *(start);
    }

clang compiles this to:

;               if (start + b > end) {
    1906:       bf 75 00 00 00 00 00 00 r5 = r7
    1907:       07 05 00 00 4a 04 00 00 r5 += 1098
    1908:       2d 15 0d 00 00 00 00 00 if r5 > r1 goto +13 <LBB0_374>
    1909:       b7 03 00 00 00 00 00 00 r3 = 0
    1910:       b7 00 00 00 4a 00 00 00 r0 = 74
;               for (int i = 0; i < b; i += 4) {
    1911:       b7 08 00 00 4a 00 00 00 r8 = 74

0000000000003bc0 <LBB0_373>:
;                       csum += *(uint32_t *)(start + i);
    1912:       bf 74 00 00 00 00 00 00 r4 = r7
    1913:       0f 04 00 00 00 00 00 00 r4 += r0
    1914:       61 44 00 00 00 00 00 00 r4 = *(u32 *)(r4 + 0)
    1915:       0f 43 00 00 00 00 00 00 r3 += r4
;               for (int i = 0; i < b; i += 4) {
    1916:       07 08 00 00 04 00 00 00 r8 += 4
    1917:       bf 09 00 00 00 00 00 00 r9 = r0
    1918:       07 09 00 00 b6 ff ff ff r9 += -74
    1919:       bf 80 00 00 00 00 00 00 r0 = r8
    1920:       bf 54 00 00 00 00 00 00 r4 = r5
    1921:       a5 09 f6 ff fc 03 00 00 if r9 < 1020 goto -10 <LBB0_373>

0000000000003c10 <LBB0_374>:
;               if (start + b > end) {
    1922:       bf 40 00 00 00 00 00 00 r0 = r4
    1923:       07 00 00 00 00 02 00 00 r0 += 512
    1924:       bf 45 00 00 00 00 00 00 r5 = r4
    1925:       2d 10 09 00 00 00 00 00 if r0 > r1 goto +9 <LBB0_377>
    1926:       b7 08 00 00 00 00 00 00 r8 = 0

0000000000003c38 <LBB0_376>:
    1927:       bf 89 00 00 00 00 00 00 r9 = r8
;                       csum += *(uint32_t *)(start + i);
    1928:       bf 45 00 00 00 00 00 00 r5 = r4
    1929:       0f 95 00 00 00 00 00 00 r5 += r9
    1930:       61 55 00 00 00 00 00 00 r5 = *(u32 *)(r5 + 0)
    1931:       0f 53 00 00 00 00 00 00 r3 += r5
;               for (int i = 0; i < b; i += 4) {
    1932:       07 08 00 00 04 00 00 00 r8 += 4
    1933:       bf 05 00 00 00 00 00 00 r5 = r0
;               for (int i = 0; i < b; i += 4) {
    1934:       a5 09 f8 ff fc 01 00 00 if r9 < 508 goto -8 <LBB0_376>

0000000000003c78 <LBB0_377>:
;               if (start + b > end) {
    1935:       bf 50 00 00 00 00 00 00 r0 = r5
    1936:       07 00 00 00 00 01 00 00 r0 += 256
    1937:       bf 54 00 00 00 00 00 00 r4 = r5
    1938:       2d 10 09 00 00 00 00 00 if r0 > r1 goto +9 <LBB0_380>
    1939:       b7 08 00 00 00 00 00 00 r8 = 0

0000000000003ca0 <LBB0_379>:
    1940:       bf 89 00 00 00 00 00 00 r9 = r8
;                       csum += *(uint32_t *)(start + i);
    1941:       bf 54 00 00 00 00 00 00 r4 = r5
    1942:       0f 94 00 00 00 00 00 00 r4 += r9
    1943:       61 44 00 00 00 00 00 00 r4 = *(u32 *)(r4 + 0)
    1944:       0f 43 00 00 00 00 00 00 r3 += r4
;               for (int i = 0; i < b; i += 4) {
    1945:       07 08 00 00 04 00 00 00 r8 += 4
    1946:       bf 04 00 00 00 00 00 00 r4 = r0
;               for (int i = 0; i < b; i += 4) {
    1947:       a5 09 f8 ff fc 00 00 00 if r9 < 252 goto -8 <LBB0_379>

If b is <= 128 clang simply unrolls the loop. With log_level = 2 the
verifier output is full of tracing of those loops. A "short" excerpt:

    ; for (int i = 0; i < b; i += 4) {
    1911: (b7) r8 = 74
    1912: R0_w=inv74 R1=pkt_end(id=0,off=0,imm=0)
R2_w=map_value(id=0,off=0,ks=4,vs=368,imm=0) R3_w=inv0
R4=pkt(id=0,off=74,r=1098,imm=0) R5_w=pkt(id=0,off=1098,r=1098,imm=0)
R6=ctx(id=0,off=0,imm=0) R7=pkt(id=0,off=0,r=1098,imm=0) R8_w=inv74
R9=inv(id=0,umax_value=65535,var_off=(0x0; 0xffff)) R10=fp0
fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmm00m0 fp-48=mmmm0000
fp-56=00000000 fp-64=00000000 fp-72=0000mmmm fp-80=mmmmmmmm
fp-88=map_value fp-96=mmmmmmmm fp-104=map_value fp-112=inv fp-120=fp
fp-128=map_value
    ; csum += *(uint32_t *)(start + i);
    1912: (bf) r4 = r7
    1913: R0_w=inv74 R1=pkt_end(id=0,off=0,imm=0)
R2_w=map_value(id=0,off=0,ks=4,vs=368,imm=0) R3_w=inv0
R4_w=pkt(id=0,off=0,r=1098,imm=0) R5_w=pkt(id=0,off=1098,r=1098,imm=0)
R6=ctx(id=0,off=0,imm=0) R7=pkt(id=0,off=0,r=1098,imm=0) R8_w=inv74
R9=inv(id=0,umax_value=65535,var_off=(0x0; 0xffff)) R10=fp0
fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmm00m0 fp-48=mmmm0000
fp-56=00000000 fp-64=00000000 fp-72=0000mmmm fp-80=mmmmmmmm
fp-88=map_value fp-96=mmmmmmmm fp-104=map_value fp-112=inv fp-120=fp
fp-128=map_value
    1913: (0f) r4 += r0
    last_idx 1913 first_idx 1901
    regs=1 stack=0 before 1912: (bf) r4 = r7
    regs=1 stack=0 before 1911: (b7) r8 = 74
    regs=1 stack=0 before 1910: (b7) r0 = 74
    1914: R0_w=invP74 R1=pkt_end(id=0,off=0,imm=0)
R2_w=map_value(id=0,off=0,ks=4,vs=368,imm=0) R3_w=inv0
R4_w=pkt(id=0,off=74,r=1098,imm=0)
R5_w=pkt(id=0,off=1098,r=1098,imm=0) R6=ctx(id=0,off=0,imm=0)
R7=pkt(id=0,off=0,r=1098,imm=0) R8_w=inv74
R9=inv(id=0,umax_value=65535,var_off=(0x0; 0xffff)) R10=fp0
fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmm00m0 fp-48=mmmm0000
fp-56=00000000 fp-64=00000000 fp-72=0000mmmm fp-80=mmmmmmmm
fp-88=map_value fp-96=mmmmmmmm fp-104=map_value fp-112=inv fp-120=fp
fp-128=map_value
    1914: (61) r4 = *(u32 *)(r4 +0)
    1915: R0_w=invP74 R1=pkt_end(id=0,off=0,imm=0)
R2_w=map_value(id=0,off=0,ks=4,vs=368,imm=0) R3_w=inv0
R4_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R5_w=pkt(id=0,off=1098,r=1098,imm=0) R6=ctx(id=0,off=0,imm=0)
R7=pkt(id=0,off=0,r=1098,imm=0) R8_w=inv74
R9=inv(id=0,umax_value=65535,var_off=(0x0; 0xffff)) R10=fp0
fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmm00m0 fp-48=mmmm0000
fp-56=00000000 fp-64=00000000 fp-72=0000mmmm fp-80=mmmmmmmm
fp-88=map_value fp-96=mmmmmmmm fp-104=map_value fp-112=inv fp-120=fp
fp-128=map_value
    ; csum += *(uint32_t *)(start + i);
    1915: (0f) r3 += r4
    1916: R0_w=invP74 R1=pkt_end(id=0,off=0,imm=0)
R2_w=map_value(id=0,off=0,ks=4,vs=368,imm=0)
R3_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R4_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R5_w=pkt(id=0,off=1098,r=1098,imm=0) R6=ctx(id=0,off=0,imm=0)
R7=pkt(id=0,off=0,r=1098,imm=0) R8_w=inv74
R9=inv(id=0,umax_value=65535,var_off=(0x0; 0xffff)) R10=fp0
fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmm00m0 fp-48=mmmm0000
fp-56=00000000 fp-64=00000000 fp-72=0000mmmm fp-80=mmmmmmmm
fp-88=map_value fp-96=mmmmmmmm fp-104=map_value fp-112=inv fp-120=fp
fp-128=map_value
    ; for (int i = 0; i < b; i += 4) {
    1916: (07) r8 += 4
    1917: R0_w=invP74 R1=pkt_end(id=0,off=0,imm=0)
R2_w=map_value(id=0,off=0,ks=4,vs=368,imm=0)
R3_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R4_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R5_w=pkt(id=0,off=1098,r=1098,imm=0) R6=ctx(id=0,off=0,imm=0)
R7=pkt(id=0,off=0,r=1098,imm=0) R8_w=inv78
R9=inv(id=0,umax_value=65535,var_off=(0x0; 0xffff)) R10=fp0
fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmm00m0 fp-48=mmmm0000
fp-56=00000000 fp-64=00000000 fp-72=0000mmmm fp-80=mmmmmmmm
fp-88=map_value fp-96=mmmmmmmm fp-104=map_value fp-112=inv fp-120=fp
fp-128=map_value
    1917: (bf) r9 = r0
    1918: R0_w=invP74 R1=pkt_end(id=0,off=0,imm=0)
R2_w=map_value(id=0,off=0,ks=4,vs=368,imm=0)
R3_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R4_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R5_w=pkt(id=0,off=1098,r=1098,imm=0) R6=ctx(id=0,off=0,imm=0)
R7=pkt(id=0,off=0,r=1098,imm=0) R8_w=inv78 R9_w=invP74 R10=fp0
fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmm00m0 fp-48=mmmm0000
fp-56=00000000 fp-64=00000000 fp-72=0000mmmm fp-80=mmmmmmmm
fp-88=map_value fp-96=mmmmmmmm fp-104=map_value fp-112=inv fp-120=fp
fp-128=map_value
    1918: (07) r9 += -74
    1919: R0_w=invP74 R1=pkt_end(id=0,off=0,imm=0)
R2_w=map_value(id=0,off=0,ks=4,vs=368,imm=0)
R3_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R4_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R5_w=pkt(id=0,off=1098,r=1098,imm=0) R6=ctx(id=0,off=0,imm=0)
R7=pkt(id=0,off=0,r=1098,imm=0) R8_w=inv78 R9_w=invP0 R10=fp0
fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmm00m0 fp-48=mmmm0000
fp-56=00000000 fp-64=00000000 fp-72=0000mmmm fp-80=mmmmmmmm
fp-88=map_value fp-96=mmmmmmmm fp-104=map_value fp-112=inv fp-120=fp
fp-128=map_value
    1919: (bf) r0 = r8
    1920: R0_w=inv78 R1=pkt_end(id=0,off=0,imm=0)
R2_w=map_value(id=0,off=0,ks=4,vs=368,imm=0)
R3_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R4_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R5_w=pkt(id=0,off=1098,r=1098,imm=0) R6=ctx(id=0,off=0,imm=0)
R7=pkt(id=0,off=0,r=1098,imm=0) R8_w=inv78 R9_w=invP0 R10=fp0
fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmm00m0 fp-48=mmmm0000
fp-56=00000000 fp-64=00000000 fp-72=0000mmmm fp-80=mmmmmmmm
fp-88=map_value fp-96=mmmmmmmm fp-104=map_value fp-112=inv fp-120=fp
fp-128=map_value
    1920: (bf) r4 = r5
    1921: R0_w=inv78 R1=pkt_end(id=0,off=0,imm=0)
R2_w=map_value(id=0,off=0,ks=4,vs=368,imm=0)
R3_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R4_w=pkt(id=0,off=1098,r=1098,imm=0)
R5_w=pkt(id=0,off=1098,r=1098,imm=0) R6=ctx(id=0,off=0,imm=0)
R7=pkt(id=0,off=0,r=1098,imm=0) R8_w=inv78 R9_w=invP0 R10=fp0
fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmm00m0 fp-48=mmmm0000
fp-56=00000000 fp-64=00000000 fp-72=0000mmmm fp-80=mmmmmmmm
fp-88=map_value fp-96=mmmmmmmm fp-104=map_value fp-112=inv fp-120=fp
fp-128=map_value
    ; for (int i = 0; i < b; i += 4) {
    1921: (a5) if r9 < 0x3fc goto pc-10
    1912: R0=inv78 R1=pkt_end(id=0,off=0,imm=0)
R2=map_value(id=0,off=0,ks=4,vs=368,imm=0)
R3=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R4=pkt(id=0,off=1098,r=1098,imm=0) R5=pkt(id=0,off=1098,r=1098,imm=0)
R6=ctx(id=0,off=0,imm=0) R7=pkt(id=0,off=0,r=1098,imm=0) R8=inv78
R9=invP0 R10=fp0 fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmm00m0
fp-48=mmmm0000 fp-56=00000000 fp-64=00000000 fp-72=0000mmmm
fp-80=mmmmmmmm fp-88=map_value fp-96=mmmmmmmm fp-104=map_value
fp-112=inv fp-120=fp fp-128=map_value

I've bisected the problem to commit 3e8ce29850f1 ("bpf: Prevent
pointer mismatch in bpf_timer_init.") The commit seems unrelated to
loop processing though (it does touch the verifier however). Either I
got the bisection wrong or there is something subtle going on.

Lorenz

#regzb introduced: 3e8ce29850f1 ("bpf: Prevent pointer mismatch in
bpf_timer_init.")

--
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
