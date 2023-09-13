Return-Path: <bpf+bounces-9861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A80E879DFC8
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 08:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F175281A39
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 06:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67486156FB;
	Wed, 13 Sep 2023 06:15:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FCDA45
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 06:15:08 +0000 (UTC)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DA6172E
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:15:07 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-59bd2e19c95so1352767b3.0
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694585706; x=1695190506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WwTHpJMTV/OXT1WAwx8krxSu7HqEyEVp5BslL7PCFzI=;
        b=TxaKtCPm5OcGNMWq/9EHjK8TJVn5EgjkGkgcegfzfzFzIMJjdV6WeyffJs60vIc87D
         yhguw2D0MDxP4eLgv92s2xfg8xlsAPcFAMvapveiASip5c57Eh3RfJwwdYvZJpslAJ1H
         DEuahGL7DtbO6y4jadfz9zc/mEaJdq+hEynlS+dKpyQsDMPhQsS4E8w8m+/eInwoXa1h
         cUSvB72nPWFgxWpl9Q71jDGqAHDGukhf6QtD7JQqovDq0pL2ms1FV0xTVENcYw1mlElg
         nq0nbQ5vefWd0S4Pluipqos2ElGamcjmfWuKKvnxFb/rNwBtjTroVE0bpcUkdieAHjCH
         BvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694585706; x=1695190506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WwTHpJMTV/OXT1WAwx8krxSu7HqEyEVp5BslL7PCFzI=;
        b=sbdubvJRHLRj0Z8As/FWXFIzF3KkYaUU2ZN3MEWv7kqHF/P+TuOy1OYFmKu1xSutL0
         to6RTxIBQ8cV5dUFNC4OswZIQhJGSlp+Cr1mwxCqdlxIwPFJpREcLBaOOrBUgVJsTjLN
         4xzi4OlX4jcyWC4Gi6ZbLvGRpDqSK6iwL/OTotO6qg3Z4D8A3ze7Cz89enRbLcHWTYgi
         Qy1uzo+FlBvJOt2/vL0g8Zm/gt+VdDaiwZlYqYq9esvdPnmTWf/n2TeBO1BqAyjPN14s
         DLnNGc/i6kyNxxHr5VxUGmZQhSY6A68LiXDduLO91dXZYF/UaI+pRX2AMqMQhQc9wxUq
         Om9w==
X-Gm-Message-State: AOJu0Yzu1++X+RV5uDaXOwQVL6zFUR/le4vGZonZLboa4p3xjWKr9o/n
	FZvkIDfKNdNagDKYYvkcx0l24IXktjc=
X-Google-Smtp-Source: AGHT+IH/+AFATNACr+xekpYkszj98wN+aZxkhIOOwcURVl8ISId1b+MBRp3CF3vl1wMX7IRwJY+Qkw==
X-Received: by 2002:a81:8887:0:b0:594:ea4f:f5a7 with SMTP id y129-20020a818887000000b00594ea4ff5a7mr1494206ywf.31.1694585705834;
        Tue, 12 Sep 2023 23:15:05 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:34c0:240e:9597:d8ed])
        by smtp.gmail.com with ESMTPSA id b132-20020a0dd98a000000b0057a5302e2fesm2961454ywe.5.2023.09.12.23.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 23:15:05 -0700 (PDT)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [RFC bpf-next v2 0/9] Registrating struct_ops types from modules
Date: Tue, 12 Sep 2023 23:14:40 -0700
Message-Id: <20230913061449.1918219-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Given the current constraints of the current implementation,
struct_ops cannot be registered dynamically. This presents a
significant limitation for modules like coming fuse-bpf, which seeks
to implement a new struct_ops type. To address this issue, a new API
is introduced that allows the registration of new struct_ops types
from modules.

Previously, struct_ops types were defined in bpf_struct_ops_types.h
and collected as a static array. The new API lets callers add new
struct_ops types to the array dynamically.

The struct_ops subsystem relies on BTF to determine the layout of
values in a struct_ops map and identify the subsystem that the
struct_ops map registers to. However, the kernel BTF does not include
the type information of struct_ops types defined by a module. The
struct_ops subsystem requires knowledge of the corresponding module
for a given struct_ops map and the utilization of BTF information from
that module. We empower libbpf to determine the correct module for
accessing the BTF information and pass an identity (FD) to the kernel.

If a module exits while one or more struct_ops maps still refer to a
struct_ops type defined by the module, it can lead to unforeseen
complications. Therefore, it is crucial to ensure that a module
remains intact as long as any struct_ops map is still linked to a
struct_ops type defined by the module. To achieve this, you can hold a
reference to the module for each struct_ops map.

Kui-Feng Lee (9):
  bpf: refactory struct_ops type initialization to a function.
  bpf: add register and unregister functions for struct_ops.
  bpf: attach a module BTF to a bpf_struct_ops
  bpf: use attached BTF to find correct type info of struct_ops progs.
  bpf: hold module for bpf_struct_ops_map.
  libbpf: Find correct module BTFs for struct_ops maps and progs.
  bpf: export btf_ctx_access to modules.
  selftests/bpf: test case for register_bpf_struct_ops().
  Comments and debug

 include/linux/bpf.h                           |  19 +-
 include/linux/btf.h                           |   1 +
 include/uapi/linux/bpf.h                      |   4 +
 kernel/bpf/bpf_struct_ops.c                   | 346 +++++++++++++-----
 kernel/bpf/btf.c                              |   3 +-
 kernel/bpf/syscall.c                          |   8 +-
 kernel/bpf/verifier.c                         |   4 +-
 tools/include/uapi/linux/bpf.h                |   4 +
 tools/lib/bpf/bpf.c                           |   3 +-
 tools/lib/bpf/bpf.h                           |   4 +-
 tools/lib/bpf/libbpf.c                        | 147 +++++---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  84 +++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   5 +
 .../bpf/prog_tests/test_struct_ops_module.c   |  40 ++
 .../selftests/bpf/progs/struct_ops_module.c   |  30 ++
 15 files changed, 558 insertions(+), 144 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_module.c

-- 
2.34.1


