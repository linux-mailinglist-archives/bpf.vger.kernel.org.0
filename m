Return-Path: <bpf+bounces-63981-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFA2B0CF7E
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 04:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30760542128
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 02:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B0F1D5ADC;
	Tue, 22 Jul 2025 02:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A80U6ifq"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E912EEC5
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 02:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753149863; cv=none; b=iv3pLaF4Or9E64EjaGfxQTlTngmm1Wqp+3WGF4ade0Nfs4do8D67YRDqZ/JqRwy5OOwRN8iSKuXW/X8GtnULwQ3kUvu+M0pD/gbEnkEBmzqjvXcNG8ZH8r0wNs9FGzYH09cAzQc9+qPca5tqFQ5jfbt1G4ZZqwgM8n1K20Y75A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753149863; c=relaxed/simple;
	bh=8F6mTLmJlh4i3Fet3JGrhPNNSnQhPigFYr8g61jXIp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H5GiiEvTpiC+IQ0fD/YRbD5FPjMIjCim3zpt4npuL12aqC5eYnveBBvc7BCXMcz/FXf8331LFYDqwKo0NpUJpTmlR8uK5zs3qc37C3MXailI2e9ZZHlyfZlIfa5uXjD0GDlKqtfcKBWwZKeM6xBJNH1i9SHlu6ibvi5l7Bv0cAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A80U6ifq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753149861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BNCqutEYCGxkPLPPDptf/fqRtu8WQpYy2xLrXDrGIyA=;
	b=A80U6ifq+M+ijiVWygwM7hvvPaxQz6mnickz0yj2DZWXwKonAHoXNdfozCcx+5hVzM4egK
	+9WrHrVXpuOHQR3bfdgjtubrZWnRBlfrMNKDWD0YDB3wNHKyCEbc16KKV/Gm0eNO/eOdAn
	V3lgPJGmfInEaVGE8edgKFLNJw83Lgo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-YEplb8HYO_2Qo6bhdbxZqQ-1; Mon,
 21 Jul 2025 22:04:17 -0400
X-MC-Unique: YEplb8HYO_2Qo6bhdbxZqQ-1
X-Mimecast-MFC-AGG-ID: YEplb8HYO_2Qo6bhdbxZqQ_1753149855
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A0981956088;
	Tue, 22 Jul 2025 02:04:14 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.104])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C28BF180045B;
	Tue, 22 Jul 2025 02:04:03 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
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
	bpf@vger.kernel.org
Subject: [PATCHv4 02/12] lib/decompress: Keep decompressor when CONFIG_KEXEC_PE_IMAGE
Date: Tue, 22 Jul 2025 10:03:09 +0800
Message-ID: <20250722020319.5837-3-piliu@redhat.com>
In-Reply-To: <20250722020319.5837-1-piliu@redhat.com>
References: <20250722020319.5837-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The KEXE PE format parser needs the kernel built-in decompressor to
decompress the kernel image. So moving the decompressor out of __init
sections.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
To: linux-kernel@vger.kernel.org
---
 include/linux/decompress/mm.h | 7 +++++++
 lib/decompress.c              | 6 +++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/linux/decompress/mm.h b/include/linux/decompress/mm.h
index ac862422df158..e8948260e2bbe 100644
--- a/include/linux/decompress/mm.h
+++ b/include/linux/decompress/mm.h
@@ -92,7 +92,14 @@ MALLOC_VISIBLE void free(void *where)
 #define large_malloc(a) vmalloc(a)
 #define large_free(a) vfree(a)
 
+#ifdef CONFIG_KEXEC_PE_IMAGE
+#define INIT
+#define INITCONST
+#else
 #define INIT __init
+#define INITCONST __initconst
+#endif
+
 #define STATIC
 
 #include <linux/init.h>
diff --git a/lib/decompress.c b/lib/decompress.c
index ab3fc90ffc646..3d5b6304bb0f1 100644
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
 	{ {0x1f, 0x8b}, "gzip", gunzip },
 	{ {0x1f, 0x9e}, "gzip", gunzip },
 	{ {0x42, 0x5a}, "bzip2", bunzip2 },
@@ -60,7 +60,7 @@ static const struct compress_format compressed_formats[] __initconst = {
 	{ {0, 0}, NULL, NULL }
 };
 
-decompress_fn __init decompress_method(const unsigned char *inbuf, long len,
+decompress_fn INIT decompress_method(const unsigned char *inbuf, long len,
 				const char **name)
 {
 	const struct compress_format *cf;
-- 
2.49.0


