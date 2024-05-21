Return-Path: <bpf+bounces-30096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E821B8CAB70
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 12:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A78D9280E38
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 10:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A46E6BB20;
	Tue, 21 May 2024 10:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTZMt8AH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC9B55E74
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 10:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716285893; cv=none; b=c5/y23cbDqLSh0crO5083FUsFidq5ZrIsJwS/sPgRRKENwRAS4Vfz/ROeGRh3+94CdWK7oG3T+ee5R97n0BL0ByKQ+FTRTgkcIgZ5qkJJI+/1gf3MQ1m4tm0ml4ac/cYEr9WRhrVDK6FTARoc1Nqmy7LVNvwjlN4MVZD88vn2nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716285893; c=relaxed/simple;
	bh=op84OqVhdThNISxJsFAvWgEzF4mH0Fee3anqiQR+ItY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVHgkcK3ykuiMnUsAfHb7ali3BcH4MtKn6V0jMf59VEghuDL02HkHvVQE1PM0ZLMBdIgQKgtpIYQRi6hnigZN2p7Ulj2MZVwoV2ImqiipZeOlBo7LolRAe+oEQy8+SjMbFwcyCfGj7i4/lJxUhjJOVzHc/wvUoDqvira6MiEir4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTZMt8AH; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a599a298990so890437866b.2
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 03:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716285890; x=1716890690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8scWBp06zcLZKhFHMItyybHh/y0aB8jnyat0N+1luCI=;
        b=OTZMt8AH8z2d6J7oDdY5DWPYVTaltWWxJds63sc+TvxiytPvMw5KtPqNucVaKgkuJC
         wv4aVRlXeB+9hnyCVNXskjgPAwXidKOnamlTGxO50woUkAW2OqaVoGOZRlXaHXnzozT2
         SIlOLYuHNf7KakV/5zZMVE40fd/h0uF7MI3NRt9ySvxUmDFyCTy4ijtZ/GLPftQUguln
         Pz5rkxsDZFSVUq3Jq/3zg8x8mwEAbGakrH88FK9KKWfizH5mWMABNN8IaAkwv5IkgkKe
         1R+ICAN9WR35g35Lrqf9wj48b2y3yDTe3qr2iP4HQLDqQl5RnSVgqD1TjiVOq+Pwsl58
         OOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716285890; x=1716890690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8scWBp06zcLZKhFHMItyybHh/y0aB8jnyat0N+1luCI=;
        b=pw55xRynZAaoPHXy0TzBcAyBxa5uqGe8rY3D5hEMA49MPlr5ALwHfmqN2sdHnNanVu
         KsgdMi/bvyzX0OWPKDeVZIGUNPuJkQigUnLoqQPE0z2uOh7M4QfBrUQtz5bQ9icvd9uo
         FUM+DwDxNkxK20tKTE8BEgTK9t6CBTUx1MiPH1IpP2ISD2HXCUzTpCx5Jr6YrrqJi1ng
         l0DL4U1H1IpZ/scLKD+/2/Vk6v1hKDY0mn1R/Qs49gn6vB/j59iQBR/ZnIAzXwIqWj3c
         b/2r/Khrvq1BUrbWLMLfMiDYGSV46M5Ds+LpGf1FF67H5D0REm4J60Bqb8O9DEMHlQn0
         ZJsQ==
X-Gm-Message-State: AOJu0Ywxm44Tef+7CEz+e1CPe+AEO5GmXnp4l6k38aA6LZ0HkXfOUcI2
	u+UCKpDPuS/t1n3CKN5irXT0wDgM13zHqlkS72iA2K8f57btNEcD
X-Google-Smtp-Source: AGHT+IH83RK2/Ac4+LqbwSF7hYS9TOsmuq1LEipzrdw5ZagG8+gI84nLKeEFu1/H1AuRZb7XMH2rAA==
X-Received: by 2002:a17:906:d7a5:b0:a5a:88ac:fbbe with SMTP id a640c23a62f3a-a5a88acfc17mr1424409266b.46.1716285889701;
        Tue, 21 May 2024 03:04:49 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01451sm1612030066b.149.2024.05.21.03.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 03:04:49 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 21 May 2024 12:04:47 +0200
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf 1/5] bpf: fix multi-uprobe PID filtering logic
Message-ID: <ZkxxvxwYWcFYI_fA@krava>
References: <20240520234720.1748918-1-andrii@kernel.org>
 <20240520234720.1748918-2-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520234720.1748918-2-andrii@kernel.org>

