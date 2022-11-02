Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4C561617E
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 12:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbiKBLNK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 07:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiKBLNH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 07:13:07 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174CE27DE3
        for <bpf@vger.kernel.org>; Wed,  2 Nov 2022 04:12:53 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id d25so27214832lfb.7
        for <bpf@vger.kernel.org>; Wed, 02 Nov 2022 04:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4nOAzoMxDAS9rcXqet8/6HQvCaOnZU+cYFlpsdxzLl0=;
        b=XIRMFo3gnVhy4ufnXupGIiY1YIrbYGMiq5+g+ILZAMWgvDOIDfbwfKi/HQOZs9EjaX
         RfW9n0IE2oynpKttcd/rU9J341szq0UvDLyFRxhygRUxIqO3Po95jf48mxIaiPdkwxku
         YV9jaOuCOp6OL6NqD6ujS65FKJ7BnAGpquuF4KfZSxDxGLrA3FOefFSg2F1h7vu0Zw98
         KRei9cMFO4f8SxruratKxSReuTMFA1vlVLI5P37rv9oV8evsjoicDrt2ggZOeuxsQNb9
         XRWqidWssfxtqn3tJnMj3g+erLR8ypWDu03FQcSkp50X4Z4h6FCu2lUNSRvgRh4u7pBN
         ioXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4nOAzoMxDAS9rcXqet8/6HQvCaOnZU+cYFlpsdxzLl0=;
        b=tg2nAjPoVV1NoxGLuoDjx4w4wm2jDkx5aVSm/1G0qX9VblKuH5j/zPp1pqd/OP6dXn
         YatwGbICgIN+oErIxGqiWbiN8ZNkaHQaEnJJaBETTIQaRT0lVYyl7Xb6b8ZfTiYWqEom
         1/5NKUYq7DOG1xpnwKRa9SXbg/STi63qOvqBmGh1rxChqDoQYa6/3ntlHpB5wQ3oV4XA
         AsiWqjNhHtjdhD6pat9YMNWiHDNWpcQZx0SE3mtTHVFuCdI+IfiNcGaGXclQ8aSC795g
         0B6gzyKBRjh/nPrNVEkoAzsq2En86ta3DkohgB5+yY6wh/Edsqx2A50LzZKTC446SUTs
         PQCQ==
X-Gm-Message-State: ACrzQf1IR/3a+WzRDQvKv9oB0VQA1qzNMetJXeOkpa71ClMKpEUkDbIt
        WidD1imlgkFyyx/k8/HJnVSowENFl6nkxUgC
X-Google-Smtp-Source: AMsMyM5NWpmZb0oBLJcXRSzG2Mf9MSGFevL1HBvUJ8HWocdoLG7vbAzvIDigyQM3Z2sznim95F2CqQ==
X-Received: by 2002:a05:6512:3b81:b0:4a2:8aa3:cf42 with SMTP id g1-20020a0565123b8100b004a28aa3cf42mr8755805lfv.301.1667387390096;
        Wed, 02 Nov 2022 04:09:50 -0700 (PDT)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id a6-20020a05651c010600b0026dcac60624sm2039781ljb.108.2022.11.02.04.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 04:09:49 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, alan.maguire@oracle.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 0/4] libbpf: Resolve unambigous forward declarations
Date:   Wed,  2 Nov 2022 13:09:01 +0200
Message-Id: <20221102110905.2433622-1-eddyz87@gmail.com>
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
 tools/lib/bpf/btf.c                           | 183 +++++++++++++++---
 tools/lib/bpf/btf_dump.c                      |  16 +-
 tools/lib/bpf/hashmap.c                       |  16 +-
 tools/lib/bpf/hashmap.h                       |  35 ++--
 tools/lib/bpf/libbpf.c                        |  18 +-
 tools/lib/bpf/strset.c                        |  24 +--
 tools/lib/bpf/usdt.c                          |  31 ++-
 tools/testing/selftests/bpf/prog_tests/btf.c  | 152 +++++++++++++++
 .../bpf/prog_tests/btf_dedup_split.c          |  45 +++--
 .../selftests/bpf/prog_tests/hashmap.c        |  68 +++----
 .../bpf/prog_tests/kprobe_multi_test.c        |   6 +-
 19 files changed, 482 insertions(+), 208 deletions(-)

-- 
2.34.1

