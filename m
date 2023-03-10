Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639AF6B51B8
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 21:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjCJUWv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 15:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjCJUWt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 15:22:49 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E888B12DC02;
        Fri, 10 Mar 2023 12:22:47 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id s11so25354045edy.8;
        Fri, 10 Mar 2023 12:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678479766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORasYKUX0Hwis7sfGua1CSHjFk1HruseacmaBr5a+Uk=;
        b=Xr7tRGNyOBC3CdRyrCHS+ePzgrFutYl2lauA4U2kxId9Ibdtglafm276EA2CQoLa/I
         YWooVbkXjxxC04X9n2QyHRKboB70j3grprJH/fRMAd6IJcrd+5PzlNG9Dts1emyWrtE2
         j0Xcwlv0P1TvrfIHwxilUNtxFHvgMIvv0TmGpl+4JWAWlatyL0g2+o0Ht3RU02DjgI0a
         yLOj2Ua9c5i/nalbwV3k0lFJskYGyBvmT1EAfOfTT20yRDL1b9LEiYtuFCKOP+c406PT
         UjU9Yi1ASE1SZ+ErFPNV525RPdMD15/r/3qR1hnBaH/BKaPsvZqy+ECGYcENp1Z9orIz
         a2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678479766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ORasYKUX0Hwis7sfGua1CSHjFk1HruseacmaBr5a+Uk=;
        b=wrbCJaGl0vNYoPav1VY7YAzBKC8o1lxzuYB3KOC+9xto52086ZrgitMATlJ2EkSYG4
         A2dQS2pIcUZpUGQUzqLVQi6Hpysf95IajsqK/xSs5OMrFt8AP9Qn0y+8BUk+rzW59jpB
         wKXku6b3c1V+JPSqOo8j7JEnXFHm8SoMVFVFl2lINaFIyfX/VpR8L85IquJkON4+K+9c
         F1tIkB1nLC8GKypnJibyZ9Cdrca2+RaWFwgZwrvsCntZrsa7gg1bty9cLzZ+bqutf6+J
         xl+Ke3Zqw9dWFYqgyGYOLmyyIOCSHab+0khMcYrgt7Mmqqr+jV9tNrmM/q1Nx+x0T2mj
         NF9A==
X-Gm-Message-State: AO0yUKU/8zQUSziLa3o1oZElDKEY7tnFZMv0p0aEBotAUSWmcKlGuhvJ
        pLdCryguO+/lyfZVqbE6Z7N8GumLMsb2YR9bPiA=
X-Google-Smtp-Source: AK7set8+IJlquFhRcIll2Sg7NI6g9Rxrd9l9Dplhy9MmVoPi+eOapi1cXygTd87AZKZ9aPUtBON+QV/JWQhpJxTBm+E=
X-Received: by 2002:a17:906:1643:b0:8af:4963:fb08 with SMTP id
 n3-20020a170906164300b008af4963fb08mr13955189ejd.15.1678479766130; Fri, 10
 Mar 2023 12:22:46 -0800 (PST)
MIME-Version: 1.0
References: <20230116010115.490713-1-irogers@google.com> <CAP-5=fVUgc8xtBzGi66YRUxZHyXvW2kiMjGz39dywaLxrO4Hpg@mail.gmail.com>
 <Y8mAuDvs566zwG67@kernel.org> <Y8myfqy5EMit3Kr/@krava> <CAP-5=fUugnKd=pGpZve7tKThhM5b0AqGMnuiELF+fZQw-xJz9w@mail.gmail.com>
 <ZAmRjk1x4p4TrFb0@gentoo.org> <CAEf4BzZJvEnWdTKVSgdBDr_KEgkW5HLHc7N-HRkmb-drCbg2uw@mail.gmail.com>
 <CAP-5=fWvMFXOaKA0bKaKdzYjqOxTCXGapJy-4x34hJyZxqD-Dw@mail.gmail.com>
