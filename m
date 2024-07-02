Return-Path: <bpf+bounces-33637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED3D9240BA
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 16:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 812B01C234AA
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 14:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8027F1B5831;
	Tue,  2 Jul 2024 14:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yj9wVabw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5UG/K2MW"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F341B583E
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 14:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719930349; cv=none; b=hDMsQQKncR23ae8g1yVVD2Ilt+zxAENNV9tOWIGXFOnNiKZJjynTVIivAlobBfyQPzFMhpcZ3P5m4NaB5gEpfkQtwIng43JJAxt8vm2bAAj+I3TvBChFhBBfIoj3WlkDlo6w4IbzaLFfMLfggsSxWP9hw57xsMZwPmw7d+PdFdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719930349; c=relaxed/simple;
	bh=j6WHCk9OKVYlr9oFjSSlk+L4eqR8DfRcyefWOpTjp0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PiorrMlQsckPQ0JszhiNV+/9sn7ZRW4kV8arJYbcR5Xz9TRnMINUslpRlwcsjeVU9OC6k+MtUMgJl+96WFWNN2TrpcBdjpiRqbvmzRuV+/MsWZfUyGW0gr+Im7xxoEGND4GMyFTrgvk+ZvGwe8O2EV17QHek+YGfVzSerP7YPVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yj9wVabw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5UG/K2MW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719930346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jYL9oUdaHZpTvIFVGaVLACS6rYjRaVdjtiTGco/6ZxE=;
	b=yj9wVabwzhpFxN/0RgWmTRnMmRCIUwxTm5l0obKbyMTDDxSite/0Lax7CpP50PDqvKe/um
	cfcyn/R/1fQzqPrKukYDJCTIMTEn181iSw3CQDLQUBNbBxJqK8zLq/UMNzLgbzat5am6vf
	BfQvDum9qm2rBP9Tx52mKGVchzuuO+85SGiVHyz/9y9WJIjXrkjoAbyr0lsgSkseTs37Pn
	CZPu9p+HOsUvFzKhLD+4mq2TRqFSEfcpEuzUTwgm/gBv4oEJZxbMrX/Pw1eUFIuFdbDLPB
	EgC+4EKkAoI84qk7l/AWcMO+x2RP548mCNCNzdIjSA7wlmfZhRTek7mxwRFM0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719930346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jYL9oUdaHZpTvIFVGaVLACS6rYjRaVdjtiTGco/6ZxE=;
	b=5UG/K2MWh6g8zYCH4y5HqKw5hGrdd9DbRchvY+SK95QJZKuMsYrgqDNa3JoNdG0MLsLEDv
	sz4AwJoE2WI8UkCw==
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH v2 bpf-next 0/3] bpf: sparse cleanup.
Date: Tue,  2 Jul 2024 16:21:40 +0200
Message-ID: <20240702142542.179753-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

after my last bpf series was merged I received a robot mail because I
added yet another sparse related warning.
I tried to address most of them, a few are left in the category "missing
prototype" but the whole block is marked as "ignore-warnings-for-gcc" so
left it as is.

v1=E2=80=A6v2 https://lore.kernel.org/all/20240628084857.1719108-1-bigeasy@=
linutronix.de
  - Accidently posted the wrong version while editing 3/3, leading to an
    compile error. This has been corrected.

Sebastian


