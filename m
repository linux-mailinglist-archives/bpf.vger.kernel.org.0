Return-Path: <bpf+bounces-14313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9503D7E2DE8
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 21:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFBDCB20A23
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 20:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C772D788;
	Mon,  6 Nov 2023 20:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBowvHTt"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A18F1D697
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 20:13:02 +0000 (UTC)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFB3D79
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 12:12:58 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5ae143e08b1so57379217b3.1
        for <bpf@vger.kernel.org>; Mon, 06 Nov 2023 12:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699301577; x=1699906377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gW/OjYonjxrlYMlpBuP8jV9ggst1MY4PqsgCHH3AK6c=;
        b=JBowvHTtSeOukue70tL3GCa5k0ODI3c5XYXrbh7CuvXsl0GKyX8lVLbRiiqzd/r3TJ
         aA17u30vsiPCONbbPM+m282ORDYIKZQxSG83ENDaYg1zmXzL37Bb2K8CXmYd1jIjgA5I
         uCb6Rg3b99orFmqW0F4fNA3+BM3PKz0ntVIo+SzrabUv61MJTV2IUCTxKKcH2bcAFKO4
         wLhfaxHdKuaIvDaIKt174sMsDzfPiIWr9hD6wHqbmHU1Ldd7mn1w3ejubLvgECbplo3g
         svK5wy/JRfmg4aYPw6xsXTFQtE+Myg/bQNg99k0S3IQCBPeR+VwVCYp51gCkex6jBQv9
         AXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699301577; x=1699906377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gW/OjYonjxrlYMlpBuP8jV9ggst1MY4PqsgCHH3AK6c=;
        b=BEME3KZRvpZ4DHOP25hl3iD8soudoP7Nn+rLnGlZsLEdYK0AXNQh3eaUC93wKLM9Dl
         selZQIy194OxUa4qQ81i71+iOpvuYcC0yzYiXtKpkIwiFj2qzxqNSK7OGS5JtUyE39Zi
         HsOSV2f0yJMvw6Sb9GobsB7Ptmcuysopg/Jm+/UiU0uUeXjAC6OF7D3hNvDK3cd9PnV/
         jfw8V4zSCuJKZc1mnG5N6EH+2f3FYv5FvHNvzqv9l1updsdmiSYNXOqbVl0M4j6aVyvI
         Tq8/7Fz9TDE6WfxzrSWdzSWbWX60MM8u3V7l8DSy9m4C0GzvH8Ii5v/X1Cv5S5jl4JRg
         DWRw==
X-Gm-Message-State: AOJu0Yxdf4Egiwvdo5AcuUHGf/6aFQ/uizzZqQTCqO52ysoBMu2Q0b2C
	Jf4BGBqIoyK97KtJiAN15qsHZpOPlTU=
X-Google-Smtp-Source: AGHT+IH/TW5Gy4FZ0grVfuj/gfVUlvRKMdySPi3WnZmmpBOok89coEWDrWkgEcV/QGxuiFRUq8KSZQ==
X-Received: by 2002:a0d:d544:0:b0:5a7:fcae:f3e2 with SMTP id x65-20020a0dd544000000b005a7fcaef3e2mr12966157ywd.43.1699301577095;
        Mon, 06 Nov 2023 12:12:57 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:446d:cdea:6fa5:5630])
        by smtp.gmail.com with ESMTPSA id e65-20020a816944000000b0058427045833sm4760611ywc.133.2023.11.06.12.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 12:12:56 -0800 (PST)
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
Subject: [PATCH bpf-next v11 00/13] Registrating struct_ops types from modules
Date: Mon,  6 Nov 2023 12:12:39 -0800
Message-Id: <20231106201252.1568931-1-thinker.li@gmail.com>
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

Changes from v10:

 - Guard btf.c from CONFIG_BPF_JIT=n. This patchset has introduced
   symbols from bpf_struct_ops.c which is only built when
   CONFIG_BPF_JIT=y.

 - Fix the warning of unused errout_free label by moving code that is
   leaked to patch 8 to patch 7.

