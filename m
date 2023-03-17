Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A69E6BE88A
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 12:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjCQLtL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 07:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjCQLtF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 07:49:05 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8223D1ABDA
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 04:49:04 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id ja10so5022515plb.5
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 04:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679053744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kk0uRad6bjQYKw9F3qrRObxyQQZB3v3G+nGHyd4h4eo=;
        b=YgUvTcTPNSq3slIljCuOZGciEJM09qGJrjfygow3ticssJKut8oHMfaDYUaSoXGwxY
         6BVkPfdUw1J9lj8F4dTB9K9McPVu5e8RvWqsVbPoU4lMh2HjffFNg9BrUavhfYCuOFdR
         740umkERx9iEOt6/h4lPSuNLCDzf/FNDi/6gKzhJnxOlj6JXZTO6H9MQDV6PvV+v7V71
         Az99gzuN3gQpfH/gHw2WbNwRvC8M/Zy1Uvtd/PbFbqHAUwj5HiMDptVzhSwy00kQiSw5
         5ZbkRe59/NOtw5my5P/Xot0orWLhm445fGV9WmlgtzFY1f1iCPbkhZ/nS8WiXsoYEXzg
         +5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679053744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kk0uRad6bjQYKw9F3qrRObxyQQZB3v3G+nGHyd4h4eo=;
        b=QJshD3uURGTXAhVeazyYg6/dNshgRtFepbqHG3NoYEcNK6oqzouJq3UijthqyGpbSu
         kG6pwYgSm4SjxPKOlKqhLs4PlKysPfVXDoPcEz5QmFeMDsAhCe1mZJ0Gh8NF80fOQwn4
         cfbLgM68JZ8XyX2LO+zxzLIwprl/Rd6xFhL6Ms+rVcFgJE/v4vuDOgaep8iIO/2BUpN0
         vR3cHpsxwnqmTur10y2hYk8HY7i8LNtY1VzR2nCC5+jDHQHOemHVWIDAgpV7k5pX/2NL
         yMiJ95eMNv9fSXfr21B0cUzSwVItV7VjiTz9mkSVsIjxnutZ/e1k0KE+zKgLHR/10h1w
         0Ihw==
X-Gm-Message-State: AO0yUKVmJyYM7CzEkehU5G9hO2x1AfEjFLvxlg+YYum3TWZ/buPEZIAe
        MwAbUGN9EAP7HSPkdRw8byE=
X-Google-Smtp-Source: AK7set+V2gARBAiXTsKTtIj/t8dFOg1A3Z2KY7EyOR3CpibCfJRS7N2tr67pk8mxC8+638rGixHDwA==
X-Received: by 2002:a17:90b:4a49:b0:23d:4241:af0 with SMTP id lb9-20020a17090b4a4900b0023d42410af0mr8125266pjb.3.1679053743929;
        Fri, 17 Mar 2023 04:49:03 -0700 (PDT)
Received: from vultr.guest ([45.76.101.150])
        by smtp.gmail.com with ESMTPSA id l18-20020a17090add9200b0023530b1e4a0sm1356791pjv.2.2023.03.17.04.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 04:49:03 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next] selftests/bpf: Filter out preempt_count_ functions from kprobe_multi bench
Date:   Fri, 17 Mar 2023 11:48:32 +0000
Message-Id: <20230317114832.13622-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It hits below warning on my test machine when running test_progs,

[  702.223611] ------------[ cut here ]------------
[  702.224168] RCU not on for: preempt_count_sub+0x0/0xa0
[  702.224770] WARNING: CPU: 14 PID: 5267 at include/linux/trace_recursion.h:162 fprobe_handler.part.0+0x1b8/0x1c0
[  702.231740] CPU: 14 PID: 5267 Comm: main_amd64 Kdump: loaded Tainted: G           O       6.2.0+ #584
[  702.233169] RIP: 0010:fprobe_handler.part.0+0x1b8/0x1c0
[  702.241388] Call Trace:
[  702.241615]  <TASK>
[  702.241811]  fprobe_handler+0x22/0x30
[  702.242129]  0xffffffffc04710f7
[  702.242417] RIP: 0010:preempt_count_sub+0x5/0xa0
[  702.242809] Code: c8 50 68 94 42 0e b5 48 cf e9 f9 fd ff ff 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 e8 4b cd 38 0b <55> 8b 0d 9c d0 cf 02 48 89 e5 85 c9 75 1b 65 8b 05 be 78 f4 4a 89
[  702.244752] RSP: 0018:ffffaf6187d27f10 EFLAGS: 00000082 ORIG_RAX: 0000000000000000
[  702.245801] RAX: 000000000000000e RBX: 0000000001b6ab72 RCX: 0000000000000000
[  702.246804] RDX: 0000000000000000 RSI: ffffffffb627967d RDI: 0000000000000001
[  702.247801] RBP: ffffaf6187d27f30 R08: 0000000000000000 R09: 0000000000000000
[  702.248786] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000000ca
[  702.249782] R13: ffffaf6187d27f58 R14: 0000000000000000 R15: 0000000000000000
[  702.250785]  ? preempt_count_sub+0x5/0xa0
[  702.251540]  ? syscall_enter_from_user_mode+0x96/0xc0
[  702.252368]  ? preempt_count_sub+0x5/0xa0
[  702.253104]  ? syscall_enter_from_user_mode+0x96/0xc0
[  702.253918]  do_syscall_64+0x16/0x90
[  702.254613]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  702.255422] RIP: 0033:0x46b793

It's caused by bench test attaching kprobe_multi link to preempt_count_sub
function, which is not executed in rcu safe context so the kprobe handler
on top of it will trigger the rcu warning.

Filtering out preempt_count_ functions from the bench test.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 22be0a9..5561b93 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -379,6 +379,8 @@ static int get_syms(char ***symsp, size_t *cntp, bool kernel)
 		if (!strncmp(name, "__ftrace_invalid_address__",
 			     sizeof("__ftrace_invalid_address__") - 1))
 			continue;
+		if (!strncmp(name, "preempt_count_", strlen("preempt_count_")))
+			continue;
 
 		err = hashmap__add(map, name, 0);
 		if (err == -EEXIST)
-- 
1.8.3.1

