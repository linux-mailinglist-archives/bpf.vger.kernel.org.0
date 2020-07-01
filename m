Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1C0211435
	for <lists+bpf@lfdr.de>; Wed,  1 Jul 2020 22:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbgGAUTH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jul 2020 16:19:07 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58613 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726049AbgGAUTH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 1 Jul 2020 16:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593634746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DTfzpOFp8L47GXahsu3e58SI+40AgZfhpmaKO1yjjr4=;
        b=e/LAkAlGEDKbcptwJzaFxZC6PCAd2MWNp8GM7HVariPBBXjXCM5rddUYiEpMtm0p62mN+j
        c0JmD5jLzjhc/CUi3Dtf4OEbS6M7S7CXbHRxggKDIrwgGgXlvkqtM6U61wn2VeeZxLFAat
        VqCyxFeEyhOVkYCtVx9tWJPx3C95Kmo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-uoeuyxaoNqaUXzVCbr-vxQ-1; Wed, 01 Jul 2020 16:19:04 -0400
X-MC-Unique: uoeuyxaoNqaUXzVCbr-vxQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5004019057A0;
        Wed,  1 Jul 2020 20:19:03 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 25FBE60BE1;
        Wed,  1 Jul 2020 20:19:00 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id 2877C300003EB;
        Wed,  1 Jul 2020 22:18:59 +0200 (CEST)
Subject: [PATCH bpf-next V2 1/3] selftests/bpf: test_progs option for getting
 number of tests
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     bpf@vger.kernel.org, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Hangbin Liu <haliu@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        vkabatov@redhat.com, jbenc@redhat.com
Date:   Wed, 01 Jul 2020 22:18:59 +0200
Message-ID: <159363473909.929474.149820248190687599.stgit@firesoul>
In-Reply-To: <159363468114.929474.3089726346933732131.stgit@firesoul>
References: <159363468114.929474.3089726346933732131.stgit@firesoul>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
index 54fa5fa688ce..433f4dbf09ca 100644
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


