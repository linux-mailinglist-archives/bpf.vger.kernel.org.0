Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C10A55913F
	for <lists+bpf@lfdr.de>; Fri, 24 Jun 2022 07:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiFXE4r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jun 2022 00:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiFXE4p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jun 2022 00:56:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF67BC7
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 21:56:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DFDD61736
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 04:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F8FC34114;
        Fri, 24 Jun 2022 04:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656046603;
        bh=LPo1ldym9bsUjCMX5U9Oc5v52wr62eVY3zSvnL2eiEY=;
        h=From:To:Cc:Subject:Date:From;
        b=fjIyrHH/KilrxCVpaUT42/AnPMjq0FotfgaXwlJZUt3SyxJipc8KTJA9opyLggSx4
         q6SR2QAcs0isXIpNRidz6+Mczy1nccEL2pk/pAGAOr3U80L1EKXUCEYtYQ5Mi+SKO4
         0aJnz+RXxRI6b8YOxkJvwH5/P2cT2VBcZ3KqsHWU4pHNJvZ1b80WkEC2SzXTUgLAje
         RgPVVED4XZ1dyDWIJBbEJ9kYC9kThsd5p8mZy/pLotZMc9XQKh7ZLLpkX1JhhuvMth
         1XPTOF4DoU2xhwJr/VBemvXQF4Skz3f9wLOenv5Z+4dsT+TUZM3k8d8d3d6fVsWOqq
         EOIaBCp2XewGA==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: [PATCH v4 bpf-next 0/5] Add bpf_getxattr
Date:   Fri, 24 Jun 2022 04:56:31 +0000
Message-Id: <20220624045636.3668195-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

v3 -> v4

- Fixed issue incorrect increment of arg counter
- Removed __weak and noinline from kfunc definiton
- Some other minor fixes.

v2 -> v3

- Fixed missing prototype error
- Fixes suggested by other Joanne and Kumar.

v1 -> v2

- Used kfuncs as suggested by Alexei
- Used Benjamin Tissoires' patch from the HID v4 series to add a
  sleepable kfunc set (I sent the patch as a part of this series as it
  seems to have been dropped from v5) and acked it. Hope this is okay.
- Added support for verifying string constants to kfuncs

Foundation for building more complex security policies using the
BPF LSM as presented in LSF/MM/BPF:

 http://vger.kernel.org/bpfconf2022_material/lsfmmbpf2022-xattr.pdf

Benjamin Tissoires (1):
  btf: Add a new kfunc set which allows to mark a function to be
    sleepable

KP Singh (4):
  bpf: kfunc support for ARG_PTR_TO_CONST_STR
  bpf: Allow kfuncs to be used in LSM programs
  bpf: Add a bpf_getxattr kfunc
  bpf/selftests: Add a selftest for bpf_getxattr

 include/linux/bpf_verifier.h                  |  2 +
 include/linux/btf.h                           |  2 +
 kernel/bpf/btf.c                              | 38 +++++++-
 kernel/bpf/verifier.c                         | 89 +++++++++++--------
 kernel/trace/bpf_trace.c                      | 42 +++++++++
 .../testing/selftests/bpf/prog_tests/xattr.c  | 58 ++++++++++++
 tools/testing/selftests/bpf/progs/xattr.c     | 37 ++++++++
 7 files changed, 228 insertions(+), 40 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/xattr.c

-- 
2.37.0.rc0.104.g0611611a94-goog

