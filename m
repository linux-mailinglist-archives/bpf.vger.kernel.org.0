Return-Path: <bpf+bounces-43275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4F89B2531
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 07:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E1862820F0
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 06:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8155318E038;
	Mon, 28 Oct 2024 06:23:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8172F18DF71;
	Mon, 28 Oct 2024 06:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730096614; cv=none; b=THkIQOL2DpiPfcKskvrAjjxBuXK3w9DdLElsR33ClV0hA0D6pyHMnzNbyJnsjO+Z7jj1tf6gxIeO/0mnG9hOQhUxnkO81UJk6btKh23RMB96IbUumyJ9hkl77WPkaW0frO8NxebAh9BgmnWhlQS1nDfybNZpMvCWmQKTHS6+nm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730096614; c=relaxed/simple;
	bh=0+J66JQvcnpiLR6r/XFkjS6u1Gc/WOk2J4wPUM3mdHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BkUcllrZ4ea+0A3kiGWiwfNf+P7fw4CTOsQtneLJnyaWhNBEOe4egcQmIovTrK1zgunAl/8lDSqWibz7bTwvE7gsb3KlfRiDoBvQvrfzKmBfhsiifJniEjzEyja445eLVgg5xPrmSUGWXatWHXlfplXiWQ7xkYN5hEAJRXv3Zw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e5a0177531so2920181a91.2;
        Sun, 27 Oct 2024 23:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730096611; x=1730701411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZALZRG3KxvUsIjcc8jJ4Z5QHpLDPuNesDh7TKaGPzo=;
        b=VK2PZkPzbrsJ87VIXTXQpp9OUsG0SzQ8GnD2grqfweLHRg4T4e4zHQCIVYKpxlYggN
         rWtczqR6iL/H5UG/f5mJiw21Zo14OqOZSOTPw6zutGQHTsEAtg0n44lg/TAzhcoCCamw
         hzoj/6IZDWkbHy5TSMcTdb+pI/wVj16c9qqEHVDS560uZI/8FCMI6CPLTJdIXBfBYIl9
         y0oPJlwwsjCrR5JbrDLHEAmlOmDwvDKefNqfHOSJDza8/xXRh9c0miIMqTGTq7jMX9nA
         /i34E04o6h5/yT7n944Umdu5ZUHjMRWwDxelnLfmgO/9KD4hp3XRqPpSwbi950PZu4Rl
         wMEA==
X-Forwarded-Encrypted: i=1; AJvYcCUYnBeYfTrFQrZ6U5YEp29Zz8ULN3Te6S0Y1k9xIgr7NKGau8MEmR/41lExcV1EZmZal6IYkgZbeDsn/hAO@vger.kernel.org, AJvYcCWRfgPRqmWfQ7JG/zsvxqcUXdMW/hkhAm8iErAgpOTYtAF5YdL0Q3avlFbbEWFXQZoJ8W0=@vger.kernel.org, AJvYcCWllBO2QyVSjts/NePAS+te1r+3eOp5pAmewbxkTX7C+b3zRxGabfe1O8ZwM8mgM4JEoMmuSpshS86cYmsHbU0CCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFv70A4MCHl7oyKziUp38lygdQSxMt0DIRevtH3OxJpHnB/xzT
	+fhInkyAXBz3dZ5gPgX3INFAJ7YqdzsclANjAmjBsP/X2DVc4xWj8HV+anUrLNRP3wVoiOA6hsE
	qmgku5RTH4E6EFbwpxs5XhP20eA8=
