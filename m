Return-Path: <bpf+bounces-69169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98973B8ECF3
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 04:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66A4E189CC56
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 02:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0212EC571;
	Mon, 22 Sep 2025 02:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3k47kb4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F031547CC
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 02:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758508973; cv=none; b=Lbp8a4smLB5gRtDgEqr52jLRPaGvkb4PZ4vbXnetmuDBacPvrZdsfkb98fvt68CW1l5Ae2jXq9IJTsPelPXhVE3mgb4691CYoomtIdWANAGX4nZTdveem35zUu7B8V21MmKOL7qfJjB7+yj21HnXSrTYLDP2y0iV3pHlD2rvxpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758508973; c=relaxed/simple;
	bh=/1cGLZSP8kaxfekkX+rPZuAIkcebERioAH2+cpf7ehM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hGbFrV+T5ClXR7adSGdpHnqSDfPX3hoBCzGgcq737tam2geqkm8gy/I81iokehcnsJ7Mv0cwTq/KEXm2YroqzZTMgeqljfpD0XYe9u5mD9cZpH/aDD1+FxNskh1C3HamYhXBDa174qAC8jjE4jN0vwgNYYI8dSwl3SuvQg6tUVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3k47kb4; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2570bf605b1so51321135ad.2
        for <bpf@vger.kernel.org>; Sun, 21 Sep 2025 19:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758508970; x=1759113770; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qpGBhjyC/fsnWKELi2J+xDResCrP6qtwTx78RLf5cPk=;
        b=k3k47kb47RA3kKZ5d2k/U+Y+LrCu6JS+0HLkHzRvRqYW3Y0CnXk0Vu+WAehtAA1SfR
         h2RTTph1C9MqlrPBa/B8g7uLbUlzJh3YZjV2Uq6LDLUnmabKtxdbQDJj+TOTN9sGS6SJ
         oxomDT5x4QogG5iwOExM9P9xOTR9Lj6PZQeekg1fML8L9B/AdOutfrQt0jeTDdT5zqzn
         19cQxi7GR6tFUGq6GcammWNVXBKX8VCtyKka9RR7daj4RiZBvZmJrwY31CXvl1zMhfvV
         Qj8AFp7Q5e/cvX51PLsZ3V9vEFRzsrCkvIVQ3VJ0DArTxwPU9sLgGKlkH1N1tVNsH2W+
         BCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758508970; x=1759113770;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qpGBhjyC/fsnWKELi2J+xDResCrP6qtwTx78RLf5cPk=;
        b=owRpUehfwTacYDNKQxoxwU2tbHwXQXSA9KRaZcp5whzH+8qTotOgNOzRyUq+FaVKez
         3TrjzArnr65f5euHTaZzRRz/wQO994kaCrAoaqicqzRoKj0ikNnnOHIboHYSD76U38MS
         WnGqnVdYb4s6mm8CdzFhNiFseIlXcdDVmCL8PzYuoWMR9Rn714OMuJwa3hkn/oaUW705
         eZjWP2VudHlAqAY4OX377vCKuUf0IshboXh8MY5gf2ZAAYlqf4h7tvRBeg9QZzBdUBr9
         aZrKavvHrBH/+t+3tHu4ZxeBEDjL1M+iH0XNmDiZJEzHIv68751aZXhv43/VuZXgiRxA
         cxpw==
X-Gm-Message-State: AOJu0Yxpmhh8y09vVze7LCTaL2vNWXbH77XlWaYt0zcTqNfw6YBhtz7U
	TgsbZ9qXhE8FHY2abpZ9aoeg1iM3YIM4ngTwf+ydELsxJoEf+ciWJpHd
X-Gm-Gg: ASbGncuUnGAqtlW8vYgB7vJlHjDQM79HKjnIoh9UpnPZykaGEc16cRw7iehNCG7AT2V
	ipzooW9DH1/yD+Q1SJC7b859qW/qa+FkMTKqBBD98Vgm/oJfHa45MFRmiAI9tPiGy39X2asPdee
	DsK4SCCBbKXwGSOl9UMfvB/AgxQ3fol51hpfmW8utBaZga9xrJ4e7sGk5jcZqrg6jrL6WxiJog3
	R5NA+SVXZWKeUqo1ZEy9kjn0q0rlrcf6qNHu/RJHeDkCDLq/XR4M3hIf/U4cWa2vjAyy2y1G+LD
	ubxOaIL1LXE1DbITk+95J8307EwFXFYngNmjY6Fhh4XWVnrA/3jsEsurT3ZqUiZipLTCISGsL7V
	FaBKtAx/WwfKbssFdAjul392JU5ylzOPlntO8Pk6+JELNSg==
X-Google-Smtp-Source: AGHT+IHRdzjR6lUNTVj0Tu1hJGVqYFIE8OBxpwn+ueG5Q8Sftr4UcpyZwJYiPtnZcxdst+qlMwzlzA==
X-Received: by 2002:a17:902:e742:b0:246:441f:f144 with SMTP id d9443c01a7336-269ba5688b4mr128039495ad.56.1758508970548;
        Sun, 21 Sep 2025 19:42:50 -0700 (PDT)
Received: from [10.22.65.172] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016bf11sm115029975ad.34.2025.09.21.19.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 19:42:49 -0700 (PDT)
Message-ID: <f1d2d0fc-c541-4acc-b5d6-34f2bba37aea@gmail.com>
Date: Mon, 22 Sep 2025 10:42:44 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Add stacktrace map
 lookup_and_delete_elem test case
Content-Language: en-US
To: Tao Chen <chen.dylane@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250920155211.1354348-1-chen.dylane@linux.dev>
 <20250920155211.1354348-2-chen.dylane@linux.dev>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <20250920155211.1354348-2-chen.dylane@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 20/9/25 23:52, Tao Chen wrote:
> ...
> test_stacktrace_map:PASS:compare_stack_ips stackmap vs. stack_amap 0 nsec
> test_stacktrace_map:PASS:stack_key_map lookup 0 nsec
> test_stacktrace_map:PASS:stackmap lookup and detele 0 nsec
> test_stacktrace_map:PASS:stackmap lookup deleted stack_id 0 nsec
>  #397     stacktrace_map:OK
> ...

As they suppose to pass, they are meaningless in the commit log.

Please describe what the test is for and what it is doing instead.

> 
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  .../selftests/bpf/prog_tests/stacktrace_map.c | 22 ++++++++++++++++++-
>  .../selftests/bpf/progs/test_stacktrace_map.c |  8 +++++++
>  2 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
> index 84a7e405e91..7d38afe5cfc 100644
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
> +	__u32 stack_id;
> +	char val_buf[PERF_MAX_STACK_DEPTH *
> +		sizeof(struct bpf_stack_build_id)];

Nit: minor indentation issue here.

'val_buf' should stay on a single line, since up to 100 characters per
line are allowed.

NOTE: keep inverted Christmas tree style.

Thanks,
Leon

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

[...]

