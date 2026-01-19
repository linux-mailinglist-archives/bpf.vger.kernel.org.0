Return-Path: <bpf+bounces-79407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E230D39CCA
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 04:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 069CA3001008
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 03:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11BF258CE7;
	Mon, 19 Jan 2026 03:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d11s5PY4"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A9126ED40
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 03:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768793189; cv=none; b=GDRi47f0QtGsxEvkqeUs2QRFXrnFwFqqS1S2LCNU0vY88/KTRO80h1aZClkbAzdhktyiqOVID+ksPa4mkxnXL0oOvOnjMJmVyeaQJGMJur61mthJitVVjoBBStCC7W9OBubsYSJJLCxtZJPxXVx9wsepnN9rptwXBNc2jLDlSjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768793189; c=relaxed/simple;
	bh=KoOqMVsxXxT2B0pOv168WB7cXJrbry5wUPqp5jH0FWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JIdFlfqKZGFVghcMMZHlI6jwQX10iDwFek6HHGse4B0yKub2/am43CH4UC0D4vAmGk8PEzR5OZqX6TbTeXB98n+6DrS8LITBjUfIu7j/BAwj1Cpw8KLF6tOShXVnRyv+h03nWvrdD0Ok92TkUbKaLlRy7J6CQjaiq1ApEnKzv/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d11s5PY4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768793184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hg0gvqRYQBne5zWb7lRZ/WuuQgWnEek/Cp/61K7aU80=;
	b=d11s5PY4dmXIPpS2yfXZsWPUMYYXvyqCPC+k/xNptf05aMAm/RqDknVbTySs/KPD9ubnhM
	E3QWE5A3QgnIZWSz81Hk+ks/85IG+M5NEBI69DclccqmSLuMqRnudcUdga5pd6iLtfnTrp
	hBKHWxaTKNQLkyL/1LDWRNKLuGrj0fw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-399-_4h3uHm2MPKI8q34RT6_Cg-1; Sun,
 18 Jan 2026 22:26:17 -0500
X-MC-Unique: _4h3uHm2MPKI8q34RT6_Cg-1
X-Mimecast-MFC-AGG-ID: _4h3uHm2MPKI8q34RT6_Cg_1768793174
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D216180044D;
	Mon, 19 Jan 2026 03:26:14 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.74])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 58BF21955F22;
	Mon, 19 Jan 2026 03:26:03 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Philipp Rudo <prudo@redhat.com>,
	Viktor Malik <vmalik@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org,
	bpf@vger.kernel.org,
	systemd-devel@lists.freedesktop.org
Subject: [PATCHv6 05/13] lib/decompress: Keep decompressor when CONFIG_KEEP_DECOMPRESSOR
Date: Mon, 19 Jan 2026 11:24:16 +0800
Message-ID: <20260119032424.10781-6-piliu@redhat.com>
In-Reply-To: <20260119032424.10781-1-piliu@redhat.com>
References: <20260119032424.10781-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The KEXE PE format parser needs the kernel built-in decompressor to
decompress the kernel image. So moving the decompressor out of __init
sections.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
To: linux-kernel@vger.kernel.org
---
 include/linux/decompress/mm.h | 8 ++++++++
 lib/Kconfig                   | 6 ++++++
 lib/decompress.c              | 6 +++---
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/linux/decompress/mm.h b/include/linux/decompress/mm.h
index ac862422df158..39df02bcbc661 100644
--- a/include/linux/decompress/mm.h
+++ b/include/linux/decompress/mm.h
@@ -81,6 +81,7 @@ MALLOC_VISIBLE void free(void *where)
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include <generated/autoconf.h>
 
 /* Use defines rather than static inline in order to avoid spurious
  * warnings when not needed (indeed large_malloc / large_free are not
@@ -92,7 +93,14 @@ MALLOC_VISIBLE void free(void *where)
 #define large_malloc(a) vmalloc(a)
 #define large_free(a) vfree(a)
 
+#ifdef CONFIG_KEEP_DECOMPRESSOR
+#define INIT
+#define INITCONST
+#else
 #define INIT __init
+#define INITCONST __initconst
+#endif
+
 #define STATIC
 
 #include <linux/init.h>
diff --git a/lib/Kconfig b/lib/Kconfig
index 2923924bea78c..4424ae14dcf12 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -165,6 +165,12 @@ config RANDOM32_SELFTEST
 #
 # compression support is select'ed if needed
 #
+config KEEP_DECOMPRESSOR
+	bool "keeps the decompress routines after kernel initialization"
+	default n
+	help
+	  This option keeps the decompress routines after kernel initialization
+
 config 842_COMPRESS
 	select CRC32
 	tristate
diff --git a/lib/decompress.c b/lib/decompress.c
index 7785471586c62..29d4c749f1fc4 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -6,7 +6,7 @@
  */
 
 #include <linux/decompress/generic.h>
-
+#include <linux/decompress/mm.h>
 #include <linux/decompress/bunzip2.h>
 #include <linux/decompress/unlzma.h>
 #include <linux/decompress/unxz.h>
@@ -48,7 +48,7 @@ struct compress_format {
 	decompress_fn decompressor;
 };
 
-static const struct compress_format compressed_formats[] __initconst = {
+static const struct compress_format compressed_formats[] INITCONST = {
 	{ .magic = {0x1f, 0x8b}, .name = "gzip", .decompressor = gunzip },
 	{ .magic = {0x1f, 0x9e}, .name = "gzip", .decompressor = gunzip },
 	{ .magic = {0x42, 0x5a}, .name = "bzip2", .decompressor = bunzip2 },
@@ -60,7 +60,7 @@ static const struct compress_format compressed_formats[] __initconst = {
 	{ /* sentinel */ }
 };
 
-decompress_fn __init decompress_method(const unsigned char *inbuf, long len,
+decompress_fn INIT decompress_method(const unsigned char *inbuf, long len,
 				const char **name)
 {
 	const struct compress_format *cf;
-- 
2.49.0


