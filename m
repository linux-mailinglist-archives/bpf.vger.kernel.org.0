Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265046B191C
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 03:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjCICN5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 21:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjCICNz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 21:13:55 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC1161A8D
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 18:13:48 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id f14so150086iow.5
        for <bpf@vger.kernel.org>; Wed, 08 Mar 2023 18:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678328028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDCu+k9I5uU9ZeyTijagvPSWTHvVWfU/xHE3X1obRdA=;
        b=dipSQP9U03tyGH9iIucLnZ+CHfS8mkxPYC/AtXJfO832TcuO3QoByvI+6Uci295s7p
         fA2hqBRkCc8bB0ZMgkrGFTYy5k5GBsaopWvkUGyIdT86m6qAPoh5sQ0peVqyaac+44bx
         U8FF94CJ+IDhardjXsj3ub8vOIaAt2oJRTIl5dCD7Lms6O2I51mhkET8WnxJrhLDwl2l
         m82MqiqWrvYwmnP/dd4F0bjz1jby+M/KxfnX0czHLuII+GwHnHDsFwydgj0EaU7Fzg2c
         hlODJfjtSs+xPsbYqL7kTPxOFFOccA7cNgraGGKw0RQFuiEAUe7pgqxJW0LrMahKUuEH
         CKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678328028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDCu+k9I5uU9ZeyTijagvPSWTHvVWfU/xHE3X1obRdA=;
        b=pnOr6VedHQw/GmGFJU9kzUgNQkoYXG2a6smtE8D/FV/uZsawqrUkkDLLxabEBbZuHT
         d5PNIwSYp5/qKpa8u1MRpD++5R3gi0tQ73hUHsFKJXg+COuElSzvJepqu7P0+PBbW7PP
         CTNoCULfKfygk+gzigEhbfEYqYiSX8AKEnPm5KZQHPdS0Ws/hjMKjZAtEP7X7tNm4Y1X
         Cj9kzQjY6vcHZTWo2hgOWghB6OEF1xPC+ZvF2RWqgeb6oCTEZr3iPKsFhuedRDnSFvXs
         rvGFJ2ZmBMuP8s4l9hhD5Pc7nQHPyVz3oPpGoXvPkWbH+ZrXhH3US0A/PfRfAPtxVi7O
         TodQ==
X-Gm-Message-State: AO0yUKUt0lwN7g1WbvIzO81xXcCiN5DAETvMGLFNoq0TWgXlcm1zR6hv
        GtzpZA7QP2lcE13qLZxfCuRfrh5MAyS/pYnGaR9lRQ==
X-Google-Smtp-Source: AK7set+mWq6zJzHt94/3BeSde/daBudUBmiy0DGPNw2z7zo1D94NCuIcD0UN8oAwSxIzMMRpLPMDFnzDPe9ry/6ETaA=
X-Received: by 2002:a6b:dc03:0:b0:74c:7eac:a064 with SMTP id
 s3-20020a6bdc03000000b0074c7eaca064mr9571737ioc.2.1678328027763; Wed, 08 Mar
 2023 18:13:47 -0800 (PST)
MIME-Version: 1.0
References: <20230116010115.490713-1-irogers@google.com> <CAP-5=fVUgc8xtBzGi66YRUxZHyXvW2kiMjGz39dywaLxrO4Hpg@mail.gmail.com>
 <Y8mAuDvs566zwG67@kernel.org> <Y8myfqy5EMit3Kr/@krava>
In-Reply-To: <Y8myfqy5EMit3Kr/@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 8 Mar 2023 18:13:34 -0800
Message-ID: <CAP-5=fUugnKd=pGpZve7tKThhM5b0AqGMnuiELF+fZQw-xJz9w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Assume libbpf 1.0+
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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
        Ben Hutchings <ben@decadent.org.uk>,
        Guilherme Amadio <amadio@gentoo.org>
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

