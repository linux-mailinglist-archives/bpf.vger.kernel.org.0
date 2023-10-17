Return-Path: <bpf+bounces-12443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9137CC8AC
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 18:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AFEF1C20C6C
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 16:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE504734D;
	Tue, 17 Oct 2023 16:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5mFSsLL"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FF645F62
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 16:23:12 +0000 (UTC)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B88FE
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 09:23:11 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5a7d532da4bso73816947b3.2
        for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 09:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697559790; x=1698164590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gfjexW+EvpdVfw1nRBfKBo3UeXl7ryRgfxMbkf6IL+I=;
        b=W5mFSsLLDBVf7DNL/fKpoa0DIzBX1yGtHJ7R0Umaa5sagTFOodG+oFmXRJHnR/yJlE
         DTHbtUNfe8PuXGnGadAkm1xBzf4SK3KxG6hBYinEve55Z6v8TTmlrpd6FtWl02vLaRDG
         fstUGBOf0RUiDl45PGWulTW4uz4Ap68Oj177gGok88mft+jN/FLpuFCsOptVYjqEq8HM
         /UgS5W7cz08o7NsbWzB8ru6h3a7tT57f/VCbx1XbmCcQbEGnYFVKgZ7H/P/PLZmqKdZo
         M5A+AtD/oG1DEVplN0Uh1Ox7qI8p9todM5nUuCsGPrIEMcbSe+PlspfNE6tXIH+Q8fAQ
         wXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697559790; x=1698164590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gfjexW+EvpdVfw1nRBfKBo3UeXl7ryRgfxMbkf6IL+I=;
        b=gSu7HjV+7cJcQDwkEMXM4K+271s82aJz5h+ymRG4TY2kFXVtnoGEeXnZ6KRaP9QAYo
         kJXMaFATR4hScD28wdD9kCN1aVUinfIA97jZFS3aBVXwb1DDntLPjLbwb5DbVjKZsnEO
         vTj/3O7wXGx00S0r81IzVrGL0Vi7oI+mlQneGpibprReu5uuim2eBL+wVWFKM2IRF8g8
         B8z61LxNk3W2kTTlGfF5KfgAum6d5BpQ9kxFS3wpef8b4QE/W+6DzVerV5W3Swh3eJOi
         KXHKuaw6vQpKymr2HT1bvvGRuALUF/T3eV6EHPN7KxNHdU80uEgs+oOjhrRcKBq6Ro/Q
         53/w==
X-Gm-Message-State: AOJu0Yznd5zu3KkmhQrpD31kA8DmmOjjowYgAFtih5bffCkafd4T4vgR
	XcMYRKhwwY5DdRdVGtARtqbPYEd7i5Q=
X-Google-Smtp-Source: AGHT+IFKyPSO+HN0GTUDZ2pSOwUo6hJVBq9YHovPmbHdvfTbxoGKGurkuiMqjrLOkd+LQ3V3pY3/Zg==
X-Received: by 2002:a25:d6c2:0:b0:d91:fdb:afd4 with SMTP id n185-20020a25d6c2000000b00d910fdbafd4mr2621766ybg.16.1697559790008;
        Tue, 17 Oct 2023 09:23:10 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:ed01:b54a:4364:93cc])
        by smtp.gmail.com with ESMTPSA id r189-20020a2544c6000000b00d814d8dfd69sm623645yba.27.2023.10.17.09.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 09:23:09 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 0/9] Registrating struct_ops types from modules
Date: Tue, 17 Oct 2023 09:22:57 -0700
Message-Id: <20231017162306.176586-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
struct_ops map holds a reference to the module for each struct_ops
map.

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

 - 

Changes from v2:

 - Remove struct_ops array, and add a per-btf (module) struct_ops_tab
   to collect registered struct_ops types.

 - Validate value_type by checking member names and types.

---
v4: https://lore.kernel.org/all/20231013224304.187218-1-thinker.li@gmail.com/
v3: https://lore.kernel.org/all/20230920155923.151136-1-thinker.li@gmail.com/
v2: https://lore.kernel.org/all/20230913061449.1918219-1-thinker.li@gmail.com/

Kui-Feng Lee (9):
  bpf: refactory struct_ops type initialization to a function.
  bpf: add struct_ops_tab to btf.
  bpf: hold module for bpf_struct_ops_map.
  bpf: validate value_type
  bpf: pass attached BTF to the bpf_struct_ops subsystem
  bpf, net: switch to dynamic registration
  libbpf: Find correct module BTFs for struct_ops maps and progs.
  bpf: export btf_ctx_access to modules.
  selftests/bpf: test case for register_bpf_struct_ops().

 include/linux/bpf.h                           |   8 +-
 include/linux/btf.h                           |  35 ++
 include/uapi/linux/bpf.h                      |   5 +
 kernel/bpf/bpf_struct_ops.c                   | 375 +++++++++++-------
 kernel/bpf/bpf_struct_ops_types.h             |  12 -
 kernel/bpf/btf.c                              |  73 +++-
 kernel/bpf/syscall.c                          |   2 +-
 kernel/bpf/verifier.c                         |   4 +-
 net/bpf/bpf_dummy_struct_ops.c                |  14 +-
 net/ipv4/bpf_tcp_ca.c                         |  16 +-
 tools/include/uapi/linux/bpf.h                |   5 +
 tools/lib/bpf/bpf.c                           |   4 +-
 tools/lib/bpf/bpf.h                           |   5 +-
 tools/lib/bpf/libbpf.c                        |  68 ++--
 tools/testing/selftests/bpf/Makefile          |   2 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  59 +++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   5 +
 .../bpf/prog_tests/test_struct_ops_module.c   |  38 ++
 .../selftests/bpf/progs/struct_ops_module.c   |  30 ++
 tools/testing/selftests/bpf/testing_helpers.c |  35 ++
 20 files changed, 604 insertions(+), 191 deletions(-)
 delete mode 100644 kernel/bpf/bpf_struct_ops_types.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_module.c

-- 
2.34.1


