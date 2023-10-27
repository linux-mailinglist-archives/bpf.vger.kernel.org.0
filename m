Return-Path: <bpf+bounces-13498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8857F7DA23C
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 23:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EA9F282601
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 21:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB8C3F4D6;
	Fri, 27 Oct 2023 21:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxNHlf3I"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151468813
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 21:17:10 +0000 (UTC)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA851B5
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 14:17:09 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d9a3d737d66so1767929276.2
        for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 14:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698441428; x=1699046228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QhyuGsnwVqHr6ODTtggd3O52+ki3jqoWGqnEu8mEXiA=;
        b=LxNHlf3IaZ6h3S72uJiopwt++NFK88li33XwtQPWxwupujG3O+lFGowo79taMKsC+k
         2E04/glh5BKxZAO45Mu0ZztA0A2IlGminjgSmJC1tFl2rx4bLOdHaHPCJ6zrj6wmy94j
         /20chos4RYV41Y7P7ByLwQ5eS929HhA9A4r4m836Wfua7112Lo7Mi3p7w34Mjs2/KOYZ
         3HWxV+A48Cr/GgIc0R+xqWr3OwiQbYdI9neovjVYqXioGCfdrl+idXFvNwqARrOnPeDf
         uI5bYeWZX7P/nadV5vH1PZVLPJr79iwWj7hQegx51OYHDDPD98+xVyAKt+p2foMXYzmk
         jpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698441428; x=1699046228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QhyuGsnwVqHr6ODTtggd3O52+ki3jqoWGqnEu8mEXiA=;
        b=wyNMc6fl/ZnMc3OmY8ChKOTJp/0fui5rz3QOEGOhfho6Es7d3aooDnPynI+OoxJRz9
         Nf5Z33HaLjWUnBE5N1YQeYEsNATNls5J+sg4wSi7YOoENpM0OBm9OcUHTFWE/28hlRV4
         WCCnCMKw4EGK4Rjw7Ulb91t2n5ygoDY6oNx/xUBlQDnQZr1PsZE0prJ3UzXOzHK0+oxe
         fX9cm88pOEdF6BHwSNAB+Q1wS796mvTE3pCYZBLlU2axwOj91gF78EYluLlOjNuiObSH
         ksse5ZiIOAIMnyDamNnEf4qVs/FhWqC05Fop6inZyhczSfxitm1YDEgLZXSLTkyCmH2q
         WPBg==
X-Gm-Message-State: AOJu0Yyht3CWGVQxYo3ah+W/NlmziX4FbZxFKIMQus9qRimdXtR+aJJm
	CTnW/T8R7vH3io+V/bo/Q6+iS3135bE=
X-Google-Smtp-Source: AGHT+IHqG1Ym86umkZt2S8gNDHcgyb5wqpiMFGKeT14m8WNEKnQeOMJpCWMZ47G9IVEv9wi+DcalwQ==
X-Received: by 2002:a81:8d53:0:b0:5a7:bb6e:7958 with SMTP id w19-20020a818d53000000b005a7bb6e7958mr3589735ywj.7.1698441428051;
        Fri, 27 Oct 2023 14:17:08 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:41cd:a94b:292d:cd8])
        by smtp.gmail.com with ESMTPSA id e133-20020a81698b000000b0059a34cfa2a5sm1080174ywc.67.2023.10.27.14.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 14:17:07 -0700 (PDT)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	drosen@google.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v7 00/10] Registrating struct_ops types from modules
Date: Fri, 27 Oct 2023 14:16:52 -0700
Message-Id: <20231027211702.1374597-1-thinker.li@gmail.com>
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
struct_ops types dynamically. The static array has been removed and
replaced by the per-btf struct_ops_tab.

The struct_ops subsystem relies on BTF to determine the layout of
values in a struct_ops map and identify the subsystem that the
struct_ops map registers to. However, the kernel BTF does not include
the type information of struct_ops types defined by a module. The
struct_ops subsystem requires knowledge of the corresponding module
for a given struct_ops map and the utilization of BTF information from
that module. We empower libbpf to determine the correct module for
accessing the BTF information and pass an identity (FD) of the module
btf to the kernel. The kernel looks up type information and registered
struct_ops types directly from the given btf.

If a module exits while one or more struct_ops maps still refer to a
struct_ops type defined by the module, it can lead to unforeseen
complications. Therefore, it is crucial to ensure that a module
remains intact as long as any struct_ops map is still linked to a
struct_ops type defined by the module. To achieve this, every
struct_ops map holds a reference to the module while being registered.

Changes from v6:

 - Change returned error code to -EINVAL for the case of
   bpf_try_get_module().

 - Return an error code from bpf_struct_ops_init().

 - Fix the dependency issue of testing_helpers.c and
   rcu_tasks_trace_gp.skel.h.

