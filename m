Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7482A615455
	for <lists+bpf@lfdr.de>; Tue,  1 Nov 2022 22:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiKAVgL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 17:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiKAVgJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 17:36:09 -0400
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928C11E725;
        Tue,  1 Nov 2022 14:36:05 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id c8so11230795qvn.10;
        Tue, 01 Nov 2022 14:36:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+zUiNbr2EYqE40Vv4a2S6JxTFQyRyoDbxpg/5rnhOg=;
        b=ZPKlDYcgUEFIb9zGoK5hCSLyeoBgAGAdlQswQKsgs8heSZKpFS7BHO/vNhc3yP9WtP
         geibT10dSEZbPw0MDVyENlW9l8NW5Q3kLfpC8uGZZkw0UoKmo+8crjMTde8LPe9w1k0n
         wBgdfVQZAc/KaEKOZF4ov70ylUpAryYMIX7pNRj1k49th1vb73dFepsgbSGUgmiTuhsO
         jKpjQBSHC0U2v/h/Zd7R0i4QAShwjnHa196XeOeSYI3iTwxaa73EzPLOlUgUnc3YfafJ
         aDlEgIGtoYrlsCV1WbOxYQRSfLI+g+Z9XUcfWb+/yi5eaFPbuCmv4H0vTEROPM8+puFO
         ej/w==
X-Gm-Message-State: ACrzQf06PKbRxCRLwWYHGbnFMiIih8o76fxacEsp3avsAX5BTcWib2Jg
        3jNgeltpC18QPh+y3RiHZY8=
X-Google-Smtp-Source: AMsMyM7dsAy+VVhJ5K6raJ46JLXkBt6zwzyJrteh5Ta0vDrfLmcgQL8Z91R+2yV/Qc3wHCXq1ufdIQ==
X-Received: by 2002:ad4:5c47:0:b0:4bc:f84:da8f with SMTP id a7-20020ad45c47000000b004bc0f84da8fmr5290198qva.73.1667338564118;
        Tue, 01 Nov 2022 14:36:04 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::987b])
        by smtp.gmail.com with ESMTPSA id h1-20020a05620a244100b006eeb3165554sm7413836qkn.19.2022.11.01.14.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 14:36:03 -0700 (PDT)
Date:   Tue, 1 Nov 2022 16:36:02 -0500
From:   David Vernet <void@manifault.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH bpf-next v6 1/3] bpf: Allow trusted pointers to be passed
 to KF_TRUSTED_ARGS kfuncs
Message-ID: <Y2GRQhsyQMNCOZMT@maniforge.dhcp.thefacebook.com>
References: <20221020222416.3415511-1-void@manifault.com>
 <20221020222416.3415511-2-void@manifault.com>
 <20221101000239.pbbmym4mbdbmnzjd@macbook-pro-4.dhcp.thefacebook.com>
 <Y2FhXC/s5GUkbr9P@maniforge.dhcp.thefacebook.com>
 <CAADnVQ+KZcFZdC=W_qZ3kam9yAjORtpN-9+Ptg_Whj-gRxCZNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQ+KZcFZdC=W_qZ3kam9yAjORtpN-9+Ptg_Whj-gRxCZNQ@mail.gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 01, 2022 at 01:22:39PM -0700, Alexei Starovoitov wrote:
> On Tue, Nov 1, 2022 at 11:11 AM David Vernet <void@manifault.com> wrote:
> >
> > > What kind of bpf prog will be able to pass 'struct nf_conn___init *' into these bpf_ct_* ?
> > > We've introduced / vs nf_conf specifically to express the relationship
> > > between allocated nf_conn and other nf_conn-s via different types.
> > > Why is this not enough?
> >
> > Kumar should have more context here (he originally suggested this in
> > [0]),
> 
> Quoting:
> "
> Unfortunately a side effect of this change is that now since
> PTR_TO_BTF_ID without ref_obj_id is considered trusted, the bpf_ct_*
> functions would begin working with tp_btf args.
> "
> I couldn't find any tracepoint that has nf_conn___init as an argument.
> The whole point of that new type was to return it to bpf prog,
> so the verifier type matches it when it's passed into bpf_ct_*
> in turn.
> So I don't see a need for a new OWNED flag still.
> If nf_conn___init is passed into tracepoint it's a bug and
> we gotta fix it.

