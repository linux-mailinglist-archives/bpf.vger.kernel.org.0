Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3715761E5E5
	for <lists+bpf@lfdr.de>; Sun,  6 Nov 2022 21:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiKFU3s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 6 Nov 2022 15:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiKFU3q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 6 Nov 2022 15:29:46 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52427BC2C
        for <bpf@vger.kernel.org>; Sun,  6 Nov 2022 12:29:45 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so8478868wmb.2
        for <bpf@vger.kernel.org>; Sun, 06 Nov 2022 12:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lTn+LaLS6t1g7b608IA3qBHIl40XwctiP/rZqs9E+S8=;
        b=OYC7zPPCSYsfBlktYGB0QyvlBYCLg5GAGWe4vYMnBfPP3zRfD+Wc3hoStPA4Mnmoxs
         h5D4E/3+f8qw5RF4YeuDVkT1CHRobwb+8smVqU/y/bauJCNFro1rdP6x0MORswHUI2pn
         0jGyz2jR9aOUccXBCv/uXsR/mwTV5/djLi3Uk8+6uYSE63G1beJhg5IkyICEI+BDjUPi
         nvuExiA6++RjshZ7PzozTw4EVcAwVMTd0vG2Ekw+aqQWD7TSoGzJ4OlS5mI2Z4tLPy2M
         SPSQptr9/+fB/DJv5YaDeFGMYu9WpOQMrt9v6X8KC4ZKOXwn8NWRS0BNmY9LWtTFBhPD
         QmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lTn+LaLS6t1g7b608IA3qBHIl40XwctiP/rZqs9E+S8=;
        b=wGRdc2leh81Ny9mfwwrWK1IJfiR5/IKNCv6YXOG0MTsQpXMKUXEkFY1IYNXknvse5R
         BMt2AGjbZhkiXebyMy3d0WqMClG9fJLntdm1G/QfYyXN/S7A5EGl6eqfYzIbMYGpugUw
         uGlcldO5ie6UmuhSCRTmetDreprrpdXe78vTbchfSks9nn8CoBkBfhUbxlw1RFmYcI/i
         kHcmunpYqzNn5hdFbSVp67Sbgpi9ja98tVSBur2o+YKY4mslOnwZF/lI/GmTXEYSSdt7
         i3muR8RAQMPD+2WJE7eQDUELbZSMAsbbghwWpkkFywPDeo4yYh2mUQF9EMlZCxILfl7G
         ENTw==
X-Gm-Message-State: ACrzQf34WQ6ZZzz7i/ehpE4KfVZlgcZEVzxK7ErP1ekoOt2ztxzULsz4
        jKhZUPACvuwk524gCWNz6caVvBV4ag+y/bwl
X-Google-Smtp-Source: AMsMyM7N/bp3ugx3CJNvE03ztxIhiQbuHXzhCZHl8s21KTxBWiprlsITSfeyxu7SSqbXztYm/CQNhA==
X-Received: by 2002:a7b:cd99:0:b0:3cf:7556:a52c with SMTP id y25-20020a7bcd99000000b003cf7556a52cmr24360177wmj.53.1667766583486;
        Sun, 06 Nov 2022 12:29:43 -0800 (PST)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id q188-20020a1c43c5000000b003cf894c05e4sm9358636wma.22.2022.11.06.12.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 12:29:42 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, alan.maguire@oracle.com, acme@kernel.org,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 0/3] libbpf: Resolve unambigous forward declarations
Date:   Sun,  6 Nov 2022 22:29:07 +0200
Message-Id: <20221106202910.4193104-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The patch-set is consists of the following parts:
- A refactoring of the libbpf's hashmap interface to use `long`
  instead of `void*` for keys and values. The reasoning behind the
  refactoring is that integer keys / values are used in libbpf more
  often then pointer keys / values. Thus the refactoring reduces the
  number of awkward looking casts like `(void *)(long)off`.
  The `long` is used with an implicit assumption that
  `sizeof(long) == sizeof(void *)` on all supported platforms.
  This includes changes in `libbpf` and `perf` source code. 

- A change to `lib/bpf/btf.c:btf__dedup` that adds a new pass named
  "Resolve unambiguous forward declaration". This pass builds a
  hashmap `name_off -> uniquely named struct or union` and uses it to
  replace FWD types by structs or unions. This is necessary for corner
  cases when FWD is not used as a part of some struct or union
  definition de-duplicated by `btf_dedup_struct_types`.

