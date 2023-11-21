Return-Path: <bpf+bounces-15596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDB27F37BC
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 21:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4343B217D5
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 20:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1165101C;
	Tue, 21 Nov 2023 20:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="sAzyBX7b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C3TF2PAy"
X-Original-To: bpf@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE48C19E;
	Tue, 21 Nov 2023 12:50:30 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 8F5C73200BB2;
	Tue, 21 Nov 2023 15:50:29 -0500 (EST)
Received: from imap42 ([10.202.2.92])
  by compute4.internal (MEProxy); Tue, 21 Nov 2023 15:50:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to; s=fm3; t=1700599829; x=1700686229; bh=2Qs9fWSfJt
	gCu3V8Z3tcwX7KwBoXsBofNMuRavCMnRo=; b=sAzyBX7bquZduUrazxktB+Rq+4
	DytOlHD6u3YebvG+GJtCq5h95SFSy9bWZ1JVb22VbRqwclhdqCryRBw7Yl7Z3XZB
	MNt+UKU30MVqZ4kUHKM1KPjP3RUlQK72nMsiPMAqrkPSYivyhFbOIBA1+S5Xt85R
	yw2uzACor5V+KOMwEKyZFCqf1IOPMS/J23YlniZ8CA2Q7M33qXEFZMcxakJd7u9z
	uWvD8bzeqRdpqkuUurtojFv0N4zzctKJbQVvbjhdzT7n5Cowhv085iWsA1Xaii5z
	Su8euMgPF2UFRtCLCG+c4FcuTX4WuJK6YxGOP+A+7mUAiZC2rbyOtbLEqaEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:reply-to:sender:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1700599829; x=1700686229; bh=2Qs9fWSfJtgCu3V8Z3tcwX7KwBoX
	sBofNMuRavCMnRo=; b=C3TF2PAyoOuGwA7+FWJvYOVJRM1BjHtK4Y8SYb9Ika1T
	UaAHqZpvpdPICrQyy9hy1z8NZeh1yoBQJsoxyuL0j24U4qeqUdDrJdkcepiCsWaL
	sB0J8JICd4uQWJJ2xPN3obvYDtb6u8rLFIzzuVeDj97IuM784NfYr8gkG/Cr9R3Q
	6Sn3MIw02tPNI9vmd7UC1rx9V/oMjjgiLir38OTPg7jJkrQpn/t8+PinHD4dRW4z
	xo3C7jxssQIRBotKLeoymsYarK1OtR8X0tzaTx44GHHLSOnt/39TLaeJddhVQpFT
	PMiFIbLCQ3NVBNzXeUa9myWXLfzehFCmcbv591MR3Q==
X-ME-Sender: <xms:FBhdZSsI9EzTHjj1wMJgCHwtpvPCzkDIsOQuWiM4McXNVhjNk5uzRQ>
    <xme:FBhdZXc42BwBIGpyrARofUA7_bniaG9W9rLAc4NFFG56ZZCYJKDKOnQTtHYFUay-K
    vBhxrM3LuWg5BIP6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegledgudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdefhedmnecujfgurhepofgfggfkjgffhffvvefutgesthdtredt
    reertdenucfhrhhomhepfdffrghnihgvlhcuighufdcuoegugihusegugihuuhhurdighi
    iiqeenucggtffrrghtthgvrhhnpedvtdeitdeuiedujeejfeelvdeigfdvgefhjeehiefh
    vddufeduueejffetffefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:FBhdZdxM38Eo0EQ-5qSkDkYtyqH6Ocan2JbVZnkHc8Lg8-QcRQY88g>
    <xmx:FBhdZdPN1BIABuAy_DAHVra09Jbbh-7GOAxk8eNN3YQp8ibv2vAx8Q>
    <xmx:FBhdZS_5Tip1GjnM1zEBLlMs0IpnX3jgIfJm5Zwj5afNGLLs0bv04A>
    <xmx:FRhdZZlGtqkI9j2MZm37kRSum3T2kxxn-j1ijq0Hb-LRE4zG_SjBJg>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id B01A9BC007E; Tue, 21 Nov 2023 15:50:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3cdecb2e-ef70-4171-8c36-edf46370d74d@app.fastmail.com>
In-Reply-To: <<20231109174328.1774571-1-anders.roxell@linaro.org>>
Date: Tue, 21 Nov 2023 14:50:07 -0600
From: "Daniel Xu" <dxu@dxuuu.xyz>
To: anders.roxell@linaro.org
Cc: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>, bjorn@kernel.org,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, linux-kernel@vger.kernel.org,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 netdev@vger.kernel.org
Subject: Re: [PATCHv3] selftests: bpf: xskxceiver: ksft_print_msg: fix format type
 error
Content-Type: text/plain

Hi,

I'm hitting the same error on bpf-next/master for native x86-64 build:
3cbbf9192abd ("Merge branch 'selftests-bpf-update-multiple-prog_tests-to-use-assert_-macros'"

Applying this patch helped.

Does this need to go onto bpf-next as well?

Thanks,
Daniel

