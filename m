Return-Path: <bpf+bounces-74391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A715DC57721
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 13:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9ED2F4E4DE0
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 12:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C2E34EF13;
	Thu, 13 Nov 2025 12:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eakqP6OL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3461D34D921;
	Thu, 13 Nov 2025 12:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763037507; cv=none; b=tut5ubI7+gKZYogZsym0sMuRkW+X2qEt7V84aMEj/wkZ83bwLK1vQHbF27XagysesbAvO3I8hPa99zOwxToAbyCxVhdvji6nydyuUh/QxinLOi0JQMk2XDtDzpDDfV03RTU8Z9GAAAlNQpvvwUQBq2eouTXmPTm30e7t9MOSVdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763037507; c=relaxed/simple;
	bh=YnnW7zN+aKxuUBmWBuWqRRKoptp3OePRxKnEM6fAzmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h5HAnQj/rss2CMr7IPWxH2yLGhMGlDS7rfC7xYC2MoXWxr19v+oiQFJEWfdI6Q1M+pEHAQL0KJe+R4CmtVwPktH/EHrjgMbjLZ4dIB15mZlRVRdIda47z2dI2lhTgIYETiS6Krn+ujnJ+AZJ3SRJwKzq9Tz5BJJrxfygcuULSkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eakqP6OL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E0DC19424;
	Thu, 13 Nov 2025 12:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763037506;
	bh=YnnW7zN+aKxuUBmWBuWqRRKoptp3OePRxKnEM6fAzmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eakqP6OLvQySInHmGJPnCvI6x0YzqEvAB/m/d5qTanF1B1Z93+W8G3F71AxCBLLpu
	 Q3QuVL6855HtTW4TzGMdkJgXyCn3vGgFRgqJhAzSluxdOhy8Cpz+Ik3VcY+LLxOzZB
	 ZhBygtK0ivDcM4L8GU+XRZB6mmaQEtwwWc2iSXdp/NmvV7KVrBRBb31Wvp2Z2dKBPo
	 oYb2jpNBnuKPNb/Atl07i9GOgCdI9cw0IovQQbB2l/cm8bcqDzwe/Fk0uqakxrf0c3
	 xQ05qt2TZhhzfqUebUeGBbWnfItTZPFJiO0+jdQDEF5Vuk7eZVT2wz3pNY/j/58MYr
	 cSdhPzu7v6z5Q==
From: Jiri Olsa <jolsa@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>,
	Florent Revest <revest@google.com>,
	Mark Rutland <mark.rutland@arm.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Song Liu <song@kernel.org>
Subject: [PATCHv2 bpf-next 1/8] ftrace: Make alloc_and_copy_ftrace_hash direct friendly
Date: Thu, 13 Nov 2025 13:37:43 +0100
Message-ID: <20251113123750.2507435-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251113123750.2507435-1-jolsa@kernel.org>
References: <20251113123750.2507435-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make alloc_and_copy_ftrace_hash to copy also direct address
for each hash entry.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/ftrace.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 59cfacb8a5bb..0e3714b796d9 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1186,7 +1186,7 @@ static void __add_hash_entry(struct ftrace_hash *hash,
 }
 
 static struct ftrace_func_entry *
-add_hash_entry(struct ftrace_hash *hash, unsigned long ip)
+add_hash_entry_direct(struct ftrace_hash *hash, unsigned long ip, unsigned long direct)
 {
 	struct ftrace_func_entry *entry;
 
@@ -1195,11 +1195,18 @@ add_hash_entry(struct ftrace_hash *hash, unsigned long ip)
 		return NULL;
 
 	entry->ip = ip;
+	entry->direct = direct;
 	__add_hash_entry(hash, entry);
 
 	return entry;
 }
 
+static struct ftrace_func_entry *
+add_hash_entry(struct ftrace_hash *hash, unsigned long ip)
+{
+	return add_hash_entry_direct(hash, ip, 0);
+}
+
 static void
 free_hash_entry(struct ftrace_hash *hash,
 		  struct ftrace_func_entry *entry)
@@ -1372,7 +1379,7 @@ alloc_and_copy_ftrace_hash(int size_bits, struct ftrace_hash *hash)
 	size = 1 << hash->size_bits;
 	for (i = 0; i < size; i++) {
 		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
-			if (add_hash_entry(new_hash, entry->ip) == NULL)
+			if (add_hash_entry_direct(new_hash, entry->ip, entry->direct) == NULL)
 				goto free_hash;
 		}
 	}
-- 
2.51.1


