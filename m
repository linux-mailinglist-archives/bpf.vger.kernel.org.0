Return-Path: <bpf+bounces-56897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8479AA0153
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 06:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B76153A9BE9
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 04:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8564270EB0;
	Tue, 29 Apr 2025 04:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dlhGE1x9"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B94253F3F
	for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 04:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745900060; cv=none; b=eA7OnHva7VWjJ4m9vd5xyau1xgu+Vw+LdIZSGDV+l/P3KmAjClymYQ6SfXWnEjAQaEKRv+ISjse3cf+KStH4egi8r7N7iSYWuUtPRQ7STIvIaGWjj6e9Hx2j3aGyx6cgQNwf3NrtUNWuoBVe08KRnF5Ug1QM1y96TorHAvHJH6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745900060; c=relaxed/simple;
	bh=q2H3Sr9ElLGaLL7aCce2NFRz2VxenQNo4d4l2QUewRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sPFVEu5qyE9Cgka6SFb1POHo8Hwese1hUSapq/sNkp6mO6oFaGLuroObu7KpLxC9J1KHJcjYK3o/p/fPSopiI6BHK+Y23oZTr15d1hIvFYiHCvLjiOjDA1sKR8Nb9eoxaGs48toKG4kHYMkQnsu8DcQyJW0DvNbAHqVqA4MbxvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dlhGE1x9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745900057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Buz5Dsn5J295lenqxdqEUf89ZzRAx+N4J9gauCKfiYY=;
	b=dlhGE1x99QQT7civG0jcz95bMgNO1lHWaC65HSRii74k+1PIVZbxOy79QNND8KuLmHpHep
	5gx+7au7bFh4SO97R2sekFXdu13UAob5mSq+IdYXO7/5qnI9uZQtpGd6H0qyQVtHXYS7DC
	cdToWtXpjSnS/iWiJJQZd7nWX5/uD30=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-fGJeuWNFPxyLpMJOWmRozg-1; Tue,
 29 Apr 2025 00:14:13 -0400
X-MC-Unique: fGJeuWNFPxyLpMJOWmRozg-1
X-Mimecast-MFC-AGG-ID: fGJeuWNFPxyLpMJOWmRozg_1745900050
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F754195609D;
	Tue, 29 Apr 2025 04:14:10 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.64])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1880F1800352;
	Tue, 29 Apr 2025 04:13:58 +0000 (UTC)
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
	Eric Biederman <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org,
	bpf@vger.kernel.org
Subject: [RFCv2 7/7] arm64/kexec: Add PE image format support
Date: Tue, 29 Apr 2025 12:12:14 +0800
Message-ID: <20250429041214.13291-8-piliu@redhat.com>
In-Reply-To: <20250429041214.13291-1-piliu@redhat.com>
References: <20250429041214.13291-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Now everything is ready for kexec PE image parser. Select it for zboot
and UKI image support.

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
index a182295e6f08b..80b365fb7643e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1592,6 +1592,7 @@ config ARCH_SELECTS_KEXEC_FILE
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


