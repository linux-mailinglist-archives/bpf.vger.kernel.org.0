Return-Path: <bpf+bounces-35010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED29B9350CA
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 18:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 298711C21286
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 16:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998FF144D3F;
	Thu, 18 Jul 2024 16:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="KGFhCRs6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jaqpIfXT"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3224A144D34
	for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721320991; cv=none; b=iOXWIsn3uoaoHf4AOcOKkItvvxo904vFXaOrWTwWUPiL4oaiIbGbUTnhEgBHIcO/UILcsKnt1x7nSSbjISpfaqZ5Y4ltosoYngPEl9n8qDBGUgV0HJjsrplbXTg/Mrpg4tUTephq9A0ROQMgfP8aHJPG6J3xEf0PWiQY8uLmBAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721320991; c=relaxed/simple;
	bh=+jw7I/FrczDXrhqzQjw5X1x7TLNkgB9H7Fx46qNvtQE=;
	h=MIME-Version:Message-Id:Date:From:To:Subject:Content-Type; b=EM139/QBbGJI9PtAmmYLABi38FJLKA030YWXbho2PbZT7ucqGfVcw3QBnsQ1XCSNkvx3OnH2cA4z2CPJ2pgc1sB0EDJ3sxTK3MQzbHZA17BU4kqms8v1qtLQQw3ThmMRN3AHLGVYTQXRu3JlQuQm8/YQX00rxc+Mh8KxhimyS5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=KGFhCRs6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jaqpIfXT; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 35BFD1140126
	for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 12:43:08 -0400 (EDT)
Received: from imap42 ([10.202.2.92])
  by compute1.internal (MEProxy); Thu, 18 Jul 2024 12:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1721320988; x=1721407388; bh=+jw7I/FrczDXrhqzQjw5X1x7TLNkgB9H
	7Fx46qNvtQE=; b=KGFhCRs6Pmj/6wQE0jHuTE99IwZV0ktxWbGyI0nIbO2SrQ4y
	xfW7ewR+/vOP2y8ShO9qGOj1DvuHIN8KNMfbSmkiC7VtnDVYyp9fHQ1agw5iEBag
	iwOk8IpgrYSs7kk4Ki5lnzjWujXwt2WlmsGEFH4vJVCvL+bmfwFiMn7odgmEO1Q5
	L16WnBwbEg6stghMkmPlMAhwx5yhSng0DfSwuuwuZUCzwOgjxZbNQfroyAniw4pQ
	WiXfGkURd2GXE0dZ0HiT3PmbP2X1fdQdQCUhUo8zVlrECoTSOj66LXuv43llOun5
	ctx9apJIEQ7OfDu9MBai4cyPkSIHn58IGSiwlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1721320988; x=1721407388; bh=+jw7I/FrczDXrhqzQjw5X1x7TLNkgB9H7Fx
	46qNvtQE=; b=jaqpIfXTWD4kZS5dwJVl+9CkxROIn2MU7V3EpqwakYT3BuDaTlo
	XJDtfj0wR+IoIoX6R+6ErigIjYCWDtOItbltpJEFcRa5TuxHJyr+LNI5ynB9d33G
	nAE1QvtIjkot0VNpCjTDf4EKdfSSYZ1eYEtjZFdhNUWjsGPWPbc9+97U9K07pe+E
	wzoEgBDDnuFuwx+8gEdLVPI/d7EaKugxBi6EkDt4trAZQF4ZvMdvhSukxm9EZ0I+
	7SZwAeAWNB3/wnaMOcoBR+pL3HWKwgv7SRaYJdIFt0cjmzWiXSzxl+0ChT5Ja+kU
	GKvQsNi5E2a5pD6xRdzoZZwPJaETcCoJQHQ==
X-ME-Sender: <xms:GkaZZnK5216MeUHII7GoMTVYbCwM_RdUoBlkp4EEBzxEmN6N4M800g>
    <xme:GkaZZrJ9OOU0RnKtQt1MXYhy6wx-dXlZTeGqJMfKN6SOLpixnGM9QP3RSf12rwKdN
    vasxAMkGGsAITUmxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeelgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlvdefmdenucfjughrpefofg
    ggkfffhffvufgtsehttdertderredtnecuhfhrohhmpedfffgrnhhivghlucgiuhdfuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepvedvieevkeeffffhud
    euudeffedtvefftdffveelkefgffeggfeigfelkedvueelnecuffhomhgrihhnpehkvghr
    nhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:GkaZZvvIc42tUMXEjoEJWQVaKczwl_A2hOitAmKRbnORR5V-sgs3Ug>
    <xmx:GkaZZgaBJXeQLetWEGl08f8hBcLlDcbrbDHP0VROznfqhml9yCvVrw>
    <xmx:GkaZZuYXr85iNzu3JOz9jcw_27Z03I_NL5ErQ1Uf9EauCLBIYcpnuA>
    <xmx:GkaZZkBt9EzyQePlBQVZ7CRpvqwqj3zCjS3yC3LNDJQ6DznDVgt9oA>
    <xmx:HEaZZnDqVD_Xk_AHMr-NXDHAY9YNxqOBbXmbYhPXERgH5i3CndgH3SX3>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 6FBE3BC007D; Thu, 18 Jul 2024 12:43:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <022c063d-4eff-4174-9b91-207715779b24@app.fastmail.com>
Date: Thu, 18 Jul 2024 10:42:43 -0600
From: "Daniel Xu" <dxu@dxuuu.xyz>
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [ANNOUNCE] On-list CI notifications rolling out
Content-Type: text/plain

As many of you already know, the BPF subsystem has a fairly
sophisticated CI [0] running behind the scenes. Up until now,
it's only been posting its results to patchwork. So you kinda
had to know where to look.

Over the next few weeks, we're going to roll out on-list CI
result notifications. This should make it easier for drive-by
(or lazy) contributors to check on the status of their submission.

If you see any issues, feel free to CC me on your thread or email
me directly.

We don't expect any major issues - we've been sending off-list
notifications for quite some time now and it's been running
stable.

Thanks,
Daniel

[0] http://vger.kernel.org/bpfconf2024_material/BPF-CI.pdf

