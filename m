Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6C56A2A86
	for <lists+bpf@lfdr.de>; Sat, 25 Feb 2023 16:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjBYPkR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Feb 2023 10:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBYPkQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Feb 2023 10:40:16 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4069213D60
        for <bpf@vger.kernel.org>; Sat, 25 Feb 2023 07:40:15 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id i34so8836774eda.7
        for <bpf@vger.kernel.org>; Sat, 25 Feb 2023 07:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NEewDrwrbQX9FqqiEV7vA1z3n4smdXdUfbrV2+Vz3p4=;
        b=g/BoJO5mfULTJfEArYDfuCIFnoVcS4PfZ6Ayy67kUC4c8U355TBjkeiuwbnc6kZz/a
         U3DfsZmljB4bVoyVwB0OWGj0i99mdYLlfgTANYceuPnvCM+QdOYnXaPhLACIgdkISSCS
         LjihSpJ/us2sWG4FvRxPUyrRlXMaSVbmmUB4LbaQsHdWwxbLgjnDoKp7LFccloDF63PB
         lgj2mbULF89e+ShgJlDVBbEvCrWFOMwH11xjEF1vMKFuEFaxGQ54tmvIcMLOuDp9Kza1
         g6ovV7CJ6yiF69aweLQb8/k8+IYK64ct3Dz7gr5464JxVFItLyS/DYmXq+6/jt4PpLbh
         Uhng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NEewDrwrbQX9FqqiEV7vA1z3n4smdXdUfbrV2+Vz3p4=;
        b=Q7kuoJ7pF1gsZXaXVJS7Fuq14J57jVii0vLQ/ZV2aqv0haLkXee0nCK0JKYC8bxfaG
         APdCCOKpNFLrL3Nom6O39zxF9Gkz4PJ09XwRULRYUzYSIJUkUFIOZ3OLPHYgdzm+/BgS
         G1AfksugxPmpR+gfUWV/qEH1qN4+qAnPhnqSoGzyL+NUW/YAOwDfLRl1fCs8wq8s1CAy
         rnSNO4zFdbuAr4Ind12bghuZonxZwsv0dCfjTaRR75VHb7uV5SfSt/7x1Z8eLI9RHHBH
         2jooXV2qKoVzCPHz2/StYdMBjZ6tP6lHfCXVdIuLSlKXSzHXNcWLcm1LeCAartpzhs6J
         E78Q==
X-Gm-Message-State: AO0yUKWzUq0dh+UJKjmhrkXbjtaUu6e8XlQb9PEPAS83LOq2qHlGBu6Z
        KL82ay5jLAAXbjEgV14BVNJLJNrjRy6MXg==
X-Google-Smtp-Source: AK7set+5jcj7G7M2mheQu8OHF/zwWDC3PUoPIs9kHgO4axEemKIqx8Oj516eGeBYf9tP2RXS5YQX2Q==
X-Received: by 2002:a17:906:d7ac:b0:8b2:3e72:101f with SMTP id pk12-20020a170906d7ac00b008b23e72101fmr30356672ejb.19.1677339613197;
        Sat, 25 Feb 2023 07:40:13 -0800 (PST)
Received: from localhost ([2001:620:618:580:2:80b3:0:30])
        by smtp.gmail.com with ESMTPSA id 27-20020a508e1b000000b004aef609f747sm978589edw.3.2023.02.25.07.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 07:40:12 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v3 0/3] Add support for kptrs in more BPF maps
Date:   Sat, 25 Feb 2023 16:40:07 +0100
Message-Id: <20230225154010.391965-1-memxor@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2434; i=memxor@gmail.com; h=from:subject; bh=1qdm820TDzRoomsmVne756s7EK1TBLIjzzJYYPtb1w8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBj+itJB9AaxIjZtuqLJrIfTJyH6ubuY57P/uaGWKDJ R5gs2FOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY/orSQAKCRBM4MiGSL8RyokxEA C/io9F9x4XM0NMBEEr2gx4pW3PSVras3AswpdrVbRyt4dXc7t9uau45ZTAflXKEFEBLB8koD3BPhhw MiFZlwbZhsmicWTLiHQeqDJ/ul+HVU8tJK6Qf5C9ic2ainpu5cT8e9ZW7nTDrLNwY6UQav+TeQDWG4 PCrHKflup1ozjDUIftyKL/5IHG6gwIe06wW/BXg+EmBE8e72qWFVBm5orNf9ZY70w5bs442U5ieIni a58yTXZaI51Uw1DADjIkQ75NwZDQC4yQvqzH6yCW+Q5DWAfaNCgmLBl5L6XPjQkKK2GTYC3SDRWVse mee1f9x1ZEQGHJ28/fbIV+F7PhJE4nXA55YOCEpZRBss5KQI5k7cWnwq95abQ6ZFbpje9QAHxwPQ1P G9Plx34yMvaEwGtNeGZ7TyVKE9Kl1kdz0aXbyRXgP0bMPSAOQ6FF/Kl6dHUp7GUUDwOqNq+T5e43i3 hFzbroigZ0kgrWpGDxSjo/bOxsYs0mVLQNU8iZIzk0Ik+VquRgUfmGRbdQMEw2RqSDKG/N2MN6MREM 38S/eMxXirBydNNobt24A0sF4JFnnl+FmRZ/KrfqPAnBZE7reIefnJEhlShHXGBHXIcz+wg3h+N1sI kLXVoqFPB/h7kDFtJXsKE7zJlD/n2EArla8ugnHF/kMe3NS+xkT+1WyrDG1g==
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
and local storage maps (covering sk, cgrp, task, inode).

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
v2 -> v3
v2: https://lore.kernel.org/bpf/20230221200646.2500777-1-memxor@gmail.com/

 * Fix a use-after-free bug in local storage patch
 * Fix selftest for aarch64 (don't use fentry/fmod_ret)
 * Wait for RCU Tasks Trace GP along with RCU GP in selftest

v1 -> v2
v1: https://lore.kernel.org/bpf/20230219155249.1755998-1-memxor@gmail.com

 * Simplify selftests, fix a couple of bugs

Kumar Kartikeya Dwivedi (3):
  bpf: Support kptrs in percpu hashmap and percpu LRU hashmap
  bpf: Support kptrs in local storage maps
  selftests/bpf: Add more tests for kptrs in maps

 include/linux/bpf_local_storage.h             |   6 +
 kernel/bpf/bpf_local_storage.c                |  48 ++-
 kernel/bpf/hashtab.c                          |  59 +--
 kernel/bpf/syscall.c                          |   8 +-
 kernel/bpf/verifier.c                         |  12 +-
 .../selftests/bpf/prog_tests/map_kptr.c       | 136 +++++--
 tools/testing/selftests/bpf/progs/map_kptr.c  | 344 +++++++++++++++---
 .../selftests/bpf/progs/rcu_tasks_trace_gp.c  |  36 ++
 8 files changed, 553 insertions(+), 96 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/rcu_tasks_trace_gp.c


base-commit: 68bfd65fb98d16239d14719a47cc1582510001de
-- 
2.39.2

