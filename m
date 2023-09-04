Return-Path: <bpf+bounces-9171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAE479106A
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 05:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95791C20443
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 03:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DDD656;
	Mon,  4 Sep 2023 03:29:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09568635
	for <bpf@vger.kernel.org>; Mon,  4 Sep 2023 03:29:02 +0000 (UTC)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B05BF
	for <bpf@vger.kernel.org>; Sun,  3 Sep 2023 20:29:00 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-414ba610766so134651cf.0
        for <bpf@vger.kernel.org>; Sun, 03 Sep 2023 20:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693798140; x=1694402940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7deoe6GKhFpc+m67Hlb6XpoWBoI8jcvPYFdC1NBI18E=;
        b=f0UkjQPVZLS35/683sE9Topltynn1uueMUc1mXgVROtG2fUvnEOqKtytWKhxUKqEK/
         0aBO9wj74V4uOL5AQaJjklFux7KY9zbz1CHYUWZdHFMRFsxi2CuxOa0JwKXDNtnDKTVz
         CKNWCMCvM/vmplkGAXROVhPBjXHoFFPZwggBVzV+KL7Fh6B4ospjik/PA+6UCV2pOpgi
         rgW1VffOHu6YvVI0PJZJoam9psWp6sEQvXAyFtZS7C2MbuOEW7VEW2TeA1zDPdwvVhvg
         PLaV83ED65i/dyArDeh/xN3ZnZjhtuvUylbha6HaqytWkwTyxxVJecJz+USHcQW06pul
         BeYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693798140; x=1694402940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7deoe6GKhFpc+m67Hlb6XpoWBoI8jcvPYFdC1NBI18E=;
        b=hm2Rw/ljED7M8UvSBM+LcEcciBFJvnklZx4j0GRV6osTFfokpNpDGSqETENZATWI2Q
         s87swJIJFw5KKC5R4MnUK3B/EaE6eSHjp9+zxY+vCDNHbPDqml+KdzXs1GQ/RsKg9q09
         XNX2UwKmqO3QJjzV4GeA0zShGQ2+alwupU6s2dB684nveteetw4aiEPCVPgl+UwdKnKT
         BWaKJpmRkvm//0NE16qVifeJC707J/fUihUC0xI699G3Opt+tZxj88s498nAX54xnJH3
         9WOesPCBfhEm0lekdt3EPkXCu9z6m7LmMsAvTtfRBul0sIa5IoDgAvKEdO571+LwwLvJ
         D+oQ==
X-Gm-Message-State: AOJu0YxiEBSFnjQXd27+L+Lte1CqgJl7BwlQtUMe2Vsq1FzAHPmQBDgw
	tZedENzJDb/V/4VL0hXx9VATPyNpozOa7MEhpOVFtg==
X-Google-Smtp-Source: AGHT+IGpSZA5b0THqLBucCAWJlFUihqilCsAwDngJNJeRAOaion0lQdf4xoRZy/rGwGk+pRPS1y9EbG705O13KUZr6M=
X-Received: by 2002:a05:622a:341:b0:412:7cc4:a0f4 with SMTP id
 r1-20020a05622a034100b004127cc4a0f4mr224747qtw.8.1693798139968; Sun, 03 Sep
 2023 20:28:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230830230126.260508-1-namhyung@kernel.org>
In-Reply-To: <20230830230126.260508-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Sun, 3 Sep 2023 20:28:48 -0700
Message-ID: <CAP-5=fWQGsBBku+vuRpxia8faVkJeR1Rp5PmoAd63LcDM3FYXg@mail.gmail.com>
Subject: Re: [PATCHSET 0/5] perf lock contention: Add cgroup support (v1)
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 30, 2023 at 4:01=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> The cgroup support comes with two flavors.  One is to aggregate the
> result by cgroups and the other is to filter result for the given
> cgroups.  For now, it only works in BPF mode.
>
> The first one is -g/--lock-cgroup option to show lock stats by cgroups
> like below.  The cgroup names were shortened for brevity:
>
>   $ sudo perf lock con -abg perf bench sched messaging
>    contended   total wait     max wait     avg wait   cgroup
>
>         1052      3.34 ms     84.71 us      3.17 us   /app-org.gnome.Term=
inal.slice/vte-spawn-52221fb8-b33f-4a52-b5c3-e35d1e6fc0e0.scope
>           13    106.60 us     11.48 us      8.20 us   /session.slice/org.=
gnome.Shell@x11.service
>           12     21.20 us      4.93 us      1.77 us   /
>            3     12.10 us      8.80 us      4.03 us   /session-4.scope
>            2     10.98 us      7.50 us      5.49 us   /app-gnome-firefox\=
x2desr-34054.scope
>            2      6.04 us      4.88 us      3.02 us   /app-gnome-google\x=
2dchrome-6442.scope
>            1      5.63 us      5.63 us      5.63 us   /app-org.gnome.Term=
inal.slice/gnome-terminal-server.service
>            1      3.51 us      3.51 us      3.51 us   /pipewire.service
>            1      2.15 us      2.15 us      2.15 us   /pipewire-pulse.ser=
vice
>            1       742 ns       742 ns       742 ns   /dbus.service
>
> The other is -G/--cgroup-filter option to show lock stats only from the
> given cgroups.  It doesn't support cgroup hierarchy and regex matching.
>
>   $ sudo perf lock con -abt -G / perf bench sched messaging
>    contended   total wait     max wait     avg wait          pid   comm
>
>            2     10.58 us      8.39 us      5.29 us       257552   kworke=
r/4:1
>            2      9.76 us      7.96 us      4.88 us            0   swappe=
r
>            4      5.36 us      2.09 us      1.34 us       255462   kworke=
r/0:2
>            3      3.33 us      1.48 us      1.11 us       257680   kworke=
r/3:1
>            2      2.59 us      1.46 us      1.29 us       257478   kworke=
r/2:2
>            1      1.50 us      1.50 us      1.50 us           15   rcu_pr=
eempt
>
> You can also use these two options together. :)
>
> The two more test cases were added to the existing lock contention test.
>
> The code is available at 'perf/lock-cgroup-v1' branch in the tree below.
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
>
>
> Thanks,
> Namhyung
>
>
> Namhyung Kim (5):
>   perf tools: Add read_all_cgroups() and __cgroup_find()
>   perf lock contention: Prepare to handle cgroups
>   perf lock contention: Add -g/--lock-cgroup option
>   perf lock contention: Add -G/--cgroup-filter option
>   perf test: Improve perf lock contention test

Series:
Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>  tools/perf/Documentation/perf-lock.txt        |  8 ++
>  tools/perf/builtin-lock.c                     | 99 ++++++++++++++++++-
>  tools/perf/tests/shell/lock_contention.sh     | 45 +++++++++
>  tools/perf/util/bpf_lock_contention.c         | 51 +++++++++-
>  .../perf/util/bpf_skel/lock_contention.bpf.c  | 48 ++++++++-
>  tools/perf/util/bpf_skel/lock_data.h          |  3 +-
>  tools/perf/util/cgroup.c                      | 63 ++++++++++--
>  tools/perf/util/cgroup.h                      |  5 +
>  tools/perf/util/lock-contention.h             | 10 +-
>  9 files changed, 312 insertions(+), 20 deletions(-)
>
>
> base-commit: d2045f87154bf67a50ebefe28d2ca0e1e3f8eef1
> --
> 2.42.0.283.g2d96d420d3-goog
>

