Return-Path: <bpf+bounces-3261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CC873B801
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 14:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A54771C21253
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 12:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E9C7499;
	Fri, 23 Jun 2023 12:46:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748F18F4D
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 12:46:51 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671281FF7
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 05:46:07 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-311099fac92so721440f8f.0
        for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 05:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1687524364; x=1690116364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nws9t6DWS4itJILSC6AFa25TyDnEnKfRyzn9fkk6/wo=;
        b=Q8SHPXtfpT+Eg6nG+Th5GjvKt+k/UHwcv9AqpE6+aAbrFJUQs1bchIrBRq9mOajEUm
         z6cWksq2nOLB7O002JNNa0kapw35/yqp0YRy6+oRy9w7Emx6UjSlWdf6UYOi2Ca60QWI
         2rVgo9BFeByh1ODjaqwT/U6yJVgwNmyY1WOQ3lk1FA5qAVO/yg9NYXXRrWzcxhb2FB6W
         q1ZynmSCoqH2T1k8OOuUiF7algovXtcVanLfHJRPawvQFPkmBo0QRKAMq069rNegfQ9u
         FFCKu7BLbvkQuLXzf7TaG/cmtQYfEjcZUhGhnCvMLkE3QD8v2HKW82IoseyT0sWRr8m/
         y4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687524364; x=1690116364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nws9t6DWS4itJILSC6AFa25TyDnEnKfRyzn9fkk6/wo=;
        b=K6+nopCb7wCW17iM7EKbTNeWHbpsClQ3WyrTeFaE3Q7rT5dhbeejWPKfzQUde9LM/a
         CHs8kiq2kKiSQuW9p4GgCYochxTPtlgB2cCFmGBA2fiIEueuqrlRf9PUTHsjNnoFX8ou
         XeV/aI6KLIpWh8ZZS+3VKdqTlRKsVQj/TQyZUjV6qCSzjd8pNz9QkMBk/WNJyjwzYTuv
         77u8guTVw7ClwzSW4oxn2JDMXTc77EzyxluKTH9gqfc5I6XPL2ggGbAGgSCBxXNP8f/X
         sQ7TzJNylblW8rELhhUmanVRgCt+iM6uTjnMSweucBpg2UTi8v4v1pYX3ORb7KsPsyiP
         ddCw==
X-Gm-Message-State: AC+VfDyKl6huoq9gPboiHE1iriWIsluu1/rBid549qL/qETAUtRSaDDo
	yNP9uBJwX/2rArKIuIRtmQG4JQ==
X-Google-Smtp-Source: ACHHUZ5RVg8j506Jw75i6PaY+S4mPvOY8Ves/vgOHJc4JxjBhvngX6fpEV3HspEEeJ3kZxxdYZahyQ==
X-Received: by 2002:a5d:5960:0:b0:30e:19a8:4b0a with SMTP id e32-20020a5d5960000000b0030e19a84b0amr19023401wri.2.1687524364410;
        Fri, 23 Jun 2023 05:46:04 -0700 (PDT)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id u2-20020a5d5142000000b003113dc327fbsm9495287wrt.22.2023.06.23.05.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 05:46:03 -0700 (PDT)
Date: Fri, 23 Jun 2023 12:47:06 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org
Subject: Re: [RFC v2 PATCH bpf-next 1/4] bpf: add percpu stats for bpf_map
 elements insertions/deletions
Message-ID: <ZJWUShe0R87HDmWA@zh-lab-node-5>
References: <20230622095330.1023453-1-aspsk@isovalent.com>
 <20230622095330.1023453-2-aspsk@isovalent.com>
 <20230622201158.s56vbdas5rcilwbd@macbook-pro-8.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622201158.s56vbdas5rcilwbd@macbook-pro-8.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 01:11:58PM -0700, Alexei Starovoitov wrote:
