Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A427269D908
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 03:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbjBUCzT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Feb 2023 21:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbjBUCzA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Feb 2023 21:55:00 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658562724;
        Mon, 20 Feb 2023 18:54:36 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id u10so3224896pjc.5;
        Mon, 20 Feb 2023 18:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PYRU/rOAadesjlu86+EoUO57rm+/qhq46aQQu1E8Ap0=;
        b=MVw0JTjA+bXaSMXGXE6cojjE+JiwSNEeBmDvFtWzVdbC09tcaAP3Pdkdnas42RKohp
         mC6o0CYGdyOaBKVsdQyt9Ov7Z2TZ/PefDq+Qee6te51UvKHSdHSLCOMz0lWkjADO2xoO
         r0DZYPxAnMS5H3zxx6qRLzgmf1hwmgbkKaZXPIaTYKho3TggLOmuLOfQRhBcurVmbDQC
         LpRNnAXaKOTQNE2sl44ML0USuVbULWv92HWzoVDAOTLnz954z3chCv8oBo26pZCP3lNh
         CZ4Q8bEDDOuIwBCmHRciE9UNvBOTM3qBRbClpd1QUz1mNi0/iz39jdLJ5QyZNzfdnNrI
         TuZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PYRU/rOAadesjlu86+EoUO57rm+/qhq46aQQu1E8Ap0=;
        b=Tiv6rtfoSwIQkhWbRGH4AVawjyDBdwh6EaOkkBnfpBjqlBfyNFuL9bS3qkhlyzzcr5
         8MKzLBitDdGoJ7YUo0a48PnFFWAv34T8JrelRLIKrueRtK13eT5v+4wPIg7jDND48VQt
         fEdZAyypOw1cvOoMHlRvuv0uxd+N80/o4HuPdoE2hW2dtHqWYzjfE80dIOgYHpoz9UbK
         yT8MLflMDm8T/fcn7eU4DNrK/1+FwrNhiicNxX44RyjQCMy4qFynXtZanAdOhHru0mul
         V67FXfKelDeBtUwbdQFLEjqVyNMdyjChHVGEnXjUfFCFU8ZJuBxE6xS+hpAPu0G1owNv
         o43g==
X-Gm-Message-State: AO0yUKVoZCeF0rQavcEZL+rmI9i4458FfNpIIgat2pgem6ZRJ7geeMz9
        p+Lii4rKIuaerOlyCqq1aRFctC8v3BkklCVJ
X-Google-Smtp-Source: AK7set8Nut7yeFFwYSaODhm/sNgK4Y4oFA/oTbVii6xWm3Z70gsQK42x3x1H/e4TRqxd3SULm2JPHg==
X-Received: by 2002:a17:903:1205:b0:19a:b151:bf68 with SMTP id l5-20020a170903120500b0019ab151bf68mr2964627plh.38.1676948067813;
        Mon, 20 Feb 2023 18:54:27 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.16])
        by smtp.gmail.com with ESMTPSA id k3-20020a170902e90300b0019a837be977sm8590156pld.271.2023.02.20.18.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 18:54:27 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     andrii.nakryiko@gmail.com, alan.maguire@oracle.com
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, benbjiang@tencent.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>
Subject: [PATCH bpf-next v3 0/3] libbpf: allow users to set kprobe/uprobe attach mode
Date:   Tue, 21 Feb 2023 10:53:44 +0800
Message-Id: <20230221025347.389047-1-imagedong@tencent.com>
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

By default, libbpf will attach the kprobe/uprobe eBPF program in the
latest mode that supported by kernel. In this series, we add the support
to let users manually attach kprobe/uprobe in legacy/perf/link mode in
the 1th patch.

And in the 2th patch, we split the testing 'attach_probe' into multi
subtests, as Andrii suggested.

In the 3th patch, we add the testings for loading kprobe/uprobe in
different mode.

Changes since v2:
- fix the typo in the 2th patch

Changes since v1:
- some small changes in the 1th patch, as Andrii suggested
- split 'attach_probe' into multi subtests

Menglong Dong (3):
  libbpf: add support to set kprobe/uprobe attach mode
  selftests/bpf: split test_attach_probe into multi subtests
  selftests/bpf: add test for legacy/perf kprobe/uprobe attach mode

 tools/lib/bpf/libbpf.c                        |  42 ++-
 tools/lib/bpf/libbpf.h                        |  31 +-
 .../selftests/bpf/prog_tests/attach_probe.c   | 283 ++++++++++++------
 .../bpf/progs/test_attach_kprobe_sleepable.c  |  23 ++
 .../selftests/bpf/progs/test_attach_probe.c   |  45 +--
 .../bpf/progs/test_attach_probe_manual.c      |  53 ++++
 6 files changed, 337 insertions(+), 140 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_attach_kprobe_sleepable.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_attach_probe_manual.c

-- 
2.39.0

