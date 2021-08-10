Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39B893E5901
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 13:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237533AbhHJLXo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Aug 2021 07:23:44 -0400
Received: from www62.your-server.de ([213.133.104.62]:55044 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhHJLXl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Aug 2021 07:23:41 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mDPql-0002eb-0E; Tue, 10 Aug 2021 13:23:15 +0200
Received: from [85.5.47.65] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1mDPqk-000Q1A-Qp; Tue, 10 Aug 2021 13:23:14 +0200
Subject: Re: [PATCH v2 bpf-next 5/5] Record all failed tests and output after
 the summary line.
To:     Yucong Sun <fallentree@fb.com>, bpf@vger.kernel.org
Cc:     andrii@kernel.org, sunyucong@gmail.com
References: <20210810001625.1140255-1-fallentree@fb.com>
 <20210810001625.1140255-6-fallentree@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <1c6e9434-4bd4-ebf1-9ea9-f4439c8974be@iogearbox.net>
Date:   Tue, 10 Aug 2021 13:23:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20210810001625.1140255-6-fallentree@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.2/26259/Tue Aug 10 10:19:56 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/10/21 2:16 AM, Yucong Sun wrote:
> This patch records all failed tests and subtests during the run, output
> them after the summary line, making it easier to identify failed tests
> in the long output.
> 
> Signed-off-by: Yucong Sun <fallentree@fb.com>

nit: please prefix all $subjects with e.g. 'bpf, selftests:'. for example, here should
be 'bpf, selftests: Record all failed tests and output after the summary line' so it's
more clear in the git log which subsystem is meant.

> ---
>   tools/testing/selftests/bpf/test_progs.c | 25 +++++++++++++++++++++++-
>   tools/testing/selftests/bpf/test_progs.h |  2 ++
>   2 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index 5cc808992b00..51a70031f07e 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -244,6 +244,11 @@ void test__end_subtest()
>   	       test->test_num, test->subtest_num, test->subtest_name,
>   	       sub_error_cnt ? "FAIL" : (test->skip_cnt ? "SKIP" : "OK"));
>   
> +	if (sub_error_cnt) {
> +		fprintf(env.summary_errors, "#%d/%d %s: FAIL\n",
> +			test->test_num, test->subtest_num, test->subtest_name);
> +	}
> +
>   	if (sub_error_cnt)
>   		env.fail_cnt++;
>   	else if (test->skip_cnt == 0)
> @@ -816,6 +821,10 @@ int main(int argc, char **argv)
>   		.sa_flags = SA_RESETHAND,
>   	};
>   	int err, i;
> +	/* record errors to print after summary line */
> +	char *summary_errors_buf;
> +	size_t summary_errors_cnt;
> +
>   

nit: double newline

>   	sigaction(SIGSEGV, &sigact, NULL);
>   
> @@ -823,6 +832,9 @@ int main(int argc, char **argv)
>   	if (err)
>   		return err;
>   
> +	env.summary_errors = open_memstream(
> +		&summary_errors_buf, &summary_errors_cnt);

Test for env.summary_errors being NULL missing.

> +
>   	err = cd_flavor_subdir(argv[0]);
>   	if (err)
>   		return err;
> @@ -891,6 +903,11 @@ int main(int argc, char **argv)
>   			test->test_num, test->test_name,
>   			test->error_cnt ? "FAIL" : "OK");
>   
> +		if(test->error_cnt) {
> +			fprintf(env.summary_errors, "#%d %s: FAIL\n",
> +				test->test_num, test->test_name);
> +		}
> +
>   		reset_affinity();
>   		restore_netns();
>   		if (test->need_cgroup_cleanup)
> @@ -908,9 +925,14 @@ int main(int argc, char **argv)
>   	if (env.list_test_names)
>   		goto out;
>   
> -	fprintf(stdout, "Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
> +	fprintf(stdout, "\nSummary: %d/%d PASSED, %d SKIPPED, %d FAILED\n\n",
>   		env.succ_cnt, env.sub_succ_cnt, env.skip_cnt, env.fail_cnt);
>   
> +	fclose(env.summary_errors);
> +	if(env.fail_cnt) {
> +		fprintf(stdout, "%s", summary_errors_buf);
> +	}
> +
>   out:
>   	free_str_set(&env.test_selector.blacklist);
>   	free_str_set(&env.test_selector.whitelist);
> @@ -919,6 +941,7 @@ int main(int argc, char **argv)
>   	free_str_set(&env.subtest_selector.whitelist);
>   	free(env.subtest_selector.num_set);
>   	close(env.saved_netns_fd);
> +	free(summary_errors_buf);
>   
>   	if (env.succ_cnt + env.fail_cnt + env.skip_cnt == 0)
>   		return EXIT_NO_TEST;
> diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
> index c8c2bf878f67..63f4e534c6e5 100644
> --- a/tools/testing/selftests/bpf/test_progs.h
> +++ b/tools/testing/selftests/bpf/test_progs.h
> @@ -82,6 +82,8 @@ struct test_env {
>   	int skip_cnt; /* skipped tests */
>   
>   	int saved_netns_fd;
> +
> +	FILE* summary_errors;

nit: FILE *summary_errors;

>   };
>   
>   extern struct test_env env;
> 

