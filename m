Return-Path: <bpf+bounces-9783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 957F779D9D4
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 21:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E961281A27
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 19:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0010CAD50;
	Tue, 12 Sep 2023 19:57:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAC633D2
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 19:57:57 +0000 (UTC)
Received: from out-219.mta1.migadu.com (out-219.mta1.migadu.com [95.215.58.219])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143E91B2
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 12:57:57 -0700 (PDT)
Message-ID: <8b272d63-5dd7-13bd-7691-d061895fdbe1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1694548674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I8O2Nscd47hkRROGFh80UDSBByNjzYNNhSIVk3mOdSU=;
	b=NPxpvABMTXZYABRLcfwsASp2EUogpYid24GMsBkMb4WxznmknrD7VDDnNsXtQJQ5Q6VCsF
	Qxebw4mdfJHig5Lgf4B1sjGQnCxeT9GAtgzBDAe6xlNX8y3vhYR3hGJQt7Yp8xyyxJXJpa
	AkluNAMk/4AEKPJCebJ0wgc7mxxc0zk=
Date: Tue, 12 Sep 2023 12:57:47 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/6] bpf: Introduce css_task open-coded
 iterator kfuncs
Content-Language: en-US
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20230912070149.969939-1-zhouchuyi@bytedance.com>
 <20230912070149.969939-3-zhouchuyi@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230912070149.969939-3-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/12/23 12:01 AM, Chuyi Zhou wrote:
> +__bpf_kfunc int bpf_iter_css_task_new(struct bpf_iter_css_task *it,
> +		struct cgroup_subsys_state *css, unsigned int flags)
> +{
> +	struct bpf_iter_css_task_kern *kit = (void *)it;
> +
> +	BUILD_BUG_ON(sizeof(struct bpf_iter_css_task_kern) != sizeof(struct bpf_iter_css_task));
> +	BUILD_BUG_ON(__alignof__(struct bpf_iter_css_task_kern) !=
> +					__alignof__(struct bpf_iter_css_task));
> +
> +	switch (flags) {
> +	case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
> +	case CSS_TASK_ITER_PROCS:
> +	case 0:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	kit->css_it = kzalloc(sizeof(struct css_task_iter), GFP_KERNEL);
> +	if (!kit->css_it)
> +		return -ENOMEM;
> +	css_task_iter_start(css, flags, kit->css_it);
> +	return 0;
> +}
> +

> +static bool check_css_task_iter_allowlist(struct bpf_verifier_env *env)
> +{
> +	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
> +
> +	switch (prog_type) {
> +	case BPF_PROG_TYPE_LSM:

This will allow the non-sleepable lsm prog to call bpf_iter_css_task_new. The 
above kzalloc(GFP_KERNEL) in bpf_iter_css_task_new should trigger a lockdep 
error in the lsm selftest in patch 6.

> +		return true;
> +	case BPF_TRACE_ITER:
> +		return env->prog->aux->sleepable;
> +	default:
> +		return false;
> +	}
> +}


