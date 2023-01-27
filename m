Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA5E67F0B5
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 22:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjA0V5J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 16:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjA0V5J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 16:57:09 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1AC81B0E
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 13:57:07 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-506466c484fso69152287b3.13
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 13:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fXDXEC0P0HmXmHBkg+xZhNAbb+sCHe1Z2rNKChcsi/c=;
        b=F3hfQdjIYuBcD0uSuObpbKFWRVt5+qtKRrMxk9PEHxVERlE2SE49Gx0RjhIbZRQ2uU
         qLptkwdR9mVPGVrFQT8xRtZpBs5MeybYM1XaSxCHxAl+r6vwYkq6TLr0FVh7yovi2yIk
         ghikIJgEsjChwl7NWRRR98csJ5r1wojpiubN9Ish+2l2NryFcit78ScIhVPgqIhO0aH/
         rq6K6oYWAGi/b6hZ0l1wv4tPL5zlqckFwMnaEqvK5xCzz2BJFpGOziVwmFpwaAZFvSky
         KZd/Eg6fbCTNo3FPDBuSFGD3t1xQ7OK9COWtkcu2iREQOIUCJKg/hh8RtGCXehi824Za
         mBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fXDXEC0P0HmXmHBkg+xZhNAbb+sCHe1Z2rNKChcsi/c=;
        b=M9jhzpGvHfmH6/0L6Xt5cPjXnc5PZ6TG4uSgGbIRDKqjZaXSEK5+IS8xUgnV2bIkAi
         ny4Z62kZxaHV0RPjUt6q0cKtjKn+COCyy29qY/efF61XAe3d8cpjldhnnTW6z6s/9mmD
         GfGrQyrMu8yTBXeRWQEN+/VPvbPx6nOu9GzOyYHaZRp3CGykXq79u9sUC33feEHBkB1r
         EUAGYNOPHuACgv28WtWCD4zXANoXD4mM3xZ9i7Q8ULozjBghuQUzXXALtRRuQqRT7gol
         aJlLZQyUSafKb2b+NNRqJ7fyY4LdyFs8qtBBe/J1hRlHR4ENauUHixmx60oOnPMvfMT3
         HJ3A==
X-Gm-Message-State: AO0yUKXvxtr/4j7X5sDfUet2jFA9/1SgWdK6UGJsZNqvXfxh0SE1vqf/
        e8Y7aKLzlMq9xrHFSrne0TqJJxyO3pQQYNWyjIt+niBFkVHBgz+HMf0IY8fJgd+8w1SKF5BJlPT
        LP4SXZ1ShGg4kfbm9ZoWobIT4JD5K/JMu8qqmt/MfK6ZEM9ouaQ==
X-Google-Smtp-Source: AK7set/1Z1NnhvlMKk8cwFHZcB+zvvPPula9FGeZngM7loxMskpb+zj+nrINEra8RQKABCQR+QrwKUc=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:d353:0:b0:507:fb46:dda2 with SMTP id
 d19-20020a81d353000000b00507fb46dda2mr1209613ywl.39.1674856626670; Fri, 27
 Jan 2023 13:57:06 -0800 (PST)
Date:   Fri, 27 Jan 2023 13:57:05 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230127215705.1254316-1-sdf@google.com>
Subject: [PATCH bpf-next] selftest/bpf: Make crashes more debuggable in test_progs
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Reset stdio before printing verbose log of the SIGSEGV'ed test.
Otherwise, it's hard to understand what's going on in the cases like [0].

With the following patch applied:

	--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
	+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
	@@ -392,6 +392,11 @@ void test_xdp_metadata(void)
	 		       "generate freplace packet"))
	 		goto out;

	+
	+	ASSERT_EQ(1, 2, "oops");
	+	int *x = 0;
	+	*x = 1; /* die */
	+
	 	while (!retries--) {
	 		if (bpf_obj2->bss->called)
	 			break;

Before:

 #281     xdp_metadata:FAIL
Caught signal #11!
Stack trace:
./test_progs(crash_handler+0x1f)[0x55c919d98bcf]
/lib/x86_64-linux-gnu/libc.so.6(+0x3bf90)[0x7f36aea5df90]
./test_progs(test_xdp_metadata+0x1db0)[0x55c919d8c6d0]
./test_progs(+0x23b438)[0x55c919d9a438]
./test_progs(main+0x534)[0x55c919d99454]
/lib/x86_64-linux-gnu/libc.so.6(+0x2718a)[0x7f36aea4918a]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0x85)[0x7f36aea49245]
./test_progs(_start+0x21)[0x55c919b82ef1]

After:

test_xdp_metadata:PASS:ip netns add xdp_metadata 0 nsec
open_netns:PASS:malloc token 0 nsec
open_netns:PASS:open /proc/self/ns/net 0 nsec
open_netns:PASS:open netns fd 0 nsec
open_netns:PASS:setns 0 nsec
..
test_xdp_metadata:FAIL:oops unexpected oops: actual 1 != expected 2
 #281     xdp_metadata:FAIL
Caught signal #11!
Stack trace:
./test_progs(crash_handler+0x1f)[0x562714a76bcf]
/lib/x86_64-linux-gnu/libc.so.6(+0x3bf90)[0x7fa663f9cf90]
./test_progs(test_xdp_metadata+0x1db0)[0x562714a6a6d0]
./test_progs(+0x23b438)[0x562714a78438]
./test_progs(main+0x534)[0x562714a77454]
/lib/x86_64-linux-gnu/libc.so.6(+0x2718a)[0x7fa663f8818a]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0x85)[0x7fa663f88245]
./test_progs(_start+0x21)[0x562714860ef1]

0: https://github.com/kernel-patches/bpf/actions/runs/4019879316/jobs/6907358876

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/test_progs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 4716e38e153a..c5f852163246 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -975,12 +975,12 @@ void crash_handler(int signum)
 
 	sz = backtrace(bt, ARRAY_SIZE(bt));
 
+	if (env.stdout)
+		stdio_restore();
 	if (env.test) {
 		env.test_state->error_cnt++;
 		dump_test_log(env.test, env.test_state, true, false);
 	}
-	if (env.stdout)
-		stdio_restore();
 	if (env.worker_id != -1)
 		fprintf(stderr, "[%d]: ", env.worker_id);
 	fprintf(stderr, "Caught signal #%d!\nStack trace:\n", signum);
-- 
2.39.1.456.gfc5497dd1b-goog

