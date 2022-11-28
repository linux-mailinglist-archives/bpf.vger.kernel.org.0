Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5711263A1F7
	for <lists+bpf@lfdr.de>; Mon, 28 Nov 2022 08:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiK1H1l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Nov 2022 02:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiK1H1i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Nov 2022 02:27:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FED13E22
        for <bpf@vger.kernel.org>; Sun, 27 Nov 2022 23:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669620407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nG5eYstJ0nX/CY5OkDMZ+vp8vbyytdDbuM6xBU/t/Nc=;
        b=a6k/dxiAMyy5rk96FEYzngvy0cBnqJMRdTc62cvXSHIWn9+3kCW1GUylHm0h9v0UsIfDO4
        mcP1zIc6jrOleMmVdgJ88ctqpo8Bu6/MHYQHX+z1hIS7sEi81nSBTC2CrmY+bq8oDclfz+
        DdUlWiAfH7V6CvaVDqI4/KstJ9vf83g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-446-3n_IvGO5P3CmKv-5cMUJiA-1; Mon, 28 Nov 2022 02:26:41 -0500
X-MC-Unique: 3n_IvGO5P3CmKv-5cMUJiA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1AA6E802314;
        Mon, 28 Nov 2022 07:26:41 +0000 (UTC)
Received: from ovpn-192-85.brq.redhat.com (ovpn-192-85.brq.redhat.com [10.40.192.85])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E9A41415100;
        Mon, 28 Nov 2022 07:26:37 +0000 (UTC)
From:   Viktor Malik <vmalik@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next 0/2] Fix attaching fentry/fexit/fmod_ret/lsm to modules
Date:   Mon, 28 Nov 2022 08:26:28 +0100
Message-Id: <cover.1669216157.git.vmalik@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

Viktor Malik (2):
  bpf: Fix attaching fentry/fexit/fmod_ret/lsm to modules
  bpf/selftests: Test fentry attachment to shadowed functions

 include/linux/btf.h                           |   1 +
 kernel/bpf/btf.c                              |   5 +
 kernel/bpf/verifier.c                         |   9 +-
 net/bpf/test_run.c                            |   5 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |   7 +
 .../bpf/prog_tests/module_attach_shadow.c     | 120 ++++++++++++++++++
 6 files changed, 146 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/module_attach_shadow.c

-- 
2.38.1

