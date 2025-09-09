Return-Path: <bpf+bounces-67856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51378B4FB54
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 14:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AA963AEE68
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 12:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6201C3218D8;
	Tue,  9 Sep 2025 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjVPK1rL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283B41D799D;
	Tue,  9 Sep 2025 12:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757421319; cv=none; b=iXQAunVdyz0Nf4+i6UECPzTgNzHq7vgc/dOm21IqU49EUNu5KSf9TvuHJNRz7b2ECGBE6qIv0CB3dlSYS0/YRhCaOTna5sO2H1PfMJxf6yLm2A4JFJ3PLBEjouabMevJjB02pdv3BcQloUIetPksUltvO3GS2Yec5gxzgwLnSeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757421319; c=relaxed/simple;
	bh=JJD95+Z5no6qhT2jB92j3jyCPQaXgs7Rkz5+py1Fl1k=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuHEozNegnnApb/vki01qxhPsVSAlKND1NuJ4aebifJoEZdXsHBsf/LamKSXrB2dsx9AU/Ov5x0ZL50lxCwotQ9gq9EBzWzh7FezlMc9T6U1EVadkbqoNd0OZ87nwkXtlxWPs85rmhVmsoSL0NIjeIYMI0wpzLrrBGbqBIbDL4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjVPK1rL; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b047f28a83dso935004266b.2;
        Tue, 09 Sep 2025 05:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757421316; x=1758026116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wXOKswV41xbf6P5E2D8W+2nEakNyEZpXhJME2GvV78Q=;
        b=NjVPK1rL6vaMPkapD2A7cafGxJUBLH84uTDdw84jaNu9UvUptddvXfi+GfSJbj5y+l
         YHcu3Z5vA000PgdQpeBgk6yOWjTH49ayLAsHm3XMr+jTcDNJG1t7SEoAkwjyXSN0yrsw
         XBxt6TRVcfThIA62OgHK7KSLPzfLLD36cEIL6pT0qqhSq/JnPmPhMyzWUkBgVW0NTQD+
         Y5Ve+/Z66QzEoqUrDaBXuqlsggyHlMUrcAPk1i02ReeZLIdz6/xFQAQGgc9GQBhsg2vF
         oXnxSK8oIO7HcB+1mM16LbUFgRjoeH1mHBc157yXsuJi8t5zo1TXaHQJrDP6jxis8UrH
         ReEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757421316; x=1758026116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXOKswV41xbf6P5E2D8W+2nEakNyEZpXhJME2GvV78Q=;
        b=HTlajXoE4Q2rzvpVq4H+jLZJuOyawW9TyHb4yLpgUDNluW+4x55RcqIB77yzoBSPPw
         AFhSEpdGk2JcRQFNf8qh0w71HwwRkgjSYzgykQAImbO3ss/6IHYUHki+9HeTMjndYpKk
         Cdjnv/Qrrz6EMD4dGC8lU58qwu3Y+byHvMFDHm6DD7oUNUFZp6IT/xnbU+5x9M32ubwv
         I2cKCLvcoXH80pOemHiXN50LkvtOk/e95MwCvu0843lNFItexfQtAOcJJTVk/pBlinQA
         ++6RSz68NiQxZsJAZvhL6KWy4mDITbzBOSaR7YjkQwyA+4tkdIsAJUqe4GR3LzVL1Cpa
         KPkw==
X-Forwarded-Encrypted: i=1; AJvYcCX0ivzkgW1d4kCNKrb4zw5u4yvfDO14pFC9yp0vswCArJQfi+jRSQEaORPnc7jEzzFcWMVuTnzVesU2OtLS@vger.kernel.org, AJvYcCXjQGZ1QF6tl9ONsxAh9i0FkUbP+mCSuQ/L/3/By/tm41PB5IW6xcYqMlHrt4fa165cFv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSPvWDl9Gbpl2aCeaNJgp+9n5Qizeb9mdQqbpJVyEgvTLUh53J
	mT33jaD2mlXQNTc320FXWOXZnGiKQfilQ9BGqMMUy9S2DMruN8hrD6lD
X-Gm-Gg: ASbGnctGQ7D+QoSJ+196Q3gVoeeeKhM8eJlgIVQT8Z5/J8Z6kO/KtARrDxcEWi9daul
	I21HQHk0LWQsuPehZ/zHq1Uo3UfYxtRocvNlPfbj3YOEoRQTw1Xn+doTstNdOA/i6eEuVDFs0NZ
	tvTjjXicACN87V1SQBpWEMCNCJkLflQ/RA7dJR/JuqzYlAMWSUn6JrTCKj6KXA1YurevSWx34Ot
	qqVNjBhYm10SsyEZi7Hktjy6+IRFQisYhIo2m47wAPCC9x7T1YNT7k9hkl44/OvaIMTZYMXgBWu
	v4vldQN6mmjP561L5dlh3Co06zsnSP6MJV67YvFice/NhoGOgub1nfhCyOuHT5GzMXSCaJ4o9+u
	/zYOf/HU=
X-Google-Smtp-Source: AGHT+IFAOq3HGu7n+dZnHU1IDl3SXVC3N2xiK5uud9KRobTsX90UhMFPJkRX0UE3uTVkreK4skBljw==
X-Received: by 2002:a17:907:6eab:b0:b04:274a:fc87 with SMTP id a640c23a62f3a-b04b13fe46bmr1173975466b.4.1757421316162;
        Tue, 09 Sep 2025 05:35:16 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b046e6c630fsm1465483866b.55.2025.09.09.05.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 05:35:15 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 9 Sep 2025 14:35:13 +0200
