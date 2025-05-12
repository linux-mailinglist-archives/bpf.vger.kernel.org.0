Return-Path: <bpf+bounces-58015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE378AB3A05
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 16:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4667919E05B4
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 14:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A897A1E32D5;
	Mon, 12 May 2025 14:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ikXyGOmH"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A121E3DD6
	for <bpf@vger.kernel.org>; Mon, 12 May 2025 14:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747058709; cv=none; b=Ws3nbqDdJisOmm6tL87lole8Y4nX4hyuqxGlvoKYT/uozT+tUkWVJ2F2OKFk4m6Y54BJ80PIRdNSs8Dxax7TAFk/7DYamTKXQJxG+YPpiKJoeQxd5qkpHGbHP31gJy0jRu6FilGXneNf1IMY+eRBqkwrGsP/iK7r8RKklSNnYbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747058709; c=relaxed/simple;
	bh=4aP75RitRUVnTQQTp/YjKO4gcw5/6HTjDWuy2H2nvBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hl2s+nA7JxbFmz6Mhy9tqmOgzgSgTtrH11koSHlxTSU2Uk3KMuKwsSKxhLYsVmlEYoNMe5m8QQiS/H+gj+r3lCx9wJhJGmwZ8SDTaU/vmkDORA6PBMzZHDoksGw6hb9Eiag/H01G10URULwyt3vAqhK/4cmHcCotoqrk8kUKOOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ikXyGOmH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747058706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z2lY/QPUwXXwhVHlAF2o+kXeAxox1vdidjJfq4kxvcM=;
	b=ikXyGOmHrq/3aOsMxhEIDmLvf+he1CRisXa+taxiopKjSYkk99w3VV9BehwCyz4+oQwDOp
	qkY23fL1tHftpyONcQBGlysWluqQFbpWVZqAIValwjI0Dc7ioXdw3JfD96RJ3H09pmofig
	07VWPUscm2ltLBvACKTuS/Ue3Vy5oTo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-x0ZIpD2VMh6kx_6BTaCXOQ-1; Mon,
 12 May 2025 10:05:02 -0400
X-MC-Unique: x0ZIpD2VMh6kx_6BTaCXOQ-1
X-Mimecast-MFC-AGG-ID: x0ZIpD2VMh6kx_6BTaCXOQ_1747058699
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 026D1180010A;
	Mon, 12 May 2025 14:04:59 +0000 (UTC)
Received: from grbell-thinkpadx1carbongen9.rmtusnh.csb (unknown [10.22.88.193])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 63172180087C;
	Mon, 12 May 2025 14:04:55 +0000 (UTC)
From: Gregory Bell <grbell@redhat.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	Gregory Bell <grbell@redhat.com>
Subject: [PATCH bpf-next 1/2] selftests/bpf: test_verifier verbose causes erroneous failures
Date: Mon, 12 May 2025 10:04:12 -0400
Message-ID: <182bf00474f817c99f968a9edb119882f62be0f8.1747058195.git.grbell@redhat.com>
In-Reply-To: <cover.1747058195.git.grbell@redhat.com>
References: <cover.1747058195.git.grbell@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

When running test_verifier with the -v flag and a test with
`expected_ret==VERBOSE_ACCEPT`, the opts.log_level is unintentionally
overwritten because the verbose flag takes precedence. This leads to
a mismatch in the expected and actual contents of bpf_vlog, causing
tests to fail incorrectly.

Reorder the conditional logic that sets opts.log_level to preserve
the expected log level and prevent it from being overridden by -v.

Signed-off-by: Gregory Bell <grbell@redhat.com>
---
 tools/testing/selftests/bpf/test_verifier.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 447b68509d76..2d13e862b078 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -1559,10 +1559,10 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 		       test->errstr_unpriv : test->errstr;
 
 	opts.expected_attach_type = test->expected_attach_type;
-	if (verbose)
-		opts.log_level = verif_log_level | 4; /* force stats */
-	else if (expected_ret == VERBOSE_ACCEPT)
+	if (expected_ret == VERBOSE_ACCEPT)
 		opts.log_level = 2;
+	else if (verbose)
+		opts.log_level = verif_log_level | 4; /* force stats */
 	else
 		opts.log_level = DEFAULT_LIBBPF_LOG_LEVEL;
 	opts.prog_flags = pflags;
-- 
2.49.0


