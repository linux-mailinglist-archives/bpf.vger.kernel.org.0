Return-Path: <bpf+bounces-65949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4561DB2B625
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 03:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00798527297
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 01:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2A721ABAA;
	Tue, 19 Aug 2025 01:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Txd9yJ88"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84182144C9
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 01:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755567092; cv=none; b=FcEI08/OSnpI6KqT0bf2bJg97NlWg4/WJxV+LkqcoGg8FKR9a+hzCcYRKGgXi4iTCLxQipbCSp++p/O8f0hRjrJhMinf8t99Hv5l0S5jTuidpmjVIX1ZidJmp4qi1Q92Q4YoyC44y3D1OU07xLBLVFd14rqdsGCWcXr53FGaie8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755567092; c=relaxed/simple;
	bh=a1WuJXSnYQFvsXxlVFoyuoLtdSWHtyMhicTvrUCWJtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TN083X92FzKxHm0cKCAleCIzmSg0fuLxulUsP8lvjZ6WAC368Ka5LpvDKeJeLkbKDt4QM63oSjzW9KiOigFeNe3qvWiSPlLUZql/z5j4XGYGXO6z49sms1zzLQexcFdCso5Z8K7nSH/onlmGTP12NEfn2IwdhZxYPOwt/Co62nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Txd9yJ88; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755567089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UM+lYf01AicvqurdDG2Jr1YwEDdRKP6fs9j6fHwup1A=;
	b=Txd9yJ88mYaBSA2kVSTpgUZ5qU21qrsptfcJjEK5DIn4fsW6KvaklwarZOowVoENK5L5OV
	SDAbiw/+4Jtc6zP7gyybtX5ROwXQt09AH4NXynsB3B9owuQVb41HUIKoSdsIbQXTC5Er6A
	MSTF3OvdMV/IoTPbMeZY1ijzsJ53Xmc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-2CIwWAB6OYKEEW0ssTjPDg-1; Mon,
 18 Aug 2025 21:27:15 -0400
X-MC-Unique: 2CIwWAB6OYKEEW0ssTjPDg-1
X-Mimecast-MFC-AGG-ID: 2CIwWAB6OYKEEW0ssTjPDg_1755566832
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C37CD19373D8;
	Tue, 19 Aug 2025 01:27:12 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.36])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1EF81180028A;
	Tue, 19 Aug 2025 01:27:00 +0000 (UTC)
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
	bpf@vger.kernel.org,
	systemd-devel@lists.freedesktop.org
Subject: [PATCHv5 10/12] arm64/kexec: Add PE image format support
Date: Tue, 19 Aug 2025 09:24:26 +0800
Message-ID: <20250819012428.6217-11-piliu@redhat.com>
In-Reply-To: <20250819012428.6217-1-piliu@redhat.com>
References: <20250819012428.6217-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Now everything is ready for kexec PE image parser. Select it on arm64
for zboot and UKI image support.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/Kconfig                     | 1 +
 arch/arm64/include/asm/kexec.h         | 1 +
 arch/arm64/kernel/machine_kexec_file.c | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e9bbfacc35a64..97d9595a5ee86 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1608,6 +1608,7 @@ config ARCH_SELECTS_KEXEC_FILE
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


