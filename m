Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E325445B25
	for <lists+bpf@lfdr.de>; Thu,  4 Nov 2021 21:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbhKDUgM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Nov 2021 16:36:12 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:37660 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbhKDUgM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Nov 2021 16:36:12 -0400
Received: by mail-lf1-f53.google.com with SMTP id g29so292777lfv.4;
        Thu, 04 Nov 2021 13:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uQrrpLW2waHbZAaA6Nm9BoEIagIh7snWJFFsKEGeS7I=;
        b=IWKGUOM1kFSaTDZBiEdN22rXJDt6aqM/gZX2ak8SLTDcuKe4aajSrSsciBXYJD1yfr
         XeVTm4nO+AGVTuivsqG0OUd0Zk0ckM9kpGqrL8R2ORWMOTc7xvf67D/rxhV1EUPYfyGB
         l6p+YyqoDGglURQ7IdDOGMmt6A9HBAanrJg23Lcd41POlq0Aisf1WUmYUJLiYEzEzwi9
         0WY9Qgibnj2vb/SYoMkGgHfuhTQJcVAZzPDOpLSDS9ks/0OHhOeB9LJwjtTeH0DC3qCO
         0kZhyFGFzPtWxOEIs6IZDVtILurwgd1XAZf1fRad2ghOpMQIPKBHyUWkysAz7m0Fl1cn
         CluA==
X-Gm-Message-State: AOAM530fNmMU5NVlOsj8bvPbPyrR4IvQBRB0FYf2P0HfSm9zfwIIfjvD
        6Cne+gj7owwX6+VmaTbmfoeFmT3WowJRtpCNdqo=
X-Google-Smtp-Source: ABdhPJwCrvV1ZZAS6LaxAZkkbIEhcoghUWZWF6LkATSjTIF57mA77tmz4hNPH5BUTYuaFTAOzaRnJqKIgcQdfQtH4ZY=
X-Received: by 2002:a05:6512:3d0b:: with SMTP id d11mr35570141lfv.481.1636058011424;
 Thu, 04 Nov 2021 13:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <YYQadWbtdZ9Ff9N4@kernel.org> <YYQdKijyt20cBQik@kernel.org>
 <CAEf4BzYtq5Fru0_=Stih+Tjya3i29xG+RSF=4oOT7GbUwVRQaQ@mail.gmail.com>
 <YYQiXnUxlOoWMdwZ@kernel.org> <C940FF7A-A27F-4F56-8659-9365FC4A2EF7@fb.com>
In-Reply-To: <C940FF7A-A27F-4F56-8659-9365FC4A2EF7@fb.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 4 Nov 2021 13:33:20 -0700
Message-ID: <CAM9d7cg9rXKUdEsdGUBSemzSrwE8XsyQtjCM=zT+8P+gs10n=Q@mail.gmail.com>
Subject: Re: perf build broken looking for bpf/{libbpf,bpf}.h after merge with upstream
To:     Song Liu <songliubraving@fb.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

On Thu, Nov 4, 2021 at 11:13 AM Song Liu <songliubraving@fb.com> wrote:
>
>
>
> > On Nov 4, 2021, at 11:11 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > Em Thu, Nov 04, 2021 at 10:56:26AM -0700, Andrii Nakryiko escreveu:
> >> On Thu, Nov 4, 2021 at 10:49 AM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> >
> >>> Em Thu, Nov 04, 2021 at 02:37:57PM -0300, Arnaldo Carvalho de Melo escreveu:
> >>>>
> >>>> Hi Song,
> >>>>
> >>>>      I just did a merge with upstream and I'm getting this:
> >>>>
> >>>>  LINK    /tmp/build/perf/plugins/plugin_scsi.so
> >>>>  INSTALL trace_plugins
> >>>
> >>> To clarify, the command line to build perf that results in this problem
> >>> is:
> >>>
> >>>  make -k BUILD_BPF_SKEL=1 CORESIGHT=1 PYTHON=python3 O=/tmp/build/perf -C tools/perf install-bin
> >>
> >> Oh, I dropped CORESIGN and left BUILD_BPF_SKEL=1 and yeah, I see the
> >> build failure. I do think now that it's related to the recent Makefile
> >> revamp effort. Quentin, PTAL.
> >>
> >> On the side note, why BUILD_BPF_SKEL=1 is not a default, we might have
> >> caught this sooner. Is there any reason not to flip the default?
> >
> > I asked Song in the past about this, and asked again on another reply to
> > this thread, I think it should be the default.
> >
> > Song, Namhyung? You're the skel guys (so far) :-)
>
> Yeah, let's make it default.

Then it'd require 'clang' for the perf build.  Maybe we can check
the availability of the compiler and disable it back if not.

Thanks,
Namhyung
