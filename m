Return-Path: <bpf+bounces-36187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBED8943988
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 01:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B4282822F3
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 23:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B6916DEAC;
	Wed, 31 Jul 2024 23:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7osGmom"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712A014B097;
	Wed, 31 Jul 2024 23:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722469975; cv=none; b=L7D+HSlhZ0vzsAVpFH4bhPIKllSBz06S9AHtFZaHiCVmkb+0RxwON+OIliZ+0xj6pbvkXeUwMS2JkrOYG8hLaQKdg/cffeWxrTAw6wdp4/9lStjcidBvPid45v6bw7tCDDm3M0ysZvLmrl+aRwPFh9hkhnTh7AnH+JYuDAIfasY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722469975; c=relaxed/simple;
	bh=lm3j1xdzYpcpoFEdtpSi/NhrcwFeBNmRdzqD+wEVuI0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YOxuinHhuDGpAadQt4Eua++ko+Q2PZp38kgbecjFH1WpxPtLuE/T1AV0/V3awHaWbifCXScP8dW5xXD+ZmI9TNnIUaDHPqyL2eo9mYcFvIQdMPL04oTLhIC5q7OM74YC8cqLInYJQ6SC2/Sx5l/ArKzbcAoE6YQwbRQ4TYGfn9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7osGmom; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75140C116B1;
	Wed, 31 Jul 2024 23:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722469975;
	bh=lm3j1xdzYpcpoFEdtpSi/NhrcwFeBNmRdzqD+wEVuI0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P7osGmom/a484+ejw0mw+VTijyJ1qBvZOE00p4wOUNcTO7/Ap3tXxnLoAajxa0f8m
	 5lX3xcM0AFw3wqi/nmZ4eJgrRFXt5O0JB4cRaGiST76rIl/TNDghvLSbmJmhoaAG6b
	 G+mH1CAfvPRuwdEBNBYYVkPk97Wu9UkZxDY2EFQUlrqOjChx9ONsHdB7NNsoUXNrve
	 yiR9hxyHIC7UJtN/2lQkc/EsS+8neoHY5F65JchlBVNivWHIQGh5HyZq9ufc2It4M4
	 f476cPG0hdIUcQW+0uVHLZD8BBngkwES7Y7Fb8INXdTSaJqkdEyT3FRIK3zIqAITXp
	 d4948A/JOyvHw==
Date: Wed, 31 Jul 2024 16:52:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: "Song, Yoong Siang" <yoong.siang.song@intel.com>, "Neftin, Sasha"
 <sasha.neftin@intel.com>, Brett Creeley <brett.creeley@amd.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, "Eric Dumazet" <edumazet@google.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Blanco Alcaine, Hector"
 <hector.blanco.alcaine@intel.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Jonathan Corbet <corbet@lwn.net>, "Gomes, Vinicius"
 <vinicius.gomes@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, John Fastabend <john.fastabend@gmail.com>,
 Shinas Rasheed <srasheed@marvell.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, Paolo Abeni <pabeni@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "Hay, Joshua A" <joshua.a.hay@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "David S . Miller"
 <davem@davemloft.net>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next, v1 0/3] Add Default Rx Queue
 Setting for igc driver
Message-ID: <20240731165253.2571b254@kernel.org>
In-Reply-To: <d805bea3-cb2f-4e2c-a07a-27b8b4c5f294@intel.com>
References: <20240730012212.775814-1-yoong.siang.song@intel.com>
	<20240730075507.7cf8741f@kernel.org>
	<PH0PR11MB5830E21A96A862B194D4A4A5D8B12@PH0PR11MB5830.namprd11.prod.outlook.com>
	<20240731074351.13676228@kernel.org>
	<d805bea3-cb2f-4e2c-a07a-27b8b4c5f294@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jul 2024 09:41:16 -0700 Jacob Keller wrote:
> In this case, (I haven't dug into the actual patches or code), I suspect
> the driver will need to validate the location values when adding rules
> to ensure that all rules which don't use the default queue have higher
> priority than the wild card rule. The request to add a filter should
> reject the rule in the case where a default queue rule was added with a
> higher priority location.

Maybe I shouldn't say it aloud but picking a "known" location for such
a wildcard rule wouldn't be the worst thing. Obviously better if the
driver just understand ordering!