The goal of the patch-set is to resolve forward declarations that
don't take part in type graphs comparisons if declaration name is
unambiguous.

Example:

CU #1:

struct foo;              // standalone forward declaration
struct foo *some_global;

CU #2:

struct foo { int x; };
struct foo *another_global;

Currently the de-duplicated BTF for this example looks as follows:

[1] STRUCT 'foo' size=4 vlen=1 ...
[2] INT 'int' size=4 ...
[3] PTR '(anon)' type_id=1
[4] FWD 'foo' fwd_kind=struct
[5] PTR '(anon)' type_id=4

The goal of this patch-set is to simplify it as follows:

[1] STRUCT 'foo' size=4 vlen=1
	'x' type_id=2 bits_offset=0
[2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
[3] PTR '(anon)' type_id=1

For defconfig kernel with BTF enabled this removes 63 forward
declarations.

For allmodconfig kernel with BTF enabled this removes ~5K out of ~21K
forward declarations in ko objects. This unlocks some additional
de-duplication in ko objects, but impact is tiny: ~13K less BTF ids
out of ~2M.

Changelog:
 v1 -> v2
 - Style fixes in btf_dedup_resolve_fwd and btf_dedup_resolve_fwds as
   suggested by Alan.
 v2 -> v3
 Changes suggested by Andrii:
 - perf's util/hashtable.{c,h} are synchronized with libbpf
   implementation, perf's source code updated accordingly;
 - changes to libbpf, bpf selftests and perf are combined in a single
   patch to simplify bisecting;
 - hashtable interface updated to be long -> long instead of
   uintptr_t -> uintptr_t;
 - btf_dedup_resolve_fwds updated to correctly use IS_ERR / PTR_ERR
   macro;
 - test cases for btf_dedup_resolve_fwds are updated for better
   clarity.

[v1] https://lore.kernel.org/bpf/20221102110905.2433622-1-eddyz87@gmail.com/
[v2] https://lore.kernel.org/bpf/20221103033430.2611623-1-eddyz87@gmail.com/

Eduard Zingerman (3):
  libbpf: hashmap interface update to long -> long
  libbpf: Resolve unambigous forward declarations
  selftests/bpf: Tests for btf_dedup_resolve_fwds

 tools/bpf/bpftool/btf.c                       |  25 +--
 tools/bpf/bpftool/common.c                    |  10 +-
 tools/bpf/bpftool/gen.c                       |  19 +-
 tools/bpf/bpftool/link.c                      |   8 +-
 tools/bpf/bpftool/main.h                      |  14 +-
 tools/bpf/bpftool/map.c                       |   8 +-
 tools/bpf/bpftool/pids.c                      |  16 +-
 tools/bpf/bpftool/prog.c                      |   8 +-
 tools/lib/bpf/btf.c                           | 184 +++++++++++++++---
 tools/lib/bpf/btf_dump.c                      |  16 +-
 tools/lib/bpf/hashmap.c                       |  16 +-
 tools/lib/bpf/hashmap.h                       |  34 ++--
 tools/lib/bpf/libbpf.c                        |  18 +-
 tools/lib/bpf/strset.c                        |  18 +-
 tools/lib/bpf/usdt.c                          |  31 ++-
 tools/perf/tests/expr.c                       |  40 ++--
 tools/perf/tests/pmu-events.c                 |   6 +-
 tools/perf/util/bpf-loader.c                  |  23 ++-
 tools/perf/util/expr.c                        |  32 ++-
 tools/perf/util/hashmap.c                     |  16 +-
 tools/perf/util/hashmap.h                     |  34 ++--
 tools/perf/util/metricgroup.c                 |  12 +-
 tools/perf/util/stat.c                        |   9 +-
 tools/testing/selftests/bpf/prog_tests/btf.c  | 176 +++++++++++++++++
 .../bpf/prog_tests/btf_dedup_split.c          |  45 +++--
 .../selftests/bpf/prog_tests/hashmap.c        | 102 +++++-----
 .../bpf/prog_tests/kprobe_multi_test.c        |   6 +-
 27 files changed, 602 insertions(+), 324 deletions(-)

-- 
2.34.1

