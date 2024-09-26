Return-Path: <bpf+bounces-40334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EB3986C5D
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 08:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B243A1F25ADA
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 06:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2D5185941;
	Thu, 26 Sep 2024 06:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W90m0nBl"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4DE176AA3
	for <bpf@vger.kernel.org>; Thu, 26 Sep 2024 06:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727331520; cv=none; b=HyWcPOAGD6IWsSNIjul/0tMTm1DGttQSqEO1BeNdbnWHWyMmWkrGCD/dis3y5WPDQOA1SNqOQki6QSKaNKHov83b2CQ+LolzseA7KUgl8os2HL6ujgQUsT/sbRQaywQhp3RHyS16rhaMVvcfkLINoWUhBVp1NZ946Kr44fn+pvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727331520; c=relaxed/simple;
	bh=G5A3xHn3VOnEZc0GF4sWRjOFd/sQe+mHNa7TJ/15GNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HeeT/fuxS4cLMi7BHUKQNTNsLMcR71XUfuFftbqpZMWTeJuVymxICy3y16U35yz9JlnOJ40H8pMnRinewLy2SY4kVsnt0Oh0q7+nuVeTW7hhwQCTXpmu8gwgrPZ7z0H03uHruCBwEs91LLbbNO/I55q6CUZ17Y3vpm7/+XZKdj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W90m0nBl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727331517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EDH6AlxCejmXjqG7byAaPpg8myKFLxd33H22AuOsLxc=;
	b=W90m0nBlwDrhvAvFbr8XGKEqmV8SchrShnu5qvVgDuhCcSkar1s4NpcGufEtza5A6GIIHd
	8XGu+AVGzwmSm/CkCw+DSS+dZGfYbJC20RhdGW7k8c+wMRdCZ+eOIjDfXhfo5rfnMZLzUS
	EdhSIj9bLr+cpG4d1spuJ4qiA3usgGM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-OVi7pbgfOpWRIcAnVaAO3w-1; Thu,
 26 Sep 2024 02:18:34 -0400
X-MC-Unique: OVi7pbgfOpWRIcAnVaAO3w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D5DA18FFA7D;
	Thu, 26 Sep 2024 06:18:32 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.224.3])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 83EA819560A3;
	Thu, 26 Sep 2024 06:18:27 +0000 (UTC)
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
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next 0/2] bpf: Add kfuncs for read-only string operations
Date: Thu, 26 Sep 2024 08:18:20 +0200
Message-ID: <cover.1727329823.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Kernel contains highly optimised implementation of traditional string
operations. Expose them as kfuncs to allow BPF programs leverage the
kernel implementation instead of needing to reimplement the operations.

These will be very helpful to bpftrace as it now needs to implement all
the string operations in LLVM IR.

Viktor Malik (2):
  bpf: Add kfuncs for read-only string operations
  selftests/bpf: Add tests for string kfuncs

 kernel/bpf/helpers.c                          |  66 ++++++
 .../selftests/bpf/prog_tests/string_kfuncs.c  |  37 +++
 .../selftests/bpf/progs/test_string_kfuncs.c  | 215 ++++++++++++++++++
 3 files changed, 318 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_string_kfuncs.c

-- 
2.46.0


