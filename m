Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E4460D7C3
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 01:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbiJYXPx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 19:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiJYXPx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 19:15:53 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F7B437FA
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 16:15:50 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 4546B240028
        for <bpf@vger.kernel.org>; Wed, 26 Oct 2022 01:15:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1666739749; bh=Sg/epzfd+AblsaaJvJUtjO097YRLxPgeswe42DGS2wE=;
        h=From:To:Cc:Subject:Date:From;
        b=l0r/nEb0MHXNM12an74QhrehXrAeifa81arbZnrrcZO0G9qvHEgxVQVp5YV9erGpJ
         BW0yJKGMBHgTsDTahr/ZeFz2RMRBey8g0UJX3b22gkIhbeUZIATlAxaCOqn/Ormzdy
         tvF2Q9LhfqBIokNl2y7piPamo29CDu5WTXeptbrPgvxI0+BK6HaUJUMs+Ov238wSJl
         Q0R4fMo7w0h2X5WUF1Hp28UWDOKqGhTlsm862AAh6OxH22o0jQPiwCa47Kr1DIMYvo
         ZlakRFTvtpRFSYG7pmlLJGmDPDd2uCOBbARXQaHe4Nrqp5rkA3mMlhFqCvKekTzDCy
         Q1foBxkUF1BYA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4MxnqS2JFbz6tmK;
        Wed, 26 Oct 2022 01:15:48 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, kernel-team@fb.com
Cc:     deso@posteo.net
Subject: [PATCH bpf-next] selftests/bpf: Panic on hard/soft lockup
Date:   Tue, 25 Oct 2022 23:15:46 +0000
Message-Id: <20221025231546.811766-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When running tests, we should probably accept any help we can get when
it comes to detecting issues early or making them more debuggable. We
have seen a few cases where a test_progs_noalu32 run, for example,
encountered a soft lockup and stopped making progress. It was only
interrupted once we hit the overall test timeout [0]. We can not and do
not want to necessarily rely on test timeouts, because those rely on
infrastructure provided by the environment we run in (and which is not
present in tools/testing/selftests/bpf/vmtest.sh, for example).
To that end, let's enable panics on soft as well as hard lockups to fail
fast should we encounter one. That's happening in the configuration
indented to be used for selftests (including when using vmtest.sh or
when running in BPF CI).

[0] https://github.com/kernel-patches/bpf/runs/7844499997

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 tools/testing/selftests/bpf/config        | 2 ++
 tools/testing/selftests/bpf/config.x86_64 | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 921356..7a99a6 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -1,4 +1,6 @@
 CONFIG_BLK_DEV_LOOP=y
+CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
+CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
 CONFIG_BPF=y
 CONFIG_BPF_EVENTS=y
 CONFIG_BPF_JIT=y
diff --git a/tools/testing/selftests/bpf/config.x86_64 b/tools/testing/selftests/bpf/config.x86_64
index 21ce5e..dd97d6 100644
--- a/tools/testing/selftests/bpf/config.x86_64
+++ b/tools/testing/selftests/bpf/config.x86_64
@@ -18,7 +18,6 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=16384
 CONFIG_BLK_DEV_THROTTLING=y
 CONFIG_BONDING=y
-CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
 CONFIG_BOOTTIME_TRACING=y
 CONFIG_BPF_JIT_ALWAYS_ON=y
 CONFIG_BPF_KPROBE_OVERRIDE=y
-- 
2.30.2

