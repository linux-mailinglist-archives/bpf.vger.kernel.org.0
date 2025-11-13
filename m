Return-Path: <bpf+bounces-74371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4E2C57215
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 12:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F01DC3B4A15
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 11:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA88333971D;
	Thu, 13 Nov 2025 11:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsjiFkuP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6B933858A
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 11:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763032474; cv=none; b=EgCCR/kd/Y3wwP49w3HW+P2yGMFgzZ2A2oLB0yZlKetzoM6cuf7CiuuQ1/I2/6iZeBKs6fKwjWBNeASq9GEPl8n2Fmpl6lM8e3bWOWAHqmveOJ1m5D3rdjDbEcz+FdG+UifvdFpUTYQUNEiCGtP+RieVsBecxVxQU1oVzgewwec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763032474; c=relaxed/simple;
	bh=th9M2NykH7Yb81ZiuFZqKlR0D3oO9gdoL+Ub+EW7tMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=We8cYZaxcaBbXdYWhdVRV+3MHPklHB7NjigIbP0cNEfCFWYDoYR3DG5J7eCE1/YbDr0VrwLEnV/IVQXYUzDyrj73ZzDIDRR1lI8K6zYu9kgqHqPgpT++L2vQMfoceake0ER7iQlgK85ZqqFBoAyJeOIzYXDepjIShIaJ1AUwm2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MsjiFkuP; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477549b3082so5835095e9.0
        for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 03:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763032471; x=1763637271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g4u7C3Y0NwjJH9VEsr30c+gij/q8WlsHyQOgxxJgZik=;
        b=MsjiFkuPZXAnw4rEum1edPN9qIxLMbLHQe/ZISRDpMSP4znWYz/Xph/yAp2pvSD3/A
         uTv0MMCu/JeYfXLXAuEdivkFUR3It/BzRbdghzvYYfTdKXW9Y6B+vy3yXgphVUFa7F5L
         AHaGMPmXjC9/NEwRv82BDVejZTQGPCloEuwrI/gsaTnvYcbqm+zlTTMauSkTMi4Qikko
         aTetlyzE8mqWJjtLgcSElfzPiCh/v4u/lFBNNdtz+Y8MbGKzI7K2wi7mu3zk8p+KpVbp
         MaZNYmPUMvFGdDF8S8285a7UiUHeRkP+8CRg4cbXnKZ2lX4OkHxzOqesCkjyhxqc5XnE
         CQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763032471; x=1763637271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4u7C3Y0NwjJH9VEsr30c+gij/q8WlsHyQOgxxJgZik=;
        b=WnxLlzAPh3TW3VTkc/YFKWLOwuJRkOyb3o3WE1XIvS3eEC4mJOTcqHTOHuDo9j3mlQ
         scgXgk/WyDom1/8efvq7ZT1McDNfMkDApLzXTOr+odTGJXLCkBLFNGZ/I3tpdc6tUqKx
         Kz2n+BoVIkmJJa3w435c1DBc+pQgX0VRg2/qY61MCBT2KkDYFKdwJDk1XO9CejkHNgdO
         hIzY4GwGAVPGiZghS1+qkh9R9XwPuMlQPj6EV9/RnqqmCRSMFB1p7n54yQZtxoouUtV0
         eTaUV9oiD9I3SicUw3BiSW2QjVp6vZIrihhaI5LfL3mcpDIYJzslKvRakdxMeiOhV1CN
         Lc1Q==
X-Forwarded-Encrypted: i=1; AJvYcCX+yXjcYeSb/S8RdF++bqa2YDSz40F/T2xks9NDTWvOklfvt+5/3fW/fJm6lQc58KMixIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOVV2Q8AYirX3OebvH0Qt6siZgstlYF624W6HVvRp+7lVQwAb0
	UYTPhx1ZR8/JoEwim/vDC3MJxq6eNeyffqgWnrs7u7AQcstN8kHt6bqw
