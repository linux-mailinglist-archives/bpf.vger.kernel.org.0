Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2506BDDBC
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 01:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCQAkJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Mar 2023 20:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjCQAkJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Mar 2023 20:40:09 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7B55D887
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 17:40:07 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so7246038pjt.2
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 17:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679013606;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jtJIZVUpiPthfojhOS/XExudPRRl8J2u64ov+y1nRco=;
        b=EIGmSgJtUX8OLY7bjRz1447kbrl3pYssdDrjCzhYpewg1Ia1J0l4E1gN1Kj4UfPKup
         C5FZop8DuPR68lLKNv57vfymzOq4x/WHSBul70ZZBLYCYM69ZLPKAVSj752XhUYZtmhA
         fniVV1YqlR1RkmZXlPX4mHqcfW0gr10ew3H0qajoft+MM33HTBhu9QEo4MHrfqy4xmes
         6iIRDTSp9XZ+kU/Ya+hOzIamUYSkxQKD8XVU8cKDsAt6fd1+6nM2paJthEWlFHdtkTOl
         uDstr3L7+Wtc9dbGMK2lfB/fN5qSX3n4Jay+KslU3IGq8sviHN2uy2Xk70pTn0W+X+LW
         ADOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679013606;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jtJIZVUpiPthfojhOS/XExudPRRl8J2u64ov+y1nRco=;
        b=swUeSxequKOJZtZsXt/qzG4WdOIqVmZcc0CAAZy3NRRyauAhhpyHeKp6B7r5yI3Eef
         Kr4MnYks/Mw5uOddWcS9oK5K0D/Z+0/iyrHeQzh8ggxe2TCXTRsUPhoOJ/Y8kN1HcSYK
         rvaC2N4sjVH1QMM1zr/5nDFqbdVw0XhimMxdjaBKkfIMUPe8U94cehA/Jcj2nebGSqJz
         nYdd7O3G8V+AX1M5iGvOQawmE8BMYHrRqSuuPiEiCHWhImAnNmguTWXz3XkGeWxUaIzN
         1JXJBYkPIUjZ6E7v415zAiA3aV8PKTK46W43HAAdGbeCNZfXi0Z+BfbPODiLdEdOlaiE
         h59A==
X-Gm-Message-State: AO0yUKVcY7c55JQ/RPizpY/afWmE7y4HdJT54ykEpJL3q3F0yiujKn8c
        HWpkVel+VujkVNfvsV1ZtYKhx/SyLIDe4A==
X-Google-Smtp-Source: AK7set+nehrkp3KNBnxTI7f0hmTXPLoLL4leEGzjSpgoZil/KZAQTvYaTznAHOUC68UnSuaz43cjKQ==
X-Received: by 2002:a17:90b:38cf:b0:23f:3b89:7f16 with SMTP id nn15-20020a17090b38cf00b0023f3b897f16mr3467630pjb.0.1679013606374;
        Thu, 16 Mar 2023 17:40:06 -0700 (PDT)
Received: from worktop ([2620:10d:c090:400::5:1c5f])
        by smtp.gmail.com with ESMTPSA id fu20-20020a17090ad19400b0023086d280c5sm307961pjb.3.2023.03.16.17.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 17:40:05 -0700 (PDT)
Date:   Thu, 16 Mar 2023 17:40:03 -0700
From:   Manu Bretelle <chantr4@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, mykolal@fb.com,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        yhs@fb.com
Subject: Re: [PATCH bpf-next] selftests/bpf: add --json-summary option to
 test_progs
Message-ID: <ZBO24yyuynZCMqGO@worktop>
References: <20230316063901.3619730-1-chantr4@gmail.com>
 <CAEf4BzYiFYdqToBpnnYMCxi+eihMu1VJ1Njz9_3vHES9y3yYcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYiFYdqToBpnnYMCxi+eihMu1VJ1Njz9_3vHES9y3yYcw@mail.gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 16, 2023 at 04:21:52PM -0700, Andrii Nakryiko wrote:
> On Wed, Mar 15, 2023 at 11:39 PM Manu Bretelle <chantr4@gmail.com> wrote:
> >
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
> 
> "is_" prefix stands out compared to other bool field ("failed"),
> should we call this just "subtest" for consistency?
> 

yes, I will give a try to the nested representation and play a bit more
with jq. In any case, this will become `subtest[s]`.

> > - failed: same as above but for the subtest
> >
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
> 
> Looks great, some nits below.
> 
> >  tools/testing/selftests/bpf/Makefile      |  4 +-
> >  tools/testing/selftests/bpf/json_writer.c |  1 +
> >  tools/testing/selftests/bpf/json_writer.h |  1 +
> >  tools/testing/selftests/bpf/test_progs.c  | 83 +++++++++++++++++++++--
> >  tools/testing/selftests/bpf/test_progs.h  |  1 +
> >  5 files changed, 84 insertions(+), 6 deletions(-)
> >  create mode 120000 tools/testing/selftests/bpf/json_writer.c
> >  create mode 120000 tools/testing/selftests/bpf/json_writer.h
> >
> 
> [...]
> 
> > @@ -269,10 +270,22 @@ static void print_subtest_name(int test_num, int subtest_num,
> >         fprintf(env.stdout, "\n");
> >  }
> >
> > +static void jsonw_write_log_message(json_writer_t *w, char *log_buf, size_t log_cnt)
> > +{
> > +       // open_memstream (from stdio_hijack_init) ensures that log_bug is terminated by a
> > +       // null byte. Yet in parralel mode, log_buf will be NULL if there is no message.
> 
> please don't use C++-style comments, let's use /* */ consistently
> 
> also typo: parallel
> 
ack

> > +       if (log_cnt) {
> > +               jsonw_string_field(w, "message", log_buf);
> > +       } else {
> > +               jsonw_string_field(w, "message", "");
> > +       }
> > +}
> > +
> 
> [...]
> 
> > @@ -1283,7 +1327,7 @@ static void *dispatch_thread(void *ctx)
> >                 } while (false);
> >
> >                 pthread_mutex_lock(&stdout_output_lock);
> > -               dump_test_log(test, state, false, true);
> > +               dump_test_log(test, state, false, true, NULL);
> >                 pthread_mutex_unlock(&stdout_output_lock);
> >         } /* while (true) */
> >  error:
> > @@ -1322,8 +1366,28 @@ static void calculate_summary_and_print_errors(struct test_env *env)
> >                         fail_cnt++;
> >                 else
> >                         succ_cnt++;
> > +
> > +       }
> > +
> > +       json_writer_t *w = NULL;
> 
> please declare variable at the top to follow C89 style
> 
ack
> > +
> > +       if (env->json) {
> > +               w = jsonw_new(env->json);
> > +               if (!w)
> > +                       fprintf(env->stderr, "Failed to create new JSON stream.");
> >         }
> >
> > +       if (w) {
> > +               jsonw_pretty(w, 1);
> 
> true, it's bool
> 

actually, given that this is not printed to stdout, and jq is widely available...
probably no need to pretty the output.

> > +               jsonw_start_object(w);
> > +               jsonw_uint_field(w, "success", succ_cnt);
> > +               jsonw_uint_field(w, "success_subtest", sub_succ_cnt);
> > +               jsonw_uint_field(w, "skipped", skip_cnt);
> > +               jsonw_uint_field(w, "failed", fail_cnt);
> > +               jsonw_name(w, "results");
> > +               jsonw_start_array(w);
> > +
> > +       }
> 
> [...]
