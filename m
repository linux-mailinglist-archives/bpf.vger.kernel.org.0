Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A2B5832D4
	for <lists+bpf@lfdr.de>; Wed, 27 Jul 2022 21:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiG0TFI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Jul 2022 15:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234750AbiG0TEs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Jul 2022 15:04:48 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109275FAED
        for <bpf@vger.kernel.org>; Wed, 27 Jul 2022 11:30:01 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id D5CA8240027
        for <bpf@vger.kernel.org>; Wed, 27 Jul 2022 20:29:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1658946598; bh=hjDlImDPRMhL9xOmdmS7P2xXMdHwLoAlDrqCoceSOvY=;
        h=From:To:Subject:Date:From;
        b=CQDTVo6+sKmWyAmDc7FNo+eIK5NDnZ0rUgK1Eu8K8zdmYi326RSdk4igkTdFcco3b
         gkcz4+0B6bFNHdz9UAyViEFNjpupVjCCPQniZTJHmmAelMkhEca55q2X9LEqkZ0vD5
         Z6Nqq3cNVOzGzaKZmSb88dgRv5EZPfK0YTZCyyTC91h+QaUI8Tns4qbOGk1iniINkD
         swS4nmSSd+0ZbOeTdynnkViYacxlBdQO+Y5EEAOIHVAMZCbyzUnsrOM//NcT+v0w1X
         Qc+nBU0MixrNSJJmnbQCuCN4u6gMy1lWxCspPRX/SGpfgzSiBfdZRm0aHq5Q0sBcAa
         HhJmApQursu7w==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LtMlB0Qdbz9rxG;
        Wed, 27 Jul 2022 20:29:58 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Subject: [PATCH bpf-next] selftests/bpf: Bump internal send_signal/send_signal_tracepoint timeout
Date:   Wed, 27 Jul 2022 18:29:55 +0000
Message-Id: <20220727182955.4044988-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The send_signal/send_signal_tracepoint is pretty flaky, with at least
one failure in every ten runs on a few attempts I've tried it:
  > test_send_signal_common:PASS:pipe_c2p 0 nsec
  > test_send_signal_common:PASS:pipe_p2c 0 nsec
  > test_send_signal_common:PASS:fork 0 nsec
  > test_send_signal_common:PASS:skel_open_and_load 0 nsec
  > test_send_signal_common:PASS:skel_attach 0 nsec
  > test_send_signal_common:PASS:pipe_read 0 nsec
  > test_send_signal_common:PASS:pipe_write 0 nsec
  > test_send_signal_common:PASS:reading pipe 0 nsec
  > test_send_signal_common:PASS:reading pipe error: size 0 0 nsec
  > test_send_signal_common:FAIL:incorrect result unexpected incorrect result: actual 48 != expected 50
  > test_send_signal_common:PASS:pipe_write 0 nsec
  > #139/1   send_signal/send_signal_tracepoint:FAIL

The reason does not appear to be a correctness issue in the strict
sense. Rather, we merely do not receive the signal we are waiting for
within the provided timeout.
Let's bump the timeout by a factor of ten. With that change I have not
been able to reproduce the failure in 150+ iterations. I am also sneaking
in a small simplification to the test_progs test selection logic.

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 tools/testing/selftests/bpf/prog_tests/send_signal.c | 2 +-
 tools/testing/selftests/bpf/test_progs.c             | 7 ++-----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
index d71226e..d63a20 100644
--- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
+++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
@@ -64,7 +64,7 @@ static void test_send_signal_common(struct perf_event_attr *attr,
 		ASSERT_EQ(read(pipe_p2c[0], buf, 1), 1, "pipe_read");
 
 		/* wait a little for signal handler */
-		for (int i = 0; i < 100000000 && !sigusr1_received; i++)
+		for (int i = 0; i < 1000000000 && !sigusr1_received; i++)
 			j /= i + j + 1;
 
 		buf[0] = sigusr1_received ? '2' : '0';
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index c639f2e..3561c9 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -1604,11 +1604,8 @@ int main(int argc, char **argv)
 		struct prog_test_def *test = &prog_test_defs[i];
 
 		test->test_num = i + 1;
-		if (should_run(&env.test_selector,
-				test->test_num, test->test_name))
-			test->should_run = true;
-		else
-			test->should_run = false;
+		test->should_run = should_run(&env.test_selector,
+					      test->test_num, test->test_name);
 
 		if ((test->run_test == NULL && test->run_serial_test == NULL) ||
 		    (test->run_test != NULL && test->run_serial_test != NULL)) {
-- 
2.30.2

