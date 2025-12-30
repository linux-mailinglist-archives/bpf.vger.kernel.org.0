Return-Path: <bpf+bounces-77514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B11BCE9FA4
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 15:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42435302E050
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 14:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305E3317709;
	Tue, 30 Dec 2025 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7rMpxMe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A741B296BB5;
	Tue, 30 Dec 2025 14:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767106241; cv=none; b=bgMhmzmxIWUI2XJ0So88m6OPBWya3TVXIRMxbubFjBurFGk/E8gLHXTfetoZB+VSF2Y2sBigz+BbA+YmRKxGLtixJ1rM3c8at08HwTKpDnb35VMpoRi4Z3ILOaXUuIC1WSyeJyRge9y5gL4n+6goXl8rWthUJARkinD0zutJka4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767106241; c=relaxed/simple;
	bh=27TvWU4UpBAfYfhozN7qRGVx1Aub7R7oMGSS4pd4NDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o0+ULnSpbtfN4WuUCKwH37zhWWzJJEsl8i364xTRBCMb8a8id6Bu9bI3e23zcjituezFcVk0EH5I2FhAnXmmn/PCTeJm1fCITnC9/30CggYm+CdUcsYu/QAage1vKlvxsy4e64gAcxO4jYIn8udU+WcYA8W7S+pdPwJiraqAMGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7rMpxMe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083FCC4CEFB;
	Tue, 30 Dec 2025 14:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767106241;
	bh=27TvWU4UpBAfYfhozN7qRGVx1Aub7R7oMGSS4pd4NDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X7rMpxMe5tUBvvp3jiwkyiPsvxQW0NwaV6UaF+p1Q6tE6RJplksLhCihzOkv3EfVj
	 b5AZoV2O0c2/SenjgK+oiUMjWgA01qx0C72CIDDgO5HbppuXwPtoghoTx9RGMqNEW8
	 0oVsS+qWM+CTvGDNIDdoxt8Y/YT1LaUse7qyIVCA6LlcBDGes3atERRgugxRpXpMRz
	 DhK7ldQwyqXxcgCDv0lrdraVIMR6ejHCLnqv0X1KPwg/FfIGeUeQ2VXX54TUV4GCE5
	 slIPWm1xJp8meUvhQ+GvMJT4DshHYe6BZ8Jg23inNxMkFmB6dpgzHrpis7O2KSLyJm
	 L0Bmllv03SYDQ==
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
Subject: [PATCHv6 bpf-next 2/9] ftrace: Make alloc_and_copy_ftrace_hash direct friendly
Date: Tue, 30 Dec 2025 15:50:03 +0100
Message-ID: <20251230145010.103439-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230145010.103439-1-jolsa@kernel.org>
References: <20251230145010.103439-1-jolsa@kernel.org>
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
index f5f042ea079e..409271aa8dad 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1212,7 +1212,7 @@ static void __add_hash_entry(struct ftrace_hash *hash,
 }
 
 static struct ftrace_func_entry *
-add_hash_entry(struct ftrace_hash *hash, unsigned long ip)
+add_hash_entry_direct(struct ftrace_hash *hash, unsigned long ip, unsigned long direct)
 {
 	struct ftrace_func_entry *entry;
 
@@ -1221,11 +1221,18 @@ add_hash_entry(struct ftrace_hash *hash, unsigned long ip)
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
@@ -1398,7 +1405,7 @@ alloc_and_copy_ftrace_hash(int size_bits, struct ftrace_hash *hash)
 	size = 1 << hash->size_bits;
 	for (i = 0; i < size; i++) {
 		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
-			if (add_hash_entry(new_hash, entry->ip) == NULL)
+			if (add_hash_entry_direct(new_hash, entry->ip, entry->direct) == NULL)
 				goto free_hash;
 		}
 	}
-- 
2.52.0


