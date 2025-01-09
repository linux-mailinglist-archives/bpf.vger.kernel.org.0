Return-Path: <bpf+bounces-48351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B37A06C69
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 04:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C91D3A6340
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 03:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566CB152E12;
	Thu,  9 Jan 2025 03:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="E3gSkZz6"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95146768FD;
	Thu,  9 Jan 2025 03:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736394152; cv=none; b=d7TZ3QSdOfHCi4ga46krgIyVhD87gNcShSp/fs94VDV8entlxXsDdVQdSq1lWjeGBM0ocIABUa0KDj7TZhRd8uV7KTzbj6mG3icUnoZc1jki8gCW4liZJMvdlHiVWJb6aPQg7bM6LPMTxDhHykukbTYhQKdTMwUhrwmowDaN6QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736394152; c=relaxed/simple;
	bh=RJmrHncmAiYfQZgHBbGZ9N6pX/NJqX1TU++10eqVLQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EbaMn4tLN6xAZbK3I7AF6IYC73YoZLNG1v8cKoemn4YiqsMUc2ftASFSIl65rHSCXAojVoyp/h7+OKs9UnF2YbxTiPL/VnUUJCbgbKmSXEnG7agX9Tone9cQbLjryVjcNrKTFSpf55S77NbQA8w41sN63T7cII0GAcKuHu/qr7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=E3gSkZz6; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=W1HRi
	UHKkNK4KFvLch5WDTwcRDvo+NOPbJJW0YrzMOo=; b=E3gSkZz65S9UfMaBWsFCI
	jLjAPf/vESCmPCUVnz5P3bWNIU16Z5uETQHSxJ3cNTRFmS6kATjumOQioVKRPFCw
	nnoza+ZVRXOlVelEQVCwJQxTBDhdXZbudDzQJHafgyp8QOtuKsdL49EoBu2+6X8z
	Re/5NQVQl9cjc2yzmT2GrE=
Received: from localhost.localdomain (unknown [47.252.33.72])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAXYaYcRX9na6O1Jw--.42275S5;
	Thu, 09 Jan 2025 11:40:55 +0800 (CST)
From: Jiayuan Chen <mrpre@163.com>
To: bpf@vger.kernel.org,
	jakub@cloudflare.com,
	john.fastabend@gmail.com
Cc: netdev@vger.kernel.org,
	martin.lau@linux.dev,
	ast@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	song@kernel.org,
	andrii@kernel.org,
	mhal@rbox.co,
	yonghong.song@linux.dev,
	daniel@iogearbox.net,
	xiyou.wangcong@gmail.com,
	horms@kernel.org,
	corbet@lwn.net,
	eddyz87@gmail.com,
	cong.wang@bytedance.com,
	shuah@kernel.org,
	mykolal@fb.com,
	jolsa@kernel.org,
	haoluo@google.com,
	sdf@fomichev.me,
	kpsingh@kernel.org,
	linux-doc@vger.kernel.org,
	Jiayuan Chen <mrpre@163.com>
Subject: [PATCH bpf v4 3/3] bpf, strparser, docs: Add new callback for bpf
Date: Thu,  9 Jan 2025 11:40:05 +0800
Message-ID: <20250109034005.861063-4-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250109034005.861063-1-mrpre@163.com>
References: <20250109034005.861063-1-mrpre@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgAXYaYcRX9na6O1Jw--.42275S5
X-Coremail-Antispam: 1Uf129KBjvdXoWrKryDXFyruFy5GF4rAw17trb_yoWkCrcEka
	yS9Fs5GFykZF43KayUua1kWr93GrWI9r18ZF4rtFZxC348XrykXF95Jrn5Zr18WrW3ury3
	K3s5JFyfJr129jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRdWrJUUUUU==
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiDwbPp2d-QGaV3wACsX

sockmap with strparser need customized read operations to fix copied_seq
error.

Signed-off-by: Jiayuan Chen <mrpre@163.com>
---
 Documentation/networking/strparser.rst | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/strparser.rst b/Documentation/networking/strparser.rst
index 6cab1f74ae05..e41c18eee2f4 100644
--- a/Documentation/networking/strparser.rst
+++ b/Documentation/networking/strparser.rst
@@ -112,7 +112,7 @@ Functions
 Callbacks
 =========
 
-There are six callbacks:
+There are seven callbacks:
 
     ::
 
@@ -182,6 +182,15 @@ There are six callbacks:
     the length of the message. skb->len - offset may be greater
     then full_len since strparser does not trim the skb.
 
+    ::
+
+	int (*read_sock)(struct strparser *strp, read_descriptor_t *desc,
+                     sk_read_actor_t recv_actor);
+
+    read_sock is called when the user specify it, allowing for customized
+    read operations. If the callback is not set (NULL in strp_init) native
+    read_sock operation of the socket is used.
+
     ::
 
 	int (*read_sock_done)(struct strparser *strp, int err);
-- 
2.43.5


