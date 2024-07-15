Return-Path: <bpf+bounces-34820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 651A0931345
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 13:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 870631C21F1E
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 11:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6667218A923;
	Mon, 15 Jul 2024 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=woks-audio.com header.i=@woks-audio.com header.b="EtvVcCtS"
X-Original-To: bpf@vger.kernel.org
Received: from mx0.woks-audio.com (mx0.woks-audio.com [88.99.2.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78338171BB;
	Mon, 15 Jul 2024 11:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.2.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721043788; cv=none; b=gLMGUIEUVOBNxZXSps8bmK02mN4qSOzm4/E8K9IofRgd9j8XFR/t7EBftXLohWucfW6KlOdGuWgL4d9OHimQ7hqNH1MmNpoSIMdu/ndBoPmxea36Q7UOlPBFCdJcA4ARoPsR3mlyH/lVWXPk0jMcVSl2cpFOVqYJDVtJuooih7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721043788; c=relaxed/simple;
	bh=T9mhDH0c1ZG2sIUI32/qS5pA87j3GgJBY4C7u3AmmXE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bZk/X5VKyfxlL0fSOSYXYF4rMzoPU94FM8ml+g5bzpITHMjFhWcdU1tobMZ/OgOLCkYmVLRgv5jQDQl0whYXgu8YWlTczKVl4Qy9xMeKZcCPjmmz6KGTdA7u3kjLSrTIYALSZQZxtiunhbHUuya9U4ETYDCBSNL8p9UGbC0brOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=woks-audio.com; spf=pass smtp.mailfrom=woks-audio.com; dkim=pass (2048-bit key) header.d=woks-audio.com header.i=@woks-audio.com header.b=EtvVcCtS; arc=none smtp.client-ip=88.99.2.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=woks-audio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=woks-audio.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=woks-audio.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=woks; bh=J7xpTlNWKSsTCrvwopXn
	KlFCYuKohhqt/axMz6/Ds/c=; b=EtvVcCtScC2cpKeH7QyV6FoIFUg3GX2dRPZa
	eXmmiMT8yv0wZlRwurE7l3EqHqb6HkAaWMnHOIeS/a+lltfrjV1zOS7EroMsH3ak
	PftJYjRQeVpnySaY1hICRDRLySA5XV5VEyb50xscve8tPCbPXMpjL9MnKy9LDZhE
	6ilA96Ag+d6BZbiYbjV3fma1Fxs/1WkhpG7bxaW9gFZzf5KTcJzclrs2x1ZdpkXg
	qdyOVBVjl6rbibY4DrKLERSuYC/OKoI/WG93OmBB6DUbClBB9JVJWUsqBwYA8Fs3
	/+/IwbYCkUH7sLyr6bRgdHx4FQCjqMLW3rD97NmpA3ySDEJsaQ==
From: Benjamin Steinke <benjamin.steinke@woks-audio.com>
To: <intel-wired-lan@osuosl.org>, Kurt Kanzenbach <kurt@linutronix.de>
CC: Sriram Yagnaraman <sriram.yagnaraman@est.tech>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, <netdev@vger.kernel.org>, Jonathan
 Lemon <jonathan.lemon@gmail.com>, John Fastabend <john.fastabend@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>, =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?=
	<bjorn@kernel.org>, Eric Dumazet <edumazet@google.com>, Sriram Yagnaraman
	<sriram.yagnaraman@est.tech>, Tony Nguyen <anthony.l.nguyen@intel.com>, Jakub
 Kicinski <kuba@kernel.org>, <bpf@vger.kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>, Magnus
 Karlsson <magnus.karlsson@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 0/4] igb: Add support for AF_XDP zero-copy
Date: Mon, 15 Jul 2024 13:34:11 +0200
Message-ID: <16778076.kXn58iQkRG@desktop>
In-Reply-To: <87cyo2fgnm.fsf@kurt.kurt.home>
References: <20230804084051.14194-1-sriram.yagnaraman@est.tech> <3253130.2gtjKKCVsX@desktop> <87cyo2fgnm.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-ClientProxiedBy: EX1.jas.loc (10.100.2.20) To EX1.jas.loc (10.100.2.20)

On Thursday, 27 June 2024, 19:18:37 CEST, Kurt Kanzenbach wrote:
> Hi Benjamin,
> 
> On Thu Jun 27 2024, Benjamin Steinke wrote:
> > On Thursday, 27 June 2024, 09:07:55 CEST, Kurt Kanzenbach wrote:
> >> Hi Sriram,
> >> 
> >> On Fri Aug 04 2023, Sriram Yagnaraman wrote:
> >> > The first couple of patches adds helper funcctions to prepare for
> >> > AF_XDP
> >> > zero-copy support which comes in the last couple of patches, one each
> >> > for Rx and TX paths.
> >> > 
> >> > As mentioned in v1 patchset [0], I don't have access to an actual IGB
> >> > device to provide correct performance numbers. I have used Intel
> >> > 82576EB
> >> > emulator in QEMU [1] to test the changes to IGB driver.
> >> 
> >> I gave this patch series a try on a recent kernel and silicon
> >> (i210). There was one issue in igb_xmit_zc(). But other than that it
> >> worked very nicely.
> > 
> > Hi Kurt and Sriram,
> > 
> > I recently tried the patches on a 6.1 kernel. On two different devices
> > i210 & i211 I couldn't see any packets being transmitted on the wire.
> > Perhaps caused by the issue in igb_xmit_zc() you mentioned, Kurt? Can you
> > share your findings, please?
> 
> Yeah, that's exactly the issue.
> 
> Following igb_xmit_xdp_ring() I've added PAYLEN to the Tx descriptor
> instead of setting it to zero:
> 
> igb_xmit_zc()
> {
>         [...]
> 
> 	/* put descriptor type bits */
> 	cmd_type = E1000_ADVTXD_DTYP_DATA | E1000_ADVTXD_DCMD_DEXT |
> 		   E1000_ADVTXD_DCMD_IFCS;
> 	olinfo_status = descs[i].len << E1000_ADVTXD_PAYLEN_SHIFT;
> 
> 	cmd_type |= descs[i].len | IGB_TXD_DCMD;
> 	tx_desc->read.cmd_type_len = cpu_to_le32(cmd_type);
> 	tx_desc->read.olinfo_status = cpu_to_le32(olinfo_status);
> 
> 	[...]
> }
> 
> Afterwards packets are transmitted on the wire.

Hi Kurt,

I can confirm this makes the transmitter work.
Thank you for taking over this patch series and continue to bring this 
upstream. I will continue testing on this.
 
> > RX seemed to work on first sight.
> 
> Yes, Rx works even with PTP enabled.

I can confirm this as well. 

Best regards,
Benjamin






