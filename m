Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5FF674431
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 22:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjASVUc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 16:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjASVUC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 16:20:02 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D97AA5CC;
        Thu, 19 Jan 2023 13:13:46 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id ud5so9096914ejc.4;
        Thu, 19 Jan 2023 13:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YkgKBEweuJoBtcSoJVQXp+cGrWKeYRlSSEkuXBn/TRc=;
        b=NmB5k4PwjXDSNszyL9U+RNTtAkeQBklwCe91u0F5mI44znTvQiNSKRARgZniExXlss
         lMQrzM/TbqWvmO4uZ7yycjdM7OLrga87R4C21fGMbOyfFVM9QbFoxBK76Jmfc0rj7YDP
         lSt5iQKwBePD8QeZtliMZLwAnR2Bt4wAJIMpq85R/4M2ZacbYBYlYB6IBLFUhqHRwkTx
         d6KS+pkmDY+D1kI1I40b2sSwFiEHwv5VHWlXh0T0wMJ9hqK5Pw/KfTdhV/1L32QNHgXV
         /p98pLuN132oBw9B+08QziGsExt0gFml6rfInkVVqmfVd7DT0LICtZWTSLyiSOcb7Rr6
         DRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YkgKBEweuJoBtcSoJVQXp+cGrWKeYRlSSEkuXBn/TRc=;
        b=zbqabmS6G6h7UeWVE3TXlCdx8PTIuWCBjjS3UvKct7h0E5//zPgplX1nNmZamks85w
         hwmVqzIqVsr7Clc8oEE90L2PimDwLeNNTWhr//JLuORKvc+E1YaPyHCRdrkG9l8gyEai
         BqGzUqkzqn1BqQoYF8XN/XPAPzJgifWdDJhWLQyUSzqGhjRccEowWwUtm6mNlGSQfNa7
         lrGfBJDmW1uKk73RZ/49UPcX1V71dgTb81H737PrcquOq2GM9nYql6qC2kmofF39VPHj
         M+7+GH58TGff6X7hCBI/CrIOWwsgzCpkNVOcEmKv3JA7FbK7e/AW6Tn/4QWH9sXg0rXX
         w1ug==
X-Gm-Message-State: AFqh2kpEP+prBpv8X86ypK0LGjsTOZA9C/5qS05HJcZRdpPo0RT8FbKl
        4p2FfXXUA5/g6Wu0I1qBtnY=
X-Google-Smtp-Source: AMrXdXuWT1VIH+6NSq5hQquJr3moZJFBW2VjfyKWOoVuxvsojM5tLJxltOvV6+JyemJ77K12KX6Qdg==
X-Received: by 2002:a17:906:34c4:b0:86f:9e4:d13e with SMTP id h4-20020a17090634c400b0086f09e4d13emr12661182ejb.72.1674162820429;
        Thu, 19 Jan 2023 13:13:40 -0800 (PST)
Received: from krava ([83.240.63.129])
        by smtp.gmail.com with ESMTPSA id a23-20020a1709066d5700b008733f1da848sm4208252ejt.170.2023.01.19.13.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 13:13:38 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 19 Jan 2023 22:13:34 +0100
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
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
Subject: Re: [PATCH v2 0/3] Assume libbpf 1.0+
Message-ID: <Y8myfqy5EMit3Kr/@krava>
References: <20230116010115.490713-1-irogers@google.com>
 <CAP-5=fVUgc8xtBzGi66YRUxZHyXvW2kiMjGz39dywaLxrO4Hpg@mail.gmail.com>
 <Y8mAuDvs566zwG67@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8mAuDvs566zwG67@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 19, 2023 at 02:41:12PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jan 19, 2023 at 09:11:03AM -0800, Ian Rogers escreveu:
