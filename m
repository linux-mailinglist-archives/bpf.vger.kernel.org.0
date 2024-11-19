Return-Path: <bpf+bounces-45126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E87D9D1C1B
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 01:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40A531F221F2
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 00:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9696C2CA6;
	Tue, 19 Nov 2024 00:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FafuMRs0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1348010F4;
	Tue, 19 Nov 2024 00:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731974899; cv=none; b=pPAmjpwnoqhlKIvHolwP0+6KpIbmklwTKIqB4kzW+lUqAy5WdeoTF5RRFiB4DIqySZXLZ4P5P9flSbrhVxnwsGZzlH7s28MD5hPRbljgc9QgGdHItuInwsh4ahyAa2pBhJG34eP831opWdQb1hE8TliPyxjJoK0z7O5dDUvp0TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731974899; c=relaxed/simple;
	bh=eUuSfbYWvh7whiSfUWQGab3NxAv06TDKoryEboI+zpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Isp8HHs0sHEhKjw6tvvvAIkO8/+NKTrMCQdcbzuvVH6nzM7Nv95TBRqRxZTGBqYJLWXnnyyISqQDoYXy7WqiPlY4Kjo6elVe7bXIsj3LFy0980tYmovkkn8QBzf2VvsiofNDmC5AcBM2sUIIDoxub2UzEugANDSlzzfi7drrF9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FafuMRs0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C6CC4CECC;
	Tue, 19 Nov 2024 00:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731974896;
	bh=eUuSfbYWvh7whiSfUWQGab3NxAv06TDKoryEboI+zpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FafuMRs0Z0+BP96xR9RGJj/8bR+CXl8jcI89TI/UPz1omwfpAUbDq7b2ViMzUBIpL
	 +3/zS2+0+TK9HN+FBxMOpqtjXdZQzh3JAGuVmNj2Nl8aWRP6EbwD4lOXAnhic1n4v+
	 moB6woiF4AQ5q1t5t7cepIA+H8nWWBHcgwqXWWhy9ofw4RwNiHkjDeDHUuFTG3UMjM
	 S8xc9aw0qDYZEkkF6oSGUvIErguYTjJh1+6OCxssP7wj8z3g2JJQw0913+WeL13Y2I
	 SqQCRPWmGWNufzmk13/JB6PcRX4e8UXfzSCZxxk84p1vXF9YLxLEFiuN6canlAXzch
	 Yoiq+kn3wSBtg==
Date: Mon, 18 Nov 2024 16:08:14 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Hao Ge <hao.ge@linux.dev>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Hao Ge <gehao@kylinos.cn>
Subject: Re: [PATCH v2] perf bpf-filter: Return -ENOMEM directly when pfi
 allocation fails
Message-ID: <ZzvW7qjkVYWMSNP5@google.com>
References: <ZzOJOEpyAc92462-@x1>
 <20241113030537.26732-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113030537.26732-1-hao.ge@linux.dev>

On Wed, Nov 13, 2024 at 11:05:37AM +0800, Hao Ge wrote:
> From: Hao Ge <gehao@kylinos.cn>
> 
> Directly return -ENOMEM when pfi allocation fails,
> instead of performing other operations on pfi.
> 
> Fixes: 0fe2b18ddc40 ("perf bpf-filter: Support multiple events properly")
> Signed-off-by: Hao Ge <gehao@kylinos.cn>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
> v2: Replace -1 with -ENOMEM as per Arnaldo's reminder.
>     Update title and commit message due to code change
> ---
>  tools/perf/util/bpf-filter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
> index e87b6789eb9e..a4fdf6911ec1 100644
> --- a/tools/perf/util/bpf-filter.c
> +++ b/tools/perf/util/bpf-filter.c
> @@ -375,7 +375,7 @@ static int create_idx_hash(struct evsel *evsel, struct perf_bpf_filter_entry *en
>  	pfi = zalloc(sizeof(*pfi));
>  	if (pfi == NULL) {
>  		pr_err("Cannot save pinned filter index\n");
> -		goto err;
> +		return -ENOMEM;
>  	}
>  
>  	pfi->evsel = evsel;
> -- 
> 2.25.1
> 