In-Reply-To: <CAP-5=fWvMFXOaKA0bKaKdzYjqOxTCXGapJy-4x34hJyZxqD-Dw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 10 Mar 2023 12:22:34 -0800
Message-ID: <CAEf4BzZyxyqC1KB3zou46ckf3UvDY9PwgrKdofnPfbhXrN3=XQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Assume libbpf 1.0+
To:     Ian Rogers <irogers@google.com>
Cc:     Guilherme Amadio <amadio@gentoo.org>,
        Jiri Olsa <olsajiri@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andres Freund <andres@anarazel.de>,
        Quentin Monnet <quentin@isovalent.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Michael Petlan <mpetlan@redhat.com>,
        Ben Hutchings <ben@decadent.org.uk>
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

On Thu, Mar 9, 2023 at 7:26=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Thu, Mar 9, 2023 at 9:25=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Mar 8, 2023 at 11:58=E2=80=AFPM Guilherme Amadio <amadio@gentoo=
.org> wrote:
> > >
> > > On Wed, Mar 08, 2023 at 06:13:34PM -0800, Ian Rogers wrote:
> > > > On Thu, Jan 19, 2023 at 1:13=E2=80=AFPM Jiri Olsa <olsajiri@gmail.c=
om> wrote:
> > > > >
> > > > > On Thu, Jan 19, 2023 at 02:41:12PM -0300, Arnaldo Carvalho de Mel=
o wrote:
> > > > > > Em Thu, Jan 19, 2023 at 09:11:03AM -0800, Ian Rogers escreveu:
> > > > > > > On Sun, Jan 15, 2023 at 5:01 PM Ian Rogers <irogers@google.co=
m> wrote:
> > > > > > > > libbpf 1.0 was a major change in API. Perf has partially su=
pported
> > > > > > > > older libbpf's but an implementation may be:
> > > > > > > > ..
> > > > > > > >        pr_err("%s: not support, update libbpf\n", __func__)=
;
> > > > > > > >        return -ENOTSUP;
> > > > > > > > ..
> > > > > > > >
> > > > > > > > Rather than build a binary that would fail at runtime it is
> > > > > > > > preferrential just to build libbpf statically and link agai=
nst
> > > > > > > > that. The static version is in the kernel tools tree and ne=
wer than
> > > > > > > > 1.0.
> > > > > > > >
> > > > > > > > These patches change the libbpf test to only pass when at l=
east
> > > > > > > > version 1.0 is installed, then remove the conditional build=
 and
> > > > > > > > feature logic.
> > > > > > > >
> > > > > > > > The issue is discussed here:
> > > > > > > > https://lore.kernel.org/lkml/20230106151320.619514-1-iroger=
s@google.com/
> > > > > > > > perf bpf:
> > > > > > > >
> > > > > > > > A variant of this fix was added to Linux 6.2 in:
> > > > > > > > "perf bpf: Avoid build breakage with libbpf < 0.8.0 + LIBBP=
F_DYNAMIC=3D1"
> > > > > > > > https://lore.kernel.org/lkml/Y71+eh00Ju7WeEFX@kernel.org/
> > > > > > > > This change goes further in removing logic that is now no l=
onger
> > > > > > > > necessary.
> > > > > > > >
> > > > > > > > v2. Rebase now that breakage fix patch is in linus/master.
> > > > > > >
> > > > > > > I missed the:
> > > > > > > Acked/Tested-by: Jiri Olsa <jolsa@kernel.org>
> > > > > > > I believe we are waiting for package maintainer input.
> > > > > >
> > > > > > Yes, as fedora:37 still is at libbpf 0.8.0 :-\
> > > > >
> > > > > rawhide (f38) is already on 1.1.0 ... I'll check how bad it'd be =
to move
> > > > > f37 to 1.x, but I had to do bulk update of like 10 other dependen=
t packages
> > > > > for f38, so not sure how bad it'd be for f37
> > > > >
> > > > > jirka
> > > >
> > > > +Guilherme
> > > >
> > > > We were looking for maintainer input on these changes, but there is=
 no
