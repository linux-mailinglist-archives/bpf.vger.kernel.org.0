Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC496F0F27
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 01:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344374AbjD0Xi7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 19:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344305AbjD0Xi5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 19:38:57 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870A6272E
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 16:38:54 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-94f7a7a3351so1749935266b.2
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 16:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682638733; x=1685230733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSL5+ZagBNgA2TzcgmqMrKCYqLWjHQPWRpdWy6ifPPk=;
        b=eLfqq9hKXtsNYEiYKON+fD8pvQRKpBQKN2zrWO0gvZFgC0B7uSaMbtQrbcyId95W27
         B3ofNS/rGnCZcs9Y4A+dtXXylEkEBMbd+tK2AL6bUOk8AnRNZUIIqqNSRNpy40rU5zAM
         Mns9AnGvbdu3CYoPGKueCqgk8F6K/VTYTXoebD1Q1Z6dqCLRauW2qEhy0h4lbPscdCUN
         D3fMyuntFyoCnRQUgc6E8iVQk2f9bR0MIapZNS4MJvx4tMVvmTdI8w0MNQrF+0O8qn8A
         eIi6sapo7AJWIvIkQoPjTdpjU5oqOG5nlNz3gRzOHaGvxdcjZ6OG5p+sKfl15cgLmUmp
         XgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682638733; x=1685230733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSL5+ZagBNgA2TzcgmqMrKCYqLWjHQPWRpdWy6ifPPk=;
        b=DQoSs8vAy1oVsZt+FtMuBQjw1cs8yeVrKVORDsyKetvLftwNmbXjiOlGXzrKf6P7W3
         GeIRNXsXk4GObS/SBWkpTa9COKIZjxI5X9m0WVknYi1XMWrnxa8qNmnGMZOEwpUqiPjD
         eVFEMI5HTRazVNyggw7vC/Kg+vYVjNEJZ1v0tEiF7k1lMTKBP9V07/TmFXKK/J3FGyWX
         iuLbn0Rgtgl4UMdW3LYhdX6Piq1jQ+YOGQuQvoAe2MPTzLEpaQZ4ht9v91+BYnTNu8MD
         +buPsD3QCrTW5gOR9blD7/DfPauwV2LC/VtBLQLk6q1hZ7AjabQ9OGuCLy3R2UIv0L1C
         PI0Q==
X-Gm-Message-State: AC+VfDwU6lXGiR1rLNSbv1f4zwSY2bCR7QsWl7Xf2HlqxB3hzjEnV8aS
        6lxcLBI54NqhVvDvzXy8L5T7YfB5mey1H4D4m3U=
X-Google-Smtp-Source: ACHHUZ6F1HOA8h1SWNZYPpFIOjDRnJeKerqQztCOChK0T3qveDmhTCVUgbTbTfxRPdFU+Od/TJSexXfMSWnYODbcTf8=
X-Received: by 2002:a17:907:948f:b0:94e:5c28:1c19 with SMTP id
 dm15-20020a170907948f00b0094e5c281c19mr3094669ejc.5.1682638733007; Thu, 27
 Apr 2023 16:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230427001425.563232-1-namhyung@kernel.org> <CAEf4BzYs6iD+iE4RZnXTKHhBHCOr9r7AdhsBWWDpivy7sshPKw@mail.gmail.com>
 <CAM9d7ci3xAcnqdkpb-J4rv7yfiB2Trb-e2h7gfj6Wu5N_V7a-Q@mail.gmail.com>
 <CAEf4BzaZhjgPNaNH2yFxjZ-C+ZaSJRg9EWzOCcMOP-CV7kDHBA@mail.gmail.com>
 <ZEn/EOnsH2RP//24@google.com> <CAEf4BzZHS5NprN2ya03Re_1hvC0nNyz_qYEhbD=sGou+m=OWHw@mail.gmail.com>
 <CAM9d7chFp42ar3dMmhHxhHR=CVRg64cMvNQDE98M-EuRmU5EfQ@mail.gmail.com>
In-Reply-To: <CAM9d7chFp42ar3dMmhHxhHR=CVRg64cMvNQDE98M-EuRmU5EfQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 27 Apr 2023 16:38:41 -0700
Message-ID: <CAEf4Bzb6RTmpjC-QhmqxU5K+mSKZ+ng2Z6o1v7b_PmxocaD8zw@mail.gmail.com>
Subject: Re: [HELP] failed to resolve CO-RE relocation
To:     Namhyung Kim <namhyung@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Hao Luo <haoluo@google.com>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 27, 2023 at 4:28=E2=80=AFPM Namhyung Kim <namhyung@gmail.com> w=
rote:
>
> On Thu, Apr 27, 2023 at 3:15=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > Ok, I didn't manage to force compiler to behave as long as
> > `&rq_old->lock` pattern was used. So I went for a different approach.
> > This works:
>
> Thanks!  It works for me too!
>
> Can I use this patch with your Co-developed-by tag ?

of course

>
> Thanks,
> Namhyung
>
>
> >
> > $ git diff
> > diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > index 8911e2a077d8..8d3cfbb3cc65 100644
> > --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > @@ -418,32 +418,32 @@ int contention_end(u64 *ctx)
> >
> >  extern struct rq runqueues __ksym;
> >
> > -struct rq__old {
> > +struct rq___old {
> >         raw_spinlock_t lock;
> >  } __attribute__((preserve_access_index));
> >
> > -struct rq__new {
> > +struct rq___new {
> >         raw_spinlock_t __lock;
> >  } __attribute__((preserve_access_index));
> >
> >  SEC("raw_tp/bpf_test_finish")
> >  int BPF_PROG(collect_lock_syms)
> >  {
> > -       __u64 lock_addr;
> > +       __u64 lock_addr, lock_off;
> >         __u32 lock_flag;
> >
> > +       if (bpf_core_field_exists(struct rq___new, __lock))
> > +               lock_off =3D offsetof(struct rq___new, __lock);
> > +       else
> > +               lock_off =3D offsetof(struct rq___old, lock);
> > +
> >         for (int i =3D 0; i < MAX_CPUS; i++) {
> >                 struct rq *rq =3D bpf_per_cpu_ptr(&runqueues, i);
> > -               struct rq__new *rq_new =3D (void *)rq;
> > -               struct rq__old *rq_old =3D (void *)rq;
> >
> >                 if (rq =3D=3D NULL)
> >                         break;
> >
> > -               if (bpf_core_field_exists(rq_new->__lock))
> > -                       lock_addr =3D (__u64)&rq_new->__lock;
> > -               else
> > -                       lock_addr =3D (__u64)&rq_old->lock;
> > +               lock_addr =3D (__u64)(void *)rq + lock_off;
> >                 lock_flag =3D LOCK_CLASS_RQLOCK;
> >                 bpf_map_update_elem(&lock_syms, &lock_addr,
> > &lock_flag, BPF_ANY);
> >         }
> >
> >
> > > Thanks,
> > > Namhyung
> > >
> > >
