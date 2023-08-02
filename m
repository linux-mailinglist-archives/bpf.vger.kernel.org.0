Return-Path: <bpf+bounces-6733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A1076D4AE
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 19:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 748B01C21061
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 17:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2FFDF40;
	Wed,  2 Aug 2023 17:06:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95169D525
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 17:06:23 +0000 (UTC)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4CA101
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 10:06:22 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7658752ce2fso23785a.1
        for <bpf@vger.kernel.org>; Wed, 02 Aug 2023 10:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690995981; x=1691600781;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RWKs0b7vWA1TEGeU1E0LCC2PQi0tBlvKn/XNCjDXUCQ=;
        b=IMlX2gun2wPfrKA6F6WsOu3PdCu3z2tBCN/4SEO9TwV/ZbI1W9+rK30Uj9mFl+TvjW
         qY1xnXZ/polNIDWhK3vhXr2xz6Y9lhWTCWDsq2+POJZJ6+NU0UY3BwJXDM5bQSSWtm8L
         R4+isC08Pzw44ZsAh/27ImkAStTGljWNepAEGwkQz/kVqSEI6cPZg8ze6kvJGOeelKof
         vEq9x5fC+SZzqfRBtpfkVQkIjbEiZ39pwnjbbFDohIQsjkX9dNpoEQulmw0XYunVijtN
         vN5LwuGabgX09v6wiRh+yN0a4R+kahcixTJMKC5CAJCKkRe0PZmHfM9hbVDY+voNAJQc
         grPQ==
X-Gm-Message-State: ABy/qLYP6jAKsnelLKW5TjrAIWPHM+QqpgyIZGGI/EkHXo9A5JRZ+wr9
	z9PYAkvgRPPEs0e1oc0FFhw=
X-Google-Smtp-Source: APBJJlFY3SaAgqkaURQYH4jp2ZTxr56kjoUHHv+wlRI8ESRJNdKgwi1/zMIj70wWxEVh+vU8mQ5YGA==
X-Received: by 2002:a05:620a:298a:b0:768:4206:f662 with SMTP id r10-20020a05620a298a00b007684206f662mr20936909qkp.40.1690995981198;
        Wed, 02 Aug 2023 10:06:21 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:e145])
        by smtp.gmail.com with ESMTPSA id 9-20020a05620a078900b00767e2668536sm5173608qka.17.2023.08.02.10.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 10:06:20 -0700 (PDT)
Date: Wed, 2 Aug 2023 12:06:18 -0500
From: David Vernet <void@manifault.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [RFC PATCH bpf-next 0/3] bpf: Add new bpf helper bpf_for_each_cpu
Message-ID: <20230802170618.GE472124@maniforge>
References: <20230801142912.55078-1-laoar.shao@gmail.com>
 <3f56b3b3-9b71-f0d3-ace1-406a8eeb64c0@linux.dev>
 <CALOAHbAnyorNdYAp1FretQcqEp_j6mQ93ATwx02auLTYnL_0KQ@mail.gmail.com>
 <CAADnVQKwY+j6JrxJ4dc1M7yhkSf958ubSH=WB7dKmHt9Ac9gQQ@mail.gmail.com>
 <20230802032958.GB472124@maniforge>
 <CAADnVQJnv5mC2=s1sQ8YKNj6gZXyXHeuNyaBJjk3D90VrM0iBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJnv5mC2=s1sQ8YKNj6gZXyXHeuNyaBJjk3D90VrM0iBw@mail.gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 02, 2023 at 09:33:18AM -0700, Alexei Starovoitov wrote:
> On Tue, Aug 1, 2023 at 8:30 PM David Vernet <void@manifault.com> wrote:
> > I agree that this is the correct way to generalize this. The only thing
> > that we'll have to figure out is how to generalize treating const struct
> > cpumask * objects as kptrs. In sched_ext [0] we export
> > scx_bpf_get_idle_cpumask() and scx_bpf_get_idle_smtmask() kfuncs to
> > return trusted global cpumask kptrs that can then be "released" in
> > scx_bpf_put_idle_cpumask(). scx_bpf_put_idle_cpumask() is empty and
> > exists only to appease the verifier that the trusted cpumask kptrs
> > aren't being leaked and are having their references "dropped".
> 
> why is it KF_ACQUIRE ?
> I think it can just return a trusted pointer without acquire.

I don't think there's a way to do this yet without hard-coding the kfuncs as
special, right? That's why we do stuff like this:


11479                 } else if (meta.func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx]) {
11480                         mark_reg_known_zero(env, regs, BPF_REG_0);
11481                         regs[BPF_REG_0].type = PTR_TO_BTF_ID | PTR_TRUSTED;
11482                         regs[BPF_REG_0].btf = desc_btf;
11483                         regs[BPF_REG_0].btf_id = meta.ret_btf_id;

We could continue to do that, but I wonder if it would be useful to add
a kfunc flag that allowed a kfunc to specify that? Something like
KF_ALWAYS_TRUSTED? In general though, yes, we can teach the verifier to
not require KF_ACQUIRE if we want. It's just that what we have now
doesn't really scale to the kernel for any global cpumask.

> > [0]: https://lore.kernel.org/all/20230711011412.100319-13-tj@kernel.org/
> >
> > I'd imagine that we have 2 ways forward if we want to enable progs to
> > fetch other global cpumasks with static lifetimes (e.g.
> > __cpu_possible_mask or nohz.idle_cpus_mask):
> >
> > 1. The most straightforward thing to do would be to add a new kfunc in
> >    kernel/bpf/cpumask.c that's a drop-in replacment for
> >    scx_bpf_put_idle_cpumask():
> >
> > void bpf_global_cpumask_drop(const struct cpumask *cpumask)
> > {}
> >
> > 2. Another would be to implement something resembling what Yonghong
> >    suggested in [1], where progs can link against global allocated kptrs
> >    like:
> >
> > const struct cpumask *__cpu_possible_mask __ksym;
> >
> > [1]: https://lore.kernel.org/all/3f56b3b3-9b71-f0d3-ace1-406a8eeb64c0@linux.dev/#t
> >
> > In my opinion (1) is more straightforward, (2) is a better UX.
> 
> 1 = adding few kfuncs.
> 2 = teaching pahole to emit certain global vars.
> 
> nm vmlinux|g -w D|g -v __SCK_|g -v __tracepoint_|wc -l
> 1998
> 
> imo BTF increase trade off is acceptable.

Agreed

