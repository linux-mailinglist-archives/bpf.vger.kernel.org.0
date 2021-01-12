Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83AA92F3383
	for <lists+bpf@lfdr.de>; Tue, 12 Jan 2021 16:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387818AbhALPCR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 10:02:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:33718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727219AbhALPCQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jan 2021 10:02:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C50623133
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 15:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610463695;
        bh=Z1rbMQMt/ZBnWtsqUtXo+X1vs3VvV7P3JPZmshyA4oM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Jgguhtk6SrFGxFmQgQs8ReYG6RT7b74Ai1SkhGaj6c/QJFulX3LVTkGuYDl5B4k5w
         xU9sJBhPvK6H4+1hiUpoBkuuTNgQgY3/VHyHXeZkI0PiBU3kaIPRflE6QfnHIG9IFl
         AIaYUND2EZFD+JslVQz5JOsaDNE+Xgab9kmKcBsAEkpdkyVrDiJxm9g0guwJBSAeUm
         pgdndlA23lvQBkfJ++LbhPPQtOVFbJ35/tztzwOJnvuzISenNUBY2TsWFtmyfdNxyn
         RTWsuV6cbhX5Pwgr7KPN36bF2DMAwTpAN6q4WwW67E4qL/T8hOQOEDhlVMB2cVnkWK
         YvVnoerlGDttA==
Received: by mail-lf1-f49.google.com with SMTP id o17so3830450lfg.4
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 07:01:35 -0800 (PST)
X-Gm-Message-State: AOAM5339c+MfEjAOk1zkjHJasFPrLStw/wB1+xT+OLu9ocWlCEtYM2jo
        eJona73tbSuOAgvjrma2f3jIDH62fyLg+Z6uMISVDA==
X-Google-Smtp-Source: ABdhPJzZ4NLevpRLkWnwSQB49m9wwhF09lnH6S37cnqrbOyWIWHGa0wNn2gCoe0+9BfL631exXRbfChV/pqcZKBZFEU=
X-Received: by 2002:a19:810:: with SMTP id 16mr2427834lfi.233.1610463693714;
 Tue, 12 Jan 2021 07:01:33 -0800 (PST)
MIME-Version: 1.0
References: <20210112091403.10458-1-gilad.reti@gmail.com> <CACYkzJ6DJ0NEm+qTBpMSJNFfgNHBFPZc=Ytj4w+4hY=Co4=0yg@mail.gmail.com>
 <CANaYP3EQhTQ_o6QF_JNffJqHmVWRw6wcc95u8XvDpm+pY8ER3Q@mail.gmail.com>
In-Reply-To: <CANaYP3EQhTQ_o6QF_JNffJqHmVWRw6wcc95u8XvDpm+pY8ER3Q@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 12 Jan 2021 16:01:23 +0100
X-Gmail-Original-Message-ID: <CACYkzJ7KLFKADCH2exaUmg7sPbUu+wxq2OTwUY6iE7cPUb5Z3Q@mail.gmail.com>
Message-ID: <CACYkzJ7KLFKADCH2exaUmg7sPbUu+wxq2OTwUY6iE7cPUb5Z3Q@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: support PTR_TO_MEM{,_OR_NULL} register spilling
To:     Gilad Reti <gilad.reti@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Networking <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 12, 2021 at 3:24 PM Gilad Reti <gilad.reti@gmail.com> wrote:
>
> On Tue, Jan 12, 2021 at 3:57 PM KP Singh <kpsingh@kernel.org> wrote:
> >
> > On Tue, Jan 12, 2021 at 10:14 AM Gilad Reti <gilad.reti@gmail.com> wrote:
> > >
> > > Add support for pointer to mem register spilling, to allow the verifier
> > > to track pointer to valid memory addresses. Such pointers are returned
> >
> > nit: pointers
>
> Thanks
>
> >
> > > for example by a successful call of the bpf_ringbuf_reserve helper.
> > >
> > > This patch was suggested as a solution by Yonghong Song.
> >
> > You can use the "Suggested-by:" tag for this.
>
> Thanks
>
> >
> > >
> > > The patch was partially contibuted by CyberArk Software, Inc.
> >
> > nit: typo *contributed
>
> Thanks. Should I submit a v2 of the patch to correct all of those?

I think it would be nice to do another revision
which also addresses the comments on the other patch.


>
> >
> > Also, I was wondering if "partially" here means someone collaborated with you
> > on the patch? And, in that case:
> >
> > "Co-developed-by:" would be a better tag here.
>
> No, I did it alone. I mentioned CyberArk since I work there and did some of the
> coding during my daily work, so they deserve credit.
>
> >
> > Acked-by: KP Singh <kpsingh@kernel.org>
> >
> >
> > >
> > > Fixes: 457f44363a88 ("bpf: Implement BPF ring buffer and verifier
> > > support for it")
> > > Signed-off-by: Gilad Reti <gilad.reti@gmail.com>
> > > ---
> > >  kernel/bpf/verifier.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 17270b8404f1..36af69fac591 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -2217,6 +2217,8 @@ static bool is_spillable_regtype(enum bpf_reg_type type)
> > >         case PTR_TO_RDWR_BUF:
> > >         case PTR_TO_RDWR_BUF_OR_NULL:
> > >         case PTR_TO_PERCPU_BTF_ID:
> > > +       case PTR_TO_MEM:
> > > +       case PTR_TO_MEM_OR_NULL:
> > >                 return true;
> > >         default:
> > >                 return false;
> > > --
> > > 2.27.0
> > >
