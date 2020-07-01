Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71CCD211546
	for <lists+bpf@lfdr.de>; Wed,  1 Jul 2020 23:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgGAVoX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jul 2020 17:44:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47154 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726114AbgGAVoW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jul 2020 17:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593639861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MI1X8O5Nn4HrghDc2zWck7Y6CcY9BbV8Pd1fuG4ysz4=;
        b=EQxK9ozJiBNuyOZSYIWDq+es8JLxW/OSEG5hH93obi/pCcvHZ6V8WrCRcKectCkpjE58AW
        iNWtdZvZJVN5JwSBhG7tqLmPJAeHm8n6XjLFKrWjCWnTi4+h4ejvjaQLuR8gbq6lsH3T8s
        QsFkJ4YekwQMnpfiCmff6NKODKK/G4k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-Fbj0wBiHMWGwmVe899ihSA-1; Wed, 01 Jul 2020 17:44:17 -0400
X-MC-Unique: Fbj0wBiHMWGwmVe899ihSA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 862C6805722;
        Wed,  1 Jul 2020 21:44:16 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 835F810016DA;
        Wed,  1 Jul 2020 21:44:13 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id 7B8C7300003EB;
        Wed,  1 Jul 2020 23:44:12 +0200 (CEST)
Subject: [PATCH bpf-next V3 2/3] selftests/bpf: test_progs option for getting
 number of tests
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     bpf@vger.kernel.org, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Hangbin Liu <haliu@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        vkabatov@redhat.com, jbenc@redhat.com
Date:   Wed, 01 Jul 2020 23:44:12 +0200
Message-ID: <159363985244.930467.12617117873058936829.stgit@firesoul>
In-Reply-To: <159363976938.930467.11835380146293463365.stgit@firesoul>
References: <159363976938.930467.11835380146293463365.stgit@firesoul>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It can be practial to get the number of tests that test_progs contain.
This could for example be used to create a shell for-loop construct that
runs the individual tests.

Like:
 for N in $(seq 1 $(./test_progs -c)); do
   ./test_progs -n $N 2>&1 > result_test_${N}.log &
 done ; wait

V2: Add the ability to return the count for the selected tests. This is
useful for getting a count e.g. after excluding some tests with option -b.
The current beakers test script like to report the max test count upfront.

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 tools/testing/selftests/bpf/test_progs.c |   18 ++++++++++++++++++
 tools/testing/selftests/bpf/test_progs.h |    1 +
 2 files changed, 19 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index da70a4f72f54..a5dba14b2025 100644
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
+	  "Get number of selected top-level tests " },
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
@@ -654,6 +660,11 @@ int main(int argc, char **argv)
 				test->test_num, test->test_name))
 			continue;
 
+		if (env.get_test_cnt) {
+			env.succ_cnt++;
+			continue;
+		}
+
 		test->run_test();
 		/* ensure last sub-test is finalized properly */
 		if (test->subtest_name)
@@ -677,9 +688,16 @@ int main(int argc, char **argv)
 			cleanup_cgroup_environment();
 	}
 	stdio_restore();
+
+	if (env.get_test_cnt) {
+		printf("%d\n", env.succ_cnt);
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
index f4503c926aca..0030584619c3 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -66,6 +66,7 @@ struct test_env {
 	enum verbosity verbosity;
 
 	bool jit_enabled;
+	bool get_test_cnt;
 
 	struct prog_test_def *test;
 	FILE *stdout;


