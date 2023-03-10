Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8808E6B39E7
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 10:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjCJJPM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 04:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjCJJOO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 04:14:14 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67669D1AD2;
        Fri, 10 Mar 2023 01:09:23 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id t25-20020a1c7719000000b003eb052cc5ccso5473884wmi.4;
        Fri, 10 Mar 2023 01:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678439362;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/UTh6kAyCKG6AZ+y68ZyBnqZnlhdEQTeB5V0SbFr7TA=;
        b=ANgE7fCJ4StvLJ7eCNORUzR/dzSDuvrawlpZoNhZ+muiMHn6reTH0SD8FiVAsmC6Bj
         69tesI0H5xjgLofxTgQPa3PPB+gudfNcKFpzPBihbucHikLC0T0krH9/kVM7z4e3qlGg
         Hg3m3MlR/WPryKE6DbJLuDHWnIQV8pipjlcCmTHFX15ELAm1mvR5AIqHNlUF5ax4usI1
         gk+KqxF10cBuNOUTF3pbkWzXFpbl4zq9BelOKREcgVL+OS2wMphJpFVyeCyExjAVNT+G
         04mdW/WVvZQ9tz8eaAZ4RDcCbBvvk/kpRkYjuLdcnHV9uSgbqGc9tmcLdXZriotuxAtZ
         KKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678439362;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/UTh6kAyCKG6AZ+y68ZyBnqZnlhdEQTeB5V0SbFr7TA=;
        b=1VSvO4cX3FrH46z+YmCkbOwgcJaXZqn68YHN7oRsT/IZrkvD8/PD4Lk2LmCTxVOhiP
         vbVdXDs3vgHuO/Y0oWETi5FekL2fxTIOVJTdPqGddgwqFfT6YBG1NLpOJDuJtZvqAUvL
         g+UdJuNRSJbjafYZJpXvMzZJfJuttOABb4plsUB+n9v2GKvx1dCJeeEogCvgxW1Qqxiv
         eaFIWaygmOciSCL9rpRPtTdHOaochrQBww1QiEz8j+MJDoY7pEPUKA7okOwFfOgLWVq/
         nZyA4Oj/Xk9mn4zeAJgOz1AtQ881PJyap87uSQt0aIGJEVZmblr+zpwrY1xQTjIwc/8e
         TpVg==
X-Gm-Message-State: AO0yUKVt7Yw4TEnWNniFUKaCG6EJTi0p9cWPReIyLJ1xCd0cU98sfz7w
        Z1JJxFspcPtPOkbbzf54Mfc=
X-Google-Smtp-Source: AK7set8Z7FBgGiZrIwOZC+VIZ+uHMMzNIkO3id365fsicLezhFCLrErwVqS51FXqWy6nPSnNqLJ2Tw==
X-Received: by 2002:a1c:770b:0:b0:3e9:b2f2:27a9 with SMTP id t11-20020a1c770b000000b003e9b2f227a9mr1941366wmi.14.1678439361562;
        Fri, 10 Mar 2023 01:09:21 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-8b88-53b7-c55c-8535.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:8b88:53b7:c55c:8535])
        by smtp.gmail.com with ESMTPSA id n22-20020a7bc5d6000000b003eaf666cbe0sm1502073wmk.27.2023.03.10.01.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 01:09:21 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 10 Mar 2023 10:09:18 +0100
To:     Ian Rogers <irogers@google.com>,
        "Justin M. Forbes" <jforbes@fedoraproject.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
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
Subject: Re: [PATCH v2 0/3] Assume libbpf 1.0+
Message-ID: <ZArzvpnRyJatVSHR@krava>
References: <20230116010115.490713-1-irogers@google.com>
 <CAP-5=fVUgc8xtBzGi66YRUxZHyXvW2kiMjGz39dywaLxrO4Hpg@mail.gmail.com>
 <Y8mAuDvs566zwG67@kernel.org>
 <Y8myfqy5EMit3Kr/@krava>
 <CAP-5=fUugnKd=pGpZve7tKThhM5b0AqGMnuiELF+fZQw-xJz9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUugnKd=pGpZve7tKThhM5b0AqGMnuiELF+fZQw-xJz9w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 08, 2023 at 06:13:34PM -0800, Ian Rogers wrote:
