Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00F761A361
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 22:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiKDVes (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 17:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKDVer (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 17:34:47 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D8C49B77
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 14:34:44 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id kt23so16521996ejc.7
        for <bpf@vger.kernel.org>; Fri, 04 Nov 2022 14:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVYX25cF/7yJyc+Fqlz5EWiIvWzpgtymbDR3XQ+a3Zo=;
        b=EKcL51cfyKn9i6TvaiYLzXpF0xH3NE/pBGn3pDwVXCEy35FER0coW2ePuDp7Gf11GJ
         TasusRB6LQW6IJPqdBkr7w+heRrE03s3pcF7it8wJX8KgHWZfswzP8rf6NDaD+M4CA8c
         I9Pyf+bVCn/dqJLJ257baj8N2Pz7Lqkla3s+8YrwM4PVOI6L8lZ5da8/KlXUAc6+76hj
         s3d+v4oxRITp3BKrf1sqCh7IKzPHBEnowgcqEzO6QENuRIgXnJ4+rJ7dQFZRjzXPTX5q
         qJQKwHusmhH4mG9Bl4USbbhHhr5ukz4ONrxvA1uONg01hniHUGRqN6I/GxhlW+lvtU7Q
         alhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVYX25cF/7yJyc+Fqlz5EWiIvWzpgtymbDR3XQ+a3Zo=;
        b=adsysTCdn9BKdw3HTq828avqbOrPdkjjcC2829ovtfsvGDnCJ03mYfePp5Y2Q+NqHF
         hqjtvDj5Z2O8wReBn/LTOMP4lWdVtugne6uTqXH/tojIYZt84oNFVDDncrqHlnHJ6wJf
         DNJymjimXMsU+IxShZuuQ3YuZoC0q/kD1d9uZGNLOqQqljpv2YT3biBfuYBmm7F5L24S
         i3S2r0sTXBjS6yUa30EZySXb3afzbV1Tgt5ZoO+BzecfGwZhgeF6LIgYxGH1yac4VdYh
         0BK4q+ALvmreVpaPGZYQwObhGMzjO6rSFqwEdCSy8m9lgSYqTVXVmiOANZjYYG+QHdce
         TF4g==
X-Gm-Message-State: ACrzQf34felnuVraGiAdJf6AGpj/7PfY6KP6zgXJNAJLoA2KRyOTAkzZ
        ehlTlurhrr9oSo67weY7VLOg+pX2q4jJjv3UY8w=
X-Google-Smtp-Source: AMsMyM74MYbh7yTUYvGMDfNCI8pEHNaKgEJyIy8CczluE0s1tq4f6vwQ+uaJM4RbUeR4QyXAOeDGUuxU4/n0/pNo8N8=
X-Received: by 2002:a17:906:99c5:b0:73d:70c5:1a4f with SMTP id
 s5-20020a17090699c500b0073d70c51a4fmr35876272ejn.302.1667597682654; Fri, 04
 Nov 2022 14:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20221028175530.1413351-1-cerasuolodomenico@gmail.com>
 <635c64abe004c_b1ba20850@john.notmuch> <DC4AB44C-734B-46BC-A9E2-9A24C56F7F9A@fb.com>
In-Reply-To: <DC4AB44C-734B-46BC-A9E2-9A24C56F7F9A@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 4 Nov 2022 14:34:30 -0700
Message-ID: <CAEf4BzZ-LQMFAv-5fZTFQp0693R-BjGNWbZV9jscM31S854+-w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests: fix test group SKIPPED result
To:     Mykola Lysenko <mykolal@meta.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Martin Lau <kafai@meta.com>, Kernel Team <Kernel-team@fb.com>
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

On Mon, Oct 31, 2022 at 4:45 PM Mykola Lysenko <mykolal@meta.com> wrote:
>
> Hi John,
>
> Test FAILs when there is an unexpected condition during test/subtest exec=
ution, developer does not control it. Hence we propagate FAIL subtest resul=
t to be the test result, test_progs result and consequently CI result.
> On the other hand, SKIP state is fully controlled by us.

So this is not entirely correct. Tests can "skip themselves" if they
detect conditions under which they can't run (e.g., hardware perf
events support). So in some contexts SKIP might be surprising.

What Daniel proposed looks good to me, we'd be able to quickly tell if
a test had some skipped subtests and how many.

> E.g. we decide when particular subtest/test should be skipped. We do not =
propagate SKIP state to the test_progs result. test_progs result can either=
 be OK or FAIL. Also, SKIPPED subtest is not an indication of a problem in =
a test. Hence, I do not think one SKIPPED subtest should mark the whole tes=
t as SKIPPED.
>
> For example, core_reloc_btfgen has 77 subtests (https://github.com/kernel=
-patches/bpf/actions/runs/3349035937/jobs/5548924891#step:6:4895). Some of =
them are skipped right now. However, most of them are passing. It is a norm=
al state. For me, marking core_reloc_btfgen as SKIP would mean that somethi=
ng is not right with the whole test. Also, I do not think we are reviewing =
SKIP tests / subtests right now. Maybe we should. But this would be orthogo=
nal discussion to this patch.
>
>
> > On Oct 28, 2022, at 4:24 PM, John Fastabend <john.fastabend@gmail.com> =
wrote:
> >
> > Domenico Cerasuolo wrote:
> >> From: Domenico Cerasuolo <dceras@meta.com>
> >>
> >> When showing the result of a test group, if one
> >> of the subtests was skipped, while still having
> >> passing subtets, the group result was marked as
> >> SKIPPED.
> >>
> >> #223/1   usdt/basic:SKIP
> >> #223/2   usdt/multispec:OK
> >> #223     usdt:SKIP
> >>
> >> With this change only if all of the subtests
> >> were skipped the group test is marked as SKIPPED.
> >>
> >> #223/1   usdt/basic:SKIP
> >> #223/2   usdt/multispec:OK
> >> #223     usdt:OK
> >
> > I'm not sure don't you want to know that some of the tests
> > were skipped? With this change its not knowable from output
> > if everything passed or one passed.
> >
> > I would prefer the behavior: If anything fails return
> > FAIL, else if anything is skipped SKIP and if _everything_
> > passes mark it OK.
> >
> > My preference is to drop this change.
> >
> >>
> >> Signed-off-by: Domenico Cerasuolo <dceras@meta.com>
> >> ---
> >> tools/testing/selftests/bpf/test_progs.c | 11 +++++++++--
> >> 1 file changed, 9 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/=
selftests/bpf/test_progs.c
> >> index 0e9a47f97890..14b70393018b 100644
> >> --- a/tools/testing/selftests/bpf/test_progs.c
> >> +++ b/tools/testing/selftests/bpf/test_progs.c
> >> @@ -222,6 +222,11 @@ static char *test_result(bool failed, bool skippe=
d)
> >>      return failed ? "FAIL" : (skipped ? "SKIP" : "OK");
> >> }
> >>
> >> +static char *test_group_result(int tests_count, bool failed, int skip=
ped)
> >> +{
> >> +    return failed ? "FAIL" : (skipped =3D=3D tests_count ? "SKIP" : "=
OK");
> >> +}
> >> +
> >> static void print_test_log(char *log_buf, size_t log_cnt)
> >> {
> >>      log_buf[log_cnt] =3D '\0';
> >> @@ -308,7 +313,8 @@ static void dump_test_log(const struct prog_test_d=
ef *test,
> >>      }
> >>
> >>      print_test_name(test->test_num, test->test_name,
> >> -                    test_result(test_failed, test_state->skip_cnt));
> >> +                    test_group_result(test_state->subtest_num,
> >> +                            test_failed, test_state->skip_cnt));
> >> }
> >>
> >> static void stdio_restore(void);
> >> @@ -1071,7 +1077,8 @@ static void run_one_test(int test_num)
> >>
> >>      if (verbose() && env.worker_id =3D=3D -1)
> >>              print_test_name(test_num + 1, test->test_name,
> >> -                            test_result(state->error_cnt, state->skip=
_cnt));
> >> +                            test_group_result(state->subtest_num,
> >> +                                    state->error_cnt, state->skip_cnt=
));
> >>
> >>      reset_affinity();
> >>      restore_netns();
> >> --
> >> 2.30.2
> >>
> >
> >
>
