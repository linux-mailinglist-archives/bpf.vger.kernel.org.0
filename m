Return-Path: <bpf+bounces-47298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B3E9F73DA
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 06:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A6FA188AA46
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 05:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2A02165E4;
	Thu, 19 Dec 2024 05:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Q3WRC20"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EB912AAE2
	for <bpf@vger.kernel.org>; Thu, 19 Dec 2024 05:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734584980; cv=none; b=ucFfcqgi9rs5wVEDuisVyT7hUqJhj+pg8i3xIt0ZnkYhD4nYtXrhZslFMg+yEWXlkucIa1nOzJCQ9flJ3ucsKNNhyJpcEQety0faCmTkbXJ8a9SFOdm7tltUAHGMDVYeXgA+SygDumiIfuAImnqrIsN0SEhsVMi00v3gj02/9/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734584980; c=relaxed/simple;
	bh=1upYpg7JeHbyxHj3GHuMzZsoO9ypm9IhxyN2Fjy2hEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dPvw9KduI+eiojcoeVweF5nLCXdtyAo4T1oA2lQG1VSGEdkEOBOcdHAjHilsGWghgfNos/BYgZJ3rguYedntKgHgG/JIH3pXY8tw7e3qk6ubEUwkSkpHO9k/LaMjZeJ+tYxoeD1IG41h+QTJdt8CCeV2jO7VcXavS4Y8P/JbYqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Q3WRC20; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a9d0c28589so77145ab.0
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 21:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734584978; x=1735189778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTOx6e8aU3t1b8KFY3+B5yvmmNYJx0HN6CrXY+bLQ+8=;
        b=0Q3WRC20Zgi+7X9A7nNReOKMO1a9GOB+II+RWaxLQbi4vUnCXmfY5xlBJwRcplSNue
         dxJWr6cWo7kcVbsalGRpEO4JJEVi0Ei0AzFt4sIzrkzpeJM5qmEnXQQ0/C/QzvVuZjGg
         8oGYcleq8CobXjeCRWbbmECVHAQsW8H5mPwFcc6qJxJ1JhDJyNLWDczf/g/n62BUsC96
         IL7MlSpOnNUfqnq0mKYD/+1Itb/Gab+/S3eyojXgZPQKZtncxfrcfCX9STY/9JxAwv5H
         4TSDWzQPJIoCcCm77qZC8eLx4qy1TIj2DkQttXx0iNAUM537qe7dLhaHHDVXd5ygIzmj
         n68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734584978; x=1735189778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTOx6e8aU3t1b8KFY3+B5yvmmNYJx0HN6CrXY+bLQ+8=;
        b=ucMir7AZqrOmSxL52omF3PqQMRLhHdtzBGQAheCvCTOlqAEYxf57FNHWLp8T3wnspA
         7w4YDvs3Ob8ScvNvRA/iMaKZPzH0gM/9x+j/i8s4LolC0StLVk5zEJ5wBLIC/M7Hv+vJ
         HGVM0DDm7EkNqZ58J1T0b2+3MfSqdNgNqN7PVfSBfQNjNaDVc+JNmkRfTtAJJdfrmYH3
         qqEOH0pQxgeVj5Q3YxHcOVF65F7shi8URpPjeAV2ccjzFip49TqqMvIWjOEt6jIm450i
         3p9wKHdF3YRuhl3np5HAxewi77dQsSREvVaOYTzDNgr1icaSBsIcbeof4htNgkneeDn0
         I6Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUj2aTzp4Z0JnaknAbgmEPA3TnEXua2zaztcBhq2S4tyrt4P2usJ79sES1q7NeRgfHHxWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH+HuwoahScTzsrwp/0YVDLYIuuuqf0x674k0ynt4LZf/8l7ih
	J4SQTnmWB+GPkqvEGUnWuH1FON+Edp0GJSGJ5828c/7vVhihM/637XpyMRYYk4LPL8Wz2kA2R8C
	uQloYXDbygbLumIt0HWxfueIMH9RNwqZWO9Ja
X-Gm-Gg: ASbGncswYJD1r1LpW44bnbOIV5ZzPr21zUfzDNh7TVNQao6rrwzORQX9Au2tgv/FyJg
	qWV+eF5M5Yv7O4Jnwo8G3EFMzTDTy9/QnTFUu/0g=
X-Google-Smtp-Source: AGHT+IFA+gCChHQIKWjd1MMBd92uqQzfvWnU9JJErwNjQQjUEfn5NvlqHNUTddNldGRFuM4NRXHa1HR+qLLEuxUzfr4=
X-Received: by 2002:a05:6e02:190d:b0:3a7:c962:95d1 with SMTP id
 e9e14a558f8ab-3c0aa480224mr1327435ab.5.1734584977502; Wed, 18 Dec 2024
 21:09:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113011956.402096-1-irogers@google.com> <0ED8731D-B183-49A5-86C3-7048D190774F@ibm.com>
