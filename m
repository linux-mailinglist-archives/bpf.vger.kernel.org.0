Return-Path: <bpf+bounces-37722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8D595A015
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 16:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1983C1F21D75
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 14:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B301B2500;
	Wed, 21 Aug 2024 14:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQtDl6Us"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F15188010;
	Wed, 21 Aug 2024 14:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724251065; cv=none; b=hdyybzLGhocwAN3YI01Ah7oIPgR0d0czCjM1//dQUNhgs1GMQpzyHOLrP9G5YMLBshr8+Ue+utnhruaqirjfX59B3JqVbW8T7RGr20WuUMv7y3GqGxBpdVjp3wlK9/wqISIdqe1KaEDkMVqQdMstkhd2rAb/DFhXRlh1S9eUlVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724251065; c=relaxed/simple;
	bh=5t9Hp9+KX6MtAN4IwkcbLRnXDae2O/vMf2n8wQrDQeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnSDuOXoCeajJ44Mwhe9sVGFse8XxSVmxDbl7ra+v1hnB83cu8c6khSfO4D+k/I8RFX9zdKjeB0MqNi7bryqNCPpthZcN4sjd8ONFaL2/afLO/TuTLYitV71+BwcsvTMIqlkLYpXjLZiArTBfMf1gzbRI416d9C2qgdTQcDxgkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQtDl6Us; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41B6C32781;
	Wed, 21 Aug 2024 14:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724251065;
	bh=5t9Hp9+KX6MtAN4IwkcbLRnXDae2O/vMf2n8wQrDQeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uQtDl6Us4SCuwP4NEPdhmbHMhgdsM11b9uaHoWHHFK+ylDj8d1uCWfA+ZM31N6Qdv
	 QzY5DoemvreNkdpgc0ed/7r6aD+iF93992SNHJO6EBD1OA8mtsIUCdH7x02EAPQ2vb
	 2KlkP+mQD7m9ASkuTO42BTTVnBQlRQZ4pOi2ntwgqn+WyGewDPcGygZK7w5/YChjZe
	 pl5cnwq2FbcrwlyzVCV6fXH1CQjpE8Kt12fFOyYjv9/YhZh0NkPTtjKKmi52xPndUn
	 syclUKXBS5bxT6ccUGZb79jtMy8+3Yr5/bYrWFJ4GfGQQwjyBfKOHjt9LtdZGn84b3
	 BniolXp0MvLZg==
Date: Wed, 21 Aug 2024 11:37:41 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Yang Ruibin <11162571@vivo.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1] tools:util:Remove the check that map is empty.
Message-ID: <ZsX7tft1EDDAAylh@x1>
References: <20240821101500.4568-1-11162571@vivo.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821101500.4568-1-11162571@vivo.com>

On Wed, Aug 21, 2024 at 06:14:56AM -0400, Yang Ruibin wrote:
> The check that map is empty is already done in the bpf_map__fd (map)
> function and returns an err_no, which does not run further checks.
>  In addition, even if the check for map is run, the return is a pointer,
>  which is not consistent with the err_number returned by bpf_map__fd (map).

Thanks, applied, looks like an artifact from the patch that removed the
bpf_map__def() API.

- Arnaldo
 
> Signed-off-by: Yang Ruibin <11162571@vivo.com>
> ---
>  tools/perf/util/bpf_map.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/tools/perf/util/bpf_map.c b/tools/perf/util/bpf_map.c
> index 81a4d5a7ccf7..578f27d2d6b4 100644
> --- a/tools/perf/util/bpf_map.c
> +++ b/tools/perf/util/bpf_map.c
> @@ -35,9 +35,6 @@ int bpf_map__fprintf(struct bpf_map *map, FILE *fp)
>  	if (fd < 0)
>  		return fd;
>  
> -	if(!map)
> -		return PTR_ERR(map);
> -
>  	err = -ENOMEM;
>  	key = malloc(bpf_map__key_size(map));
>  	if (key == NULL)
> -- 
> 2.34.1

