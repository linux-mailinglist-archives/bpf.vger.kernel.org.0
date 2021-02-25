Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B27325933
	for <lists+bpf@lfdr.de>; Thu, 25 Feb 2021 23:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbhBYWCe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Feb 2021 17:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234220AbhBYWCY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Feb 2021 17:02:24 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83841C06174A
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 14:01:42 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id w36so10889643lfu.4
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 14:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ur8sN5+Y5H9SCWGU5NZIURHn6ZhqbLISS0b8Lewbocg=;
        b=jDKoFAdirwUrODfD4X0N5lZppQRi6oqIdQA4IV5kN3cmpmzYhUJP79peY8/GPVaHvA
         4+56CIRrLHf6bOfC6O1cwgc375EYpYYrVZIBbxRyrEMT5ebEeVjJzbN+S22RiZ2zRh1x
         UWVfV6pJ/q0nvhanBXSVy2GLoxCA4dLskJb2cLUNMWnvZsrtgBsmLOF2w/N3qoGlE5/I
         eSCSTzx6JxINV6Ae5S2yKWZJ2Eui0OPmEc04guHjq2wCl/atnvwdKVCcTHJy25p5mIlt
         CKZb4j8x5rQQyS4/NqdTShv4GItKxLDdThqsoE/HIk50XLx958kMEz8Tl/f8d94F3LqQ
         c9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ur8sN5+Y5H9SCWGU5NZIURHn6ZhqbLISS0b8Lewbocg=;
        b=jr/r3qgSCFZA97NSwdUPaFr5mflyR/eULdDxrqLfMvq+jMqFcAd5ukTpwSCms1MfwA
         9ENgyIAHpjEAxWz5B2MLPlIRQiDjXrnnLWDLEMka467VYqnCG3db+O8hIbggIh0VTg0P
         jtienamPyvhxi42wytd6WO7ccAvQAv45kzKGhAQWrk//3Y/WRlwRf+hXEZifcFPCm9WM
         JCVq7hP1RTpJa6sSgY7XZgrr/5w+WKxynIaRBrJ/bXucTJj8ciydL0hK9hemiL4CHFit
         09zaB70CrTZi9kRoeMkpvrEDuvPCV8BmvWERZyICGAWKkF/oV34L/EvhXTmEwEKTywzK
         uijg==
X-Gm-Message-State: AOAM530Oc4oD0kicHcBj3yXDPFSnR1jrYcziYUtdPSMtmQNYPiyXHwif
        AvbudNxOo5iLo4esbXHAO1xgvrGUsTAb9lyaJA0=
X-Google-Smtp-Source: ABdhPJyR9IfKSbVeAMZ4NMCYQzP78/p2RlDXiLqerKnpq+yk93BWaSmL77VX+ybh/OhblFEi42TBTtFhMyTx8BsgtVo=
X-Received: by 2002:a05:6512:2254:: with SMTP id i20mr2996686lfu.534.1614290501070;
 Thu, 25 Feb 2021 14:01:41 -0800 (PST)
MIME-Version: 1.0
References: <20210225073309.4119708-1-yhs@fb.com> <20210225073309.4119838-1-yhs@fb.com>
 <CAEf4BzYfN6Rbp+Xph3Z4=YpUfikHrgXBSrhXvYRzg7SyqpUcBg@mail.gmail.com>
In-Reply-To: <CAEf4BzYfN6Rbp+Xph3Z4=YpUfikHrgXBSrhXvYRzg7SyqpUcBg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 25 Feb 2021 14:01:29 -0800
Message-ID: <CAADnVQ+Uv1zi6+WNmHHMWTbiMn3__O2_8NRQV8aVU-FyM58PEw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 01/11] bpf: factor out visit_func_call_insn()
 in check_cfg()
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 25, 2021 at 1:54 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Feb 25, 2021 at 1:35 AM Yonghong Song <yhs@fb.com> wrote:
> >
> > During verifier check_cfg(), all instructions are
> > visited to ensure verifier can handle program control flows.
> > This patch factored out function visit_func_call_insn()
> > so it can be reused in later patch to visit callback function
> > calls. There is no functionality change for this patch.
> >
> > Signed-off-by: Yonghong Song <yhs@fb.com>
> > ---
> >  kernel/bpf/verifier.c | 35 +++++++++++++++++++++++------------
> >  1 file changed, 23 insertions(+), 12 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 1dda9d81f12c..9cb182e91162 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -8592,6 +8592,27 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env,
> >         return DONE_EXPLORING;
> >  }
> >
> > +static int visit_func_call_insn(int t, int insn_cnt,
> > +                               struct bpf_insn *insns,
>
> both insns and insn_cnt seem to be derivatives of env
> (env->prog->insnsi and env->prog->len), so it shouldn't be necessary
> to pass them in.

Not really. 'env' is there only for logging.
When we do a cleanup later we can replace it with log.
So pls keep insns and len.
It's not the only place that will benefit from s/env/log/.
