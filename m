Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583516AD703
	for <lists+bpf@lfdr.de>; Tue,  7 Mar 2023 06:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjCGF4y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 00:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjCGF4x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 00:56:53 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FBA4391F
        for <bpf@vger.kernel.org>; Mon,  6 Mar 2023 21:56:52 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id t1so4061521iln.8
        for <bpf@vger.kernel.org>; Mon, 06 Mar 2023 21:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678168611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdFUJP8auJcAum98WqbkN3RrlWKERy7l6pk30sSpaQM=;
        b=RZMwuMT4gRG2QRPmzR0BlIAwYe5pUEwoNyPJ6MQz6Wa8fI5AOssQYGAlPh3Z7dpb5M
         kSxHWSYQZYD7LGs8fcuAn3q8cT8GclGqqatHbAPGi0sDKmzFJS7p+hPreav552iYqSpF
         atbagOts1h3yOCeEBmFLdMoZWmG+8OsTmpUa3tvPlVCYuL4FGYIm4HkfI/tGC/NDvPFz
         Oa1YjdCIoOsrdY61uq6rUuZTzZUhLOTFYb2+O5+/5YIaKunxJHU2Tfg3oThh1fcYZ//3
         aDA6obEsMfHILb19ormZjEd7MUe21G5YcYhLe4EiGu1vQplrs4/+pNoq+nEHAwXKqs8W
         w7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678168611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DdFUJP8auJcAum98WqbkN3RrlWKERy7l6pk30sSpaQM=;
        b=QRnW2oQHVpmDGMhei0k8xZ2gHnFHrWoyzdTzFv2+K0eUx1YqDjcboLDMBpZFBALTwc
         Vhu3pODJZMiE1O0G+kcBzkNb9cYmsSkxW5p9FjMq6mxPrWLRQeYa+hEcr1h30jj6B0lg
         f5tFl4oJ6P9uAXuWzNWyYSfq8ttLbMXwqSek5o5NAnoiswgY/+jT3BuggH5qSZEoiG/0
         6h8lBzH0BcS8rhPEuKZYBirOrG9qhrlAKKrZK0xaHylt+nHq08l0bT77Yhdyu1UNAXlk
         nnyNuhgZqt9jaP8curtvk1Sxa9mNzXozO9Zal1Pf1J9cryJCL+GMxf9yycQ0JfRIK2c0
         ST2g==
X-Gm-Message-State: AO0yUKUfKRsNmhowNFkIEoUk7el99H/vsuDZj403GnaNV4yaG5lfExEk
        w8zasG+LKfjWHcUA6dEDyQoyU6uE6A0TC1jdP7kRxdtXst93q8THF67f6A==
X-Google-Smtp-Source: AK7set84Nh7fXJIVBG1ArRivoVuXOmQgaXW71J5OeyLaDH9u1JveraRZNirZlGjSdzSCTaN+BqQpaMxEwZBWqMLzLtY=
X-Received: by 2002:a05:6e02:1111:b0:315:5d89:fb2c with SMTP id
 u17-20020a056e02111100b003155d89fb2cmr8929860ilk.2.1678168610887; Mon, 06 Mar
 2023 21:56:50 -0800 (PST)
MIME-Version: 1.0
References: <20230307032117.3461008-1-irogers@google.com> <CAM9d7ci6FWx2oYAbqhVW2-tjB4p8ji3w87n-ndwxidMov+kVZw@mail.gmail.com>
In-Reply-To: <CAM9d7ci6FWx2oYAbqhVW2-tjB4p8ji3w87n-ndwxidMov+kVZw@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 6 Mar 2023 21:56:38 -0800
Message-ID: <CAP-5=fUQNimNSKjwZaCASyikjXJXBZdw7Z=APYEB4RyX-dXMfQ@mail.gmail.com>
Subject: Re: [PATCH] perf lock contention: Fix builtin detection
To:     Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 6, 2023 at 8:43=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hi Ian,
>
> On Mon, Mar 6, 2023 at 7:21 PM Ian Rogers <irogers@google.com> wrote:
> >
> > __has_builtin was passed the macro rather than the actual builtin
> > feature.
>
> Oh, I missed it's a macro define in tools/lib/bpf/bpf_core_read.h file.
>
> Looking at some BPF test codes, it seems you also need to check the
> clang compiler version.  Please take a look at the file below:
>
>   tools/testing/selftests/bpf/progs/test_core_reloc_type_base.c
>
> Thanks,
> Namhyung

Hmm..

tools/testing/selftests/bpf/progs/test_core_reloc_kernel.c:
...
       /* Support for the BPF_TYPE_MATCHES argument to the
        * __builtin_preserve_type_info builtin was added at some point duri=
ng
        * development of clang 15 and it's what we require for this test.
        */
#if __has_builtin(__builtin_preserve_type_info) && __clang_major__ >=3D 15
...

I'm not sure we need to worry about development clang builds and just
the __has_builtin is cleaner. Perhaps the BPF folks can chime in.

Thanks,
Ian

> >
> > Fixes: 1bece1351c65 ("perf lock contention: Support old rw_semaphore ty=
pe")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/bpf_skel/lock_contention.bpf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/per=
f/util/bpf_skel/lock_contention.bpf.c
> > index e6007eaeda1a..e422eee0f942 100644
> > --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > @@ -182,7 +182,7 @@ static inline struct task_struct *get_lock_owner(__=
u64 lock, __u32 flags)
> >                 struct mutex *mutex =3D (void *)lock;
> >                 owner =3D BPF_CORE_READ(mutex, owner.counter);
> >         } else if (flags =3D=3D LCB_F_READ || flags =3D=3D LCB_F_WRITE)=
 {
> > -#if __has_builtin(bpf_core_type_matches)
> > +#if __has_builtin(__builtin_preserve_type_info)
> >                 if (bpf_core_type_matches(struct rw_semaphore___old)) {
> >                         struct rw_semaphore___old *rwsem =3D (void *)lo=
ck;
> >                         owner =3D (unsigned long)BPF_CORE_READ(rwsem, o=
wner);
> > --
> > 2.40.0.rc0.216.gc4246ad0f0-goog
> >
