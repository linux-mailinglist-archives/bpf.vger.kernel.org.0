Return-Path: <bpf+bounces-27609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B22198AFDD4
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 03:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DDA32879CB
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 01:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F0F6FB8;
	Wed, 24 Apr 2024 01:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+etGHks"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7F76125
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 01:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713922129; cv=none; b=opYqreWcsX9BpCFHZHIaLkcwXJfianCCyYIylCoCbNm6Tn0PvvkGPCtTXFuwYjkiT1SNKugyEd+mDNJJdk3+KFFJ+/zEtXcLV31Bz/+DJYtnlXelKKmO9jmWizkqdJmUFpEugyZ+1SRLd0eq3VdHD5N5V/YPij3l2/YlyjwU86M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713922129; c=relaxed/simple;
	bh=sTuKmtJwL3gPave0nrd2VpPYpZQtRBX0dCALLuh5Nwo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fYDnLa6MKAB0J85zBhgBeRFGHxYlEpHzWjeA2L+poXjDlXNL20GOwQg3YMo9ytCB9lhi/dGCYJD/mv/QhTDLLqgPeH3bq+Vd17gz4AwoApEpyMBda01SEPkhm8TsoZIbS0YJM6rMDAVenYG7y1V6VMxIsHX4LfhJHPF7tJRYW0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+etGHks; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c70999ff96so3970757b6e.2
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 18:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713922127; x=1714526927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qgBJyyfxBAfTfO4kbxZUN4YIN1WEkduXU+TuRJBa8uY=;
        b=E+etGHksfNuFPgBowPq7qPxJOcU3WJduaXJT7yKCH3WD7IVuscb0dXn2tbeb5HGMkw
         xHQ0B+7uJC99y3J+lEZqzbOGhjQ0u9reEP+k+FiohfBKkvJh5H9sBmfhjLtkMSJ6Hqd+
         9HbW5ma8B7w70QZGtO1+pA2WnD6pB0r32MiuGQZ/qPj4MtXjzqwOjVBAVC5k6YLh+HvX
         31l0A88NN7M4e66/qREA+j/o4psA5psFsiQi+V9JTbB46KybZ5hBorCNLawcemlpebX0
         VSFLvYGLUd95zsFk+CS2Ur8i17+sRbrJ+41s1QOpX1F4bbKQZM91XY0kWNH+nKUvaGiu
         9Z6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713922127; x=1714526927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qgBJyyfxBAfTfO4kbxZUN4YIN1WEkduXU+TuRJBa8uY=;
        b=rORnHHACecdLhxlIRtLOHw3zJgT2KYh+VmRuvsPwkdlZJK0BqnOs4Z+FsoDay8Nkk8
         NGkqnbpdBbuuwbFMiqT/1k1uXX/cgVhJayIOX4vE1rN0f4cgn08oyJwn6dGoIzsArrip
         2/4WsAbrAWDq+4ZZft10RtP6XmiQiveI44rVQdNtEJVB0EQlF+TGKoDmPm/+IdAiA+s+
         zGKgmZQn6P47iqZHOs6c5Pn6KHZeSgq06GElmTx7rieN4ChpVXkz4vwy7k30mfeALDvC
         C4G0xl0iOrtojUe0tqZ4Umf2gLkCPX+BiXFtG9yZRpG3pO3tJnv2V6SIy3nzZl4YGRQ6
         Zmng==
X-Gm-Message-State: AOJu0YzGzpiV5okQCQP47p3kCgzuaR697NnZ6NSt0cNt43mBu01pE18M
	yA/U897V3mXlXXfugPrL8Fz8yQVz3npA/KMACPUUlJim36yk3pAWheKg4g==
X-Google-Smtp-Source: AGHT+IEZzGbci4+59fXLWfGVz8bWOXi/L1VyQ8PTy8rF8mxN6MoIEJB/JewyWilAn3GnfVtQAleVcA==
X-Received: by 2002:aca:1e09:0:b0:3c7:52cb:e0ff with SMTP id m9-20020aca1e09000000b003c752cbe0ffmr962185oic.47.1713922127260;
        Tue, 23 Apr 2024 18:28:47 -0700 (PDT)
Received: from badger.vs.shawcable.net ([2604:3d08:9880:5900:1fa0:b3a5:f828:f414])
        by smtp.gmail.com with ESMTPSA id fk24-20020a056a003a9800b006ed9d839c4csm10271007pfb.4.2024.04.23.18.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 18:28:46 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	jemarch@gnu.org,
	thinker.li@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 0/5] check bpf_dummy_struct_ops program params for test runs
Date: Tue, 23 Apr 2024 18:28:16 -0700
Message-Id: <20240424012821.595216-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When doing BPF_PROG_TEST_RUN for bpf_dummy_struct_ops programs,
execution should be rejected when NULL is passed for non-nullable
params, because for such params verifier assumes that such params are
never NULL and thus might optimize out NULL checks.

This problem was reported by Jose E. Marchesi in off-list discussion.
The code generated by GCC for dummy_st_ops_success/test_1() function
differs from LLVM variant in a way that allows verifier to remove the
NULL check. The test dummy_st_ops/dummy_init_ret_value actually sets
the 'state' parameter to NULL, thus GCC-generated version of the test
triggers NULL pointer dereference when BPF program is executed.

This patch-set addresses the issue in the following steps:
- patch #1 marks bpf_dummy_struct_ops.test_1 parameter as nullable,
  for verifier to have correct assumptions about test_1() programs;
- patch #2 modifies dummy_st_ops/dummy_init_ret_value to trigger NULL
  dereference with both GCC and LLVM (if patch #1 is not applied);
- patch #3 adjusts a few dummy_st_ops test cases to avoid passing NULL
  for 'state' parameter of test_2() and test_sleepable() functions,
  as parameters of these functions are not marked as nullable;
- patch #4 adjusts bpf_dummy_struct_ops to reject test execution of
  programs if NULL is passed for non-nullable parameter;
- patch #5 adds a test to verify logic from patch #4.

Eduard Zingerman (5):
  bpf: mark bpf_dummy_struct_ops.test_1 parameter as nullable
  selftests/bpf: adjust dummy_st_ops_success to detect additional error
  selftests/bpf: do not pass NULL for non-nullable params in
    dummy_st_ops
  bpf: check bpf_dummy_struct_ops program params for test runs
  selftests/bpf: dummy_st_ops should reject 0 for non-nullable params

 net/bpf/bpf_dummy_struct_ops.c                | 55 ++++++++++++++++++-
 .../selftests/bpf/prog_tests/dummy_st_ops.c   | 34 +++++++++++-
 .../bpf/progs/dummy_st_ops_success.c          | 15 ++++-
 3 files changed, 96 insertions(+), 8 deletions(-)

-- 
2.34.1


