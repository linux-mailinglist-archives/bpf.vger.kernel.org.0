Return-Path: <bpf+bounces-59569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D86ACD075
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 02:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EAF57A3D79
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 00:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CC4B661;
	Wed,  4 Jun 2025 00:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0+A6aeeM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8737A53A7
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 00:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748995333; cv=none; b=JM8lV3HhJM2AcSh6oyO6/zO2pCdLZ8cYb+AOyAjlLuKY7rcFDlYqWIvXKkz6JfyQoB2VEZtsY+IZ/oUT7KiMV7HwDtof+aYmBL1+iEsXufbZD44zcAdkeZoRiQGKl3PMe5lf8PLYIPODTW0+DSsShPS5LM7lmlzwyCFRWgITzrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748995333; c=relaxed/simple;
	bh=qvJBhahKOOF54t2U2LU5cR7iRRPjLipXPejMChFrNRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XbJNx480Ujgfdpxk1vafpxi3ZFdotS41mxvgCAKvHQ3cFV9Dd5bBlL1fu8BAxDcQq9kiAGWiPcsJUjmVVXQIFZdLZTSWWpIEGDnTxarl7nKJjgS26f5RjfSMjs+FGVGsJjZxRguaGqbBTpeZvPSkwvZmJZqoGnkqJpTV5FvsObs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0+A6aeeM; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3da76aea6d5so38745ab.1
        for <bpf@vger.kernel.org>; Tue, 03 Jun 2025 17:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748995330; x=1749600130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aby5cmVrQJBl2moPBZcclJIR+UepgzcsOR17H1jYn0o=;
        b=0+A6aeeMN4LsVL4OeE6iKcWGH3+oypky0S4TP7yhcsYdXiA/0UMpccYiWYtZVxPz3r
         YAPKXf2Vzv/5G+pTAv05tnqgWEsVO91pePY6+J8pG8CWTE/pj3/xlXfeGWgG7/hc+2Ix
         BVvnV+PMK93JdlHrPT8pQANNNwPY68Ged4FN7YID11lWHFgjdIFrv4rgne8aXMxxoqyY
         QCwZHlwuSuoONNkFfqbXopkETCS2OGc2DchzR8Q5mBtS3WGicL21e6b5D2AYae6tSAOT
         oIfPjqy5dcv2IKx3b1TL2M/d4RkNbRersmvTWRD6cKQ31QBKRY65i2xJER18810fK5kq
         I6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748995330; x=1749600130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aby5cmVrQJBl2moPBZcclJIR+UepgzcsOR17H1jYn0o=;
        b=fsVvrIwhk1AI/pojbduw3uH2lBJ37PI5Awk9Fkrx/fpNIAcdtpQey7Rz81uxOCn3oC
         vxG2I2WGafOM1PEjEibx8j20++4mBS3Vs/rlYtxYAv7z5dFR76rYpmv4joweToHJMrn8
         NSDcGofY69ov7GeujF3OClUSUoVXfmuDwa0Og3wCmWyoc0lkLNFKRF9w6RAoI+DrxDj1
         QaatRO8W05cfZKrW45leMnb+iyiSDRczpmOL3U5M2Lzza4VJxuTOGy8B7TkfSxZI6rzH
         iBr51uqcsmBh6B+J0ZUSjFNsCYGYdX4cjf0SPMEpJUNhuUsGBSGGOMQ5voTDOjnyWnPX
         X1Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUbBjn1aN0npSV3MrChhIQEI+Sy/mfxtBYBys1s38YLA/+dQwhdNOcVOgLdYgtv1b/Yjbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKOXz/DsBHW1Egn8AXM6o8yjsMXI2pXrkkQqgV8NN576Zf/eOW
	+WSi7UYwxV+AXGVW4RYQ4egN30KfTrNO+4GalvO6SsctoCBgPY6A5BkzpW09d35VTxelv2avPcU
	nYhBjXtWuhRJ0sSJPF/1ElKLK/0ubEGiuZqg/ONuD
