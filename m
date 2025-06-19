Return-Path: <bpf+bounces-61080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67998AE0842
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 16:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E773AB136
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 14:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC3F286893;
	Thu, 19 Jun 2025 14:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lk6R81/J"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A102737EB
	for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 14:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750341978; cv=none; b=Jb2WnIjNWkDA+kh3XPgHqxlmo2w0KQDH8YOlFs4RhCukZ0FE10uvdXY/bOj89HG8K/sWtvgPd3yzEok+u3h9I4aeADMcRfjSidnCtYL4uKXbIBzKMDEJgqi//IxyICNMs8/5ZpXOktg+A33kzCIBf3zx0Okpb+v0FQORcAdnd/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750341978; c=relaxed/simple;
	bh=nFfYI/rXd1fAzj6l4qfTfO5yFM0HFV2xA44YFfMXIm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GP76uZP4pmepXGCtdrVz3Bco0bV2puihhXxVeWVDRG6FD0YWWR2Fk7oCMXnpKkm7v39bCmBi7Xh2ReezKPUAjX35JS88QPmrEPhAam2rJqDXQeZCf+S01Epwai5JOFRd9EDJlg7bs3hTKZqkHyQBtwireRGeT7d6wkIhL6bEor0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lk6R81/J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750341975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=u476X32Vev4yniOeqMRFA8gNv0bvwwmmxlvE2dQmeNY=;
	b=Lk6R81/JkfuZwMogKDYNszT4AbGqwERmkULZrsOonAOUUIlIoiz1afev1YZf9m9VitlLDF
	yMco7Kx1xeRtN+dXONvO6BUlED0FQgEOS+4oTDCwSQGyqMzmyqMc9EomuObjAMH5x7qICO
	6CrRTAFNB/70J9wuaaQKDBvN+WA2ORk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-6dJBMj_cMgmW3ziJdnbxLw-1; Thu,
 19 Jun 2025 10:06:11 -0400
X-MC-Unique: 6dJBMj_cMgmW3ziJdnbxLw-1
X-Mimecast-MFC-AGG-ID: 6dJBMj_cMgmW3ziJdnbxLw_1750341970
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A7DF01808993;
	Thu, 19 Jun 2025 14:06:09 +0000 (UTC)
Received: from fedora (unknown [10.45.226.41])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4C37619560B2;
	Thu, 19 Jun 2025 14:06:04 +0000 (UTC)
Received: by fedora (sSMTP sendmail emulation); Thu, 19 Jun 2025 16:06:03 +0200
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
Subject: [PATCH v3 0/2] bpf: Specify access type of bpf_sysctl_get_name args
Date: Thu, 19 Jun 2025 16:06:01 +0200
Message-ID: <20250619140603.148942-1-jmarchan@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The second argument of bpf_sysctl_get_name() helper is a pointer to a
buffer that is being written to. However that isn't specify in the
prototype. Until commit 37cce22dbd51a ("bpf: verifier: Refactor helper
access type tracking") that mistake was hidden by the way the verifier
treated helper accesses. Since then, the verifier, working on wrong
infromation from the prototype, can make faulty optimization that
would had been caught by the test_sysctl selftests if it was run by
the CI.

The first patch fixes bpf_sysctl_get_name prototype.

The second patch converts the test_sysctl to prog_tests so that it
will be run by the CI and catch similar issues in the future.

Changes in v3:
 - Use ASSERT* macro instead of CHECK_FAIL.
 - Remove useless code.

Changes in v2:
 - Replace ARG_PTR_TO_UNINIT_MEM by ARG_PTR_TO_MEM | MEM_WRITE.
 - Converts test_sysctl to prog_tests.

Jerome Marchand (2):
  bpf: Specify access type of bpf_sysctl_get_name args
  selftests/bpf: Convert test_sysctl to prog_tests

 kernel/bpf/cgroup.c                           |  2 +-
 tools/testing/selftests/bpf/.gitignore        |  1 -
 tools/testing/selftests/bpf/Makefile          |  5 +--
 .../bpf/{ => prog_tests}/test_sysctl.c        | 37 ++++---------------
 4 files changed, 11 insertions(+), 34 deletions(-)
 rename tools/testing/selftests/bpf/{ => prog_tests}/test_sysctl.c (98%)

-- 
2.49.0