> On Thu, Jun 22, 2023 at 09:53:27AM +0000, Anton Protopopov wrote:
> > Add a generic percpu stats for bpf_map elements insertions/deletions in order
> > to keep track of both, the current (approximate) number of elements in a map
> > and per-cpu statistics on update/delete operations.
> > 
> > To expose these stats a particular map implementation should initialize the
> > counter and adjust it as needed using the 'bpf_map_*_elements_counter' helpers
> > provided by this commit. The counter can be read by an iterator program.
> > 
> > A bpf_map_sum_elements_counter kfunc was added to simplify getting the sum of
> > the per-cpu values. If a map doesn't implement the counter, then it will always
> > return 0.
> > 
> > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > ---
> >  include/linux/bpf.h   | 30 +++++++++++++++++++++++++++
> >  kernel/bpf/map_iter.c | 48 ++++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 77 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index f58895830ada..20292a096188 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -275,6 +275,7 @@ struct bpf_map {
> >  	} owner;
> >  	bool bypass_spec_v1;
> >  	bool frozen; /* write-once; write-protected by freeze_mutex */
> > +	s64 __percpu *elements_count;
> >  };
> >  
> >  static inline const char *btf_field_type_name(enum btf_field_type type)
> > @@ -2040,6 +2041,35 @@ bpf_map_alloc_percpu(const struct bpf_map *map, size_t size, size_t align,
> >  }
> >  #endif
> >  
> > +static inline int
> > +bpf_map_init_elements_counter(struct bpf_map *map)
> > +{
> > +	size_t size = sizeof(*map->elements_count), align = size;
> > +	gfp_t flags = GFP_USER | __GFP_NOWARN;
> > +
> > +	map->elements_count = bpf_map_alloc_percpu(map, size, align, flags);
> > +	if (!map->elements_count)
> > +		return -ENOMEM;
> > +
> > +	return 0;
> > +}
> > +
> > +static inline void
> > +bpf_map_free_elements_counter(struct bpf_map *map)
> > +{
> > +	free_percpu(map->elements_count);
> > +}
> > +
> > +static inline void bpf_map_inc_elements_counter(struct bpf_map *map)
> 
> bpf_map_inc_elem_count() to match existing inc_elem_count() ?
> 
> > +{
> > +	this_cpu_inc(*map->elements_count);
> > +}
> > +
> > +static inline void bpf_map_dec_elements_counter(struct bpf_map *map)
> > +{
> > +	this_cpu_dec(*map->elements_count);
> > +}
> > +
> >  extern int sysctl_unprivileged_bpf_disabled;
> >  
> >  static inline bool bpf_allow_ptr_leaks(void)
> > diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
> > index b0fa190b0979..26ca00dde962 100644
> > --- a/kernel/bpf/map_iter.c
> > +++ b/kernel/bpf/map_iter.c
> > @@ -93,7 +93,7 @@ static struct bpf_iter_reg bpf_map_reg_info = {
> >  	.ctx_arg_info_size	= 1,
> >  	.ctx_arg_info		= {
> >  		{ offsetof(struct bpf_iter__bpf_map, map),
> > -		  PTR_TO_BTF_ID_OR_NULL },
> > +		  PTR_TO_BTF_ID_OR_NULL | PTR_TRUSTED },
> 
> this and below should be in separate patch.
> 
> >  	},
> >  	.seq_info		= &bpf_map_seq_info,
> >  };
> > @@ -193,3 +193,49 @@ static int __init bpf_map_iter_init(void)
> >  }
> >  
> >  late_initcall(bpf_map_iter_init);
> > +
> > +__diag_push();
> > +__diag_ignore_all("-Wmissing-prototypes",
> > +		  "Global functions as their definitions will be in vmlinux BTF");
> > +
> > +__bpf_kfunc s64 bpf_map_sum_elements_counter(struct bpf_map *map)
> > +{
> > +	s64 *pcount;
> > +	s64 ret = 0;
> > +	int cpu;
> > +
> > +	if (!map || !map->elements_count)
> > +		return 0;
> > +
> > +	for_each_possible_cpu(cpu) {
> > +		pcount = per_cpu_ptr(map->elements_count, cpu);
> > +		ret += READ_ONCE(*pcount);
> > +	}
> > +	return ret;
> > +}
> > +
> > +__diag_pop();
> > +
> > +BTF_SET8_START(bpf_map_iter_kfunc_ids)
> > +BTF_ID_FLAGS(func, bpf_map_sum_elements_counter, KF_TRUSTED_ARGS)
> > +BTF_SET8_END(bpf_map_iter_kfunc_ids)
> > +
> > +static int tracing_iter_filter(const struct bpf_prog *prog, u32 kfunc_id)
> > +{
> > +	if (btf_id_set8_contains(&bpf_map_iter_kfunc_ids, kfunc_id) &&
> > +	    prog->expected_attach_type != BPF_TRACE_ITER)
> 
> why restrict to trace_iter?

Thanks, I will remove it.

All your other comments in this series make sense as well, will address them.

> > +		return -EACCES;
> > +	return 0;
> > +}
> > +
> > +static const struct btf_kfunc_id_set bpf_map_iter_kfunc_set = {
> > +	.owner = THIS_MODULE,
> > +	.set   = &bpf_map_iter_kfunc_ids,
> > +	.filter = tracing_iter_filter,
> > +};
> > +
> > +static int init_subsystem(void)
> > +{
> > +	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_map_iter_kfunc_set);
> > +}
> > +late_initcall(init_subsystem);
> > -- 
> > 2.34.1
> > 