X-Gm-Gg: ASbGncsXwxecdeaCdnm9BJek4rvjxB2Jgqkm5Zy7jVFE2IiBXDkcyZOIRayicBNyGkx
	HCC15L4BFC7f20lbYMSy4FaJWvBKC0qRtJaCJ5opbVmDrvyJgtX6BQf/wjt8bmaNMDwRUnjUEPQ
	ShgX9+EgbHM+cSs/mpt60g7EOz4+ffoRxXwehXRm40TXuy/6Q1xhBSoRoFd2zRWEXxaqXh78iP
X-Google-Smtp-Source: AGHT+IGRBEaC9iljAUrrLAP2akvAi/AW9ctkLZcvCkKUrr7Y+LLqUYiret7dfOge83jwcDp5fvbmIbLEqBUrIzZ2+KM=
X-Received: by 2002:a05:6e02:2206:b0:3dd:a7a1:9ee8 with SMTP id
 e9e14a558f8ab-3ddbe7f1abdmr1623805ab.24.1748995330188; Tue, 03 Jun 2025
 17:02:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425214008.176100-1-irogers@google.com> <CAP-5=fXiYHbe9gd_TNyy=txzrd+ONxecnpZr+uPeOnF5XxunGw@mail.gmail.com>
 <aD586_XkeOH2_Fes@google.com> <CAP-5=fUXJ6fW4738Fnx9AK2mPeA74ZpYKv=Ui6wYLWXE3KRRTQ@mail.gmail.com>
 <aD94FJN4Pjsx7exP@google.com> <CAP-5=fX98m+PPkHR2+KdjtJfc0ONMwkjeoCLzjwG_O=5j50=5g@mail.gmail.com>
 <aD-IJRi0n1WGmOFP@google.com>
In-Reply-To: <aD-IJRi0n1WGmOFP@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 3 Jun 2025 17:01:59 -0700
X-Gm-Features: AX0GCFvUrVl-ePFUGbaUjGrjB9pfUjpYtIeqIcvZHSiHt1ERAxwnL_yWNobnNoU
Message-ID: <CAP-5=fUEYqHLYwGWn_BUdk2rZngEVH79=96yVdQT0P+vR6=tQw@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] Move uid filtering to BPF filters
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Veronika Molnarova <vmolnaro@redhat.com>, Hao Ge <gehao@kylinos.cn>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Levi Yun <yeoreum.yun@arm.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 4:41=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Tue, Jun 03, 2025 at 04:22:53PM -0700, Ian Rogers wrote:
> > On Tue, Jun 3, 2025 at 3:32=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> > >
> > > On Mon, Jun 02, 2025 at 11:26:12PM -0700, Ian Rogers wrote:
> > > > On Mon, Jun 2, 2025 at 9:41=E2=80=AFPM Namhyung Kim <namhyung@kerne=
l.org> wrote:
> > > > >
> > > > > Hi Ian,
> > > > >
> > > > > On Tue, May 27, 2025 at 01:39:21PM -0700, Ian Rogers wrote:
> > > > > > On Fri, Apr 25, 2025 at 2:40=E2=80=AFPM Ian Rogers <irogers@goo=
gle.com> wrote:
> > > > > > >
> > > > > > > Rather than scanning /proc and skipping PIDs based on their U=
IDs, use
> > > > > > > BPF filters for uid filtering. The /proc scanning in thread_m=
ap is
> > > > > > > racy as the PID may exit before the perf_event_open causing p=
erf to
> > > > > > > abort. BPF UID filters are more robust as they avoid the race=
. The
> > > > > > > /proc scanning also misses processes starting after the perf
> > > > > > > command. Add a helper for commands that support UID filtering=
 and wire
> > > > > > > up. Remove the non-BPF UID filtering support given it doesn't=
 work.
