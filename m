Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E361D5528F7
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 03:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243355AbiFUB23 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jun 2022 21:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240120AbiFUB2T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jun 2022 21:28:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D240E1928B
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 18:28:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91467B811BD
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 01:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16421C3411B;
        Tue, 21 Jun 2022 01:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655774896;
        bh=K0oOL0RFKKNWM96RrEqfv2xaxnbCY547USrJijlDyVw=;
        h=From:To:Cc:Subject:Date:From;
        b=d0iwgInzVihIYVhK4dY1VUIPHJygEYP96THXjf74ADAW1icV52LlL/GHeJkUYUNba
         ZHD04X/HJ+O/8JwfQUWkQPf/nSkBagmJCQBxBgojGl5vW5/zd1+IYVA3K0h5N3vKPD
         jU6Y53ZZgsVN3z5V6ypVdqI/T2iTvchiuoZKzQFfyv+xdiJk4tsjgmkhQjbp47a32/
         I0GVY6S8wTGUxB5pZfg81BrUDbCK7lEXyrCnJFPoTavcbazaUHu62fWcZHHK8xZ4Cx
         ShBRbPes5q1MZzeDmSrS6xlMIzJGZMyvDSkp6MVLEDY1ljHXHhJjO0i/M5HqSgAoQK
         oARyJTyLAHzuQ==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: [PATCH v2 bpf-next 0/5] Add bpf_getxattr
Date:   Tue, 21 Jun 2022 01:28:06 +0000
Message-Id: <20220621012811.2683313-1-kpsingh@kernel.org>
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
 kernel/bpf/btf.c                              | 42 ++++++++-
 kernel/bpf/verifier.c                         | 85 +++++++++++--------
 kernel/trace/bpf_trace.c                      | 36 ++++++++
 .../testing/selftests/bpf/prog_tests/xattr.c  | 58 +++++++++++++
 tools/testing/selftests/bpf/progs/xattr.c     | 37 ++++++++
 7 files changed, 223 insertions(+), 39 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/xattr.c

-- 
2.37.0.rc0.104.g0611611a94-goog