Changes from v9:

 - Remove the call_rcu_tasks_trace() changes from kern_sync_rcu().

 - Trace btf_put() in the test case to ensure the release of kmod's
   btf, or the consequent tests may fail for using kmod's unloaded old
   btf instead the new one created after loading again. The kmod's btf
   may live for awhile after unloading the kmod, for a map being freed
   asynchronized is still holding the btf.

 - Split "add struct_ops_tab to btf" into tow patches by adding
   "make struct_ops_map support btfs other than btf_vmlinux".

 - Flip the order of "pass attached BTF to the bpf_struct_ops
   subsystem" and "hold module for bpf_struct_ops_map" to make it more
   reasonable.

 - Fix the compile errors of a missing header file.

Changes from v8:

 - Rename bpf_struct_ops_init_one() to bpf_struct_ops_desc_init().

 - Move code that using BTF_ID_LIST to the newly added patch 2.

 - Move code that lookup struct_ops types from a given module to the
   newly added patch 5.

 - Store the pointers of btf at st_maps.

 - Add test cases for the cases of modules being unload.

 - Call bpf_struct_ops_init() in btf_add_struct_ops() to fix an
   inconsistent issue.

Changes from v7:

 - Fix check_struct_ops_btf_id() to use attach btf if there is instead
   of btf_vmlinux.

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
v10: https://lore.kernel.org/all/20231103232202.3664407-1-thinker.li@gmail.com/
v9: https://lore.kernel.org/all/20231101204519.677870-1-thinker.li@gmail.com/
v8: https://lore.kernel.org/all/20231030192810.382942-1-thinker.li@gmail.com/
v7: https://lore.kernel.org/all/20231027211702.1374597-1-thinker.li@gmail.com/
v6: https://lore.kernel.org/all/20231022050335.2579051-11-thinker.li@gmail.com/
v5: https://lore.kernel.org/all/20231017162306.176586-1-thinker.li@gmail.com/
v4: https://lore.kernel.org/all/20231013224304.187218-1-thinker.li@gmail.com/
v3: https://lore.kernel.org/all/20230920155923.151136-1-thinker.li@gmail.com/
v2: https://lore.kernel.org/all/20230913061449.1918219-1-thinker.li@gmail.com/

Kui-Feng Lee (13):
  bpf: refactory struct_ops type initialization to a function.
  bpf: get type information with BPF_ID_LIST
  bpf, net: introduce bpf_struct_ops_desc.
  bpf: add struct_ops_tab to btf.
  bpf: make struct_ops_map support btfs other than btf_vmlinux.
  bpf: lookup struct_ops types from a given module BTF.
  bpf: pass attached BTF to the bpf_struct_ops subsystem
  bpf: hold module for bpf_struct_ops_map.
  bpf: validate value_type
  bpf, net: switch to dynamic registration
  libbpf: Find correct module BTFs for struct_ops maps and progs.
  bpf: export btf_ctx_access to modules.
  selftests/bpf: test case for register_bpf_struct_ops().

 include/linux/bpf.h                           |  52 ++-
 include/linux/bpf_verifier.h                  |   1 +
 include/linux/btf.h                           |  10 +
 include/uapi/linux/bpf.h                      |   5 +
 kernel/bpf/bpf_struct_ops.c                   | 437 ++++++++++--------
 kernel/bpf/bpf_struct_ops_types.h             |  12 -
 kernel/bpf/btf.c                              | 120 ++++-
 kernel/bpf/syscall.c                          |   2 +-
 kernel/bpf/verifier.c                         |  25 +-
 net/bpf/bpf_dummy_struct_ops.c                |  23 +-
 net/ipv4/bpf_tcp_ca.c                         |  24 +-
 tools/include/uapi/linux/bpf.h                |   5 +
 tools/lib/bpf/bpf.c                           |   4 +-
 tools/lib/bpf/bpf.h                           |   5 +-
 tools/lib/bpf/libbpf.c                        |  38 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  59 +++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   5 +
 .../bpf/prog_tests/test_struct_ops_module.c   | 144 ++++++
 .../selftests/bpf/progs/struct_ops_module.c   |  30 ++
 .../testing/selftests/bpf/progs/testmod_btf.c |  26 ++
 20 files changed, 796 insertions(+), 231 deletions(-)
 delete mode 100644 kernel/bpf/bpf_struct_ops_types.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_module.c
 create mode 100644 tools/testing/selftests/bpf/progs/testmod_btf.c

-- 
2.34.1


