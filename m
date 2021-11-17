Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980B2453D57
	for <lists+bpf@lfdr.de>; Wed, 17 Nov 2021 01:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhKQAvw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Nov 2021 19:51:52 -0500
Received: from linux.microsoft.com ([13.77.154.182]:57508 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbhKQAvv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Nov 2021 19:51:51 -0500
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
        by linux.microsoft.com (Postfix) with ESMTPSA id 26BDB20C6376
        for <bpf@vger.kernel.org>; Tue, 16 Nov 2021 16:48:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 26BDB20C6376
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1637110134;
        bh=75twU7NIZAcfuLZqCWb4kRzr01+M2zUdyS7YeyJGBaI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jXHYjHxPQU8C0tGUgBrifak8pUwpPZGIinOE82xUF+OSrv98L3iyRrm8Mjz0VcgPh
         OIM1rO4DCBq0z/xkB/gioG06RPUfI1zFBhcvwnn2qWlRb6dB2gUn75L9dBtuAIXns5
         5hZUuQ3lPhsbe25ipqWkjcJFP5kdQBZjq183CVns=
Received: by mail-pj1-f49.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so3722641pju.3
        for <bpf@vger.kernel.org>; Tue, 16 Nov 2021 16:48:54 -0800 (PST)
X-Gm-Message-State: AOAM530nxtGa1OM1kxrCdB2rpkcnWGVw17kh81GPigYB13IwYcYcnpr1
        xkfRQWAyOqBjTLSVZr8IEJ9l8cyMnlLJwc4gSRw=
X-Google-Smtp-Source: ABdhPJw0KvgaKNCgBM6SmidhKHIGMHVdBBG4G9UBVRdDnryUfWIJYsPT70yiD1+zutIPYbkQfgaR9cUGNcn1EW8fLHk=
X-Received: by 2002:a17:902:d4d0:b0:141:c13d:6c20 with SMTP id
 o16-20020a170902d4d000b00141c13d6c20mr50510593plg.44.1637110133637; Tue, 16
 Nov 2021 16:48:53 -0800 (PST)
MIME-Version: 1.0
References: <20211112050230.85640-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20211112050230.85640-1-alexei.starovoitov@gmail.com>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Wed, 17 Nov 2021 01:48:17 +0100
X-Gmail-Original-Message-ID: <CAFnufp20BUGADHQLPWsa2BDorS+_pDxT2Sn1GKkSHGBw1RgMFA@mail.gmail.com>
Message-ID: <CAFnufp20BUGADHQLPWsa2BDorS+_pDxT2Sn1GKkSHGBw1RgMFA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 00/12] bpf: CO-RE support in the kernel
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 12, 2021 at 6:02 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> v1->v2:
> . Refactor uapi to pass 'struct bpf_core_relo' from LLVM into libbpf and further
> into the kernel instead of bpf_core_apply_relo() bpf helper. Because of this
> change the CO-RE algorithm has an ability to log error and debug events through
> the standard bpf verifer log mechanism which was not possible with helper
> approach.
> . #define RELO_CORE macro was removed and replaced with btf_member_bit_offset() patch.
>
> This set introduces CO-RE support in the kernel.
> There are several reasons to add such support:
> 1. It's a step toward signed BPF programs.
> 2. It allows golang like languages that struggle to adopt libbpf
>    to take advantage of CO-RE powers.
> 3. Currently the field accessed by 'ldx [R1 + 10]' insn is recognized
>    by the verifier purely based on +10 offset. If R1 points to a union
>    the verifier picks one of the fields at this offset.
>    With CO-RE the kernel can disambiguate the field access.
>

Great, I tested the same code which was failing with the RFC series,
now there isn't any error.
This is the output with pr_debug() enabled:

root@debian64:~/core# ./core
[    5.690268] prog '(null)': relo #-2115894237: kind <(null)>
(163299788), spec is
[    5.690272] prog '(null)': relo #-2115894246: (null) candidate #-2115185528
[    5.690392] prog '(null)': relo #2: patched insn #208 (LDX/ST/STX)
off 208 -> 208
[    5.691045] prog '(efault)': relo #-2115894237: kind <(null)>
(163299788), spec is
[    5.691047] prog '(efault)': relo #-2115894246: (null) candidate
#-2115185528
[    5.691148] prog '(efault)': relo #3: patched insn #208
(LDX/ST/STX) off 208 -> 208
[    5.692456] prog '(null)': relo #-2115894237: kind <(null)>
(163302708), spec is
[    5.692459] prog '(null)': relo #-2115894246: (null) candidate #-2115185668
[    5.692564] prog '(null)': relo #2: patched insn #104 (LDX/ST/STX)
off 104 -> 104
[    5.693179] prog '(efault)': relo #-2115894237: kind <(null)>
(163299788), spec is
[    5.693181] prog '(efault)': relo #-2115894246: (null) candidate
#-2115185528
[    5.693258] prog '(efault)': relo #3: patched insn #208
(LDX/ST/STX) off 208 -> 208
[    5.696141] prog '(null)': relo #-2115894237: kind <(null)>
(163302708), spec is
[    5.696143] prog '(null)': relo #-2115894246: (null) candidate #-2115185668
[    5.696255] prog '(null)': relo #2: patched insn #104 (LDX/ST/STX)
off 104 -> 104
[    5.696733] prog '(efault)': relo #-2115894237: kind <(null)>
(163299788), spec is
[    5.696734] prog '(efault)': relo #-2115894246: (null) candidate
#-2115185528
[    5.696833] prog '(efault)': relo #3: patched insn #208
(LDX/ST/STX) off 208 -> 208

And the syscall returns success:

bpf(BPF_PROG_TEST_RUN, {test={prog_fd=4, retval=0, data_size_in=0,
data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0,
ctx_size_in=68, ctx_size_out=0, ctx_in=0x5590b97dd2a0, ctx_out=NULL}},
160) = 0

Regards,
-- 
per aspera ad upstream
