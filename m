Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FE8622DD2
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 15:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbiKIO1S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 09:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbiKIO0z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 09:26:55 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77879FE4
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 06:26:33 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id kt23so47030999ejc.7
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 06:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aCdp9eX3eGQ90Uw95PhN7SWqP8HjyBbydnrC7G0BwTQ=;
        b=p174LXEM5LAv92io56pac6QTTFRe5dJPH12GD0D0+ngXTBIXF1qOmvcPXi9i6ASN7V
         uR6sqMwep7Pl/mcqv3Ho/4Z2YD7n+HH2jTiAJw9o105QC40g0ZZMCHtks88PMTE7LBLb
         sjJTR9LqgjTsJe794ayd/aVNzKp2N3OgNUJQnViLsAdEYyAsRJzEh6sixk/UQnydSGIw
         XOsgXaJkdqIOpCxw01TtodjbqMTk46+M3gzcJVTolUetfuUsI/6dpl7WJxAEOYkzBvNY
         iM1+xDXleYuG3COCaDdwSQ1J4GOliDl/s0/oZFECaZyYROKesHnTMOUcL6Lt2kupbXbw
         Ktnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aCdp9eX3eGQ90Uw95PhN7SWqP8HjyBbydnrC7G0BwTQ=;
        b=uO5RXCjiF0S9qQjb2j23yLGpuPoyDBvv2dmH8AOPAvwxxC3/L3cjMiCBXgrAhHA75O
         4nPC46mNb43ZQHEiBxEBnDZYLXuibSJkD3y/zdMIR8629trLsZD/cNy7qcTZiU4GRIy7
         A85e1rF7C4jAz0IoksBWMDLUcDuJ8jJV9Svs+Zwcddgiz6Ora5hh6iFcI6/rLX4HbKDl
         tRkrJhINYQ6l/elSOdlcc6Vy8WiXNVlmgckhq7oCKd02liCPoU4ds1joFW1x5XZm3aJO
         X1lZk8jlTqKUuKLG8NE1dZsBG7QONMQkLub4MbK8yvv78+wBVn/1o257ObvXao7Wx/yn
         BvZQ==
X-Gm-Message-State: ACrzQf1HdvB21Ib1g5P3U6BnGhhAzwjubFSqKdH5kWSXrDmHNOeCJb/o
        dPeweJ4/7f7v3gAxuUgb9Rgbj4+ubwyhW6s7
X-Google-Smtp-Source: AMsMyM547xlsd8FP7L73df7CSVGCYKkjuQzY+UN4ay7IATvXbCDpJ4v20W2+tDI1aUsgnE2LuPPrYA==
X-Received: by 2002:a17:906:899d:b0:7ad:cf09:96be with SMTP id gg29-20020a170906899d00b007adcf0996bemr51206849ejc.221.1668003991988;
        Wed, 09 Nov 2022 06:26:31 -0800 (PST)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id w21-20020a170906131500b007addcbd402esm5921013ejb.215.2022.11.09.06.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 06:26:31 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, alan.maguire@oracle.com, acme@kernel.org,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v4 0/3] libbpf: Resolve unambigous forward declarations
Date:   Wed,  9 Nov 2022 16:26:08 +0200
Message-Id: <20221109142611.879983-1-eddyz87@gmail.com>
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
- An update for libbpf's hashmap interface from void* -> void* to a
  polymorphic one, allowing to use both long and void* keys and values
  w/o additional casts. Interface functions are hidden behind
  auxiliary macro that add casts as necessary.
  
  This simplifies many use cases in libbpf as hashmaps there are
  mostly integer to integer and required awkward looking incantations
  like `(void *)(long)off` previously. Also includes updates for perf
  as it copies map implementation from libbpf.
  
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
 v3 -> v4
 Changes suggested by Andrii:
 - hashmap interface rework to allow use of integer and pointer keys
   an values w/o casts as suggested in [1].
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
 v1 -> v2
 - Style fixes in btf_dedup_resolve_fwd and btf_dedup_resolve_fwds as
   suggested by Alan.

[v1] https://lore.kernel.org/bpf/20221102110905.2433622-1-eddyz87@gmail.com/
[v2] https://lore.kernel.org/bpf/20221103033430.2611623-1-eddyz87@gmail.com/
[v3] https://lore.kernel.org/bpf/20221106202910.4193104-1-eddyz87@gmail.com/

[1] https://lore.kernel.org/bpf/CAEf4BzZ8KFneEJxFAaNCCFPGqp20hSpS2aCj76uRk3-qZUH5xg@mail.gmail.com/

Eduard Zingerman (3):
  libbpf: hashmap interface update to allow both long and void*
    keys/values
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
 tools/lib/bpf/btf.c                           | 184 ++++++++++++++---
 tools/lib/bpf/btf_dump.c                      |  17 +-
 tools/lib/bpf/hashmap.c                       |  18 +-
 tools/lib/bpf/hashmap.h                       |  91 +++++----
 tools/lib/bpf/libbpf.c                        |  18 +-
 tools/lib/bpf/strset.c                        |  18 +-
 tools/lib/bpf/usdt.c                          |  29 ++-
 tools/perf/tests/expr.c                       |  28 +--
 tools/perf/tests/pmu-events.c                 |   6 +-
 tools/perf/util/bpf-loader.c                  |  11 +-
 tools/perf/util/evsel.c                       |   2 +-
 tools/perf/util/expr.c                        |  36 ++--
 tools/perf/util/hashmap.c                     |  18 +-
 tools/perf/util/hashmap.h                     |  91 +++++----
 tools/perf/util/metricgroup.c                 |  10 +-
 tools/perf/util/stat-shadow.c                 |   2 +-
 tools/perf/util/stat.c                        |   9 +-
 tools/testing/selftests/bpf/prog_tests/btf.c  | 176 ++++++++++++++++
 .../bpf/prog_tests/btf_dedup_split.c          |  45 +++--
 .../selftests/bpf/prog_tests/hashmap.c        | 190 +++++++++++++-----
 .../bpf/prog_tests/kprobe_multi_test.c        |   6 +-
 29 files changed, 756 insertions(+), 357 deletions(-)

-- 
2.34.1

