Return-Path: <bpf+bounces-56891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EA4AA014C
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 06:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D7E61A84F73
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 04:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B6727057C;
	Tue, 29 Apr 2025 04:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ADyk8auf"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C757149C7B
	for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 04:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745899980; cv=none; b=tO+BYex1VRmY/5+6HHBrCwwUbVj6B1JoL9csVuSF9EsFfL9te0dhXXVQQ/EKsED5U9zRw3YYB2enN3peYTSxc3LtzsPHBOhX5T03yjbR0447pf9sO2ldsHG7alyjU1bqDFafRxhfrL93qGmcDyGxV/V3GS7toP0O9SN/6xNEWXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745899980; c=relaxed/simple;
	bh=ShHw7jCZXf6bRe8d8R7dZgVKyyOcGAGwPo4/PcdiEWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M2nappoEZFi7zdDzVcnGbnkVniDeTC4H1HTrIP0Wk7WNqr+nGe7uvRrgK7ZUhYeDRCUXGp5Fh+wW9aXEG2CkE6tJLk2slZgjBdhZZzrL/RBIOD55zMP21PrRikA8azWGEF2kYuXwjiyJ7EvvBCzOh1p54VR19lkVVmxEjE/7txw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ADyk8auf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745899977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bvfTDw7WFGQFZCuai1UFLFcXSBfdhaz2G1qzNhhRZTE=;
	b=ADyk8aufjHhvEN0GTBNi6YxgsMOTbNF7rcHenCFZb8o35o5+IhZ8vcORfctcmiA5z+Le7D
	NRB1aNb0mbpoNmKkfA0fhv18ncegFvv97hU/SMrNv7ZiQy/fyGh7MlLN4S3KYVykj8PhiJ
	SCnKS1hrSo2CZqwbqMI8z6dEe3r8LOw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-SAR_GK3BPfeZARmAM19J-g-1; Tue,
 29 Apr 2025 00:12:55 -0400
X-MC-Unique: SAR_GK3BPfeZARmAM19J-g-1
X-Mimecast-MFC-AGG-ID: SAR_GK3BPfeZARmAM19J-g_1745899973
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A30A41800360;
	Tue, 29 Apr 2025 04:12:52 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.64])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 70C3D180045B;
	Tue, 29 Apr 2025 04:12:41 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
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
	bpf@vger.kernel.org
Subject: [RFCv2 1/7] kexec_file: Make kexec_image_load_default global visible
Date: Tue, 29 Apr 2025 12:12:08 +0800
Message-ID: <20250429041214.13291-2-piliu@redhat.com>
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

In latter patches, PE format parser will extract the linux kernel inside
and try its real format parser. So making kexec_image_load_default
global.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>
To: kexec@lists.infradead.org
---
 include/linux/kexec.h | 1 +
 kernel/kexec_file.c   | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index c8971861521a5..26398b269ac29 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -148,6 +148,7 @@ extern const struct kexec_file_ops * const kexec_file_loaders[];
 
 int kexec_image_probe_default(struct kimage *image, void *buf,
 			      unsigned long buf_len);
+void *kexec_image_load_default(struct kimage *image);
 int kexec_image_post_load_cleanup_default(struct kimage *image);
 
 /*
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index fba686487e3b5..6a72bdfab5f5c 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -65,7 +65,7 @@ int kexec_image_probe_default(struct kimage *image, void *buf,
 	return ret;
 }
 
-static void *kexec_image_load_default(struct kimage *image)
+void *kexec_image_load_default(struct kimage *image)
 {
 	if (!image->fops || !image->fops->load)
 		return ERR_PTR(-ENOEXEC);
-- 
2.49.0


