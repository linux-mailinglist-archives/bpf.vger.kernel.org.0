Return-Path: <bpf+bounces-65794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2E2B28821
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 00:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A7B9AA39ED
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 22:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A923D26E708;
	Fri, 15 Aug 2025 22:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OK1jBw/y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8A926B971
	for <bpf@vger.kernel.org>; Fri, 15 Aug 2025 22:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755295221; cv=none; b=oerNKdvIAgw3eJIsoWXW/P9Kc8BLI1bl1YcjP14FmwQqPczbdQdM6P8LDtXvNXhcLgFiBebYH9J5dwz0NRnBKriUKY1wQwaO42CmCNBVT7cZfAlgDT40fvG7MIley+5cIygxdjy+uAvUjG1HvNIlo5XkwxGbeBcX2STQ1MFi5cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755295221; c=relaxed/simple;
	bh=X3GA9ghE8XNWj9SSgyitkZlwJHthBAgCECt7UESXSXs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=at8BuznoqGLwx6GEF1nXwfY2/11MmL15IArqry2KfKdHtqC8cryLLPSUig9waJK7Xq3dWt6DPOVARH5o1AniqyeG0bRgkSt6jmVvigPpuD3+fgNLwhb+lGSVZOrCaxN73P46BxjDze3qBbs4sK8r5VeBywEBqyz72m3Q397QTxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OK1jBw/y; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb731ca8eso386618566b.0
        for <bpf@vger.kernel.org>; Fri, 15 Aug 2025 15:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755295218; x=1755900018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eJi8jYFjRcK61f7nSW1Xmdv8BYXKhJYS/wRZp+8KNwA=;
        b=OK1jBw/yBB81UF6pK0We4wong7IuoH2b8f4Z0++o31YJ4vSvSiVerzu4ZCuEqi8A4T
         eamU2AG55tkKjoDxyYo7w6j1NaK/rMo8YVDl7g6JNdt7/bI255dgcjSR+jRo/o+u6Pr7
         l2JFYzsO+pYcHYdt5vSVU7+FIO70LSUYDCdPNiWljNViKa+AvxEyCc1K1kg8xMVteWPE
         uLEv48EjfKgrzU7HjCULCSkOiPommPxefcxi93U4hUAa1hoharg1voeWCsz7YvkIHXla
         FGaIU3ANVHh3hJ9hMHboTlFaFM0fODfvlt/5xyMvO+don2mj8DufuU2Y2ihejsx6jlvO
         bSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755295218; x=1755900018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJi8jYFjRcK61f7nSW1Xmdv8BYXKhJYS/wRZp+8KNwA=;
        b=Ci6kGy46jeNmTmJiylJqZk3e071zvUcDrKqfpKRoFb3735ikuzt+At0hYp7uYDWMVa
         eNqVVeMRSCbOAjn439G7G0qsYMtK2G/RhQeT+MRNTfpGHd5zHjABtz/J0pHdU+ODr8Fh
         JMmPZeRxdSV3V7AHF6/qFgsvXbgR+Zg4fe5h8APL/uE+9LrL4KYc08rHaF/hJ97Vg0/H
         iPOkXjNoCuTrtY5cBjOPiJhyjbb1y4EjrAUzbR/8bgpRIzNlujAfDgrL+MozWvXpaNP0
         tfbJtzQt4l+WIcvhKSmx2RGa8qp0nqcevcWnTidc6EsCdLE73VnrtNDUamYHJbGygZ4E
         rt5A==
X-Gm-Message-State: AOJu0YykvIKFr2DmSbqAlSWMWYj6GgogKBJPACEQsczUWOoQFCadAWce
	VNzpBmTNHFyIFwj/+goqURQqAwYlA/VuKZyC31U039MAJNRhbbANHsXO
