Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8736BD605
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 17:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjCPQjr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Mar 2023 12:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbjCPQj2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Mar 2023 12:39:28 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61030E1FF3
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 09:38:45 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c18so2347380ple.11
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 09:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678984720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YRpbRE6//zHeUNsJ33Dc54msU4x4msttG517yhDSEDY=;
        b=fP5TUP6zREAH6bFIecGyCqmN/OCo9xvhvHgp+wQIMsk2lt04W5S5GuC3WRBTG6S+cL
         NdInO8QYp5PLiQFJQwlMfx0gp7b2qcWU+cnlPEqgnz/WZlqxypOR2H4P996uPOlKRgxp
         2qDa2DvURTeTG9r+7SpdVZcmyXrh7sOoV/jpucKGdkfxvmqRrQaAWjnJBgBxfqfrkzQZ
         MUzr64uOF7GBLLx1Dr1RoAfkLHZZ9UfZEuql4rDEOjGP6Eq+8ugN4YX0e4ukVlmL4o3c
         hOhgOhktTEMCzX3yUSCA5y4caEMhutINgxpD3f13FnWZrY01OARrR10Iv32gKm4c9i9k
         r6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678984720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRpbRE6//zHeUNsJ33Dc54msU4x4msttG517yhDSEDY=;
        b=k0q7m4inWKGqB3w3IM1f/PXDOlx1y9PB3CS2gQ92TlaIgwavQYZ2c0fk/E431hphyd
         3VnZ63o6DauWzw5kXcDy7l3+Zvgu+I9+/b02wM4kqp/przP1MaLfcxtfRoD6FY6vn6un
         iUAkmOmChxWOuu3OhAYiqctUvHW8XhrI/AUtbADF/38nDqJAqK/Tawvz7Bo9wOMp2YLC
         DrWv3+1z+HmKO7fF3js7BU8+byqLNGLnUOGv22Yp7P0LKJ7ykTnODFBg4eSlg3Zd3X6m
         uy27p6FywPTKjt51fNXzoDp3TiJT/a1r7Nm6cZwhK1/McRrro5DVEQaNTm8I5kIyvdlV
         vbCA==
X-Gm-Message-State: AO0yUKXjmMqVEA7x7BWri3K2gHkhgqDQ60hJcxF6tkLFNbumIYb/5afQ
        6bGStKZSq7A9Q03YrJrR1x4=
X-Google-Smtp-Source: AK7set830E2vb+Lqcf6UsDurOZIDgbueGv8/4uD1oq8u1CL4nYdpa4S2W8owVv1kj8o9IfAWphw3Hw==
X-Received: by 2002:a05:6a20:1443:b0:c7:249:cd8c with SMTP id a3-20020a056a20144300b000c70249cd8cmr5173244pzi.5.1678984719222;
        Thu, 16 Mar 2023 09:38:39 -0700 (PDT)
Received: from worktop ([2620:10d:c090:500::5:cd4d])
        by smtp.gmail.com with ESMTPSA id n20-20020aa78a54000000b0062604b7552fsm971628pfa.63.2023.03.16.09.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 09:38:38 -0700 (PDT)
Date:   Thu, 16 Mar 2023 09:38:28 -0700
From:   Manu Bretelle <chantr4@gmail.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, mykolal@fb.com,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        yhs@fb.com
Subject: Re: [PATCH bpf-next] selftests/bpf: add --json-summary option to
 test_progs
Message-ID: <ZBNGBAAki3VUU0bQ@worktop>
References: <20230316063901.3619730-1-chantr4@gmail.com>
 <665c32ae4ef880c1811b8a8e3b35a7ad0bcfb054.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <665c32ae4ef880c1811b8a8e3b35a7ad0bcfb054.camel@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 16, 2023 at 05:03:01PM +0200, Eduard Zingerman wrote:
