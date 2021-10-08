Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F0C4273ED
	for <lists+bpf@lfdr.de>; Sat,  9 Oct 2021 00:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243552AbhJHWvt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 18:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243505AbhJHWvt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 18:51:49 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4646BC061570
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 15:49:53 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x27so44896821lfa.9
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 15:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8B3ExhlOdE3o7BSPjfW4DgXiAX0XrGly7PtruTHBPPY=;
        b=S1gfnuc5cWG8rDcjL+gfUJe+43tQYbHjQLxnTI/TcviO8fu5FUs1nNFbowUuZjAOx7
         FpucZxP05yfieS4tdZXf36EAEKhiuNOuA59Do0wOix763nIA+Ykxx9p/rH0xVx1ieW6c
         vo9MPHHT5AVviTjVDwRkg06f1VKCeuBaFNc6URt/EBG2hhO3fn/jBEpZPjlrAwjj+Efs
         ISNpTuqEnurWpYxVgWRvKZqaZg31xG8MqnIxlnQqSR+nPYFZA5qYlsF/Ak91VyBG6lGE
         U/7oAqVKAxFnLm3up+F7W714Ngjkmtjbz8wt7054J+3nhRLe7PpPMevRwytP2VA05msx
         h+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8B3ExhlOdE3o7BSPjfW4DgXiAX0XrGly7PtruTHBPPY=;
        b=JEEIrTVmERkf8BghgGK8OQiJgy9KKUxJya0dLd2MGYfCBS9nFavM8lT8ighE491n6W
         zuW0pvUfzQKWZYAhCl4X8ULJaom4+d/KmmzHa8bx4EwNeu+0BW5DasXTdR6qaBHHEoke
         foHbndlo0SYzciGR6o7OkBRLZBnWcn4y5kNZ6WwZo0wnX7ahaL+5cn/uv6QwL5MvWC7N
         2uoBSczDzE9ND0GGyCQV35J58c1r3voUnopsiJl1q/DEqDflYFrTzKv+M4qMamoKsmpf
         DuSw8O8YNnse7R/YF4qoNwtAIfPawuX5rkjD9of0s9XGAb8u92USfujC1GmaIuJXXEMH
         KI9A==
X-Gm-Message-State: AOAM533OhIslJSXYlhA727q7xBcaiRf4H3wtb8qKCeTrAhF7b7rFwdku
        8XJ98A6uq6QAUZVzrOZvy0Xsr7moxGy8cauN3W0=
X-Google-Smtp-Source: ABdhPJwojGuP8p5obQukcGc7TLZJVvOdFeWdRQO9rEoosLXW3ODdmliwytvhvMAZEjNV4kQvGDCNJUTmGzdBqamKDWE=
X-Received: by 2002:a2e:2205:: with SMTP id i5mr6472342lji.242.1633733391414;
 Fri, 08 Oct 2021 15:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <20211006185619.364369-1-fallentree@fb.com> <20211006185619.364369-6-fallentree@fb.com>
 <CAEf4BzaWi5FQsES5C72T6FgPbEdxqAfQGTArovY_d2KS_w6-=Q@mail.gmail.com>
In-Reply-To: <CAEf4BzaWi5FQsES5C72T6FgPbEdxqAfQGTArovY_d2KS_w6-=Q@mail.gmail.com>
From:   "sunyucong@gmail.com" <sunyucong@gmail.com>
Date:   Fri, 8 Oct 2021 15:49:25 -0700
Message-ID: <CAJygYd2hwcKKZsfXa3eM_jT9WmcpUnmNzmkH1eMBU0MZwg=9NA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 05/14] selftests/bpf: adding
 read_perf_max_sample_freq() helper
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yucong Sun <fallentree@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 8, 2021 at 3:27 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Oct 6, 2021 at 11:56 AM Yucong Sun <fallentree@fb.com> wrote:
> >
> > From: Yucong Sun <sunyucong@gmail.com>
> >
> > This patch moved a helper function to test_progs and make all tests
> > setting sampling frequency use it to read current perf_max_sample_freq,
> > this will avoid triggering EINVAL error.
> >
> > Signed-off-by: Yucong Sun <sunyucong@gmail.com>
> > ---
> >  .../selftests/bpf/prog_tests/bpf_cookie.c     |  2 +-
> >  .../selftests/bpf/prog_tests/perf_branches.c  |  4 ++--
> >  .../selftests/bpf/prog_tests/perf_link.c      |  2 +-
> >  .../bpf/prog_tests/stacktrace_build_id_nmi.c  | 19 ++-----------------
> >  tools/testing/selftests/bpf/test_progs.c      | 15 +++++++++++++++
> >  tools/testing/selftests/bpf/test_progs.h      |  1 +
> >  6 files changed, 22 insertions(+), 21 deletions(-)
> >
>
> We have trace_helper.c, seems like it would be better to have it
> there? I haven't applied this patch yet.

I did look at that file, but the content was not really related, so
didn't go with it, of course we can :-D

>
> [...]
>
> > @@ -48,6 +31,8 @@ void test_stacktrace_build_id_nmi(void)
> >         if (CHECK(err, "skel_load", "skeleton load failed: %d\n", err))
> >                 goto cleanup;
> >
> > +       attr.sample_freq = read_perf_max_sample_freq();
> > +
> >         pmu_fd = syscall(__NR_perf_event_open, &attr, -1 /* pid */,
> >                          0 /* cpu 0 */, -1 /* group id */,
> >                          0 /* flags */);
> > diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> > index 2ac922f8aa2c..66825313414b 100644
> > --- a/tools/testing/selftests/bpf/test_progs.c
> > +++ b/tools/testing/selftests/bpf/test_progs.c
> > @@ -1500,3 +1500,18 @@ int main(int argc, char **argv)
> >
> >         return env.fail_cnt ? EXIT_FAILURE : EXIT_SUCCESS;
> >  }
> > +
> > +__u64 read_perf_max_sample_freq(void)
> > +{
> > +       __u64 sample_freq = 1000; /* fallback to 1000 on error */
>
> previous default was 5000, message below still claims 5000, what's the
> The reason for changing it?

This is from my observation that on my machine it frequently dip down
to 3000,  the test doesn't really rely on 5000 either, they were fine
with 1000 even.

>
>
>
> > +       FILE *f;
> > +       __u32 duration = 0;
> > +
> > +       f = fopen("/proc/sys/kernel/perf_event_max_sample_rate", "r");
> > +       if (f == NULL)
> > +               return sample_freq;
> > +       CHECK(fscanf(f, "%llu", &sample_freq) != 1, "Get max sample rate",
> > +             "return default value: 5000,err %d\n", -errno);
> > +       fclose(f);
> > +       return sample_freq;
> > +}
> > diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
> > index b239dc9fcef0..d5ca0d36cc96 100644
> > --- a/tools/testing/selftests/bpf/test_progs.h
> > +++ b/tools/testing/selftests/bpf/test_progs.h
> > @@ -327,6 +327,7 @@ int extract_build_id(char *build_id, size_t size);
> >  int kern_sync_rcu(void);
> >  int trigger_module_test_read(int read_sz);
> >  int trigger_module_test_write(int write_sz);
> > +__u64 read_perf_max_sample_freq(void);
> >
> >  #ifdef __x86_64__
> >  #define SYS_NANOSLEEP_KPROBE_NAME "__x64_sys_nanosleep"
> > --
> > 2.30.2
> >
