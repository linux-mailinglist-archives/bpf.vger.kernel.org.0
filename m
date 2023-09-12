Return-Path: <bpf+bounces-9775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5685279D757
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 19:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82CD5281F97
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 17:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312A75CBC;
	Tue, 12 Sep 2023 17:13:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046251C04
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 17:13:41 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539FD10E9;
	Tue, 12 Sep 2023 10:13:41 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68fb7074348so2451169b3a.2;
        Tue, 12 Sep 2023 10:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694538821; x=1695143621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LMMQ1lktwirbBPlReTdZp3GmRYCfelrN3dXTicMPj0s=;
        b=LbFx4X0rLL/DB4SgTDU/rbMAygGEmFMHHzIwnFOc9btvdpLaqo8rjJCOWCvAqSmwyG
         T75Ss7y9vDlug3fiLtfI9AnPgh4F8eIsuDSniDPVl+LUPDgyk5zAt2PFQdNc5MEXomC+
         0CEeYtY5wpGg3xmSp+LROHvurGl8W5+RHQ6jIYIH4315fL5lh2CIAp0JdQ7Ig8Cfita3
         meDvffsR2A6WCOyVMsLSa/Yl1ukN91sOourasrLqUKe41zeNe9BZ081xbVld9fU4WKST
         lMPNetGXeLYCm8/yFPeAgrc0/uvewxUpLj0o2+mCouYVusuii4YvJalFbuaLkCy8NQes
         /GiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694538821; x=1695143621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMMQ1lktwirbBPlReTdZp3GmRYCfelrN3dXTicMPj0s=;
        b=X6OnYjFjMKpCF07GH5GMAek3ZqDo4Ld2w9LyOs0njHwiwV7D66r03LjPyKRer7db9s
         H/O73FAvMKH7eeBodYAmWnA1rkXn+ImF4P8fdmAc0PKHTFe4hXz/ntJ16pE1kARalwjX
         AfAw3Wck3SxtohSvXON8ohueYTWBDXiNgXzrZQPJg9E6lq576q2/qb1l6ZP7miaxquci
         B1u17Cgz8H2Dm86wLs0AWeadNn/No8J/LRUbEJPNliRuT5XRnC5VwvPoF9eddQ29N8U8
         bgrOjEF8u/gd828oswgB+miHUPPEATHkrGC9+7Rh0bNeKHBFQ7g8iY3P5EgoFxCDeacR
         XDsA==
X-Gm-Message-State: AOJu0Yzn6OKyPPqsZakHWaZWja4lCsX3qgde2cNxg/a4+MHP5N6YsnlJ
	nvZWPM62Lm4eYdhouq8rHGxhCy51n2A=
X-Google-Smtp-Source: AGHT+IGhlpB7xfGQfHKtnQ5s2rpGE2S7nFJpBkE0d+VNESemwPKWUW493/tq+sZ9L78lTpG8hn95zQ==
X-Received: by 2002:a05:6a00:1891:b0:68f:b7f6:f1df with SMTP id x17-20020a056a00189100b0068fb7f6f1dfmr433037pfh.5.1694538820653;
        Tue, 12 Sep 2023 10:13:40 -0700 (PDT)
Received: from iphone-544e90d47a76.dhcp.thefacebook.com ([2620:10d:c090:500::4:eead])
        by smtp.gmail.com with ESMTPSA id q11-20020a056a0002ab00b0068fb59a16edsm5144020pfs.175.2023.09.12.10.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 10:13:40 -0700 (PDT)
Date: Tue, 12 Sep 2023 10:13:37 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@kernel.org, tj@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 2/6] bpf: Introduce css_task open-coded
 iterator kfuncs
Message-ID: <20230912171337.px445hxd76uxxnu6@iphone-544e90d47a76.dhcp.thefacebook.com>
References: <20230912070149.969939-1-zhouchuyi@bytedance.com>
 <20230912070149.969939-3-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912070149.969939-3-zhouchuyi@bytedance.com>

On Tue, Sep 12, 2023 at 03:01:45PM +0800, Chuyi Zhou wrote:
> This patch adds kfuncs bpf_iter_css_task_{new,next,destroy} which allow
> creation and manipulation of struct bpf_iter_css_task in open-coded
> iterator style. These kfuncs actually wrapps css_task_iter_{start,next,
> end}. BPF programs can use these kfuncs through bpf_for_each macro for
> iteration of all tasks under a css.
> 
> css_task_iter_*() would try to get the global spin-lock *css_set_lock*, so
> the bpf side has to be careful in where it allows to use this iter.
> Currently we only allow it in bpf_lsm and bpf iter-s.
> 
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---
>  include/uapi/linux/bpf.h       |  4 +++
>  kernel/bpf/helpers.c           |  3 +++
>  kernel/bpf/task_iter.c         | 48 ++++++++++++++++++++++++++++++++++
>  kernel/bpf/verifier.c          | 23 ++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  4 +++
>  tools/lib/bpf/bpf_helpers.h    |  7 +++++
>  6 files changed, 89 insertions(+)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 73b155e52204..de02c0971428 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7318,4 +7318,8 @@ struct bpf_iter_num {
>  	__u64 __opaque[1];
>  } __attribute__((aligned(8)));
>  
> +struct bpf_iter_css_task {
> +	__u64 __opaque[1];
> +} __attribute__((aligned(8)));
> +
>  #endif /* _UAPI__LINUX_BPF_H__ */
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index b0a9834f1051..d6a16becfbb9 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2504,6 +2504,9 @@ BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
>  BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
> +BTF_ID_FLAGS(func, bpf_iter_css_task_new, KF_ITER_NEW)

Looking at selftest:
struct cgroup_subsys_state *css = &cgrp->self;

realized that we're missing KF_TRUSTED_ARGS here.

> +BTF_ID_FLAGS(func, bpf_iter_css_task_next, KF_ITER_NEXT | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
>  BTF_ID_FLAGS(func, bpf_dynptr_adjust)
>  BTF_ID_FLAGS(func, bpf_dynptr_is_null)
>  BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 7473068ed313..d8539cc05ffd 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -803,6 +803,54 @@ const struct bpf_func_proto bpf_find_vma_proto = {
>  	.arg5_type	= ARG_ANYTHING,
>  };
>  
> +struct bpf_iter_css_task_kern {
> +	struct css_task_iter *css_it;
> +} __attribute__((aligned(8)));
> +
> +__bpf_kfunc int bpf_iter_css_task_new(struct bpf_iter_css_task *it,
> +		struct cgroup_subsys_state *css, unsigned int flags)

the verifier does a type check, but it's not strong enough.
We need KF_TRUSTED_ARGS to make sure the pointer is valid.
The BTF_TYPE_SAFE_RCU(struct cgroup) {
probably doesn't need to change, since '&cgrp->self' is not a pointer deref.
The verifier should understand that cgroup_subsys_state is also PTR_TRUSTED
just like 'cgrp' pointer.

Also please add negative tests in patch 6.
Like doing bpf_rcu_read_unlock() in the middle and check that the verifier
catches such mistake.

