Return-Path: <bpf+bounces-65938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A340AB2B5E5
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 03:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64134620DBC
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 01:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9865A1DF265;
	Tue, 19 Aug 2025 01:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YNMt2ztB"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3111D514E
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 01:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755566723; cv=none; b=sldvL3d7ixPzweLNCw+5qD2A7EvJ9rDLZNL9m8eBBUhMfkOunLl6OwJ9LlbVSowNYgzKfVpak0+qKRx2sRtVSgWvGlrOPduuHWyKqtU7DNyPMOVmLjv4rlMEl0Hh20ojXAVtfulAEVe8wqXlKahM21HON4QJtvOES0UZvlWL74c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755566723; c=relaxed/simple;
	bh=3re+fj6m54UY0vLXYhNF4NNMXcTwKCYl6GXcVbKCvVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WFOcAtFwqcTB8wefC8bNVMxiTgLAzOwAMCG8R3YuWGEmFdiFfdyZ1mquPBlCADah0u1EXaE7+k0iU3/gL1Gjk+SK25Dj+s6lw/ULQrA/J+W39Vhy8PAsQGEhSz+E0A5TykPIe8RcXgDoNC2wfPmCtuMwfu9/D4hzvxqIUmQSX0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YNMt2ztB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755566720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=To+XQ2ONtZTSYENZTGXdVesU6BPlLZ0Diu5MXvTKFs0=;
	b=YNMt2ztB/THiAlIn43QYKgh548/opdcx0PmxWy21SA7EP7CbWNkhH9vcMsFPguDJs/05C8
	3uZ/904euLdB/u9HYsxSUykqtZ1gluKkSsQz+DMa/V0BR+Xs2hTlXZRpcIJ6+SnQEdRbxj
	UAW/LcFYnT3QvtMd/Octs/QD53z2A3I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-rN8gDTs7Plqv-WJ3A2Yn9Q-1; Mon,
 18 Aug 2025 21:25:18 -0400
X-MC-Unique: rN8gDTs7Plqv-WJ3A2Yn9Q-1
X-Mimecast-MFC-AGG-ID: rN8gDTs7Plqv-WJ3A2Yn9Q_1755566716
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C0B1B180048E;
	Tue, 19 Aug 2025 01:25:15 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.36])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3B6C3180028A;
	Tue, 19 Aug 2025 01:25:02 +0000 (UTC)
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
	bpf@vger.kernel.org,
	systemd-devel@lists.freedesktop.org
Subject: [PATCHv5 01/12] kexec_file: Make kexec_image_load_default global visible
Date: Tue, 19 Aug 2025 09:24:17 +0800
Message-ID: <20250819012428.6217-2-piliu@redhat.com>
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
index 1b10a5d84b68c..7bd7f8a25dd59 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -158,6 +158,7 @@ extern const struct kexec_file_ops * const kexec_file_loaders[];
 
 int kexec_image_probe_default(struct kimage *image, void *buf,
 			      unsigned long buf_len);
+void *kexec_image_load_default(struct kimage *image);
 int kexec_image_post_load_cleanup_default(struct kimage *image);
 
 /*
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 91d46502a8174..4780d8aae24e7 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -80,7 +80,7 @@ int kexec_image_probe_default(struct kimage *image, void *buf,
 	return ret;
 }
 
-static void *kexec_image_load_default(struct kimage *image)
+void *kexec_image_load_default(struct kimage *image)
 {
 	if (!image->fops || !image->fops->load)
 		return ERR_PTR(-ENOEXEC);
-- 
2.49.0


