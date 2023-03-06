Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B3E6AB684
	for <lists+bpf@lfdr.de>; Mon,  6 Mar 2023 07:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjCFGs5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Mar 2023 01:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCFGs4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Mar 2023 01:48:56 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C1F83E1;
        Sun,  5 Mar 2023 22:48:55 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id h31so4877006pgl.6;
        Sun, 05 Mar 2023 22:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678085335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eFHn5FfCLzXc2Zphnr99D4T7djusYGDgP5E+TmE5X9w=;
        b=hwfI/PoR3OCowF0hC6XGu7u3UjF3R0yxH+qvnJG/8wl1/Ea0AMk+bRwOM/wPuul/Py
         md27lKglZeoDlu9N5BwmftfOXWWIHw4NlwFOpU5K41k6TMgQSEaBHvnUTUQlHyWhDc2L
         yPt+gEDVtdp8ErkN3ZFeYYu1KgR+ouSSUpIx3LzW9BrokXlS1RUkulzIrF9LlhDwl/yE
         W4hr/eulkOxu52agwEyeAtVP7G6BFHKSN9+muKV9kyq2FTIJ1C95L8wJhvZmIqei+r3q
         GArGFNqusMujLWvOFz52CCjyeUqqQHpP+m6eh9gIMIeund5PqD2ubCER5WF0icFw/xQX
         uo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678085335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eFHn5FfCLzXc2Zphnr99D4T7djusYGDgP5E+TmE5X9w=;
        b=Ky/qihhwTG9pUUNtdfDCf4LQdoQ+sHT/TbIFmjc1+iZlxMUc2hOU/ljOnnvVudBhp6
         /vdZTLYBP+IhErtv59rJeaf1aHNF3O7FrbDrf2HfnHj3O3eN4VjJZuQeLuaefM8xAdXV
         pp4UsHpgTnNuDwfotYf7ZNGquTI+dmtspXLDvUQ1sxJ8iKW5YrbFI4M7SjfunHESXsBw
         1omwCvKDg+XbgnGVeb86GKpbz2+wwAYCW0AhT37AmiYj8UusIOGEkxMK7Qg/b8nmVtAj
         reXgj2u/3meCyjNQLuCw9d/bKDwGBGrNfasN2nU9ZPUeD6vEApX/V+MPVVaC1waxq+fl
         AbtQ==
X-Gm-Message-State: AO0yUKU7p8nAo0ATh9Es9iol5RlMGpcrIsnMmmK//wbzySqeX38HfvR+
        L9htqnFCYEpJ9WfYR5ppPS4=
X-Google-Smtp-Source: AK7set8fUQTo3aQU4wb80VhcxZJw8dkeT2LDLmo0bJpZNpRAQhbOFvXZqxNnBm8o8R/BNUJYZXE+Sg==
X-Received: by 2002:a62:4e43:0:b0:5a8:b649:99d4 with SMTP id c64-20020a624e43000000b005a8b64999d4mr9030345pfb.7.1678085334641;
        Sun, 05 Mar 2023 22:48:54 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.82])
        by smtp.gmail.com with ESMTPSA id g9-20020aa78189000000b0061a942c8b62sm2378184pfi.43.2023.03.05.22.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 22:48:54 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     andrii.nakryiko@gmail.com, alan.maguire@oracle.com
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, benbjiang@tencent.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>
Subject: [PATCH bpf-next v4 0/3] libbpf: allow users to set kprobe/uprobe attach mode
Date:   Mon,  6 Mar 2023 14:48:30 +0800
Message-Id: <20230306064833.7932-1-imagedong@tencent.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
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

From: Menglong Dong <imagedong@tencent.com>

By default, libbpf will attach the kprobe/uprobe BPF program in the
latest mode that supported by kernel. In this series, we add the support
to let users manually attach kprobe/uprobe in legacy/perf/link mode in
the 1th patch.

And in the 2th patch, we split the testing 'attach_probe' into multi
subtests, as Andrii suggested.

In the 3th patch, we add the testings for loading kprobe/uprobe in
different mode.

Changes since v3:
- rename eBPF to BPF in the doc
- use OPTS_GET() to get the value of 'force_ioctl_attach'
- error out on attach mode is not supported
- use test_attach_probe_manual__open_and_load() directly

Changes since v2:
- fix the typo in the 2th patch

Changes since v1:
- some small changes in the 1th patch, as Andrii suggested
- split 'attach_probe' into multi subtests

Menglong Dong (3):
  libbpf: add support to set kprobe/uprobe attach mode
  selftests/bpf: split test_attach_probe into multi subtests
  selftests/bpf: add test for legacy/perf kprobe/uprobe attach mode

 tools/lib/bpf/libbpf.c                        |  47 ++-
 tools/lib/bpf/libbpf.h                        |  31 +-
 .../selftests/bpf/prog_tests/attach_probe.c   | 291 ++++++++++++------
 .../bpf/progs/test_attach_kprobe_sleepable.c  |  23 ++
 .../selftests/bpf/progs/test_attach_probe.c   |  35 +--
 .../bpf/progs/test_attach_probe_manual.c      |  53 ++++
 6 files changed, 347 insertions(+), 133 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_attach_kprobe_sleepable.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_attach_probe_manual.c

-- 
2.39.0

