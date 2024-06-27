Return-Path: <bpf+bounces-33274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C37D191AD51
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 18:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E13128789D
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 16:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1092199EAF;
	Thu, 27 Jun 2024 16:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=woks-audio.com header.i=@woks-audio.com header.b="lt3HoQar"
X-Original-To: bpf@vger.kernel.org
Received: from mx0.woks-audio.com (mx0.woks-audio.com [88.99.2.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FEC199E95;
	Thu, 27 Jun 2024 16:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.2.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719507486; cv=none; b=hiIuyCM9qVR9QveTtO3NWn5gpmEnU+po959ZwboZ5eO9c2wheRQ2ZXPWRxz/mVzuOhlvNpwoHGJc6wUOUvB81PAbnP7QgE7J5EttT8js51j+rn5RNMZ8mLWCjAiOyWE4b3QeUFOXi95NGyTGZJZrFITo0EU9NztIBpYApdiIFKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719507486; c=relaxed/simple;
	bh=JUrDz0DUi7tTCIkG+LvEykVWxfjltHMCEk5nyXOxBE0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N5xBP1lkmZrM7nW6HtGWkAS5qA0pLLsXrV5cIejJW/tmYCh/dhKyozovvnTPkZtTETHyWYI3jwktzBckdCD3EbZJMWmQPoMdPRFTURPNXnkfj3h4FYC8Ke2LxNMmorUSFyl7vCT9txmETbixH7PS8TlwdAbPY8baPT6X9A3z80w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=woks-audio.com; spf=pass smtp.mailfrom=woks-audio.com; dkim=pass (2048-bit key) header.d=woks-audio.com header.i=@woks-audio.com header.b=lt3HoQar; arc=none smtp.client-ip=88.99.2.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=woks-audio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=woks-audio.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=woks-audio.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=woks; bh=PenMp7vS8XlisAM41TFu
	zVihkYFaLUEzYIJvh+AQm4M=; b=lt3HoQarHo9VA33X7Km44EYZTJn6MR3RS5ju
	rGkivuCCAtTecsXv27sxu/+Ly0vBKd54+wsKHEPeoo/fdlVvYH/+9ZX/69bFcP8+
	ID4IeSVKR04lRSgCMQMUrJ8gOMNpwEbnpJdy/PB1oG0vsbfs9b1XuDAEhsSQnvom
	xIX1IbeUQbvJ0HgJaFImNkt4VQQYKfdyWzhaKGgyyfWOn0IjjmDGW/BulTFAEQA3
	U+TjFRObSC55+3aiU3XOgEwHNeB6F3QuVXMpvQzstyUAqhQEc0YNwWuBMV2PUqnj
	aiTMcl00EPJzsBoIeA0Ak1obnUSYo70cSa5myqjl6t+sWU1bUw==
From: Benjamin Steinke <benjamin.steinke@woks-audio.com>
To: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
CC: <intel-wired-lan@osuosl.org>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, <netdev@vger.kernel.org>, Jonathan
 Lemon <jonathan.lemon@gmail.com>, John Fastabend <john.fastabend@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>, =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?=
	<bjorn@kernel.org>, Eric Dumazet <edumazet@google.com>, Sriram Yagnaraman
	<sriram.yagnaraman@est.tech>, Tony Nguyen <anthony.l.nguyen@intel.com>, Jakub
 Kicinski <kuba@kernel.org>, <bpf@vger.kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>, Magnus
 Karlsson <magnus.karlsson@intel.com>, Kurt Kanzenbach <kurt@linutronix.de>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 0/4] igb: Add support for AF_XDP zero-copy
Date: Thu, 27 Jun 2024 18:49:16 +0200
Message-ID: <3253130.2gtjKKCVsX@desktop>
In-Reply-To: <878qyq9838.fsf@kurt.kurt.home>
References: <20230804084051.14194-1-sriram.yagnaraman@est.tech> <878qyq9838.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-ClientProxiedBy: EX1.jas.loc (10.100.2.20) To EX1.jas.loc (10.100.2.20)

On Thursday, 27 June 2024, 09:07:55 CEST, Kurt Kanzenbach wrote:
> Hi Sriram,
> 
> On Fri Aug 04 2023, Sriram Yagnaraman wrote:
> > The first couple of patches adds helper funcctions to prepare for AF_XDP
> > zero-copy support which comes in the last couple of patches, one each
> > for Rx and TX paths.
> > 
> > As mentioned in v1 patchset [0], I don't have access to an actual IGB
> > device to provide correct performance numbers. I have used Intel 82576EB
> > emulator in QEMU [1] to test the changes to IGB driver.
> 
> I gave this patch series a try on a recent kernel and silicon
> (i210). There was one issue in igb_xmit_zc(). But other than that it
> worked very nicely.

Hi Kurt and Sriram,

I recently tried the patches on a 6.1 kernel. On two different devices i210 & 
i211 I couldn't see any packets being transmitted on the wire. Perhaps caused 
by the issue in igb_xmit_zc() you mentioned, Kurt? Can you share your findings, 
please?

RX seemed to work on first sight.

> It seems like it hasn't been merged yet. Do you have any plans for
> continuing to work on this?

I can offer to do testing and debugging on real hardware if this helps.

Thanks,
Benjamin





