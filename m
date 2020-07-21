Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAEC227641
	for <lists+bpf@lfdr.de>; Tue, 21 Jul 2020 04:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbgGUCwp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jul 2020 22:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728545AbgGUCwp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jul 2020 22:52:45 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3394FC0619D6
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2020 19:52:45 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id l6so9593839plt.7
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2020 19:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.washington.edu; s=goo201206;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/WbGkn+wvw226WWVfxHp0ZWh+j6mSIy6XFA68Tzw7oc=;
        b=bmKwkYBH8n0mhHSrgarzUE4ElRiyDr+K4d2EBgchfYCzvYKggUsehrSJ49zrx5+KGZ
         jZBmOR8m0Cm+ET55fu5CAFMRKzhezCGaNXCJi3fHuXkXYuXHmc3E0MwBXWgl0NRVozmh
         wxKAMJeaCiUL0yMgzU7ZvH2N32+faZ7xZj7sA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/WbGkn+wvw226WWVfxHp0ZWh+j6mSIy6XFA68Tzw7oc=;
        b=R5/Syn1xJY7GojqOcINfgaeRoBI4TuM/R+7JRZVoaUG/+JLzKJoCh/UcTFsGxrDZNj
         by5UEjSXvk43/u42ZBOhgi9AN9OUzHAAQmmvbI0vs/7ZOR6U3OF3q9HEjoY/wX+0gGZg
         tLg+n1bgAxg3LpWxsrjqP6Xxkr5C1E5Sy5AmlAfro2M6SnrdMzihv0z4aBZo6m7IKLpS
         AeBZkIEnlgTPtKp10NmIg+lngd/z6E+tSbRlM1X34DdwQLjE0MuRUaAagvJJRoWfMZY8
         tnEmVFXW6ilNPkgLolXWGkndrkHrLYMSeYuuP5LPKbZqN0/1zksl7YiaZfr4O/M19fvk
         x3Eg==
X-Gm-Message-State: AOAM531qM7I9eCGpekAq2pulLz+M3vAigBTk6hw/itx2ga5dIq8jKbys
        6OhkjAaeAksqhjCr1SpBuC57MbeHJoU=
X-Google-Smtp-Source: ABdhPJyh88Ogb8H3OVRgDrNhABdUb5B/+sOrg08AXUvSzNymIUmCNOySpZ8QfNpdyttJETrJaOkJkA==
X-Received: by 2002:a17:902:6194:: with SMTP id u20mr20732136plj.68.1595299964253;
        Mon, 20 Jul 2020 19:52:44 -0700 (PDT)
Received: from localhost.localdomain (c-73-53-94-119.hsd1.wa.comcast.net. [73.53.94.119])
        by smtp.gmail.com with ESMTPSA id m16sm18769753pfd.101.2020.07.20.19.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 19:52:43 -0700 (PDT)
From:   Luke Nelson <lukenels@cs.washington.edu>
X-Google-Original-From: Luke Nelson <luke.r.nels@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Luke Nelson <luke.r.nels@gmail.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>,
        Xi Wang <xi.wang@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, netdev@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v1 0/3] bpf, riscv: Add compressed instructions to rv64 JIT
Date:   Mon, 20 Jul 2020 19:52:37 -0700
Message-Id: <20200721025241.8077-1-luke.r.nels@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch series enables using compressed riscv (RVC) instructions
in the rv64 BPF JIT.

RVC is a standard riscv extension that adds a set of compressed,
2-byte instructions that can replace some regular 4-byte instructions
for improved code density.

This series first modifies the JIT to support using 2-byte instructions
(e.g., in jump offset computations), then adds RVC encoding and
helper functions, and finally uses the helper functions to optimize
the rv64 JIT.

I used our formal verification framework, Serval, to verify the
correctness of the RVC encodings and their uses in the rv64 JIT.

The JIT continues to pass all tests in lib/test_bpf.c, and introduces
no new failures to test_verifier; both with and without RVC being enabled.

The following are examples of the JITed code for the verifier selftest
"direct packet read test#3 for CGROUP_SKB OK", without and with RVC
enabled, respectively. The former uses 178 bytes, and the latter uses 112,
for a ~37% reduction in code size for this example.

Without RVC:

   0: 02000813    addi  a6,zero,32
   4: fd010113    addi  sp,sp,-48
   8: 02813423    sd    s0,40(sp)
   c: 02913023    sd    s1,32(sp)
  10: 01213c23    sd    s2,24(sp)
  14: 01313823    sd    s3,16(sp)
  18: 01413423    sd    s4,8(sp)
  1c: 03010413    addi  s0,sp,48
  20: 03056683    lwu   a3,48(a0)
  24: 02069693    slli  a3,a3,0x20
  28: 0206d693    srli  a3,a3,0x20
  2c: 03456703    lwu   a4,52(a0)
  30: 02071713    slli  a4,a4,0x20
  34: 02075713    srli  a4,a4,0x20
  38: 03856483    lwu   s1,56(a0)
  3c: 02049493    slli  s1,s1,0x20
  40: 0204d493    srli  s1,s1,0x20
  44: 03c56903    lwu   s2,60(a0)
  48: 02091913    slli  s2,s2,0x20
  4c: 02095913    srli  s2,s2,0x20
  50: 04056983    lwu   s3,64(a0)
  54: 02099993    slli  s3,s3,0x20
  58: 0209d993    srli  s3,s3,0x20
  5c: 09056a03    lwu   s4,144(a0)
  60: 020a1a13    slli  s4,s4,0x20
  64: 020a5a13    srli  s4,s4,0x20
  68: 00900313    addi  t1,zero,9
  6c: 006a7463    bgeu  s4,t1,0x74
  70: 00000a13    addi  s4,zero,0
  74: 02d52823    sw    a3,48(a0)
  78: 02e52a23    sw    a4,52(a0)
  7c: 02952c23    sw    s1,56(a0)
  80: 03252e23    sw    s2,60(a0)
  84: 05352023    sw    s3,64(a0)
  88: 00000793    addi  a5,zero,0
  8c: 02813403    ld    s0,40(sp)
  90: 02013483    ld    s1,32(sp)
  94: 01813903    ld    s2,24(sp)
  98: 01013983    ld    s3,16(sp)
  9c: 00813a03    ld    s4,8(sp)
  a0: 03010113    addi  sp,sp,48
  a4: 00078513    addi  a0,a5,0
  a8: 00008067    jalr  zero,0(ra)

