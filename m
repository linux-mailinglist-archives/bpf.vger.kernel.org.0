Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678536B2BFC
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 18:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjCIRZL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 12:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjCIRZF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 12:25:05 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21D2F4014;
        Thu,  9 Mar 2023 09:25:03 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id da10so10050050edb.3;
        Thu, 09 Mar 2023 09:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678382702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrmnCwuqDBkKBTp5toyLRDgxwMb1mUSNwOKGOvXrNk8=;
        b=YbMFQAN2CFlTRt/shmKFWoDHH43IVpYQv0SdPfm1P0UfpM2c2rY0m3J7N4tG0Q/3UO
         niA4MqgL3o1TfWqbVSuZw0qSG5yX9f+bmGbnMokP/7KExMkIA98ymyTOQ/TIvY7X6rdK
         F8j6/zYdxi8fVdjAkOL/jFjnbZWAOC2JsHX8CcLoMBshIkRXczOq/4+yIr/zybGd9bqF
         +TRHSx1dsz7z/cG8zSds+BYnz5wMl7LfB5NnbZuUDz/n49I8gPt+FqiApPYgOqmjCENu
         HGblFwoYSg0zMZGTRJRn+SMCYkpkd6fTebC4OoFtA6+EWvzczM8WI3Sib8AGBHg8zXSb
         BgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678382702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HrmnCwuqDBkKBTp5toyLRDgxwMb1mUSNwOKGOvXrNk8=;
        b=UjkLqanfSQcAzP56BTY0AU93/1AQgH3OmsGHm7NIWBVZx/fV4aYqCMCFbQmgFVL5HF
         52+SnRS01lp8C/4mpjOY5yI76gDhBjUMmx3lPqG6xzi4+8d+TtKWqGO2AYrZcrwQt3hK
         gETmFU0UIXpBQDGymY89w5tktInt1WWJfzwOzNscblxQCXQ6M8uWduERCaTgjj5Ehe7J
         75PEbKiNdJK547fuB7KL/2pCQQpurkuo7W4bwW5r42SJ6omis2OQBMx7sKrD0fzxG8pN
         hMTWObwik2vzrTk9tFXNhvVMY1QGnI8e/TNyaSe82aa/nN4t1V+qdInE+Ze2/wG4YmdS
         Xn0A==
X-Gm-Message-State: AO0yUKWsHaEWHtokfzVlvFcHa6G5Nmbhk67SGSw9LwXU/QjdTifKLdgj
        y9YkS4l1a/AR1sYascnJtv1XW3avzzrPZbEq3/c=
X-Google-Smtp-Source: AK7set9+WAM2tkUR3P8z1o6OwFcOvtGcpMNZO6wiOAEM0Wf7cKJqwCUv8lccj1cA/eicaCLfU57xRkIAGSrSIMk1IdM=
X-Received: by 2002:a17:906:6dc1:b0:8b1:76b8:9834 with SMTP id
 j1-20020a1709066dc100b008b176b89834mr11537033ejt.5.1678382702071; Thu, 09 Mar
 2023 09:25:02 -0800 (PST)
MIME-Version: 1.0
References: <20230116010115.490713-1-irogers@google.com> <CAP-5=fVUgc8xtBzGi66YRUxZHyXvW2kiMjGz39dywaLxrO4Hpg@mail.gmail.com>
 <Y8mAuDvs566zwG67@kernel.org> <Y8myfqy5EMit3Kr/@krava> <CAP-5=fUugnKd=pGpZve7tKThhM5b0AqGMnuiELF+fZQw-xJz9w@mail.gmail.com>
 <ZAmRjk1x4p4TrFb0@gentoo.org>
In-Reply-To: <ZAmRjk1x4p4TrFb0@gentoo.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 9 Mar 2023 09:24:50 -0800
Message-ID: <CAEf4BzZJvEnWdTKVSgdBDr_KEgkW5HLHc7N-HRkmb-drCbg2uw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Assume libbpf 1.0+
To:     Guilherme Amadio <amadio@gentoo.org>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <olsajiri@gmail.com>,
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

