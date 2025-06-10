Return-Path: <bpf+bounces-60139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 992EBAD31BE
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 11:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9193F18835FE
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 09:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7C228B412;
	Tue, 10 Jun 2025 09:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fa5nxdUp"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F412E28B401
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 09:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749547188; cv=none; b=RBG2D06/6aUDJmhPtwDM7iwqJ6zrjLK6rJNdhHWl7/bxqxS/t46mwAz9dC+QsAbTfgnS2RGqHfSTEV+A/GqiSau5zHk1uSHGe0+X7Wjc6clcO6PpRKn/C/ejOwtYkJuyqaPbnhlmZLEhKG5tfZFVSClXhlqO2k689bHKDgOfApQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749547188; c=relaxed/simple;
	bh=ltjpKWi1t7lbiS/wQUL0JGtR6xxe81f0cE/kMQ+SMZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N6Y9OtcTzpYxYzA2c9stSLt1SLbEG+lQpvFbdjzCBrfGBDE1f7CgwAUYOl5CZf2DYlEF7k3H40iGh8utd+VFL6reg9R3e0DtnCDCV/+zXgnnyeVr5rurUJgJUgcD+aPCerG35ySMCKXheNGO3GrMVe+JKjiQb845sA8xt6697FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fa5nxdUp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749547185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QIyeiHyJh2LLkv/UD+/4q8cYY7zOw5NP6NFKW3iCjws=;
	b=fa5nxdUpxJVpigL1jXr/3iVRstgDB6JBAaB8NpFfb94bdpRtZ3ENzj4R+Wq5spA8AB5V/M
	xqerqB5oGk0eD1RaZTIVn9iHMGktVzblWkR3NNfeG2t83v8/mEuPeLPcLLx9VLikX+QqHx
	BEenNhPWKwER04lG3yGYnvvgonfVjSc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-h22P7FUaMCq4i0r-ayQMAQ-1; Tue,
 10 Jun 2025 05:19:44 -0400
X-MC-Unique: h22P7FUaMCq4i0r-ayQMAQ-1
X-Mimecast-MFC-AGG-ID: h22P7FUaMCq4i0r-ayQMAQ_1749547183
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F393818002EC;
	Tue, 10 Jun 2025 09:19:42 +0000 (UTC)
Received: from fedora (unknown [10.45.225.84])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 7E3C530001B1;
	Tue, 10 Jun 2025 09:19:39 +0000 (UTC)
Received: by fedora (sSMTP sendmail emulation); Tue, 10 Jun 2025 11:19:38 +0200
From: "Jerome Marchand" <jmarchan@redhat.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-kernel@vger.kernel.org,
	Yonghong Song <yonghong.song@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Jerome Marchand <jmarchan@redhat.com>
Subject: [PATCH v2 1/2] bpf: Specify access type of bpf_sysctl_get_name args
Date: Tue, 10 Jun 2025 11:19:32 +0200
Message-ID: <20250610091933.717824-2-jmarchan@redhat.com>
In-Reply-To: <20250610091933.717824-1-jmarchan@redhat.com>
References: <20250527165412.533335-1-jmarchan@redhat.com>
 <20250610091933.717824-1-jmarchan@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The second argument of bpf_sysctl_get_name() helper is a pointer to a
buffer that is being written to. However that isn't specify in the
prototype.

Until commit 37cce22dbd51a ("bpf: verifier: Refactor helper access
type tracking"), all helper accesses were considered as a possible
write access by the verifier, so no big harm was done. However, since
then, the verifier might make wrong asssumption about the content of
that address which might lead it to make faulty optimizations (such as
removing code that was wrongly labeled dead). This is what happens in
test_sysctl selftest to the tests related to sysctl_get_name.

Add MEM_WRITE flag the second argument of bpf_sysctl_get_name().

Signed-off-by: Jerome Marchand <jmarchan@redhat.com>
---
 kernel/bpf/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 84f58f3d028a3..76994c204b503 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2104,7 +2104,7 @@ static const struct bpf_func_proto bpf_sysctl_get_name_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_WRITE,
 	.arg3_type	= ARG_CONST_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 };
-- 
2.49.0


