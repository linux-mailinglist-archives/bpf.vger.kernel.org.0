Return-Path: <bpf+bounces-10458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA737A891D
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 18:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 166F41C20AB7
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 16:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96CD3C6AE;
	Wed, 20 Sep 2023 15:59:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8A43C69D
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 15:59:52 +0000 (UTC)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CBFCA
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 08:59:49 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-59e8d963adbso41579857b3.0
        for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 08:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695225588; x=1695830388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kn/V59hwPVDnzxvQ/5jpGArnbX7ES2HvHcpDKMD7r40=;
        b=afdHfknlXbfP3h/KW5LDPShaOllL/dzhd7qO4InEFzXAbkU5xvFdeM/t/OFcg68pgn
         nLQYZuARMLtZLeOzW9nXSVywGlNTuMoeG6pxy3c878LHpZGx6n02q/DgbB37rvR5Xvha
         i5QtD63oNIMxyoU/xXxf7xDDfP3HVHE2ppT3bd60UqbA9UlLlK8Wzd1KOexnExqHel6N
         syJV38mFPQB2cHPjihcjdjHav2wV9F4PePlx59MOlapacnnutMiqw38zCtUPaoVgCcEI
         ucPJpsIze0Xrg8hOSdkwcJk1RifBTS8x8+IrPtW4ubGiWOF01aAr42SR8sOox/S/h7DH
         AOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695225588; x=1695830388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kn/V59hwPVDnzxvQ/5jpGArnbX7ES2HvHcpDKMD7r40=;
        b=nK+28x2mM+zIDxBb+o5dyMdAEGhq2lLdxnteQSNX39HmuMzEkPcBGmiMiWGvJBNssH
         M55Wd1oDUc5tU6Aj/gTNSguuMOq1bGzD3ew0CCoGTBAUT4PmWvroghdKLZ3UskQVKLfu
         9aMu6juNIQF35/sbs4NixoyWNiA207SCSHVqwIIHG2pOD/J8cvQjNBtMAH86ahcrFLi1
         i170se+VbZM05FQAkvxSv8qvn5vwSd1/xZwj6xt1T6IR3WPPddLZxtwuGxFRrcMYYGe1
         VE19/k7TxQCnDm4k3HhGL8X0BtdfLKNBlxzTXvcteKJzqEgVj4R1t9wIHW0I39soeGpi
         crsA==
X-Gm-Message-State: AOJu0YyoBfvVB7OcSW7ixPN1K1GH5jxmIsQkg5xylAhOZ2Kaq1cLecaz
	+EvNe7vc0AGVkbYSIsG7HAMBE9R+OtQ=
X-Google-Smtp-Source: AGHT+IHEdfDgcinMczuprXuMRFvwrEcVpMIRveiDOrHOOKqKfH6as+m/PkW9IrzeO0TOqOySJjWmnQ==
X-Received: by 2002:a05:690c:f89:b0:59b:69cf:72c0 with SMTP id df9-20020a05690c0f8900b0059b69cf72c0mr3341027ywb.6.1695225587962;
        Wed, 20 Sep 2023 08:59:47 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:dcd2:9730:2c7c:239f])
        by smtp.gmail.com with ESMTPSA id m131-20020a817189000000b00589dbcf16cbsm3860490ywc.35.2023.09.20.08.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 08:59:46 -0700 (PDT)
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
Subject: [RFC bpf-next v3 00/11] Registrating struct_ops types from modules
Date: Wed, 20 Sep 2023 08:59:12 -0700
Message-Id: <20230920155923.151136-1-thinker.li@gmail.com>
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

Changes from v2:

 - Remove struct_ops array, and add a per-btf (module) struct_ops_tab
   to collect registered struct_ops types.

 - Validate value_type by checking member names and types.

---
v2: https://lore.kernel.org/all/20230913061449.1918219-1-thinker.li@gmail.com/

Kui-Feng Lee (11):
  bpf: refactory struct_ops type initialization to a function.
  bpf: add struct_ops_tab to btf.
  bpf: add register and unregister functions for struct_ops.
  bpf: attach a module BTF to a bpf_struct_ops
  bpf: hold module for bpf_struct_ops_map.
  bpf: validate value_type
  bpf, net: switch to storing struct_ops in btf
  bpf: pass attached BTF to find correct type info of struct_ops progs.
  libbpf: Find correct module BTFs for struct_ops maps and progs.
  bpf: export btf_ctx_access to modules.
  selftests/bpf: test case for register_bpf_struct_ops().

 include/linux/bpf.h                           |  15 +-
 include/linux/btf.h                           |  36 ++
 include/uapi/linux/bpf.h                      |   4 +
 kernel/bpf/bpf_struct_ops.c                   | 378 ++++++++++++------
 kernel/bpf/bpf_struct_ops_types.h             |  12 -
 kernel/bpf/btf.c                              |  87 +++-
 kernel/bpf/syscall.c                          |   2 +-
 kernel/bpf/verifier.c                         |   4 +-
 net/bpf/bpf_dummy_struct_ops.c                |  12 +-
 net/ipv4/bpf_tcp_ca.c                         |  20 +-
 tools/include/uapi/linux/bpf.h                |   4 +
 tools/lib/bpf/bpf.c                           |   3 +-
 tools/lib/bpf/bpf.h                           |   4 +-
 tools/lib/bpf/libbpf.c                        | 121 +++---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  63 +++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   5 +
 .../bpf/prog_tests/test_struct_ops_module.c   |  43 ++
 .../selftests/bpf/progs/struct_ops_module.c   |  30 ++
 18 files changed, 638 insertions(+), 205 deletions(-)
 delete mode 100644 kernel/bpf/bpf_struct_ops_types.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_module.c

-- 
2.34.1


