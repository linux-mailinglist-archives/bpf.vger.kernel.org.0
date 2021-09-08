Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1918403848
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 12:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346120AbhIHKyn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Sep 2021 06:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348969AbhIHKym (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Sep 2021 06:54:42 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDCFC061575
        for <bpf@vger.kernel.org>; Wed,  8 Sep 2021 03:53:34 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id s16so2432290ybe.0
        for <bpf@vger.kernel.org>; Wed, 08 Sep 2021 03:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8+FiuvJj8Y4nT8SCPEuVHuMdoydnO/ZdFnbO3tV8nt4=;
        b=0U5bbvfC1NC3O0SPdmzv2/on6Pl1YX6DSCMLy3Qw3OKvDoinV7iBgFtX0n30uRg7R0
         jJVYRcDDITXGbnrhyIODlROcaZUErYbt9EdaP7bGcvNMgOZjOhHBBiD7cRYBF0mqAtET
         sd6fGgV621Rr7tic5qbuHNtgSQPLzZqoQ1pBaKncCeSh0zW2dYlmyr/YKXgtehwJC2EW
         bu9119sTeN74SjJx2SR7umQtv6dOKtmS9VUBMIz0wiLU7iAvxx5g54BNMgV+DBlgpzh0
         nEkE6xNZXFl8n88ej8bsCjI1itaf5NouT6Qh6Lujy+eYqKHgEjwjQ3iRhLYm1U0OW+iQ
         7HUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8+FiuvJj8Y4nT8SCPEuVHuMdoydnO/ZdFnbO3tV8nt4=;
        b=JTXFPzmyJFRFj46XZlY/QbglkpSe614HAsBg6+5JuVSztzYK1g/+dhyUYnib9/duAd
         69mr51lVFMwpQIJMatM1K2cFuxuOyvS+Wz0zcAGFQPcnsoLfj1zlWd8y8LeDS1O6HPeo
         DerBKrDlBDzk1kPsi37WIoivUyxSv0WxDU733nl1ktIoO4r4N62Tbfc6NZDggNHMAhhO
         aupB4LRzP81z+nrUKtXENfPd0a1FTxINbukTBK8QxL/TwVRDiMyayZXuMUPffNogg6QL
         kTW1dO6OXqHEPQOtpApXfA5UGBNbjZF9Z299rupSz86m8LcP1OioCzxrTsjgpz+O4me/
         VWyw==
X-Gm-Message-State: AOAM531EjuTC2BE0Esxau24/xbAJS43zg9jxVNYtPnLegYZ5PPNos57h
        ubLLsZdqls3MB9FeiDbLAHJs+p1LmTadte8Z6kjnVA==
X-Google-Smtp-Source: ABdhPJywWobX7mjX+JOraUaQSgQ1OOfd2U+jhJ8Bll1RPXi3aL1mUC2LfRIpsld6Hd++Enxx8y8uwZTOmTRNAW73jYE=
X-Received: by 2002:a05:6902:124f:: with SMTP id t15mr4369311ybu.161.1631098414000;
 Wed, 08 Sep 2021 03:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210907222339.4130924-1-johan.almbladh@anyfinetworks.com>
 <20210907222339.4130924-14-johan.almbladh@anyfinetworks.com> <fe04c10b5991a5fb0656fe272c137a73ec7d2472.camel@linux.ibm.com>
In-Reply-To: <fe04c10b5991a5fb0656fe272c137a73ec7d2472.camel@linux.ibm.com>
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date:   Wed, 8 Sep 2021 12:53:23 +0200
Message-ID: <CAM1=_QTC077YiaJ_7x=ooq2HyKhYFEPt_C04y1uo4tNEyGioFA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 13/13] bpf/tests: Add tail call limit test
 with external function call
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 8, 2021 at 12:10 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Wed, 2021-09-08 at 00:23 +0200, Johan Almbladh wrote:
> > This patch adds a tail call limit test where the program also emits
> > a BPF_CALL to an external function prior to the tail call. Mainly
> > testing that JITed programs preserve its internal register state, for
> > example tail call count, across such external calls.
> >
> > Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
> > ---
> >  lib/test_bpf.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 48 insertions(+), 3 deletions(-)
> >
> > diff --git a/lib/test_bpf.c b/lib/test_bpf.c
> > index 7475abfd2186..6e45b4da9841 100644
> > --- a/lib/test_bpf.c
> > +++ b/lib/test_bpf.c
> > @@ -12259,6 +12259,20 @@ static struct tail_call_test tail_call_tests[]
> > = {
> >                 },
> >                 .result = MAX_TAIL_CALL_CNT + 1,
> >         },
> > +       {
> > +               "Tail call count preserved across function calls",
> > +               .insns = {
> > +                       BPF_ALU64_IMM(BPF_ADD, R1, 1),
> > +                       BPF_STX_MEM(BPF_DW, R10, R1, -8),
> > +                       BPF_CALL_REL(0),
> > +                       BPF_LDX_MEM(BPF_DW, R1, R10, -8),
> > +                       BPF_ALU32_REG(BPF_MOV, R0, R1),
> > +                       TAIL_CALL(0),
> > +                       BPF_EXIT_INSN(),
> > +               },
> > +               .stack_depth = 8,
> > +               .result = MAX_TAIL_CALL_CNT + 1,
> > +       },
> >         {
> >                 "Tail call error path, NULL target",
> >                 .insns = {
>
> There seems to be a problem with BPF_CALL_REL(0) on s390, since it
> assumes that test_bpf_func and __bpf_call_base are within +-2G of
> each other, which is not (yet) the case.

The idea with this test is to mess up a JITed program's internal state
if it does not properly save/restore those regs. I would like to keep
the test in some form, but I do see the problem here.

Another option could perhaps be to skip this test at runtime if the
computed offset is outside +-2G. If the offset is greater than that it
does not fit into the 32-bit BPF immediate field, and must therefore
be skipped. This would work for other archs too.

Yet another solution would be call one or several bpf helpers instead.
As I understand it, they should always be located within this range,
otherwise they would not be callable from a BPF program. The reason I
did not do this was because I found helpers that don't require any
context to be too simple. Ideally one would want to call something
that uses pretty much all available caller-saved CPU registers. I
figured snprintf would be complex/nasty enough for this purpose.

>
> I can't think of a good fix, so how about something like this?
>
> --- a/lib/test_bpf.c
> +++ b/lib/test_bpf.c
> @@ -12257,6 +12257,7 @@ static struct tail_call_test tail_call_tests[]
> = {
>                 },
>                 .result = MAX_TAIL_CALL_CNT + 1,
>         },
> +#ifndef __s390__
>         {
>                 "Tail call count preserved across function calls",
>                 .insns = {
> @@ -12271,6 +12272,7 @@ static struct tail_call_test tail_call_tests[]
> = {
>                 .stack_depth = 8,
>                 .result = MAX_TAIL_CALL_CNT + 1,
>         },
> +#endif
>         {
>                 "Tail call error path, NULL target",
>                 .insns = {
>
> [...]
>
