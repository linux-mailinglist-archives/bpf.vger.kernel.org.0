Return-Path: <bpf+bounces-12196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF70C7C905D
	for <lists+bpf@lfdr.de>; Sat, 14 Oct 2023 00:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C7DFB20C44
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 22:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7568C2B5FC;
	Fri, 13 Oct 2023 22:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIQ3GJN7"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2A6107AD
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 22:43:11 +0000 (UTC)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4257B7
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 15:43:09 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a82f176860so10058777b3.1
        for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 15:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697236988; x=1697841788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a3QPrS98UXUNFgAZ+bxkec2E7rhVw8RBoOP5ATaAVgs=;
        b=jIQ3GJN7wopsz8jfIAP4+4wwujUtvNeIZCh3ar/zr0p9ZJ5PWky/5pBM0fOLKTzcUU
         q3u4BDaBJhmRW05ql6y4bIWZCvFPlsbB7T7EgVqnc9KML+t1Jv+RkGRaSlKLzdXiWjhc
         QoTM5VTi3dznjKRGcLUul0LEIVA80y/2xhq7dkeW1WfJGFWDS+XnGCWLM27jqf3ueA9h
         /F133x0pAUflVJNLhMEJXjJdl4imwLepHoTQ7KgFTpEB9rJsIvZkLkvSQadpbqECHfKl
         w+f8KvVXlNBG8NQ/I7tJHDjsNmt8mkixtvoh/MmEc6jG/+VqKsakdNJN1u7XAt977VFF
         YFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697236988; x=1697841788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a3QPrS98UXUNFgAZ+bxkec2E7rhVw8RBoOP5ATaAVgs=;
        b=RV77Y1wWB7VeM3mTfGy5/0d8+cM+nowUiyMWZbkI7Xu7azv/8qYfBN11c/SD5F1e6z
         hIvReCfAaH+sZ+4++Flg+zkbnDQH6esUiCwX31ja+X5BuoJz9CN0F3Z2qVYbXeEOVwW2
         /qVc45UJ4tEZU3skqcK5XLqC4fFi48KzHYsSKov4Rh49DU/DFU4rhkWOGndimLkCSMkY
         /qt5K30LkY4a2xmvmVHViIOAdrvkdrJimMMe0BEtz4FfJ/NFBzEH/63u2Q6SKYcLhC1N
         NauKZg0JesW57R13WnGXi6AytPaOq11Wv5Wx+W3vX5z9M9lkuQkehunD3NJyf6bouxKz
         eVpw==
X-Gm-Message-State: AOJu0YyZNfpMsEHcZEJS02tFhug91duMz1HWOBimbrUTeNneaNdVOrp4
	Ziicgp2XHMEApM2annm7JX2bl3EuwnI=
X-Google-Smtp-Source: AGHT+IFfVdI5Bz/JvfJY2bxEcgM+noCzWS0GaujOvgX6LzdKd/374HKk0tB/tSeoi2QVsLe3cB7aIg==
X-Received: by 2002:a81:6905:0:b0:589:db22:bfd6 with SMTP id e5-20020a816905000000b00589db22bfd6mr28562115ywc.40.1697236988510;
        Fri, 13 Oct 2023 15:43:08 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:df89:3514:fdf4:ee2])
        by smtp.gmail.com with ESMTPSA id g141-20020a0ddd93000000b00592548b2c47sm101989ywe.80.2023.10.13.15.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 15:43:07 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 0/9] Registrating struct_ops types from modules
Date: Fri, 13 Oct 2023 15:42:55 -0700
Message-Id: <20231013224304.187218-1-thinker.li@gmail.com>
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
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  59 +++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   5 +
 .../bpf/prog_tests/test_struct_ops_module.c   |  38 ++
 .../selftests/bpf/progs/struct_ops_module.c   |  30 ++
 tools/testing/selftests/bpf/testing_helpers.c |  35 ++
 19 files changed, 602 insertions(+), 191 deletions(-)
 delete mode 100644 kernel/bpf/bpf_struct_ops_types.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_module.c

-- 
2.34.1


