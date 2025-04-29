Return-Path: <bpf+bounces-56900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5CEAA01FB
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 07:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 912601B60130
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 05:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C887F2144DE;
	Tue, 29 Apr 2025 05:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hun5pi1i"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C9117C21B
	for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 05:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745905704; cv=none; b=FOy5D1HU+Mm0r5IBuQmsTGkR554TeG4tTZVSbLfrw3FCcJW++O3EOuZgewsgwoTkIQmXXB/LB3gd0Pl952nOMRYRvItBuwWcMoaaw1daVYuzE0CzXI06WThy9l41l7s1hdw8SMbjUA5lkaEVk7+eHh7biVZ+sD8rwtY/eJuYpCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745905704; c=relaxed/simple;
	bh=S2F9cy1P32D1MrCP40MrmJy0aXKoJEYRPzonUjlMoHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oxdUXocnAni6pRpYWgof2o8Nkhe/EmNE+7QCvmC8x+pLHm6YYPpGmNCExGEvH72QoICfIYBeSidrXN+IpUwaYCUpMSzdSr0DsyzxQ3dzxw5pj51H0qE3aYpZVk9pCLNxi4A4kCasJXy3CejqeNd+OAuuHjdTWpNaH5VpPsj3Lds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hun5pi1i; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0a25f585-de46-4e3e-8ec2-47df25947df1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745905690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7LZcbrAMfCDd4lnWPi8BBDX0LHsvZTUM8X0yPk05FoE=;
	b=Hun5pi1iblLS3Eb8YZyho/6ZdLG7pxP4GsGlQWTPl/rtedWkZJ5TejZ4IkSzXvQ4f04waS
	O5R4upoh2OSNjAoJvLc6f05gDO2cQb0XyotSksGiSoiTf3hkO9ZeTZbw7dRDDpTJB5T465
	I2y54h4bLxxvk8NCxsXoAHa0jqrBcCI=
Date: Tue, 29 Apr 2025 13:48:01 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] libbpf: remove sample_period init in perf_buffer
To: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Namhyung Kim <namhyung@kernel.org>
References: <20250423163901.2983689-1-chen.dylane@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <20250423163901.2983689-1-chen.dylane@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/4/24 00:39, Tao Chen 写道:

ping...

> It seems that sample_period no used in perf buffer, actually only
> wakeup_events valid about events aggregation for wakeup. So remove
> it to avoid causing confusion.
> 
> Fixes: fb84b8224655 ("libbpf: add perf buffer API")
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>   tools/lib/bpf/libbpf.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 194809da5172..1830e3c011a5 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -13306,7 +13306,6 @@ struct perf_buffer *perf_buffer__new(int map_fd, size_t page_cnt,
>   	attr.config = PERF_COUNT_SW_BPF_OUTPUT;
>   	attr.type = PERF_TYPE_SOFTWARE;
>   	attr.sample_type = PERF_SAMPLE_RAW;
> -	attr.sample_period = sample_period;
>   	attr.wakeup_events = sample_period;
>   
>   	p.attr = &attr;


-- 
Best Regards
Tao Chen

