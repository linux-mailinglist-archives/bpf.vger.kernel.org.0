Return-Path: <bpf+bounces-9126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BDB7903E9
	for <lists+bpf@lfdr.de>; Sat,  2 Sep 2023 01:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A30DD281991
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 23:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920F913AD3;
	Fri,  1 Sep 2023 23:11:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A657AD53
	for <bpf@vger.kernel.org>; Fri,  1 Sep 2023 23:11:57 +0000 (UTC)
Received: from out-238.mta0.migadu.com (out-238.mta0.migadu.com [91.218.175.238])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDC6E56
	for <bpf@vger.kernel.org>; Fri,  1 Sep 2023 16:11:55 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1693609913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KBHcFz2ZEJKZ2HGokV8y/4x871h9BEY1YxIxFYVPbwE=;
	b=IjGWGo/2UHC9uUQHbxGsSncJhE/c6MOtENy6iHyU0UXi2EKFaRO0nlC8TZIvAgOyT47wEc
	3XC47wiZULgYQwTYKQw6t2Q/k2hlTtQubJwDRARq988T3x78sN0EhAfbIY1kpB2tZRH0Pe
	XQ0/lM4mDgr+iJl3bnhLRmMEAyr1TOM=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf 0/3] bpf: Fixes for bpf_sk_storage
Date: Fri,  1 Sep 2023 16:11:26 -0700
Message-Id: <20230901231129.578493-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Martin KaFai Lau <martin.lau@kernel.org>

This set has two fixes for bpf_sk_storage. Please see the individual
patch for details.

Martin KaFai Lau (3):
  bpf: bpf_sk_storage: Fix invalid wait context lockdep report
  bpf: bpf_sk_storage: Fix the missing uncharge in sk_omem_alloc
  selftests/bpf: Check bpf_sk_storage has uncharged sk_omem_alloc

 kernel/bpf/bpf_local_storage.c                | 49 +++++----------
 .../bpf/prog_tests/sk_storage_omem_uncharge.c | 56 +++++++++++++++++
 .../selftests/bpf/progs/bpf_tracing_net.h     |  1 +
 .../bpf/progs/sk_storage_omem_uncharge.c      | 61 +++++++++++++++++++
 4 files changed, 133 insertions(+), 34 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sk_storage_omem_uncharge.c
 create mode 100644 tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c

-- 
2.34.1