To: Tao Chen <chen.dylane@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@fomichev.me, haoluo@google.com, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add stacktrace map
 lookup_and_delete_elem test case
Message-ID: <aMAfAf1JEAcbYOuq@krava>
References: <20250908113622.810652-1-chen.dylane@linux.dev>
 <20250908113622.810652-2-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908113622.810652-2-chen.dylane@linux.dev>

On Mon, Sep 08, 2025 at 07:36:22PM +0800, Tao Chen wrote:
> ...
> test_stacktrace_map:PASS:compare_stack_ips stackmap vs. stack_amap 0 nsec
> test_stacktrace_map:PASS:stack_key_map lookup 0 nsec
> test_stacktrace_map:PASS:stackmap lookup and detele 0 nsec
>  #397     stacktrace_map:OK
> ...
> 
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  .../selftests/bpf/prog_tests/stacktrace_map.c  | 18 +++++++++++++++++-
>  .../selftests/bpf/progs/test_stacktrace_map.c  | 12 +++++++++++-
>  2 files changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
> index 84a7e405e91..496c4dcf4ea 100644
> --- a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
> +++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
> @@ -3,7 +3,7 @@
>  
>  void test_stacktrace_map(void)
>  {
> -	int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd;
> +	int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd, stack_key_map_fd;
>  	const char *prog_name = "oncpu";
>  	int err, prog_fd, stack_trace_len;
>  	const char *file = "./test_stacktrace_map.bpf.o";
> @@ -11,6 +11,9 @@ void test_stacktrace_map(void)
>  	struct bpf_program *prog;
>  	struct bpf_object *obj;
>  	struct bpf_link *link;
> +	__u32 stackmap_key;
> +	char val_buf[PERF_MAX_STACK_DEPTH *
> +		sizeof(struct bpf_stack_build_id)];
>  
>  	err = bpf_prog_test_load(file, BPF_PROG_TYPE_TRACEPOINT, &obj, &prog_fd);
>  	if (CHECK(err, "prog_load", "err %d errno %d\n", err, errno))
> @@ -41,6 +44,10 @@ void test_stacktrace_map(void)
>  	if (CHECK_FAIL(stack_amap_fd < 0))
>  		goto disable_pmu;
>  
> +	stack_key_map_fd = bpf_find_map(__func__, obj, "stack_key_map");
> +	if (CHECK_FAIL(stack_key_map_fd < 0))
> +		goto disable_pmu;
> +
>  	/* give some time for bpf program run */
>  	sleep(1);
>  
> @@ -68,6 +75,15 @@ void test_stacktrace_map(void)
>  		  "err %d errno %d\n", err, errno))
>  		goto disable_pmu;
>  
> +	err = bpf_map_lookup_elem(stack_key_map_fd, &key, &stackmap_key);
> +	if (CHECK(err, "stack_key_map lookup", "err %d errno %d\n", err, errno))
> +		goto disable_pmu;
> +
> +	err = bpf_map_lookup_and_delete_elem(stackmap_fd, &stackmap_key, &val_buf);
> +	if (CHECK(err, "stackmap lookup and detele",

nit typo 's/detele/delete/'

> +		  "err %d errno %d\n", err, errno))
> +		goto disable_pmu;

should we also check the record got deleted? like make sure following
lookup fails with NOENT:

  bpf_map_lookup_elem(stackmap_fd, &stackmap_key, &val_buf)

> +
>  disable_pmu:
>  	bpf_link__destroy(link);
>  close_prog:
> diff --git a/tools/testing/selftests/bpf/progs/test_stacktrace_map.c b/tools/testing/selftests/bpf/progs/test_stacktrace_map.c
> index 47568007b66..d036e8e9c83 100644
> --- a/tools/testing/selftests/bpf/progs/test_stacktrace_map.c
> +++ b/tools/testing/selftests/bpf/progs/test_stacktrace_map.c
> @@ -38,6 +38,13 @@ struct {
>  	__type(value, stack_trace_t);
>  } stack_amap SEC(".maps");
>  
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__uint(max_entries, 1);
> +	__type(key, __u32);
> +	__type(value, __u32);
> +} stack_key_map SEC(".maps");
> +
>  /* taken from /sys/kernel/tracing/events/sched/sched_switch/format */
>  struct sched_switch_args {
>  	unsigned long long pad;
> @@ -54,7 +61,7 @@ SEC("tracepoint/sched/sched_switch")
>  int oncpu(struct sched_switch_args *ctx)
>  {
>  	__u32 max_len = PERF_MAX_STACK_DEPTH * sizeof(__u64);
> -	__u32 key = 0, val = 0, *value_p;
> +	__u32 key = 0, val = 0, *value_p, stackmap_key = 0;
>  	void *stack_p;
>  
>  	value_p = bpf_map_lookup_elem(&control_map, &key);
> @@ -64,6 +71,9 @@ int oncpu(struct sched_switch_args *ctx)
>  	/* The size of stackmap and stackid_hmap should be the same */
>  	key = bpf_get_stackid(ctx, &stackmap, 0);
>  	if ((int)key >= 0) {
> +		val = key;
> +		bpf_map_update_elem(&stack_key_map, &stackmap_key, &val, 0);

why not use '&key' directly as the update value?

jirka


> +		val = 0;
>  		bpf_map_update_elem(&stackid_hmap, &key, &val, 0);
>  		stack_p = bpf_map_lookup_elem(&stack_amap, &key);
>  		if (stack_p)
> -- 
> 2.48.1
> 
> 

