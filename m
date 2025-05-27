Return-Path: <bpf+bounces-59004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2C7AC5409
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 18:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ADD34A2102
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 16:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D232280A29;
	Tue, 27 May 2025 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UcyIVsIc"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD6828030A
	for <bpf@vger.kernel.org>; Tue, 27 May 2025 16:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748364868; cv=none; b=lFbW+xUXDRJoniAbaGY0coZs5cMWryAQ/C28gxbuQ5Kl7Ky+eHFduG63eaUMYHv/SCNBT2CIvkoSaMn91/ENiFXMWrUl4+Px6UyPaEYtIoCGAE49jigLZud2QGnJqIF+FZ7Yy2lfCisZqP1Ww3cim0MnW8VbrC1uaqIF3PBzmeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748364868; c=relaxed/simple;
	bh=faAyvJ7qDtqhrtzmWY1tEA3zcdDuNWETrdnIodiVYnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oR8foMaUUcurtoKZjtE1rwYNTum9ei7XUkeQ8kvZzfmBDyc9IHiV4ccHGHi9J7zth+A84hMDqKbo6l7WozOTkOEvoA8wR1Oj6VGbCPF6FaWUNiUIVaiMM1/lYQmHBtKD7Bxt5WZU1/CHbKZzm+HdZDYKBhbihozO0LdXenGKFxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UcyIVsIc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748364862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0Azkfo/3THlNlvSSf9IUNcPc6ss/iGQ5ilgF0zN91Xs=;
	b=UcyIVsIcUZXcdvuhuKqcgpTpHUbIoDQAXcR/yBD0Tu29RHnsrN6/vaipqKrsbZKQh3F0tP
	kQ4Xz5CmFsebMMT/wAGc1PUt7i9qUzhGFNmzmtCtsjjp3H18lasZZKsB+p9oNqlX7GsZ/t
	F38U6gXQGYD9UEfNTz8eNl5FY8zLBFU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-Sqm02QwTM5e5RmxdKn-jFg-1; Tue,
 27 May 2025 12:54:19 -0400
X-MC-Unique: Sqm02QwTM5e5RmxdKn-jFg-1
X-Mimecast-MFC-AGG-ID: Sqm02QwTM5e5RmxdKn-jFg_1748364858
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AAEA419560BC;
	Tue, 27 May 2025 16:54:17 +0000 (UTC)
Received: from fedora (unknown [10.44.34.177])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 3CF3930001B0;
	Tue, 27 May 2025 16:54:14 +0000 (UTC)
Received: by fedora (sSMTP sendmail emulation); Tue, 27 May 2025 18:54:12 +0200
From: "Jerome Marchand" <jmarchan@redhat.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-kernel@vger.kernel.org,
	Jerome Marchand <jmarchan@redhat.com>
Subject: [PATCH] bpf: Specify access type of bpf_sysctl_get_name args
Date: Tue, 27 May 2025 18:54:12 +0200
Message-ID: <20250527165412.533335-1-jmarchan@redhat.com>
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

Correctly mark the second argument of bpf_sysctl_get_name() as
ARG_PTR_TO_UNINIT_MEM.

Signed-off-by: Jerome Marchand <jmarchan@redhat.com>
---
 kernel/bpf/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 84f58f3d028a3..09c02a592d24a 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2104,7 +2104,7 @@ static const struct bpf_func_proto bpf_sysctl_get_name_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg3_type	= ARG_CONST_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 };
-- 
2.49.0