Changes from v5:

 - As the 2nd patch, we introduce "bpf_struct_ops_desc". This change
   involves moving certain members of "bpf_struct_ops" to
   "bpf_struct_ops_desc", which becomes a part of
   "btf_struct_ops_tab". This ensures that these members remain
   accessible even when the owner module of a "bpf_struct_ops" is
   unloaded.

 - Correct the order of arguments when calling
    in the 3rd patch.

 - Remove the owner argument from bpf_struct_ops_init_one(). Instead,
   callers should fill in st_ops->owner.

 - Make sure to hold the owner module when calling
   bpf_struct_ops_find() and bpf_struct_ops_find_value() in the 6th
   patch.

 - Merge the functions register_bpf_struct_ops_btf() and
   register_bpf_struct_ops() into a single function and relocate it to
   btf.c for better organization and clarity.

 - Undo the name modifications made to find_kernel_btf_id() and
   find_ksym_btf_id() in the 8th patch.

Changes from v4:

 - Fix the dependency between testing_helpers.o and
   rcu_tasks_trace_gp.skel.h.

Changes from v3:

 - Fix according to the feedback for v3.

   - Change of the order of arguments to make btf as the first
     argument.

   - Use btf_try_get_module() instead of try_get_module() since the
     module pointed by st_ops->owner can gone while some one is still
     holding its btf.

   - Move variables defined by BPF_STRUCT_OPS_COMMON_VALUE to struct
     bpf_struct_ops_common_value to validation easier.

   - Register the struct_ops type defined by bpf_testmod in its init
     function.

   - Rename field name to 'value_type_btf_obj_fd' to make it explicit.

   - Fix leaking of btf objects on error.

   - st_maps hold their modules to keep modules alive and prevent they
     from unloading.

   - bpf_map of libbpf keeps mod_btf_fd instead of a pointer to module_btf.

   - Do call_rcu_tasks_trace() in kern_sync_rcu() to ensure the
     bpf_testmod is unloaded properly. It uses rcu_tasks_trace_gp to
     trigger call_rcu_tasks_trace() in the kernel.

 - Merge and reorder patches in a reasonable order.


Changes from v2:

 - Remove struct_ops array, and add a per-btf (module) struct_ops_tab
   to collect registered struct_ops types.

 - Validate value_type by checking member names and types.

---
v6: https://lore.kernel.org/all/20231022050335.2579051-11-thinker.li@gmail.com/
v5: https://lore.kernel.org/all/20231017162306.176586-1-thinker.li@gmail.com/
v4: https://lore.kernel.org/all/20231013224304.187218-1-thinker.li@gmail.com/
v3: https://lore.kernel.org/all/20230920155923.151136-1-thinker.li@gmail.com/
v2: https://lore.kernel.org/all/20230913061449.1918219-1-thinker.li@gmail.com/

Kui-Feng Lee (10):
  bpf: refactory struct_ops type initialization to a function.
  bpf, net: introduce bpf_struct_ops_desc.
  bpf: add struct_ops_tab to btf.
  bpf: hold module for bpf_struct_ops_map.
  bpf: validate value_type
  bpf: pass attached BTF to the bpf_struct_ops subsystem
  bpf, net: switch to dynamic registration
  libbpf: Find correct module BTFs for struct_ops maps and progs.
  bpf: export btf_ctx_access to modules.
  selftests/bpf: test case for register_bpf_struct_ops().

 include/linux/bpf.h                           |  51 +-
 include/linux/bpf_verifier.h                  |   1 +
 include/linux/btf.h                           |   9 +
 include/uapi/linux/bpf.h                      |   5 +
 kernel/bpf/bpf_struct_ops.c                   | 435 ++++++++++--------
 kernel/bpf/bpf_struct_ops_types.h             |  12 -
 kernel/bpf/btf.c                              | 113 ++++-
 kernel/bpf/syscall.c                          |   2 +-
 kernel/bpf/verifier.c                         |  21 +-
 net/bpf/bpf_dummy_struct_ops.c                |  23 +-
 net/ipv4/bpf_tcp_ca.c                         |  24 +-
 tools/include/uapi/linux/bpf.h                |   5 +
 tools/lib/bpf/bpf.c                           |   4 +-
 tools/lib/bpf/bpf.h                           |   5 +-
 tools/lib/bpf/libbpf.c                        |  50 +-
 tools/testing/selftests/bpf/Makefile          |   4 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  59 +++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   5 +
 .../bpf/prog_tests/test_struct_ops_module.c   |  39 ++
 .../selftests/bpf/progs/struct_ops_module.c   |  30 ++
 tools/testing/selftests/bpf/testing_helpers.c |  35 ++
 21 files changed, 695 insertions(+), 237 deletions(-)
 delete mode 100644 kernel/bpf/bpf_struct_ops_types.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_module.c

-- 
2.34.1


