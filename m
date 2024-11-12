Return-Path: <bpf+bounces-44656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 448829C5E0D
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 18:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F04AC1F21D30
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 17:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1C420DD40;
	Tue, 12 Nov 2024 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STiu4vFw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A941FCC43;
	Tue, 12 Nov 2024 16:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731430717; cv=none; b=SbgqhKUw4jytgj/1Mqa5yx2ljIN4dVtSjIGiD0OrI7Me3N3ikic9JgbyCRuKVFH6mE5a1+BoNHTZrcxO3bXAV0M95Pc57f1QmmybHtBITeW6xdmPishi0sxzPFudMedhNHuAtxqZzeNk6oq/7Q5j/HFJoRDgjDagQCuznLyQvEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731430717; c=relaxed/simple;
	bh=6MATLaNTaFPSyKBlF8ht5BCoK52hQMWsO7YQuGpBK9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESheaBQNk8yHAivAYzfbyTqNXRPS03niwxbnLPkKLUAB0rY2DYDYeBRLvvjJIozardhKn8EEY7a+jQzLim21DetpAufqovf4dBkmteGyUtpBbl7X/cjBb2lHQCRy5j93jA5kuzpgy84H84zQVCf2r5Ch477o0X2SmbM+0WyKVCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STiu4vFw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8FAC4CECD;
	Tue, 12 Nov 2024 16:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731430717;
	bh=6MATLaNTaFPSyKBlF8ht5BCoK52hQMWsO7YQuGpBK9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=STiu4vFwe+SdIbAaKqeygcdVCSIzYQuVq2GT2lEMoYIVlGA/32lnlDAeCU7V4KhE5
	 oF5FNDajS6y4JZjt/yc5mPw4YJIDqwD1pJzJ19u1F679c1+foDl+OqzQ96Jedoj5mn
	 sqGiYk9W/4pY1xJjV18Km9BScqIDyfAw7GHLQp6AObOizNwHKIOEYMYIWIOHPb79Sy
	 kqFI2+TnKlNw48qyqMbzs0SNqEDUFS2/GTImtQ9INWtxCDPv0L8YTOlXXZuOj27vcc
	 QvODrfJK32ePKD34SFxB9SS0lD95wtZ/2AepPK+F3Oonz84apjc4lmLBLh8zcOT9i+
	 Q6kkjwfiLoaEw==
Date: Tue, 12 Nov 2024 13:58:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Hao Ge <hao.ge@linux.dev>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Hao Ge <gehao@kylinos.cn>
Subject: Re: [PATCH] perf bpf-filter: Return -1 directly when pfi allocation
 fails
Message-ID: <ZzOJOEpyAc92462-@x1>
References: <20241112022815.191201-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112022815.191201-1-hao.ge@linux.dev>

On Tue, Nov 12, 2024 at 10:28:15AM +0800, Hao Ge wrote:
> From: Hao Ge <gehao@kylinos.cn>
> 
> Directly return -1 when pfi allocation fails,

The convention for this function is to return -errno, so please resubmit
returning -ENOMEM.

- Arnaldo

> instead of performing other operations on pfi.
> 
> Fixes: 0fe2b18ddc40 ("perf bpf-filter: Support multiple events properly")
> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> ---
>  tools/perf/util/bpf-filter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
> index e87b6789eb9e..34c8bf7e469e 100644
> --- a/tools/perf/util/bpf-filter.c
> +++ b/tools/perf/util/bpf-filter.c
> @@ -375,7 +375,7 @@ static int create_idx_hash(struct evsel *evsel, struct perf_bpf_filter_entry *en
>  	pfi = zalloc(sizeof(*pfi));
>  	if (pfi == NULL) {
>  		pr_err("Cannot save pinned filter index\n");
> -		goto err;
> +		return -1;
>  	}
>  
>  	pfi->evsel = evsel;
> -- 
> 2.25.1

