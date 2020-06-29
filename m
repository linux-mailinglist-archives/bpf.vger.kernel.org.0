Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A0920D3C2
	for <lists+bpf@lfdr.de>; Mon, 29 Jun 2020 21:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbgF2TBx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Jun 2020 15:01:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48206 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730361AbgF2TBr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Jun 2020 15:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593457306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=kFIJkw7uizlumVYgU4yOLgni5TnkFJaj4wh2hYKWb4c=;
        b=EnSRVb6MIyAHnOtWDrKUm4TEEQnKqZ5/8osJlqubuJkyBVSCXSrF8ppOBIcjEdQkrPrG3a
        X+RpFFWEMRAwXPtVc0nQ7mqlf4ORLEdLof7Xnyh0tX2a7p91FLmhJ6IPpgUUPnqRrynrQJ
        ukzByPhyHnwKUbbhXXErcfbBlffE1xU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-zYKQbKhyPBq9vP7PMP_2ww-1; Mon, 29 Jun 2020 12:01:23 -0400
X-MC-Unique: zYKQbKhyPBq9vP7PMP_2ww-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93CAFA0BDB;
        Mon, 29 Jun 2020 16:01:22 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6EDD119C4F;
        Mon, 29 Jun 2020 16:01:19 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id 2F5BB300003EB;
        Mon, 29 Jun 2020 18:01:18 +0200 (CEST)
Subject: [PATCH bpf-next] selftests/bpf: test_progs option for getting number
 of tests
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     bpf@vger.kernel.org, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Hangbin Liu <haliu@redhat.com>
Date:   Mon, 29 Jun 2020 18:01:18 +0200
Message-ID: <159344647797.836609.7781883615056725815.stgit@firesoul>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It can be practial to get the number of tests that test_progs
contain.  This could for example be used to create a shell
for-loop construct that runs the individual tests.

Like:
 for N in $(seq 1 $(./test_progs -c)); do
   ./test_progs -n $N 2>&1 > result_test_${N}.log &
 done ; wait

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 tools/testing/selftests/bpf/test_progs.c |   11 +++++++++++
 tools/testing/selftests/bpf/test_progs.h |    1 +
 2 files changed, 12 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 54fa5fa688ce..1aa5360c427f 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -366,6 +366,7 @@ enum ARG_KEYS {
 	ARG_TEST_NAME_BLACKLIST = 'b',
 	ARG_VERIFIER_STATS = 's',
 	ARG_VERBOSE = 'v',
+	ARG_GET_TEST_CNT = 'c',
 };
 
 static const struct argp_option opts[] = {
@@ -379,6 +380,8 @@ static const struct argp_option opts[] = {
 	  "Output verifier statistics", },
 	{ "verbose", ARG_VERBOSE, "LEVEL", OPTION_ARG_OPTIONAL,
 	  "Verbose output (use -vv or -vvv for progressively verbose output)" },
+	{ "count", ARG_GET_TEST_CNT, NULL, 0,
+	  "Get number of top-level tests " },
 	{},
 };
 
@@ -511,6 +514,9 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 			}
 		}
 		break;
+	case ARG_GET_TEST_CNT:
+		env->get_test_cnt = true;
+		break;
 	case ARGP_KEY_ARG:
 		argp_usage(state);
 		break;
@@ -643,6 +649,11 @@ int main(int argc, char **argv)
 		return -1;
 	}
 
+	if (env.get_test_cnt) {
+		printf("%d\n", prog_test_cnt);
+		return EXIT_SUCCESS;
+	}
+
 	stdio_hijack();
 	for (i = 0; i < prog_test_cnt; i++) {
 		struct prog_test_def *test = &prog_test_defs[i];
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index f4503c926aca..0030584619c3 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -66,6 +66,7 @@ struct test_env {
 	enum verbosity verbosity;
 
 	bool jit_enabled;
+	bool get_test_cnt;
 
 	struct prog_test_def *test;
 	FILE *stdout;


