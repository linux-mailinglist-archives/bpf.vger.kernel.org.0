Return-Path: <bpf+bounces-29968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEC48C8C8D
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 21:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94AEE1F28187
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 19:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9933313E3E0;
	Fri, 17 May 2024 19:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ge//Q0mF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE01C6A005
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 19:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715972768; cv=none; b=cWSiNbv2pxEliHg0DqZc7WLRbkIKcX1YqIdf15NkQOBHSovRThK7jKQhhuvfB7kPxi1AqYK4gAAnA4gu+qIfe6GKiLD+z6RjKFMSOe/q1WqUFVgeomlfV7YUHW1wZ0ZcNk6G62QzQuip+TQEP7+cTGFYjzcvCJ+I7O0J7ScyHMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715972768; c=relaxed/simple;
	bh=XQG+qKW/wmIzkT2bXiYE19EYiGqqIbdCuNkbqh/bzsU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C7lYRRw3KPDAuoHBkKIyI7al0TOBV2WWvnxbUax99Hv2HBURL4IC2Nyy9TpSBwlKyDU73CGeufAL4T4/+JwlBeySisfG44Z4Qma/dQNkU+fSav2uVuO5Xa7JYbppwyNhcL6PtYHBq51H7FJ4sE3csFgXJ/PIerObiwy8XRzZEt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ge//Q0mF; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-663d2e6a3d7so97301a12.0
        for <bpf@vger.kernel.org>; Fri, 17 May 2024 12:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715972766; x=1716577566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fg+7NOiOvmiqJom6wLV7kf/ID1oMFAfXDLfl9F5OLwc=;
        b=Ge//Q0mF0I6NhNckfoxwfnp0LSrRVMRe00zz3uPrtzGACoqp8YUlridiPhzpXn8zUu
         UbaywpYZEnRUrPecnCxUiIeZJX/j7C/vaOu1Q3ZZD4aOmH9sOUg6m8wZdnNSIu7SrGWc
         jSooW3U6YW+Eb4jfmv3vN95J51Zu2WtjRtWzpBa4u6TZrAjDz9TdS6W1xVUglancYmac
         oaJvkPTruYarkCQbAvhitQW0jF0IpZsvQu5+d4zd/PyWeyIEkfuk4HnawqMN9+sNKIID
         jbag+b4tbFj2fWRN8UR9ZshvS1U/f7Dxv3aLRCvBXj2YiYNEC5veYdDh5yP7BAR1vcJW
         zHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715972766; x=1716577566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fg+7NOiOvmiqJom6wLV7kf/ID1oMFAfXDLfl9F5OLwc=;
        b=Janpoxeyj6NC1N3DEFUrdxDhSLS/V88QglCiAdCQGhg65wd+NTCisuUrCzQiGmnwcJ
         APxK/D3IZiL0ZJYvYBUijJDYJJZ3akuwtDCuMK2pi2B27oVLN8QEm3FFB7Re7+Dz5ZMy
         81u8msT3zoa7jtSkpOKt60KNl9YPNr/GWQiOVaI5r22P0kg1w0GV0247zGjfILWd0M3f
         hS2/k/oaIS0MA9g5mGijemu5klquHb80l4ikyeTNzOGrinYjHROjbHH5b0hvYB68aP/U
         UC120JB9We89/apxtXzjrgsdzJ6/u4hE75pqGaet9bhXw9LQi0bytN//UkoyFQ2rw4wZ
         Jiuw==
X-Gm-Message-State: AOJu0YzlXRsW7459Jg/efH711/ne06V0hOLwoTox/B9v9qpyziFVH2J5
	msAZUrfA+WESNlQ0Ly5F3gEH4bXbbmou0SzrncF4J7YJXeHZsi6s5/uShA==
X-Google-Smtp-Source: AGHT+IGIYEZFj0bwYIh2zGS8vhcSLHLso1TBQ3Wc+JAivSEiOs99CK4awso9ofC/8u5evC3Qv53bbw==
X-Received: by 2002:a17:90a:f008:b0:2b1:54e4:e125 with SMTP id 98e67ed59e1d1-2bd6040c1c1mr23708a91.22.1715972765852;
        Fri, 17 May 2024 12:06:05 -0700 (PDT)
Received: from badger.hitronhub.home ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b9ddbcf05csm5459747a91.45.2024.05.17.12.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 12:06:05 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	jose.marchesi@oracle.com,
	alan.maguire@oracle.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 0/4] API to access btf_dump emit queue and print single type
Date: Fri, 17 May 2024 12:05:51 -0700
Message-Id: <20240517190555.4032078-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a follow-up to the following discussion:
https://lore.kernel.org/bpf/20240503111836.25275-1-jose.marchesi@oracle.com/

As suggested by Andrii, this series adds several API functions to
allow more flexibility with btf dump:
- a function to add a type and all its dependencies to the emit queue;
- functions to provide access to the emit queue owned by btf_dump object;
- a function to print a given type (skipping any dependencies).

This should allow filtering printed types and also adding
attributes / pre-processor statements to specific types.

There are several ways to add such API:
1. The simplest in terms of code changes is to refactor
   btf_dump_emit_type() to push types and forward declarations
   to the emit queue, instead of printing those directly;
2. More intrusive: refactor btf_dump_emit_type() and
   btf_dump_order_type() to avoid doing topological sorting twice and
   put forward declarations to the emit queue at once.

This series opts for (2) as it seems to simplify library code a bit.
For the sake of discussion, source code for option (1) as available at:
https://github.com/eddyz87/bpf/tree/libbpf-sort-for-dump-api-simple

Also, this series opts for the following new API function:

  int btf_dump__dump_one_type(struct btf_dump *d, __u32 id, bool fwd);

As adding _opts variant of btf_dump__dump_type seems a bit clumsy:

  struct btf_dump_opts {
	size_t sz;
	bool fwd;
	bool skip_dependencies;
	bool skip_last_semi;
  };

  int btf_dump__dump_type_opts(struct btf_dump *d, __u32 id,
			       struct btf_dump_opts *opts);

but maybe community would prefer the later variant.

Changes v1->v2:
- fix for build issues reported by CI: do not mark typedefs as ORDERED

v1: https://lore.kernel.org/bpf/20240516230443.3436233-1-eddyz87@gmail.com/

Eduard Zingerman (4):
  libbpf: put forward declarations to btf_dump->emit_queue
  libbpf: API to access btf_dump emit queue and print single type
  selftests/bpf: tests for btf_dump emit queue API
  selftests/bpf: corner case for typedefs handling in btf_dump

 tools/lib/bpf/btf.h                           |  33 ++
 tools/lib/bpf/btf_dump.c                      | 386 +++++++++---------
 tools/lib/bpf/libbpf.map                      |   4 +
 .../selftests/bpf/prog_tests/btf_dump.c       |  86 ++++
 .../bpf/progs/btf_dump_test_case_ordering.c   |  10 +
 5 files changed, 315 insertions(+), 204 deletions(-)

-- 
2.34.1