X-Gm-Gg: ASbGnctOWQvfp2zxWum7imngVOtZObFDNu7iELPeB4jOkCuMjewCHMuTI4+/YTSkhwm
	4yfC1o6ieK1PzP/m5syKFzEIMKQ1rM6656fIGnXKGZZk3LQeOVwYFy67JV9oQBa/CrlvRVuGpLm
	clPBt6rXUc1oXHmcUjIdf0H7i6LzXNd1dEaUXOxwKUccn9/mQNCnOI/DamXF/dZe80uldHLMFhL
	OJP+0ogR3g4WQQnlH26fwzDXGy1RNy0BI9tNTaMmsb2tvJpBj873dW2WoMmU0h2iM0Dgk5Qt3oY
	orxhf6RyuArxVIFLDoGTmmZp/hYFW6bl/wuDa1Dsis8j4a1RWpo5B7zUTIwn6l8+RsEWD+u5vG6
	NmCTF9HAVpQ==
X-Google-Smtp-Source: AGHT+IFZBqmls0WNn1o6yoVpvClSn716SMrZHnq8Th2amfe83EFA36p4zEJSachrboRob7yADbTyQA==
X-Received: by 2002:a17:907:6d06:b0:af6:361e:664d with SMTP id a640c23a62f3a-afcdc1f8b6bmr299202766b.7.1755295217663;
        Fri, 15 Aug 2025 15:00:17 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdce53dd5sm225225466b.5.2025.08.15.15.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 15:00:17 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 16 Aug 2025 00:00:15 +0200
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
	eddyz87@gmail.com, memxor@gmail.com,
	Mykyta Yatsenko <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next v2 3/4] bpf: task work scheduling kfuncs
Message-ID: <aJ-t7wxrQIB1oYyh@krava>
References: <20250815192156.272445-1-mykyta.yatsenko5@gmail.com>
 <20250815192156.272445-4-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815192156.272445-4-mykyta.yatsenko5@gmail.com>

On Fri, Aug 15, 2025 at 08:21:55PM +0100, Mykyta Yatsenko wrote:

SNIP

>  void bpf_task_work_cancel_and_free(void *val)
>  {
> +	struct bpf_task_work *tw = val;
> +	struct bpf_task_work_context *ctx;
> +	enum bpf_task_work_state state;
> +
> +	/* No need do rcu_read_lock as no other codepath can reset this pointer */
> +	ctx = unrcu_pointer(xchg((struct bpf_task_work_context __force __rcu **)&tw->ctx, NULL));
> +	if (!ctx)
> +		return;
> +	state = xchg(&ctx->state, BPF_TW_FREED);
> +
> +	switch (state) {
> +	case BPF_TW_SCHEDULED:
> +		/* If we can't cancel task work, rely on task work callback to free the context */
> +		if (!task_work_cancel_match(ctx->task, task_work_match, ctx))
> +			break;
> +		bpf_task_work_context_reset(ctx);
> +		fallthrough;
> +	case BPF_TW_STANDBY:
> +		call_rcu_tasks_trace(&ctx->rcu, bpf_task_work_context_free);
> +		break;
> +	/* In all below cases scheduling logic should detect context state change and cleanup */
> +	case BPF_TW_SCHEDULING:
> +	case BPF_TW_PENDING:
> +	case BPF_TW_RUNNING:
> +	default:
> +		break;
> +	}
>  }
>  
>  BTF_KFUNCS_START(generic_btf_ids)
> @@ -3769,6 +4017,8 @@ BTF_ID_FLAGS(func, bpf_rbtree_first, KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_rbtree_root, KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_rbtree_left, KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_rbtree_right, KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_TRUSTED_ARGS)

hi,
I'd like to use that with uprobes, could we add it to common_kfunc_set?
I tried it with uprobe and it seems to work nicely

thanks,
jirka


----
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 346ae8fd3ada..b5d52168ba77 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4129,6 +4129,8 @@ BTF_ID_FLAGS(func, bpf_strnstr);
 BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
 #endif
 BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {

