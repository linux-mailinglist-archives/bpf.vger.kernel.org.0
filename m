Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A418867402C
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 18:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjASRlb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 12:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjASRlZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 12:41:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327B38F7C6;
        Thu, 19 Jan 2023 09:41:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C10AE61D0C;
        Thu, 19 Jan 2023 17:41:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3785C433F0;
        Thu, 19 Jan 2023 17:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674150078;
        bh=yYK3rkY1Hp0BLfyO/L0impXfxVy7Y9KNMmZ4POG2Sd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ob0xOYrC3n2ycBkWYtPxYSww7yGnmkRqU7Z8o6DmQPwazNT3fB3aIxX+MqlnCoQX2
         O5fYZqdbI5lABjUCLl0MsQOf3zqkNAziJua//nbGD9hpH+R+iSKDjn3d7oYzoCQExs
         q8gXfPvCl8qNIupjlw6w24eUZphds68kQD15vNqcObWs9yjNWSGf0XF92Xr9rsgT/z
         wRV6CJBHJk/iX58QCZvcAMa3nsZYofDYkDqt5UOyq/++C41u075j6YFCEFC2g+CrPb
         ujT4VlvBP0JQUgO59w2sBzQg+MuGE5I2LTbU03RPjiSxn3myUsRvvDn8xmlL8+MWgn
         /GQQVG2R8sdzw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D85C5405BE; Thu, 19 Jan 2023 14:41:12 -0300 (-03)
Date:   Thu, 19 Jan 2023 14:41:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
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
Subject: Re: [PATCH v2 0/3] Assume libbpf 1.0+
Message-ID: <Y8mAuDvs566zwG67@kernel.org>
References: <20230116010115.490713-1-irogers@google.com>
 <CAP-5=fVUgc8xtBzGi66YRUxZHyXvW2kiMjGz39dywaLxrO4Hpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVUgc8xtBzGi66YRUxZHyXvW2kiMjGz39dywaLxrO4Hpg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Jan 19, 2023 at 09:11:03AM -0800, Ian Rogers escreveu:
> On Sun, Jan 15, 2023 at 5:01 PM Ian Rogers <irogers@google.com> wrote:
> > libbpf 1.0 was a major change in API. Perf has partially supported
> > older libbpf's but an implementation may be:
> > ..
> >        pr_err("%s: not support, update libbpf\n", __func__);
> >        return -ENOTSUP;
> > ..
> >
> > Rather than build a binary that would fail at runtime it is
> > preferrential just to build libbpf statically and link against
> > that. The static version is in the kernel tools tree and newer than
> > 1.0.
> >
> > These patches change the libbpf test to only pass when at least
> > version 1.0 is installed, then remove the conditional build and
> > feature logic.
> >
> > The issue is discussed here:
> > https://lore.kernel.org/lkml/20230106151320.619514-1-irogers@google.com/
> > perf bpf:
> >
> > A variant of this fix was added to Linux 6.2 in:
> > "perf bpf: Avoid build breakage with libbpf < 0.8.0 + LIBBPF_DYNAMIC=1"
> > https://lore.kernel.org/lkml/Y71+eh00Ju7WeEFX@kernel.org/
> > This change goes further in removing logic that is now no longer
> > necessary.
> >
> > v2. Rebase now that breakage fix patch is in linus/master.
> 
> I missed the:
> Acked/Tested-by: Jiri Olsa <jolsa@kernel.org>
> I believe we are waiting for package maintainer input.

Yes, as fedora:37 still is at libbpf 0.8.0 :-\

This is what I have in the containers I test, sure, the older ones
already have NO_LIBBPF=1 and some will get this added, and some I still
need to ask for libbpf-devel (or the distro specific name, like
libbpf-dev):

