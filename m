Return-Path: <bpf+bounces-48880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 241B6A115B3
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 00:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35620168AFB
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 23:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86E3223326;
	Tue, 14 Jan 2025 23:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D+fMDUwD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6312F221D99
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 23:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736898962; cv=none; b=Xqzank1uvqmJal99854/Z1PHml86hFa6EbpunHHHPtnOGPqRW7HUdc1S6/lUzGubOeXfrfglzu6ko1LhmuvzkgoQkb38F8YUrltZ3EYBLloImmWeqJ/ELmLRnXCJg5admYJLmN1lkNZbLsLG6SB6b3tmkaBS9UKp+LrtEm7a7hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736898962; c=relaxed/simple;
	bh=KaALaCaKNmbvVs1ZpCkOxun8jgOb4rPuqBHd/Sf7Ilg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QOIX4bTED84E+6Qmeb7+opEQx5WT3Wh3+wsQBVtIUTg+pjOv8FPSA9TxvpEOBZaNVtfb4XggkdAkQtFa1piB4iiIUcp9aq6fgXDV1iqBO8zrkWjYHpbAkjLrPmSHpjYhKh352VV0QIRdMwozdzWqe8mwq1Xpdjh8yKP9Wa2Z0m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D+fMDUwD; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3ce82195aa0so59445ab.0
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 15:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736898959; x=1737503759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZjztpnGf2/x7CmVk8X85gVhhDvgMNeUrqUQwbwgBRw=;
        b=D+fMDUwDeFvn1Mi0BqT8iHa0kyHA6swwAJvhHAw1XZKtbIoYci3FedVk8RN4GUc2PB
         fynd8HKOoLyih4uiUJ6ccK0fOL7lQu+pLRuwJt3PSJZOBPaAfxfcnj7w7zNqde6X6zMT
         J0l/AqzrQCr3aSZVi/BZ4jciy/3ZDTyW2A9xq/9td0SVQjmSzFYNddwBEFUkIm0xbxzw
         A0tZ7CzxoMqpvxIG7BmY8oDlpaRRtubyXMlhHzyTNOeJ/sKKx4flhXcopsrtaa1ctOCh
         EKgXYFiAb9BdhschbnZfHROOVGG8SDTK8UDfuoPqxIaTBpm33f2mWN3ZsOURh+QHZOHN
         dkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736898959; x=1737503759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZjztpnGf2/x7CmVk8X85gVhhDvgMNeUrqUQwbwgBRw=;
        b=PpJJjoZ5Ai+ezd6sYHZQ0JYwlnY+ridTVyvbpJ3KocRR3xkidk//AP6sm1e7HJpHIA
         VReYYRTEKMcW41lYyQVyxx66Q30YzvNei8DvRiHzsaGrc1j3yM6sm7iaIm+4Fy4/PMeO
         Ui9e09LtElKjrL84fZwSKOGQs6g9zxms27dhidrKpn95zfsGg618Ctm6cifFL8qW+qp2
         4tp5xDP2IOlY+b7zLTRJzPNKSr418AGhZj1Vd9jT9f1W3aBeKopBG5l3Di5uM/BpuVPj
         AQ8M0pArD0/oh7YWrF087vq5VEWghTi8WbEU/YT1+tI3TjJVc/tSd66qfX4gCufldiZw
         SouQ==
X-Forwarded-Encrypted: i=1; AJvYcCUk8x+BKxGemT58NBpRSCv/JpG1v5AZH7PbPFvdF5geJBj02IcEDytqYIwtBO//JofuV4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAFLM7cdkEXuvpDdPAlikjBt/4olm0BFmeRIfa7f/+oqsCjZj/
	RT6NMq/7zkRBsmTp9Hs62M3Q/2EZgeaEsO4xbXPInfBsQGn6WnybshDNC2PUQ5BBl/q2YA141aE
	74qfi4N9q1kHNXuavtSn/LwjsAYkkocVT+wmq
X-Gm-Gg: ASbGncsx7ZCNOzzX1g/42ebyIXxJMbyrGVeh0X/fnTvrAYLSt0hfmhB1Xt8HKo7yWCz
	Pqs/c9Zi1wutl2v9PNZixDt7dwQ6CLmW7hjXTIFk=