On Mon, May 20, 2024 at 04:47:16PM -0700, Andrii Nakryiko wrote:
> Current implementation of PID filtering logic for multi-uprobes in
> uprobe_prog_run() is filtering down to exact *thread*, while the intent
> for PID filtering it to filter by *process* instead. The check in
> uprobe_prog_run() also differs from the analogous one in
> uprobe_multi_link_filter() for some reason. The latter is correct,
> checking task->mm, not the task itself.
> 
> Fix the check in uprobe_prog_run() to perform the same task->mm check.
> 
> While doing this, we also update get_pid_task() use to use PIDTYPE_TGID
> type of lookup, given the intent is to get a representative task of an
> entire process. This doesn't change behavior, but seems more logical. It
> would hold task group leader task now, not any random thread task.
> 
> Last but not least, given multi-uprobe support is half-broken due to
> this PID filtering logic (depending on whether PID filtering is
> important or not), we need to make it easy for user space consumers
> (including libbpf) to easily detect whether PID filtering logic was
> already fixed.
> 
> We do it here by adding an early check on passed pid parameter. If it's
> negative (and so has no chance of being a valid PID), we return -EINVAL.
> Previous behavior would eventually return -ESRCH ("No process found"),
> given there can't be any process with negative PID. This subtle change
> won't make any practical change in behavior, but will allow applications
> to detect PID filtering fixes easily. Libbpf fixes take advantage of
> this in the next patch.
> 
> Fixes: b733eeade420 ("bpf: Add pid filter support for uprobe_multi link")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/trace/bpf_trace.c                                  | 8 ++++----
>  .../testing/selftests/bpf/prog_tests/uprobe_multi_test.c  | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index f5154c051d2c..1baaeb9ca205 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3295,7 +3295,7 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
>  	struct bpf_run_ctx *old_run_ctx;
>  	int err = 0;
>  
> -	if (link->task && current != link->task)
> +	if (link->task && current->mm != link->task->mm)

argh.. I guess we don't use filtering or usdt ATM, so we did not catch
this, thanks for fixing this

>  		return 0;
>  
>  	if (sleepable)
> @@ -3396,8 +3396,9 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
>  	upath = u64_to_user_ptr(attr->link_create.uprobe_multi.path);
>  	uoffsets = u64_to_user_ptr(attr->link_create.uprobe_multi.offsets);
>  	cnt = attr->link_create.uprobe_multi.cnt;
> +	pid = attr->link_create.uprobe_multi.pid;
>  
> -	if (!upath || !uoffsets || !cnt)
> +	if (!upath || !uoffsets || !cnt || pid < 0)
>  		return -EINVAL;
>  	if (cnt > MAX_UPROBE_MULTI_CNT)
>  		return -E2BIG;
> @@ -3421,10 +3422,9 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
>  		goto error_path_put;
>  	}
>  
> -	pid = attr->link_create.uprobe_multi.pid;
>  	if (pid) {
>  		rcu_read_lock();
> -		task = get_pid_task(find_vpid(pid), PIDTYPE_PID);
> +		task = get_pid_task(find_vpid(pid), PIDTYPE_TGID);

agreed,

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

>  		rcu_read_unlock();
>  		if (!task) {
>  			err = -ESRCH;
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> index 8269cdee33ae..38fda42fd70f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> @@ -397,7 +397,7 @@ static void test_attach_api_fails(void)
>  	link_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &opts);
>  	if (!ASSERT_ERR(link_fd, "link_fd"))
>  		goto cleanup;
> -	ASSERT_EQ(link_fd, -ESRCH, "pid_is_wrong");
> +	ASSERT_EQ(link_fd, -EINVAL, "pid_is_wrong");
>  
>  cleanup:
>  	if (link_fd >= 0)
> -- 
> 2.43.0
> 
> 