With RVC:

   0:   02000813    addi    a6,zero,32
   4:   7179        c.addi16sp  sp,-48
   6:   f422        c.sdsp  s0,40(sp)
   8:   f026        c.sdsp  s1,32(sp)
   a:   ec4a        c.sdsp  s2,24(sp)
   c:   e84e        c.sdsp  s3,16(sp)
   e:   e452        c.sdsp  s4,8(sp)
  10:   1800        c.addi4spn  s0,sp,48
  12:   03056683    lwu     a3,48(a0)
  16:   1682        c.slli  a3,0x20
  18:   9281        c.srli  a3,0x20
  1a:   03456703    lwu     a4,52(a0)
  1e:   1702        c.slli  a4,0x20
  20:   9301        c.srli  a4,0x20
  22:   03856483    lwu     s1,56(a0)
  26:   1482        c.slli  s1,0x20
  28:   9081        c.srli  s1,0x20
  2a:   03c56903    lwu     s2,60(a0)
  2e:   1902        c.slli  s2,0x20
  30:   02095913    srli    s2,s2,0x20
  34:   04056983    lwu     s3,64(a0)
  38:   1982        c.slli  s3,0x20
  3a:   0209d993    srli    s3,s3,0x20
  3e:   09056a03    lwu     s4,144(a0)
  42:   1a02        c.slli  s4,0x20
  44:   020a5a13    srli    s4,s4,0x20
  48:   4325        c.li    t1,9
  4a:   006a7363    bgeu    s4,t1,0x50
  4e:   4a01        c.li    s4,0
  50:   d914        c.sw    a3,48(a0)
  52:   d958        c.sw    a4,52(a0)
  54:   dd04        c.sw    s1,56(a0)
  56:   03252e23    sw      s2,60(a0)
  5a:   05352023    sw      s3,64(a0)
  5e:   4781        c.li    a5,0
  60:   7422        c.ldsp  s0,40(sp)
  62:   7482        c.ldsp  s1,32(sp)
  64:   6962        c.ldsp  s2,24(sp)
  66:   69c2        c.ldsp  s3,16(sp)
  68:   6a22        c.ldsp  s4,8(sp)
  6a:   6145        c.addi16sp  sp,48
  6c:   853e        c.mv    a0,a5
  6e:   8082        c.jr    ra

RFC -> v1:
  - From Björn Töpel:
    * Changed RVOFF macro to static inline "ninsns_rvoff".
    * Changed return type of rvc_ functions from u32 to u16.
    * Changed sizeof(u16) to sizeof(*ctx->insns).
  * Factored unsigned immediate checks into helper functions
    (is_8b_uint, etc.)
  * Changed to use IS_ENABLED instead of #ifdef to check if RVC is
    enabled.
  * Changed type of immediate arguments to rvc_* encoding to u32
    to avoid issues from promotion of u16 to signed int.
  * Cleaned up RVC checks in emit_{addi,slli,srli,srai}.
    + Wrapped lines at 100 instead of 80 columns for increased clarity.
	+ Move !imm checks into each branch instead of checking
	  separately.
	+ Strengthed checks for c.{slli,srli,srai} to check that
	  imm < XLEN. Otherwise, imm could be non-zero but the lower
	  XLEN bits could all be zero, leading to invalid RVC encoding.
  * Changed emit_imm to sign-extend the 12-bit value in "lower"
    + The immediate checks for emit_{addiw,li,addi} use signed
	  comparisons, so this enables the RVC variants to be used
	  more often (e.g., if val == -1, then lower should be -1
	  as opposed to 4095).

Luke Nelson (3):
  bpf, riscv: Modify JIT ctx to support compressed instructions
  bpf, riscv: Add encodings for compressed instructions
  bpf, riscv: Use compressed instructions in the rv64 JIT

 arch/riscv/net/bpf_jit.h        | 483 +++++++++++++++++++++++++++++++-
 arch/riscv/net/bpf_jit_comp32.c |  14 +-
 arch/riscv/net/bpf_jit_comp64.c | 293 ++++++++++---------
 arch/riscv/net/bpf_jit_core.c   |   6 +-
 4 files changed, 643 insertions(+), 153 deletions(-)

-- 
2.25.1

