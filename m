Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B4D617512
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 04:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiKCDfj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 23:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiKCDfi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 23:35:38 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3979213F4F
        for <bpf@vger.kernel.org>; Wed,  2 Nov 2022 20:35:36 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id k2so2055979ejr.2
        for <bpf@vger.kernel.org>; Wed, 02 Nov 2022 20:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mr7b+c2DPjAnfjyr79n/bYI7K1AMmW+a/7CSBZygnVY=;
        b=d5istclJfssZ4MZZZFlkloWUm1qofzp6/eclFCyEpmVIlbbOHjmey8x3UgsZwun2RE
         Ucr+Y1F6XzsFCYMXbrZJtF5gwTYJhGf5MRz35CVuCMkZSFqqfgC7htHtAC0sjo5CyTuZ
         GhE2jfFAqPncXXM4oPx7vYJox2nltzQMgwPrZGsPG5KPLEaM/ZnyIIEQCyRtIanSDCzL
         BQhDrNB0LsvoUAW0yTQJLvoo4bD+QRmUNhIweUUNYnc2UkOBgUPLjtwkG4FvGPGY6PNP
         JDubAXdxcOsUFksMiBdLTOm5/brt86LtIAxHLfZpDTyq40fublXeAK+fL60vYg+AoeCP
         Y7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mr7b+c2DPjAnfjyr79n/bYI7K1AMmW+a/7CSBZygnVY=;
        b=Oou07yvmKEO0MicXXXAltJOwT6NOenEcoYzjoyijY+xJKisdrMXtst25zNVeUqTqAy
         NukGdKvoFbfIEckTgvs6wvRQD0+Zj1o8RxLpiYG8514tzzUf9WX0YDLto2lki4GXNezu
         2lsc9NUM20I3ltS7iJoWjBoo43nZL68GwCMzynGiwlqw5+p6CPw+MrJIIJAPIqGpydr/
         b+tDQvTx/dD+NZ7Xf2zIG1BhCnLp3e+ygMwWrkqFMj7GlPWKXt/qIVQKeDNxK+m/pj3l
         KY1FoQY7T1+maLLXBquhfcPYwYKvLa0VTK018XzXZ9gemspuRrTDdy7vhC1sdDzTOzLF
         an1Q==
X-Gm-Message-State: ACrzQf1RNFFhWWGXgRL4OPDn+tPNu7ALi6GYSp0vCMKG87WHN2AOxQHN
        pUd7UMXJ74n1jkKXm0KLQM9yGDFmzWAiGKM9
X-Google-Smtp-Source: AMsMyM47yGeMgefxePDr2WfdGGWsB+FCpOWO2l0jH9E80Xr1ZPNK3wmDoA6zX8XbeEtiYXvMghZr8A==
X-Received: by 2002:a17:907:8a0a:b0:78d:b87d:e68a with SMTP id sc10-20020a1709078a0a00b0078db87de68amr25953222ejc.301.1667446534499;
        Wed, 02 Nov 2022 20:35:34 -0700 (PDT)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090604c200b007815ca7ae57sm6106441eja.212.2022.11.02.20.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 20:35:33 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, alan.maguire@oracle.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 0/4] libbpf: Resolve unambigous forward declarations
Date:   Thu,  3 Nov 2022 05:34:26 +0200
Message-Id: <20221103033430.2611623-1-eddyz87@gmail.com>
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

Resolve forward declarations that don't take part in type graphs
comparisons if declaration name is unambiguous.
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

The patch-set is consists of the following parts:
- A refactoring of the libbpf's hashmap interface to use `uintptr_t`
  instead of `void*` for keys and values. The reasoning behind the
  refactoring is that integer keys / values are used in libbpf more
  often then pointer keys / values. Thus the refactoring reduces the
  number of awkward looking casts like "(void *)(long)off".
  `uintptr_t` is used to avoid necessity for temporary variables when
  pointer keys / values are used on platforms with 32-bit pointers.
- A change to `lib/bpf/btf.c:btf__dedup` that adds a new pass named
  "Resolve unambiguous forward declaration". This pass builds a
  hashmap `name_off -> uniquely named struct or union` and uses it to
  replace FWD types by structs or unions. This is necessary for corner
  cases when FWD is not used as a part of some struct or union
  definition de-duplicated by `btf_dedup_struct_types`.

For defconfig kernel with BTF enabled this removes 63 forward
declarations.

For allmodconfig kernel with BTF enabled this removes ~5K out of ~21K
forward declarations in ko objects. This unlocks some additional
de-duplication in ko objects, but impact is tiny: ~13K less BTF ids
out of ~2M.

Changelog:
 v1 -> v2
 v1: https://lore.kernel.org/bpf/20221102110905.2433622-1-eddyz87@gmail.com/T/#t
 - Style fixes in btf_dedup_resolve_fwd and btf_dedup_resolve_fwds as
   suggested by Alan.

Eduard Zingerman (4):
  libbpf: hashmap interface update to uintptr_t -> uintptr_t
  selftests/bpf: hashmap test cases updated for uintptr_t -> uintptr_t
    interface
  libbpf: Resolve unambigous forward declarations
  selftests/bpf: Tests for btf_dedup_resolve_fwds

 tools/bpf/bpftool/btf.c                       |  23 +--
 tools/bpf/bpftool/common.c                    |  10 +-
 tools/bpf/bpftool/gen.c                       |  19 +-
 tools/bpf/bpftool/link.c                      |   8 +-
 tools/bpf/bpftool/main.h                      |   4 +-
 tools/bpf/bpftool/map.c                       |   8 +-
 tools/bpf/bpftool/pids.c                      |  16 +-
 tools/bpf/bpftool/prog.c                      |   8 +-
 tools/lib/bpf/btf.c                           | 186 +++++++++++++++---
 tools/lib/bpf/btf_dump.c                      |  16 +-
 tools/lib/bpf/hashmap.c                       |  16 +-
 tools/lib/bpf/hashmap.h                       |  35 ++--
 tools/lib/bpf/libbpf.c                        |  18 +-
 tools/lib/bpf/strset.c                        |  24 +--
 tools/lib/bpf/usdt.c                          |  31 ++-
 tools/testing/selftests/bpf/prog_tests/btf.c  | 152 ++++++++++++++
 .../bpf/prog_tests/btf_dedup_split.c          |  45 +++--
 .../selftests/bpf/prog_tests/hashmap.c        |  68 +++----
 .../bpf/prog_tests/kprobe_multi_test.c        |   6 +-
 19 files changed, 485 insertions(+), 208 deletions(-)

-- 
2.34.1

