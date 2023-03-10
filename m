Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95016B3665
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 07:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjCJGK5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 01:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCJGK4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 01:10:56 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6631033BA;
        Thu,  9 Mar 2023 22:10:55 -0800 (PST)
Received: by mail-qt1-f180.google.com with SMTP id c18so4714414qte.5;
        Thu, 09 Mar 2023 22:10:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678428654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TKs6blxuG9zlni0sl4k3Jn1Rpj+hd6hKaAuGgne6E3I=;
        b=Arfhtvk5OCmG97S8NBEhVc7lOecrFGxT2QnPwa+Odby5bmHE1VKgNNYT38wIyAs0HF
         hn7DkUkIm1CSXod+zHdCx/MGtMgZ0N6RsHuqA8wgtmOoeNHeLA4Faicks7JDzD4hcZ8N
         oV5XvwkvSrzPMvCmXm4r1IKXO5J4SH/UEXR05PxiS3NRHsHqDeLIOZWr77FnGriWHP/4
         LJgPAxOJZytBxQhfQKjIhcrQem2CGb7Ij8jEHB6PP5hVKbhuju6PRYrxxeVtH8MO5rsi
         tawmLrnBO8J9QRJZnPpcPzUwds9UltA55ekt7gCbmWOWoHtM2cR3Blffv/tpeTAHvSVn
         x6Zg==
X-Gm-Message-State: AO0yUKV80lwfdsjm2Twykl/ufAS+AIJy/6Y0ytITvPVnhdRTDBJymj6A
        JtLa44BsQWYBWHY68hixdVXr63GyNdRK5X4p
X-Google-Smtp-Source: AK7set+PLqLYG1FqnTAj54fy3PVP4/yGZ31mRw2Zwqf+kEJAesi8g41Dlmj9P7AzO9JmmjsSljEItA==
X-Received: by 2002:a05:622a:181d:b0:3b8:689f:d8ef with SMTP id t29-20020a05622a181d00b003b8689fd8efmr39564041qtc.18.1678428654450;
        Thu, 09 Mar 2023 22:10:54 -0800 (PST)
Received: from localhost ([2620:10d:c091:400::5:388b])
        by smtp.gmail.com with ESMTPSA id m12-20020ac866cc000000b003bfc335f124sm801321qtp.79.2023.03.09.22.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 22:10:53 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next] bpf/selftests: Fix send_signal tracepoint tests
Date:   Fri, 10 Mar 2023 00:10:48 -0600
Message-Id: <20230310061048.1418400-1-void@manifault.com>
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
 tools/testing/selftests/bpf/prog_tests/send_signal.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
index d63a20fbed33..61cc83fca53c 100644
--- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
+++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
@@ -64,8 +64,11 @@ static void test_send_signal_common(struct perf_event_attr *attr,
 		ASSERT_EQ(read(pipe_p2c[0], buf, 1), 1, "pipe_read");
 
 		/* wait a little for signal handler */
-		for (int i = 0; i < 1000000000 && !sigusr1_received; i++)
+		for (int i = 0; i < 1000000000 && !sigusr1_received; i++) {
 			j /= i + j + 1;
+			if (!attr)
+				ASSERT_EQ(usleep(1), 0, "nanosleep_tp");
+		}
 
 		buf[0] = sigusr1_received ? '2' : '0';
 		ASSERT_EQ(sigusr1_received, 1, "sigusr1_received");
-- 
2.39.0