On Thu, Jan 19, 2023 at 1:13=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Jan 19, 2023 at 02:41:12PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Jan 19, 2023 at 09:11:03AM -0800, Ian Rogers escreveu:
> > > On Sun, Jan 15, 2023 at 5:01 PM Ian Rogers <irogers@google.com> wrote=
:
> > > > libbpf 1.0 was a major change in API. Perf has partially supported
> > > > older libbpf's but an implementation may be:
> > > > ..
> > > >        pr_err("%s: not support, update libbpf\n", __func__);
> > > >        return -ENOTSUP;
> > > > ..
> > > >
> > > > Rather than build a binary that would fail at runtime it is
> > > > preferrential just to build libbpf statically and link against
> > > > that. The static version is in the kernel tools tree and newer than
> > > > 1.0.
> > > >
> > > > These patches change the libbpf test to only pass when at least
> > > > version 1.0 is installed, then remove the conditional build and
> > > > feature logic.
> > > >
> > > > The issue is discussed here:
> > > > https://lore.kernel.org/lkml/20230106151320.619514-1-irogers@google=
.com/
> > > > perf bpf:
> > > >
> > > > A variant of this fix was added to Linux 6.2 in:
> > > > "perf bpf: Avoid build breakage with libbpf < 0.8.0 + LIBBPF_DYNAMI=
C=3D1"
> > > > https://lore.kernel.org/lkml/Y71+eh00Ju7WeEFX@kernel.org/
> > > > This change goes further in removing logic that is now no longer
> > > > necessary.
> > > >
> > > > v2. Rebase now that breakage fix patch is in linus/master.
> > >
> > > I missed the:
> > > Acked/Tested-by: Jiri Olsa <jolsa@kernel.org>
> > > I believe we are waiting for package maintainer input.
> >
> > Yes, as fedora:37 still is at libbpf 0.8.0 :-\
>
> rawhide (f38) is already on 1.1.0 ... I'll check how bad it'd be to move
> f37 to 1.x, but I had to do bulk update of like 10 other dependent packag=
es
> for f38, so not sure how bad it'd be for f37
>
> jirka

+Guilherme

We were looking for maintainer input on these changes, but there is no
update in over a month. Here is the original lore link:
https://lore.kernel.org/lkml/CAP-5=3DfVUgc8xtBzGi66YRUxZHyXvW2kiMjGz39dywaL=
xrO4Hpg@mail.gmail.com/
Should these changes land in perf-tools-next targeting Linux 6.4?

Thanks,
Ian

> >
> > This is what I have in the containers I test, sure, the older ones
> > already have NO_LIBBPF=3D1 and some will get this added, and some I sti=
ll
> > need to ask for libbpf-devel (or the distro specific name, like
> > libbpf-dev):
> >
> > [perfbuilder@five ~]$ podman images --format "{{.Repository}}:{{.Tag}}"=
 | grep /acmel/ | grep -v '<none>' | sort -t: -Vk1,2 | grep -v -- -x- | whi=
le read image ; do echo -n $image: ; libbpf=3D$(podman run --rm -t --entryp=
oint=3Dls $image -la /usr/lib64/libbpf.so.1) ; echo $libbpf ; done
> > localhost/acmel/linux-perf-tools-build-almalinux:8:ls: cannot access '/=
usr/lib64/libbpf.so.1': No such file or directory
> > localhost/acmel/linux-perf-tools-build-almalinux:9:ls: cannot access '/=
usr/lib64/libbpf.so.1': No such file or directory
> > localhost/acmel/linux-perf-tools-build-alpine:3.12:ls: /usr/lib64/libbp=
f.so.1: No such file or directory
> > localhost/acmel/linux-perf-tools-build-alpine:3.13:ls: /usr/lib64/libbp=
f.so.1: No such file or directory
> > localhost/acmel/linux-perf-tools-build-alpine:3.14:ls: /usr/lib64/libbp=
f.so.1: No such file or directory
> > localhost/acmel/linux-perf-tools-build-alpine:3.15:ls: /usr/lib64/libbp=
f.so.1: No such file or directory
> > localhost/acmel/linux-perf-tools-build-alpine:3.16:ls: /usr/lib64/libbp=
f.so.1: No such file or directory
> > localhost/acmel/linux-perf-tools-build-alpine:3.17:ls: /usr/lib64/libbp=
f.so.1: No such file or directory
> > localhost/acmel/linux-perf-tools-build-alpine:edge:ls: /usr/lib64/libbp=
f.so.1: No such file or directory
> > localhost/acmel/linux-perf-tools-build-alt:p9:ls: cannot access '/usr/l=
ib64/libbpf.so.1': No such file or directory
> > localhost/acmel/linux-perf-tools-build-alt:p10:ls: cannot access '/usr/=
lib64/libbpf.so.1': No such file or directory
> > localhost/acmel/linux-perf-tools-build-alt:sisyphus:ls: cannot access '=
/usr/lib64/libbpf.so.1': No such file or directory
> > localhost/acmel/linux-perf-tools-build-amazonlinux:2:ls: cannot access =
/usr/lib64/libbpf.so.1: No such file or directory
> > localhost/acmel/linux-perf-tools-build-amazonlinux:devel:ls: cannot acc=
ess '/usr/lib64/libbpf.so.1': No such file or directory
> > localhost/acmel/linux-perf-tools-build-archlinux:base:lrwxrwxrwx 1 root=
 root 15 Oct 1 12:32 /usr/lib64/libbpf.so.1 -> libbpf.so.1.0.1
