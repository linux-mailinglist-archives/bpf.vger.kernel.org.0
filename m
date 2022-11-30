Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FE363CF5F
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 07:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbiK3GzT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 01:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiK3GzS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 01:55:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E316F4B74E
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 22:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669791259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=H2iGqtyDsxGM7nTHtMoLbX3Il/zIE8f3Q7faI7ZXAUw=;
        b=O3iM+P7d9XfUB8Eyp6xYl9q0KTXNdsARgLhFE0TU3da99KIBtx0QeZrsJanByR0W2NP6ud
        nePZEE3UK9Zy4pCnW7v2EVmFfsq68EYA8G+nI5nWLE13LKdCKG+meDn5fKP8aBrRRanFz0
        xancLrbGOKXaqsFYM4s4t87Jjt1YmGE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-445-p_mlVDGfObKKaRtgZKNg5w-1; Wed, 30 Nov 2022 01:54:12 -0500
X-MC-Unique: p_mlVDGfObKKaRtgZKNg5w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F59A29AB3F1;
        Wed, 30 Nov 2022 06:54:12 +0000 (UTC)
Received: from ovpn-192-146.brq.redhat.com (ovpn-192-146.brq.redhat.com [10.40.192.146])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 19D67C15BA4;
        Wed, 30 Nov 2022 06:54:08 +0000 (UTC)
From:   Viktor Malik <vmalik@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next v2 0/3] Fix attaching fentry/fexit/fmod_ret/lsm to modules
Date:   Wed, 30 Nov 2022 07:54:01 +0100
Message-Id: <cover.1669787912.git.vmalik@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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
use the vmlinux function address as the target trampoline, attempting to
attach two functions to the same trampoline (which is prohibited).

[1] https://github.com/iovisor/bpftrace/pull/2315

---
Changes in v2:
- introduced and used more space-efficient kallsyms lookup function,
  suggested by Jiri Olsa
- included Hao Luo's comments

Viktor Malik (3):
  kallsyms: add space-efficient lookup in one module
  bpf: Fix attaching fentry/fexit/fmod_ret/lsm to modules
  bpf/selftests: Test fentry attachment to shadowed functions

 include/linux/btf.h                           |   1 +
 include/linux/module.h                        |   1 +
 kernel/bpf/btf.c                              |   5 +
 kernel/bpf/verifier.c                         |   5 +-
 kernel/module/kallsyms.c                      |  16 +++
 net/bpf/test_run.c                            |   5 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |   7 +
 .../bpf/prog_tests/module_attach_shadow.c     | 124 ++++++++++++++++++
 8 files changed, 163 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/module_attach_shadow.c

-- 
2.38.1

