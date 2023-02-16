Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5242699159
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 11:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjBPKdt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Feb 2023 05:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjBPKdr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 05:33:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB64F5B86
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 02:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676543575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8AAUI3PcbzXKBBVlg6I+wfiBGdAIt2D64w3Vzc4iXUc=;
        b=K10GtVFdBTxA3x4dP0Y3K51nnp2WzWefGX1CbO66afJSGi96hMJhSihq53Mw332MKmwMXj
        rM7r30gFJw2TJv+tpo0gYb9pn8fIVK9hAf+szsybjbjYWXcpm8YAYj6Cc1AYdLbe4yQWnX
        ibdQ455s5fdY4MdrBTl54z8AK1jkke4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-533-UzmVF1UIN3-DjXEZuAxsZA-1; Thu, 16 Feb 2023 05:32:50 -0500
X-MC-Unique: UzmVF1UIN3-DjXEZuAxsZA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03DEC85CBE6;
        Thu, 16 Feb 2023 10:32:50 +0000 (UTC)
Received: from ovpn-193-202.brq.redhat.com (ovpn-193-202.brq.redhat.com [10.40.193.202])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2033240C1423;
        Thu, 16 Feb 2023 10:32:46 +0000 (UTC)
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
Subject: [PATCH bpf-next v6 0/2] Fix attaching fentry/fexit/fmod_ret/lsm to modules
Date:   Thu, 16 Feb 2023 11:32:40 +0100
Message-Id: <cover.1676542796.git.vmalik@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

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
right before the program itself is unloaded.

---
Changes in v6:
- storing the module reference inside bpf_prog_aux instead of
  bpf_trampoline and releasing it when the program is unloaded
  (suggested by Jiri Olsa)

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
 kernel/bpf/trampoline.c                       |  27 ----
 kernel/bpf/verifier.c                         |  20 ++-
 kernel/module/internal.h                      |   5 +
 net/bpf/test_run.c                            |   5 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |   6 +
 .../bpf/prog_tests/module_attach_shadow.c     | 131 ++++++++++++++++++
 8 files changed, 169 insertions(+), 28 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/module_attach_shadow.c

-- 
2.39.1