X-Google-Smtp-Source: AGHT+IERFH5vCrsUdxlh7k465Xlp47CNz0RfhCmy+hV6tLr8hN2O60wwsKXarULUhKX9hEXSv7ce8lotjuCWqEpLKCM=
X-Received: by 2002:a17:90a:f0d3:b0:2e2:bb32:73e0 with SMTP id
 98e67ed59e1d1-2e8f1067fc3mr8022349a91.12.1730096610753; Sun, 27 Oct 2024
 23:23:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021110201.325617-1-wutengda@huaweicloud.com>
 <20241021110201.325617-2-wutengda@huaweicloud.com> <ZxclNg9Y5hUXGXCf@google.com>
 <e1faa3b2-5448-403f-93ab-78731daffce4@huaweicloud.com> <Zxl8iRgHi0ZZKMf-@google.com>
 <58fc2ccf-17ed-41eb-ac53-a3813ef75edc@huaweicloud.com>
In-Reply-To: <58fc2ccf-17ed-41eb-ac53-a3813ef75edc@huaweicloud.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Sun, 27 Oct 2024 23:23:19 -0700
Message-ID: <CAM9d7cgRmzoTeLRCCSL38cpoVFWOXNghML99qeYmmapPokLDfQ@mail.gmail.com>
Subject: Re: [PATCH -next v5 1/2] perf stat: Support inherit events during
 fork() for bperf
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Peter Zijlstra <peterz@infradead.org>, song@kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 7:11=E2=80=AFPM Tengda Wu <wutengda@huaweicloud.com=
> wrote:
>
>
>
> On 2024/10/24 6:45, Namhyung Kim wrote:
> > On Tue, Oct 22, 2024 at 05:39:23PM +0800, Tengda Wu wrote:
> >>
> >>
> >> On 2024/10/22 12:08, Namhyung Kim wrote:
> >>> Hello,
> >>>
> >>> On Mon, Oct 21, 2024 at 11:02:00AM +0000, Tengda Wu wrote:
> >>>> bperf has a nice ability to share PMUs, but it still does not suppor=
t
> >>>> inherit events during fork(), resulting in some deviations in its st=
at
> >>>> results compared with perf.
> >>>>
> >>>> perf stat result:
> >>>> $ ./perf stat -e cycles,instructions -- ./perf test -w sqrtloop
> >>>>    Performance counter stats for './perf test -w sqrtloop':
> >>>>
> >>>>        2,316,038,116      cycles
> >>>>        2,859,350,725      instructions
> >>>>
> >>>>          1.009603637 seconds time elapsed
> >>>>
> >>>>          1.004196000 seconds user
> >>>>          0.003950000 seconds sys
> >>>>
> >>>> bperf stat result:
> >>>> $ ./perf stat --bpf-counters -e cycles,instructions -- \
> >>>>       ./perf test -w sqrtloop
> >>>>
> >>>>    Performance counter stats for './perf test -w sqrtloop':
> >>>>
> >>>>           18,762,093      cycles
> >>>>           23,487,766      instructions
> >>>>
> >>>>          1.008913769 seconds time elapsed
> >>>>
> >>>>          1.003248000 seconds user
> >>>>          0.004069000 seconds sys
> >>>>
> >>>> In order to support event inheritance, two new bpf programs are adde=
d
> >>>> to monitor the fork and exit of tasks respectively. When a task is
> >>>> created, add it to the filter map to enable counting, and reuse the
> >>>> `accum_key` of its parent task to count together with the parent tas=
k.
> >>>> When a task exits, remove it from the filter map to disable counting=
.
> >>>>
> >>>> After support:
> >>>> $ ./perf stat --bpf-counters -e cycles,instructions -- \
> >>>>       ./perf test -w sqrtloop
> >>>>
> >>>>  Performance counter stats for './perf test -w sqrtloop':
> >>>>
> >>>>      2,316,252,189      cycles
> >>>>      2,859,946,547      instructions
> >>>>
> >>>>        1.009422314 seconds time elapsed
> >>>>
> >>>>        1.003597000 seconds user
> >>>>        0.004270000 seconds sys
> >>>>
> >>>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> >>>> ---
> >>>>  tools/perf/builtin-stat.c                     |  1 +
> >>>>  tools/perf/util/bpf_counter.c                 | 35 +++++--
> >>>>  tools/perf/util/bpf_skel/bperf_follower.bpf.c | 98 ++++++++++++++++=
+--
> >>>>  tools/perf/util/bpf_skel/bperf_u.h            |  5 +
> >>>>  tools/perf/util/target.h                      |  1 +
> >>>>  5 files changed, 126 insertions(+), 14 deletions(-)
> >>>>
> >>>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> >>>> index 3e6b9f216e80..8bc880479417 100644
> >>>> --- a/tools/perf/builtin-stat.c
> >>>> +++ b/tools/perf/builtin-stat.c
> >>>> @@ -2620,6 +2620,7 @@ int cmd_stat(int argc, const char **argv)
> >>>>    } else if (big_num_opt =3D=3D 0) /* User passed --no-big-num */
> >>>>            stat_config.big_num =3D false;
> >>>>
> >>>> +  target.inherit =3D !stat_config.no_inherit;
> >>>>    err =3D target__validate(&target);
> >>>>    if (err) {
> >>>>            target__strerror(&target, err, errbuf, BUFSIZ);
> >>>> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_cou=
nter.c
> >>>> index 7a8af60e0f51..73fcafbffc6a 100644
> >>>> --- a/tools/perf/util/bpf_counter.c
> >>>> +++ b/tools/perf/util/bpf_counter.c
> >>>> @@ -394,6 +394,7 @@ static int bperf_check_target(struct evsel *evse=
l,
> >>>>  }
> >>>>
> >>>>  static    struct perf_cpu_map *all_cpu_map;
> >>>> +static __u32 filter_entry_cnt;
> >>>>
> >>>>  static int bperf_reload_leader_program(struct evsel *evsel, int att=
r_map_fd,
> >>>>                                   struct perf_event_attr_map_entry *=
entry)
> >>>> @@ -444,12 +445,32 @@ static int bperf_reload_leader_program(struct =
evsel *evsel, int attr_map_fd,
> >>>>    return err;
> >>>>  }
> >>>>
> >>>> +static int bperf_attach_follower_program(struct bperf_follower_bpf =
*skel,
> >>>> +                                   enum bperf_filter_type filter_ty=
pe,
> >>>> +                                   bool inherit)
> >>>> +{
> >>>> +  struct bpf_link *link;
> >>>> +  int err =3D 0;
> >>>> +
> >>>> +  if ((filter_type =3D=3D BPERF_FILTER_PID ||
> >>>> +      filter_type =3D=3D BPERF_FILTER_TGID) && inherit)
> >>>> +          /* attach all follower bpf progs to enable event inherita=
nce */
> >>>> +          err =3D bperf_follower_bpf__attach(skel);
> >>>> +  else {
> >>>> +          link =3D bpf_program__attach(skel->progs.fexit_XXX);
> >>>> +          if (IS_ERR(link))
> >>>> +                  err =3D PTR_ERR(link);
> >>>> +  }
> >>>> +
> >>>> +  return err;
> >>>> +}
> >>>> +
> >>>>  static int bperf__load(struct evsel *evsel, struct target *target)
> >>>>  {
> >>>>    struct perf_event_attr_map_entry entry =3D {0xffffffff, 0xfffffff=
f};
> >>>>    int attr_map_fd, diff_map_fd =3D -1, err;
> >>>>    enum bperf_filter_type filter_type;
> >>>> -  __u32 filter_entry_cnt, i;
> >>>> +  __u32 i;
> >>>>
> >>>>    if (bperf_check_target(evsel, target, &filter_type, &filter_entry=
_cnt))
> >>>>            return -1;
> >>>> @@ -529,9 +550,6 @@ static int bperf__load(struct evsel *evsel, stru=
ct target *target)
> >>>>    /* set up reading map */
> >>>>    bpf_map__set_max_entries(evsel->follower_skel->maps.accum_reading=
s,
> >>>>                             filter_entry_cnt);
> >>>> -  /* set up follower filter based on target */
> >>>> -  bpf_map__set_max_entries(evsel->follower_skel->maps.filter,
> >>>> -                           filter_entry_cnt);
> >>>>    err =3D bperf_follower_bpf__load(evsel->follower_skel);
> >>>>    if (err) {
> >>>>            pr_err("Failed to load follower skeleton\n");
> >>>> @@ -543,6 +561,7 @@ static int bperf__load(struct evsel *evsel, stru=
ct target *target)
> >>>>    for (i =3D 0; i < filter_entry_cnt; i++) {
> >>>>            int filter_map_fd;
> >>>>            __u32 key;
> >>>> +          struct bperf_filter_value fval =3D { i, 0 };
> >>>>
> >>>>            if (filter_type =3D=3D BPERF_FILTER_PID ||
> >>>>                filter_type =3D=3D BPERF_FILTER_TGID)
> >>>> @@ -553,12 +572,14 @@ static int bperf__load(struct evsel *evsel, st=
ruct target *target)
> >>>>                    break;
> >>>>
> >>>>            filter_map_fd =3D bpf_map__fd(evsel->follower_skel->maps.=
filter);
> >>>> -          bpf_map_update_elem(filter_map_fd, &key, &i, BPF_ANY);
> >>>> +          bpf_map_update_elem(filter_map_fd, &key, &fval, BPF_ANY);
> >>>>    }
> >>>>
> >>>>    evsel->follower_skel->bss->type =3D filter_type;
> >>>> +  evsel->follower_skel->bss->inherit =3D target->inherit;
> >>>>
> >>>> -  err =3D bperf_follower_bpf__attach(evsel->follower_skel);
> >>>> +  err =3D bperf_attach_follower_program(evsel->follower_skel, filte=
r_type,
> >>>> +                                      target->inherit);
> >>>>
> >>>>  out:
> >>>>    if (err && evsel->bperf_leader_link_fd >=3D 0)
> >>>> @@ -623,7 +644,7 @@ static int bperf__read(struct evsel *evsel)
> >>>>    bperf_sync_counters(evsel);
> >>>>    reading_map_fd =3D bpf_map__fd(skel->maps.accum_readings);
> >>>>
> >>>> -  for (i =3D 0; i < bpf_map__max_entries(skel->maps.accum_readings)=
; i++) {
> >>>> +  for (i =3D 0; i < filter_entry_cnt; i++) {
> >>>>            struct perf_cpu entry;
> >>>>            __u32 cpu;
> >>>>
> >>>> diff --git a/tools/perf/util/bpf_skel/bperf_follower.bpf.c b/tools/p=
erf/util/bpf_skel/bperf_follower.bpf.c
> >>>> index f193998530d4..0595063139a3 100644
> >>>> --- a/tools/perf/util/bpf_skel/bperf_follower.bpf.c
> >>>> +++ b/tools/perf/util/bpf_skel/bperf_follower.bpf.c
> >>>> @@ -5,6 +5,8 @@
> >>>>  #include <bpf/bpf_tracing.h>
> >>>>  #include "bperf_u.h"
> >>>>
> >>>> +#define MAX_ENTRIES 102400
> >>>> +
> >>>>  struct {
> >>>>    __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> >>>>    __uint(key_size, sizeof(__u32));
> >>>> @@ -22,25 +24,29 @@ struct {
> >>>>  struct {
> >>>>    __uint(type, BPF_MAP_TYPE_HASH);
> >>>>    __uint(key_size, sizeof(__u32));
> >>>> -  __uint(value_size, sizeof(__u32));
> >>>> +  __uint(value_size, sizeof(struct bperf_filter_value));
> >>>> +  __uint(max_entries, MAX_ENTRIES);
> >>>> +  __uint(map_flags, BPF_F_NO_PREALLOC);
> >>>>  } filter SEC(".maps");
> >>>>
> >>>>  enum bperf_filter_type type =3D 0;
> >>>>  int enabled =3D 0;
> >>>> +int inherit;
> >>>>
> >>>>  SEC("fexit/XXX")
> >>>>  int BPF_PROG(fexit_XXX)
> >>>>  {
> >>>>    struct bpf_perf_event_value *diff_val, *accum_val;
> >>>>    __u32 filter_key, zero =3D 0;
> >>>> -  __u32 *accum_key;
> >>>> +  __u32 accum_key;
> >>>> +  struct bperf_filter_value *fval;
> >>>>
> >>>>    if (!enabled)
> >>>>            return 0;
> >>>>
> >>>>    switch (type) {
> >>>>    case BPERF_FILTER_GLOBAL:
> >>>> -          accum_key =3D &zero;
> >>>> +          accum_key =3D zero;
> >>>>            goto do_add;
> >>>>    case BPERF_FILTER_CPU:
> >>>>            filter_key =3D bpf_get_smp_processor_id();
> >>>> @@ -49,22 +55,34 @@ int BPF_PROG(fexit_XXX)
> >>>>            filter_key =3D bpf_get_current_pid_tgid() & 0xffffffff;
> >>>>            break;
> >>>>    case BPERF_FILTER_TGID:
> >>>> -          filter_key =3D bpf_get_current_pid_tgid() >> 32;
> >>>> +          /* Use pid as the filter_key to exclude new task counts
> >>>> +           * when inherit is disabled. Don't worry about the existi=
ng
> >>>> +           * children in TGID losing their counts, bpf_counter has
> >>>> +           * already added them to the filter map via perf_thread_m=
ap
> >>>> +           * before this bpf prog runs.
> >>>> +           */
> >>>> +          filter_key =3D inherit ?
> >>>> +                       bpf_get_current_pid_tgid() >> 32 :
> >>>> +                       bpf_get_current_pid_tgid() & 0xffffffff;
> >>>
> >>> I'm not sure why this is needed.  Isn't the existing code fine?
> >>
> >> No, it's not. If I don't modify here, all child threads will always be=
 counted
> >> when inherit is disabled.
> >>
> >>
> >> Before explaining this modification, we may need to first clarify what=
 is included
> >> in the filter map.
> >>
> >> 1. The fexit_XXX prog determines whether to count by filter_key during=
 each
> >>    context switch. If the key is found in the filter map, it will be c=
ounted,
> >>    otherwise not.
> >> 2. The keys in the filter map are synchronized from the perf_thread_ma=
p when
> >>    bperf__load().
> >> 3. The threads in perf_thread_map are added through cmd_stat()->evlist=
__create_maps()
> >>    before bperf__load().
> >> 4. evlist__create_maps() fills perf_thread_map by traversing the /proc=
/%d/task
> >>    directory, and these pids belong to the same tgid.
> >>
> >> Therefore, when the bperf command is issued, the filter map already ho=
lds all
> >> existing threads with the same tgid as the specified process.
> >>
> >>
> >> Now, let's take a look at the TGID case. We hope the behavior is as fo=
llows:
> >>
> >>  * TGID w/ inherit : specified process + all children from the process=
es
> >>  * TGID w/o inherit: specified process (all threads in the process) on=
ly
> >>
> >> Assuming that a new thread is created during bperf stats, the new thre=
ad should
> >> exhibit the following behavior in the fexit_XXX prog:
> >>
> >>  * TGID w/ inherit : do_add
> >>  * TGID w/o inherit: skip and return
> >>
> >> Let's now test the code before and after modification.
> >>
> >> Before modification: (filter_key =3D tgid)
> >>
> >>  * TGID w/ inherit:
> >>       create  : new thread
> >>       enter   : fexit_XXX prog
> >>       assign  : filter_key =3D new thread's tgid
> >>       match   : bpf_map_lookup_elem(&filter, &filter_key)
> >>       do_add
> >>    (PASS)
> >>
> >>  * TGID w/o inherit:
> >>       [...]   /* like above */
> >>       do_add
> >>    (FAILED, expect skip and return)
> >>
> >> After modification: (filter_key =3D inherit ? tgid : pid)
> >>
> >>  * TGID w/ inherit:
> >>       create  : new thread
> >>       enter   : fexit_XXX prog
> >>       assign  : filter_key =3D new thread's tgid
> >>       match   : bpf_map_lookup_elem(&filter, &filter_key)
> >>       do_add
> >>    (PASS)
> >>
> >>  * TGID w/o inherit:
> >>       create  : new thread
> >>       enter   : fexit_XXX prog
> >>       assign  : filter_key =3D new thread's pid
> >>       mismatch: bpf_map_lookup_elem(&filter, &filter_key)
> >>       skip and return
> >>    (PASS)
> >>
> >> As we can see, filter_key=3Dtgid counts incorrectly in TGID w/o inheri=
t case,
> >> and we need to change it to filter_key=3Dpid to fix it.
> >
> > I'm sorry but I don't think I'm following.  A new thread in TGID mode
> > (regardless inherit) should be counted always, right?  Why do you
> > expect to skip it?
>
> This is how perf originally performs. To confirm this, I wrote a workload
> that creates one new thread per second and then stat it, as shown below.
> You can see that in 'TGID w/o inherit' case, perf does not count for the
> newly created threads.
>
> Perf TGID w/ inherit:
> ---
>   $ ./perf stat -e cpu-clock --timeout 5000 -- ./new_thread_per_second
>   thread 367444: start [main]
>   thread 367448: start
>   thread 367455: start
>   thread 367462: start
>   thread 367466: start
>   thread 367473: start
>   ./new_thread_per_second: Terminated
>
>   Performance counter stats for './new_thread_per_second':
>
>           10,017.71 msec cpu-clock
>
>         5.005538048 seconds time elapsed
>
>         10.018777000 seconds user
>         0.000000000 seconds sys
>
> Perf TGID w/o inherit:
> ---
>   $ ./perf stat -e cpu-clock --timeout 5000 -i -- ./new_thread_per_second
>   thread 366679: start [main]
>   thread 366686: start
>   thread 366693: start
>   thread 366697: start
>   thread 366704: start
>   thread 366708: start
>   ./new_thread_per_second: Terminated
>
>   Performance counter stats for './new_thread_per_second':
>
>                 4.29 msec cpu-clock
>
>         5.005539338 seconds time elapsed
>
>         10.019673000 seconds user
>         0.000000000 seconds sys
>
>
> Therefore, we also need to distinguish it in bperf so that the collection
> results can be consistent with perf.
>
> Bperf TGID w/o inherit: (BEFORE FIX)
> ---
>   $ ./perf stat --bpf-counters -e cpu-clock --timeout 5000 -i -- ./new_th=
read_per_second
>   thread 369127: start [main]
>   thread 369134: start
>   thread 369141: start
>   thread 369145: start
>   thread 369152: start
>   thread 369156: start
>   ./new_thread_per_second: Terminated
>
>   Performance counter stats for './new_thread_per_second':
>
>           10,019.05 msec cpu-clock
>
>         5.005567266 seconds time elapsed
>
>         10.018528000 seconds user
>         0.000000000 seconds sys
>
> Bperf TGID w/o inherit: (AFTER FIX)
> ---
>   $ ./perf stat --bpf-counters -e cpu-clock --timeout 5000 -i -- ./new_th=
read_per_second
>   thread 366616: start [main]
>   thread 366623: start
>   thread 366627: start
>   thread 366634: start
>   thread 366638: start
>   thread 366645: start
>   ./new_thread_per_second: Terminated
>
>   Performance counter stats for './new_thread_per_second':
>
>                 4.95 msec cpu-clock
>
>         5.005511173 seconds time elapsed
>
>         10.018790000 seconds user
>         0.000000000 seconds sys
>
>
> Thanks,
> Tengda
>

Thanks for the explanation.  Ok I think it's the limitation of the current
implementation of perf_event that works at thread-level.  Even if we
can count events at process-level with bperf, it might be important to
keep the compatibility with the existing behavior.

Thanks,
Namhyung

