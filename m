Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876706BF5EC
	for <lists+bpf@lfdr.de>; Sat, 18 Mar 2023 00:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjCQXDO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 19:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjCQXDN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 19:03:13 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B450206A2
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 16:02:47 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id eg48so25927217edb.13
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 16:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679094165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VB609857EkgRBFblhpV0PeTJs9ddUoLACLWY/hOXZw=;
        b=JC9mUG8RdOMckG8eA+WlhpId6dG661p6LLLo6Y5QeeKeOqY0vioGG+/d+bmCOvNCTb
         lRvR3JWAiUnC2IbGywL8Gdvp8LRHOMKJ1zwSeKM6SCbTpdS5PPbRTZvYlfcUbEP0HnjG
         wzbBAl3wAR7ShFUuVTcx4yL3eVnHNE+OKysFc686aA2ti6SjWwVhj+aIhpsuBOWjM506
         KkkYubIE8C/Y2FG4lznoTqJQOdSAvyc4SWAsn4I29Dg6a2Hf+owKiXKgPyZBHfRhc01L
         ZXm/nRx2MwYFfcVUrXWw+Yohe02k2QgLN/6xfsylv2qhmJyrJBkqnndI+z4QioW5v8Sz
         b9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679094165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VB609857EkgRBFblhpV0PeTJs9ddUoLACLWY/hOXZw=;
        b=YhpwLNU2+2CkLkpEoH4RTF2rcWCzquMah/2Jl1XAGm6T8nGySgz0lHlMRPf4FnReuG
         o6pb6LYHZi2aV+LJxERzfRA+dbOq+QUCOZfnZZuwq4Z5F3ZbLiI76gmOLoTjCLUO1o1x
         yIlAowcc7ywEiaKHG1yvwa5o5iy0tiF4mTCk0j+vhlZ0j8D4YUjTun9WuHU5GcbJLM21
         hKlzztY7JZkebLB7YSrqEYqVxuitUdHKXDWjuiFLuvCIt4iGy8qZ4MGOvB/EXb9O9ddR
         aHIVF5T00f1eV1pYePOCf3dWG8/n3SVH4rxCy4WWL9HJjbi7JTEG9Jqzhs7DDlRUZuom
         M+sw==
X-Gm-Message-State: AO0yUKWuxoegGXkq+adOnz3KRTMzfF/Wl+FRTvSuyyR9O/FLyVJmppZI
        pNmZurY9qFM9XRFFWAnnEkUZUaiuGHBDo/Ofqgw=
X-Google-Smtp-Source: AK7set95vQ7My8oQfl/pnesEoS5b+yqodWKYjA64xCESjLn8nxDcHbWlx5Vf9L/pSFSg+0MlGSspcy7SS5UEJFP/Y20=
X-Received: by 2002:a50:d0cd:0:b0:4fc:f0b8:7da0 with SMTP id
 g13-20020a50d0cd000000b004fcf0b87da0mr2703614edf.1.1679094165221; Fri, 17 Mar
 2023 16:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230317163256.3809328-1-chantr4@gmail.com>
In-Reply-To: <20230317163256.3809328-1-chantr4@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 17 Mar 2023 16:02:32 -0700
Message-ID: <CAEf4BzZdyvY8A7KMbWP4uesOZQ631j5DL7_LJnsKa4d2xN-_cQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: add --json-summary option to test_progs
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