Yep, this is what I'm seeing as well. I think you're right that
KF_OWNED_ARGS is just strictly unnecessary and that creating wrapper
types is the way to enable an ownership model like this.

> > but AFAICT you're correct that this should be sufficient. I added
> > a negative test case that correctly fails if a BPF program tries to call
> > these helpers with a struct nf_conn* rather than a struct
> > nf_conn__init*.
> >
> > [0]: https://lore.kernel.org/all/CAP01T77PTK+bD2mBrxJShKNPhEypT2+nSHcr3=uuJbrghv_wFg@mail.gmail.com/
> >
> > > I prefer to keep only one flag KF_TRUSTED_ARGS that kfunc-s need to use
> > > and eventually make all kfuncs KF_TRUSTED_ARGS by default and remove that flag.
> >
> > Yes, KF_TRUSTED_ARGS really should be the default. As Kumar describes in
> > [1], we'll have to figure out how to avoid trace progs with unsafe args
> > from calling these kfuncs. Maybe the right thing to do is allow-listing
> > rather than deny-listing, as you pointed out.
> >
> > [1]: https://lore.kernel.org/bpf/CAP01T77goGbF3GVithEuJ7yMQR9PxHNA9GXFODq_nfA66G=F9g@mail.gmail.com/
> 
> That is still the plan. more or less.
> 
> > > Separately...
> > > I think there was a plan to strengthen PTR_TO_BTF_ID and apply PTR_UNTRUSTED.
> >
> > That would be nice if we could do it. I assume that the issue is we're
> > breaking backwards compat if we do, so I'd be curious to hear what the
> > plan was if you're aware. The only plan that I've seen so far is what
> > Kumar spelled out above in [1] above.
> 
> Right. Backward compat with existing usage of PTR_TO_BTF_ID
> is the main issue.
> 
> >
> > > This PTR_WALKED looks like new thing.
> > > If we really need it PTR_TO_BTF_ID should be allowlisted instead of denylisted
> > > as PTR_WALKED is doing.
> > > I mean we can introduce PTR_TRUSTED and add this flag to return value
> > > of bpf_get_current_task_btf() and arguments of tracepoints.
> > > As soon as any ptr walking is done we can clear PTR_TRUSTED to keep
> > > backward compat behavior of PTR_TO_BTF_ID.
> > > PTR_WALKED is sort-of doing the same, but not conservative enough.
> > > Too many things produce PTR_TO_BTF_ID. Auditing it all is challenging.
> >
> > I very much prefer the idea of allowlisting instead of denylisting,
> > though I wish we'd taken that approach from the start rather than going
> > with PTR_UNTRUSTED. It feels wrong to have both PTR_UNTRUSTED and
> > PTR_TRUSTED as type modifiers, as the absence of PTR_UNTRUSTED should
> > (and currently does) imply PTR_TRUSTED.
> 
> I kind agree, but we gotta have both because of backward compat.
> We cannot change PTR_TO_BTF_ID as a whole right now.
> 
> Note PTR_TO_BTF_ID appears in kfuncs too.
> I'm proposing to use PTR_TO_BTF_ID | PTR_TRUSTED
> only in tracepoint args and as return value from
> certain helpers like bpf_get_current_task_btf().
> afaik it's all safe. There is no uaf here.
> uaf is for kfunc. Especially fexit.
> Those will stay PTR_TO_BTF_ID. Without PTR_TRUSTED.

Ok, this feels like the right approach to me. Unless I'm missing
something, modulo doing our due diligence and checking if there are any
existing kfuncs that are relying on different behavior, once this lands
I think we could maybe even make KF_TRUSTED_ARGS the default for all
kfuncs? That should probably be done in a separate patch set though.

> > If we're going to go with an allowlist approach, then I think we should
> > just get rid of PTR_UNTRUSTED altogether. Is that what you're
> > suggesting? Otherwise, if we don't get rid of PTR_UNTRUSTED, then
> > PTR_WALKED seems like a more natural type modifier addition.
> 
> Eventually either PTR_TRUSTED or PTR_UNTRUSTED will be removed.

In that case I'm fine with doing PTR_TRUSTED. Would ideally like to get
Kumar's input before doing it in v7 to avoid too much more churn.
