Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 938C719C706
	for <lists+bpf@lfdr.de>; Thu,  2 Apr 2020 18:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732214AbgDBQ1K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Apr 2020 12:27:10 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:46811 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731842AbgDBQ1K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Apr 2020 12:27:10 -0400
Received: by mail-oi1-f172.google.com with SMTP id q204so3270096oia.13
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2020 09:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=incline-eu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=V8dJz2fIiZgwJMqh2I3ZK0RyoK55u6Ys9s004u3NeHE=;
        b=FmecfHrgf0CY1GZSNh6Y1LVT26k0zX6K0MEX0K6QlCI3s0Jf2ZU4A6LLRODQpVQkfx
         NFqb1HrV3eXSRwhyukkaJY+67Tlhh2wh7JsYV0J4gw8scjnBDXbfj9vwNsDJz/6bUOp4
         wm8fHslntBCxlLtCXv0j6RgR/kGLEFldOYizUo8vAuU4iuYLoH2fXsg/zNr7U1k4V/D6
         bHLUOLNimu0kf68ZOkDkCPyO5ZBp09t+wMiyCgVFqfvQLJx8qhyJR9IGWaPJGH5Jouz9
         aIzYFGwmUrzD4PF4DZ4J4r5mRzYX4EFWN5jm/83xZ8ctgJIdIYZCVoetjsvkk2DPqI4A
         j6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=V8dJz2fIiZgwJMqh2I3ZK0RyoK55u6Ys9s004u3NeHE=;
        b=Tvb41juYTvepzdExkL4J+niV7MQKAj36Eztl6bqYKuxoAEoVo9AMYB1LSP5feQwQvs
         1BIC+IwpXKIhQPbEwjFOOGCVwRcCmn0Qt1pxJIvWgZ2B6WpLgaxOACFWUt6P8Xh1NHsG
         llNTekDE418RRuLn0edkBg6uBua5rkIFauycccnuSI9gjRmo2p24VPzxQ+IldcRhkWuF
         iMs1pH6XFYVvyfd5j7K+Le4hhTFxQFh5LipSpJSg2aSV68d+xjJjN9SI7RUNwii2KpfJ
         cthfqmVXvcuSetXljR9ifkN1LJchmoIGPyZpJG8/u/QSaur2vvrInc71VK2pCZJDVO+P
         Ir1Q==
X-Gm-Message-State: AGi0PubZUvHrxXtbVqSk2FEQOoQhJfEaY0lmpnvuYXd4URRRCdhge69Z
        j/O4kN1lemLTvIugVnXYJNA1CTgG8zT+KWDZPFap5wX6nZQelg==
X-Google-Smtp-Source: APiQypIIMLRRKU21HA93Wr9Fz91xUujHI8Rzipq1xmACDnM3gfygNe1ta37vFFpUgtycYLPGBOtmDhpWNYftz2jkpC0=
X-Received: by 2002:a05:6808:4d1:: with SMTP id a17mr1880724oie.39.1585844829198;
 Thu, 02 Apr 2020 09:27:09 -0700 (PDT)
MIME-Version: 1.0
From:   Timo Beckers <timo@incline.eu>
Date:   Thu, 2 Apr 2020 18:27:10 +0200
Message-ID: <CANgQc9iPidNLReQpdjyZy-1Ac-nZ+wKr0E_NZ50UCwRSqe6_VQ@mail.gmail.com>
Subject: arm6/7: pointers wrongly treated as 64 bits wide?
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi all,

I've been trying to get my BPF program to run on arm6/7 targets
(an RPi 3 and an ODroid XU4), but I'm having trouble getting it past
the verifier.

It's been a great learning experience, but after not making any progress for
a couple of days, I think I'm ready to blame the compiler. :(

Some background info:
- Builds are run on an x86 machine (5.5.10-arch1-1)
- Using clang+llc version 9.0.1
- Target board: RPi 3 (armv6l) 4.19.108-1-ARCH, running alarm
- Builds run against fresh mainline sources prepared with `ARCH=arm
CROSS_COMPILE=arm-linux-gnueabi- make defconfig prepare`
- Link to the full version of the program:
https://github.com/ti-mo/conntracct/blob/arm-builds/bpf/acct.c
- The program builds and runs fine on anything x86 (don't have any
arm64 around to test)

clang itself is run as follows (-W arguments omitted):

clang -D__KERNEL__ -D__BPF_TRACING__ \
    -fno-stack-protector \
    -O2 -emit-llvm \
    -c acct.c \
    -I%s/include \
    -I%s/include/uapi \
    -I%s/arch/arm/include \
    -I%s/arch/arm/include/uapi \
    -I%s/arch/arm/include/generated \
    -I%s/arch/arm/include/generated/uapi \
    --target=armv7-linux-gnueabihf \
    -o - | llc -march=bpf -filetype=obj -o acct.o