X-Google-Smtp-Source: AGHT+IFD2FZO22gYwjqS/W2R8BU+z1PyKboxx9L2nXXaxN3X1mxEPSgfAkW3JDRnEpr2kbwloN6DlCar/hZ/ez+9ewY=
X-Received: by 2002:a05:6e02:20e3:b0:3ce:6a91:2318 with SMTP id
 e9e14a558f8ab-3ce84a4ac08mr1245815ab.26.1736898959213; Tue, 14 Jan 2025
 15:55:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109222109.567031-1-irogers@google.com> <20250109222109.567031-4-irogers@google.com>
 <Z4B279zu_8Kz5N6u@google.com> <CAP-5=fUSfbZGNaUttM3UCzcrMzkkFAJVA8mheMKQ0nxNH_KuTg@mail.gmail.com>
 <Z4FtHGBbCEeLQhAm@google.com> <CAP-5=fVr43v8gkqi8SXVaNKnkO+cooQVqx3xUFJ-BtgxGHX90g@mail.gmail.com>
 <Z4a7DncIlP6pznW7@google.com>
In-Reply-To: <Z4a7DncIlP6pznW7@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 14 Jan 2025 15:55:47 -0800
X-Gm-Features: AbW1kvalc4iuRVQvNblsy_TYapr356XuLDObglLylqCbMl1JxwzmbUECWJ5lJ1E
Message-ID: <CAP-5=fWZxpooqOhC_QrR2YaZVEj0UpipBCHXHZMbFfv7G15Vnw@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] perf record: Skip don't fail for events that don't open
To: Namhyung Kim <namhyung@kernel.org>
Cc: James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>, 
	Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 11:29=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Fri, Jan 10, 2025 at 11:18:53AM -0800, Ian Rogers wrote:
> > On Fri, Jan 10, 2025 at 10:55=E2=80=AFAM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > >
> > > On Thu, Jan 09, 2025 at 08:44:38PM -0800, Ian Rogers wrote:
> > > > On Thu, Jan 9, 2025 at 5:25=E2=80=AFPM Namhyung Kim <namhyung@kerne=
l.org> wrote:
> > > > >
> > > > > On Thu, Jan 09, 2025 at 02:21:08PM -0800, Ian Rogers wrote:
> > > > > > Whilst for many tools it is an expected behavior that failure t=
o open
> > > > > > a perf event is a failure, ARM decided to name PMU events the s=
ame as
> > > > > > legacy events and then failed to rename such events on a server=
 uncore
> > > > > > SLC PMU. As perf's default behavior when no PMU is specified is=
 to
> > > > > > open the event on all PMUs that advertise/"have" the event, thi=
s
> > > > > > yielded failures when trying to make the priority of legacy and
> > > > > > sysfs/json events uniform - something requested by RISC-V and A=
RM. A
> > > > > > legacy event user on ARM hardware may find their event opened o=
n an
> > > > > > uncore PMU which for perf record will fail. Arnaldo suggested s=
kipping
> > > > > > such events which this patch implements. Rather than have the s=
kipping
> > > > > > conditional on running on ARM, the skipping is done on all
> > > > > > architectures as such a fundamental behavioral difference could=
 lead
