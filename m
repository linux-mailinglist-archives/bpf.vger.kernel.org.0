Return-Path: <bpf+bounces-11726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D7F7BE3F7
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 17:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C520A281939
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 15:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FF6358A9;
	Mon,  9 Oct 2023 15:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZnayWCvn"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B32358A2
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 15:09:55 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5541BB4;
	Mon,  9 Oct 2023 08:09:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B3D6221883;
	Mon,  9 Oct 2023 15:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1696864192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ISQ9n4D5T3P8ooumknvc+YiFO0JDSQRXu8nxDrWSZQQ=;
	b=ZnayWCvnMF9L+nOSQ/u0lRORq0pD9+ifKV4GqLv9wH7Z5tc1ily0R1cd6V7h0m0JWlkPKP
	MglvcvQ4TdGnmeKxfB3ROOGJbNlYwmKuqqyUxzGOWPmlSHlhdVEv3VfQYmdL6Py2OiS9kk
	ehffi4TuE0QPZBYHC9UV/EOCEo4SFr0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3B4BE13905;
	Mon,  9 Oct 2023 15:09:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id t/q1AMAXJGW6JgAAMHmgww
	(envelope-from <mpdesouza@suse.com>); Mon, 09 Oct 2023 15:09:52 +0000
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: shuah@kernel.org,
	corbet@lwn.net,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH] Documentation: kselftests: Remove references to bpf tests
Date: Mon,  9 Oct 2023 12:09:29 -0300
Message-ID: <20231009150929.25953-1-mpdesouza@suse.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently the bpf selftests are skipped by default, so is someone would
like to run the tests one would need to run:
  $ make TARGETS=bpf SKIP_TARGETS="" kselftest

To overwrite the SKIP_TARGETS that defines bpf by default. Also,
following the BPF instructions[1], to run the bpf selftests one would
need to enter in the tools/testing/selftests/bpf/ directory, and then
run make, which is not the standard way to run selftests per it's
documentation.

For the reasons above stop mentioning bpf in the kselftests as examples
of how to run a test suite.

[1]: Documentation/bpf/bpf_devel_QA.rst

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 Documentation/dev-tools/kselftest.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index deede972f254..ab376b316c36 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -112,7 +112,7 @@ You can specify multiple tests to skip::
 You can also specify a restricted list of tests to run together with a
 dedicated skiplist::
 
-  $  make TARGETS="bpf breakpoints size timers" SKIP_TARGETS=bpf kselftest
+  $  make TARGETS="breakpoints size timers" SKIP_TARGETS=size kselftest
 
 See the top-level tools/testing/selftests/Makefile for the list of all
 possible targets.
@@ -165,7 +165,7 @@ To see the list of available tests, the `-l` option can be used::
 The `-c` option can be used to run all the tests from a test collection, or
 the `-t` option for specific single tests. Either can be used multiple times::
 
-   $ ./run_kselftest.sh -c bpf -c seccomp -t timers:posix_timers -t timer:nanosleep
+   $ ./run_kselftest.sh -c size -c seccomp -t timers:posix_timers -t timer:nanosleep
 
 For other features see the script usage output, seen with the `-h` option.
 
@@ -210,7 +210,7 @@ option is supported, such as::
 tests by using variables specified in `Running a subset of selftests`_
 section::
 
-    $ make -C tools/testing/selftests gen_tar TARGETS="bpf" FORMAT=.xz
+    $ make -C tools/testing/selftests gen_tar TARGETS="size" FORMAT=.xz
 
 .. _tar's auto-compress: https://www.gnu.org/software/tar/manual/html_node/gzip.html#auto_002dcompress
 
-- 
2.42.0