Inspired by this blog post:
https://www.collabora.com/news-and-blog/blog/2019/05/06/an-ebpf-overview-part-4-working-with-embedded-systems.

---

The verifier complains as follows:

program kretprobe____nf_ct_refresh_acct: can't load program:
permission denied: 0: (bf) r6 = r1
...
20: (85) call bpf_map_lookup_elem#1
21: (15) if r0 == 0x0 goto pc+276
 R0=map_value(id=0,off=0,ks=4,vs=4,imm=0) R6=ctx(id=0,off=0,imm=0)
R9=inv(id=0) R10=fp0,call_-1 fp-112=0
22: (7b) *(u64 *)(r10 -240) = r6
23: (7b) *(u64 *)(r10 -248) = r9
24: (61) r7 = *(u32 *)(r0 +4)
 R0=map_value(id=0,off=0,ks=4,vs=4,imm=0) R6=ctx(id=0,off=0,imm=0)
R9=inv(id=0) R10=fp0,call_-1 fp-112=0 fp-240_w=ctx
invalid access to map value, value_size=4 off=4 size=4
R0 min value is outside of the array range

The annotated objdump looks like:

;   ctp = bpf_map_lookup_elem(&currct, &pid);
      18:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
      20:       85 00 00 00 01 00 00 00 call 1
;   if (ctp == 0)
      21:       15 00 14 01 00 00 00 00 if r0 == 0 goto +276 <LBB1_51>
      22:       7b 6a 10 ff 00 00 00 00 *(u64 *)(r10 - 240) = r6
      23:       7b 9a 08 ff 00 00 00 00 *(u64 *)(r10 - 248) = r9
;   struct nf_conn *ct = *ctp;
      24:       61 07 04 00 00 00 00 00 r7 = *(u32 *)(r0 + 4)
      25:       61 06 00 00 00 00 00 00 r6 = *(u32 *)(r0 + 0)
      26:       bf a2 00 00 00 00 00 00 r2 = r10
      27:       07 02 00 00 80 ff ff ff r2 += -128
;   bpf_map_delete_elem(&currct, &pid);
      28:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
      30:       85 00 00 00 03 00 00 00 call 3
      31:       b7 01 00 00 00 00 00 00 r1 = 0
;   struct acct_event_t data = {
      32:       7b 1a 28 ff 00 00 00 00 *(u64 *)(r10 - 216) = r1
...zeroing the struct...
      44:       7b 9a 20 ff 00 00 00 00 *(u64 *)(r10 - 224) = r9
      45:       63 6a 28 ff 00 00 00 00 *(u32 *)(r10 - 216) = r6
;   struct nf_conn *ct = *ctp;
      46:       67 07 00 00 20 00 00 00 r7 <<= 32
      47:       4f 67 00 00 00 00 00 00 r7 |= r6
;   bpf_probe_read(&ct_ext, sizeof(ct_ext), &ct->ext);
      48:       bf 78 00 00 00 00 00 00 r8 = r7
      49:       07 08 00 00 a0 00 00 00 r8 += 160
      50:       bf a1 00 00 00 00 00 00 r1 = r10
      51:       07 01 00 00 90 ff ff ff r1 += -112
      52:       b7 02 00 00 04 00 00 00 r2 = 4
      53:       bf 83 00 00 00 00 00 00 r3 = r8
      54:       85 00 00 00 04 00 00 00 call 4
;   if (!ct_ext)
      55:       79 a3 90 ff 00 00 00 00 r3 = *(u64 *)(r10 - 112)
      56:       55 03 01 00 00 00 00 00 if r3 != 0 goto +1 <LBB1_6>
      57:       05 00 f0 00 00 00 00 00 goto +240 <LBB1_51>

---

A couple of lines down, `struct nf_conn *ct` is passed to a function
`extract_counters(&data, ct)`. Interestingly, when I remove this statement
along with the remainder of the function, the erroneous access to r0 + 4 is
no longer emitted. Only r0 + 0 remains, as it should, and the probe clears
the verifier and runs as expected.

The compiler is clearly aware it's targeting a 32-bit architecture because
it treats the return value of bpf_map_lookup_elem() as a u32. However, if the
result is dereferenced and later passed to a function as a pointer, it's
incorrectly considered as being 64 bits wide.

I've noticed this problem manifests itself in different ways while trying to
work around this, always when it comes to working with pointers. This is
the clearest example I could generate.

Any ideas as to what I'm doing wrong? Could this be a bug in clang/LLVM?

Timo
