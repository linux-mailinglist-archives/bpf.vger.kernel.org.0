Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA1467B72C
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 17:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbjAYQrn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 11:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235580AbjAYQrn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 11:47:43 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509AF5955A;
        Wed, 25 Jan 2023 08:47:42 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id q15so16503913qtn.0;
        Wed, 25 Jan 2023 08:47:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OQEsSarJb+hBFom7gqhSVfq6h8OCdNh0Feofy2X6fd4=;
        b=1aRfFzV+r1Eb5piCGQsABx7yzn7AgDxsjUvVDNQrC1OodebG/j++Zh7FfmzgXm7XXK
         1p7nNO8cd/cFANiqH0BYuOtM4BMkp94iKmyjOQuPELHZ/IHXtkQLFGWUJhVF4bS091kr
         m44fAvTqq2kfnV4nI4m51M0poTlR8bTkE8bb4t+XNDx4rJFXil9jf6uakbwJLLgiU2xm
         VEKgw3aBg1JxHVs78EAAQC9a6tAlUBiixh0OPqWaY7b3DZ5A7cQEX0Y0vNWro5B6bhWD
         dRA8cDYrKqiODtrylEVEqBq9Yeb/6N/wEk5t2g3BUuvh8FnzTv5TatmX/1aw5EFORNgp
         t0zg==
X-Gm-Message-State: AFqh2kqqg+cNDc58/jUMTCNv66OVJaj9xHy5DyWp/fztofBh17GKQnqZ
        vRgOQqjEQqhgGe2iFqTlkCU0NnMkjLjthY6E
X-Google-Smtp-Source: AMrXdXv6Egz1YcKnc24a/RRcyWoKFe7SEUurBXv90qNUxRDuTNVF1/QCesedL410sCtU7A0YWqPMUw==
X-Received: by 2002:ac8:564f:0:b0:3b6:2ee9:7424 with SMTP id 15-20020ac8564f000000b003b62ee97424mr45532927qtt.60.1674665261031;
        Wed, 25 Jan 2023 08:47:41 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:113e])
        by smtp.gmail.com with ESMTPSA id r22-20020ac87ef6000000b003ab7aee56a0sm3577119qtc.39.2023.01.25.08.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 08:47:40 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
Subject: [PATCH bpf-next v4 0/4] Enable struct_ops programs to be sleepable
Date:   Wed, 25 Jan 2023 10:47:31 -0600
Message-Id: <20230125164735.785732-1-void@manifault.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is part 4 of https://lore.kernel.org/bpf/20230123232228.646563-1-void@manifault.com/

Part 3: https://lore.kernel.org/all/20230125050359.339273-1-void@manifault.com/
Part 2: https://lore.kernel.org/all/20230124160802.1122124-1-void@manifault.com/

Changelog:
----------
v3 -> v4:
- Fix accidental typo in name of dummy_st_ops introduced in v2, moving
  it back to dummy_st_ops from dummy_st_ops_success. Should fix s390x
  testruns.

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
 kernel/bpf/verifier.c                         |  7 +--
 net/bpf/bpf_dummy_struct_ops.c                | 18 +++++++
 net/ipv4/bpf_tcp_ca.c                         |  3 +-
 tools/lib/bpf/libbpf.c                        |  1 +
 .../selftests/bpf/prog_tests/dummy_st_ops.c   | 52 ++++++++++++++-----
 .../selftests/bpf/progs/dummy_st_ops_fail.c   | 27 ++++++++++
 ...{dummy_st_ops.c => dummy_st_ops_success.c} | 19 +++----
 .../selftests/bpf/verifier/sleepable.c        |  2 +-
 9 files changed, 103 insertions(+), 30 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/dummy_st_ops_fail.c
 rename tools/testing/selftests/bpf/progs/{dummy_st_ops.c => dummy_st_ops_success.c} (72%)

-- 
2.39.0

