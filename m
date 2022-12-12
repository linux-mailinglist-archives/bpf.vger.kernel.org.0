Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DE6649F4C
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 14:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbiLLNBL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 08:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbiLLNAe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 08:00:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFCFDCF
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 04:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670849968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OS5HvLCtm+4ptAbGDYWFgbUKjClVtcCJqUAVXrv8ZJQ=;
        b=UNwRy3lWei892hlkldas6HGHHNNQAzcOQ4cGedVXCM5fuXLEXr4NcQ+64RNybsn0CjyxfP
        d+7xkiLz+xcx3ASEz3KevRkr4eeLs/eLk0puXdGr7NoSyx8sfn2ppUuPK3y2Ud3Gfa3RHL
        ZwAGgiMISKdSpThNj+iGpHaUtLZoFBk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-118-cKTx7KtGM26xjrOQj5-DLQ-1; Mon, 12 Dec 2022 07:59:25 -0500
X-MC-Unique: cKTx7KtGM26xjrOQj5-DLQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A78780252C;
        Mon, 12 Dec 2022 12:59:24 +0000 (UTC)
Received: from ovpn-195-46.brq.redhat.com (ovpn-195-46.brq.redhat.com [10.40.195.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F33B2026D4B;
        Mon, 12 Dec 2022 12:59:20 +0000 (UTC)
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
        Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next v4 0/2] Fix attaching fentry/fexit/fmod_ret/lsm to modules
Date:   Mon, 12 Dec 2022 13:59:14 +0100
Message-Id: <cover.1670847888.git.vmalik@redhat.com>
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

While working on bpftrace support for BTF in modules [1], I noticed that
the verifier behaves incorrectly when attaching to fentry of multiple
functions of the same name located in different modules (or in vmlinux).

The reason for this is that if the target program is not specified, the
verifier will search kallsyms for the trampoline address to attach to.
The entire kallsyms is always searched, not respecting the module in
which the function to attach to is located.

This patch fixes the above issue by extracting the module name from the
BTF of the attachment target (which must be specified) and by doing the
search in kallsyms of the correct module.

This also adds a new test in test_progs which tries to attach a program
to fentry of two functions of the same name, one located in vmlinux and
the other in bpf_testmod. Prior to the fix, the verifier would always
use the vmlinux function address for the target trampoline, attempting
to create two trampolines for the same address (which is prohibited).

[1] https://github.com/iovisor/bpftrace/pull/2315

---
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

 kernel/bpf/verifier.c                         |  16 ++-
 net/bpf/test_run.c                            |   5 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |   6 +
 .../bpf/prog_tests/module_attach_shadow.c     | 131 ++++++++++++++++++
 4 files changed, 157 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/module_attach_shadow.c

-- 
2.38.1

