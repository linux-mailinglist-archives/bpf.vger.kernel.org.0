Return-Path: <bpf+bounces-3189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1EC73A95B
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 22:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D3AB1C2119D
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 20:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E624D21093;
	Thu, 22 Jun 2023 20:12:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7F820690
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 20:12:03 +0000 (UTC)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386CD1BD8
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 13:12:02 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-553a1f13d9fso4634006a12.1
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 13:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687464721; x=1690056721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nz9m/AVCYpJY3TUjuJI6d3jH2k5Z0Vv2asMMTB+tRqo=;
        b=oi54k3a6PzfK58BAyNrHNoPwClihk6T7cevgw1Gcc6MU1oyB8Ao5JE2dLVrFLYEbhh
         nVUZQyQzfBVdktztor5sTfV63ehHxzCzCeTwONEAlI/DqiNZdqT+x2WZOiq2DLE1cyV2
         szV4Hp4cvBcLQmzIAS4yWft+fJYD3NOdbYTdyLwAvEf5il6bC8HR7yTCzL8lqhD3p2IL
         s+7D/fjwv1dyv1UtVmhNttweEfV+o+4tigWgmVv3EpNyJY1WyZQVxRF8Vc/UmcRcmiZt
         xylTfs9lG0lK5pc7V6vVe0pNIOWq8wI/k7PcOQ+g6kV1FG8hG47O5+3WKu/rrNj8Bl18
         1Y/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687464721; x=1690056721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nz9m/AVCYpJY3TUjuJI6d3jH2k5Z0Vv2asMMTB+tRqo=;
        b=O6j4galrx+F7p7CHDvC4j6n+lkKCTYxnkBfInQ9Ok8a6rY+d4lrsdTmNW+dcAs5jyz
         QlK4pF8IiH3+dVktshYAXzkBZMMEokw1Jvit4tOgT1vMjw/paGlV2KTXOVpkxvZ4WGZO
         CMY8fDERf0WRI172ymu0zb2ySRTy/kfM4AK96u/gjAedAs/AP11CVT4ybEQ9Yf50EXh/
         wSfqjCnBq1yXAsEIreppFctJ1n5blWaw/tQeUiS7vT5Ic8p7RHwDAERM9wOedOgTT6ei
         Ho7O2+avPvsfDVaOkz67xAMPrULzKGJQLcNpRsak8xEVf1kwCllkM4nK1JfU/exN0mXx
         3kVg==
X-Gm-Message-State: AC+VfDztC+jka5HeWr3Yd29yHbRfFv0L8YzNmNYdmGVZI9ecRrD93OS2
	VZmg6XCNGLtIW4AqmSyy5oU5mEx0f8M=
X-Google-Smtp-Source: ACHHUZ6U58SRIJGUzjf1Qy/C0X9mb8tApFh03KaSuqJ5e81TVSsDXBjGvCnEMGHRKz40RxzxRrNqsA==
X-Received: by 2002:a17:902:9a0b:b0:1b0:663e:4b10 with SMTP id v11-20020a1709029a0b00b001b0663e4b10mr18174585plp.64.1687464721597;
        Thu, 22 Jun 2023 13:12:01 -0700 (PDT)
Received: from macbook-pro-8.dhcp.thefacebook.com ([2620:10d:c090:500::4:95b5])
        by smtp.gmail.com with ESMTPSA id y13-20020a1709027c8d00b001ac937171e4sm5706880pll.254.2023.06.22.13.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 13:12:01 -0700 (PDT)
Date: Thu, 22 Jun 2023 13:11:58 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Anton Protopopov <aspsk@isovalent.com>
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
Message-ID: <20230622201158.s56vbdas5rcilwbd@macbook-pro-8.dhcp.thefacebook.com>
References: <20230622095330.1023453-1-aspsk@isovalent.com>
 <20230622095330.1023453-2-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622095330.1023453-2-aspsk@isovalent.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 09:53:27AM +0000, Anton Protopopov wrote:
