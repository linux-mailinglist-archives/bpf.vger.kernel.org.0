Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31FC4943DA
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 00:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344347AbiASX1B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 18:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343864AbiASX07 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Jan 2022 18:26:59 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A28C061574;
        Wed, 19 Jan 2022 15:26:59 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id e79so4846505iof.13;
        Wed, 19 Jan 2022 15:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=twTpEEL71TXTpscf69cFTweDWM0HCgehxL0N3bDgiho=;
        b=oAaHdvqQk7PeYLD0xdkyrQuQqgxHoxSSeNGNK05gcYB24YuuNNbBWFoTMMt2BHY5qt
         78nQBgQwCKFSXJH/lA7FpAOTc5bJ1OM1wv+GfN4yFkJtsDyQLZjy9gDG27c9VgTy5jHq
         oV324cZk0xKPu35t/L2GD/9wcinVKyMJd93c1S+lqalWy6Sp4EJDhy8zp9NSo9xM4fiU
         FBkP56DEmmVpr5CO08Gx8MXwrWpUWacGvpedm5QyRCaqrV7M229QgA3ChL5QPsbV9l+Q
         m/WOdwn4FjNDib7gz0iMZfm6IN7GdyLp8rUwCsYZ0kjtEwoFSYUwh1HJ02mBQwKVJ+ky
         owLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=twTpEEL71TXTpscf69cFTweDWM0HCgehxL0N3bDgiho=;
        b=aIv8ld+DjHLQcRi1dU+SGrjhoH6Sallt1mw1iBCNTjj+B+DF2LxTP870F/7NOWpd6P
         ojWxmKFLybXjbo4XWrz4Mxtf5I0J429kGFEkJmU2OW6QN+uwKKFnVTcqIYL+IsKffY7w
         y4uJsS7JX6HKlscFm6X3Pe71rVQ8loBtPm5JoQJbWRD+AEo0zrh67DfxGDbft5b/zDgU
         4evc/GaKTG1iMy7y9Grx9gwxInOIhr/WctOYpYffqjUmV5EP96+qRLeXbBheep2CorAh
         8RLwJC4DfgJ5M5iY/LHGwmn7WokgxTMBxG9EUnSouo+1lqVy0B2mNg4VotmusrVW9YoN
         /tGg==
X-Gm-Message-State: AOAM533xHBHCHi1zDI1ZD1PP+CrejfnZxjq+IUwAeER7zmMgfef4cxWl
        WWxb8A284LxdKrAJCkh3+vp8p8vrnhEx7YekVJQ=
X-Google-Smtp-Source: ABdhPJyN9zql36ndwhR423euHzYeZgKkqK0EsODbnK+J0J4BREaut1BQk331YEMKClTPfZQb8NMqhsX0XLE1tTOfxno=
X-Received: by 2002:a5d:9f01:: with SMTP id q1mr16891616iot.144.1642634818532;
 Wed, 19 Jan 2022 15:26:58 -0800 (PST)
MIME-Version: 1.0
References: <20220119230636.1752684-1-christylee@fb.com> <20220119230636.1752684-2-christylee@fb.com>
 <C02B00A0-5760-44CE-B727-90CF601A8437@fb.com>
In-Reply-To: <C02B00A0-5760-44CE-B727-90CF601A8437@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 19 Jan 2022 15:26:47 -0800
Message-ID: <CAEf4BzaoqsxOvYsPjC4RX-mL+HsgEP=GsnS5fKm0UZsYvY=Sjw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] perf: stop using deprecated
 bpf_load_program() API
To:     Song Liu <songliubraving@fb.com>
Cc:     "Christy Lee-Eusman (PL&R)" <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        "christyc.y.lee@gmail.com" <christyc.y.lee@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "wangnan0@huawei.com" <wangnan0@huawei.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 19, 2022 at 3:20 PM Song Liu <songliubraving@fb.com> wrote:
>
>
>
> > On Jan 19, 2022, at 3:06 PM, Christy Lee <christylee@fb.com> wrote:
> >
> > bpf_load_program() API is deprecated, remove perf's usage of the
> > deprecated function. Add a __weak function declaration for libbpf
> > version compatibility.
> >
> > Signed-off-by: Christy Lee <christylee@fb.com>
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
> Acked-by: Song Liu <songliubraving@fb.com>
>
> With one minor comment below.
>
> > ---
> > tools/perf/tests/bpf.c      | 14 ++++----------
> > tools/perf/util/bpf-event.c | 16 ++++++++++++++++
> > 2 files changed, 20 insertions(+), 10 deletions(-)
> >
> > diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
> > index 573490530194..57b9591f7cbb 100644
> > --- a/tools/perf/tests/bpf.c
> > +++ b/tools/perf/tests/bpf.c
> > @@ -281,8 +281,8 @@ static int __test__bpf(int idx)
> >
> > static int check_env(void)
> > {
> > +     LIBBPF_OPTS(bpf_prog_load_opts, opts);
>
> This changes seems unnecessary.
>
> >       int err;
> > -     unsigned int kver_int;
> >       char license[] = "GPL";
> >
> >       struct bpf_insn insns[] = {
> > @@ -290,19 +290,13 @@ static int check_env(void)
> >               BPF_EXIT_INSN(),
> >       };
> >
> > -     err = fetch_kernel_version(&kver_int, NULL, 0);
> > +     err = fetch_kernel_version(&opts.kern_version, NULL, 0);

Opts are used here. Libbpf is now performing the same kern_version
extraction logic, so we might not need fetch_kernel_version() now, but
I'd still keep it to avoid unnecessary regressions.


> >       if (err) {
> >               pr_debug("Unable to get kernel version\n");
> >               return err;
> >       }
> > -
> > -/* temporarily disable libbpf deprecation warnings */
> > -#pragma GCC diagnostic push
> > -#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> > -     err = bpf_load_program(BPF_PROG_TYPE_KPROBE, insns,
> > -                            ARRAY_SIZE(insns),
> > -                            license, kver_int, NULL, 0);
> > -#pragma GCC diagnostic pop
> > +     err = bpf_prog_load(BPF_PROG_TYPE_KPROBE, NULL, license, insns,
> > +                         ARRAY_SIZE(insns), &opts);
> >       if (err < 0) {
> >               pr_err("Missing basic BPF support, skip this test: %s\n",
> >                      strerror(errno));
> > diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> > index a517eaa51eb3..48872276c0b7 100644
> > --- a/tools/perf/util/bpf-event.c
> > +++ b/tools/perf/util/bpf-event.c
> > @@ -33,6 +33,22 @@ struct btf * __weak btf__load_from_kernel_by_id(__u32 id)
> >        return err ? ERR_PTR(err) : btf;
> > }
> >
> > +#pragma GCC diagnostic push
> > +#pragma GCC diagnostic ignored "-Wunused-parameter"
> > +int __weak
> > +bpf_prog_load(enum bpf_prog_type prog_type,
> > +             const char *prog_name, const char *license,
> > +             const struct bpf_insn *insns, size_t insn_cnt,
> > +             const struct bpf_prog_load_opts *opts)
> > +{
> > +#pragma GCC diagnostic push
> > +#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> > +     return bpf_load_program(prog_type, insns, insn_cnt, license,
> > +                             opts->kern_version, opts->log_buf, opts->log_size);
> > +#pragma GCC diagnostic pop
> > +}
> > +#pragma GCC diagnostic pop
> > +
> > struct bpf_program * __weak
> > bpf_object__next_program(const struct bpf_object *obj, struct bpf_program *prev)
> > {
> > --
> > 2.30.2
> >
>
