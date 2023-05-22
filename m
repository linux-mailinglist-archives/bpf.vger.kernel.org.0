Return-Path: <bpf+bounces-1039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1CA70CB36
	for <lists+bpf@lfdr.de>; Mon, 22 May 2023 22:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF8781C20C02
	for <lists+bpf@lfdr.de>; Mon, 22 May 2023 20:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1B8171D7;
	Mon, 22 May 2023 20:35:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C87154AF
	for <bpf@vger.kernel.org>; Mon, 22 May 2023 20:35:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A771C4339B;
	Mon, 22 May 2023 20:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684787713;
	bh=eHFLwkwnqJLV1skqiSQb1kO36BXLt5pZkTr7pZXoGQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZIotzxhO3HwG38hcM6aijGpyjjnPs6cQsHkoiUDuxBLolfFQK75I5fpMs/cB2wf6V
	 mR28ahuPQ/KT51PcT/869TcBM4E13dtkg3oN4VqdX5vLB1tTSzCswlUWwoW0mG/Nk9
	 unbDxoFcjbze+24r3T8thJEGfCNznl3ceEouvKiqvESC0RkGfcvdzjJdkqd17+YN8+
	 ewzuQBUBiMKT3knw5DWvLs+LUTtQ4INx5qw1R5jX86s12NeJgwmfyzJT7vPao72NWZ
	 9cyMZflIK3W6SdeIKtGaRSmhUVl67wYenrT+LW5Mw1ZSktfTIWARdzWVH3DENzNnMG
	 TkYl06+GRoHFw==
From: Jiri Olsa <jolsa@kernel.org>
To: stable@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@elte.hu>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Tsahee Zidenberg <tsahee@annapurnalabs.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	=?UTF-8?q?Mah=C3=A9=20Tardy?= <mahe.tardy@isovalent.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH stable 5.4 5/8] maccess: rename strncpy_from_unsafe_user to strncpy_from_user_nofault
Date: Mon, 22 May 2023 22:33:49 +0200
Message-Id: <20230522203352.738576-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522203352.738576-1-jolsa@kernel.org>
References: <20230522203352.738576-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

commit bd88bb5d4007949be7154deae7cef7173c751a95 upstream.

[Missing bpf_trace.c hunk due to not backported changes]

This matches the naming of strncpy_from_user, and also makes it more
clear what the function is supposed to do.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20200521152301.2587579-7-hch@lst.de
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 include/linux/uaccess.h     | 4 ++--
 kernel/trace/trace_kprobe.c | 2 +-
 mm/maccess.c                | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 25ae650dcb1a..23bda5df4c08 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -358,8 +358,8 @@ extern long strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count);
 extern long strncpy_from_unsafe_strict(char *dst, const void *unsafe_addr,
 				       long count);
 extern long __strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count);
-extern long strncpy_from_unsafe_user(char *dst, const void __user *unsafe_addr,
-				     long count);
+long strncpy_from_user_nofault(char *dst, const void __user *unsafe_addr,
+		long count);
 extern long strnlen_unsafe_user(const void __user *unsafe_addr, long count);
 
 /**
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index a422cf6a0358..d6ba4f6bed73 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1111,7 +1111,7 @@ fetch_store_string_user(unsigned long addr, void *dest, void *base)
 
 	__dest = get_loc_data(dest, base);
 
-	ret = strncpy_from_unsafe_user(__dest, uaddr, maxlen);
+	ret = strncpy_from_user_nofault(__dest, uaddr, maxlen);
 	if (ret >= 0)
 		*(u32 *)dest = make_data_loc(ret, __dest - base);
 
diff --git a/mm/maccess.c b/mm/maccess.c
index d263c7b5e4eb..8e4d564b6c25 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -231,7 +231,7 @@ long __strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count)
 }
 
 /**
- * strncpy_from_unsafe_user: - Copy a NUL terminated string from unsafe user
+ * strncpy_from_user_nofault: - Copy a NUL terminated string from unsafe user
  *				address.
  * @dst:   Destination address, in kernel space.  This buffer must be at
  *         least @count bytes long.
@@ -248,7 +248,7 @@ long __strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count)
  * If @count is smaller than the length of the string, copies @count-1 bytes,
  * sets the last byte of @dst buffer to NUL and returns @count.
  */
-long strncpy_from_unsafe_user(char *dst, const void __user *unsafe_addr,
+long strncpy_from_user_nofault(char *dst, const void __user *unsafe_addr,
 			      long count)
 {
 	mm_segment_t old_fs = get_fs();
-- 
2.40.1