> Add a generic percpu stats for bpf_map elements insertions/deletions in order
> to keep track of both, the current (approximate) number of elements in a map
> and per-cpu statistics on update/delete operations.
> 
> To expose these stats a particular map implementation should initialize the
> counter and adjust it as needed using the 'bpf_map_*_elements_counter' helpers
> provided by this commit. The counter can be read by an iterator program.
> 
> A bpf_map_sum_elements_counter kfunc was added to simplify getting the sum of
> the per-cpu values. If a map doesn't implement the counter, then it will always
> return 0.
> 
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> ---
>  include/linux/bpf.h   | 30 +++++++++++++++++++++++++++
>  kernel/bpf/map_iter.c | 48 ++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 77 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index f58895830ada..20292a096188 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -275,6 +275,7 @@ struct bpf_map {
>  	} owner;
>  	bool bypass_spec_v1;
>  	bool frozen; /* write-once; write-protected by freeze_mutex */
> +	s64 __percpu *elements_count;
>  };
>  
>  static inline const char *btf_field_type_name(enum btf_field_type type)
> @@ -2040,6 +2041,35 @@ bpf_map_alloc_percpu(const struct bpf_map *map, size_t size, size_t align,
>  }
>  #endif
>  
> +static inline int
> +bpf_map_init_elements_counter(struct bpf_map *map)
> +{
> +	size_t size = sizeof(*map->elements_count), align = size;
> +	gfp_t flags = GFP_USER | __GFP_NOWARN;
> +
> +	map->elements_count = bpf_map_alloc_percpu(map, size, align, flags);
> +	if (!map->elements_count)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static inline void
> +bpf_map_free_elements_counter(struct bpf_map *map)
> +{
> +	free_percpu(map->elements_count);
> +}
> +
> +static inline void bpf_map_inc_elements_counter(struct bpf_map *map)

bpf_map_inc_elem_count() to match existing inc_elem_count() ?

> +{
> +	this_cpu_inc(*map->elements_count);
> +}
> +
> +static inline void bpf_map_dec_elements_counter(struct bpf_map *map)
> +{
> +	this_cpu_dec(*map->elements_count);
> +}
> +
>  extern int sysctl_unprivileged_bpf_disabled;
>  
>  static inline bool bpf_allow_ptr_leaks(void)
> diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
> index b0fa190b0979..26ca00dde962 100644
> --- a/kernel/bpf/map_iter.c
> +++ b/kernel/bpf/map_iter.c
> @@ -93,7 +93,7 @@ static struct bpf_iter_reg bpf_map_reg_info = {
>  	.ctx_arg_info_size	= 1,
>  	.ctx_arg_info		= {
>  		{ offsetof(struct bpf_iter__bpf_map, map),
> -		  PTR_TO_BTF_ID_OR_NULL },
> +		  PTR_TO_BTF_ID_OR_NULL | PTR_TRUSTED },

this and below should be in separate patch.

>  	},
>  	.seq_info		= &bpf_map_seq_info,
>  };
> @@ -193,3 +193,49 @@ static int __init bpf_map_iter_init(void)
>  }
>  
>  late_initcall(bpf_map_iter_init);
> +
> +__diag_push();
> +__diag_ignore_all("-Wmissing-prototypes",
> +		  "Global functions as their definitions will be in vmlinux BTF");
> +
> +__bpf_kfunc s64 bpf_map_sum_elements_counter(struct bpf_map *map)
> +{
> +	s64 *pcount;
> +	s64 ret = 0;
> +	int cpu;
> +
> +	if (!map || !map->elements_count)
> +		return 0;
> +
> +	for_each_possible_cpu(cpu) {
> +		pcount = per_cpu_ptr(map->elements_count, cpu);
> +		ret += READ_ONCE(*pcount);
> +	}
> +	return ret;
> +}
> +
> +__diag_pop();
> +
> +BTF_SET8_START(bpf_map_iter_kfunc_ids)
> +BTF_ID_FLAGS(func, bpf_map_sum_elements_counter, KF_TRUSTED_ARGS)
> +BTF_SET8_END(bpf_map_iter_kfunc_ids)
> +
> +static int tracing_iter_filter(const struct bpf_prog *prog, u32 kfunc_id)
> +{
> +	if (btf_id_set8_contains(&bpf_map_iter_kfunc_ids, kfunc_id) &&
> +	    prog->expected_attach_type != BPF_TRACE_ITER)

why restrict to trace_iter?

> +		return -EACCES;
> +	return 0;
> +}
> +
> +static const struct btf_kfunc_id_set bpf_map_iter_kfunc_set = {
> +	.owner = THIS_MODULE,
> +	.set   = &bpf_map_iter_kfunc_ids,
> +	.filter = tracing_iter_filter,
> +};
> +
> +static int init_subsystem(void)
> +{
> +	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_map_iter_kfunc_set);
> +}
> +late_initcall(init_subsystem);
> -- 
> 2.34.1
> 

