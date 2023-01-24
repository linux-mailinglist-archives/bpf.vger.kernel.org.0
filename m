Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB2A679E38
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 17:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjAXQJ1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 11:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjAXQJ0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 11:09:26 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F191ABFC;
        Tue, 24 Jan 2023 08:09:26 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id d16so13428890qtw.8;
        Tue, 24 Jan 2023 08:09:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4oW+kjbdfD2UZ0Y0yY675AjDRpuz5dKDMbgZwwf8UEg=;
        b=fiGiClFex72BIS1hZUQTUCTdRaUt7TqJmMc57SbHabC15wBR3mjcpa59Lc25H2U4UC
         Fg/9yYR6ePWg+9IsoTMjozKA1owCG7d7OyoejW0s+AUMaqSb49ONzvxSDVKCY86O2KF5
         Mg3IWjqno4S3cACODGurbr0ffXPZXc1iEkQRv5RlkLHo2BkEx9OOvC/J1q0jD9YfBR1+
         +oGj2pL2bo6RBvVJHWVPwXhy6Cqr5mgCfyYhAWU1s8+nOV+sZm9jt/lFC0Xzd1NeNCTb
         5XBLlfnQ+JKRku+I+DaJWWwmflaSC6GzdUItlc6rRuKoKUT6UY7ipd71g17HrO0NGFOa
         /4qg==
X-Gm-Message-State: AFqh2krWQ31dOmWvf/XnCCr0dJQm3+obXm15m3Z0r6FZeHOct1xyTMC9
        51hWCWU7zg2Jx7Ei65q/1AQ6p5Ob3q0GEqex
X-Google-Smtp-Source: AMrXdXvC+umlqmNelcwfCQdMZV7Tl8BrcqM5LHNEQKBDqBYZBgRv5LOLFDs477x7RVhMGNNpKX3Uuw==
X-Received: by 2002:ac8:5194:0:b0:3b6:302d:714 with SMTP id c20-20020ac85194000000b003b6302d0714mr44609903qtn.4.1674576564672;
        Tue, 24 Jan 2023 08:09:24 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:93a0])
        by smtp.gmail.com with ESMTPSA id d7-20020ac800c7000000b003b0b903720esm1495692qtg.13.2023.01.24.08.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 08:09:24 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
Subject: [PATCH bpf-next v2 0/4] Enable struct_ops programs to be sleepable
Date:   Tue, 24 Jan 2023 10:07:58 -0600
Message-Id: <20230124160802.1122124-1-void@manifault.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is part 2 of https://lore.kernel.org/bpf/20230123232228.646563-1-void@manifault.com/

Changelog:
----------
v1 -> v2:
- Add support for specifying sleepable struct_ops programs with
  struct_ops.s in libbpf (Alexei).
- Move failure test case into new dummy_st_ops_fail.c prog file.
- Update test_dummy_sleepable() to use struct_ops.s instead of manually
  setting prog flags. Also remove open_load_skel() helper which is no
  longer needed.
- Fix verifier tests to expect new sleepable prog failure message.

David Vernet (4):
  bpf: Allow BPF_PROG_TYPE_STRUCT_OPS programs to be sleepable
  libbpf: Support sleepable struct_ops.s section
  bpf: Pass const struct bpf_prog * to .check_member
  bpf/selftests: Verify struct_ops prog sleepable behavior

 include/linux/bpf.h                           |  4 +-
 kernel/bpf/verifier.c                         |  7 ++-
 net/bpf/bpf_dummy_struct_ops.c                | 18 ++++++
 net/bpf/test_run.c                            |  6 ++
 net/ipv4/bpf_tcp_ca.c                         |  3 +-
 tools/lib/bpf/libbpf.c                        |  1 +
 .../selftests/bpf/prog_tests/dummy_st_ops.c   | 56 ++++++++++++++-----
 .../selftests/bpf/progs/dummy_st_ops_common.h | 20 +++++++
 .../selftests/bpf/progs/dummy_st_ops_fail.c   | 41 ++++++++++++++
 ...{dummy_st_ops.c => dummy_st_ops_success.c} | 18 +++---
 10 files changed, 145 insertions(+), 29 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/dummy_st_ops_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/dummy_st_ops_fail.c
 rename tools/testing/selftests/bpf/progs/{dummy_st_ops.c => dummy_st_ops_success.c} (75%)

-- 
2.39.0

