Return-Path: <bpf+bounces-17278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D602F80B0F1
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 01:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05BF31C20D06
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 00:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10ADC388;
	Sat,  9 Dec 2023 00:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6VyV8YJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70031734
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 16:27:13 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5d8a772157fso23582787b3.3
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 16:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702081632; x=1702686432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O570WAew95hVrFDY8+zopBmQpQ53VG4GKatam/C46Aw=;
        b=L6VyV8YJH8hg4Wtl4VIv7sGboqKU2ho5Wh2E/Ln2mu4nXaaC82wqVT5mo4jRdn1Bm3
         qcTdYsX9P0dUXsL2fqkxiuz+shdlZZcI82U304r4lXiWsJv8FN1zP/dohrgnpMBTq+iW
         +4+t3crPPp8vHzggsEBIkCq9aJUg8NH26VBFNgXdOvzcPadFpp1vcXv4/1KmqaA/eZMR
         c2YEp/MfqcqpYwmdVcjiXDoc97mA8MG/cFs1psLWt//8++z7UNZ0tumx3KpP4fqxxZkH
         ojqwPy4Xz8MPK5c1kA9s1N6HPRzu181r2G2/DjZpa1hjh3ETyY8A+tj+y3J+vifiQTBQ
         kGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702081632; x=1702686432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O570WAew95hVrFDY8+zopBmQpQ53VG4GKatam/C46Aw=;
        b=YC04NV0pP0QqulRYI9E1SfNxY1AXhDSVPdizIvKw+y2EAJtB46POH/EXAM8WsRKAiI
         wzezspEPoZ5mvu3ps4WF3qGyrAZyDDQ3pcecWziSZAEz4G2F88mZJiuxRh/+W3uk6K1m
         Ma0C7DiG1tsFAgdCx5q3yoGgJj48/8UzqzGY16aVEzjKSwrXbjf3O+h8oPGanQOiP0xg
         05d7EIMLogJHPyJDDzVGPV8Qlq6FmK+n8ZMj7qLVX43ywnyimi6CWaXXcylevsdD7Thm
         b17qIdK840AgDfw1QYT3hw39VEGhK5eXrhe1T6x0IT/4ck/Bn6urlBUOgLz8biDkZa22
         /OEQ==
X-Gm-Message-State: AOJu0YzNw9e9dHcizN9d+fLB042NDOUndoy3lCei5u7qpyZsNVRAdAFw
	FcPgReBly9l88KVd87r2/frcpVe1fVDwLA==
X-Google-Smtp-Source: AGHT+IEe0Pv7v3VqMKrA2hiZLIMdp6J0KRm2QA8F/jVOxmwRnSglbbeXh+s+1VPqw/LZZ/U74KKfhg==
X-Received: by 2002:a0d:ea82:0:b0:5d9:653d:a9cb with SMTP id t124-20020a0dea82000000b005d9653da9cbmr569103ywe.8.1702081632440;
        Fri, 08 Dec 2023 16:27:12 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:65fe:fe26:c15:a05c])
        by smtp.gmail.com with ESMTPSA id v4-20020a818504000000b005d9729068f5sm1057450ywf.42.2023.12.08.16.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 16:27:12 -0800 (PST)
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
Subject: [PATCH bpf-next v13 00/14] Registrating struct_ops types from modules
Date: Fri,  8 Dec 2023 16:26:55 -0800
Message-Id: <20231209002709.535966-1-thinker.li@gmail.com>
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

Changes from v12:

 - Rebase to for-next to fix conflictions.

Changes from v11:

 - bpf_struct_ops_maps hold only the refcnt to the module, but not
   btf. (patch 1)

 - Fix warning messages. (patch 1, 9 and 10)

 - Remove unnecessary conditional compiling of CONFIG_BPF_JIT.
   (patch 4, 9 and 10)

 - Fix the commit log of the patch 7 to explain how a btf is pass from
   the user space and how the kernel handle it.

 - bpf_struct_ops_maps hold the module defining it's type, but not
   btf. A map will hold the module through its life-span from
   allocating to being free. (patch 8)

 - Change selftests and tracing __bpf_struct_ops_map_free() to wait
   for the release of the bpf_testmod module.

 - Include btf_obj_id in bpf_map_info. (patch 14)

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
v12: https://lore.kernel.org/all/20231207013950.1689269-1-thinker.li@gmail.com/
v11: https://lore.kernel.org/all/20231106201252.1568931-1-thinker.li@gmail.com/
v10: https://lore.kernel.org/all/20231103232202.3664407-1-thinker.li@gmail.com/
v9: https://lore.kernel.org/all/20231101204519.677870-1-thinker.li@gmail.com/
v8: https://lore.kernel.org/all/20231030192810.382942-1-thinker.li@gmail.com/
v7: https://lore.kernel.org/all/20231027211702.1374597-1-thinker.li@gmail.com/
v6: https://lore.kernel.org/all/20231022050335.2579051-11-thinker.li@gmail.com/
v5: https://lore.kernel.org/all/20231017162306.176586-1-thinker.li@gmail.com/
v4: https://lore.kernel.org/all/20231013224304.187218-1-thinker.li@gmail.com/
v3: https://lore.kernel.org/all/20230920155923.151136-1-thinker.li@gmail.com/
v2: https://lore.kernel.org/all/20230913061449.1918219-1-thinker.li@gmail.com/

Kui-Feng Lee (14):
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
  bpf: pass btf object id in bpf_map_info.

 include/linux/bpf.h                           |  55 ++-
 include/linux/bpf_verifier.h                  |   1 +
 include/linux/btf.h                           |   8 +
 include/uapi/linux/bpf.h                      |   7 +-
 kernel/bpf/bpf_struct_ops.c                   | 421 ++++++++++--------
 kernel/bpf/bpf_struct_ops_types.h             |  12 -
 kernel/bpf/btf.c                              | 124 +++++-
 kernel/bpf/syscall.c                          |   4 +-
 kernel/bpf/verifier.c                         |  25 +-
 net/bpf/bpf_dummy_struct_ops.c                |  22 +-
 net/ipv4/bpf_tcp_ca.c                         |  22 +-
 tools/include/uapi/linux/bpf.h                |   7 +-
 tools/lib/bpf/bpf.c                           |   4 +-
 tools/lib/bpf/bpf.h                           |   5 +-
 tools/lib/bpf/libbpf.c                        |  38 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  52 +++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   5 +
 .../bpf/prog_tests/test_struct_ops_module.c   |  92 ++++
 .../selftests/bpf/progs/struct_ops_module.c   |  30 ++
 .../selftests/bpf/progs/testmod_unload.c      |  25 ++
 20 files changed, 725 insertions(+), 234 deletions(-)
 delete mode 100644 kernel/bpf/bpf_struct_ops_types.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_module.c
 create mode 100644 tools/testing/selftests/bpf/progs/testmod_unload.c

-- 
2.34.1


