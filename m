Return-Path: <bpf+bounces-62501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BC3AFB585
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 16:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 279317B3728
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 14:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F7D2BE04E;
	Mon,  7 Jul 2025 14:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DlgsqkrK"
X-Original-To: bpf@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D506928934C;
	Mon,  7 Jul 2025 14:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751896934; cv=none; b=CF4MJ8uMN2PT5obAqS+nCKLGDXh0CJt6elMpiOAaFNsRsr/xC4bj63Cfxn1whdm18JYytgxJ9Hjk4mFxLEFz6jHJZP5CitvtPSO5oUcYmGaeAu5qJ918wpLgWOSusJ/bRx5SzKsV8z8N1fzveFUrItY5F7LXa1aC3u7cVaelecM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751896934; c=relaxed/simple;
	bh=n6SS0rqFQzpXTPDDFGetfqR6z2jRkeScw4vhZ9JGHX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jr3qVzh46fCHMxn3xR340PyIiaFuX3BFLwEDhM0FFYQdD83L69zc1QiSJPF5I1M2Si6O4a+doi2F7ZyR+Ydglc2JLEibP+jwtSU/NiR2rudWHUCZOZDoXpbEs+Ae6ivGYdopa2NecuZfTlRpLJJPSGk10Em+U22qCy/HhFRg+v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DlgsqkrK; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BE2DA443D0;
	Mon,  7 Jul 2025 14:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751896931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y9sq7urvPW68KTuA6tJJVHtN8g3ty/sAZ5XSjbouT2Y=;
	b=DlgsqkrK+AzC7la7Irjwy9Zt35HiXVUS0JLDh6JhMCnuoTeTguxPKPfy6ApzGVz4FYheDp
	RmdHJteQzWDeaMbPx0sD9/NWPRWY5C1MYIPjfm7Kab0gKT0S7DO4JfriC1NzQA+OvPGNuh
	aou9TrOsRbg4IdQFEfa8yM2Wav0mOebGBsMcn3xEvbRNCY0MGcAB/kfVK5H3GW+NiePzw0
	1uvwwfMOHDrm2L1qI5kLbZxPbUSNNriRDSbs94vgVC4zrzGvhDZ61vYSyuzgGmwODj92G5
	I8pvSfQkXkx2rxMaqTLfRN+PNXu0TY6CeQjWYT3PWc1v7MkOJ6W3b3HNEFksAg==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Mon, 07 Jul 2025 16:02:05 +0200
Subject: [PATCH v3 3/3] gitignore: ignore all the test kmod build-related
 files
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250707-btf_skip_structs_on_stack-v3-3-29569e086c12@bootlin.com>
References: <20250707-btf_skip_structs_on_stack-v3-0-29569e086c12@bootlin.com>
In-Reply-To: <20250707-btf_skip_structs_on_stack-v3-0-29569e086c12@bootlin.com>
To: dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Alexei Starovoitov <ast@fb.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, ebpf@linuxfoundation.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefudellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrroculdgvuefrhfcuhfhouhhnuggrthhiohhnmdcuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepleejkeetffefveelgeeklefhtefhgfeigeduveffjeehleeifeefjedtudejgeeunecukfhppedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemfhekhedphhgvlhhopegludelvddrudeikedruddrudeljegnpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeelpdhrtghpthhtoheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheprghlrghnrdhmrghguhhirhgvsehorhgrtghlvgdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtp
 hhtthhopegrtghmvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvggsphhfsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepugifrghrvhgvshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheprghsthesfhgsrdgtohhm
X-GND-Sasl: alexis.lothore@bootlin.com

The kmod module generates quite a lot of intermediate build files, so
ignore those in git.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v3:
- update dropped files names, following changes in previous commit
Changes in v2:
- new patch
---
 .gitignore | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitignore b/.gitignore
index 96e05c7842624067ed5571bccbaae76122a66567..98fdf13b96225697b5d58126af17c92af487ed6f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,2 +1,5 @@
 /build
 /config.h
+tests/bin/*
+!tests/bin/test_bin.c
+!tests/bin/Makefile

-- 
2.50.0