> > localhost/acmel/linux-perf-tools-build-centos:8:ls: cannot access '/usr=
/lib64/libbpf.so.1': No such file or directory
> > localhost/acmel/linux-perf-tools-build-centos:stream:ls: cannot access =
'/usr/lib64/libbpf.so.1': No such file or directory
> > localhost/acmel/linux-perf-tools-build-clearlinux:latest:lrwxrwxrwx 1 r=
oot root 15 Sep 30 16:01 /usr/lib64/libbpf.so.1 -> libbpf.so.1.0.1
> > localhost/acmel/linux-perf-tools-build-debian:10:ls: cannot access '/us=
r/lib64/libbpf.so.1': No such file or directory
> > localhost/acmel/linux-perf-tools-build-debian:11:ls: cannot access '/us=
r/lib64/libbpf.so.1': No such file or directory
> > localhost/acmel/linux-perf-tools-build-debian:experimental:ls: cannot a=
ccess '/usr/lib64/libbpf.so.1': No such file or directory
> > localhost/acmel/linux-perf-tools-build-fedora:26:ls: cannot access '/us=
r/lib64/libbpf.so.1': No such file or directory
> > localhost/acmel/linux-perf-tools-build-fedora:27:ls: cannot access '/us=
r/lib64/libbpf.so.1': No such file or directory
> > localhost/acmel/linux-perf-tools-build-fedora:28:ls: cannot access '/us=
r/lib64/libbpf.so.1': No such file or directory
> > localhost/acmel/linux-perf-tools-build-fedora:29:ls: cannot access '/us=
r/lib64/libbpf.so.1': No such file or directory
> > localhost/acmel/linux-perf-tools-build-fedora:30:ls: cannot access '/us=
r/lib64/libbpf.so.1': No such file or directory
> > localhost/acmel/linux-perf-tools-build-fedora:31:ls: cannot access '/us=
r/lib64/libbpf.so.1': No such file or directory
> > localhost/acmel/linux-perf-tools-build-fedora:32:ls: cannot access '/us=
r/lib64/libbpf.so.1': No such file or directory
> > localhost/acmel/linux-perf-tools-build-fedora:33:ls: cannot access '/us=
r/lib64/libbpf.so.1': No such file or directory
> > localhost/acmel/linux-perf-tools-build-fedora:34:ls: cannot access '/us=
r/lib64/libbpf.so.1': No such file or directory
> > localhost/acmel/linux-perf-tools-build-fedora:35:ls: cannot access '/us=
r/lib64/libbpf.so.1': No such file or directory
> > localhost/acmel/linux-perf-tools-build-fedora:36:ls: cannot access '/us=
r/lib64/libbpf.so.1': No such file or directory
> > localhost/acmel/linux-perf-tools-build-fedora:37:ls: cannot access '/us=
r/lib64/libbpf.so.1': No such file or directory
> > localhost/acmel/linux-perf-tools-build-fedora:38:lrwxrwxrwx. 1 root roo=
t 15 Dec 20 14:39 /usr/lib64/libbpf.so.1 -> libbpf.so.1.0.0
> > localhost/acmel/linux-perf-tools-build-fedora:rawhide:lrwxrwxrwx. 1 roo=
t root 15 Dec 20 14:39 /usr/lib64/libbpf.so.1 -> libbpf.so.1.0.0
> > localhost/acmel/linux-perf-tools-build-gentoo-stage3:latest:ls: cannot =
access '/usr/lib64/libbpf.so.1': No such file or directory
> > localhost/acmel/linux-perf-tools-build-manjaro:base:ls: cannot access '=
/usr/lib64/libbpf.so.1': No such file or directory
> > localhost/acmel/linux-perf-tools-build-opensuse:15.0:ls: cannot access =
'/usr/lib64/libbpf.so.1': No such file or directory
> > localhost/acmel/linux-perf-tools-build-opensuse:15.1:ls: cannot access =
'/usr/lib64/libbpf.so.1': No such file or directory
> > localhost/acmel/linux-perf-tools-build-opensuse:15.2:ls: cannot access =
'/usr/lib64/libbpf.so.1': No such file or directory
> > localhost/acmel/linux-perf-tools-build-opensuse:15.3:ls: cannot access =
'/usr/lib64/libbpf.so.1': No such file or directory
> > localhost/acmel/linux-perf-tools-build-opensuse:15.4:ls: cannot access =
'/usr/lib64/libbpf.so.1': No such file or directory
> > localhost/acmel/linux-perf-tools-build-opensuse:15.5:ls: cannot access =
'/usr/lib64/libbpf.so.1': No such file or directory
> > localhost/acmel/linux-perf-tools-build-opensuse:tumbleweed:lrwxrwxrwx. =
1 root root 15 Nov 9 12:08 /usr/lib64/libbpf.so.1 -> libbpf.so.1.0.1
> > localhost/acmel/linux-perf-tools-build-oraclelinux:8:ls: cannot access =
'/usr/lib64/libbpf.so.1': No such file or directory
> > localhost/acmel/linux-perf-tools-build-oraclelinux:9:ls: cannot access =
'/usr/lib64/libbpf.so.1': No such file or directory
> > localhost/acmel/linux-perf-tools-build-rockylinux:8:ls: cannot access '=
/usr/lib64/libbpf.so.1': No such file or directory
> > localhost/acmel/linux-perf-tools-build-rockylinux:9:ls: cannot access '=
/usr/lib64/libbpf.so.1': No such file or directory
> > localhost/acmel/linux-perf-tools-build-ubuntu:18.04:ls: cannot access '=
/usr/lib64/libbpf.so.1': No such file or directory
> > localhost/acmel/linux-perf-tools-build-ubuntu:20.04:ls: cannot access '=
/usr/lib64/libbpf.so.1': No such file or directory
> > localhost/acmel/linux-perf-tools-build-ubuntu:21.04:ls: cannot access '=
/usr/lib64/libbpf.so.1': No such file or directory
> > localhost/acmel/linux-perf-tools-build-ubuntu:21.10:ls: cannot access '=
/usr/lib64/libbpf.so.1': No such file or directory
> > localhost/acmel/linux-perf-tools-build-ubuntu:22.04:ls: cannot access '=
/usr/lib64/libbpf.so.1': No such file or directory
> > localhost/acmel/linux-perf-tools-build-ubuntu:22.10:ls: cannot access '=
/usr/lib64/libbpf.so.1': No such file or directory
> > localhost/acmel/linux-perf-tools-build-ubuntu:23.04:ls: cannot access '=
/usr/lib64/libbpf.so.1': No such file or directory
> > [perfbuilder@five ~]$
> >
> > [perfbuilder@five linux-perf-tools-build]$ grep libbpf-dev */*/Dockerfi=
le
> > debian/experimental/Dockerfile:       libbpf-dev \
> > fedora/35/Dockerfile:            libtraceevent-devel libbpf-devel \
> > fedora/36/Dockerfile:            libtraceevent-devel libbpf-devel \
> > fedora/37/Dockerfile:            libtraceevent-devel libbpf-devel \
> > fedora/38/Dockerfile:            libtraceevent-devel libbpf-devel \
> > fedora/rawhide/Dockerfile:    libtraceevent-devel libbpf-devel \
> > opensuse/tumbleweed/Dockerfile:       libbpf-devel libtraceevent-devel =
\
> > ubuntu/22.04/Dockerfile:      libelf-dev libiberty-dev libdw-dev libaud=
it-dev libtraceevent-dev libbpf-dev \
> > ubuntu/22.10/Dockerfile:      libelf-dev libiberty-dev libdw-dev libaud=
it-dev libtraceevent-dev libbpf-dev \
> > ubuntu/23.04/Dockerfile:      libelf-dev libiberty-dev libdw-dev libaud=
it-dev libtraceevent-dev libbpf-dev \
> > [perfbuilder@five linux-perf-tools-build]$
> >
> > In some cases it gets dragged on differently, like with clearlinux,
> > gentoo, archlinux, etc.
> >
> > Anyway, just a data point, I'll check if I'm missing installing it
> > somewhere.
> >
> > - Arnaldo
