Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51F36B629A
	for <lists+bpf@lfdr.de>; Sun, 12 Mar 2023 02:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjCLBAT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Mar 2023 20:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCLBAT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 11 Mar 2023 20:00:19 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F21F6233F
        for <bpf@vger.kernel.org>; Sat, 11 Mar 2023 17:00:17 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id q16so8306056wrw.2
        for <bpf@vger.kernel.org>; Sat, 11 Mar 2023 17:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678582816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVqViHKN5Yirjh+bmhLj58d+3uxBU5OraeGY1CTO3p0=;
        b=YXV7T+jrhb/oIiO+r59EKktvaQZO116g6QgA/YTIS1RwBA9Ng3/qRalnt1KzZyWwHg
         GltOPQDsulhChZSx8XE9pZfpvmjTx0htL98h+KTh1UiJOdcO0LD0Lzdx1qrSVYC5AHBb
         +RQg9CVa8Ls/92haVTTZtY76yyJv+DrtC/sXhB86Ir3oc9Kf2Hu0ZZYf+LSSCVKQvDra
         Ex5PBhy/Gdak5+UoOvVH8dXaeQEUIRgZ+kDWWbFJhzg4XbyAqR9M75ZmmBkQdZNfpb14
         5+aVaC2ZhEon5BYTJAubMjAGMptIhw3scDnYE5tv56WylYHtK+G8pIjYiUe+vMJXB016
         ugdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678582816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DVqViHKN5Yirjh+bmhLj58d+3uxBU5OraeGY1CTO3p0=;
        b=UTOynxSIs0dUXTeFF/RirhwNh3C+86/YgYbSUpgWE4hm7luQ/cGABoEjofmvqlxl+G
         OA4kiTA0VxkyniQfImElu8zB4VcK7rOi9nTLI2L4E+HLouxg0kgW/hVZsS3Dkl1E/DtW
         zfaID4XGlUpBeeGY8I6bzH8skDNyReorgKupP7G4eEqoBa9x9DLicFnPREOGtmWmd7aq
         bEULWzGrpBLuVA09ZcOcOLRnjDSa86VnXwHtWSwl2InKz27o9Q+AxsL6F0Vnz/yuUAoh
         pZKWBSn8AqbRY560tlh9OgWJKTuN7mr9OtnySFucznt5E/JLEbLtkWzwLlWuTWOcMxrA
         8krQ==
X-Gm-Message-State: AO0yUKVlaPq5l3lsJ9qZQw0zLBo8syfF3rmfc6hQ+8UBK1KnZ2Td7Y8f
        j8oTOqzP0eL/wpkD6MA3H4tdJPpgAG7VPXsS22Y/Ew==
X-Google-Smtp-Source: AK7set9bmHDuF9mllRRV379UiGJDViyqO9cr5DQfcZYcJ4Q1rrezSOAo940mr19FkRZTedMUoNWupL7ppjMO7tjDHuo=
X-Received: by 2002:a5d:46ca:0:b0:2c7:c483:9faa with SMTP id
 g10-20020a5d46ca000000b002c7c4839faamr6639805wrs.14.1678582815821; Sat, 11
 Mar 2023 17:00:15 -0800 (PST)
MIME-Version: 1.0
References: <20230116010115.490713-1-irogers@google.com> <CAP-5=fVUgc8xtBzGi66YRUxZHyXvW2kiMjGz39dywaLxrO4Hpg@mail.gmail.com>
 <Y8mAuDvs566zwG67@kernel.org> <Y8myfqy5EMit3Kr/@krava> <CAP-5=fUugnKd=pGpZve7tKThhM5b0AqGMnuiELF+fZQw-xJz9w@mail.gmail.com>
 <ZAmRjk1x4p4TrFb0@gentoo.org> <CAEf4BzZJvEnWdTKVSgdBDr_KEgkW5HLHc7N-HRkmb-drCbg2uw@mail.gmail.com>
 <CAP-5=fWvMFXOaKA0bKaKdzYjqOxTCXGapJy-4x34hJyZxqD-Dw@mail.gmail.com> <CAEf4BzZyxyqC1KB3zou46ckf3UvDY9PwgrKdofnPfbhXrN3=XQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZyxyqC1KB3zou46ckf3UvDY9PwgrKdofnPfbhXrN3=XQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 11 Mar 2023 17:00:01 -0800
