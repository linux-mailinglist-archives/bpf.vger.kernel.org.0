Return-Path: <bpf+bounces-64610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87423B14C23
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 12:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 639427A24A6
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 10:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F35289E0B;
	Tue, 29 Jul 2025 10:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fa94HDat"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C4E288C16;
	Tue, 29 Jul 2025 10:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753784909; cv=none; b=Zm3kZ0bIShMJ0PA5VOSPIdL5A1HHJX4hpDB6DamwFTkFkpSQCCp/LVu5tRFf/cmvWLOgqVoAk1o5j9kfa2W1XjAxvcUNR1athWvsRApdiciwckhomHS3ACb2chZztfNktYpbZJvbtVOQyAxHMWmBpf/aaPcdi9+7dqvGuPMf9Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753784909; c=relaxed/simple;
	bh=Sm7jV+tRKsytGK5LOleOia6QLTmymRlF5GUTJcd927I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=otWeEcecTeeGcWtX9IxGoK+jzOu39HexKhUVrhH6fu99v0pryjokU2Kh/W1cQA2ePBT7cf0ytQ+ukpyoNO2WZeuHrTGMPauIYRuxXKjUSFd8aqDWg+1ojRGSCFuO1qKjas4tnvuwUOrK8j8X8XSPUuHfAJr7+6s1HSimAAldey0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fa94HDat; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B207C4CEEF;
	Tue, 29 Jul 2025 10:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753784909;
	bh=Sm7jV+tRKsytGK5LOleOia6QLTmymRlF5GUTJcd927I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fa94HDatVkSI/VlhVI0V22z6g6CxlV/NoPqz+yc+zjKjJUkB+9QSzWB1X4RMqR+6s
	 Kc0V7nU/Nx4KMQirEt6DddN50VwYea+QdtZTQcYRJY0zya2q7v5M6F41xdT5ci2E33
	 xaAbUYW8p/b6ucLEhs5YXr9CUn9woOz/6ta/GtW/Qz3MwKnAaBUeBxbeRNK5JM+pcT
	 aRlY4mh7bvXmj3bAbFZwUxmVr8waN3MscHIRtxQJCfcGrV20eB+zjLCAk3GobxLkxF
	 5d01W12qAJdZsNr6RRUa6XvJ4TO3iN2Zw5+3TVtiLMiW4vELhmAlZeaSX2zNelYDLN
	 nS4YoTPAtwL0Q==
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
	Menglong Dong <menglong8.dong@gmail.com>
Subject: [RFC 01/10] ftrace: Make alloc_and_copy_ftrace_hash direct friendly
Date: Tue, 29 Jul 2025 12:28:04 +0200
Message-ID: <20250729102813.1531457-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250729102813.1531457-1-jolsa@kernel.org>
References: <20250729102813.1531457-1-jolsa@kernel.org>
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
index 4203fad56b6c..5b8f565a1258 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1190,7 +1190,7 @@ static void __add_hash_entry(struct ftrace_hash *hash,
 }
 
 static struct ftrace_func_entry *
-add_hash_entry(struct ftrace_hash *hash, unsigned long ip)
+add_hash_entry_direct(struct ftrace_hash *hash, unsigned long ip, unsigned long direct)
 {
 	struct ftrace_func_entry *entry;
 
@@ -1199,11 +1199,18 @@ add_hash_entry(struct ftrace_hash *hash, unsigned long ip)
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
@@ -1376,7 +1383,7 @@ alloc_and_copy_ftrace_hash(int size_bits, struct ftrace_hash *hash)
 	size = 1 << hash->size_bits;
 	for (i = 0; i < size; i++) {
 		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
-			if (add_hash_entry(new_hash, entry->ip) == NULL)
+			if (add_hash_entry_direct(new_hash, entry->ip, entry->direct) == NULL)
 				goto free_hash;
 		}
 	}
-- 
2.50.1


