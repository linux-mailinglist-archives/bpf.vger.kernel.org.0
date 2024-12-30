Return-Path: <bpf+bounces-47706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA799FEAAF
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 21:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C9173A29DE
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 20:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B74A19AA56;
	Mon, 30 Dec 2024 20:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="T6dWqOKU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yVNUab7W"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D41D23CE
	for <bpf@vger.kernel.org>; Mon, 30 Dec 2024 20:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735591568; cv=none; b=fMGeioCJRsA06vhAWQ554aoLF4AgOv5WMo2glJVRlMqG1yhgCBGPXUu+N/pqhlFZHs61puPYXKfkOqh461jC82OhYl9ZkmQWszCu7aHwRjoIk6NOSm0f8ETQc0yz0CSBe9O89t+SEEzQQgbNcTafyqZUE4b3Le+xwGk7vhnxkwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735591568; c=relaxed/simple;
	bh=lm73R+QfAG2AOytuwh/Pd8qtnJoPkvrlyAGdxkq+Nfs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=b0iTKD+6esoHssaCyLNrrxQrk18GMJPbkoXG+o4f5mvA3zjw8fTV/RCge6z4ehk7Qlmf0SjY1EW7SdkbcLLwUkXATqtwc54yyyfGiDhLUQ9m8PkgNHiyQU9vCy1iEL56XL+Xc0BZxnnpNPc8PizqVTwZO3VoQPtkk3NFiDw/5DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=T6dWqOKU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yVNUab7W; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3CD8D1140231;
	Mon, 30 Dec 2024 15:46:01 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 30 Dec 2024 15:46:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1735591561; x=1735677961; bh=lm73R+QfAG2AOytuwh/Pd8qtnJoPkvrl
	yAGdxkq+Nfs=; b=T6dWqOKUyKT0NE41W31s46CquLwB+K4Pmd8TYYxh0Bct4uoR
	C+VZfCvYXepRlbuMCawjAKEeM8+n3XlY8H/1LRo/QTIiNB4Wf1Xu0APHte2lkgsx
	VhhXDz4bP1DmrXbSESFhVbHhp6CTMUe1UHxySoZAiWzh/UWZvDDAKj8CXpBDm5VV
	J4CfECzzSmHc0OOLW6R+wq4cGJwlBtVEkVgStFw62ln0ANorvwugCg8LSCXBnBzR
	hiOEszguuC1/sjdjkcEquo60pWWvyVG83EABOkWwmyG2FdF407m5sdeAnAQbJoyB
	v85ZdeOatjFPEtROsjwp9V5mNoP1UgTqhAPRRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735591561; x=
	1735677961; bh=lm73R+QfAG2AOytuwh/Pd8qtnJoPkvrlyAGdxkq+Nfs=; b=y
	VNUab7WkqB84sCctV2FjbTujkIFUOW/8/ZHyvH+myiASx6rMzcmPMkxFxMWwFtAr
	EWNTFPTecmyMRjeMO41tJXlvoxDkbFRILnMQr8sYeXxCOqe5JraT0Z1mI19HzTcP
	ysFI998LCi3HlNIvN84yeKy7XjApjL2XWk+CSJB/SFfJ/wP6N0+UsEt6lL+DcpM3
	0j1vV07hYclFERD1w8puoySKpl5a1YoahAO/kFc37j4/Mbpyxll8e1x7Us2JISl0
	MuCYzvtOg/CwVGaZ+w3peuuS4w3mAM0Fm9wgqnwtlNS6p4qYB+E9PAdtyNoUczwN
	/eM1MzR6EP+0opJFpudUQ==
X-ME-Sender: <xms:iAZzZ6vooHK0r6T4jOWJXsZo22_ubsW1w_iHaEKFv72RVHCQo-Qunw>
    <xme:iAZzZ_fOJm9VKcVylQZrKaPQq284T3ZXrQX8W0NLm8QYzNscLO0hAE-iADFh47q_e
    Hq2Kae332wHFpRe3w>
X-ME-Received: <xmr:iAZzZ1xhjCbtjSbRx5PNxtgbpuHLv_XPrwemgcDVcIBjpnJu7cCZVD3JbkRC3dwn9fI0dAHBFQL_vkYiAKKMa4gUkvT35QWJqn9fn35RmGu--g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddviedgudegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculd
    efhedmnecujfgurhepfffhvfevuffkgggtugesthdtsfdttddtvdenucfhrhhomhepffgr
    nhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpe
    fgueelgeeghfffjeejteelieduhfehteehveehteduteeljeehleduhefhgfevheenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihiidpnhgspghrtghpthht
    ohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehjohhlshgrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:iAZzZ1OI8VZ2nKYkXGmpG2TsQ0UG10JxNGqpTVskbfr0hacFH01w3w>
    <xmx:iAZzZ69hGehjnhgYqhBKFeU8sMKnjNqgQEn72ArRYty6ACtK7LzzOA>
    <xmx:iAZzZ9VtzPAJ-E_yeN5vKkJrcvOF1G722uT34FnxwYjIoW4ChazzPg>
    <xmx:iAZzZzezsZpCPz2a6tKpME_ebt06qymcNJ5RjD76eTk_JbbPjaihaA>
    <xmx:iQZzZ8JVBztPZvU5ZiV4QU-HnPUkAKM436B-hr-MILsHEN7cYb-jNHX5>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Dec 2024 15:46:00 -0500 (EST)
Date: Mon, 30 Dec 2024 13:45:58 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: bpf@vger.kernel.org
Cc: jolsa@kernel.org
Subject: d_path() truncates at front of path?
Message-ID: <pv3zr55lja6lumu7iilsdtbujd6yq6qxsrxssifeqh6tmcmzii@5kkyaajllr65>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I was poking around bpftrace test suite and noticed that our d_path()
wrapper is truncating at the beginning of the path. See [0] for an
example.

bpftrace codegen doesn't do anything fancy here. And I see in the kernel
d_path() implementation there's some prepend logic going on.

I wanted to confirm this is the expected behavior. And if so, whether it
should be documented.

Thanks,
Daniel


[0]: https://github.com/bpftrace/bpftrace/issues/3663