Message-ID: <CAP-5=fWRxM3pVy6YH=gAnyMXgPBx5eShcJMBiGggCdJj23tUtg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Assume libbpf 1.0+
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 10, 2023 at 12:22=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Mar 9, 2023 at 7:26=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > On Thu, Mar 9, 2023 at 9:25=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Mar 8, 2023 at 11:58=E2=80=AFPM Guilherme Amadio <amadio@gent=
oo.org> wrote:
> > > >
> > > > On Wed, Mar 08, 2023 at 06:13:34PM -0800, Ian Rogers wrote:
> > > > > On Thu, Jan 19, 2023 at 1:13=E2=80=AFPM Jiri Olsa <olsajiri@gmail=
.com> wrote:
> > > > > >
> > > > > > On Thu, Jan 19, 2023 at 02:41:12PM -0300, Arnaldo Carvalho de M=
elo wrote:
> > > > > > > Em Thu, Jan 19, 2023 at 09:11:03AM -0800, Ian Rogers escreveu=
:
> > > > > > > > On Sun, Jan 15, 2023 at 5:01 PM Ian Rogers <irogers@google.=
com> wrote:
> > > > > > > > > libbpf 1.0 was a major change in API. Perf has partially =
supported
> > > > > > > > > older libbpf's but an implementation may be:
> > > > > > > > > ..
> > > > > > > > >        pr_err("%s: not support, update libbpf\n", __func_=
_);
> > > > > > > > >        return -ENOTSUP;
> > > > > > > > > ..
> > > > > > > > >
> > > > > > > > > Rather than build a binary that would fail at runtime it =
is
> > > > > > > > > preferrential just to build libbpf statically and link ag=
ainst
> > > > > > > > > that. The static version is in the kernel tools tree and =
newer than
> > > > > > > > > 1.0.
> > > > > > > > >
> > > > > > > > > These patches change the libbpf test to only pass when at=
 least
> > > > > > > > > version 1.0 is installed, then remove the conditional bui=
ld and
> > > > > > > > > feature logic.
> > > > > > > > >
> > > > > > > > > The issue is discussed here:
> > > > > > > > > https://lore.kernel.org/lkml/20230106151320.619514-1-irog=
ers@google.com/
> > > > > > > > > perf bpf:
> > > > > > > > >
> > > > > > > > > A variant of this fix was added to Linux 6.2 in:
> > > > > > > > > "perf bpf: Avoid build breakage with libbpf < 0.8.0 + LIB=
BPF_DYNAMIC=3D1"
> > > > > > > > > https://lore.kernel.org/lkml/Y71+eh00Ju7WeEFX@kernel.org/
> > > > > > > > > This change goes further in removing logic that is now no=
 longer