> > On Sun, Jan 15, 2023 at 5:01 PM Ian Rogers <irogers@google.com> wrote:
> > > libbpf 1.0 was a major change in API. Perf has partially supported
> > > older libbpf's but an implementation may be:
> > > ..
> > >        pr_err("%s: not support, update libbpf\n", __func__);
> > >        return -ENOTSUP;
> > > ..
> > >
> > > Rather than build a binary that would fail at runtime it is
> > > preferrential just to build libbpf statically and link against
> > > that. The static version is in the kernel tools tree and newer than
> > > 1.0.
> > >
> > > These patches change the libbpf test to only pass when at least
> > > version 1.0 is installed, then remove the conditional build and
> > > feature logic.
> > >
> > > The issue is discussed here:
> > > https://lore.kernel.org/lkml/20230106151320.619514-1-irogers@google.com/
> > > perf bpf:
> > >
> > > A variant of this fix was added to Linux 6.2 in:
> > > "perf bpf: Avoid build breakage with libbpf < 0.8.0 + LIBBPF_DYNAMIC=1"
> > > https://lore.kernel.org/lkml/Y71+eh00Ju7WeEFX@kernel.org/
> > > This change goes further in removing logic that is now no longer
> > > necessary.
> > >
> > > v2. Rebase now that breakage fix patch is in linus/master.
> > 
> > I missed the:
> > Acked/Tested-by: Jiri Olsa <jolsa@kernel.org>
> > I believe we are waiting for package maintainer input.
> 
> Yes, as fedora:37 still is at libbpf 0.8.0 :-\

rawhide (f38) is already on 1.1.0 ... I'll check how bad it'd be to move
f37 to 1.x, but I had to do bulk update of like 10 other dependent packages
for f38, so not sure how bad it'd be for f37

jirka

