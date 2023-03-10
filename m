Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9D76B4302
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 15:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjCJOJo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 09:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjCJOJZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 09:09:25 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD2B12041
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 06:08:48 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id z42so5367076ljq.13
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 06:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1678457325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IeEXk67wIJ913Y7z/KttI6cUkRX+27x8mHj5WiM1k8k=;
        b=ROnut0mKL3kWff2v2cdQiEIdeHLJhXRjDMwrmQxP4z1+hGJH2xF8MWAz87QbXHszRC
         dAipsLC3zGnZlUL79Xi5sH9DNACGOnOh9zxxX9fSreg9HlAM6uR+2MIiPfOIjnZsFrEr
         FWBI3hAuSXuGGOuqgizL72kD4aezIlFiD1GyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678457325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IeEXk67wIJ913Y7z/KttI6cUkRX+27x8mHj5WiM1k8k=;
        b=aXp+KSCaO0823M2FfmJKqrDUsHtH0f+7ZjnAqTAZFshhfNAlcUvrF+fBbkT4uIAtca
         p6pUgHJU869z2WEnJTwLFfRq37eFDkZY14KjA7Tnz6tJocpJVczJfCC4dcsqqDv6s/6/
         wakD6AkWknZdM4tvJIYfvqi3kcWOjX35MJ1/OXibvTvZgZYBGj/O6U5m5Q9uEFSGJod8
         HTraPeFp10zxd48obUHSgX+teNkaEa08afrqD1+Z5WNfIq2e+VYXZomDdxnt0CePb0EN
         vPyIwbewDBMaX15ltX8cbabnbMj4W07Cn4VIZ3ywwMlxWPmqObYDZPwFbu/L1rT2TRfH
         +l3g==
X-Gm-Message-State: AO0yUKU2IzYMArJc1QZf/GAoFaxz/4TUhVJ8yu4eHRidHYBA1AtWxcP3
        yKk1zj8PzlURP4eJiXbTiXOVCx0sJXtieTG/2o3zEQ==
X-Google-Smtp-Source: AK7set8Q46zPr6wtlvyNvFfKvE1TMQxEvKpI0U4jpR74IO1MGIEV29WllS53Cx1oXrQPiTJFjPqujg==
X-Received: by 2002:a2e:9019:0:b0:295:74f5:fca9 with SMTP id h25-20020a2e9019000000b0029574f5fca9mr6946665ljg.52.1678457325304;
        Fri, 10 Mar 2023 06:08:45 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id t23-20020a2e9557000000b00298798f7e38sm17555ljh.77.2023.03.10.06.08.44
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 06:08:45 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Received: by mail-lf1-f54.google.com with SMTP id f18so6773316lfa.3
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 06:08:44 -0800 (PST)
X-Received: by 2002:ac2:5934:0:b0:4db:3873:fac1 with SMTP id
 v20-20020ac25934000000b004db3873fac1mr8069058lfi.9.1678457324089; Fri, 10 Mar
 2023 06:08:44 -0800 (PST)
MIME-Version: 1.0
References: <20230116010115.490713-1-irogers@google.com> <CAP-5=fVUgc8xtBzGi66YRUxZHyXvW2kiMjGz39dywaLxrO4Hpg@mail.gmail.com>
 <Y8mAuDvs566zwG67@kernel.org> <Y8myfqy5EMit3Kr/@krava> <CAP-5=fUugnKd=pGpZve7tKThhM5b0AqGMnuiELF+fZQw-xJz9w@mail.gmail.com>
 <ZArzvpnRyJatVSHR@krava>
In-Reply-To: <ZArzvpnRyJatVSHR@krava>
From:   Justin Forbes <jforbes@fedoraproject.org>
Date:   Fri, 10 Mar 2023 08:08:31 -0600
X-Gmail-Original-Message-ID: <CAFbkSA03OoqWbh5v8FLyHBHOhgOTJQL2CPurcGOHpeXgDBbyiw@mail.gmail.com>
Message-ID: <CAFbkSA03OoqWbh5v8FLyHBHOhgOTJQL2CPurcGOHpeXgDBbyiw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Assume libbpf 1.0+
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
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
        Ben Hutchings <ben@decadent.org.uk>,
        Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 10, 2023 at 3:09=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
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
> ugh, I did not include Justin :-\ sry
>
> Justin,
> we are trying to move perf to use libbpf 1.0 only, which is fine for fedo=
ra 38,
> but fedora 37 is still on libbpf 0.8 (and it's not easy to do the bulk up=
date)
>
> would fedora 37 even get to sync 6.4 kernel/kernel-tools?

