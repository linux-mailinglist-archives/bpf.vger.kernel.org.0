Return-Path: <bpf+bounces-65140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D7DB1C9BE
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 18:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2702A563986
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 16:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FBF29A332;
	Wed,  6 Aug 2025 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkSyLfUy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C6D1A3165;
	Wed,  6 Aug 2025 16:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754497544; cv=none; b=cVuNmNCUf9PI9smTQlIhxU2nznmEym0H46uOvKJyTyx7IysC+q6BpBnrX0rVI4mmg2KqYC9t4jGdh/FvlkaKzL6h01PayERxMSmaHQpc0icxcPUJj2Rt77sm1n9uW8I/AEIJntJ10scgSt970QqRnCSNwPd96yuqwdcn3Ize1w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754497544; c=relaxed/simple;
	bh=4YCCQk+eiALFvUeq5bAV46broNlB4B5ZgpOoNKr529U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ij3u1u3TtN6VvUss2/kRluaEGyppjyV/4PjJVmpNswqPEmXo45jTjlbCHe7evqxuYHqIKR8dwD9GG1AgEQ1xREOXRVCnHhlY21boM/fRIbdKDUaLCjUdjMJeyRrdSEOc+2GsSWL1g0yUeNjNgSbvimlgITdlJBu2b/7CRV+7yvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VkSyLfUy; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-321461ab4efso110374a91.2;
        Wed, 06 Aug 2025 09:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754497542; x=1755102342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Lo8WJhIr8SLSfDX9vQjRkT/czyhJoedW+cN+qm4ZTY=;
        b=VkSyLfUy8iA/YMXqDgHH8G7cxPRc2w+Lcxba0Fy6QwXUHaepXIwSE6EQiGFQZ3z/Jb
         72iw2wudoGGraoHqnO3uxN0EU5QLvkRWDllbHO0whiKOmkEVdQ/bBY9z3cQF1KnA39Yj
         aHz+7ZImxw1BBN0MA8S51qFgP6s/d3IYppz7cAmmZIFrdu7gg4tqHYv2LUVcRj4Y1dts
         E3O9H1O0+X4TV/6gqe2n4gIKa0nZeW9dhrkUgUoWXnWAw5mGzOyZ9ILYTc+GK3xbnueK
         RkqKwtoO7xR3fu+IqDaqCjDxvYvKVUpLpoJd4pJzy1VYeClkRtwRQHF9nztXU41EldWm
         i7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754497542; x=1755102342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Lo8WJhIr8SLSfDX9vQjRkT/czyhJoedW+cN+qm4ZTY=;
        b=nRI4CeXFgYTWY65e1Lb7wxDCAMRj6iwPR/tqPoFdDW7qVpaBNWG4o5MmI/bj53mBZE
         pMu4yFvFVaJFaHbjgYHB3RcDd7sCQHsW9aoYbmrhzTCdBozjnytRvtiNeMR/L5aeMUga
         1Viz61vSwgSkzToc9tgs6m6fT2i14Xc0CPpXD4yWG5/cI4480A6hp1oVVgC3MBNz2otn
         iNRmd7BT8PBDyIyv+ZPqoy6lbYDI7H7Rc9Orm5+v/IR9tbNWVQ9uu94ogCPacFiVSAJh
         7edefrhXA9ddKxV5hhXBOZAvNFWqkq3xLWyJKXy/sG/g+wW9dlPlqVgCVL3hwiioxEcb
         KyZQ==
X-Gm-Message-State: AOJu0Yx/BcnxEgWacB4ZFxfiHj9Q0IlO6ZkwigIR7/KA9Ao3JtX0XRWe
	ksZyplVL7hQgYK2480jbRVGueRdl1gKLBNZ1CaLZxy7ydCFM5STqSlPTyO+l9w==
X-Gm-Gg: ASbGnctls/KLf83/zt68DvPe9XsOE2aaWsBV1PQpJC+WoBAR4w9r3GNHj4cWqSRyPmr
	nBCgrSe96S0qXrJIM9EdWn0GGwyfdirPWKn/sO5cwFWC44EzR1NvoL6d/Td72KX8xkbjDaBSi3s
	uq2fIOAVRcj7ikD11ioZ0BUKi0Z0qYcp3cNCb/n6gG8X8TracvZ0Yd+ePWhbSZkQVN3ii9ly3zA
	rXxUABna9oVsZSgQ/ZG6wvh7ojCbQbGLlDh2AwRcqyyHg2x+gzKGII9Ah7Qy81SXspyjSMI8NKO
	iQvn4eNcm5H+2hf0/TBzMRRLVrpP0iS8tjmdFZl1FUeB4jyllKRJxj6KxL4QbxCd2cOj+iD+RgR
	u9hWuBD+YVxKl
X-Google-Smtp-Source: AGHT+IHxeRoUN6E2vqGVAQRWsrCvr7v+JtGfEG269YWRBtBxDsN6M2vpw0aQlcZbwYWrC94DRriZOw==
X-Received: by 2002:a17:90b:3a45:b0:31e:cc6b:321f with SMTP id 98e67ed59e1d1-32166cdfa47mr4366070a91.29.1754497542184;
        Wed, 06 Aug 2025 09:25:42 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32161282b5esm3285824a91.27.2025.08.06.09.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 09:25:41 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	memxor@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/3] Allow struct_ops to create map id to
Date: Wed,  6 Aug 2025 09:25:37 -0700
Message-ID: <20250806162540.681679-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1 -> v2
    Add bpf_struct_ops_id() instead of using bpf_struct_ops_get()

Hi,

This patchset allows struct_ops implementors to get map id from kdata in
reg(), unreg() and update() so that they create an id to struct_ops
instance mapping. This in turn allows struct_ops kfuncs to refer to the
calling instance without passing a pointer to the struct_ops. The selftest
provides an end-to-end example.

Some struct_ops users extend themselves with other bpf programs, which
also need to call struct_ops kfuncs. For example, scx_layered uses
syscall bpf programs as a scx_layered specific control plane and uses
tracing programs to get additional information for scheduling [0].
The kfuncs may need to refer to the struct_ops instance and perform
jobs accordingly. To allow calling struct_ops kfuncs referring to
specific instances from different program types and context (e.g.,
struct_ops, tracing, async callbacks), the traditional way is to pass
the struct_ops pointer to kfuncs.

This patchset provides an alternative way, through a combination of
bpf map id and global variable. First, a struct_ops implementor will
use the map id of the struct_ops map as the id of an instance. Then, 
it needs to maintain an id to instance mapping: inserting a new mapping
during reg() and removing it during unreg(). The map id can be acquired
by calling bpf_struct_ops_id().

[0] https://github.com/sched-ext/scx/blob/main/scheds/rust/scx_layered/src/bpf/main.bpf.c

Amery Hung (3):
  bpf: Allow struct_ops to get map id by kdata
  selftests/bpf: Add multi_st_ops that supports multiple instances
  selftests/bpf: Test multi_st_ops and calling kfuncs from different
    programs

 include/linux/bpf.h                           |   1 +
 kernel/bpf/bpf_struct_ops.c                   |  12 ++
 .../test_struct_ops_id_ops_mapping.c          |  77 +++++++++++++
 .../bpf/progs/struct_ops_id_ops_mapping1.c    |  59 ++++++++++
 .../bpf/progs/struct_ops_id_ops_mapping2.c    |  59 ++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 109 ++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.h    |   8 ++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   2 +
 8 files changed, 327 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_id_ops_mapping.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_id_ops_mapping1.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_id_ops_mapping2.c

-- 
2.47.3


