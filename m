Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74903466A00
	for <lists+bpf@lfdr.de>; Thu,  2 Dec 2021 19:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236815AbhLBSsu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Dec 2021 13:48:50 -0500
Received: from linux.microsoft.com ([13.77.154.182]:57566 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbhLBSsu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Dec 2021 13:48:50 -0500
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by linux.microsoft.com (Postfix) with ESMTPSA id 41F4C20E67A7
        for <bpf@vger.kernel.org>; Thu,  2 Dec 2021 10:45:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 41F4C20E67A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1638470727;
        bh=XMAsry7nJ2+EFIKAyeyNRs2KKvs/JI4J5z79eo0LQ+s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N4yte0MOwx4RmqIsHe+EJnXRfYh1MAvs2uGilAWNGtGY2tHSYETdXR5ckhYBttRJk
         CeTT0IX9cz6CYocCeNqQNNsPpSn1bxWOb+tzYGoz3pXZ4lgdGX5wXHI2/zmlmaegQH
         MnIVFGfKYVCSAa0F64ZeqWvSy5wMaUmXuFgbN5cQ=
Received: by mail-pg1-f170.google.com with SMTP id 200so656095pga.1
        for <bpf@vger.kernel.org>; Thu, 02 Dec 2021 10:45:27 -0800 (PST)
X-Gm-Message-State: AOAM53052aSViMK+sWdpJvZbQyPPRhidWw3WKycPe0YLi4MkO2e0YAHH
        00yiBoCrgQ9KWZHIlCeLKf4seGgp5PCE82MP5/8=
X-Google-Smtp-Source: ABdhPJyu03+SQUtDp07EmiQkmyQ9CyqL5BDPns3ymV4ZF/Lz1SOIy8rc32tpqikbbhC169on6Hbp/tMRqarfiqOON6s=
X-Received: by 2002:a63:7904:: with SMTP id u4mr765865pgc.360.1638470726633;
 Thu, 02 Dec 2021 10:45:26 -0800 (PST)
MIME-Version: 1.0
References: <20211201181040.23337-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20211201181040.23337-1-alexei.starovoitov@gmail.com>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Thu, 2 Dec 2021 19:44:50 +0100
X-Gmail-Original-Message-ID: <CAFnufp2sP_N57qxQPoEHoMqN-NQ3HwiqKvWOecbEvFwrgK8QRw@mail.gmail.com>
Message-ID: <CAFnufp2sP_N57qxQPoEHoMqN-NQ3HwiqKvWOecbEvFwrgK8QRw@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 00/17] bpf: CO-RE support in the kernel
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 1, 2021 at 7:11 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> v4->v5:
> . Reduce number of memory allocations in candidate cache logic
> . Fix couple UAF issues
> . Add Andrii's patch to cleanup struct bpf_core_cand
> . More thorough tests
> . Planned followups:
>   - support -v in lskel
>   - move struct bpf_core_spec out of bpf_core_apply_relo_insn to
>     reduce stack usage
>   - implement bpf_core_types_are_compat
>
> v3->v4:
> . complete refactor of find candidates logic.
>   Now it has small permanent cache.
> . Fix a bug in gen_loader related to attach_kind.
> . Fix BTF log size limit.
> . More tests.
>
> v2->v3:
> . addressed Andrii's feedback in every patch.
>   New field in union bpf_attr changed from "core_relo" to "core_relos".
> . added one more test and checkpatch.pl-ed the set.
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

Hi,

I ran my usual co-re test which was failing in the v1. Relocations
looks correct now:

root@debian64:~/core# ./core
[  207.017086] prog '': relo #0: kind <byte_off> (0), spec is
[  207.017092] prog '': relo #0: matching candidate #0
[  207.017172] prog '': relo #0: patched insn #2 (LDX/ST/STX) off 208 -> 208
[  207.017239] prog '': relo #1: kind <byte_off> (0), spec is
[  207.017240] prog '': relo #1: matching candidate #0
[  207.017269] prog '': relo #1: patched insn #3 (LDX/ST/STX) off 208 -> 208
[  207.018232] prog '': relo #0: kind <byte_off> (0), spec is
[  207.018238] prog '': relo #0: matching candidate #0
[  207.018322] prog '': relo #0: patched insn #2 (LDX/ST/STX) off 104 -> 104
[  207.018384] prog '': relo #1: kind <byte_off> (0), spec is
[  207.018385] prog '': relo #1: matching candidate #0
[  207.018411] prog '': relo #1: patched insn #3 (LDX/ST/STX) off 208 -> 208
[  207.021003] prog '': relo #0: kind <byte_off> (0), spec is
[  207.021006] prog '': relo #0: matching candidate #0
[  207.021104] prog '': relo #0: patched insn #2 (LDX/ST/STX) off 104 -> 104
[  207.021167] prog '': relo #1: kind <byte_off> (0), spec is
[  207.021168] prog '': relo #1: matching candidate #0
[  207.021196] prog '': relo #1: patched insn #3 (LDX/ST/STX) off 208 -> 208

Regards,
-- 
per aspera ad upstream
