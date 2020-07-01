Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58276211436
	for <lists+bpf@lfdr.de>; Wed,  1 Jul 2020 22:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgGAUTN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jul 2020 16:19:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24668 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726049AbgGAUTN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jul 2020 16:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593634751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S0+P4sJQq5vuOrYwhu/OOkrWh+QekHSmE46vbOURhFA=;
        b=hEHc4bdMW96Ptr7jlx/tMcXxjqmlPyLRTUybW8DRv2LQA23weEQgMAcLoQpjw/o8w6+2XY
        OGQANoUKlIqm318XZsz83/Q3D8ybnAA/6sFaOTxzg+Gtb7S2rGf+3noxx8BoT/iKFjM0L6
        L/CGVqf5BLa7eo/aWI/IDFc496ElGSo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-RXl2FuDqOJGYK4Mf7AoQZA-1; Wed, 01 Jul 2020 16:19:09 -0400
X-MC-Unique: RXl2FuDqOJGYK4Mf7AoQZA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A17E800C60;
        Wed,  1 Jul 2020 20:19:08 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4299D5C220;
        Wed,  1 Jul 2020 20:19:05 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id 3B7DC300003EB;
        Wed,  1 Jul 2020 22:19:04 +0200 (CEST)
Subject: [PATCH bpf-next V2 2/3] selftests/bpf: test_progs option for listing
 test names
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     bpf@vger.kernel.org, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Hangbin Liu <haliu@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        vkabatov@redhat.com, jbenc@redhat.com
Date:   Wed, 01 Jul 2020 22:19:04 +0200
Message-ID: <159363474417.929474.570677654666099808.stgit@firesoul>
In-Reply-To: <159363468114.929474.3089726346933732131.stgit@firesoul>
References: <159363468114.929474.3089726346933732131.stgit@firesoul>
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

This features can also be used for looking up a test number and returning
a testname. If the selection was empty then a shell EXIT_FAILURE is
returned.  This is useful for scripting. e.g. like this:

 n=1;
 while [ $(./test_progs --list -n $n) ] ; do \
   ./test_progs -n $n ; n=$(( n+1 )); \
 done

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 tools/testing/selftests/bpf/test_progs.c |   18 ++++++++++++++++++
 tools/testing/selftests/bpf/test_progs.h |    1 +
 2 files changed, 19 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 433f4dbf09ca..3345cd977c10 100644
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
 	  "Get number of selected top-level tests " },
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
 			continue;
 		}
 
+		if (env.list_test_names) {
+			fprintf(env.stdout, "%s\n", test->test_name);
+			env.succ_cnt++;
+			continue;
+		}
+
 		test->run_test();
 		/* ensure last sub-test is finalized properly */
 		if (test->subtest_name)
@@ -694,6 +706,12 @@ int main(int argc, char **argv)
 		goto out;
 	}
 
+	if (env.list_test_names) {
+		if (env.succ_cnt == 0)
+			env.fail_cnt = 1;
+		goto out;
+	}
+
 	fprintf(stdout, "Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
 		env.succ_cnt, env.sub_succ_cnt, env.skip_cnt, env.fail_cnt);
 
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


