Return-Path: <bpf+bounces-62244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E47A8AF6E1A
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 11:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49161167B0E
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 09:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8DA2D4B75;
	Thu,  3 Jul 2025 09:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AOvwN/C8"
X-Original-To: bpf@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A75B2D0292;
	Thu,  3 Jul 2025 09:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751533377; cv=none; b=Iryr7f6pTcnCdaBi/Ob/vrhjfvqnOlvt3cDnReJRRZGpfQQFjU/v90hSBO9PUCKtAI0DCnpvWz0LeThjTXViLuzQwovSvMqw6+KnTyc/xIpOVTv1AsJhYFv5LF+oiRMx5aapx6071yQULwfJuSUy7aglkNAZsshflDlxVlCcPL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751533377; c=relaxed/simple;
	bh=EOrZnYUy6WTOIt2vP6q9T9T8LYeYmLQzYHtHeFXEbiY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QHHOnhpG2dB1IMmBARMvUBADPz3GE2n9MzSLJqCZPpYzoCA42SqtwaOjjc9m/AUMlgcgGR3lajnGgKA9xEK6OOyCib/t1QK60YQU2y0JoM9l0fqkimZX4S0eA461QQLAxtWVaBIQo0luggL4fMF344FeujjPZj6V7FvK01eVBSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AOvwN/C8; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 07D9B4330F;
	Thu,  3 Jul 2025 09:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751533367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y/oun4zUAh+IdTnEFJSGV6HxMB1qCD2B/FYd0k9Cxtw=;
	b=AOvwN/C8T/Sp6LO4i4hAwE0B8qRUY92dvPbYqv2Tdnc/GjipytsMENzn9SKfgbbDGNIw4j
	qRthGQLFwtXlMwrNuve/ezCJDr/IhxPy6Y8tjDI+xqqWMQMTngO1CBeitqvfrOYAmouxzu
	eS75g5uy7TfBqhsYtkM4DPPbVj3KpBBeSFmKJlXfPRbppcaO1n8ZaKnt3IHHjDBrF4tJ5A
	tmKQ/xnpecbProfcvpA8W0wDlIRWRxzz9WGwXHpo7LSRtHiOIw4mBj87CuiUfRlNZh+Ooj
	okaE9vAleAWEkeqKEuRmTiZnBhSv3qE0ToEo5n7ikr5SvARJ0DaCVOhjt7sY3Q==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Thu, 03 Jul 2025 11:02:34 +0200
Subject: [PATCH v2 3/3] gitignore: ignore all the test kmod build-related
 files
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250703-btf_skip_structs_on_stack-v2-3-4767e3ba10c9@bootlin.com>
References: <20250703-btf_skip_structs_on_stack-v2-0-4767e3ba10c9@bootlin.com>
In-Reply-To: <20250703-btf_skip_structs_on_stack-v2-0-4767e3ba10c9@bootlin.com>
To: dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Alexei Starovoitov <ast@fb.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, ebpf@linuxfoundation.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleekjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrroculdgvuefrhfcuhfhouhhnuggrthhiohhnmdcuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepleejkeetffefveelgeeklefhtefhgfeigeduveffjeehleeifeefjedtudejgeeunecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrvddungdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepledprhgtphhtthhopegvsghpfheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegsphhfsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepugifrghrvhgvshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrtghmvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghsthesf
 hgsrdgtohhmpdhrtghpthhtohepsggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrlhgrnhdrmhgrghhuihhrvgesohhrrggtlhgvrdgtohhm
X-GND-Sasl: alexis.lothore@bootlin.com

The kmod module generates quite a lot of intermediate build files, so
ignore those in git.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v2:
- new patch
---
 .gitignore | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitignore b/.gitignore
index 96e05c7842624067ed5571bccbaae76122a66567..b82205d4ee2d0a83ac736c3c879d46d44e0212d6 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,2 +1,5 @@
 /build
 /config.h
+tests/kmod/*
+!tests/kmod/kmod.c
+!tests/kmod/Makefile

-- 
2.50.0