Yes, Fedora 37 will not EOL until November when F39 has been out for
30 days. It will certainly get 6.4, which should come out this summer.
We could probably do some hackish static link situation for Fedora 37
if necessary though.  It isn't idea, but we know it is short lived, so
I would be okay with making that work.

Justin

> thanks,
> jirka
>
> >
> > Thanks,
> > Ian
> >
> > > >
> > > > This is what I have in the containers I test, sure, the older ones
> > > > already have NO_LIBBPF=3D1 and some will get this added, and some I=
 still
> > > > need to ask for libbpf-devel (or the distro specific name, like
> > > > libbpf-dev):
> > > >
> > > > [perfbuilder@five ~]$ podman images --format "{{.Repository}}:{{.Ta=
g}}" | grep /acmel/ | grep -v '<none>' | sort -t: -Vk1,2 | grep -v -- -x- |=
 while read image ; do echo -n $image: ; libbpf=3D$(podman run --rm -t --en=
trypoint=3Dls $image -la /usr/lib64/libbpf.so.1) ; echo $libbpf ; done
> > > > localhost/acmel/linux-perf-tools-build-almalinux:8:ls: cannot acces=
s '/usr/lib64/libbpf.so.1': No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-almalinux:9:ls: cannot acces=
s '/usr/lib64/libbpf.so.1': No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-alpine:3.12:ls: /usr/lib64/l=
ibbpf.so.1: No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-alpine:3.13:ls: /usr/lib64/l=
ibbpf.so.1: No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-alpine:3.14:ls: /usr/lib64/l=
ibbpf.so.1: No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-alpine:3.15:ls: /usr/lib64/l=
ibbpf.so.1: No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-alpine:3.16:ls: /usr/lib64/l=
ibbpf.so.1: No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-alpine:3.17:ls: /usr/lib64/l=
ibbpf.so.1: No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-alpine:edge:ls: /usr/lib64/l=
ibbpf.so.1: No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-alt:p9:ls: cannot access '/u=
sr/lib64/libbpf.so.1': No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-alt:p10:ls: cannot access '/=
usr/lib64/libbpf.so.1': No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-alt:sisyphus:ls: cannot acce=
ss '/usr/lib64/libbpf.so.1': No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-amazonlinux:2:ls: cannot acc=
ess /usr/lib64/libbpf.so.1: No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-amazonlinux:devel:ls: cannot=
 access '/usr/lib64/libbpf.so.1': No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-archlinux:base:lrwxrwxrwx 1 =
root root 15 Oct 1 12:32 /usr/lib64/libbpf.so.1 -> libbpf.so.1.0.1
> > > > localhost/acmel/linux-perf-tools-build-centos:8:ls: cannot access '=
/usr/lib64/libbpf.so.1': No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-centos:stream:ls: cannot acc=
ess '/usr/lib64/libbpf.so.1': No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-clearlinux:latest:lrwxrwxrwx=
 1 root root 15 Sep 30 16:01 /usr/lib64/libbpf.so.1 -> libbpf.so.1.0.1
> > > > localhost/acmel/linux-perf-tools-build-debian:10:ls: cannot access =
'/usr/lib64/libbpf.so.1': No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-debian:11:ls: cannot access =
'/usr/lib64/libbpf.so.1': No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-debian:experimental:ls: cann=
ot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-fedora:26:ls: cannot access =
'/usr/lib64/libbpf.so.1': No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-fedora:27:ls: cannot access =
'/usr/lib64/libbpf.so.1': No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-fedora:28:ls: cannot access =
'/usr/lib64/libbpf.so.1': No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-fedora:29:ls: cannot access =
'/usr/lib64/libbpf.so.1': No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-fedora:30:ls: cannot access =
'/usr/lib64/libbpf.so.1': No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-fedora:31:ls: cannot access =
'/usr/lib64/libbpf.so.1': No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-fedora:32:ls: cannot access =
'/usr/lib64/libbpf.so.1': No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-fedora:33:ls: cannot access =
'/usr/lib64/libbpf.so.1': No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-fedora:34:ls: cannot access =
'/usr/lib64/libbpf.so.1': No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-fedora:35:ls: cannot access =
'/usr/lib64/libbpf.so.1': No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-fedora:36:ls: cannot access =
'/usr/lib64/libbpf.so.1': No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-fedora:37:ls: cannot access =
'/usr/lib64/libbpf.so.1': No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-fedora:38:lrwxrwxrwx. 1 root=
 root 15 Dec 20 14:39 /usr/lib64/libbpf.so.1 -> libbpf.so.1.0.0
