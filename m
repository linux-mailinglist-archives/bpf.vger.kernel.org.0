Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07131453F99
	for <lists+bpf@lfdr.de>; Wed, 17 Nov 2021 05:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbhKQEh2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Nov 2021 23:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbhKQEh2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Nov 2021 23:37:28 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8E5C061570
        for <bpf@vger.kernel.org>; Tue, 16 Nov 2021 20:34:30 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id y68so3587213ybe.1
        for <bpf@vger.kernel.org>; Tue, 16 Nov 2021 20:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3TAVAfGSMmJmurZRiyAoNjlpP3rtzD/xVVAAf7zzrYM=;
        b=I64NBN1iwNX1GayZpF5/W6zi+ydq9A2IzCHJ/c5KWtbhUuZoicQdcME6wUfjdpgkJR
         vejRqVAcab1MdAC6OXjIyez/HHesqZrm9Mrj4H6AEiZo3UFvO14UQC9Zcqk1uIXuuKox
         bzYfdiAd5Leq3Q+kPmgk/TIXf5TEf+KxmPCjgjHzO/LssdP4lOj9ygBtRHO0nQTe5Qg8
         lrD4ZuHiU84tyTjVO05Oy50dANNaq5J+3klbZ6s00pydxBnge6T8ewKIft3DRl+FNAU3
         U4uZc5amG76rus7pPLAsU6tQG2DRMjETdnZqtHJIrILW05/uUyIWXlr/osjcRTGVO86f
         DZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3TAVAfGSMmJmurZRiyAoNjlpP3rtzD/xVVAAf7zzrYM=;
        b=wt9MNGzYQt8bxyro8437D5si8hNoeRws2qHHWFZCNnNf4ENzZvB/cdkMiSpkO9uK68
         fuA+Oz1RLiJRDrKwMjuFXNkZdBrnPeTM5Tl39p9D8iVokF3/4eyxFa3nOptR/J93V/sd
         2alwcym78mv0LaR3RbtkMzQ5MlrWu7DDjHhRsUVXYer38w1LDA6+W7docani6J8KNPiK
         ohd7wTpCKBAP7qI6Dqddz2gt9wGUXZrocL309oHziGUyzOEpKb9epv+g1tiAM+HIcnL1
         nYgtvzGwPPHmja+IEK599FveHifkR5gFlZY4hA2PVwfmLnqGnHgw53V484N0x20we9av
         Djvg==
X-Gm-Message-State: AOAM533uVgHYoTauBO46G81OZyS5kC7ckZJGOAtlOoOiKlvzU8sFZKH3
        hRG0aiFZWC4t4I8iPJo/HcSA0nzTlWD1/hu2M2s=
X-Google-Smtp-Source: ABdhPJxwFEqfm0YlHsGeke1ksm86t5MDDzOxe1hC7rxRYCNmZi0KnRTX/a8P8i8/k+CNKtgv8GaLGz8Pb5PRh22w74w=
X-Received: by 2002:a25:afcd:: with SMTP id d13mr14703595ybj.504.1637123669308;
 Tue, 16 Nov 2021 20:34:29 -0800 (PST)