> > > > > > >
> > > > > > > v3: Add lengthier commit messages as requested by Arnaldo. Re=
base on
> > > > > > >     tmp.perf-tools-next.
> > > > > > >
> > > > > > > v2: Add a perf record uid test (Namhyung) and force setting
> > > > > > >     system-wide for perf trace and perf record (Namhyung). En=
sure the
> > > > > > >     uid filter isn't set on tracepoint evsels.
> > > > > > >
> > > > > > > v1: https://lore.kernel.org/lkml/20250111190143.1029906-1-iro=
gers@google.com/
> > > > > >
> > > > > > Ping. Thanks,
> > > > >
> > > > > I'm ok with preferring BPF over /proc scanning, but still hesitat=
e to
> > > > > remove it since some people don't use BPF.  Can you please drop t=
hat
> > > > > part and make parse_uid_filter() conditional on BPF?
> > > >
> > > > Hi Namhyung,
> > > >
> > > > The approach of scanning /proc fails as:
> > > > 1) processes that start after perf starts will be missed,
> > > > 2) processes that terminate between being scanned in /proc and
> > > > perf_event_open will cause perf to fail (essentially the -u option =
is
> > > > just sugar to scan /proc and then provide the processes as if they
> > > > were a -p option - such an approach doesn't need building into the
> > > > tool).
> > >
> > > Yeah, I remember we had this discussion before.  I think (1) is not t=
rue
> > > as perf events will be inherited to children (but there is a race).
> >
> > If you log in from another terminal? Anything that creates a new
> > process for that user but isn't inherited will be missed, which isn't
> > merely a race.
>
> As long as the another terminal is owned by the same user, any new
> process from the terminal will inherit events, no?
>
> >
> > >  And
> > > (2) is a real problem but it's also about a race and it can succeed.
> > >
> > > Maybe we could change it to skip failed events when the target is a
> > > user but that's not the direction you want.
> >
> > We could have other events and try to discover new processes via them,
> > do things like dummy events to cover races. It is just a lot of
> > complexity for something that is a trivial amount of BPF. In something
> > like 10 years nobody has bothered to fix this up.
>
> I don't want any complex solution for this.  Let's not touch this.
>
> >
> > > >
> > > > This patch series adds a test [1] and perf test has lots of process=
es
> > > > starting and exiting, matching condition (2) above*. If this series
> > > > were changed to an approach that uses BPF and falls back on /proc
> > > > scanning then the -u option would be broken for both reasons above =
but
> > > > also prove a constant source of test flakes.
> > > >
> > > > Rather than give the users something both frustrating to use (keeps
> > > > quitting due to failed opens) and broken (missing processes) I thin=
k
> > > > it is better to quit perf at that point informing the user they nee=
d
> > > > more permissions to load the BPF program. This also makes the -u
> > > > option testable.
> > > >
> > > > So the request for a change I don't think is sensible as it provide=
s a
> > > > worse user and testing experience. There is also the cognitive load=
 of
> > > > having the /proc scanning code in the code base, whereas the BPF
> > > > filter is largely isolated.
> > >
> > > But I think the problem is that it has different requirements - BPF a=
nd
> > > root privilege.  So it should be used after checking the requirements
> > > and fail or fallback.
> > >
> > > Does it print proper error messages if not?  With that we can depreca=
te
> > > the existing behavior and remove it later.
> >
> > For `perf top` with TUI you get an error message in a box of:
> > ```
> > failed to set filter "BPF" on event cpu_atom/cycles/P with 1
> > (Operation not permitted)
> > ```
> > With --stdio you get:
> > ```
> > libbpf: Error in bpf_object__probe_loading(): -EPERM. Couldn't load
> > trivial BPF program. Make sure your kernel supports BPF
> > (CONFIG_BPF_SYSCALL=3Dy) and/or that RLIMIT_MEMLOCK is set to big enoug=
h
> > value.
> > libbpf: failed to load object 'sample_filter_bpf'
> > libbpf: failed to load BPF skeleton 'sample_filter_bpf': -EPERM
> > Failed to load perf sample-filter BPF skeleton
> > failed to set filter "BPF" on event cpu_atom/cycles/P with 1
> > (Operation not permitted)
> > ```
> > This matches the existing behavior if you put a filter on an event.
>
> But that's different as user directly asked the BPF filter.
> The following message would be better (unless you fallback to the old
> behavior).
>
> "-u/--uid option is using BPF filter but perf is not built with BPF.
> Please make sure to build with libbpf and bpf skeletons."
>
> and/or
>
> "-u/--uid option is using BPF filter which requires root privilege."
>
> You may check if the filter program and map is pinned already.

I don't disagree that these error messages would be better, shouldn't
the existing BPF filter code also produce these more user friendly
error messages? Once it does that we can adapt it when the caller is
the '-u' option so that the error message doesn't imply '--filter' was
used?

Thanks,
Ian

> Thanks,
> Namhyung
>

