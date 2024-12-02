Return-Path: <bpf+bounces-45958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EEB9E0EA1
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 23:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D90A285AA4
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 22:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64751DFE29;
	Mon,  2 Dec 2024 22:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHqIlLpj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588F61DFE11;
	Mon,  2 Dec 2024 22:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733177086; cv=none; b=PYVT9RL26GlMvhVPqngXVrJPbjJYPLYabJk9SEflilhuCLzOiJdR4LbV75rlErtOxyNr7UQ7oNlio52ZmlKAbOJQ4uGxJKyJxOUL1f6aym6QBT8SMtEdbGJ1hEDVStxb6KFF/DM2rnHH6FG6l6g2NLq5RHV2oImHUh2a79hIBsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733177086; c=relaxed/simple;
	bh=I4mDpvUHwUmd72iS1kvSMbaCuapN/zGwKCKu6Zsp15Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9ACbUTNuWmt2dzkCEGy6YzhOZPxjseyBfbN/kaC/NTaYq0wWAGuCikNygnGfV+0OuGkoIo9bQkRzy3MiW1FcP72BkCbVnLfN7NNvVuJh3khnLTQ4IVu29ypOJOrg3ulEZ7h6gR4idSMu5jzHM+Aq+fpxVQsUs23robdccgtxbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHqIlLpj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18FB9C4CED1;
	Mon,  2 Dec 2024 22:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733177085;
	bh=I4mDpvUHwUmd72iS1kvSMbaCuapN/zGwKCKu6Zsp15Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nHqIlLpjh/4o3Pq4qsFW6NSkc4kjQc9j1VaYkye7vMPm80m1DXqQFonOAcrqfqIEk
	 3yhRyP05SKkeq2PUqYvPGyLuoDfn2r1Z7vmAe81ydiRhQjIb/D4yOZMiTGP7wQqmNi
	 HtJ9z+zeodwWwh3xkISHSmCSKw9I+/bDlhMeE5cJ9FBGrS2bX4dLpMwC1akTHQVx4E
	 BwXaAPkk53hFKMfJdHcCuk/LhA+MmgFjW7N96xp3UoU/sgDvdbjiFYNFQwcmcGTC2d
	 0JDAE7YbnHEeKDO7antm8msTD+O5ouvsWoCzowL5MqJ4GKV/fozwOfo1x/1A1sNSLM
	 hyC/wRvLcC3Tg==
Date: Mon, 2 Dec 2024 14:04:43 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Zhongqiu Han <quic_zhonhan@quicinc.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, james.clark@linaro.org,
	yangyicong@hisilicon.com, song@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH 0/3] perf tool: Fix multiple memory leakages
Message-ID: <Z04u-7DQr5w9daS5@google.com>
References: <20241128125432.2748981-1-quic_zhonhan@quicinc.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241128125432.2748981-1-quic_zhonhan@quicinc.com>

On Thu, Nov 28, 2024 at 08:54:29PM +0800, Zhongqiu Han wrote:
> Fix memory leakages when btf_node or bpf_prog_info_node is duplicated
> during insertion into perf_env.
> 
> Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
> ---
> Zhongqiu Han (3):
>   perf header: Fix one memory leakage in process_bpf_btf()
>   perf header: Fix one memory leakage in process_bpf_prog_info()
>   perf bpf: Fix two memory leakages when calling
>     perf_env__insert_bpf_prog_info()

Although I have a nitpick in the patch 3, it looks good otherwise.

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

And I don't think the Fixes tags are correct, but it won't apply before
the change it points to.  So for practical reason, I'm ok with that.

Thanks,
Namhyung

> 
>  tools/perf/util/bpf-event.c | 10 ++++++++--
>  tools/perf/util/env.c       | 12 ++++++++----
>  tools/perf/util/env.h       |  4 ++--
>  tools/perf/util/header.c    |  8 ++++++--
>  4 files changed, 24 insertions(+), 10 deletions(-)
> 
> 
> base-commit: f486c8aa16b8172f63bddc70116a0c897a7f3f02
> -- 
> 2.25.1
> 

