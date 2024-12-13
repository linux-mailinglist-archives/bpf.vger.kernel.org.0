Return-Path: <bpf+bounces-46801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 724B89F0221
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 02:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3328B284643
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 01:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E3F4A2D;
	Fri, 13 Dec 2024 01:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="ZzKNWCRx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S3ZUNfug"
X-Original-To: bpf@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C3D3D0D5;
	Fri, 13 Dec 2024 01:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734053078; cv=none; b=pr0ikbupiywcXJ/P8DGQphiTiCz1afIFffR0HfZdb930rDBw0VQZO8fCniIvY5uYSVR5YTFUZJSIZh6ytZipDad6Uzgow3jgk95UkzIgm2CdN/wbHIursr3XryITk6kqokaRP4Bw3V5WSFTypQboiPoEtte97CM913+cln/jV3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734053078; c=relaxed/simple;
	bh=tIaQGA6ru209wj2zRo7/LOYxSSw8NE0ffGbyi5wMNY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A+b/9dnic8vSe0CHZic40r5Jb3g20jA0h3KJX8Iwmd2g5HV8qI1Io10SxYe90JjTo7x2/4UVrsuxpyTcIbBnUBnNFPhVW9qmq9wNRyIv0uiYVeQSXAWWsa4xwWacsjJvfr0FUcBeqpdSF2p8H9+nRu3JOTf9YwxFncJ3OGb1zg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=ZzKNWCRx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S3ZUNfug; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 5B87713841A1;
	Thu, 12 Dec 2024 20:24:35 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 12 Dec 2024 20:24:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1734053075; x=
	1734139475; bh=xpRdN0TuD11EDsUB/g43WYAhnnZK310+Kd5LiZ2xWXA=; b=Z
	zKNWCRxh0Pj1j5226hK8mLCFETaVhB1I3IHyro5/MqrTN3IxtvRMDWySNrklKd5Z
	zoHEsDHH9HPVG+h51wXVwoSnhY20TaiI34OphQ/4mahZtzJ9CRBEGEYp05fDNbQf
	5F96grkTNEAFayDRsCWcFxz9FfY3mFYokxvgG75uGTQ/PKgFLEt/P7ctASkemc8D
	+F+xQyF3FLjMeEn5hSdrqLxXYbhFn3CGatvIgO3bK7VRAHU28NTq6w1TRa75mGJ7
	Ug+0QLg9VaNJH6gl5l85uQeivFglO1s9kV0z60cIYPL7eYAg2AZVZiM1GwXQzFu/
	VVsK9/kingErW0/74ZkpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1734053075; x=1734139475; bh=x
	pRdN0TuD11EDsUB/g43WYAhnnZK310+Kd5LiZ2xWXA=; b=S3ZUNfug7iLzSPtku
	IG4p/oQ6kHtVIxZQilslRWJ2tacDK+9HmtygC1NR0Mu57wOi17KGqei6uryOV3w4
	0if+NM0A3HRPfad72AEw/gN9XrtqoGtVrN9K6vC0s+NcfDtxxkJA7D172UIUn3Yc
	MkWMuBhRdU2GlTTQ4gxuhBlNaDf1lWYQkn+LxCjimw1TXcuGxSZbyNqctjo6IpqQ
	szJNRvZPQCojwKnFPHYYtAqptdF991DwRn7txPZt5rxW/oCP4Uo2Gx89cjZYwstf
	e//RJG6e/RVMyzx3dG7zr6DSKHyYuuGevIIxEZ2uCX83UGcG+HlfWPso9K4GRCWu
	k5LKQ==
X-ME-Sender: <xms:04xbZx7FL6E0uNIrA0fyvdXbXvp0plFTiF4mqIHKSVq6Rfd3KLgjgA>
    <xme:04xbZ-79DZC3w1AOilTLpEBgHU4Q_4W9zFmrV8ICGonSC3h90wVAoHX0lRtjfomBg
    CbwNkyNFHyHpJi4Pw>
X-ME-Received: <xmr:04xbZ4dK4VonHq13mx2MUMpdEaNY0QJYrUZ9HWNjG6qKWSrllruI9te9qwSL2PqJHj6ooAd2eLSkGsIVV4wzHWJTzNWOFRXjv4j4zsOvk0T4GSa2fiIC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeeigdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtd
    dmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgr
    nhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpe
    fgfefggeejhfduieekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugi
    huuhhurdighiiipdhnsggprhgtphhtthhopedukedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshhtse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehqmhhosehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopehmrg
    hrthhinhdrlhgruheslhhinhhugidruggvvhdprhgtphhtthhopegvugguhiiikeejsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepshhonhhgsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopeihohhnghhhohhnghdrshhonhhgsehlihhnuhigrdguvghvpdhrtghpthhtohep
    jhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:04xbZ6JxOSZRSbH3v8paqs_ALT_gYCloClsHGqGnVZF1GiZc_s39kA>
    <xmx:04xbZ1KyKFyXDA_-dlEL9ZO3OYHBAZ2RX0YROoHS0rN0teIeMJS0Tg>
    <xmx:04xbZzw1CM4_9PXsAuhzD0qSH9zZtsict9gJzoHqqR42-LDVLblpZg>
    <xmx:04xbZxIkQKdNB0mBys__3tNkuZh9hbWZAWAfDYWMe6rDTJzX92vKCQ>
    <xmx:04xbZ6Dyc9rQ0uvrhZU-NXJKKp2BnkFC7xz_CBDbgAEXAzrqiR_OiIvH>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Dec 2024 20:24:33 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: andrii@kernel.org,
	ast@kernel.org,
	qmo@kernel.org,
	daniel@iogearbox.net
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andrii.nakryiko@gmail.com,
	antony@phenome.org,
	toke@kernel.org
Subject: [PATCH bpf-next v4 2/4] bpftool: btf: Validate root_type_ids early
Date: Thu, 12 Dec 2024 18:24:14 -0700
Message-ID: <5b5dbe4219d051f0184b8f40e35f47512ebde07a.1734052995.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1734052995.git.dxu@dxuuu.xyz>
References: <cover.1734052995.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handle invalid root_type_ids early, as an invalid ID will cause dumpers
to half-emit valid boilerplate and then bail with an unclean exit. This
is ugly and possibly confusing for users, so preemptively handle the
common error case before any dumping begins.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/bpf/bpftool/btf.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index d005e4fd6128..3e995faf9efa 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -886,6 +886,7 @@ static int do_dump(int argc, char **argv)
 	const char *src;
 	int fd = -1;
 	int err = 0;
+	int i;
 
 	if (!REQ_ARGS(2)) {
 		usage();
@@ -1017,6 +1018,17 @@ static int do_dump(int argc, char **argv)
 		}
 	}
 
+	/* Invalid root IDs causes half emitted boilerplate and then unclean
+	 * exit. It's an ugly user experience, so handle common error here.
+	 */
+	for (i = 0; i < root_type_cnt; i++) {
+		if (root_type_ids[i] >= btf__type_cnt(btf)) {
+			err = -EINVAL;
+			p_err("invalid root ID: %u", root_type_ids[i]);
+			goto done;
+		}
+	}
+
 	if (dump_c) {
 		if (json_output) {
 			p_err("JSON output for C-syntax dump is not supported");
-- 
2.46.0