In-Reply-To: <0ED8731D-B183-49A5-86C3-7048D190774F@ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 18 Dec 2024 21:09:26 -0800
Message-ID: <CAP-5=fW8DfYJqT2WF_VbmAZUSY5Twozm9VdjZPaX6B0J-9Mn7g@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Prefer sysfs/JSON events also when no PMU is provided
To: Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>, James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Junhao He <hejunhao3@huawei.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 4:36=E2=80=AFAM Aditya Bodkhe <Aditya.Bodkhe1@ibm.c=
om> wrote:
>
>
>
> > On 13 Nov 2024, at 6:49=E2=80=AFAM, Ian Rogers <irogers@google.com> wro=
te:
> >
> > At the RISC-V summit the topic of avoiding event data being in the
> > RISC-V PMU kernel driver came up. There is a preference for sysfs/JSON
> > events being the priority when no PMU is provided so that legacy
> > events maybe supported via json. Originally Mark Rutland also
> > expressed at LPC 2023 that doing this would resolve bugs on ARM Apple
> > M? processors, but James Clark more recently tested this and believes
> > the driver issues there may not have existed or have been resolved. In
> > any case, it is inconsistent that with a PMU event names avoid legacy
> > encodings, but when wildcarding PMUs (ie without a PMU with the event
> > name) the legacy encodings have priority.
> >
> > The patch doing this work was reverted in a v6.10 release candidate
> > as, even though the patch was posted for weeks and had been on
> > linux-next for weeks without issue, Linus was in the habit of using
> > explicit legacy events with unsupported precision options on his
> > Neoverse-N1. This machine has SLC PMU events for bus and CPU cycles
> > where ARM decided to call the events bus_cycles and cycles, the latter
> > being also a legacy event name. ARM haven't renamed the cycles event
> > to a more consistent cpu_cycles and avoided the problem. With these
> > changes the problematic event will now be skipped, a large warning
> > produced, and perf record will continue for the other PMU events. This
> > solution was proposed by Arnaldo.
> >
> > Two minor changes have been added to help with the error message and
> > to work around issues occurring with "perf stat metrics (shadow stat)
> > test".
> >
> > The patches have only been tested on my x86 non-hybrid laptop.
>
> Hi,
> After applying this patch series,we observed a regression while running t=
he perf test suite on powerpc system. Specifically, test case for "Check br=
anch stack sampling" now fails.
> Upon investigation, identified that patch "perf record: Skip don't fail f=
or events that don't open"  is causing the breakage. This test case uses br=
anch-filter as "save_type" and it is supposed to be skipped in powerpc.
> Snippet of code:
>
> skip the test if the hardware doesn't support branch stack sampling
>  and if the architecture doesn't support filter types: any,save_type,u
> if ! perf record -o- --no-buildid --branch-filter any,save_type,u -- true=
 > /dev/null 2>&1 ; then
>     echo "skip: system doesn't support filter types: any,save_type,u"
>     exit 2
> fi
>
> Before applying the patch, running the command:
> ./perf record -o- --no-buildid --branch-filter any,save_type,u -- true
> cycles:PH: PMU Hardware or event type doesn't support branch stack sampli=
ng.
> # echo $?
> 255
>
> would return 255 (indicating not supported) with the error.
> After applying the patch, the same command now returns 0, which is incorr=
ect. The output is as follows:
>
> # ./perf record -o- --no-buildid --branch-filter any,save_type,u -- true
> Lowering default frequency rate from 4000 to 2000.
> Please consider tweaking /proc/sys/kernel/perf_event_max_sample_rate.
> Error:
> Failure to open event 'cycles:PH' on PMU 'cpu' which will be removed.
> cycles:PH: PMU Hardware or event type doesn't support branch stack sampli=
ng.
> libperf: Miscounted nr_mmaps 0 vs 8
> WARNING: No sample_id_all support, falling back to unordered processing
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.008 MB - ]
> # echo $?
> 0
>
> Also there were some junk result in the output which I have skipped in ab=
ove result. The patch appears to alter behavior such that the unsupported o=
r failed event open still proceeds and leading to this.
>
> Ian ,
> Is this behaviour expected ?

Thanks Aditya, sorry for my slow response! Breaking tests isn't
expected (thanks for the report!), warning when encountering an event
that won't be recorded is expected. James Clark mentioned that we
should probably make perf record fail if it has no events to record,
my issue there was that the dummy event (for sideband things like mmap
events) is always opened and I was worried about turning "perf record
-e dummy .." into a failure. We should be able to determine if the
dummy event was created by the tool or specified the user, so I should
look to add that to the patch series and it should address this test
regression.

Thanks!
Ian