On Wed, Mar 8, 2023 at 11:58=E2=80=AFPM Guilherme Amadio <amadio@gentoo.org=
> wrote:
>
> On Wed, Mar 08, 2023 at 06:13:34PM -0800, Ian Rogers wrote:
> > On Thu, Jan 19, 2023 at 1:13=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> =
wrote:
> > >
> > > On Thu, Jan 19, 2023 at 02:41:12PM -0300, Arnaldo Carvalho de Melo wr=
ote:
> > > > Em Thu, Jan 19, 2023 at 09:11:03AM -0800, Ian Rogers escreveu:
> > > > > On Sun, Jan 15, 2023 at 5:01 PM Ian Rogers <irogers@google.com> w=
rote:
> > > > > > libbpf 1.0 was a major change in API. Perf has partially suppor=
ted
> > > > > > older libbpf's but an implementation may be:
> > > > > > ..
> > > > > >        pr_err("%s: not support, update libbpf\n", __func__);
> > > > > >        return -ENOTSUP;
> > > > > > ..
> > > > > >
> > > > > > Rather than build a binary that would fail at runtime it is
> > > > > > preferrential just to build libbpf statically and link against
> > > > > > that. The static version is in the kernel tools tree and newer =
than
> > > > > > 1.0.
> > > > > >
> > > > > > These patches change the libbpf test to only pass when at least
> > > > > > version 1.0 is installed, then remove the conditional build and
> > > > > > feature logic.
> > > > > >
> > > > > > The issue is discussed here:
> > > > > > https://lore.kernel.org/lkml/20230106151320.619514-1-irogers@go=
ogle.com/
> > > > > > perf bpf:
> > > > > >
> > > > > > A variant of this fix was added to Linux 6.2 in:
> > > > > > "perf bpf: Avoid build breakage with libbpf < 0.8.0 + LIBBPF_DY=
NAMIC=3D1"
> > > > > > https://lore.kernel.org/lkml/Y71+eh00Ju7WeEFX@kernel.org/
> > > > > > This change goes further in removing logic that is now no longe=
r
> > > > > > necessary.
> > > > > >
> > > > > > v2. Rebase now that breakage fix patch is in linus/master.
> > > > >
> > > > > I missed the:
> > > > > Acked/Tested-by: Jiri Olsa <jolsa@kernel.org>
> > > > > I believe we are waiting for package maintainer input.
> > > >
> > > > Yes, as fedora:37 still is at libbpf 0.8.0 :-\
> > >
> > > rawhide (f38) is already on 1.1.0 ... I'll check how bad it'd be to m=
ove
> > > f37 to 1.x, but I had to do bulk update of like 10 other dependent pa=
ckages
> > > for f38, so not sure how bad it'd be for f37
> > >
> > > jirka
> >
> > +Guilherme
> >
> > We were looking for maintainer input on these changes, but there is no
> > update in over a month. Here is the original lore link:
> > https://lore.kernel.org/lkml/CAP-5=3DfVUgc8xtBzGi66YRUxZHyXvW2kiMjGz39d=
ywaLxrO4Hpg@mail.gmail.com/
> > Should these changes land in perf-tools-next targeting Linux 6.4?
>
> Gentoo has libbpf-1.1 already available, so requiring >libbpf-1.0 is not
> a problem. We (Gentoo) just need to make sure to stabilize libbpf-1.x bef=
ore
> stabilizing newer versions of perf, as the stable libbpf is 0.8.1 at the =
moment.
>

libbpf v0.8 is basically all the 1.0 APIs, except by default 1.0
semantics is not enforced, unless libbpf_set_strict_mode() is enabled.

So, if 0.8 is a restriction, perf can stay on 0.8, use all the same
APIs that are in 1.0 (except newer one added later, but I'm not sure
perf needs any of the newer additions), and just stick to setting
libbpf_set_strict_mode() unconditionally.


> Best regards,
> -Guilherme
>
