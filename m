Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4654A553BC4
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 22:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352632AbiFUUqv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jun 2022 16:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352430AbiFUUqu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jun 2022 16:46:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4971223BC4
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 13:46:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05CFEB80F63
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 20:46:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D259C3411C;
        Tue, 21 Jun 2022 20:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655844407;
        bh=WlV96+U4qLVE+yTyigJEQCop24tCYm7hTxYvnjuO7Hc=;
        h=From:To:Cc:Subject:Date:From;
        b=VsHefN9xfmIt448srfQLqnmpYW/Ei642kClu/ZLWEF+Zp9TSNE5aapVpXLTvFftcL
         CQ5v6gUw9moxwpi3SyFmfIZX17mvLAjUuXnrYJRfMMWUdNwVTBari/taKawxNLQ5ay
         OYuCuhjp3DX+U0ppbfXiKCEhKwVCO5EdI5dhk4DCAkqB32Tvpg0yyVfOBKgKU1kqVk
         ScS8ZkM4r8MeJu1kwdmEsxxCuw5KBLzw2tHWc7EGMepzXargR5yN/MyfbkFZirPzFV
         YPewJ7zBB6eWt0RgSBO5xBGWnuNo9z2+aQeTA9ICVpD7WippsQpyumD9S4BR2g/rK9
         3obEJPRllISPg==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: [PATCH v3 bpf-next 0/5] Add bpf_getxattr
Date:   Tue, 21 Jun 2022 20:46:37 +0000
Message-Id: <20220621204642.2891979-1-kpsingh@kernel.org>
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
 kernel/bpf/btf.c                              | 39 +++++++-
 kernel/bpf/verifier.c                         | 89 +++++++++++--------
 kernel/trace/bpf_trace.c                      | 42 +++++++++
 .../testing/selftests/bpf/prog_tests/xattr.c  | 58 ++++++++++++
 tools/testing/selftests/bpf/progs/xattr.c     | 37 ++++++++
 7 files changed, 229 insertions(+), 40 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/xattr.c

-- 
2.37.0.rc0.104.g0611611a94-goog

