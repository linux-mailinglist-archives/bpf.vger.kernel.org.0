Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE2C3E7D75
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 18:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhHJQZo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Aug 2021 12:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhHJQZn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Aug 2021 12:25:43 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B07EC0613C1
        for <bpf@vger.kernel.org>; Tue, 10 Aug 2021 09:25:21 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id a93so37300036ybi.1
        for <bpf@vger.kernel.org>; Tue, 10 Aug 2021 09:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QLuaXnrjs4XgMpx2wR4ZelCY0Uk09PmhHDhHj2ydl+4=;
        b=srMWPEVySrWT9yqD98NUSHg31abFRsQV5oMA9+DI1qOssUUc3hxXdPKkh26VF1b/F9
         AK3uR4qkflgJSlOt4eq00fYN607z6LqzWYpZU46fuVsGN3ZKPYpwNHPNAQnlUBW2mE/q
         y/lhT1aOg4SZdfTP8NhpJDYblshfKaeSWsvpjCjXYvVJQt9qr/gzWL3/KOoo8uAx5ItZ
         ehPGOzs6ka/wstCqp0X001d7d8rbLeTwUVgoSel/+Fi+B92M0ZvE6Bh0yKJ87c22u797
         rQLk+8TgDJGjuuKiZaYc3WmwTUfnBawpv3neSuHolDAr1AVZ0eTZJ84t4me2Lq0U1XJa
         K6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QLuaXnrjs4XgMpx2wR4ZelCY0Uk09PmhHDhHj2ydl+4=;
        b=F9Mb8/BsYoSUTMA0dswPtxwqifR+9uqemylxQbaR0q88PP//c/nhQmFdPwuQ74CNFe
         iJSaT/z7PUEnoIQRzc4Fa/aN50UcnHghWfWIK318NnPbJYhAqG6cz8qxzKkFkd9qYEpP
         YKM1IaYxipmEnQ4itPqu5zMwuekWkKDd9+FnNiCoLqJIQrap118tw5pMSZ8jtgrEIkIS
         jNiLJOShbPFvE0HB7yUYkoz/kKYUGhVYAJVEb8py3//ZGrMBCj4MRXHtzvfqZBJs7Rxg
         CTf77xLltXlsyh9ajq7YpQ1pqmgbMpxpPW3YFJ05r2RhTwSF4Cqkp4zILucRqNwF7yVe
         5+5A==
X-Gm-Message-State: AOAM530LsK20A9YBQdEVHkVypI0hZ1GKpgK218TVDsM1ptyI9t4TVcAF
        WETAH8NqsxJ50soEkxlxQo1Nr6EpkZL/N1flx0g=
X-Google-Smtp-Source: ABdhPJyWmYb9V2uNz1E3NGO9KD2d+Iq6JNmQXBTxuiAihojIpIBAoCB5hn3KjNTOH/L3TiYQCCFwzwbf2LyHlZIvunc=
X-Received: by 2002:a25:bb13:: with SMTP id z19mr41051363ybg.347.1628612720854;
 Tue, 10 Aug 2021 09:25:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210810001625.1140255-1-fallentree@fb.com> <20210810001625.1140255-6-fallentree@fb.com>
 <1c6e9434-4bd4-ebf1-9ea9-f4439c8974be@iogearbox.net>
In-Reply-To: <1c6e9434-4bd4-ebf1-9ea9-f4439c8974be@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 10 Aug 2021 09:25:09 -0700
Message-ID: <CAEf4BzY0=e6PrJGsaOgutWmH=JRvmROv8x7BOVXTKNjj0CbcCg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 5/5] Record all failed tests and output after
 the summary line.
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Yucong Sun <fallentree@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, sunyucong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 10, 2021 at 4:23 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 8/10/21 2:16 AM, Yucong Sun wrote:
> > This patch records all failed tests and subtests during the run, output
> > them after the summary line, making it easier to identify failed tests
> > in the long output.
> >
> > Signed-off-by: Yucong Sun <fallentree@fb.com>
>
> nit: please prefix all $subjects with e.g. 'bpf, selftests:'. for example, here should
> be 'bpf, selftests: Record all failed tests and output after the summary line' so it's
> more clear in the git log which subsystem is meant.

Thank, Daniel, for catching this!

We've more or less consistently used these prefixes (with the emphasis
on "more or less", of course):

