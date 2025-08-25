Return-Path: <bpf+bounces-66468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B780BB34F0D
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 00:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7503D2A48C8
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 22:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E18298CCF;
	Mon, 25 Aug 2025 22:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBVQ3gze"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1753B271475;
	Mon, 25 Aug 2025 22:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756160988; cv=none; b=SBZ9gJmuKxbNmMQ8PtFm3HMK4ny0hWdl3nBC5Pg39SCe72Y5ZK/hw1lnPwV23Dx7WRR2sCYy4BNn9UaQpUk1ow6mNCBdtV8jvNB+S+1+pOeh3qPo7Orw3CEXAh3SqRbyITiq/kd0F9QhJB/krtgJvInm3/fyqUhtOHNYjlvM+SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756160988; c=relaxed/simple;
	bh=d1OAkPqa8ZmyQj+ydzoZS6CfmzIkGq0NY9VT+2MPx+I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pEBCQVF5l2xA9M3HlyrX5KN6kQ/NEXJWQiUYN/e/KYhcC2m3zNyODQlm4qTeXHQmhsP68KhbnW+HZg+OUauWFxNNgcNHv6SAspzUwHuu245ToOFsGng2pQX5U0e/0zr+TTfcIFyVuXuyb0uLg/lsErBnBSpSVJ22bbNkSkJEIzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBVQ3gze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D241C4CEED;
	Mon, 25 Aug 2025 22:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756160988;
	bh=d1OAkPqa8ZmyQj+ydzoZS6CfmzIkGq0NY9VT+2MPx+I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RBVQ3gzeEouUn+cTavVTP/KzV8EkqpOGNKmrgm9ecAtwfW+fteb9wSk8R9F7sn7ol
	 dwTM6d55RCfjSjenFMAOnOsR0uWtotms3XIDKE574bQ5GuzxGiNSH4OTx7I3IMwhQJ
	 MWg1qC7gKVNpMP8i/BimKZf3pTi5mJN89we/ND6ZhnsWC6w4jFlQUG8ojY3oKm1Qxi
	 tFfTk2ADi88nf84tItTU+lcUoSXbMkEQ36FZkh2Ko99hA+zZkEscCBNbmsAdmbMYlV
	 LfLlL1y45x7derE/jKr2zonJL73jfmjeKg51ZLv7+Ae4DB4Mlvgxt64n0125TR8vXz
	 jK+T8clWaiviw==
Date: Mon, 25 Aug 2025 15:29:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Amery Hung <ameryhung@gmail.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, mohsin.bashr@gmail.com,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 maciej.fijalkowski@intel.com, kernel-team@meta.com
Subject: Re: [RFC bpf-next v1 3/7] bpf: Support pulling non-linear xdp data
Message-ID: <20250825152946.4c25c538@kernel.org>
In-Reply-To: <CAMB2axOkPx=5vseNXbwQtHQTFhdur6OSZ-HbNPUciwBmubQa1w@mail.gmail.com>
References: <20250825193918.3445531-1-ameryhung@gmail.com>
	<20250825193918.3445531-4-ameryhung@gmail.com>
	<aKzVsZ0D53rhOhQe@mini-arch>
	<CAMB2axOkPx=5vseNXbwQtHQTFhdur6OSZ-HbNPUciwBmubQa1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Aug 2025 15:23:23 -0700 Amery Hung wrote:
> > > +     if (!len)
> > > +             len = xdp_get_buff_len(xdp);  
> >
> > Why not return -EINVAL here for len=0?
> >  
> 
> I try to mirror the behavior of bpf_skb_pull_data() to reduce confusion here.

Different question for the same LoC :)

Why not

	if (!len)
		len = buff_len;
?
Or perhaps:

	len = len ?: buf_len;

