Return-Path: <bpf+bounces-72684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6C7C1866D
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 07:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC9B1AA472E
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 06:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE7F2FE587;
	Wed, 29 Oct 2025 06:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="e+WwOI0R"
X-Original-To: bpf@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDA02F12BB;
	Wed, 29 Oct 2025 06:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761718465; cv=none; b=YPl2cNd0Sl4s32mwOgcvvEyeFp+2nx2nQluzvMbnnxJYHoTQgyLruat4dVl0bVka87mGppBuuaoVGMTOYeGC+P3nDMqV8DAN4GoJF6qBrLUlwwkRJqRMVqRmFqfZFAj0f2itPIpGTrQ1AAluJ59GEhJ0NmoE2QTRwgmtg30rSNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761718465; c=relaxed/simple;
	bh=CqTEutJd2iH+SNvmxd+5gxkNpnMuzCbcCo7+YPwtpRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZ4qsuapaM0GF9cj99rN7U5yBFdNAk3pM5T4GoxaImet6Hia3QkVz7z7GModkJuYzUdp+mp3EPtbX7VDVo0g4iHNYuHYobF494eK23CZ14iti0PGB1+oUHHkO5ZBgY5lPt02zbXcHu9opWxdfiTF+mQ3KLQtuHKtcjpoUPjaapo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=e+WwOI0R; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761718459; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=n/Wg+0g3Nyy/TFISVde9M4JkfxmwIT9/CJq8QDTfiTQ=;
	b=e+WwOI0R9ZrPrfBiNyr6LG5isCqREIwOxb6EmMNG6gjWvitWLC+2DBmwi8wcOZBUXnjIzNa1SLGFeD1N0zYatl7gE6UdTwCb5vlV5Xl86V6fPlcLeGkTLeV684ufMFMkTh6ROyw7vP9oh9kVydiVLYqXpLbHmd48BvRx2XddUf0=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WrEi384_1761718457 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 29 Oct 2025 14:14:18 +0800
Date: Wed, 29 Oct 2025 14:14:17 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, ast@kernel.org,
	andrii.nakryiko@gmail.com, daniel@iogearbox.net, andrii@kernel.org,
	pabeni@redhat.com, song@kernel.org, sdf@google.com,
	haoluo@google.com, yhs@fb.com, edumazet@google.com,
	john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
	mjambigi@linux.ibm.com, wenjia@linux.ibm.com, wintera@linux.ibm.com,
	dust.li@linux.alibaba.com, tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com, bpf@vger.kernel.org, davem@davemloft.net,
	kuba@kernel.org, netdev@vger.kernel.org, sidraya@linux.ibm.com,
	jaka@linux.ibm.com
Subject: Re: [PATCH bpf-next v3 0/3] net/smc: Introduce smc_hs_ctrl
Message-ID: <20251029061417.GA22337@j66a10360.sqa.eu95>
References: <20250929063400.37939-1-alibuda@linux.alibaba.com>
 <20251028121531.GA51645@j66a10360.sqa.eu95>
 <fea9adf1-3c61-4213-bc84-9429bf3e82a7@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fea9adf1-3c61-4213-bc84-9429bf3e82a7@linux.dev>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Oct 28, 2025 at 05:30:12PM -0700, Martin KaFai Lau wrote:
> On 10/28/25 5:15 AM, D. Wythe wrote:
> >On Mon, Sep 29, 2025 at 02:33:57PM +0800, D. Wythe wrote:
> >>This patch aims to introduce BPF injection capabilities for SMC and
> >>includes a self-test to ensure code stability.
> >>
> >>Since the SMC protocol isn't ideal for every situation, especially
> >>short-lived ones, most applications can't guarantee the absence of
> >
> >
> >Hi bpf folks,
> >
> >I've noticed this patch has been pending for a while, and I wanted to
> >gently check in. Is there any specific concerns or feedback regarding
> >it from the BPF side? I'm keen to address any issues and move it
> >forward.
> 
> The original v1 started last year. The bpf side had been responsive
> but the progress stopped for months and the smc side review had been
> slow also. I doubt how well will this be supported in the future and
> put this to the bottom of my list since then.
> 
> The set does not apply on bpf-next/net now. Please re-spin.

Hi Martin,

Thanks for your feedback and for surfacing these long-standing
concerns regarding the patchset. I fully appreciate your perspective on
its previous progress.

You're right that this patchset has been in the pipeline for a
significant amount of time, influenced by the past pace of SMC-side
reviews. However, the good news is that its future support should no
longer be a concern. Dust and I, along with two maintainers from IBM,
have been co-maintaining the SMC subsystem for some time now. From our
discussions, I believe that the IBM maintainers are in agreement
and open to the progress of this specific patchset, and Dust Li has already
provided an ACK. This collective and aligned support should effectively address
previous worries about SMC-side review.

Best regards,
D. Wythe

