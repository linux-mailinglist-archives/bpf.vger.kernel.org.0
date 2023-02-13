Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C0D694BEF
	for <lists+bpf@lfdr.de>; Mon, 13 Feb 2023 17:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjBMQB2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Feb 2023 11:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjBMQBU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Feb 2023 11:01:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704091F933
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 08:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676304013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lLKR8qjHl4DW+ozihot8HzkcFeBycVD7uPgmihQyePM=;
        b=NGfDopaf9eCyFSl9IvlQOlR5QcFx0zQ44YwVqBF0KWmmIwuNslBtnGkBaYTmQYKdpWmzLb
        BETbhi99/eSsnoH3zi9aqZGhCNp6xmEcCPUpsHnblb9QtdI86mWt+Wux8YjzkGI42J31sa
        73ncBMyEr9J6x2KHqYDP9F94bvdEQxU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-r7C2d5I1Paiys9wpxyow9w-1; Mon, 13 Feb 2023 11:00:11 -0500
X-MC-Unique: r7C2d5I1Paiys9wpxyow9w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D021B101B429;
        Mon, 13 Feb 2023 16:00:07 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.33.37.15])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 193C52026D2C;
        Mon, 13 Feb 2023 16:00:04 +0000 (UTC)
From:   Viktor Malik <vmalik@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next v5 0/2] Fix attaching fentry/fexit/fmod_ret/lsm to modules
Date:   Mon, 13 Feb 2023 16:59:57 +0100
Message-Id: <cover.1676302508.git.vmalik@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

After some time, posting another version of this patchset.

Context: I noticed that the verifier behaves incorrectly when attaching
to fentry of multiple functions of the same name located in different
modules (or in vmlinux). The reason for this is that if the target
program is not specified, the verifier will search kallsyms for the
trampoline address to attach to. The entire kallsyms is always searched,
not respecting the module in which the function to attach to is located.

As Yonghong correctly pointed out, there is yet another issue - the
trampoline acquires the module reference in register_fentry which means
that if the module is unloaded between the place where the address is
found in the verifier and register_fentry, it is possible that another
module is loaded to the same address in the meantime, which may lead to
errors.

This patch fixes the above issues by extracting the module name from the
BTF of the attachment target (which must be specified) and by doing the
search in kallsyms of the correct module. At the same time, the module
reference is acquired right after the address is found and only released
right before the trampoline itself is removed.

---
Changes in v5:
- fixed acquiring and releasing of module references by trampolines to
  prevent modules being unloaded between address lookup and trampoline
  allocation

Changes in v4:
- reworked module kallsyms lookup approach using existing functions,
  verifier now calls btf_try_get_module to retrieve the module and
  find_kallsyms_symbol_value to get the symbol address (suggested by
  Alexei)
- included Jiri Olsa's comments
- improved description of the new test and added it as a comment into
  the test source

Changes in v3:
- added trivial implementation for kallsyms_lookup_name_in_module() for
  !CONFIG_MODULES (noticed by test robot, fix suggested by Hao Luo)

Changes in v2:
- introduced and used more space-efficient kallsyms lookup function,
  suggested by Jiri Olsa
- included Hao Luo's comments

Viktor Malik (2):
  bpf: Fix attaching fentry/fexit/fmod_ret/lsm to modules
  bpf/selftests: Test fentry attachment to shadowed functions

 include/linux/bpf.h                           |   1 +
 kernel/bpf/syscall.c                          |   2 +
 kernel/bpf/trampoline.c                       |  44 +++---
 kernel/bpf/verifier.c                         |  27 +++-
 kernel/module/internal.h                      |   5 +
 net/bpf/test_run.c                            |   5 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |   6 +
 .../bpf/prog_tests/module_attach_shadow.c     | 131 ++++++++++++++++++
 8 files changed, 190 insertions(+), 31 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/module_attach_shadow.c

-- 
2.39.1

