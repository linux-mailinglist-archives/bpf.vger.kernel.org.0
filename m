Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9385F6BDCD9
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 00:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjCPXWd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Mar 2023 19:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjCPXWU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Mar 2023 19:22:20 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FD210DE66
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 16:22:06 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x13so13995720edd.1
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 16:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679008925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0F9x0eI+53H6yrKTyNWX23Iwz6iZCfeT/qSLoy7z96k=;
        b=gzWdGk3D38iXFINugkBWX7EPfovwuepjnr/fCU3m5bfahJAsAVGbVHJ+YZMiWIRL03
         UGyePda1i8+l0TcRZoN+qXNMTwe5IV7vZzv6Yg3N6t3P9wlGyGUoidDs/IpjSYfJlq3Y
         r9cVYvTIgh6ZYPqEFAZSlibxqDz51mYCyuFsUaGvgnD4wbC2wtQl0BzQRrQLdi7bRcz3
         epvtQJXOs4I0LbqL6wYlVo7wSxXKY3rAYNmGjP7GwPCdkI5JbaN6lN8y/HQ4uJiYnGtO
         N0/3YjkSgRZvHo/vrGw7hj6nwFOvcqaIsTMY9PJBZPonOrGPfUAoJRYPao6uX/YulDIi
         oSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679008925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0F9x0eI+53H6yrKTyNWX23Iwz6iZCfeT/qSLoy7z96k=;
        b=a/hmlu9D5UretE4x3Tj0JuKA/yrleIpJIMEf49l0g0N9JTSH16ARRYaJd0pwv6sZwQ
         Cs9L0uyiDdADQBnFYswVxMzc3qNYBR4JU5ljHdY3QLMStD/Jszfsr36lxM6kj27c3aZd
         vN7bt5NH5e4wmvy4y1hfdCSyF2CjnoODC528ua+mlpJ79pJkBW3FxZa3td0RfgjDAOhA
         I3VG29BojtQM3xCW+9Vh50q4t4Hi9IC8tAJRIpi5Go+Xsr6DBiBwH2CymzLnlPTVdzIk
         iDvQiMtixRDUFeKBFsOeIdNeKQk2YMYOLjrS10pftlzygFPpPuiJmy0Z/fmGFwuWT5qm
         4RCA==
X-Gm-Message-State: AO0yUKUxMos0H/pipCe/ZZpkvlHxMgXpsnoZR8SWd0yvBg0u4/dzxGmE
        lGClTI02tnWKADzIGCa5sHu1JGTMauURHEmhCq2I8YGu
X-Google-Smtp-Source: AK7set+HBAnhuxiVXnsgwIPFOfppATh0K0zr7CKmHjxlRCqzbOEOL3yQkkfn2tjv0m8iUK9/qGgH54BFz7tcAIb2i1g=
X-Received: by 2002:a50:8e41:0:b0:4ac:b832:856c with SMTP id
 1-20020a508e41000000b004acb832856cmr718459edx.1.1679008924707; Thu, 16 Mar
 2023 16:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230316063901.3619730-1-chantr4@gmail.com>
In-Reply-To: <20230316063901.3619730-1-chantr4@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 16 Mar 2023 16:21:52 -0700
Message-ID: <CAEf4BzYiFYdqToBpnnYMCxi+eihMu1VJ1Njz9_3vHES9y3yYcw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: add --json-summary option to test_progs
To:     Manu Bretelle <chantr4@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, mykolal@fb.com,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 15, 2023 at 11:39=E2=80=AFPM Manu Bretelle <chantr4@gmail.com> =
wrote:
>
> Currently, test_progs outputs all stdout/stderr as it runs, and when it
> is done, prints a summary.
>
> It is non-trivial for tooling to parse that output and extract meaningful
> information from it.
>
> This change adds a new option, `--json-summary`/`-J` that let the caller
> specify a file where `test_progs{,-no_alu32}` can write a summary of the
> run in a json format that can later be parsed by tooling.
>
> Currently, it creates a summary section with successes/skipped/failures
> followed by a list of failed tests/subtests.
>
> A test contains the following fields:
> - test_name: the name of the test
> - test_number: the number of the test
> - message: the log message that was printed by the test.
> - failed: A boolean indicating whether the test failed or not. Currently
> we only output failed tests, but in the future, successful tests could
> be added.
>
> A subtest contains the following fields:
> - test_name: same as above
> - test_number: sanme as above
> - subtest_name: the name of the subtest
> - subtest_number: the number of the subtest.
> - message: the log message that was printed by the subtest.
> - is_subtest: a boolean indicating that the entry is a subtest.

"is_" prefix stands out compared to other bool field ("failed"),
should we call this just "subtest" for consistency?