> > > > update in over a month. Here is the original lore link:
> > > > https://lore.kernel.org/lkml/CAP-5=3DfVUgc8xtBzGi66YRUxZHyXvW2kiMjG=
z39dywaLxrO4Hpg@mail.gmail.com/
> > > > Should these changes land in perf-tools-next targeting Linux 6.4?
> > >
> > > Gentoo has libbpf-1.1 already available, so requiring >libbpf-1.0 is =
not
> > > a problem. We (Gentoo) just need to make sure to stabilize libbpf-1.x=
 before
> > > stabilizing newer versions of perf, as the stable libbpf is 0.8.1 at =
the moment.
> > >
> >
> > libbpf v0.8 is basically all the 1.0 APIs, except by default 1.0
> > semantics is not enforced, unless libbpf_set_strict_mode() is enabled.
> >
> > So, if 0.8 is a restriction, perf can stay on 0.8, use all the same
> > APIs that are in 1.0 (except newer one added later, but I'm not sure
> > perf needs any of the newer additions), and just stick to setting
> > libbpf_set_strict_mode() unconditionally.
>
> Thanks Andrii,
>

Full disclosure, I'm totally supporting the switch to v1.0+, just
trying to be helpful here from the standpoint of 0.x vs 1.x libbpf
transition. See below. I believe you can keep 0.8+ dependency and drop
all the legacy code completely.

But just take it as an information, and feel free to do whatever you
think is best with it.

> The default perf build is to build against tools/lib/bpf and
> statically link libbpf in. This means by default we have the latest
> libbpf 1.2. If any perf code has a dependency on 0.8 (we don't support
> earlier) we need to #ifdef for it. Currently we have 7 feature tests
> for libbpf, but perhaps there is some cruft that's carried forward.
> The features are:
>  - btf__load_from_kernel_by_id

v0.5 API

>  - bpf_prog_load
>  - bpf_object__next_program
>  - bpf_object__next_map

all three are v0.6 APIs

>  - bpf_program__set_insns

v0.8 API

>  - btf__raw_data
>  - bpf_map_create

both v0.6 API

>
> The not present implementations look like:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools=
/perf/util/bpf-loader.c?h=3Dperf-tools#n36
> ```
> int bpf_program__set_insns(struct bpf_program *prog __maybe_unused,
>   struct bpf_insn *new_insns __maybe_unused, size_t new_insn_cnt __maybe_=
unused)
> {
> pr_err("%s: not support, update libbpf\n", __func__);
> return -ENOTSUP;
> }
>
> int libbpf_register_prog_handler(const char *sec __maybe_unused,
>                                  enum bpf_prog_type prog_type __maybe_unu=
sed,
>                                  enum bpf_attach_type exp_attach_type
> __maybe_unused,
>                                  const struct libbpf_prog_handler_opts
> *opts __maybe_unused)
> {
> pr_err("%s: not support, update libbpf\n", __func__);
> return -ENOTSUP;
> }
> ```

both are v0.8 APIs

> This will basically mean that while you dynamically linked with libbpf
> 0.8 you are in all likelihood not going to get proper BPF support.
> These changes up the version requirement to 1.0 and get rid entirely
> of the feature tests - so no runtime failing implementations. If the

100% supportive on upgrade and dropping feature checks. My point is
that you don't need those feature checks with v0.8+ requirement.

The only difference between staying on v0.8+ vs going all the way to
v1.0+ would be that you have to keep libbpf_set_strict() call. In
v1.0+ it's a noop, so could be dropped.

> build determines at build time libbpf 1.0+ isn't present then it still
> executes, switching from dynamic libbpf to the default static libbpf
> that is at 1.2. As mentioned in this thread, distributions like Debian
> use the default static linking of libbpf.
>

oh, that's nice, good to know

> I'm not keen to hold on to the feature tests for the complexity that
> they hold and their needlessly (as you can always statically link)
> broken at runtime behavior. We could but my opinion is, let's not :-)

I've been consistently advocating for static linking with libbpf, so
100% support this.

>
> Thanks,
> Ian
>
> > > Best regards,
> > > -Guilherme
> > >
