Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E0C20F88A
	for <lists+bpf@lfdr.de>; Tue, 30 Jun 2020 17:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389599AbgF3Pkh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 11:40:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47894 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389589AbgF3Pkg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Jun 2020 11:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593531634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ryYSYybgSal295SlzAxWuJoThtOxN275m4Q3P359Ul0=;
        b=fvcxdYCzPIB2QuUpzelR0MAEjaKAOGE91hf8Jy1vmO/UBMyMPoHDEUhTXIgcMJXB5Dja0O
        NiGLzAJr1NOxFkaZmkPXmmyAoZWj0IOl6UWmUhrvuO8263RZ9b8IGQ8d8nB8KMpQ2LuTXy
        dXJqcTpogCBKb9mg04XJ2heI92JXq6E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-SB1Hc8TCPf274u25nqXtrQ-1; Tue, 30 Jun 2020 11:40:33 -0400
X-MC-Unique: SB1Hc8TCPf274u25nqXtrQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FC9213F6;
        Tue, 30 Jun 2020 15:40:32 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E45BA5C1B0;
        Tue, 30 Jun 2020 15:40:28 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id AC7B6300003EB;
        Tue, 30 Jun 2020 17:40:27 +0200 (CEST)
Subject: [PATCH bpf-next] selftests/bpf: test_progs option for listing test
 names
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     bpf@vger.kernel.org, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Hangbin Liu <haliu@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 30 Jun 2020 17:40:27 +0200
Message-ID: <159353162763.912056.3435319848074491018.stgit@firesoul>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The program test_progs have some very useful ability to specify a list of
test name substrings for selecting which tests to run.

This patch add the ability to list the selected test names without running
them. This is practical for seeing which tests gets selected with given
select arguments (which can also contain a exclude list via --name-blacklist).

This output can also be used by shell-scripts in a for-loop:

 for N in $(./test_progs --list -t xdp); do \
   ./test_progs -t $N 2>&1 > result_test_${N}.log & \
 done ; wait

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 tools/testing/selftests/bpf/test_progs.c |   20 ++++++++++++++++++++
 tools/testing/selftests/bpf/test_progs.h |    1 +
 2 files changed, 21 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 1aa5360c427f..36abc3d4a8e2 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -367,6 +367,7 @@ enum ARG_KEYS {
 	ARG_VERIFIER_STATS = 's',
 	ARG_VERBOSE = 'v',
 	ARG_GET_TEST_CNT = 'c',
+	ARG_LIST_TEST_NAMES = 'l',
 };
 
 static const struct argp_option opts[] = {
@@ -382,6 +383,8 @@ static const struct argp_option opts[] = {
 	  "Verbose output (use -vv or -vvv for progressively verbose output)" },
 	{ "count", ARG_GET_TEST_CNT, NULL, 0,
 	  "Get number of top-level tests " },
+	{ "list", ARG_LIST_TEST_NAMES, NULL, 0,
+	  "List test names that would run (without running them) " },
 	{},
 };
 
@@ -517,6 +520,9 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 	case ARG_GET_TEST_CNT:
 		env->get_test_cnt = true;
 		break;
+	case ARG_LIST_TEST_NAMES:
+		env->list_test_names = true;
+		break;
 	case ARGP_KEY_ARG:
 		argp_usage(state);
 		break;
@@ -665,6 +671,12 @@ int main(int argc, char **argv)
 				test->test_num, test->test_name))
 			continue;
 
+		if (env.list_test_names) {
+			fprintf(env.stdout, "%s\n", test->test_name);
+			env.succ_cnt++;
+			continue;
+		}
+
 		test->run_test();
 		/* ensure last sub-test is finalized properly */
 		if (test->subtest_name)
@@ -688,9 +700,17 @@ int main(int argc, char **argv)
 			cleanup_cgroup_environment();
 	}
 	stdio_restore();
+
+	if (env.list_test_names) {
+		if (env.succ_cnt == 0)
+			env.fail_cnt = 1;
+		goto out;
+	}
+
 	fprintf(stdout, "Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
 		env.succ_cnt, env.sub_succ_cnt, env.skip_cnt, env.fail_cnt);
 
+out:
 	free_str_set(&env.test_selector.blacklist);
 	free_str_set(&env.test_selector.whitelist);
 	free(env.test_selector.num_set);
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 0030584619c3..ec31f382e7fd 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -67,6 +67,7 @@ struct test_env {
 
 	bool jit_enabled;
 	bool get_test_cnt;
+	bool list_test_names;
 
 	struct prog_test_def *test;
 	FILE *stdout;


