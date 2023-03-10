Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A446B367C
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 07:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjCJGTQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 01:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjCJGTP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 01:19:15 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B641EDB43;
        Thu,  9 Mar 2023 22:19:13 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id y10so4741671qtj.2;
        Thu, 09 Mar 2023 22:19:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678429152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2QivXt8zfdhcwelJzzxGLwGDIAnA1Rdksg2B5MmKcE8=;
        b=HzUFmKeeVRUlh0eIwsbEiCN8KZJueviCvZ6ybc3ZS5WaFCZzmtiS1G4OlxqnfAm8dd
         hQiwdJtncfO7JfSH/sagkkG10zVm7cOGZcYgO7dnoi0vckpFPTksDRLxMn8BGIgr+u5Y
         bc3iC/8DFacEUVPpWeDJaEJNOVcpJMxhFg3lApsUxsZ70HuQ2wWRoWhDKAR8AwjxQvYi
         J5LV/ox3dh/34YKYLX9DxV0Hg7v2qMaK/+S/F7HhDslXxxfbyyf51CHPTFBsm/cJqtzV
         gg70ok8lKwIaN+QlHRJ51Oztn+jr8GQXM9uisnZFndrXOJX7mm7cmB8130shAt/r9Hj2
         544Q==
X-Gm-Message-State: AO0yUKX3PsecROJm7Cei+i6xJNm4g2CufjWv96e2sWxXgqmWL0Uyj1LB
        MgTibPzX9wohgcIKJdbs04M2ppz30zviho1i
X-Google-Smtp-Source: AK7set8FcP9hhRnt5cwezC0b+VHMeQX7NxS56QG/aiiftgPTrUY1Z36zFyzScuha/QKl/UKdoTdMsg==
X-Received: by 2002:ac8:5bc6:0:b0:3b8:3c4e:d334 with SMTP id b6-20020ac85bc6000000b003b83c4ed334mr35744161qtb.50.1678429152084;
        Thu, 09 Mar 2023 22:19:12 -0800 (PST)
Received: from localhost ([2620:10d:c091:400::5:388b])
        by smtp.gmail.com with ESMTPSA id z17-20020ac83e11000000b003bfd27755d7sm866723qtf.19.2023.03.09.22.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 22:19:11 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next v2] bpf/selftests: Fix send_signal tracepoint tests
Date:   Fri, 10 Mar 2023 00:19:09 -0600
Message-Id: <20230310061909.1420887-1-void@manifault.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The send_signal tracepoint tests are non-deterministically failing in
CI. The test works as follows:

1. Two pairs of file descriptors are created using the pipe() function.
   One pair is used to communicate between a parent process -> child
   process, and the other for the reverse direction.

2. A child is fork()'ed. The child process registers a signal handler,
   notifies its parent that the signal handler is registered, and then
   and waits for its parent to have enabled a BPF program that sends a
   signal.

3. The parent opens and loads a BPF skeleton with programs that send
   signals to the child process. The different programs are triggered by
   different perf events (either NMI or normal perf), or by regular
   tracepoints. The signal is delivered to the child whenever the child
   triggers the program.

4. The child's signal handler is invoked, which sets a flag saying that
   the signal handler was reached. The child then signals to the parent
   that it received the signal, and the test ends.

The perf testcases (send_signal_perf{_thread} and
send_signal_nmi{_thread}) work 100% of the time, but the tracepoint
testcases fail non-deterministically because the tracepoint is not
always being fired for the child.

There are two tracepoint programs registered in the test:
'tracepoint/sched/sched_switch', and
'tracepoint/syscalls/sys_enter_nanosleep'. The child never intentionally
blocks, nor sleeps, so neither tracepoint is guaranteed to be triggered.
To fix this, we can have the child trigger the nanosleep program with a
usleep().

Before this patch, the test would fail locally every 2-3 runs. Now, it
doesn't fail after more than 1000 runs.

Signed-off-by: David Vernet <void@manifault.com>
---
Changelog:

v1 -> v2:
- Remove ASSERT_EQ around usleep(). It could be interrupted by a signal
  and return EINTR (that's the whole point of the test), so let's just
  call it directly.
- Add a comment explaining why the usleep() is there.

 tools/testing/selftests/bpf/prog_tests/send_signal.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
index d63a20fbed33..b15b343ebb6b 100644
--- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
+++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
@@ -64,8 +64,12 @@ static void test_send_signal_common(struct perf_event_attr *attr,
 		ASSERT_EQ(read(pipe_p2c[0], buf, 1), 1, "pipe_read");
 
 		/* wait a little for signal handler */
-		for (int i = 0; i < 1000000000 && !sigusr1_received; i++)
+		for (int i = 0; i < 1000000000 && !sigusr1_received; i++) {
 			j /= i + j + 1;
+			if (!attr)
+				/* trigger the nanosleep tracepoint program. */
+				usleep(1);
+		}
 
 		buf[0] = sigusr1_received ? '2' : '0';
 		ASSERT_EQ(sigusr1_received, 1, "sigusr1_received");
-- 
2.39.0