> On Thu, Jan 19, 2023 at 1:13 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Thu, Jan 19, 2023 at 02:41:12PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Thu, Jan 19, 2023 at 09:11:03AM -0800, Ian Rogers escreveu:
> > > > On Sun, Jan 15, 2023 at 5:01 PM Ian Rogers <irogers@google.com> wrote:
> > > > > libbpf 1.0 was a major change in API. Perf has partially supported
> > > > > older libbpf's but an implementation may be:
> > > > > ..
> > > > >        pr_err("%s: not support, update libbpf\n", __func__);
> > > > >        return -ENOTSUP;
> > > > > ..
> > > > >
> > > > > Rather than build a binary that would fail at runtime it is
> > > > > preferrential just to build libbpf statically and link against
> > > > > that. The static version is in the kernel tools tree and newer than
> > > > > 1.0.
> > > > >
> > > > > These patches change the libbpf test to only pass when at least
> > > > > version 1.0 is installed, then remove the conditional build and
> > > > > feature logic.
> > > > >
> > > > > The issue is discussed here:
> > > > > https://lore.kernel.org/lkml/20230106151320.619514-1-irogers@google.com/
> > > > > perf bpf:
> > > > >
> > > > > A variant of this fix was added to Linux 6.2 in:
> > > > > "perf bpf: Avoid build breakage with libbpf < 0.8.0 + LIBBPF_DYNAMIC=1"
> > > > > https://lore.kernel.org/lkml/Y71+eh00Ju7WeEFX@kernel.org/
> > > > > This change goes further in removing logic that is now no longer
> > > > > necessary.
> > > > >
> > > > > v2. Rebase now that breakage fix patch is in linus/master.
> > > >
> > > > I missed the:
> > > > Acked/Tested-by: Jiri Olsa <jolsa@kernel.org>
> > > > I believe we are waiting for package maintainer input.
> > >
> > > Yes, as fedora:37 still is at libbpf 0.8.0 :-\
> >
> > rawhide (f38) is already on 1.1.0 ... I'll check how bad it'd be to move
> > f37 to 1.x, but I had to do bulk update of like 10 other dependent packages
> > for f38, so not sure how bad it'd be for f37
> >
> > jirka
> 
> +Guilherme
> 
> We were looking for maintainer input on these changes, but there is no
> update in over a month. Here is the original lore link:
> https://lore.kernel.org/lkml/CAP-5=fVUgc8xtBzGi66YRUxZHyXvW2kiMjGz39dywaLxrO4Hpg@mail.gmail.com/
> Should these changes land in perf-tools-next targeting Linux 6.4?

ugh, I did not include Justin :-\ sry