[perfbuilder@five ~]$ podman images --format "{{.Repository}}:{{.Tag}}" | grep /acmel/ | grep -v '<none>' | sort -t: -Vk1,2 | grep -v -- -x- | while read image ; do echo -n $image: ; libbpf=$(podman run --rm -t --entrypoint=ls $image -la /usr/lib64/libbpf.so.1) ; echo $libbpf ; done
localhost/acmel/linux-perf-tools-build-almalinux:8:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
localhost/acmel/linux-perf-tools-build-almalinux:9:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
localhost/acmel/linux-perf-tools-build-alpine:3.12:ls: /usr/lib64/libbpf.so.1: No such file or directory
localhost/acmel/linux-perf-tools-build-alpine:3.13:ls: /usr/lib64/libbpf.so.1: No such file or directory
localhost/acmel/linux-perf-tools-build-alpine:3.14:ls: /usr/lib64/libbpf.so.1: No such file or directory
localhost/acmel/linux-perf-tools-build-alpine:3.15:ls: /usr/lib64/libbpf.so.1: No such file or directory
localhost/acmel/linux-perf-tools-build-alpine:3.16:ls: /usr/lib64/libbpf.so.1: No such file or directory
localhost/acmel/linux-perf-tools-build-alpine:3.17:ls: /usr/lib64/libbpf.so.1: No such file or directory
localhost/acmel/linux-perf-tools-build-alpine:edge:ls: /usr/lib64/libbpf.so.1: No such file or directory
localhost/acmel/linux-perf-tools-build-alt:p9:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
localhost/acmel/linux-perf-tools-build-alt:p10:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
localhost/acmel/linux-perf-tools-build-alt:sisyphus:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
localhost/acmel/linux-perf-tools-build-amazonlinux:2:ls: cannot access /usr/lib64/libbpf.so.1: No such file or directory
localhost/acmel/linux-perf-tools-build-amazonlinux:devel:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
localhost/acmel/linux-perf-tools-build-archlinux:base:lrwxrwxrwx 1 root root 15 Oct 1 12:32 /usr/lib64/libbpf.so.1 -> libbpf.so.1.0.1
localhost/acmel/linux-perf-tools-build-centos:8:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
localhost/acmel/linux-perf-tools-build-centos:stream:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
localhost/acmel/linux-perf-tools-build-clearlinux:latest:lrwxrwxrwx 1 root root 15 Sep 30 16:01 /usr/lib64/libbpf.so.1 -> libbpf.so.1.0.1
localhost/acmel/linux-perf-tools-build-debian:10:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
localhost/acmel/linux-perf-tools-build-debian:11:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
localhost/acmel/linux-perf-tools-build-debian:experimental:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
localhost/acmel/linux-perf-tools-build-fedora:26:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
localhost/acmel/linux-perf-tools-build-fedora:27:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
localhost/acmel/linux-perf-tools-build-fedora:28:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
localhost/acmel/linux-perf-tools-build-fedora:29:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
localhost/acmel/linux-perf-tools-build-fedora:30:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
localhost/acmel/linux-perf-tools-build-fedora:31:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
localhost/acmel/linux-perf-tools-build-fedora:32:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
localhost/acmel/linux-perf-tools-build-fedora:33:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
localhost/acmel/linux-perf-tools-build-fedora:34:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
localhost/acmel/linux-perf-tools-build-fedora:35:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
localhost/acmel/linux-perf-tools-build-fedora:36:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
localhost/acmel/linux-perf-tools-build-fedora:37:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
localhost/acmel/linux-perf-tools-build-fedora:38:lrwxrwxrwx. 1 root root 15 Dec 20 14:39 /usr/lib64/libbpf.so.1 -> libbpf.so.1.0.0
localhost/acmel/linux-perf-tools-build-fedora:rawhide:lrwxrwxrwx. 1 root root 15 Dec 20 14:39 /usr/lib64/libbpf.so.1 -> libbpf.so.1.0.0
localhost/acmel/linux-perf-tools-build-gentoo-stage3:latest:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
localhost/acmel/linux-perf-tools-build-manjaro:base:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
localhost/acmel/linux-perf-tools-build-opensuse:15.0:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
localhost/acmel/linux-perf-tools-build-opensuse:15.1:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
localhost/acmel/linux-perf-tools-build-opensuse:15.2:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
localhost/acmel/linux-perf-tools-build-opensuse:15.3:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
localhost/acmel/linux-perf-tools-build-opensuse:15.4:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
localhost/acmel/linux-perf-tools-build-opensuse:15.5:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
localhost/acmel/linux-perf-tools-build-opensuse:tumbleweed:lrwxrwxrwx. 1 root root 15 Nov 9 12:08 /usr/lib64/libbpf.so.1 -> libbpf.so.1.0.1
localhost/acmel/linux-perf-tools-build-oraclelinux:8:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
localhost/acmel/linux-perf-tools-build-oraclelinux:9:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
localhost/acmel/linux-perf-tools-build-rockylinux:8:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
localhost/acmel/linux-perf-tools-build-rockylinux:9:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
localhost/acmel/linux-perf-tools-build-ubuntu:18.04:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
localhost/acmel/linux-perf-tools-build-ubuntu:20.04:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
localhost/acmel/linux-perf-tools-build-ubuntu:21.04:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
localhost/acmel/linux-perf-tools-build-ubuntu:21.10:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
localhost/acmel/linux-perf-tools-build-ubuntu:22.04:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
localhost/acmel/linux-perf-tools-build-ubuntu:22.10:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
localhost/acmel/linux-perf-tools-build-ubuntu:23.04:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
[perfbuilder@five ~]$

[perfbuilder@five linux-perf-tools-build]$ grep libbpf-dev */*/Dockerfile
debian/experimental/Dockerfile:	libbpf-dev \
fedora/35/Dockerfile:		   libtraceevent-devel libbpf-devel \
fedora/36/Dockerfile:		   libtraceevent-devel libbpf-devel \
fedora/37/Dockerfile:		   libtraceevent-devel libbpf-devel \
fedora/38/Dockerfile:		   libtraceevent-devel libbpf-devel \
fedora/rawhide/Dockerfile:	libtraceevent-devel libbpf-devel \
opensuse/tumbleweed/Dockerfile:	libbpf-devel libtraceevent-devel \
ubuntu/22.04/Dockerfile:	libelf-dev libiberty-dev libdw-dev libaudit-dev libtraceevent-dev libbpf-dev \
ubuntu/22.10/Dockerfile:	libelf-dev libiberty-dev libdw-dev libaudit-dev libtraceevent-dev libbpf-dev \
ubuntu/23.04/Dockerfile:	libelf-dev libiberty-dev libdw-dev libaudit-dev libtraceevent-dev libbpf-dev \
[perfbuilder@five linux-perf-tools-build]$

In some cases it gets dragged on differently, like with clearlinux,
gentoo, archlinux, etc.

Anyway, just a data point, I'll check if I'm missing installing it
somewhere.

- Arnaldo
