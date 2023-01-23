Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DA8678BEF
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 00:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjAWXWh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 18:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjAWXWf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 18:22:35 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A92F17CF7;
        Mon, 23 Jan 2023 15:22:35 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id jr19so10503762qtb.7;
        Mon, 23 Jan 2023 15:22:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=04jkzre1j7/rYjmK6iSYqnpMbEfaeULGdhvfnEgScyY=;
        b=H4Jc/ORnE4swwF1AYtKg27W13MLCSfxrfV9bWCDKNRnI3vWzWvgYpbHb+nTtB894yZ
         0rgCsdO36lwrimbL0cd4VYjR6PV5xQZTCtdNgy8aGuG9+HBxE3cuqb1HCxDHmaymw+DN
         OAJIb3CBd+56J0vfNzTxyNNrKzYTF2sf18he1O+6ZmPrlSXYZVp3P6sHqp+Ie7E1iRYt
         7pl21mqz66g8BsWA7o8c3+ZN0wxKnIh6/esSsbY7PrWBNLFRTz+p7gF5PogfZCmpTyqb
         6riwtQ89u27uSWNnBX3TV/iwsyLCKJTXsIoE7rynddTlMZwgP6pI3TOUd2UZ6NONu/BO
         q8CA==
X-Gm-Message-State: AFqh2kqVdX1PPOMwZL8xZ57zMlWuLPRb9XKWZB+NMlEK6p6/359kNf+K
        lEhZr0HXmaYlX+TYMP4h8/7BkTs+HCqM6lg3
X-Google-Smtp-Source: AMrXdXuoIIwMF3dRqgCDSAIByB9oXZ/ttc4bizmD4j5ZBRkL0XuPqDlHM41T7v/JczwF3yfEyLnyqA==
X-Received: by 2002:ac8:5a88:0:b0:3a7:e2df:e868 with SMTP id c8-20020ac85a88000000b003a7e2dfe868mr48158327qtc.41.1674516153785;
        Mon, 23 Jan 2023 15:22:33 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:93a0])
        by smtp.gmail.com with ESMTPSA id p14-20020ac8408e000000b003b6894f7002sm212272qtl.9.2023.01.23.15.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 15:22:33 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org, memxor@gmail.com
Subject: [PATCH bpf-next 0/3] Enable struct_ops programs to be sleepable
Date:   Mon, 23 Jan 2023 17:22:25 -0600
Message-Id: <20230123232228.646563-1-void@manifault.com>
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

BPF struct_ops programs currently cannot be marked as sleepable. This
need not be the case -- struct_ops programs could be sleepable, and e.g.
invoke kfuncs that export the KF_SLEEPABLE flag.

Enabling this is simple -- we just have to change a couple of lines in
the verifier. This patch set does that, then allows struct_ops backends
to validate the program being loaded to check if it's allowed to be
sleepable, and finally adds a testcase to validate all of this.

David Vernet (3):
  bpf: Allow BPF_PROG_TYPE_STRUCT_OPS programs to be sleepable
  bpf: Pass const struct bpf_prog * to .check_member
  bpf/selftests: Verify struct_ops prog sleepable behavior

 include/linux/bpf.h                           |  4 +-
 kernel/bpf/verifier.c                         |  7 +-
 net/bpf/bpf_dummy_struct_ops.c                | 18 ++++
 net/bpf/test_run.c                            |  6 ++
 net/ipv4/bpf_tcp_ca.c                         |  3 +-
 .../selftests/bpf/prog_tests/dummy_st_ops.c   | 85 +++++++++++++++++--
 .../selftests/bpf/progs/dummy_st_ops.c        | 11 +++
 7 files changed, 121 insertions(+), 13 deletions(-)

-- 
2.39.0