> > > > > > to problems with tools built/depending on perf.
> > > > > >
> > > > > > An example of perf record failing to open events on x86 is:
> > > > > > ```
> > > > > > $ perf record -e data_read,cycles,LLC-prefetch-read -a sleep 0.=
1
> > > > > > Error:
> > > > > > Failure to open event 'data_read' on PMU 'uncore_imc_free_runni=
ng_0' which will be removed.
> > > > > > The sys_perf_event_open() syscall returned with 22 (Invalid arg=
ument) for event (data_read).
> > > > > > "dmesg | grep -i perf" may provide additional information.
> > > > > >
> > > > > > Error:
> > > > > > Failure to open event 'data_read' on PMU 'uncore_imc_free_runni=
ng_1' which will be removed.
> > > > > > The sys_perf_event_open() syscall returned with 22 (Invalid arg=
ument) for event (data_read).
> > > > > > "dmesg | grep -i perf" may provide additional information.
> > > > > >
> > > > > > Error:
> > > > > > Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which wi=
ll be removed.
> > > > > > The LLC-prefetch-read event is not supported.
> > > > > > [ perf record: Woken up 1 times to write data ]
> > > > > > [ perf record: Captured and wrote 2.188 MB perf.data (87 sample=
s) ]
> > > > >
> > > > > I'm afraid this can be too noisy.
> > > >
> > > > The intention is to be noisy:
> > > > 1) it matches the existing behavior, anything else is potentially a=
 regression;
> > >
> > > Well.. I think you're changing the behavior. :)  Also currently it ju=
st
> > > fails on the first event so it won't be too much noisy.
> > >
> > >   $ perf record -e data_read,data_write,LLC-prefetch-read -a sleep 0.=
1
> > >   event syntax error: 'data_read,data_write,LLC-prefetch-read'
> > >                        \___ Bad event name
> > >
> > >   Unable to find event on a PMU of 'data_read'
> > >   Run 'perf list' for a list of valid events
> > >
> > >    Usage: perf record [<options>] [<command>]
> > >       or: perf record [<options>] -- <command> [<options>]
> > >
> > >       -e, --event <event>   event selector. use 'perf list' to list a=
vailable events
> >
> > Fwiw, this error is an event parsing error not an event opening error.
> > You need to select an uncore event, I was using data_read which exists
> > in the uncore_imc_free_running PMUs on Intel tigerlake. Here is the
> > existing error message:
> > ```
> > $ perf record -e data_read -a true
> > Error:
> > The sys_perf_event_open() syscall returned with 22 (Invalid argument)
> > for event (data_read).
> > "dmesg | grep -i perf" may provide additional information.
> > ```
> > and here it with the series:
> > ```
> > $ perf record -e data_read -a true
> > Error:
> > Failure to open event 'data_read' on PMU 'uncore_imc_free_running_0'
> > which will be removed.
> > The sys_perf_event_open() syscall returned with 22 (Invalid argument)
> > for event (data_read).
> > "dmesg | grep -i perf" may provide additional information.
> >
> > Error:
> > Failure to open event 'data_read' on PMU 'uncore_imc_free_running_1'
> > which will be removed.
> > The sys_perf_event_open() syscall returned with 22 (Invalid argument)
> > for event (data_read).
> > "dmesg | grep -i perf" may provide additional information.
> >
> > Error:
> > Failure to open any events for recording.
> > ```
> > and here is what it would be with pr_debug:
> > ```
> > $ perf record -e data_read -a true
> > Error:
> > Failure to open any events for recording.
> > ```
> > I believe this last output is worst because:
> > 1) If not all events fail to open there is no error reported unless I
> > know to run with -v, which will also bring a bunch more noise with it,
>
> I suggested to add a warning if any (not all) of events failed to open.
>
>   "Removed some unsupported events, use -v for details."
>
>
> > 2) I don't see the PMU / event name and "Invalid argument" indicating
> > what has gone wrong again unless I know to run with -v and get all the
> > verbose noise with that.
>
> I don't think single -v adds a lot of noise in the output.
>
> >
> > Yes it is noisy on 1 platform for 1 event due to an ARM PMU event name
> > bug that ARM should have long ago fixed. That should be fixed rather
> > than hiding errors and making users think they are recording samples
> > when silently they're not - or they need to search through verbose
> > output to try to find out if something broke.
>
> I'm not sure if it's a bug in the driver.  It happens because perf tool
> changed the way it finds events - it used to look at the core PMUs only
> if no PMU name was given, but now it searches every PMU, right?

So there is the ARM bug in the PMU driver that caused an issue with
the hybrid fixes done because of wanting to have metrics work for
hybrid. The bug is reported here:
https://lore.kernel.org/lkml/08f1f185-e259-4014-9ca4-6411d5c1bc65@marcan.st=
/
The events are apple_icestorm_pmu/cycles/ and
apple_firestorm_pmu/cycles/. The issue is that prior to fixing hybrid
the ARM PMUs looked like uncore PMUs and couldn't open a legacy event,
which was fine as they has sysfs events. When hybrid was fixed in the
tool, the tool would then try to open apple_icestorm_pmu/cycles/ and
apple_firestorm_pmu/cycles/ as legacy events - legacy having priority
over sysfs/json back then. The legacy mapping was broken in the PMU
driver. Now were everything working as intended, just the cycles event
would be specified on the command line and the event would be wildcard
opened on the apple_icestorm_pmu and apple_firestorm_pmu. I believe
this way would already use a legacy encoding and so to work around the
PMU driver bug people were specifying the PMU name to get the sysfs
encoding, but that only worked as the PMUs appeared to be uncore.

> >
> > > > 2) it only happens if trying to record on a PMU/event that doesn't
> > > > support recording, something that is currently an error and so we'r=
e
> > > > not motivated to change the behavior as no-one should be using it;
> > >
> > > It was caught by Linus, so we know at least one (very important) user=
.
> >
> > If they care enough then specifying the PMU with the event will avoid
> > any warning and has always been a fix for this issue. It was the first
> > proposed workaround for Linus.
>
> I guess that's what Linus said regression.

But a regression where? The tool's behavior is pretty clear, no PMU
the event will be tried on every PMU, give it a PMU and the event will
only be tried on that PMU, give it a PMU without a suffix and the
event will be opened on all PMUs that match the name with different
suffixes. I dislike the idea of  cpu-cycles implicitly being just for
core PMUs, but cpu_cycles being for all PMUs as the hyphen is a legacy
name and the underscore not. I dislike the idea of specifying a PMU
with uncore events as uncore events often already have a PMU within
their event name and it also breaks the universe. When trying to find
out what people mean by event names being implicitly associated with
PMUs I get told I'm throwing out "what ifs," when all I'm doing is
reading the code (that I wrote and I'm trying to fix) and trying to
figure out what behavior people want. What I don't want is
inconsistencies, events behaving differently in different scenarios
and the perf output's use of event names being inconsistent with the
parsing. RISC-V and ARM have wanted the syfs/json over legacy
priority, so I'm trying to get that landed.

Ultimately the original regression comes back to the ARM SLC PMU
advertising a cycles event when it should have been named cpu_cycles,
if for no other reason than uniformity with the bus_cycles name on the
same PMU. The change in perf's wildcard behavior exposed the latent
bug, that doesn't make the SLC PMU's event name not a bug. The change
here is to make seeing that bug non-terminal to running the program.

> >
> > > > 3) for the wildcard case the only offender is ARM's SLC PMU and the
> > > > appropriate fix there has always been to make the CPU cycle's event
> > > > name match the bus_cycles event name by calling it cpu_cycles -
> > > > something that doesn't conflict with a core PMU event name, the thi=
ng
> > > > that has introduced all these problems, patches, long email exchang=
es,
> > > > unfixed inconsistencies, etc.. If the errors aren't noisy then ther=
e
> > > > is little motivation for the ARM SLC PMU's event name to be fixed.
> > >
> > > I understand your concern but I'm not sure it's the best way to fix t=
he
> > > issue.
> >
> > Right, I'm similarly concerned about hiding legitimate warning/error
> > messages because of 1 event on 1 PMU on 1 architecture because of how
> > perf gets driven by 1 user. Yes, when you break you can wade through
> > the verbose output but imo the verbose output was never intended to be
> > used in that way.
>
> Well, the verbose output is to debug when something doesn't go well, no?

The output isn't currently only enabled in verbose mode, so is this
wrong? You will only get extra warnings with this change if you do
anything wrong. For a hybrid system maybe you've gone from 1 warning
to 2, I fail to see a big deal. Yes if you try to do perf record on an
uncore server PMU with many instances you will potentially get many
warnings, but the behavior before and after is to fail and the user is
likely to figure out what the fix is in both cases, with more errors
they may appreciate better that the event was getting opened on many
PMUs. The trend for event parsing errors is to have more error
messages. We went from 1 to 2 in commit
a910e4666d61712840c78de33cc7f89de8affa78 and from 2 to many in commit
fd7b8e8fb20f51d60dfee7792806548f3c6a4c2c. The trend isn't to try to
move things into verbose only output and for things to silently (or
with little detail) fail for the user.

Thanks,
Ian