1. 'bpf:', for BPF-related kernel proper patches
2. 'libbpf:', for libbpf patches
3. 'selftests/bpf:'. for BPF selftests
4. 'bpftool:', for bpftool-specific patches
5. 'samples/bpf', for, you guessed it, samples/bpf :)

I don't know how much value it is to record this convention in our
docs Q&A doc, but it's worth keeping this convention consistent.

Haven't checked the logic of this patch yet, but thought I'll comment
on this convention (and a minor styling nit below).

>
> > ---
> >   tools/testing/selftests/bpf/test_progs.c | 25 +++++++++++++++++++++++-
> >   tools/testing/selftests/bpf/test_progs.h |  2 ++
> >   2 files changed, 26 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> > index 5cc808992b00..51a70031f07e 100644
> > --- a/tools/testing/selftests/bpf/test_progs.c
> > +++ b/tools/testing/selftests/bpf/test_progs.c
> > @@ -244,6 +244,11 @@ void test__end_subtest()
> >              test->test_num, test->subtest_num, test->subtest_name,
> >              sub_error_cnt ? "FAIL" : (test->skip_cnt ? "SKIP" : "OK"));
> >
> > +     if (sub_error_cnt) {
> > +             fprintf(env.summary_errors, "#%d/%d %s: FAIL\n",
> > +                     test->test_num, test->subtest_num, test->subtest_name);
> > +     }
> > +
> >       if (sub_error_cnt)
> >               env.fail_cnt++;
> >       else if (test->skip_cnt == 0)
> > @@ -816,6 +821,10 @@ int main(int argc, char **argv)
> >               .sa_flags = SA_RESETHAND,
> >       };
> >       int err, i;
> > +     /* record errors to print after summary line */
> > +     char *summary_errors_buf;
> > +     size_t summary_errors_cnt;
> > +
> >
>
> nit: double newline
>
> >       sigaction(SIGSEGV, &sigact, NULL);
> >
> > @@ -823,6 +832,9 @@ int main(int argc, char **argv)
> >       if (err)
> >               return err;
> >
> > +     env.summary_errors = open_memstream(
> > +             &summary_errors_buf, &summary_errors_cnt);
>
> Test for env.summary_errors being NULL missing.
>
> > +
> >       err = cd_flavor_subdir(argv[0]);
> >       if (err)
> >               return err;
> > @@ -891,6 +903,11 @@ int main(int argc, char **argv)
> >                       test->test_num, test->test_name,
> >                       test->error_cnt ? "FAIL" : "OK");
> >
> > +             if(test->error_cnt) {

styling nit: if<space>(

please run checkpatches.pl before submitting patches

> > +                     fprintf(env.summary_errors, "#%d %s: FAIL\n",
> > +                             test->test_num, test->test_name);
> > +             }
> > +
> >               reset_affinity();
> >               restore_netns();
> >               if (test->need_cgroup_cleanup)
> > @@ -908,9 +925,14 @@ int main(int argc, char **argv)
> >       if (env.list_test_names)
> >               goto out;
> >
> > -     fprintf(stdout, "Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
> > +     fprintf(stdout, "\nSummary: %d/%d PASSED, %d SKIPPED, %d FAILED\n\n",
> >               env.succ_cnt, env.sub_succ_cnt, env.skip_cnt, env.fail_cnt);
> >
> > +     fclose(env.summary_errors);
> > +     if(env.fail_cnt) {
> > +             fprintf(stdout, "%s", summary_errors_buf);
> > +     }
> > +
> >   out:
> >       free_str_set(&env.test_selector.blacklist);
> >       free_str_set(&env.test_selector.whitelist);
> > @@ -919,6 +941,7 @@ int main(int argc, char **argv)
> >       free_str_set(&env.subtest_selector.whitelist);
> >       free(env.subtest_selector.num_set);
> >       close(env.saved_netns_fd);
> > +     free(summary_errors_buf);
> >
> >       if (env.succ_cnt + env.fail_cnt + env.skip_cnt == 0)
> >               return EXIT_NO_TEST;
> > diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
> > index c8c2bf878f67..63f4e534c6e5 100644
> > --- a/tools/testing/selftests/bpf/test_progs.h
> > +++ b/tools/testing/selftests/bpf/test_progs.h
> > @@ -82,6 +82,8 @@ struct test_env {
> >       int skip_cnt; /* skipped tests */
> >
> >       int saved_netns_fd;
> > +
> > +     FILE* summary_errors;
>
> nit: FILE *summary_errors;
>
> >   };
> >
> >   extern struct test_env env;
> >
>
