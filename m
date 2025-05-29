Return-Path: <bpf+bounces-59262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB75AC7711
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 06:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 016991C01FC9
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 04:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4C024E4B4;
	Thu, 29 May 2025 04:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ry9yi11T"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42037EEAA
	for <bpf@vger.kernel.org>; Thu, 29 May 2025 04:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748492335; cv=none; b=EZQStENQXxyhYRI33MdO71wVOz4L68NulhBo/POIQiympp7lF/g3ex9GtXE3VAU++8k2RK8uVa19sw1gOczWarGA6czviU5iuHEXaiYzfyri7uRK868/mvuZ2wqmQ3jKkEa4D09Vwr0cJhrku4AD48yIGupiisFxTF1RDHmasuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748492335; c=relaxed/simple;
	bh=VWc8sBhzhcvA7Ylkfs0vK4jSX+l+AD4vk6QHVGlbidg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CNZS6Ns6FZlqaUP0kNxr2YzbpFjoN2wgk8FVyEEqh88RyuBK8W7v2ASPqT2isXMIN4eUJPKaZ6tX2O1sYNILiY8eiDizXSp1sJQ6VAecTTZy5eieIumMlviJ5+v4SXzBA+SIDXr0BRM+XQJYh6nZZSqHdHmigVZZBPx0P4oH3Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ry9yi11T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748492333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r4Ki9z0ShHf2vySh7hI3sELvA68yXo/Rw604jsSCFYw=;
	b=Ry9yi11TqZyyYKD8hIj6nfrNU26QtvhjUlqQ0I3gmbevDLNHRsF1iLRzytIug3IJpa7aGB
	Etihn8D5fd0NPBFmrqrDMrqt2VxfHixMzlFN2u6qCQMMbdSjsnHYemuYiLaK3Q67fU0bPh
	lrL4pVdumC+7QlQ1hJaVOG2IluB/ocA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-4lVwXHmcNwS6Hn_h41fmww-1; Thu,
 29 May 2025 00:18:51 -0400
X-MC-Unique: 4lVwXHmcNwS6Hn_h41fmww-1
X-Mimecast-MFC-AGG-ID: 4lVwXHmcNwS6Hn_h41fmww_1748492329
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47F331956086;
	Thu, 29 May 2025 04:18:48 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.18])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1AEEC18003FC;
	Thu, 29 May 2025 04:18:36 +0000 (UTC)
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
Subject: [PATCHv3 1/9] kexec_file: Make kexec_image_load_default global visible
Date: Thu, 29 May 2025 12:17:36 +0800
Message-ID: <20250529041744.16458-2-piliu@redhat.com>
In-Reply-To: <20250529041744.16458-1-piliu@redhat.com>
References: <20250529041744.16458-1-piliu@redhat.com>
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


