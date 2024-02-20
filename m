Return-Path: <bpf+bounces-22353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C148285CC41
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 00:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84F3F284811
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 23:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3373154C1A;
	Tue, 20 Feb 2024 23:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QN13jVAp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AFB154C11
	for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 23:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708473008; cv=none; b=BiS7B9STwHklEFRe6e/qDfslMkA+QFT2yTCn1BQmeOhNpjKs3q9DTNRQl5tIS/CEwuZ4bi3I0cN1ctGKVSV1WEWl3vBSennTj2Jz9djJF1tNMlS8mqplXl/muOKu3pgHdE2FLtMbJf+agVwBsA+aKHau2pN1rDKiFqfVQOgkBtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708473008; c=relaxed/simple;
	bh=o6ZJNTn1bxjV0Er8+ZRcY0XDyy3pzDEVXI0OqSW08xQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YupxEVlzJNIrup7VyEJ4K4zv4GXBJ5B/9kVYStxKW+oDp0m/nkAJHE5RWF8QJogfOPXLtfnn2lfv0b9RVpVfW16NmqH3IisCZ55VmK0w1eIFlEQnVAVtXRnFDqhqdNqahzEkOWP/sXDnV7gc3glu7SfJTkiUs51ixss3RQI2/Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QN13jVAp; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d8da50bffaso30780095ad.2
        for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 15:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708473005; x=1709077805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D9sFPDMAFgPLQwGz5jO27DfKgxfbrjbijbBIEDWd9rk=;
        b=QN13jVApuooD+zIpeR1AhEM6j8SXH+r5jq7GmtxjwaCwJjle0bmBAeSYBU7Q+a9UiT
         sP0faGc+spBgJ1uBcUXkkDhTXtJVDpSUFJLSIxaVz3HpU51zqwaeHP3gb3AVUHdHQ2sC
         zMqphKivr/7V9eOzGTWTYHqO5RfofebmTB31F+LvoWOTI2xR3GVKhnV9LrnpnSXdoaf9
         4abDsoS71EwVcY7t7cIwRy7VwJhVYc44Fev0suObOT5jkcp4MqUjEF7+X4qds6hpPnWB
         1DzvM8DEga1hZkfw15dchhsGsf8p3Tuh9jE8hsFEFZdRS7CgGqD9B4tsbLpx6QRdoIFr
         ZwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708473005; x=1709077805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D9sFPDMAFgPLQwGz5jO27DfKgxfbrjbijbBIEDWd9rk=;
        b=ikFNEsM+gLQtS51mdeluLKNkVA/EBlimduDqV973di/ILk19uurjtMnebKr0UUKOFA
         Fwoe4AUfbdy+RfNSDvp51NvnOHngpXap7/j7ZjZUQ/1q89Z+i6UqvQUGFNAa01+q5c14
         b6q7AMaQ2HgtxQfR3ytAWNfB0LpFwdocUbDXZbgGkcbNlMolsXgcmQ7HLYYGaVTtlkKl
         DpX3UWUHrGZvJd5qHswwkfJqSyFRKF5H85/bL32qKGHlkU2PMe7UP7oN92LIiF0DySpi
         Fi2XSFjOc1xM0vi6W3OpGNf8v6v3fWoCNTqj17ecUqhaWxU1erLGmcabbI5LjMksH44v
         R8iA==
X-Gm-Message-State: AOJu0YxMiRUp14SXe/EryuSWfkTWgKiczEdpr/4W9QveNcbFJs+pWHNb
	9WxCcHn8vZX9zf4nwibBmeYfxxbxZgCMawuf8YOIOBRZAZaEQA/gF3nlQ/9n