> 
> This is what I have in the containers I test, sure, the older ones
> already have NO_LIBBPF=1 and some will get this added, and some I still
> need to ask for libbpf-devel (or the distro specific name, like
> libbpf-dev):
> 
> [perfbuilder@five ~]$ podman images --format "{{.Repository}}:{{.Tag}}" | grep /acmel/ | grep -v '<none>' | sort -t: -Vk1,2 | grep -v -- -x- | while read image ; do echo -n $image: ; libbpf=$(podman run --rm -t --entrypoint=ls $image -la /usr/lib64/libbpf.so.1) ; echo $libbpf ; done
> localhost/acmel/linux-perf-tools-build-almalinux:8:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> localhost/acmel/linux-perf-tools-build-almalinux:9:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> localhost/acmel/linux-perf-tools-build-alpine:3.12:ls: /usr/lib64/libbpf.so.1: No such file or directory
> localhost/acmel/linux-perf-tools-build-alpine:3.13:ls: /usr/lib64/libbpf.so.1: No such file or directory
> localhost/acmel/linux-perf-tools-build-alpine:3.14:ls: /usr/lib64/libbpf.so.1: No such file or directory
> localhost/acmel/linux-perf-tools-build-alpine:3.15:ls: /usr/lib64/libbpf.so.1: No such file or directory
> localhost/acmel/linux-perf-tools-build-alpine:3.16:ls: /usr/lib64/libbpf.so.1: No such file or directory
> localhost/acmel/linux-perf-tools-build-alpine:3.17:ls: /usr/lib64/libbpf.so.1: No such file or directory
> localhost/acmel/linux-perf-tools-build-alpine:edge:ls: /usr/lib64/libbpf.so.1: No such file or directory
> localhost/acmel/linux-perf-tools-build-alt:p9:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> localhost/acmel/linux-perf-tools-build-alt:p10:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> localhost/acmel/linux-perf-tools-build-alt:sisyphus:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> localhost/acmel/linux-perf-tools-build-amazonlinux:2:ls: cannot access /usr/lib64/libbpf.so.1: No such file or directory
> localhost/acmel/linux-perf-tools-build-amazonlinux:devel:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> localhost/acmel/linux-perf-tools-build-archlinux:base:lrwxrwxrwx 1 root root 15 Oct 1 12:32 /usr/lib64/libbpf.so.1 -> libbpf.so.1.0.1
> localhost/acmel/linux-perf-tools-build-centos:8:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> localhost/acmel/linux-perf-tools-build-centos:stream:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> localhost/acmel/linux-perf-tools-build-clearlinux:latest:lrwxrwxrwx 1 root root 15 Sep 30 16:01 /usr/lib64/libbpf.so.1 -> libbpf.so.1.0.1
> localhost/acmel/linux-perf-tools-build-debian:10:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> localhost/acmel/linux-perf-tools-build-debian:11:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> localhost/acmel/linux-perf-tools-build-debian:experimental:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> localhost/acmel/linux-perf-tools-build-fedora:26:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> localhost/acmel/linux-perf-tools-build-fedora:27:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> localhost/acmel/linux-perf-tools-build-fedora:28:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> localhost/acmel/linux-perf-tools-build-fedora:29:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> localhost/acmel/linux-perf-tools-build-fedora:30:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> localhost/acmel/linux-perf-tools-build-fedora:31:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> localhost/acmel/linux-perf-tools-build-fedora:32:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> localhost/acmel/linux-perf-tools-build-fedora:33:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> localhost/acmel/linux-perf-tools-build-fedora:34:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> localhost/acmel/linux-perf-tools-build-fedora:35:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> localhost/acmel/linux-perf-tools-build-fedora:36:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> localhost/acmel/linux-perf-tools-build-fedora:37:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> localhost/acmel/linux-perf-tools-build-fedora:38:lrwxrwxrwx. 1 root root 15 Dec 20 14:39 /usr/lib64/libbpf.so.1 -> libbpf.so.1.0.0
> localhost/acmel/linux-perf-tools-build-fedora:rawhide:lrwxrwxrwx. 1 root root 15 Dec 20 14:39 /usr/lib64/libbpf.so.1 -> libbpf.so.1.0.0
> localhost/acmel/linux-perf-tools-build-gentoo-stage3:latest:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> localhost/acmel/linux-perf-tools-build-manjaro:base:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> localhost/acmel/linux-perf-tools-build-opensuse:15.0:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> localhost/acmel/linux-perf-tools-build-opensuse:15.1:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> localhost/acmel/linux-perf-tools-build-opensuse:15.2:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> localhost/acmel/linux-perf-tools-build-opensuse:15.3:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> localhost/acmel/linux-perf-tools-build-opensuse:15.4:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> localhost/acmel/linux-perf-tools-build-opensuse:15.5:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> localhost/acmel/linux-perf-tools-build-opensuse:tumbleweed:lrwxrwxrwx. 1 root root 15 Nov 9 12:08 /usr/lib64/libbpf.so.1 -> libbpf.so.1.0.1
> localhost/acmel/linux-perf-tools-build-oraclelinux:8:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> localhost/acmel/linux-perf-tools-build-oraclelinux:9:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> localhost/acmel/linux-perf-tools-build-rockylinux:8:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> localhost/acmel/linux-perf-tools-build-rockylinux:9:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> localhost/acmel/linux-perf-tools-build-ubuntu:18.04:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> localhost/acmel/linux-perf-tools-build-ubuntu:20.04:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> localhost/acmel/linux-perf-tools-build-ubuntu:21.04:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> localhost/acmel/linux-perf-tools-build-ubuntu:21.10:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> localhost/acmel/linux-perf-tools-build-ubuntu:22.04:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> localhost/acmel/linux-perf-tools-build-ubuntu:22.10:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> localhost/acmel/linux-perf-tools-build-ubuntu:23.04:ls: cannot access '/usr/lib64/libbpf.so.1': No such file or directory
> [perfbuilder@five ~]$
> 
> [perfbuilder@five linux-perf-tools-build]$ grep libbpf-dev */*/Dockerfile
> debian/experimental/Dockerfile:	libbpf-dev \
> fedora/35/Dockerfile:		   libtraceevent-devel libbpf-devel \
> fedora/36/Dockerfile:		   libtraceevent-devel libbpf-devel \
> fedora/37/Dockerfile:		   libtraceevent-devel libbpf-devel \
> fedora/38/Dockerfile:		   libtraceevent-devel libbpf-devel \
> fedora/rawhide/Dockerfile:	libtraceevent-devel libbpf-devel \
> opensuse/tumbleweed/Dockerfile:	libbpf-devel libtraceevent-devel \
> ubuntu/22.04/Dockerfile:	libelf-dev libiberty-dev libdw-dev libaudit-dev libtraceevent-dev libbpf-dev \
> ubuntu/22.10/Dockerfile:	libelf-dev libiberty-dev libdw-dev libaudit-dev libtraceevent-dev libbpf-dev \
> ubuntu/23.04/Dockerfile:	libelf-dev libiberty-dev libdw-dev libaudit-dev libtraceevent-dev libbpf-dev \
> [perfbuilder@five linux-perf-tools-build]$
> 
> In some cases it gets dragged on differently, like with clearlinux,
> gentoo, archlinux, etc.
> 
> Anyway, just a data point, I'll check if I'm missing installing it
> somewhere.
> 
> - Arnaldo