> - failed: same as above but for the subtest
>
> ```
> $ sudo ./test_progs -a $(grep -v '^#' ./DENYLIST.aarch64 | awk '{print
> $1","}' | tr -d '\n') -j -J /tmp/test_progs.json
> $ jq . < /tmp/test_progs.json | head -n 30
> $ head -n 30 /tmp/test_progs.json
> {
>     "success": 29,
>     "success_subtest": 23,
>     "skipped": 3,
>     "failed": 27,
>     "results": [{
>             "test_name": "bpf_cookie",
>             "test_number": 10,
>             "message": "test_bpf_cookie:PASS:skel_open 0 nsec\n",
>             "failed": true
>         },{
>             "test_name": "bpf_cookie",
>             "subtest_name": "multi_kprobe_link_api",
>             "test_number": 10,
>             "subtest_number": 2,
>             "message": "kprobe_multi_link_api_subtest:PASS:load_kallsyms
> 0 nsec\nlibbpf: extern 'bpf_testmod_fentry_test1' (strong): not
> resolved\nlibbpf: failed to load object 'kprobe_multi'\nlibbpf: failed
> to load BPF skeleton 'kprobe_multi':
> -3\nkprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected
> error: -3\n",
>             "is_subtest": true,
>             "failed": true
>         },{
>             "test_name": "bpf_cookie",
>             "subtest_name": "multi_kprobe_attach_api",
>             "test_number": 10,
>             "subtest_number": 3,
>             "message": "libbpf: extern 'bpf_testmod_fentry_test1'
> (strong): not resolved\nlibbpf: failed to load object
> 'kprobe_multi'\nlibbpf: failed to load BPF skeleton 'kprobe_multi':
> -3\nkprobe_multi_attach_api_subtest:FAIL:fentry_raw_skel_load unexpected
> error: -3\n",
>             "is_subtest": true,
>             "failed": true
>         },{
>             "test_name": "bpf_cookie",
>             "subtest_name": "lsm",
>             "test_number": 10,
> ```
>
> The file can then be used to print a summary of the test run and list of
> failing tests/subtests:
>
> ```
> $ jq -r < /tmp/test_progs.json '"Success:
> \(.success)/\(.success_subtest), Skipped: \(.skipped), Failed:
> \(.failed)"'
>
> Success: 29/23, Skipped: 3, Failed: 27
> $ jq -r <
> /tmp/test_progs.json  '.results[] | if .is_subtest then
> "#\(.test_number)/\(.subtest_number) \(.test_name)/\(.subtest_name)"
> else "#\(.test_number) \(.test_name)" end'
> ```
>
> Signed-off-by: Manu Bretelle <chantr4@gmail.com>
> ---

Looks great, some nits below.

>  tools/testing/selftests/bpf/Makefile      |  4 +-
>  tools/testing/selftests/bpf/json_writer.c |  1 +
>  tools/testing/selftests/bpf/json_writer.h |  1 +
>  tools/testing/selftests/bpf/test_progs.c  | 83 +++++++++++++++++++++--
>  tools/testing/selftests/bpf/test_progs.h  |  1 +
>  5 files changed, 84 insertions(+), 6 deletions(-)
>  create mode 120000 tools/testing/selftests/bpf/json_writer.c
>  create mode 120000 tools/testing/selftests/bpf/json_writer.h
>

[...]

> @@ -269,10 +270,22 @@ static void print_subtest_name(int test_num, int su=
btest_num,
>         fprintf(env.stdout, "\n");
>  }
>
> +static void jsonw_write_log_message(json_writer_t *w, char *log_buf, siz=
e_t log_cnt)
> +{
> +       // open_memstream (from stdio_hijack_init) ensures that log_bug i=
s terminated by a
> +       // null byte. Yet in parralel mode, log_buf will be NULL if there=
 is no message.

please don't use C++-style comments, let's use /* */ consistently

also typo: parallel

> +       if (log_cnt) {
> +               jsonw_string_field(w, "message", log_buf);
> +       } else {
> +               jsonw_string_field(w, "message", "");
> +       }
> +}
> +

[...]

> @@ -1283,7 +1327,7 @@ static void *dispatch_thread(void *ctx)
>                 } while (false);
>
>                 pthread_mutex_lock(&stdout_output_lock);
> -               dump_test_log(test, state, false, true);
> +               dump_test_log(test, state, false, true, NULL);
>                 pthread_mutex_unlock(&stdout_output_lock);
>         } /* while (true) */
>  error:
> @@ -1322,8 +1366,28 @@ static void calculate_summary_and_print_errors(str=
uct test_env *env)
>                         fail_cnt++;
>                 else
>                         succ_cnt++;
> +
> +       }
> +
> +       json_writer_t *w =3D NULL;

please declare variable at the top to follow C89 style

> +
> +       if (env->json) {
> +               w =3D jsonw_new(env->json);
> +               if (!w)
> +                       fprintf(env->stderr, "Failed to create new JSON s=
tream.");
>         }
>
> +       if (w) {
> +               jsonw_pretty(w, 1);

true, it's bool

> +               jsonw_start_object(w);
> +               jsonw_uint_field(w, "success", succ_cnt);
> +               jsonw_uint_field(w, "success_subtest", sub_succ_cnt);
> +               jsonw_uint_field(w, "skipped", skip_cnt);
> +               jsonw_uint_field(w, "failed", fail_cnt);
> +               jsonw_name(w, "results");
> +               jsonw_start_array(w);
> +
> +       }

[...]