X-Google-Smtp-Source: AGHT+IGiXyw7h+Q9JbpPSrpjUMEsSfOVQe6T2iLWl7llSqKsrOo/8OD0oetgBUm44wJVl8HWJY9f/Q==
X-Received: by 2002:a17:902:ce01:b0:1db:aef3:ac01 with SMTP id k1-20020a170902ce0100b001dbaef3ac01mr15804987plg.46.1708473005401;
        Tue, 20 Feb 2024 15:50:05 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::4:b11c])
        by smtp.gmail.com with ESMTPSA id q10-20020a17090311ca00b001db33112225sm6775280plh.9.2024.02.20.15.50.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Feb 2024 15:50:04 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next] bpf: Shrink size of struct bpf_map/bpf_array.
Date: Tue, 20 Feb 2024 15:50:01 -0800
Message-Id: <20240220235001.57411-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Back in 2018 the commit be95a845cc44 ("bpf: avoid false sharing of map refcount with max_entries")
added ____cacheline_aligned to "struct bpf_map" to make sure that fields like
refcnt don't share a cache line with max_entries that is used to bounds check
map access. That was done to make spectre style attacks harder. The main
mitigation is done via code similar to array_index_nospec(), of course.
This was an additional precaution.
It increased the size of "struct bpf_map" a little, but it's affect
on all other maps (like array) is significant, since "struct bpf_map" is
typically the first member in other map types.

Undo this ____cacheline_aligned tag. Instead move freeze_mutex field around,
so that refcnt and max_entries are still in different cache lines.

The main effect is seen in sizeof(struct bpf_array) that reduces from 320 to 248 bytes.

BEFORE:

struct bpf_map {
	const struct bpf_map_ops  * ops;                 /*     0     8 */
	...
	char                       name[16];             /*    96    16 */

	/* XXX 16 bytes hole, try to pack */

	/* --- cacheline 2 boundary (128 bytes) --- */
	atomic64_t refcnt __attribute__((__aligned__(64))); /*   128     8 */
	...
	/* size: 256, cachelines: 4, members: 30 */
	/* sum members: 232, holes: 1, sum holes: 16 */
	/* padding: 8 */
	/* paddings: 1, sum paddings: 2 */
} __attribute__((__aligned__(64)));

struct bpf_array {
	struct bpf_map             map;                  /*     0   256 */
	...
	/* size: 320, cachelines: 5, members: 5 */
	/* padding: 48 */
	/* paddings: 1, sum paddings: 8 */
} __attribute__((__aligned__(64)));

AFTER:

struct bpf_map {
	/* size: 232, cachelines: 4, members: 30 */
	/* paddings: 1, sum paddings: 2 */
	/* last cacheline: 40 bytes */
};
struct bpf_array {
	/* size: 248, cachelines: 4, members: 5 */
	/* last cacheline: 56 bytes */
};

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c7aa99b44dbd..814dc913a968 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -251,10 +251,7 @@ struct bpf_list_node_kern {
 } __attribute__((aligned(8)));
 
 struct bpf_map {
-	/* The first two cachelines with read-mostly members of which some
-	 * are also accessed in fast-path (e.g. ops, max_entries).
-	 */
-	const struct bpf_map_ops *ops ____cacheline_aligned;
+	const struct bpf_map_ops *ops;
 	struct bpf_map *inner_map_meta;
 #ifdef CONFIG_SECURITY
 	void *security;
@@ -276,17 +273,14 @@ struct bpf_map {
 	struct obj_cgroup *objcg;
 #endif
 	char name[BPF_OBJ_NAME_LEN];
-	/* The 3rd and 4th cacheline with misc members to avoid false sharing
-	 * particularly with refcounting.
-	 */
-	atomic64_t refcnt ____cacheline_aligned;
+	struct mutex freeze_mutex;
+	atomic64_t refcnt;
 	atomic64_t usercnt;
 	/* rcu is used before freeing and work is only used during freeing */
 	union {
 		struct work_struct work;
 		struct rcu_head rcu;
 	};
-	struct mutex freeze_mutex;
 	atomic64_t writecnt;
 	/* 'Ownership' of program-containing map is claimed by the first program
 	 * that is going to use this map or by the first program which FD is
-- 
2.34.1


