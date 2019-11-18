Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1234100A1F
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2019 18:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfKRRV3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Nov 2019 12:21:29 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33093 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfKRRV3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Nov 2019 12:21:29 -0500
Received: by mail-qk1-f193.google.com with SMTP id 71so15140302qkl.0
        for <bpf@vger.kernel.org>; Mon, 18 Nov 2019 09:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WbEULxdApcvu0cgmvWVP+6riuZHIB2Jc8ugcvc0vURw=;
        b=htwV4QCFaqQ78FQJSS8XUVDDP9D2TJtJDZszLMqCIvuPePYiLIz2iYbVO3+7zuM7HY
         T3oSnHxfIEhXISgZCsZ612xWt7ngb447DxMopDNRyjRmekJjSi7z1GfVamWtXDZ+ZmQe
         qFwk74GGZGu2TKcvUU0eAtns0C/UaL7IOff3ytOFGIHaJCc4/FdtRtcu+iR5DQkpO9UG
         MEBC79F62SCKxMIsV7BNjkEFOj1kYm0i0VSeYdDk3F9r59wM+O6wbG5TNT4T6nXi5gZs
         m4qxtXGkWZXCgF2CHWQKdFqig5MmsAwUU5G/480TRMUr+V1EIvkMLTd/JFP7RNISrVES
         FG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WbEULxdApcvu0cgmvWVP+6riuZHIB2Jc8ugcvc0vURw=;
        b=a0P2ua6tH+q/HPqyTkQC2eTDxevD5Bgv+ARR7m9YpPNvGmacDqpx/01XPLKEQ5uOjG
         6qnpGhwFLzO4H2QYd7tE838JUq4wEY3slBt4tZDCL21w4KpZC+8S/iMdk2p/zFXwhqD0
         qnM6vZSkywYZtcZmCG7k1N/doda0A/Uh7VoRRpyn37oEdUU3S0+dUtNWFV33549MNZAj
         9Z1BynWdDWaVSPz3esLXyAUF4to43X2GQw3wJpV33584oVYSHWhdEj2JB8cRPFUMURBO
         REMB8KgcO4mqpIu32oNZCUdCABbp29+aRkWecPZ3JOzw2epTLGCtMi//MJeU8N3vUC6d
         qKpQ==
X-Gm-Message-State: APjAAAX4nHia38wimKHePlPkyxlBO7ITy80hd4exwAC6nPgy44ujizn5
        K/+4sF9/dVF/Qx4WzQQoC4b9PEDJCENuPqOCU3lpTQ==
X-Google-Smtp-Source: APXvYqxty3cG5M0StCWzF1cUh0HI2rYRaFL6Bci3IiMcUCZnqN865/k7PNT+2QlmEemL7QpZeeqUyHvFPM7h7WzB9lA=
X-Received: by 2002:a05:620a:1011:: with SMTP id z17mr25415371qkj.39.1574097688178;
 Mon, 18 Nov 2019 09:21:28 -0800 (PST)
MIME-Version: 1.0
References: <20191117214036.1309510-1-yhs@fb.com>
In-Reply-To: <20191117214036.1309510-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 18 Nov 2019 09:21:17 -0800
Message-ID: <CAEf4BzaTPjD94rU3xrjT0zQnFfwduJtREg04VEPPyWb+g8=UXg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] [tools/bpf] workaround an alu32 sub-register
 spilling issue
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Nov 17, 2019 at 1:41 PM Yonghong Song <yhs@fb.com> wrote:
>
> Currently, with latest llvm trunk, selftest test_progs failed
> obj file test_seg6_loop.o with the following error
> in verifier:
>   infinite loop detected at insn 76
> The byte code sequence looks like below, and noted
> that alu32 has been turned off by default for better
> generated codes in general:
>       48:       w3 = 100
>       49:       *(u32 *)(r10 - 68) = r3
>       ...
>   ;             if (tlv.type == SR6_TLV_PADDING) {
>       76:       if w3 == 5 goto -18 <LBB0_19>
>       ...
>       85:       r1 = *(u32 *)(r10 - 68)
>   ;     for (int i = 0; i < 100; i++) {
>       86:       w1 += -1
>       87:       if w1 == 0 goto +5 <LBB0_20>
>       88:       *(u32 *)(r10 - 68) = r1
>
> The main reason for verification failure is due to
> partial spills at r10 - 68 for induction variable "i".
>
> Current verifier only handles spills with 8-byte values.
> The above 4-byte value spill to stack is treated to
> STACK_MISC and its content is not saved. For the above example,
>     w3 = 100
>       R3_w=inv100 fp-64_w=inv1086626730498
>     *(u32 *)(r10 - 68) = r3
>       R3_w=inv100 fp-64_w=inv1086626730498
>     ...
>     r1 = *(u32 *)(r10 - 68)
>       R1_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
>       fp-64=inv1086626730498
>
> To resolve this issue, verifier needs to be extended to
> track sub-registers in spilling, or llvm needs to enhanced
> to prevent sub-register spilling in register allocation
> phase. The former will increase verifier complexity and
> the latter will need some llvm "hacking".
>
> Let us workaround this issue by declaring the induction
> variable as "long" type so spilling will happen at non
> sub-register level. We can revisit this later if sub-register
> spilling causes similar or other verification issues.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/testing/selftests/bpf/progs/test_seg6_loop.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/test_seg6_loop.c b/tools/testing/selftests/bpf/progs/test_seg6_loop.c
> index c4d104428643..69880c1e7700 100644
> --- a/tools/testing/selftests/bpf/progs/test_seg6_loop.c
> +++ b/tools/testing/selftests/bpf/progs/test_seg6_loop.c
> @@ -132,8 +132,10 @@ static __always_inline int is_valid_tlv_boundary(struct __sk_buff *skb,
>         *pad_off = 0;
>
>         // we can only go as far as ~10 TLVs due to the BPF max stack size
> +       // workaround: define induction variable "i" as "long" instead
> +       // of "int" to prevent alu32 sub-register spilling.
>         #pragma clang loop unroll(disable)
> -       for (int i = 0; i < 100; i++) {
> +       for (long i = 0; i < 100; i++) {

hmm, seems like our compiler settings for selftests are more lax: long
i should be defined outside the loop

>                 struct sr6_tlv_t tlv;
>
>                 if (cur_off == *tlv_off)
> --
> 2.17.1
>