X-Gm-Gg: ASbGncv2+bWQl2Bwx3Z8I4r/3CUJztA6TFp83RJAa9lzlMZrD+QR+ZgEkSMKVLKPLM/
	O1vJ/S4WCENWcSViikMMC5m0qDgxyDBg/OiYjdMFwXofgF/KywLjjSyGC2ZriKHW4fQYWoYMcW4
	fI1kDC/xeKccB5bLhUSm1ktiWq4T9jXukgblSXLx/QlserNsVKlFTy4yBSXCauGF/FmtL/dbAun
	SNNGDMQ1CxYfd5NBrAY1pr9VwInlQ2XCvYSgmiP2CVcrg2nv0THoM7WAjcYpWQ8LtsVo2/0Whjb
	aPxiIn0LfcjCyLileOVEZBPtXIT4UG2HN6C5Ra4gUFUiO1655ZqF7GD2mPfy4yOg6SglRSyW6bE
	hqkN8a/0teovRZIcRMXJVFb0JVoh/uom4BaG/Q6fJZ7GoqdTQMbu0hz1L/LbGylPb+nClTLfhW3
	zmX7Dd7ph6Q72zLVHW/Tqz6cE=
X-Google-Smtp-Source: AGHT+IFYVhYBjfP04vJBGEnSjIyHx4PM2GrEwHP+F5uBytgA+05q2tu/UUG98vl4/aZlU3S5nvI9PQ==
X-Received: by 2002:a05:600c:3587:b0:459:e398:ed89 with SMTP id 5b1f17b1804b1-477870450ffmr68835375e9.1.1763032470903;
        Thu, 13 Nov 2025 03:14:30 -0800 (PST)
Received: from paul-Precision-5770 ([80.12.41.69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778bcfa2e9sm17739825e9.12.2025.11.13.03.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 03:14:30 -0800 (PST)
From: Paul Houssel <paulhoussel2@gmail.com>
X-Google-Original-From: Paul Houssel <paul.houssel@orange.com>
To: Paul Houssel <paulhoussel2@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Martin Horth <martin.horth@telecom-sudparis.eu>,
	Ouail Derghal <ouail.derghal@imt-atlantique.fr>,
	Guilhem Jazeron <guilhem.jazeron@inria.fr>,
	Ludovic Paillat <ludovic.paillat@inria.fr>,
	Robin Theveniaut <robin.theveniaut@irit.fr>,
	Tristan d'Audibert <tristan.daudibert@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Paul Houssel <paul.houssel@orange.com>
Subject: [PATCH v3 0/2] libbpf: fix BTF dedup to support recursive typedef
Date: Thu, 13 Nov 2025 12:14:04 +0100
Message-ID: <cover.1763024337.git.paul.houssel@orange.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pahole fails to encode BTF for some Go projects (e.g. Kubernetes and
Podman) due to recursive type definitions that create reference loops
not representable in C. These recursive typedefs trigger a failure in
the BTF deduplication algorithm.

This patch extends btf_dedup_struct_types() to properly handle potential
recursion for BTF_KIND_TYPEDEF, similar to how recursion is already
handled for BTF_KIND_STRUCT. This allows pahole to successfully
generate BTF for Go binaries using recursive types without impacting
existing C-based workflows.

Changes in v3:
  1. Patch 1: Adjusted the comment of btf_dedup_ref_type() to refer to
  typedef as well.
  2. Patch 2: Update of the "dedup: recursive typedef" test to include a
  duplicated version of the types to make sure deduplication still happens
  in this case.

Changes in v2:
  1. Patch 1: Refactored code to prevent copying existing logic. Instead of
  adding a new function we modify the existing btf_dedup_struct_type()
  function to handle the BTF_KIND_TYPEDEF case. Calls to btf_hash_struct()
  and btf_shallow_equal_struct() are replaced with calls to functions that
  select btf_hash_struct() / btf_hash_typedef() based on the type.
  2. Patch 2: Added tests

v2: https://lore.kernel.org/lkml/cover.1762956564.git.paul.houssel@orange.com/

v1: https://lore.kernel.org/lkml/20251107153408.159342-1-paulhoussel2@gmail.com/

Paul Houssel (2):
  libbpf: fix BTF dedup to support recursive typedef definitions
  selftests/bpf: add BTF dedup tests for recursive typedef definitions

 tools/lib/bpf/btf.c                          | 73 +++++++++++++++-----
 tools/testing/selftests/bpf/prog_tests/btf.c | 65 +++++++++++++++++
 2 files changed, 121 insertions(+), 17 deletions(-)

-- 
2.51.0