MIME-Version: 1.0
References: <20211112050230.85640-1-alexei.starovoitov@gmail.com> <CAFnufp20BUGADHQLPWsa2BDorS+_pDxT2Sn1GKkSHGBw1RgMFA@mail.gmail.com>
In-Reply-To: <CAFnufp20BUGADHQLPWsa2BDorS+_pDxT2Sn1GKkSHGBw1RgMFA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 16 Nov 2021 20:34:18 -0800
Message-ID: <CAEf4BzbhzNU-ydvTYa8XG3jRxae+83d_w7EkHaOkySQVH1BHww@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 00/12] bpf: CO-RE support in the kernel
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Miller <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 16, 2021 at 4:48 PM Matteo Croce <mcroce@linux.microsoft.com> wrote:
>
> On Fri, Nov 12, 2021 at 6:02 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > v1->v2:
> > . Refactor uapi to pass 'struct bpf_core_relo' from LLVM into libbpf and further
> > into the kernel instead of bpf_core_apply_relo() bpf helper. Because of this
> > change the CO-RE algorithm has an ability to log error and debug events through
> > the standard bpf verifer log mechanism which was not possible with helper
> > approach.
> > . #define RELO_CORE macro was removed and replaced with btf_member_bit_offset() patch.
> >
> > This set introduces CO-RE support in the kernel.
> > There are several reasons to add such support:
> > 1. It's a step toward signed BPF programs.
> > 2. It allows golang like languages that struggle to adopt libbpf
> >    to take advantage of CO-RE powers.
> > 3. Currently the field accessed by 'ldx [R1 + 10]' insn is recognized
> >    by the verifier purely based on +10 offset. If R1 points to a union
> >    the verifier picks one of the fields at this offset.
> >    With CO-RE the kernel can disambiguate the field access.
> >
>
> Great, I tested the same code which was failing with the RFC series,
> now there isn't any error.
> This is the output with pr_debug() enabled:
>
> root@debian64:~/core# ./core
> [    5.690268] prog '(null)': relo #-2115894237: kind <(null)>
> (163299788), spec is
> [    5.690272] prog '(null)': relo #-2115894246: (null) candidate #-2115185528
> [    5.690392] prog '(null)': relo #2: patched insn #208 (LDX/ST/STX)
> off 208 -> 208
> [    5.691045] prog '(efault)': relo #-2115894237: kind <(null)>
> (163299788), spec is
> [    5.691047] prog '(efault)': relo #-2115894246: (null) candidate
> #-2115185528
> [    5.691148] prog '(efault)': relo #3: patched insn #208
> (LDX/ST/STX) off 208 -> 208
> [    5.692456] prog '(null)': relo #-2115894237: kind <(null)>
> (163302708), spec is
> [    5.692459] prog '(null)': relo #-2115894246: (null) candidate #-2115185668
> [    5.692564] prog '(null)': relo #2: patched insn #104 (LDX/ST/STX)
> off 104 -> 104
> [    5.693179] prog '(efault)': relo #-2115894237: kind <(null)>
> (163299788), spec is
> [    5.693181] prog '(efault)': relo #-2115894246: (null) candidate
> #-2115185528
> [    5.693258] prog '(efault)': relo #3: patched insn #208
> (LDX/ST/STX) off 208 -> 208
> [    5.696141] prog '(null)': relo #-2115894237: kind <(null)>
> (163302708), spec is
> [    5.696143] prog '(null)': relo #-2115894246: (null) candidate #-2115185668
> [    5.696255] prog '(null)': relo #2: patched insn #104 (LDX/ST/STX)
> off 104 -> 104
> [    5.696733] prog '(efault)': relo #-2115894237: kind <(null)>
> (163299788), spec is
> [    5.696734] prog '(efault)': relo #-2115894246: (null) candidate
> #-2115185528
> [    5.696833] prog '(efault)': relo #3: patched insn #208
> (LDX/ST/STX) off 208 -> 208

All the logged values are completely wrong, some corruption somewhere.

But I tried to see it for myself and I couldn't figure out how to get
these logs with lskel. How did you get the above?

Alexei, any guidance on how to get those verifier logs back with
test_progs? ./test_progs -vvv didn't help, I also checked trace_pipe
output, it was empty. I thought that maybe verifier truncates logs on
success and simulated failed prog validation, but still nothing.

>
> And the syscall returns success:
>
> bpf(BPF_PROG_TEST_RUN, {test={prog_fd=4, retval=0, data_size_in=0,
> data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0,
> ctx_size_in=68, ctx_size_out=0, ctx_in=0x5590b97dd2a0, ctx_out=NULL}},
> 160) = 0
>
> Regards,
> --
> per aspera ad upstream
