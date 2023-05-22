Return-Path: <bpf+bounces-1040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E809670CB3C
	for <lists+bpf@lfdr.de>; Mon, 22 May 2023 22:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B96E81C20BF6
	for <lists+bpf@lfdr.de>; Mon, 22 May 2023 20:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC05F174C9;
	Mon, 22 May 2023 20:35:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDB0154AF
	for <bpf@vger.kernel.org>; Mon, 22 May 2023 20:35:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB53C433D2;
	Mon, 22 May 2023 20:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684787727;
	bh=WBBOfaVUfGGoU8Hmkitpa+xWNdHXkkJPQthgTtdReZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j5yYDFtBdzXqePyI8lpdVEi04496pv3AyvnZk6ScW1UV2DQ8acR1fu0Zjimr1Fttz
	 GZftk2wWppltBRYHQQ2jJ8mlmHIW3tCIDetovhFUMWy14LPamrHwm7F4KVb0+Z+Rhb
	 87DD2hTbfB1dXY23B8HvEaQME2y8JC3ubY8sc+/1NPUuopB62F22XQCvkD0QCFdgvs
	 GFDgVkUM1/RK9m+johxQwFTnguhsEIQEKfVlQqyHvMDfSNmCQA4FdjjqD19qelJAyJ
	 HKoyuzpm/zHjF/7cy1FHls7U91J2KKAj0s/6oWCbkfvkU0sP9r6+7je1kzk/P36gQb
	 7yh4kJdcOSfVw==
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
Subject: [RFC PATCH stable 5.4 6/8] maccess: rename strncpy_from_unsafe_strict to strncpy_from_kernel_nofault
Date: Mon, 22 May 2023 22:33:50 +0200
Message-Id: <20230522203352.738576-7-jolsa@kernel.org>
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

commit c4cb164426aebd635baa53685b0ebf1a127e9803 upstream.

[Missing bpf_trace_printk due to not backported changes]

This matches the naming of strncpy_from_user_nofault, and also makes it
more clear what the function is supposed to do.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20200521152301.2587579-8-hch@lst.de
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/x86/mm/maccess.c    | 2 +-
 include/linux/uaccess.h  | 4 ++--
 kernel/trace/bpf_trace.c | 2 +-
 mm/maccess.c             | 6 +++---
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/mm/maccess.c b/arch/x86/mm/maccess.c
index f5b85bdc0535..62c4017a2473 100644
--- a/arch/x86/mm/maccess.c
+++ b/arch/x86/mm/maccess.c
@@ -34,7 +34,7 @@ long probe_kernel_read_strict(void *dst, const void *src, size_t size)
 	return __probe_kernel_read(dst, src, size);
 }
 
-long strncpy_from_unsafe_strict(char *dst, const void *unsafe_addr, long count)
+long strncpy_from_kernel_nofault(char *dst, const void *unsafe_addr, long count)
 {
 	if (unlikely(invalid_probe_range((unsigned long)unsafe_addr)))
 		return -EFAULT;
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 23bda5df4c08..7a926c5b77ce 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -355,8 +355,8 @@ extern long notrace probe_user_write(void __user *dst, const void *src, size_t s
 extern long notrace __probe_user_write(void __user *dst, const void *src, size_t size);
 
 extern long strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count);
-extern long strncpy_from_unsafe_strict(char *dst, const void *unsafe_addr,
-				       long count);
+long strncpy_from_kernel_nofault(char *dst, const void *unsafe_addr,
+		long count);
 extern long __strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count);
 long strncpy_from_user_nofault(char *dst, const void __user *unsafe_addr,
 		long count);
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 61c81c38202b..d1fd13a47bdf 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -187,7 +187,7 @@ bpf_probe_read_kernel_str_common(void *dst, u32 size, const void *unsafe_ptr,
 	 * is returned that can be used for bpf_perf_event_output() et al.
 	 */
 	ret = compat ? strncpy_from_unsafe(dst, unsafe_ptr, size) :
-	      strncpy_from_unsafe_strict(dst, unsafe_ptr, size);
+	      strncpy_from_kernel_nofault(dst, unsafe_ptr, size);
 	if (unlikely(ret < 0))
 out:
 		memset(dst, 0, size);
diff --git a/mm/maccess.c b/mm/maccess.c
index 8e4d564b6c25..8cfe21dfc953 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -174,7 +174,7 @@ EXPORT_SYMBOL_GPL(probe_user_write);
  * If @count is smaller than the length of the string, copies @count-1 bytes,
  * sets the last byte of @dst buffer to NUL and returns @count.
  *
- * Same as strncpy_from_unsafe_strict() except that for architectures with
+ * Same as strncpy_from_kernel_nofault() except that for architectures with
  * not fully separated user and kernel address spaces this function also works
  * for user address tanges.
  *
@@ -186,7 +186,7 @@ long __weak strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count)
     __attribute__((alias("__strncpy_from_unsafe")));
 
 /**
- * strncpy_from_unsafe_strict: - Copy a NUL terminated string from unsafe
+ * strncpy_from_kernel_nofault: - Copy a NUL terminated string from unsafe
  *				 address.
  * @dst:   Destination address, in kernel space.  This buffer must be at
  *         least @count bytes long.
@@ -203,7 +203,7 @@ long __weak strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count)
  * If @count is smaller than the length of the string, copies @count-1 bytes,
  * sets the last byte of @dst buffer to NUL and returns @count.
  */
-long __weak strncpy_from_unsafe_strict(char *dst, const void *unsafe_addr,
+long __weak strncpy_from_kernel_nofault(char *dst, const void *unsafe_addr,
 				       long count)
     __attribute__((alias("__strncpy_from_unsafe")));
 
-- 
2.40.1


