Return-Path: <bpf+bounces-61081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EB1AE0847
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 16:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F02D7A7028
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 14:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AFF28B511;
	Thu, 19 Jun 2025 14:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GVdHzqxm"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0933828B4EC
	for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 14:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750341985; cv=none; b=OCo/cfrT+jpR9pz+GAQhHcNnGmJou9/TQMYj84lEddCY+mLIZHpfTQSeSPBSRp9XtJDY8vnU7fn8A6R1pXiBMUe90ar0JvFL41vhkPEb2M7aHu6bOarMl9ot9oeBkJs2YI5FJhJ4r8Cdvn+TPQJA2ZDIPEJ7nTrTwkPRLl5byGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750341985; c=relaxed/simple;
	bh=ltjpKWi1t7lbiS/wQUL0JGtR6xxe81f0cE/kMQ+SMZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gzMnd4gSSDdYPbB0dMMvmE9fE8g4vgNbUqOXYfmeIT0JEhsSduzskNX/M6s/ahSLubBfC0Vd18urI4XBFjtzA55ahMR+qnql5hhlR5zh3sNxVFJZ/oQLRg8TZgLdtRqU4Q1VgJJmiXX2jiJvV9Ntl0d5xdXUjszq7XLStfMmbIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GVdHzqxm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750341981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QIyeiHyJh2LLkv/UD+/4q8cYY7zOw5NP6NFKW3iCjws=;
	b=GVdHzqxmcEDp2pejM78fTfSEPvwfjCZdWfEV/d4uWCH4tE5ZhsldixyBCueLXxTpmSfzHk
	Ev5qZQY90ZmwA1rOkIZk9b7mqjf05WzdhKjDD3+YWEb9JC4VUPKCnKS+IbyH+EhlGhZLUs
	SCYa+odqbGCwHBuwMsw6GNvnf6yVW5k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-ltaj88ZnMCGh-96liPa8EA-1; Thu,
 19 Jun 2025 10:06:17 -0400
X-MC-Unique: ltaj88ZnMCGh-96liPa8EA-1
X-Mimecast-MFC-AGG-ID: ltaj88ZnMCGh-96liPa8EA_1750341976
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2287A1809C80;
	Thu, 19 Jun 2025 14:06:16 +0000 (UTC)
Received: from fedora (unknown [10.45.226.41])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id CCD93195609D;
	Thu, 19 Jun 2025 14:06:11 +0000 (UTC)
Received: by fedora (sSMTP sendmail emulation); Thu, 19 Jun 2025 16:06:10 +0200
From: "Jerome Marchand" <jmarchan@redhat.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	linux-kernel@vger.kernel.org,
	Jerome Marchand <jmarchan@redhat.com>
Subject: [PATCH v3 1/2] bpf: Specify access type of bpf_sysctl_get_name args
Date: Thu, 19 Jun 2025 16:06:02 +0200
Message-ID: <20250619140603.148942-2-jmarchan@redhat.com>
In-Reply-To: <20250619140603.148942-1-jmarchan@redhat.com>
References: <20250619140603.148942-1-jmarchan@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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


