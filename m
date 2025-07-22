Return-Path: <bpf+bounces-63980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 994C0B0CF7D
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 04:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E1D5189172B
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 02:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE40FEC5;
	Tue, 22 Jul 2025 02:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="euVZpdbK"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB96C86328
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 02:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753149853; cv=none; b=b/JwZmKIf4fOFmPoXEthJL7sfhaoi4CilCHrYyIaML3zGle474T9p7jWrAx5UtowxJ9PQsLn1q6eQb2ARlXWpCZqj5iEOO8mWBAsEduify9j1CnRtrPH5cXeJxxUPSqhnaXjDAuhjCgiy9wPdH34yixzsoKIwiKx3hN5YRMdGFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753149853; c=relaxed/simple;
	bh=OUX1aHxoIvHTlEAOzIF7czAvEAV3ysVQrf2qgn/3HqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rCwspME51AW0U+Yukkuif6ltp6Se1IwIM1FqD8esa6jXHdMhmvKQddp97PnxfbzGAuFJJ6NdL6ebPT9InMiOSPrcm7LRu6Syw6Cj5eIAYUmAjY0p4wz8HROx5DbOR9ta4buyDWiiz5EmJfjOnK3Q64Sbe5wMk75dEEvT+AMMkUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=euVZpdbK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753149849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d1kId2e7KIkFMRhhlju2vk28yIM+A7bIIRnD6ohEW/Y=;
	b=euVZpdbKLvbRw4bO41AtwlzfyJQdllJhuAf8tk2hZML1UbOgRHWOxlviNj5JmuTWVC4Ksp
	hrxHIk/CCjsDCZ8lab2VwgZUZg5pMxh+NBZE+xo8/Kq9Oxx1UKPhgF3SAvR5urD1tvn9Os
	ca+xVuEbAFfTpX6/ZVF1ztHHX0RxQWs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237--IdnhXX8N0WogFAhXLsJJw-1; Mon,
 21 Jul 2025 22:04:05 -0400
X-MC-Unique: -IdnhXX8N0WogFAhXLsJJw-1
X-Mimecast-MFC-AGG-ID: -IdnhXX8N0WogFAhXLsJJw_1753149843
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 23E9A180028D;
	Tue, 22 Jul 2025 02:04:03 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.104])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7919318004AD;
	Tue, 22 Jul 2025 02:03:52 +0000 (UTC)
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
	Andrew Morton <akpm@linux-foundation.org>,
	bpf@vger.kernel.org
Subject: [PATCHv4 01/12] kexec_file: Make kexec_image_load_default global visible
Date: Tue, 22 Jul 2025 10:03:08 +0800
Message-ID: <20250722020319.5837-2-piliu@redhat.com>
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

In latter patches, PE format parser will extract the linux kernel inside
and try its real format parser. So making kexec_image_load_default
global.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
To: kexec@lists.infradead.org
---
 include/linux/kexec.h | 1 +
 kernel/kexec_file.c   | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 03f85ad03025b..3a2b9b4fffa18 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -152,6 +152,7 @@ extern const struct kexec_file_ops * const kexec_file_loaders[];
 
 int kexec_image_probe_default(struct kimage *image, void *buf,
 			      unsigned long buf_len);
+void *kexec_image_load_default(struct kimage *image);
 int kexec_image_post_load_cleanup_default(struct kimage *image);
 
 /*
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 69fe76fd92334..c92afe1a3aa5e 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -79,7 +79,7 @@ int kexec_image_probe_default(struct kimage *image, void *buf,
 	return ret;
 }
 
-static void *kexec_image_load_default(struct kimage *image)
+void *kexec_image_load_default(struct kimage *image)
 {
 	if (!image->fops || !image->fops->load)
 		return ERR_PTR(-ENOEXEC);
-- 
2.49.0


