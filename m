Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0365F69E8D0
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 21:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjBUUGv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 15:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjBUUGv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 15:06:51 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFE927997
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 12:06:49 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id ck15so23184164edb.0
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 12:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hjMazF96ZhYmw/k8PzFthwbccIAn9SqulgxIgEvnTc0=;
        b=oozApcb9KfIUZ9y59GbeJ0LGRCkUeSkgwRn+dIyUQoOhKzGYAbne8u+sNKgTzIfzrV
         OYCTQhYOscL/ydLPLsVptPowU9Z90yjqnXE5ZkFnFPGyQS55uZXYGmMXlipt4HOR/3vU
         VUN1jodmcxkByVOx+RNkeYq+zg5lyhR/eXjRhMO5VLZh8z0ne69tz2EnWh2hB8llB4gV
         Ekq3Hdo+rqQ3XGt0u1mG5yEU0A7iqT01PRxREP2BrmpwI2L6ZszZm8KAW6ATY4Fpv5ln
         05c9UWHr8IaJmKc4WmKuta1Dc69h1icBIfrLMYvpxfPoj6Zb2ucP3RWhYvTAVSmUy4kc
         CvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hjMazF96ZhYmw/k8PzFthwbccIAn9SqulgxIgEvnTc0=;
        b=xQai6H+lnuZHk1pX4KlRiopHaragpY0sQknS7yjnoFBoZb7SphBKQ7tRSFTGGqaxSY
         MeFDGijVoPBiu60x9rcdFZV7glLJ19XZAeUY0RZ5dGhZZFDm3MkN232Fsq6Nu0b/yhzK
         ahuhvEa41uI7UjRAD/Hh7q9TwOc2tvo9rZKQlJ3Dhlw5vU4qANv4hpQb5B2IatLvKRwj
         Bjh8LxYEpGjrYdCsD25mvSk+Hmgf/XBdy+xu7/ACevlw7Bo7yMQLNZHkqOngpE0526DT
         u9AnV4tXcMkH8JrQh3Nckj+IWMhD0OiIj1sCq3Ku6BxqjwgAfqujq3l46LHPmklZ4Dip
         QX/w==
X-Gm-Message-State: AO0yUKUWzEZR+wVHXLqlMO4IDSpk674p19Nx+OEHBreTcuOb9uXUSZ5n
        kRAtaqmp8JOCxRYwkJWa06H/m3Uj6bbPww==
X-Google-Smtp-Source: AK7set/Q0esPtgWyefj9UhhSkMT0+AUcuXv2okBGxI7uQGD38U1iZ8w/gPkAQmC67R3oJVndUA5LBQ==
X-Received: by 2002:a17:906:c289:b0:8b8:c04f:c5f9 with SMTP id r9-20020a170906c28900b008b8c04fc5f9mr14427862ejz.73.1677010007965;
        Tue, 21 Feb 2023 12:06:47 -0800 (PST)
Received: from localhost ([2001:620:618:580:2:80b3:0:6d0])
        by smtp.gmail.com with ESMTPSA id s21-20020a50d495000000b004aee548b3e2sm2744003edi.69.2023.02.21.12.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 12:06:47 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v2 0/7] Add support for kptrs in more BPF maps
