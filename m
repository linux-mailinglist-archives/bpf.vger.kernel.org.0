Return-Path: <bpf+bounces-12924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7938C7D210C
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 07:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F447281773
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 05:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D3610EC;
	Sun, 22 Oct 2023 05:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzroOfRy"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726F810F1
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 05:03:49 +0000 (UTC)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8E3E7
	for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 22:03:47 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a92782615dso7250307b3.2
        for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 22:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697951027; x=1698555827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WWTToRDBTtJo2jg2ychAdWBNAW/rhWvN0GSJEys0obs=;
        b=WzroOfRyEksr7lUAyIywbT296wd0wmA9S51aygRk8JWUurV9dv3FMXDPBYUY4H7wtd
         hfDHO7zeDu2zHSPTQYv8WtEGyp/S0U2BAsESdhJ8pel6r+UKHaVBHoVgOOKC7kJ0uWFy
         kBTPi72R9yJ5TW4yLpurmrABtkAa/7IYkUA4Y10g5/IHj3toi1XsbkNDI7SX2Rtq5n35
         W2kahmfEqrqScM6X85eL5J5lLjkEl9rDNsfglXYaTHZL/QtkDTMq5YSHE6Y+iqGhFPeW
         y0Ggka+O7dQGfaKntyTRkimmAHkdpmYCJqvwlqAlPemWAAJM2hbo/QKTZvZECrUdWEHo
         YaTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697951027; x=1698555827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WWTToRDBTtJo2jg2ychAdWBNAW/rhWvN0GSJEys0obs=;
        b=AoxXMAowA6Tk4RnzGuje9xvPz/VwRmqNuq7uX7vUpdSyexl7hHBtC1LSWZh2LwHekJ
         MEQAcLs6a3uLLiJTuVuvBn2yerkmdbB9vM+/qN2Ui1wi5FOrVcSFIsmYgWjcMnmXGQ+9
         1EDF4EaQEZlhGIO3N1H07d5IDyLq4HxgafZmxGEhMU4F31OCKLX5u3XtHcxtSlB/Q80f
         VPoTnPLvS9//rhIr9xRKbpKwQZ8GZQQaWB8bB7yhSBObaL+TwsFOKCgrp8be90KAXI3b
         FnS0AvsvQ279284Mj7b/Z2FVpa3hcBFxULVYkXsusNtJWRe+d6Ij64rxrp1A+pWYkpsQ
         xHxg==
X-Gm-Message-State: AOJu0YwkRHq9Ni/wr9321QwWIUARQQhG0DAAVf6QmbuG3qaH+y+TX3uj
	5eG/ePA0rI4ajAt/MZAds7gb1dDm4fI=
X-Google-Smtp-Source: AGHT+IGVMjQ+YnAztb/Ag42yGMegOzs8yTa23OC0u/TX/u+h2G06Pd4c+TWHqi5jw0QWUZnQiMYGsQ==
X-Received: by 2002:a05:690c:38b:b0:59f:7650:8fdb with SMTP id bh11-20020a05690c038b00b0059f76508fdbmr7657192ywb.33.1697951026687;
        Sat, 21 Oct 2023 22:03:46 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:9904:3214:88c1:e733])
        by smtp.gmail.com with ESMTPSA id j1-20020a0de001000000b005a8c392f498sm2035169ywe.82.2023.10.21.22.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 22:03:46 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 00/10] Registrating struct_ops types from modules
Date: Sat, 21 Oct 2023 22:03:25 -0700
Message-Id: <20231022050335.2579051-1-thinker.li@gmail.com>
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

 include/linux/bpf.h                           |  51 ++-
 include/linux/bpf_verifier.h                  |   1 +
 include/linux/btf.h                           |   9 +
 include/uapi/linux/bpf.h                      |   5 +
 kernel/bpf/bpf_struct_ops.c                   | 430 ++++++++++--------
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
 tools/testing/selftests/bpf/Makefile          |   2 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  59 +++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   5 +
 .../bpf/prog_tests/test_struct_ops_module.c   |  38 ++
 .../selftests/bpf/progs/struct_ops_module.c   |  30 ++
 tools/testing/selftests/bpf/testing_helpers.c |  35 ++
 21 files changed, 689 insertions(+), 235 deletions(-)
 delete mode 100644 kernel/bpf/bpf_struct_ops_types.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_module.c

-- 
2.34.1


