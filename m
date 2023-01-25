Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E93967A9D2
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 06:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjAYFEK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 00:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjAYFEK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 00:04:10 -0500
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF61474EA;
        Tue, 24 Jan 2023 21:04:07 -0800 (PST)
Received: by mail-pf1-f178.google.com with SMTP id s3so12640649pfd.12;
        Tue, 24 Jan 2023 21:04:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yQTyErXQ5tMybBRfl9siMYjWzCennbntv/U8mzyCIJU=;
        b=33DLnX5DGXB9U4+tD6PKEk/duQnj6/JIJzYvdCs3TR22Wobwemz/pdGvmodGwIBudv
         0KPwDtsO6i0TH3PDkb+Fo7as+ORoddXRZVSdbttM7h4hDTn4WVdVA2HlCm2FNceOZajp
         FV8t4fFo3Uh1ChpKKqwIKIooSYwvGkzxoiBHmYu3qA1FEmRDSaiPXMsT0S4SYABzfNsw
         jpdHSuqZhwxtK8CXJH8nRO5suQoI3gQ61S0bWlGSoqrBlACCjqIbSFtDqNiikQiKWGWN
         kNbnkUAJQH4FpCctpNJu+sBfQjQQSStyEsLUoJ5DH61VAoC/HEO+xhL4oaYI2Psr60PM
         3tUg==
X-Gm-Message-State: AFqh2kq+0rqB4TaOJLhyJGDLcnbG7HpHH/l+wNjQ82sAgo3/kamjHhDR
        Q72RjYsGa5YOTs6eqpOvUw0PIVMPOnyS3mh0
X-Google-Smtp-Source: AMrXdXs+kEgy09V3cjRYSUn77y2tBTcB8HDL64c71/cZfOr2HYmJ2/1HUxO/8t40+fCAU/PTbJ9rdQ==
X-Received: by 2002:a05:6a00:2986:b0:58d:8d7d:80a3 with SMTP id cj6-20020a056a00298600b0058d8d7d80a3mr32488130pfb.20.1674623045882;
        Tue, 24 Jan 2023 21:04:05 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:d24a])
        by smtp.gmail.com with ESMTPSA id a6-20020aa794a6000000b0058bc5f6426asm2494104pfl.169.2023.01.24.21.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 21:04:05 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
Subject: [PATCH bpf-next v3 0/4] Subject: [PATCH bpf-next v2 0/4] Enable struct_ops programs to be sleepable
Date:   Tue, 24 Jan 2023 23:03:55 -0600
Message-Id: <20230125050359.339273-1-void@manifault.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is part 3 of https://lore.kernel.org/bpf/20230123232228.646563-1-void@manifault.com/

Part 2: https://lore.kernel.org/all/20230124160802.1122124-1-void@manifault.com/

Changelog:
----------
v2 -> v3:
- Don't call a KF_SLEEPABLE kfunc from the dummy_st_ops testsuite, and
  remove the newly added bpf_kfunc_call_test_sleepable() test kfunc
  (Martin).
- Include vmlinux.h from progs/dummy_st_ops_success.c (previously
  progs/dummy_st_ops.c) rather than manually defining
  struct bpf_dummy_ops_state and struct bpf_dummy_ops.
  (Martin).
- Fix a typo added to prog_tests/dummy_st_ops.c in a previous version:
  s/trace_dummy_st_ops_success__open/trace_dummy_st_ops__open.

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
 net/ipv4/bpf_tcp_ca.c                         |  3 +-
 tools/lib/bpf/libbpf.c                        |  1 +
 .../selftests/bpf/prog_tests/dummy_st_ops.c   | 56 ++++++++++++++-----
 .../selftests/bpf/progs/dummy_st_ops_fail.c   | 27 +++++++++
 ...{dummy_st_ops.c => dummy_st_ops_success.c} | 19 +++----
 .../selftests/bpf/verifier/sleepable.c        |  2 +-
 9 files changed, 105 insertions(+), 32 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/dummy_st_ops_fail.c
 rename tools/testing/selftests/bpf/progs/{dummy_st_ops.c => dummy_st_ops_success.c} (72%)

-- 
2.39.0