Date:   Tue, 21 Feb 2023 21:06:39 +0100
Message-Id: <20230221200646.2500777-1-memxor@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2417; i=memxor@gmail.com; h=from:subject; bh=xPz6SIhZsUjFPgX+71DGl6hVFZjHXQy08lwx7xnt0hE=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBj9SRLzBdjf69+I1fKeggg52ENWEKgDDU8U/Ekh0z+ u/G+wq6JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY/UkSwAKCRBM4MiGSL8Ryt01D/ 4zixsFwco3ShvTavMcs7hB3vkyMzrYhhgC3x38uocakDTwr4IA68IZCZGQwY7aAEGzjpOrMB54u4va kKwKpfLT30xIwDZ+lPpMQ8n7l0o8vTn0hGBE/1BVzYdfX2glMEzNdUqz1wViPwI+wpknCzwGEmSx1e g9rJN0noPFQ0odR+/aYdyM7SJ1r8yG6lyWh84LjNw0KptMAxIMWnQIApx/jZQN+ZoFA1rVRIqyQjQX RLZkTKRdSH5j3Cu05b/5H887PzLxKS+iWkTzLKdPMS82ld+aVuJzQkhk/ssXr1q5HDTuYeNPU9HOw7 FHfKyIGDu2aEGSgG/N4/I0bXZCvT/fSqUXJ6yPamCmEw1k+anAimKyZrSR76FyF1kHaYjufrtkLHXz 8vj7+Wc2XIxU4D5u//1YxZX5Seq7FJIU8TZMgiP1eOr9xTq5C8u1ci1QuFZFLAPxnwoNuFRL53nngd PmcdNzqkK7djBZ46c0LbVjlvOlHrN/VCATwKpMfu/0VWM9tJIR+89I5smubVDIWMqFNC79GIWbPvv/ cX+u3DHzrQuIo9seUYKleyWkhwsCQFXPCPiJnTNec3UKT/zr1rvUXU15+X4zCvJ715vCE9ZDv60ANo 2qYLJzoL+bHogkgTeun7lR2wNxpii+raEz78XChCdpx0nJ+45lChO2zJJ31Q==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This set adds support for kptrs in percpu hashmaps, percpu LRU hashmaps,
and local storage maps (covering sk, cgrp, task, inode). There are also
minor miscellaneous cleanups rolled in, unrelated to the set, that I
collected over time. Feel free to drop them, they have been
intentionally placed after the kptr support to ease partial application
of the series.

Tests are expanded to test more existing maps at runtime and also test
the code path for the local storage maps (which is shared by all
implementations).

A question for reviewers is what the position of the BPF runtime should
be on dealing with reference cycles that can be created by BPF programs
at runtime using this additional support. For instance, one can store
the kptr of the task in its own task local storage, creating a cycle
which prevents destruction of task local storage. Cycles can be formed
using arbitrarily long kptr ownership chains. Therefore, just preventing
storage of such kptrs in some maps is not a sufficient solution, and is
more likely to hurt usability.

There is precedence in existing runtimes which promise memory safety,
like Rust, where reference cycles and memory leaks are permitted.
However, traditionally the safety guarantees of BPF have been stronger.
Thus, more discussion and thought is invited on this topic to ensure we
cover all usage aspects.

Changelog:
----------
v1 -> v2
v1: https://lore.kernel.org/bpf/20230219155249.1755998-1-memxor@gmail.com

 * Simplify selftests, fix a couple of bugs

Kumar Kartikeya Dwivedi (7):
  bpf: Support kptrs in percpu hashmap and percpu LRU hashmap
  bpf: Support kptrs in local storage maps
  bpf: Annotate data races in bpf_local_storage
  bpf: Remove unused MEM_ALLOC | PTR_TRUSTED checks
  bpf: Fix check_reg_type for PTR_TO_BTF_ID
  bpf: Wrap register invalidation with a helper
  selftests/bpf: Add more tests for kptrs in maps

 kernel/bpf/bpf_local_storage.c                |  51 ++-
 kernel/bpf/hashtab.c                          |  59 +--
 kernel/bpf/syscall.c                          |   8 +-
 kernel/bpf/verifier.c                         |  65 ++--
 .../selftests/bpf/prog_tests/map_kptr.c       | 122 ++++--
 tools/testing/selftests/bpf/progs/map_kptr.c  | 353 +++++++++++++++---
 6 files changed, 540 insertions(+), 118 deletions(-)


base-commit: 951bce29c8988209cc359e1fa35a4aaa35542fd5
-- 
2.39.2