> > > > > > > > > necessary.
> > > > > > > > >
> > > > > > > > > v2. Rebase now that breakage fix patch is in linus/master=
.
> > > > > > > >
> > > > > > > > I missed the:
> > > > > > > > Acked/Tested-by: Jiri Olsa <jolsa@kernel.org>
> > > > > > > > I believe we are waiting for package maintainer input.
> > > > > > >
> > > > > > > Yes, as fedora:37 still is at libbpf 0.8.0 :-\
> > > > > >
> > > > > > rawhide (f38) is already on 1.1.0 ... I'll check how bad it'd b=
e to move
> > > > > > f37 to 1.x, but I had to do bulk update of like 10 other depend=
ent packages
> > > > > > for f38, so not sure how bad it'd be for f37
> > > > > >
> > > > > > jirka
> > > > >
> > > > > +Guilherme
> > > > >
> > > > > We were looking for maintainer input on these changes, but there =
is no
> > > > > update in over a month. Here is the original lore link:
> > > > > https://lore.kernel.org/lkml/CAP-5=3DfVUgc8xtBzGi66YRUxZHyXvW2kiM=
jGz39dywaLxrO4Hpg@mail.gmail.com/
> > > > > Should these changes land in perf-tools-next targeting Linux 6.4?
> > > >
> > > > Gentoo has libbpf-1.1 already available, so requiring >libbpf-1.0 i=
s not
> > > > a problem. We (Gentoo) just need to make sure to stabilize libbpf-1=
.x before
> > > > stabilizing newer versions of perf, as the stable libbpf is 0.8.1 a=
t the moment.
> > > >
> > >
> > > libbpf v0.8 is basically all the 1.0 APIs, except by default 1.0
> > > semantics is not enforced, unless libbpf_set_strict_mode() is enabled=
.
> > >
> > > So, if 0.8 is a restriction, perf can stay on 0.8, use all the same
> > > APIs that are in 1.0 (except newer one added later, but I'm not sure
> > > perf needs any of the newer additions), and just stick to setting
> > > libbpf_set_strict_mode() unconditionally.
> >
> > Thanks Andrii,
> >
>
> Full disclosure, I'm totally supporting the switch to v1.0+, just
> trying to be helpful here from the standpoint of 0.x vs 1.x libbpf
> transition. See below. I believe you can keep 0.8+ dependency and drop
> all the legacy code completely.
>
> But just take it as an information, and feel free to do whatever you
> think is best with it.
>
> > The default perf build is to build against tools/lib/bpf and
> > statically link libbpf in. This means by default we have the latest
> > libbpf 1.2. If any perf code has a dependency on 0.8 (we don't support
> > earlier) we need to #ifdef for it. Currently we have 7 feature tests
> > for libbpf, but perhaps there is some cruft that's carried forward.
> > The features are:
> >  - btf__load_from_kernel_by_id
>
> v0.5 API
>
> >  - bpf_prog_load
> >  - bpf_object__next_program
> >  - bpf_object__next_map
>
> all three are v0.6 APIs
>
> >  - bpf_program__set_insns
>
> v0.8 API
>
> >  - btf__raw_data
> >  - bpf_map_create
>
> both v0.6 API
>
> >
> > The not present implementations look like:
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/too=
ls/perf/util/bpf-loader.c?h=3Dperf-tools#n36
> > ```
> > int bpf_program__set_insns(struct bpf_program *prog __maybe_unused,
> >   struct bpf_insn *new_insns __maybe_unused, size_t new_insn_cnt __mayb=
e_unused)
> > {
> > pr_err("%s: not support, update libbpf\n", __func__);
> > return -ENOTSUP;
> > }
> >
> > int libbpf_register_prog_handler(const char *sec __maybe_unused,
> >                                  enum bpf_prog_type prog_type __maybe_u=
nused,
> >                                  enum bpf_attach_type exp_attach_type
> > __maybe_unused,
> >                                  const struct libbpf_prog_handler_opts
> > *opts __maybe_unused)
> > {
> > pr_err("%s: not support, update libbpf\n", __func__);
> > return -ENOTSUP;
> > }
> > ```
>
> both are v0.8 APIs
>
> > This will basically mean that while you dynamically linked with libbpf
> > 0.8 you are in all likelihood not going to get proper BPF support.
> > These changes up the version requirement to 1.0 and get rid entirely
> > of the feature tests - so no runtime failing implementations. If the
>
> 100% supportive on upgrade and dropping feature checks. My point is
> that you don't need those feature checks with v0.8+ requirement.
>
> The only difference between staying on v0.8+ vs going all the way to
> v1.0+ would be that you have to keep libbpf_set_strict() call. In
> v1.0+ it's a noop, so could be dropped.
>
> > build determines at build time libbpf 1.0+ isn't present then it still
> > executes, switching from dynamic libbpf to the default static libbpf
> > that is at 1.2. As mentioned in this thread, distributions like Debian
> > use the default static linking of libbpf.
> >
>
> oh, that's nice, good to know
>
> > I'm not keen to hold on to the feature tests for the complexity that
> > they hold and their needlessly (as you can always statically link)
> > broken at runtime behavior. We could but my opinion is, let's not :-)
>
> I've been consistently advocating for static linking with libbpf, so
> 100% support this.

Right, so I think we should move forward with these patches. We also
have had non-API changes to support libbpf 1.0+ like:
https://lore.kernel.org/lkml/20221103045437.163510-4-irogers@google.com/
and I'm worried about the state of these with libbpf 0.8.

Thanks,
Ian

> >
> > Thanks,
> > Ian
> >
> > > > Best regards,
> > > > -Guilherme
> > > >
