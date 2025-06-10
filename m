Return-Path: <bpf+bounces-60138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BB4AD31B0
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 11:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCC9F3A4FF7
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 09:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597B528B3ED;
	Tue, 10 Jun 2025 09:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HIqrOtMA"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97B127AC4C
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 09:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749547185; cv=none; b=ZRpZSicWqMO8wSEww6kxqFiFvHjpGEo5Rm6zuDJKjMoMBnfG5gBB9XvSAS8NMkh0Jw/Ai1tUKJVTGw52oDXnCY5C5m09i7Y4bOpAk0JBMjwMHVzcUB4WdYT23DE5noAwJuM8x8HeXiy1jekG7v3do/eO5ZNfk5FUH6eK1C3If58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749547185; c=relaxed/simple;
	bh=qp+safo5HWGt5ZdIpiZb5RfnsN3Ot7uFR0kRUUYtDS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJu3KfoEZCAyNuFW/Z8mhqLQXdNHAAiUjki8gSqEbar66TmPEVw7CQWebeiunHLxvECt1rrmB+PMMp9Yp1x7DAmRRhNoaePcCoXrYXOW7fU6qSgtz1R1etiuPAOQIrIDLdFGGwPOxrWF1tKu7TyQD0CTRuYOrP90gVbdUF4WzIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HIqrOtMA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749547181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tgIiJFlARtDTBJPtFaz8P3NffupBnsifcaDfHJG+stU=;
	b=HIqrOtMABFFfL9BBVGQiJgPj07BjsYB0yqw62X10GKIpyLb3WzQ9i+WXwoJJ3Z5fL16iHw
	tZNE6Entt3mY7f+pVAqCcKvfq11jRA8VGvMdux4mhJ/92m8X61KF7p93FUd3O3Bytx94RP
	dAmYSNcXpFFpteqJhej1mfFS4hV9gHA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-296-sAx6Nh2nML-2FVM8fDWEHw-1; Tue,
 10 Jun 2025 05:19:39 -0400
X-MC-Unique: sAx6Nh2nML-2FVM8fDWEHw-1
X-Mimecast-MFC-AGG-ID: sAx6Nh2nML-2FVM8fDWEHw_1749547178
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 05F9B19560B0;
	Tue, 10 Jun 2025 09:19:38 +0000 (UTC)
Received: from fedora (unknown [10.45.225.84])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 3BEF01956087;
	Tue, 10 Jun 2025 09:19:34 +0000 (UTC)
Received: by fedora (sSMTP sendmail emulation); Tue, 10 Jun 2025 11:19:33 +0200
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
Subject: [PATCH v2 0/2] bpf: Specify access type of bpf_sysctl_get_name args
Date: Tue, 10 Jun 2025 11:19:31 +0200
Message-ID: <20250610091933.717824-1-jmarchan@redhat.com>
In-Reply-To: <20250527165412.533335-1-jmarchan@redhat.com>
References: <20250527165412.533335-1-jmarchan@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

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

Changes in v2:
 - Replace ARG_PTR_TO_UNINIT_MEM by ARG_PTR_TO_MEM | MEM_WRITE.
 - Converts test_sysctl to prog_tests.

Jerome Marchand (2):
  bpf: Specify access type of bpf_sysctl_get_name args
  selftests/bpf: Convert test_sysctl to prog_tests

 kernel/bpf/cgroup.c                           |  2 +-
 tools/testing/selftests/bpf/.gitignore        |  1 -
 tools/testing/selftests/bpf/Makefile          |  5 ++-
 .../bpf/{ => prog_tests}/test_sysctl.c        | 32 ++++---------------
 4 files changed, 10 insertions(+), 30 deletions(-)
 rename tools/testing/selftests/bpf/{ => prog_tests}/test_sysctl.c (98%)

-- 
2.49.0


