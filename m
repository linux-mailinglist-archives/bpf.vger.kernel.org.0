Return-Path: <bpf+bounces-47711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFC79FEB33
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 22:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96B933A10B1
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 21:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9917F19D065;
	Mon, 30 Dec 2024 21:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="Z9kMB4JL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QQXG8hyS"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089E01991A1;
	Mon, 30 Dec 2024 21:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735595748; cv=none; b=Tcbq5J2r9hkd4E8d0azjs0XC4DY+7iSOrJMGToVT5aObVPPHbC3LvtnJK0fwg643d12hxTIxqWAU7e9E+JNqWD8h+A6157dhUpW+FvLm3DWCBpM79fzJUxn+cCckvNjZ1v4IRtyrl93gRxV7YJqj93IauA06xUt5lodhf45QUWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735595748; c=relaxed/simple;
	bh=xgF+xOC/kBe8/Vxcejq3gV1Nnp2wKLnRCo54wahkvLM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UCpAZPI5DZ53tgIZRowFPjV8/dmSZoubJE8DrnN0Fbr+BmKrwIMI+bPpLnXNdt+IJgjUqJOCE8+E4zPv2RiNuf2vu/DQtLmo6CJ3FRhEzByNKI0EmvQ1FQFrfw1kmj6YCBIhkleSxA+GUhQUsWYrTdSiTZDf/QcQzwLzD7iOYeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=Z9kMB4JL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QQXG8hyS; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 288C81140192;
	Mon, 30 Dec 2024 16:55:45 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 30 Dec 2024 16:55:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1735595745; x=1735682145; bh=7Pwq3XV4jVYvKT9S0lpps
	RzyfAcuvDaCl+vev4IDot8=; b=Z9kMB4JLuom2w1rKFvv5VW6+QB8HDtq0Emgk8
	7SSWWh/zjle4AS5xVYc1HtM5TXj5/gdlh3J/LxXukPSHAs9zUI3uuPJ10rAKOKvg
	2rNzxsMw00nxBUhK4YJL21bgbxfzT22cmrq4fXGyDtrBw2nvE+1RlTXs6yQ7i4T3
	7X6UpRzrGdwQPB9y5PzkEoX0visGJPTxV5bxzWPQwqEGZCHnynnaEyMMAXnYxcho
	t63Z7aIiJbfBlxOq9Yzhwi4n3y5mSMdnTR/Tay5xtl5JGorcCQU4FHd1qiJJwo67
	Kui7aAEj8WJK8c5tKju+fLH4PqbRERpMiZl21EDMDYKwA6w8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735595745; x=1735682145; bh=7Pwq3XV4jVYvKT9S0lppsRzyfAcuvDaCl+v
	ev4IDot8=; b=QQXG8hySFxTNUwwLWFHOJFIs+ZIrdz5vf+Aw2SM4E8TnsJPteBE
	lilbVffFfGDpMTttHG3lGQajyUfiNLfJ96JOOlDW3VHIz+k3hlI2z5VZDcrCrmyi
	OHuP84nPylwc6CkPS1szWUR4BGso/CHbY4c/dDf41Z6Co29oENHXWsCysULugrby
	G7+Yqpwtx2Oab8dbtJ6UyQyIjMKCddorIDoC6+xCGUdgOje1rqXdfXcoToNWmPaJ
	5WCXFeGGSZIj1W9TGPeh34CK0BYYESt0mPNsv6m8C3KrRUoUoT4zIv74gHc9oxlp
	EL3VBRmqO2K4sYAIWHYM47sa4M03eJPdVAA==
X-ME-Sender: <xms:4BZzZ7N6lc-lI1eEtuVE8pGc23-3LghiDeAcgYhy9Gnv5zJzZdsEnw>
    <xme:4BZzZ18s3E3f4IwRQuKaNXcRWl_xfaMP7VYKgUGHt96bxU0iCOFxv9XAzi3xk1j_g
    yzucmeBC5Q_WuT6vg>
X-ME-Received: <xmr:4BZzZ6SWkDfou_qBmz2vR6XQHLI8hhlQfe9JAwIk8yrwUh4QqK9apMXn1joNNZfd18Lzn39we4CJJUyi5SRyiN4DafqaR1iIrIdd0-aWOvlkDbqaGILH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddviedgudehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculd
    ejtddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgr
    nhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpe
    dvgefgtefgleehhfeufeekuddvgfeuvdfhgeeljeduudfffffgteeuudeiieekjeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugi
    huuhhurdighiiipdhnsggprhgtphhtthhopedugedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlse
    hiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehmrghrthhinhdrlhgruheslhhinhhugidruggvvhdprhgtph
    htthhopegvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhonhhgsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopeihohhnghhhohhnghdrshhonhhgsehlihhnuh
    igrdguvghvpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepkhhpshhinhhghheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:4BZzZ_vn-ut3xUGuy4o6taWqLEOpn1T1x24aAYvNxpEdT7aSuQxoOQ>
    <xmx:4BZzZzcM6KdXGhkxjjAFRd7qqhz8TG9GBRpqM33XXfjhSNKb94Zjtg>
    <xmx:4BZzZ705YW5RB12M3mOcTRiNBOdjs_oWmNX8PCUJ65Z0VB2dn9WtVA>
    <xmx:4BZzZ__0Hux7Li-nGjfe6szdOLxQDVQ6vMg6qaKQdvgn6dEU7LbeXw>
    <xmx:4RZzZ-38hUV7d2XX0-yiYzbOAm0GAgzApbBvrnKDiisHg_J9RnFIsR45>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Dec 2024 16:55:43 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
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
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpf: uapi: Document front truncation in bpf_d_path()
Date: Mon, 30 Dec 2024 14:55:11 -0700
Message-ID: <505ee6e414ee701c9ea899220154d1ec3a1f647f.1735595687.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_d_path() will truncate the resolved path from the front if the
provided buffer is too small. This is somewhat non-intuitive but makes
sense when you think about it. So document it.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/uapi/linux/bpf.h       | 4 ++++
 tools/include/uapi/linux/bpf.h | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 2acf9b336371..91218c5fd207 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4845,6 +4845,10 @@ union bpf_attr {
  *		including the trailing NUL character. On error, a negative
  *		value.
  *
+ *		If *buf* is too small, the resolved path is truncated from
+ *		the front and -ENAMETOOLONG is returned. The buffer is valid
+ *		in this case.
+ *
  * long bpf_copy_from_user(void *dst, u32 size, const void *user_ptr)
  * 	Description
  * 		Read *size* bytes from user space address *user_ptr* and store
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 2acf9b336371..91218c5fd207 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4845,6 +4845,10 @@ union bpf_attr {
  *		including the trailing NUL character. On error, a negative
  *		value.
  *
+ *		If *buf* is too small, the resolved path is truncated from
+ *		the front and -ENAMETOOLONG is returned. The buffer is valid
+ *		in this case.
+ *
  * long bpf_copy_from_user(void *dst, u32 size, const void *user_ptr)
  * 	Description
  * 		Read *size* bytes from user space address *user_ptr* and store
-- 
2.47.1


