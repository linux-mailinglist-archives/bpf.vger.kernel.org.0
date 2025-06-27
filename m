Return-Path: <bpf+bounces-61737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 935D9AEB11C
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 10:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B6861BC1CD6
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 08:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A8322A4E5;
	Fri, 27 Jun 2025 08:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+eKRd8h"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AA01DC9B8
	for <bpf@vger.kernel.org>; Fri, 27 Jun 2025 08:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751012423; cv=none; b=gZcAfcAT7D4Q2y16+i82CJLOSpDmBEXa7WsEDhXnBi99QWuWqPdOfpQu6yjskm+h0d0CojmzW62ysXbxxtKol1/BbYcvA6Rkhtmuvr4x8zVuw93C55UK46OX58inxaLRWL7VeE/+gUrEOMkYQLVRmK916W3aMI+yMVPKFzsy2q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751012423; c=relaxed/simple;
	bh=vV71196NNzG38a/OQbaoM/DAVq2xEjxFr9aI98bR+E4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TO3jxklVrY7alFWkkbHSZkJFjEv0MEQ1jt0rlKwnrYSfPErAbDGY4Nl/lFoLCUu1GrEsYntk8fiAfSQ1lWTSdyRCqsqnTum+SeW3dzlr33O8tzN9vqtQVxAie0UXGQUe2YzCOimtox4FS5T4hfoaTCiJ5G+YA//qzrqs/m1U3WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i+eKRd8h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751012420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4FgB+hppyuYgSJ7DUk5fmzmCO/nlRHcyEDnv9eMB6j0=;
	b=i+eKRd8hSTyyky3z+gILzmqc9KptilE/mZe0F2spWNC36914sNi68wW1/X2lPACOFdMUtk
	HRcmYCvHJCdXbU9nQZfz3v5S4+KXC0PdZyWZbWPlqlJwQp5PtTCpflg8MjAUf/JNTLaJC+
	kIy2Ywp+/YQEYMXv/AvTj9bIIHFKSaY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-363-BM5TWtTgNSyQRU2zNVNI2A-1; Fri,
 27 Jun 2025 04:20:16 -0400
X-MC-Unique: BM5TWtTgNSyQRU2zNVNI2A-1
X-Mimecast-MFC-AGG-ID: BM5TWtTgNSyQRU2zNVNI2A_1751012414
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 42EA91800287;
	Fri, 27 Jun 2025 08:20:13 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.44.32.95])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB2AD19560A2;
	Fri, 27 Jun 2025 08:20:06 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Viktor Malik <vmalik@redhat.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH bpf-next] bpf: Fix string kfuncs names in doc comments
Date: Fri, 27 Jun 2025 10:20:01 +0200
Message-ID: <20250627082001.237606-1-vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Documentation comments for bpf_strnlen and bpf_strcspn contained
incorrect function names.

Fixes: e91370550f1f ("bpf: Add kfuncs for read-only string operations")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/bpf/20250627174759.3a435f86@canb.auug.org.au/T/#u
Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 kernel/bpf/helpers.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6d051416c184..b4117681137e 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3451,7 +3451,7 @@ __bpf_kfunc int bpf_strrchr(const char *s__ign, int c)
 }
 
 /**
- * bpf_strlen - Calculate the length of a length-limited string
+ * bpf_strnlen - Calculate the length of a length-limited string
  * @s__ign: The string
  * @count: The maximum number of characters to count
  *
@@ -3541,8 +3541,8 @@ __bpf_kfunc int bpf_strspn(const char *s__ign, const char *accept__ign)
 }
 
 /**
- * strcspn - Calculate the length of the initial substring of @s__ign which
- *           does not contain letters in @reject__ign
+ * bpf_strcspn - Calculate the length of the initial substring of @s__ign which
+ *               does not contain letters in @reject__ign
  * @s__ign: The string to be searched
  * @reject__ign: The string to search for
  *
-- 
2.50.0


