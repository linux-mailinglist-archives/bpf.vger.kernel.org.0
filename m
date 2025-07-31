Return-Path: <bpf+bounces-64840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B01B177D7
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 23:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 255CE3B34C4
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 21:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107BF25A2C7;
	Thu, 31 Jul 2025 21:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2UjzXWT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BD2153598;
	Thu, 31 Jul 2025 21:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753996194; cv=none; b=d9XgD6+dtEZl5AA/VbZEI6q5YUGFRsfa9XPGyKBYfMYzWdo/qbiiPGDgMhX+SLyzl2hCpQuPYbAhfmTtDVmHC0MnolRR/qZ9HmetPe9FZb+Itbw4KQz8R0EKnVF2sgW7v/DxLJf4IgcM7sjsuojYvJcEq3JSz8/2VhIoN5qvdjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753996194; c=relaxed/simple;
	bh=tZPLyp9ccd9CeEjm37KnDGPEJS3ru0ZoESdHAVSjkyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q9V5Y/ZgYv/7Z1oN45xLywDU5EGkFR2mwUHgreV2urXITWMCzIIJEd0HkspFLlFPHaXW1+WQw1jy7vg026eMmMDXzahU/daaVKY9trIRniYknC0Ie6ZgbWbnDSuuPdjW34VjgfMP4X99nG6L22YjJBMcOt//ftNIENjwYnP2JJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2UjzXWT; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-240763b322fso9535545ad.0;
        Thu, 31 Jul 2025 14:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753996191; x=1754600991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7sZuqmuyXQoISyl7ZKxyRSc3le5zu2GDSfJ7Az4I2pg=;
        b=X2UjzXWTW7XOGRIJMNF7yqWrXFKJf1az5q+0IHV91uXyN+fCdz2JMzQZpe9O8lN6jI
         XDWVgvOoD7U/GZcceT3FmLbXzxpR1gEp/50y1myr/9Eo9kQ/OFKzcxBTpDT7Vgg1ZaoE
         7bPajmEVFjE/9K4tMAR4gYza/eps2BM5GxjsAaDmesIjaoX/ir1PoASDHgwcg91XAmjl
         p7bCoBjrLWH0y+qMfSNCUACTLxDB16hYlfE0TD8vg71oA9hZLzte4Xx8RFz5udosVWaS
         HvN4GgNXP5o8l5eDr4qJMH/3x/4EUv2uMTIoCo0yG8D3YUTexvjdY2ijYZiF9J8scduq
         DNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753996191; x=1754600991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7sZuqmuyXQoISyl7ZKxyRSc3le5zu2GDSfJ7Az4I2pg=;
        b=Zcf3+me/eUUMPqSy58KDlBRUudVWQOMNdOGsEUDPRcwQwzGy41CftKCgK52djuuyHI
         YADDXQhmFa+j0jsKYPx6Q2WTfXYxmFKeyEhLtdSyEPWS679+zLj8G2G2vIDWo8IzjR+N
         Z4t4DzuDK5ru/LSpxOXUIDo7oml/SPUszzujT74wXWJh50/Y9D82NA3yFoFKX545F8+N
         Ers6YE2sIF2kxVSq13c0uCkZVcdcX5VOWU7i+MAKr2H7Dbj/Pd7n7QuL1DnI4KNuxSxc
         BTU7ctsjC+lq6paOCWF5cmchf9Sq3SLqAutF5GUHSTkyCFisIvf3S9xSxFuYWJ0SGlW0
         c0/A==
X-Gm-Message-State: AOJu0YzpHWkPtsbe7dvOXSg3dI2Fw51UYqK1lTkozG9qo25elUKurKJI
	5R7fxktOB77siF+cmpXIIvfQIp8Vfypoj/LSWYvSkCLix8Q/PvtEDFHn1iURGg==
X-Gm-Gg: ASbGnctsvVf7eIrCGnTEZoVLmgXUXOpU4lT3YzcCUOW+SLMaJUIZXWeUXVRASqwogkx
	PpS8+wBhjz5qsRH9bldB7Z8dUOyhV2oyp/pyQ7g8yLbW9IKyHjgNF/D8q3xdsjOOR5AYCfXZvds
	yuE0CWLhWkV8jNUvPHp0HXAsu6ffuRmjW2AmbuiYGdzdBCSMxfmW9HIoQNibbr+F1ymsy5LuPKu
	E0aiHuyY7iLAyDmSuNwhHYPZdsqXvwwFUH8oH6C7YpXgJFRq1HHUMiWFtxae5VK+rhFwsvroQ1L
	zNkYpiuP2bD+DFI2PBZmz34FwI3hhKxq8z4VXKfIcZmCfjfkTPtvHXg+jfrWnWcnb68P9ZJpZar
	7cKg0YWFtX7mf6w==
X-Google-Smtp-Source: AGHT+IFYv6eba3WJObd64sCwSu99uz3WdC2j1Vga5hEuFpajyfyMkaHH7H1fOclc6PRwkqf/x52t8g==
X-Received: by 2002:a17:902:db09:b0:240:b3dd:9eeb with SMTP id d9443c01a7336-240b3dda073mr105333945ad.36.1753996191041;
        Thu, 31 Jul 2025 14:09:51 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976a11sm26207325ad.86.2025.07.31.14.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 14:09:50 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 0/3] Allow struct_ops to get bpf_map during
Date: Thu, 31 Jul 2025 14:09:47 -0700
Message-ID: <20250731210950.3927649-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset allows struct_ops implementors to access bpf_map during
reg() and unreg() so that they can create an id to struct_ops instance
mapping. This in turn allows struct_ops kfuncs to refer to the instance
without passing a pointer to the struct_ops. The selftest provides an
end-to-end example.

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
by calling bpf_struct_ops_get(), which is tweaked to return bpf_map
instead of bool.

[0] https://github.com/sched-ext/scx/blob/main/scheds/rust/scx_layered/src/bpf/main.bpf.c


Amery Hung (3):
  bpf: Allow getting bpf_map from struct_ops kdata
  selftests/bpf: Add multi_st_ops that supports multiple instances
  selftests/bpf: Test multi_st_ops and calling kfuncs from different
    programs

 include/linux/bpf.h                           |   4 +-
 kernel/bpf/bpf_struct_ops.c                   |   7 +-
 .../test_struct_ops_id_ops_mapping.c          |  77 ++++++++++++
 .../bpf/progs/struct_ops_id_ops_mapping1.c    |  57 +++++++++
 .../bpf/progs/struct_ops_id_ops_mapping2.c    |  57 +++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 112 ++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.h    |   8 ++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   2 +
 8 files changed, 319 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_id_ops_mapping.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_id_ops_mapping1.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_id_ops_mapping2.c

-- 
2.47.3


