Return-Path: <bpf+bounces-64983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCFCB19C06
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 09:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDD1316C9CD
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 07:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51224233D9E;
	Mon,  4 Aug 2025 07:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GYHu/wW7"
X-Original-To: bpf@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC26230997;
	Mon,  4 Aug 2025 07:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754291631; cv=none; b=mRx3Y+NwxtKCFeUiU1nLdkRNeY31lT0NzaZNqRhmCMv2sUkaRwi3UWiKCp6W9kNWmjVbrBRfKkjObH6B+3dPERfh9n2d+nqK17KtdPM3iof/Cs3kGobEg0VM2ye+E1w1i6zpnmdKXP7XbIimBCCx2a+qsRs9xT0NlmjFFHYInxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754291631; c=relaxed/simple;
	bh=wM2IiWzILJXwecgYwglk8FGvEq1slYAEyqZ3qEKBSAE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=okIGQhH8SwlHsHSCBPvNxuGUdWfoY0bhuD449v0Bls0uegcts59YL7XV6FRSG8qsX3ZOsvhVlXBtdvD5OjfLvfpU7JbgtCgYHzxL4DxJ8nkNSAvyM8vl93ms+dIX4afmxRK08zCVCPpM11IzzzTakDZ8Z9RCx3VUioFj7AjKK4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GYHu/wW7; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 185FC4426B;
	Mon,  4 Aug 2025 07:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754291621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wM2IiWzILJXwecgYwglk8FGvEq1slYAEyqZ3qEKBSAE=;
	b=GYHu/wW7fmlR4/gXi/DunVdIVcBtnooUJeClW5Pvrp7mZOO6AeSzgZzvTa7lzsYhKGGNGN
	hZFPRVxkMmbtTiD+Fj0Nk7+Mc6BilfhNzQoGUbp3KnadC6bODKIwcHmexaI/Apo8essr8i
	PVdOZvrOo4o18iwTPkiCtEAqkGEmZfQ4CDydGd2epbxQmcMzR2MW1nIyiO4EsEthUI/wBD
	HBoIdl5LBn8mbCmqM/pDEY1kurYrkzoz7RljSS0wkBr5QOhBd3smEvjkl4BIn4wuku022Z
	ao1DYayZCTn2C2TEvkE1zRt2bHzO+6XNlPZS7lsHLEjt7wIo9MGTKnTvM2vmEg==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 Aug 2025 09:13:40 +0200
Message-Id: <DBTGH8VGCJM5.160FSRY06LNUC@bootlin.com>
Subject: Re: [PATCH v3 1/3] btf_encoder: skip functions consuming packed
 structs passed by value on stack
Cc: <bpf@vger.kernel.org>, "Alan Maguire" <alan.maguire@oracle.com>,
 "Arnaldo Carvalho de Melo" <acme@kernel.org>, "Alexei Starovoitov"
 <ast@fb.com>, "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Bastien
 Curutchet" <bastien.curutchet@bootlin.com>, <ebpf@linuxfoundation.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>, <dwarves@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250707-btf_skip_structs_on_stack-v3-0-29569e086c12@bootlin.com> <20250707-btf_skip_structs_on_stack-v3-1-29569e086c12@bootlin.com>
In-Reply-To: <20250707-btf_skip_structs_on_stack-v3-1-29569e086c12@bootlin.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudduieeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkufevhffvofhfjgesthhqredtredtjeenucfhrhhomheptehlvgigihhsucfnohhthhhorhoruceorghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeegledvkedvvefhvdfgieffueeileffgfeliedvleehledvieevteeftdeitdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeelpdhrtghpthhtoheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepugifrghrvhgvshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsphhfsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlrghnrdhmrghguhhirhgvsehorhgrt
 ghlvgdrtghomhdprhgtphhtthhopegrtghmvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghsthesfhgsrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepsggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomh
X-GND-Sasl: alexis.lothore@bootlin.com

Hi,

On Mon Jul 7, 2025 at 4:02 PM CEST, Alexis Lothor=C3=A9 (eBPF Foundation) w=
rote:
> Most ABIs allow functions to receive structs passed by value, if they
> fit in a register or a pair of registers, depending on the exact ABI.
> However, when there is a struct passed by value but all registers are
> already used for parameters passing, the struct is still passed by value
> but on the stack. This becomes an issue if the passed struct is defined
> with some attributes like __attribute__((packed)) or
> __attribute__((aligned(X)), as its location on the stack is altered, but
> this change is not reflected in dwarf information. The corresponding BTF
> data generated from this can lead to incorrect BPF trampolines
> generation (eg to attach bpf tracing programs to kernel functions) in
> the Linux kernel.
>
> Prevent those wrong cases by not encoding functions consuming structs
> passed by value on stack, when those structs do not have the expected
> alignment due to some attribute usage.
>
> Signed-off-by: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@boot=
lin.com>

Gentle ping/follow-up on this series. Most of the discussions on this
revision were about an unrelated bug that has been submitted and merged in
[1], aside from that Alexei and Ihor provided some positive feedback on the
current revision. Any additional feedback on this ?

[1] https://lore.kernel.org/dwarves/20250731-lsk__abort-v3-1-40f79e168198@b=
ootlin.com/

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