On Fri, Mar 17, 2023 at 9:33=E2=80=AFAM Manu Bretelle <chantr4@gmail.com> w=
rote:
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
> followed by a list of failed tests and subtests.
>
> A test contains the following fields:
> - name: the name of the test
> - number: the number of the test
> - message: the log message that was printed by the test.
> - failed: A boolean indicating whether the test failed or not. Currently
> we only output failed tests, but in the future, successful tests could
> be added.
> - subtests: A list of subtests associated with this test.
>
> A subtest contains the following fields:
> - name: same as above
> - number: sanme as above
> - message: the log message that was printed by the subtest.
> - failed: same as above but for the subtest
>
> An example run and json content below:
> ```
> $ sudo ./test_progs -a $(grep -v '^#' ./DENYLIST.aarch64 | awk '{print
> $1","}' | tr -d '\n') -j -J /tmp/test_progs.json
> $ jq < /tmp/test_progs.json | head -n 30
> {
>   "success": 29,
>   "success_subtest": 23,
>   "skipped": 3,
>   "failed": 28,
>   "results": [
>     {
>       "name": "bpf_cookie",
>       "number": 10,
>       "message": "test_bpf_cookie:PASS:skel_open 0 nsec\n",
>       "failed": true,
>       "subtests": [
>         {
>           "name": "multi_kprobe_link_api",
>           "number": 2,
>           "message": "kprobe_multi_link_api_subtest:PASS:load_kallsyms 0
> nsec\nlibbpf: extern 'bpf_testmod_fentry_test1' (strong): not
> resolved\nlibbpf: failed to load object 'kprobe_multi'\nlibbpf: failed
> to load BPF skeleton 'kprobe_multi':
> -3\nkprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected
> error: -3\n",
>           "failed": true
>         },
>         {
>           "name": "multi_kprobe_attach_api",
>           "number": 3,
>           "message": "libbpf: extern 'bpf_testmod_fentry_test1'
> (strong): not resolved\nlibbpf: failed to load object
> 'kprobe_multi'\nlibbpf: failed to load BPF skeleton 'kprobe_multi':
> -3\nkprobe_multi_attach_api_subtest:FAIL:fentry_raw_skel_load unexpected
> error: -3\n",
>           "failed": true
>         },
>         {
>           "name": "lsm",
>           "number": 8,
>           "message": "lsm_subtest:PASS:lsm.link_create 0
> nsec\nlsm_subtest:FAIL:stack_mprotect unexpected stack_mprotect: actual
> 0 !=3D expected -1\n",

Undid this wrapping of message strings, and command line examples
below. See also note about extra empty lines below.

Applied to bpf-next. So looking forward for this to be used in BPF CI!

>           "failed": true
>         }
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
> Success: 29/23, Skipped: 3, Failed: 28
> $ jq -r < /tmp/test_progs.json '.results | map([
>     if .failed then "#\(.number) \(.name)" else empty end,
>     (
>         . as {name: $tname, number: $tnum} | .subtests | map(
>             if .failed then "#\($tnum)/\(.number) \($tname)/\(.name)"
> else empty end
>         )
>     )
> ]) | flatten | .[]' | head -n 20
>  #10 bpf_cookie
>  #10/2 bpf_cookie/multi_kprobe_link_api
>  #10/3 bpf_cookie/multi_kprobe_attach_api
>  #10/8 bpf_cookie/lsm
>  #15 bpf_mod_race
>  #15/1 bpf_mod_race/ksym (used_btfs UAF)
>  #15/2 bpf_mod_race/kfunc (kfunc_btf_tab UAF)
>  #36 cgroup_hierarchical_stats
>  #61 deny_namespace
>  #61/1 deny_namespace/unpriv_userns_create_no_bpf
>  #73 fexit_stress
>  #83 get_func_ip_test
>  #99 kfunc_dynptr_param
>  #99/1 kfunc_dynptr_param/dynptr_data_null
>  #99/4 kfunc_dynptr_param/dynptr_data_null
>  #100 kprobe_multi_bench_attach
>  #100/1 kprobe_multi_bench_attach/kernel
>  #100/2 kprobe_multi_bench_attach/modules
>  #101 kprobe_multi_test
>  #101/1 kprobe_multi_test/skel_api
> ```
>
> Signed-off-by: Manu Bretelle <chantr4@gmail.com>
> ---
> v2:
>     * use `test_failed`, `subtest_failed` to populate "failed" field.
>     * Move to nested structure where subtests are added to the subtests
>         array of a test.
>     * removed test/subtest prefixes now that an object identify either
>         of them.
>     * addressed nits (comment, declaration at top of function)
>     * do not pretty output
> ---
>  tools/testing/selftests/bpf/Makefile      |  4 +-
>  tools/testing/selftests/bpf/json_writer.c |  1 +
>  tools/testing/selftests/bpf/json_writer.h |  1 +
>  tools/testing/selftests/bpf/test_progs.c  | 86 +++++++++++++++++++++--
>  tools/testing/selftests/bpf/test_progs.h  |  1 +
>  5 files changed, 87 insertions(+), 6 deletions(-)
>  create mode 120000 tools/testing/selftests/bpf/json_writer.c
>  create mode 120000 tools/testing/selftests/bpf/json_writer.h
>

[...]

> @@ -314,8 +338,24 @@ static void dump_test_log(const struct prog_test_def=
 *test,
>                                    test->test_name, subtest_state->name,
>                                    test_result(subtest_state->error_cnt,
>                                                subtest_state->skipped));
> +
> +               if (w && print_subtest) {
> +                       jsonw_start_object(w);
> +                       jsonw_string_field(w, "name", subtest_state->name=
);
> +                       jsonw_uint_field(w, "number", i+1);
> +                       jsonw_write_log_message(w, subtest_state->log_buf=
, subtest_state->log_cnt);
> +                       jsonw_bool_field(w, "failed", subtest_failed);
> +                       jsonw_end_object(w);
> +               }
> +
> +       }
> +
> +       if (w && print_test) {
> +               jsonw_end_array(w);
> +               jsonw_end_object(w);
>         }
>
> +

Undid this unnecessary line, same in few other places. Please don't
add unnecessary whitespaces for future patches.

>         print_test_result(test, test_state);
>  }
>

[...]