> On Wed, 2023-03-15 at 23:39 -0700, Manu Bretelle wrote:
> > Currently, test_progs outputs all stdout/stderr as it runs, and when it
> > is done, prints a summary.
> > 
> > It is non-trivial for tooling to parse that output and extract meaningful
> > information from it.
> > 
> > This change adds a new option, `--json-summary`/`-J` that let the caller
> > specify a file where `test_progs{,-no_alu32}` can write a summary of the
> > run in a json format that can later be parsed by tooling.
> > 
> > Currently, it creates a summary section with successes/skipped/failures
> > followed by a list of failed tests/subtests.
> > 
> > A test contains the following fields:
> > - test_name: the name of the test
> > - test_number: the number of the test
> > - message: the log message that was printed by the test.
> > - failed: A boolean indicating whether the test failed or not. Currently
> > we only output failed tests, but in the future, successful tests could
> > be added.
> > 
> > A subtest contains the following fields:
> > - test_name: same as above
> > - test_number: sanme as above
> > - subtest_name: the name of the subtest
> > - subtest_number: the number of the subtest.
> > - message: the log message that was printed by the subtest.
> > - is_subtest: a boolean indicating that the entry is a subtest.
> > - failed: same as above but for the subtest
> > 
> 
> Looks like a great feature!
> A few nitpicks below.
> 
> > ```
> > $ sudo ./test_progs -a $(grep -v '^#' ./DENYLIST.aarch64 | awk '{print
> > $1","}' | tr -d '\n') -j -J /tmp/test_progs.json
> > $ jq . < /tmp/test_progs.json | head -n 30
> > $ head -n 30 /tmp/test_progs.json
> > {
> >     "success": 29,
> >     "success_subtest": 23,
> >     "skipped": 3,
> >     "failed": 27,
> >     "results": [{
> >             "test_name": "bpf_cookie",
> >             "test_number": 10,
> >             "message": "test_bpf_cookie:PASS:skel_open 0 nsec\n",
> >             "failed": true
> >         },{
> >             "test_name": "bpf_cookie",
> >             "subtest_name": "multi_kprobe_link_api",
> >             "test_number": 10,
> >             "subtest_number": 2,
> >             "message": "kprobe_multi_link_api_subtest:PASS:load_kallsyms
> > 0 nsec\nlibbpf: extern 'bpf_testmod_fentry_test1' (strong): not
> > resolved\nlibbpf: failed to load object 'kprobe_multi'\nlibbpf: failed
> > to load BPF skeleton 'kprobe_multi':
> > -3\nkprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected
> > error: -3\n",
> >             "is_subtest": true,
> >             "failed": true
> >         },{
> >             "test_name": "bpf_cookie",
> >             "subtest_name": "multi_kprobe_attach_api",
> >             "test_number": 10,
> >             "subtest_number": 3,
> >             "message": "libbpf: extern 'bpf_testmod_fentry_test1'
> > (strong): not resolved\nlibbpf: failed to load object
> > 'kprobe_multi'\nlibbpf: failed to load BPF skeleton 'kprobe_multi':
> > -3\nkprobe_multi_attach_api_subtest:FAIL:fentry_raw_skel_load unexpected
> > error: -3\n",
> >             "is_subtest": true,
> >             "failed": true
> >         },{
> >             "test_name": "bpf_cookie",
> >             "subtest_name": "lsm",
> >             "test_number": 10,
> > ```
> > 
> > The file can then be used to print a summary of the test run and list of
> > failing tests/subtests:
> > 
> > ```
> > $ jq -r < /tmp/test_progs.json '"Success:
> > \(.success)/\(.success_subtest), Skipped: \(.skipped), Failed:
> > \(.failed)"'
> > 
> > Success: 29/23, Skipped: 3, Failed: 27
> > $ jq -r <
> > /tmp/test_progs.json  '.results[] | if .is_subtest then
> > "#\(.test_number)/\(.subtest_number) \(.test_name)/\(.subtest_name)"
> > else "#\(.test_number) \(.test_name)" end'
> > ```
> > 
> > Signed-off-by: Manu Bretelle <chantr4@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/Makefile      |  4 +-
> >  tools/testing/selftests/bpf/json_writer.c |  1 +
> >  tools/testing/selftests/bpf/json_writer.h |  1 +
> >  tools/testing/selftests/bpf/test_progs.c  | 83 +++++++++++++++++++++--
> >  tools/testing/selftests/bpf/test_progs.h  |  1 +
> >  5 files changed, 84 insertions(+), 6 deletions(-)
> >  create mode 120000 tools/testing/selftests/bpf/json_writer.c
> >  create mode 120000 tools/testing/selftests/bpf/json_writer.h
> > 
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > index 55811c448eb7..fc092582d16d 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -234,6 +234,7 @@ $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(BPFOBJ)
> >  CGROUP_HELPERS	:= $(OUTPUT)/cgroup_helpers.o
> >  TESTING_HELPERS	:= $(OUTPUT)/testing_helpers.o
> >  TRACE_HELPERS	:= $(OUTPUT)/trace_helpers.o
> > +JSON_WRITER		:= $(OUTPUT)/json_writer.o
> >  CAP_HELPERS	:= $(OUTPUT)/cap_helpers.o
> >  
> >  $(OUTPUT)/test_dev_cgroup: $(CGROUP_HELPERS) $(TESTING_HELPERS)
> > @@ -559,7 +560,8 @@ TRUNNER_BPF_PROGS_DIR := progs
> >  TRUNNER_EXTRA_SOURCES := test_progs.c cgroup_helpers.c trace_helpers.c	\
> >  			 network_helpers.c testing_helpers.c		\
> >  			 btf_helpers.c flow_dissector_load.h		\
> > -			 cap_helpers.c test_loader.c xsk.c disasm.c
> > +			 cap_helpers.c test_loader.c xsk.c disasm.c \
> > +			 json_writer.c
> >  TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
> >  		       $(OUTPUT)/liburandom_read.so			\
> >  		       $(OUTPUT)/xdp_synproxy				\
> > diff --git a/tools/testing/selftests/bpf/json_writer.c b/tools/testing/selftests/bpf/json_writer.c
> > new file mode 120000
> > index 000000000000..5effa31e2f39
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/json_writer.c
> > @@ -0,0 +1 @@
> > +../../../bpf/bpftool/json_writer.c
> > \ No newline at end of file
> > diff --git a/tools/testing/selftests/bpf/json_writer.h b/tools/testing/selftests/bpf/json_writer.h
> > new file mode 120000
> > index 000000000000..e0a264c26752
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/json_writer.h
> > @@ -0,0 +1 @@
> > +../../../bpf/bpftool/json_writer.h
> > \ No newline at end of file
> > diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> > index 6d5e3022c75f..cf56f6a4e1af 100644
> > --- a/tools/testing/selftests/bpf/test_progs.c
> > +++ b/tools/testing/selftests/bpf/test_progs.c
> > @@ -18,6 +18,7 @@
> >  #include <sys/socket.h>
> >  #include <sys/un.h>
> >  #include <bpf/btf.h>
> > +#include "json_writer.h"
> >  
> >  static bool verbose(void)
> >  {
> > @@ -269,10 +270,22 @@ static void print_subtest_name(int test_num, int subtest_num,
> >  	fprintf(env.stdout, "\n");
> >  }
> >  
> > +static void jsonw_write_log_message(json_writer_t *w, char *log_buf, size_t log_cnt)
> > +{
> > +	// open_memstream (from stdio_hijack_init) ensures that log_bug is terminated by a
> > +	// null byte. Yet in parralel mode, log_buf will be NULL if there is no message.
> > +	if (log_cnt) {
> > +		jsonw_string_field(w, "message", log_buf);
> > +	} else {
> > +		jsonw_string_field(w, "message", "");
> > +	}
> > +}
> > +
> >  static void dump_test_log(const struct prog_test_def *test,
> >  			  const struct test_state *test_state,
> >  			  bool skip_ok_subtests,
> > -			  bool par_exec_result)
> > +			  bool par_exec_result,
> > +			  json_writer_t *w)
> >  {
> >  	bool test_failed = test_state->error_cnt > 0;
> >  	bool force_log = test_state->force_log;
> > @@ -296,6 +309,15 @@ static void dump_test_log(const struct prog_test_def *test,
> >  	if (test_state->log_cnt && print_test)
> >  		print_test_log(test_state->log_buf, test_state->log_cnt);
> >  
> > +	if (w && print_test) {
> > +		jsonw_start_object(w);
> > +		jsonw_string_field(w, "test_name", test->test_name);
> > +		jsonw_uint_field(w, "test_number", test->test_num);
> > +		jsonw_write_log_message(w, test_state->log_buf, test_state->log_cnt);
> > +		jsonw_bool_field(w, "failed", true);
> 
> The `print_test` is used as a precondition, but it is defined as follows:
> 
> 	bool print_test = verbose() || force_log || test_failed;
> 
> Maybe change the line above to:
> 
> 		jsonw_bool_field(w, "failed", test_failed);
> 

Good point/catch. Thanks.

> Or use `test_failed` as a precondition?
> 
> > +		jsonw_end_object(w);
> > +	}
> > +
> >  	for (i = 0; i < test_state->subtest_num; i++) {
> >  		subtest_state = &test_state->subtest_states[i];
> >  		subtest_failed = subtest_state->error_cnt;
> > @@ -314,6 +336,19 @@ static void dump_test_log(const struct prog_test_def *test,
> >  				   test->test_name, subtest_state->name,
> >  				   test_result(subtest_state->error_cnt,
> >  					       subtest_state->skipped));
> > +
> > +		if (w && print_subtest) {
> > +			jsonw_start_object(w);
> > +			jsonw_string_field(w, "test_name", test->test_name);
> > +			jsonw_string_field(w, "subtest_name", subtest_state->name);
> > +			jsonw_uint_field(w, "test_number", test->test_num);
> > +			jsonw_uint_field(w, "subtest_number", i+1);
> > +			jsonw_write_log_message(w, subtest_state->log_buf, subtest_state->log_cnt);
> > +			jsonw_bool_field(w, "is_subtest", true);
> > +			jsonw_bool_field(w, "failed", true);
> > +			jsonw_end_object(w);
> > +		}
> > +
> 
> Maybe organize failed subtests as a field of a top-level result?
> E.g. as follows:
> 
> {
>     "success": 295,
>     "success_subtest": 1771,
>     "skipped": 18,
>     "failed": 3,
>     "results": [
>         {
>             "test_name": "btf_tag",
>             "test_number": 29,
>             "message": "",
>             "failed": true
>             "subtests": [
>                 {
>                     "test_name": "btf_tag",
>                     "subtest_name": "btf_type_tag_percpu_mod1",
>                     "test_number": 29,
>                     "subtest_number": 6,
>                     "message": "...",
>                     "failed": true
>                 }
>             ]
>         }
>     ]
> }

I was originally going to do a nested structure similar to this too
(minus the repeat of test_* entries for subtests. But while discussing this
offline with Andrii, a flatter structured seemed to be easier to parse/manage
with tools such as `jq`. I am also very probably missing the right
incantation for `jq`.

Finding whether a test has subtests (currently only adding failed ones,
but this could change in the future) would be easier (essentially checking
length(subtests)). But neither is it difficult to reconstruct using
higher level language.

In term of logical structure and maybe extensibility, this is more appropriate,
in term of pragmatism maybe less.

I don't have strong opinions and can see benefit for both.

> 
> >  	}
> >  
> >  	print_test_result(test, test_state);
> > @@ -715,6 +750,7 @@ enum ARG_KEYS {
> >  	ARG_TEST_NAME_GLOB_DENYLIST = 'd',
> >  	ARG_NUM_WORKERS = 'j',
> >  	ARG_DEBUG = -1,
> > +	ARG_JSON_SUMMARY = 'J'
> >  };
> >  
> >  static const struct argp_option opts[] = {
> > @@ -740,6 +776,7 @@ static const struct argp_option opts[] = {
> >  	  "Number of workers to run in parallel, default to number of cpus." },
> >  	{ "debug", ARG_DEBUG, NULL, 0,
> >  	  "print extra debug information for test_progs." },
> > +	{ "json-summary", ARG_JSON_SUMMARY, "FILE", 0, "Write report in json format to this file."},
> >  	{},
> >  };
> >  
> > @@ -870,6 +907,13 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
> >  	case ARG_DEBUG:
> >  		env->debug = true;
> >  		break;
> > +	case ARG_JSON_SUMMARY:
> > +		env->json = fopen(arg, "w");
> > +		if (env->json == NULL) {
> > +			perror("Failed to open json summary file");
> > +			return -errno;
> > +		}
> > +		break;
> >  	case ARGP_KEY_ARG:
> >  		argp_usage(state);
> >  		break;
> > @@ -1017,7 +1061,7 @@ void crash_handler(int signum)
> >  		stdio_restore();
> >  	if (env.test) {
> >  		env.test_state->error_cnt++;
> > -		dump_test_log(env.test, env.test_state, true, false);
> > +		dump_test_log(env.test, env.test_state, true, false, NULL);
> >  	}
> >  	if (env.worker_id != -1)
> >  		fprintf(stderr, "[%d]: ", env.worker_id);
> > @@ -1124,7 +1168,7 @@ static void run_one_test(int test_num)
> >  
> >  	stdio_restore();
> >  
> > -	dump_test_log(test, state, false, false);
> > +	dump_test_log(test, state, false, false, NULL);
> >  }
> >  
> >  struct dispatch_data {
> > @@ -1283,7 +1327,7 @@ static void *dispatch_thread(void *ctx)
> >  		} while (false);
> >  
> >  		pthread_mutex_lock(&stdout_output_lock);
> > -		dump_test_log(test, state, false, true);
> > +		dump_test_log(test, state, false, true, NULL);
> >  		pthread_mutex_unlock(&stdout_output_lock);
> >  	} /* while (true) */
> >  error:
> > @@ -1322,8 +1366,28 @@ static void calculate_summary_and_print_errors(struct test_env *env)
> >  			fail_cnt++;
> >  		else
> >  			succ_cnt++;
> > +
> > +	}
> > +
> > +	json_writer_t *w = NULL;
> > +
> > +	if (env->json) {
> > +		w = jsonw_new(env->json);
> > +		if (!w)
> > +			fprintf(env->stderr, "Failed to create new JSON stream.");
> >  	}
> >  
> > +	if (w) {
> > +		jsonw_pretty(w, 1);
> > +		jsonw_start_object(w);
> > +		jsonw_uint_field(w, "success", succ_cnt);
> > +		jsonw_uint_field(w, "success_subtest", sub_succ_cnt);
> > +		jsonw_uint_field(w, "skipped", skip_cnt);
> > +		jsonw_uint_field(w, "failed", fail_cnt);
> > +		jsonw_name(w, "results");
> > +		jsonw_start_array(w);
> > +
> > +	}
> >  	/*
> >  	 * We only print error logs summary when there are failed tests and
> >  	 * verbose mode is not enabled. Otherwise, results may be incosistent.
> > @@ -1340,10 +1404,19 @@ static void calculate_summary_and_print_errors(struct test_env *env)
> >  			if (!state->tested || !state->error_cnt)
> >  				continue;
> >  
> > -			dump_test_log(test, state, true, true);
> > +			dump_test_log(test, state, true, true, w);
> >  		}
> >  	}
> >  
> > +	if (w) {
> > +		jsonw_end_array(w);
> > +		jsonw_end_object(w);
> > +		jsonw_destroy(&w);
> > +	}
> > +
> > +	if (env->json)
> > +		fclose(env->json);
> > +
> >  	printf("Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
> >  	       succ_cnt, sub_succ_cnt, skip_cnt, fail_cnt);
> >  
> > diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
> > index 3cbf005747ed..4b06b8347cd4 100644
> > --- a/tools/testing/selftests/bpf/test_progs.h
> > +++ b/tools/testing/selftests/bpf/test_progs.h
> > @@ -114,6 +114,7 @@ struct test_env {
> >  	FILE *stdout;
> >  	FILE *stderr;
> >  	int nr_cpus;
> > +	FILE *json;
> >  
> >  	int succ_cnt; /* successful tests */
> >  	int sub_succ_cnt; /* successful sub-tests */
> 
