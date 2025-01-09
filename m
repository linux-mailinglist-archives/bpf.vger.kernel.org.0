Return-Path: <bpf+bounces-48382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2660AA0721B
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 10:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90806188A968
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 09:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0730215784;
	Thu,  9 Jan 2025 09:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="iPbKZEA4"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC30E2153F9;
	Thu,  9 Jan 2025 09:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736416037; cv=none; b=Ddz7Dp2jatsbjKwSPGApixEwLXZHs/P3lvIDUPg3r1A+kTBUoq/ojaKbFyi6XmQnHNlEf6fYaqS1LJfwogr8oPIUckOQ+Ah6DocUgvKEyuO14P/bJrbztMg+eht+Uhuv4jXgLpfGDi0cm/C8peZDo/z9DsMGD7NPiF7Gk9ybFg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736416037; c=relaxed/simple;
	bh=RJmrHncmAiYfQZgHBbGZ9N6pX/NJqX1TU++10eqVLQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aiOIjt+OVXizR9k5D4S7wDUNWFSa0d5pdx/P/0DJGu3JEU6Q2qnDuzREs/ROxlM2q3dcrjQq9YipdBsyPZ/rqAlFMCQXJS0XMVAyYwbK93zQQ3VLMfJ85KNdMCNv1hZ5bTmZqS1poM+cUYDuVj28xDQijijzFnlEEWrsv8+6FrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=iPbKZEA4; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=W1HRi
	UHKkNK4KFvLch5WDTwcRDvo+NOPbJJW0YrzMOo=; b=iPbKZEA4hgy3lQ6oQTBGv
	cPjpLZ9Jh6cSxmHzlTWBZqmZ+i6uV46rguUsC3YSUOvz4q7vuesrjYAZPOcSg/yC
	7RQ7BUtLnKp9IGCSIYQEmdMaYB9TFm+C+xH/l+j0IMp2oYgu83LRccwnqi2abY6m
	BCXEw1JQ+RGHpnkerArunk=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgBnDnRlmn9no5XNEA--.12216S5;
	Thu, 09 Jan 2025 17:44:48 +0800 (CST)
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
Subject: [PATCH bpf v5 3/3] bpf, strparser, docs: Add new callback for bpf
Date: Thu,  9 Jan 2025 17:44:01 +0800
Message-ID: <20250109094402.50838-4-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250109094402.50838-1-mrpre@163.com>
References: <20250109094402.50838-1-mrpre@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgBnDnRlmn9no5XNEA--.12216S5
X-Coremail-Antispam: 1Uf129KBjvdXoWrKryDXFyruFy5GF4rAw17trb_yoWkCrcEka
	yS9Fs5GFykZF43KayUua1kWr93GrWI9r18ZF4rtFZxC348XrykXF95Jrn5Zr18WrW3ury3
	K3s5JFyfJr129jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRdWrJUUUUU==
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiDwbPp2d-kzTJjQAAsa

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


