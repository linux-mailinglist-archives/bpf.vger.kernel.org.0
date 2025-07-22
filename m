Return-Path: <bpf+bounces-63989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D436B0CF8B
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 04:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 890223A649D
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 02:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D51A1CCB40;
	Tue, 22 Jul 2025 02:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xx9Trkdq"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2400E1ADC7E
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 02:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753149955; cv=none; b=R4x0Cif8hO4VEaq55rHVgJRQVG2PNQXwd8z845FAiCgR8p2UY7N6509UrUgDKQkbrInuRz2gOh/YdJQCv9hqMl3SILPE14aA+JVHvHmO6bfID/h0ENOGSDSme4Aql+mpIg5OfiONxBPKTREDIdImkA75SMi5m7iYaXlGaqqCwN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753149955; c=relaxed/simple;
	bh=xENFj464i3VaLC/5qoXyvhLix/xDSlpZugWLT6/573A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+HLtIQUKBuDJbfl25G0llfSX4I0DcxPy4A+UWGwwEONj5+la05lMqjcXzboCiyGqzMYXLIFLtLF/YiPc8BFJjF6FI4FXeP8YEC67CMfVVIx1c3L1/b4MaRSQdHX/iPKfv357miNrkcOFdhlQvdojLyd526skBm8Nd9cNrAZYYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xx9Trkdq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753149953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FC3yvRWGyaEerEFkky/lXdjnRYSQ2y+Y4Lf3dI4+DrQ=;
	b=Xx9TrkdqwTJLFmr8lct9db1KxeVt66feyD9LWe7IqKM0UacnD33D6joTAuMHRb9fSC2UMx
	CskQv5ESiezxvidn4op0vPnZ1OU2MzW45WdFDwm+0zIfkxxxUq63MqtoQGspB2t5nM2nm+
	zJFZ9qlX/PAfDgA5NmCq0pxe/lJYCSI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-krhlqYdLNpmfvhBQlmR6zg-1; Mon,
 21 Jul 2025 22:05:49 -0400
X-MC-Unique: krhlqYdLNpmfvhBQlmR6zg-1
X-Mimecast-MFC-AGG-ID: krhlqYdLNpmfvhBQlmR6zg_1753149947
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0274719560AA;
	Tue, 22 Jul 2025 02:05:47 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.104])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9F8F718003FC;
	Tue, 22 Jul 2025 02:05:36 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: linux-arm-kernel@lists.infradead.org
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
Subject: [PATCHv4 10/12] arm64/kexec: Add PE image format support
Date: Tue, 22 Jul 2025 10:03:17 +0800
Message-ID: <20250722020319.5837-11-piliu@redhat.com>
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

Now everything is ready for kexec PE image parser. Select it on arm64
for zboot and UKI image support.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/Kconfig                     | 1 +
 arch/arm64/include/asm/kexec.h         | 1 +
 arch/arm64/kernel/machine_kexec_file.c | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 55fc331af3371..8973697ed1479 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1606,6 +1606,7 @@ config ARCH_SELECTS_KEXEC_FILE
 	def_bool y
 	depends on KEXEC_FILE
 	select HAVE_IMA_KEXEC if IMA
+	select KEXEC_PE_IMAGE
 
 config ARCH_SUPPORTS_KEXEC_SIG
 	def_bool y
diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 4d9cc7a76d9ca..d50796bd2f1e6 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -120,6 +120,7 @@ struct kimage_arch {
 
 #ifdef CONFIG_KEXEC_FILE
 extern const struct kexec_file_ops kexec_image_ops;
+extern const struct kexec_file_ops kexec_pe_image_ops;
 
 int arch_kimage_file_post_load_cleanup(struct kimage *image);
 #define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index af1ca875c52ce..7c544c385a9ab 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -24,6 +24,9 @@
 
 const struct kexec_file_ops * const kexec_file_loaders[] = {
 	&kexec_image_ops,
+#ifdef CONFIG_KEXEC_PE_IMAGE
+	&kexec_pe_image_ops,
+#endif
 	NULL
 };
 
-- 
2.49.0


