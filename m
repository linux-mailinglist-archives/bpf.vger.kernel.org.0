Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738171D9879
	for <lists+bpf@lfdr.de>; Tue, 19 May 2020 15:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgESNpI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 May 2020 09:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729051AbgESNpH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 May 2020 09:45:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB58C08C5C0;
        Tue, 19 May 2020 06:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mSMXwSYIg6w8Djb8jfs2EjgdqI2tqBJvsH4pyf4a+s4=; b=O4f7jbEoBQytGY6y9+u4qjcwK/
        d0PUaF85FF31qS/GlEkF174eEqJm762g8NSYqJ4iV3/VqrHLvoSBA/5Oh5sntM9aFmrx2I0LFgV4p
        iA7rnGTnWiSaN8DIYHkk9gFBdyJPJak3iCIO94f8TPwaXseW4H2zqTGI4ResgwEupbjKNh2GjTOgC
        N0JRDfBLZVlefrRvc1YbZBCARFuuLVeyv1lQ7ADUyhfd2p4y4X8hpHTEtNrhXy5OjF1rFEWqjdXUU
        3utE0/vpSnifG2fqDyKfQF633VI2w3iWruGWtZDQhnufE9YgZZ2HdQ03GLTHJ3En2ld2NlNRdUM4s
        Fbis1O3g==;
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jb2YK-0001CH-JV; Tue, 19 May 2020 13:45:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-parisc@vger.kernel.org, linux-um@lists.infradead.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/20] maccess: clarify kerneldoc comments
Date:   Tue, 19 May 2020 15:44:33 +0200
Message-Id: <20200519134449.1466624-5-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519134449.1466624-1-hch@lst.de>
References: <20200519134449.1466624-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add proper kerneldoc comments for probe_kernel_read_strict and
probe_kernel_read strncpy_from_unsafe_strict and explain the different
versus the non-strict version.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/maccess.c | 61 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 18 deletions(-)

diff --git a/mm/maccess.c b/mm/maccess.c
index 4e7f3b6eb05ae..747581ac50dc9 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -31,29 +31,35 @@ probe_write_common(void __user *dst, const void *src, size_t size)
 }
 
 /**
- * probe_kernel_read(): safely attempt to read from a kernel-space location
+ * probe_kernel_read(): safely attempt to read from any location
  * @dst: pointer to the buffer that shall take the data
  * @src: address to read from
  * @size: size of the data chunk
  *
- * Safely read from address @src to the buffer at @dst.  If a kernel fault
- * happens, handle that and return -EFAULT.
+ * Same as probe_kernel_read_strict() except that for architectures with
+ * not fully separated user and kernel address spaces this function also works
+ * for user address tanges.
+ *
+ * DO NOT USE THIS FUNCTION - it is broken on architectures with entirely
+ * separate kernel and user address spaces, and also a bad idea otherwise.
+ */
+long __weak probe_kernel_read(void *dst, const void *src, size_t size)
+    __attribute__((alias("__probe_kernel_read")));
+
+/**
+ * probe_kernel_read_strict(): safely attempt to read from kernel-space
+ * @dst: pointer to the buffer that shall take the data
+ * @src: address to read from
+ * @size: size of the data chunk
+ *
+ * Safely read from kernel address @src to the buffer at @dst.  If a kernel
+ * fault happens, handle that and return -EFAULT.
  *
  * We ensure that the copy_from_user is executed in atomic context so that
  * do_page_fault() doesn't attempt to take mmap_sem.  This makes
  * probe_kernel_read() suitable for use within regions where the caller
  * already holds mmap_sem, or other locks which nest inside mmap_sem.
- *
- * probe_kernel_read_strict() is the same as probe_kernel_read() except for
- * the case where architectures have non-overlapping user and kernel address
- * ranges: probe_kernel_read_strict() will additionally return -EFAULT for
- * probing memory on a user address range where probe_user_read() is supposed
- * to be used instead.
  */
-
-long __weak probe_kernel_read(void *dst, const void *src, size_t size)
-    __attribute__((alias("__probe_kernel_read")));
-
 long __weak probe_kernel_read_strict(void *dst, const void *src, size_t size)
     __attribute__((alias("__probe_kernel_read")));
 
@@ -153,15 +159,34 @@ long probe_user_write(void __user *dst, const void *src, size_t size)
  * If @count is smaller than the length of the string, copies @count-1 bytes,
  * sets the last byte of @dst buffer to NUL and returns @count.
  *
- * strncpy_from_unsafe_strict() is the same as strncpy_from_unsafe() except
- * for the case where architectures have non-overlapping user and kernel address
- * ranges: strncpy_from_unsafe_strict() will additionally return -EFAULT for
- * probing memory on a user address range where strncpy_from_unsafe_user() is
- * supposed to be used instead.
+ * Same as strncpy_from_unsafe_strict() except that for architectures with
+ * not fully separated user and kernel address spaces this function also works
+ * for user address tanges.
+ *
+ * DO NOT USE THIS FUNCTION - it is broken on architectures with entirely
+ * separate kernel and user address spaces, and also a bad idea otherwise.
  */
 long __weak strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count)
     __attribute__((alias("__strncpy_from_unsafe")));
 
+/**
+ * strncpy_from_unsafe_strict: - Copy a NUL terminated string from unsafe
+ *				 address.
+ * @dst:   Destination address, in kernel space.  This buffer must be at
+ *         least @count bytes long.
+ * @unsafe_addr: Unsafe address.
+ * @count: Maximum number of bytes to copy, including the trailing NUL.
+ *
+ * Copies a NUL-terminated string from unsafe address to kernel buffer.
+ *
+ * On success, returns the length of the string INCLUDING the trailing NUL.
+ *
+ * If access fails, returns -EFAULT (some data may have been copied
+ * and the trailing NUL added).
+ *
+ * If @count is smaller than the length of the string, copies @count-1 bytes,
+ * sets the last byte of @dst buffer to NUL and returns @count.
+ */
 long __weak strncpy_from_unsafe_strict(char *dst, const void *unsafe_addr,
 				       long count)
     __attribute__((alias("__strncpy_from_unsafe")));
-- 
2.26.2