> > > > localhost/acmel/linux-perf-tools-build-fedora:rawhide:lrwxrwxrwx. 1=
 root root 15 Dec 20 14:39 /usr/lib64/libbpf.so.1 -> libbpf.so.1.0.0
> > > > localhost/acmel/linux-perf-tools-build-gentoo-stage3:latest:ls: can=
not access '/usr/lib64/libbpf.so.1': No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-manjaro:base:ls: cannot acce=
ss '/usr/lib64/libbpf.so.1': No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-opensuse:15.0:ls: cannot acc=
ess '/usr/lib64/libbpf.so.1': No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-opensuse:15.1:ls: cannot acc=
ess '/usr/lib64/libbpf.so.1': No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-opensuse:15.2:ls: cannot acc=
ess '/usr/lib64/libbpf.so.1': No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-opensuse:15.3:ls: cannot acc=
ess '/usr/lib64/libbpf.so.1': No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-opensuse:15.4:ls: cannot acc=
ess '/usr/lib64/libbpf.so.1': No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-opensuse:15.5:ls: cannot acc=
ess '/usr/lib64/libbpf.so.1': No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-opensuse:tumbleweed:lrwxrwxr=
wx. 1 root root 15 Nov 9 12:08 /usr/lib64/libbpf.so.1 -> libbpf.so.1.0.1
> > > > localhost/acmel/linux-perf-tools-build-oraclelinux:8:ls: cannot acc=
ess '/usr/lib64/libbpf.so.1': No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-oraclelinux:9:ls: cannot acc=
ess '/usr/lib64/libbpf.so.1': No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-rockylinux:8:ls: cannot acce=
ss '/usr/lib64/libbpf.so.1': No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-rockylinux:9:ls: cannot acce=
ss '/usr/lib64/libbpf.so.1': No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-ubuntu:18.04:ls: cannot acce=
ss '/usr/lib64/libbpf.so.1': No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-ubuntu:20.04:ls: cannot acce=
ss '/usr/lib64/libbpf.so.1': No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-ubuntu:21.04:ls: cannot acce=
ss '/usr/lib64/libbpf.so.1': No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-ubuntu:21.10:ls: cannot acce=
ss '/usr/lib64/libbpf.so.1': No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-ubuntu:22.04:ls: cannot acce=
ss '/usr/lib64/libbpf.so.1': No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-ubuntu:22.10:ls: cannot acce=
ss '/usr/lib64/libbpf.so.1': No such file or directory
> > > > localhost/acmel/linux-perf-tools-build-ubuntu:23.04:ls: cannot acce=
ss '/usr/lib64/libbpf.so.1': No such file or directory
> > > > [perfbuilder@five ~]$
> > > >
> > > > [perfbuilder@five linux-perf-tools-build]$ grep libbpf-dev */*/Dock=
erfile
> > > > debian/experimental/Dockerfile:       libbpf-dev \
> > > > fedora/35/Dockerfile:            libtraceevent-devel libbpf-devel \
> > > > fedora/36/Dockerfile:            libtraceevent-devel libbpf-devel \
> > > > fedora/37/Dockerfile:            libtraceevent-devel libbpf-devel \
> > > > fedora/38/Dockerfile:            libtraceevent-devel libbpf-devel \
> > > > fedora/rawhide/Dockerfile:    libtraceevent-devel libbpf-devel \
> > > > opensuse/tumbleweed/Dockerfile:       libbpf-devel libtraceevent-de=
vel \
> > > > ubuntu/22.04/Dockerfile:      libelf-dev libiberty-dev libdw-dev li=
baudit-dev libtraceevent-dev libbpf-dev \
> > > > ubuntu/22.10/Dockerfile:      libelf-dev libiberty-dev libdw-dev li=
baudit-dev libtraceevent-dev libbpf-dev \
> > > > ubuntu/23.04/Dockerfile:      libelf-dev libiberty-dev libdw-dev li=
baudit-dev libtraceevent-dev libbpf-dev \
> > > > [perfbuilder@five linux-perf-tools-build]$
> > > >
> > > > In some cases it gets dragged on differently, like with clearlinux,
> > > > gentoo, archlinux, etc.
> > > >
> > > > Anyway, just a data point, I'll check if I'm missing installing it
> > > > somewhere.
> > > >
> > > > - Arnaldo
>