Justin,
we are trying to move perf to use libbpf 1.0 only, which is fine for fedora 38,
but fedora 37 is still on libbpf 0.8 (and it's not easy to do the bulk update)

would fedora 37 even get to sync 6.4 kernel/kernel-tools?

thanks,
jirka

> 
> Thanks,
> Ian
> 
> > >
> > > This is what I have in the containers I test, sure, the older ones
> > > already have NO_LIBBPF=1 and some will get this added, and some I still
> > > need to ask for libbpf-devel (or the distro specific name, like
> > > libbpf-dev):
> > >
> > > [perfbuilder@five ~]$ podman images --format "{{.Repository}}:{{.Tag}}" | grep /acmel/ | grep -v '<none>' | sort -t: -Vk1,2 | grep -v -- -x- | while read image ; do echo -n $image: ; libbpf=$(podman run --rm -t --entrypoint=ls $image -la /usr/lib64/libbpf.so.1) ; echo $libbpf ; done
> > > localhost/acmel/linux-perf-tools-build-almalinux:8:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > localhost/acmel/linux-perf-tools-build-almalinux:9:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > localhost/acmel/linux-perf-tools-build-alpine:3.12:ls: /usr/lib64/libbpf.so.1: No such file or directory
> > > localhost/acmel/linux-perf-tools-build-alpine:3.13:ls: /usr/lib64/libbpf.so.1: No such file or directory
> > > localhost/acmel/linux-perf-tools-build-alpine:3.14:ls: /usr/lib64/libbpf.so.1: No such file or directory
> > > localhost/acmel/linux-perf-tools-build-alpine:3.15:ls: /usr/lib64/libbpf.so.1: No such file or directory
> > > localhost/acmel/linux-perf-tools-build-alpine:3.16:ls: /usr/lib64/libbpf.so.1: No such file or directory
> > > localhost/acmel/linux-perf-tools-build-alpine:3.17:ls: /usr/lib64/libbpf.so.1: No such file or directory
> > > localhost/acmel/linux-perf-tools-build-alpine:edge:ls: /usr/lib64/libbpf.so.1: No such file or directory
> > > localhost/acmel/linux-perf-tools-build-alt:p9:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > localhost/acmel/linux-perf-tools-build-alt:p10:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > localhost/acmel/linux-perf-tools-build-alt:sisyphus:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > localhost/acmel/linux-perf-tools-build-amazonlinux:2:ls: cannot access /usr/lib64/libbpf.so.1: No such file or directory
> > > localhost/acmel/linux-perf-tools-build-amazonlinux:devel:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > localhost/acmel/linux-perf-tools-build-archlinux:base:lrwxrwxrwx 1 root root 15 Oct 1 12:32 /usr/lib64/libbpf.so.1 -> libbpf.so.1.0.1
> > > localhost/acmel/linux-perf-tools-build-centos:8:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > localhost/acmel/linux-perf-tools-build-centos:stream:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > localhost/acmel/linux-perf-tools-build-clearlinux:latest:lrwxrwxrwx 1 root root 15 Sep 30 16:01 /usr/lib64/libbpf.so.1 -> libbpf.so.1.0.1
> > > localhost/acmel/linux-perf-tools-build-debian:10:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > localhost/acmel/linux-perf-tools-build-debian:11:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > localhost/acmel/linux-perf-tools-build-debian:experimental:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > localhost/acmel/linux-perf-tools-build-fedora:26:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > localhost/acmel/linux-perf-tools-build-fedora:27:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > localhost/acmel/linux-perf-tools-build-fedora:28:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > localhost/acmel/linux-perf-tools-build-fedora:29:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > localhost/acmel/linux-perf-tools-build-fedora:30:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > localhost/acmel/linux-perf-tools-build-fedora:31:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > localhost/acmel/linux-perf-tools-build-fedora:32:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > localhost/acmel/linux-perf-tools-build-fedora:33:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > localhost/acmel/linux-perf-tools-build-fedora:34:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > localhost/acmel/linux-perf-tools-build-fedora:35:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > localhost/acmel/linux-perf-tools-build-fedora:36:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > localhost/acmel/linux-perf-tools-build-fedora:37:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > localhost/acmel/linux-perf-tools-build-fedora:38:lrwxrwxrwx. 1 root root 15 Dec 20 14:39 /usr/lib64/libbpf.so.1 -> libbpf.so.1.0.0
> > > localhost/acmel/linux-perf-tools-build-fedora:rawhide:lrwxrwxrwx. 1 root root 15 Dec 20 14:39 /usr/lib64/libbpf.so.1 -> libbpf.so.1.0.0
> > > localhost/acmel/linux-perf-tools-build-gentoo-stage3:latest:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > localhost/acmel/linux-perf-tools-build-manjaro:base:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > localhost/acmel/linux-perf-tools-build-opensuse:15.0:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > localhost/acmel/linux-perf-tools-build-opensuse:15.1:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > localhost/acmel/linux-perf-tools-build-opensuse:15.2:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > localhost/acmel/linux-perf-tools-build-opensuse:15.3:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > localhost/acmel/linux-perf-tools-build-opensuse:15.4:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > localhost/acmel/linux-perf-tools-build-opensuse:15.5:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > localhost/acmel/linux-perf-tools-build-opensuse:tumbleweed:lrwxrwxrwx. 1 root root 15 Nov 9 12:08 /usr/lib64/libbpf.so.1 -> libbpf.so.1.0.1
> > > localhost/acmel/linux-perf-tools-build-oraclelinux:8:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > localhost/acmel/linux-perf-tools-build-oraclelinux:9:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > localhost/acmel/linux-perf-tools-build-rockylinux:8:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > localhost/acmel/linux-perf-tools-build-rockylinux:9:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > localhost/acmel/linux-perf-tools-build-ubuntu:18.04:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > localhost/acmel/linux-perf-tools-build-ubuntu:20.04:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > localhost/acmel/linux-perf-tools-build-ubuntu:21.04:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > localhost/acmel/linux-perf-tools-build-ubuntu:21.10:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > localhost/acmel/linux-perf-tools-build-ubuntu:22.04:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > localhost/acmel/linux-perf-tools-build-ubuntu:22.10:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > localhost/acmel/linux-perf-tools-build-ubuntu:23.04:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> > > [perfbuilder@five ~]$
> > >
> > > [perfbuilder@five linux-perf-tools-build]$ grep libbpf-dev */*/Dockerfile
> > > debian/experimental/Dockerfile:       libbpf-dev \
> > > fedora/35/Dockerfile:            libtraceevent-devel libbpf-devel \
> > > fedora/36/Dockerfile:            libtraceevent-devel libbpf-devel \
> > > fedora/37/Dockerfile:            libtraceevent-devel libbpf-devel \
> > > fedora/38/Dockerfile:            libtraceevent-devel libbpf-devel \
> > > fedora/rawhide/Dockerfile:    libtraceevent-devel libbpf-devel \
> > > opensuse/tumbleweed/Dockerfile:       libbpf-devel libtraceevent-devel \
> > > ubuntu/22.04/Dockerfile:      libelf-dev libiberty-dev libdw-dev libaudit-dev libtraceevent-dev libbpf-dev \
> > > ubuntu/22.10/Dockerfile:      libelf-dev libiberty-dev libdw-dev libaudit-dev libtraceevent-dev libbpf-dev \
> > > ubuntu/23.04/Dockerfile:      libelf-dev libiberty-dev libdw-dev libaudit-dev libtraceevent-dev libbpf-dev \
> > > [perfbuilder@five linux-perf-tools-build]$
> > >
> > > In some cases it gets dragged on differently, like with clearlinux,
> > > gentoo, archlinux, etc.
> > >
> > > Anyway, just a data point, I'll check if I'm missing installing it
> > > somewhere.
> > >
> > > - Arnaldo
