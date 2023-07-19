Return-Path: <bpf+bounces-5205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB041758A0D
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 02:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D19651C20E68
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 00:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35732ECC;
	Wed, 19 Jul 2023 00:25:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC92179;
	Wed, 19 Jul 2023 00:25:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9D3C433C7;
	Wed, 19 Jul 2023 00:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689726333;
	bh=2aGgTSj5bbj/YnWHpy0VMS6W5Q7YQSDfMHgsOrDd8bQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MX3QI5ckWp/2DdOGkOxi7kMSe0ASR2unOjXm7nGeHT7BwwyWJqk2lGcIjaQYvWl6m
	 r3S5qhzuY7vNWo4wsGE6f2Bxg4N4RZa+2Sz5c/ywenGm+y6gMcsWdDSvA4lmmhLaTw
	 A3sRlrok+a4vpKfRmjQVXUGY32jpht7124UBfEzDM3ibF6+eVyh/coGaWRDAezQQUv
	 IGPhz3ZxBUpFp8ZBdWrzHR3kmebuF3e/qfdSK0zr/cubSZRlhiJyteKqsLDIBvzd8V
	 x8oB2bk62GfTvKyqiOzmiFWOwXKLFGoRIKiwYceeMrRmGEBtglDAZ30jNXtIp1pE4r
	 OAH3nquzb2qrA==
Date: Tue, 18 Jul 2023 17:25:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 razor@blackwall.org, sdf@google.com, john.fastabend@gmail.com,
 dxu@dxuuu.xyz, joe@cilium.io, toke@kernel.org, davem@davemloft.net,
 bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 2/8] bpf: Add fd-based tcx multi-prog infra
 with link support
Message-ID: <20230718172531.67b639fc@kernel.org>
In-Reply-To: <20230714141545.26904-3-daniel@iogearbox.net>
References: <20230714141545.26904-1-daniel@iogearbox.net>
	<20230714141545.26904-3-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Jul 2023 16:15:39 +0200 Daniel Borkmann wrote:
> +void tcx_inc(void)
> +{
> +	static_branch_inc(&tcx_needed_key);
> +}
> +EXPORT_SYMBOL_GPL(tcx_inc);
> +
> +void tcx_dec(void)
> +{
> +	static_branch_dec(&tcx_needed_key);
> +}
> +EXPORT_SYMBOL_GPL(tcx_dec);

Do these need to be exported? Otherwise:

Acked-by: Jakub Kicinski <kuba@kernel.org>

