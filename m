Return-Path: <bpf+bounces-22182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD8A8586B2
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 21:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FAA41F232E1
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 20:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822A013A253;
	Fri, 16 Feb 2024 20:25:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C589A1369B4;
	Fri, 16 Feb 2024 20:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115152; cv=none; b=cwaKQRWcyROjG8dXlfROXWIKnyLCO+UcueuU9u5hOLqNBWCQemtDpTNS3lErkD3t4sJBZt/wX/kqqP6K4hKHBhsr9S+lOCmoE8KF1++Cxyzd8Pj6MEMkfnRL8dkeR/8Wa3/QX4UppO7ykXFErqHUN2smmZLsy7fKzFxGskwq+Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115152; c=relaxed/simple;
	bh=GJrtu7I2epYO6j1RMbl/uIUyxnpASqo4eBWtQdRkI+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YeozmY0sc60baxaS7N5aMPtEb3Cnm6xA3dXBoyAOVkYScsiZvDupekF9Xk9Od4EaZ4p1ewo2Ocj9B+DEMhJsOjlAYGQHLT7D3A753JhBQ7gEAoOJJGaTGJZLt/D4utTKu8NPMNq/S+HsRgIfdyDG5lw1QZka6ak77PQXGmK4e2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-297108e7001so1988170a91.1;
        Fri, 16 Feb 2024 12:25:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708115150; x=1708719950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hUD1Qj4ogPKSm/Sr3r1n8tx+Z+/CZkerzMxnHgkBW8=;
        b=c8ntYFvOwISlE8oInaJpS+yJ17zr22z7L8TNmu8T8R0zKEGT88VcpEZ6AkHGWjAIxW
         wQKyCRZJYBHFoVi4A2SQnvnSm+vK9izzl7k+n+PyikdS+7LLZ1uKmvxI35UxfO5+gp83
         NtuLc8wUgxM9ywaHpR4QmU+mAc2HgVWWlUaqZW0+A15f8jlPRUCasxjtYScoPnejdaBS
         NExIA/B8012JGvz4z+DPSwDm66RHLLfAgWOCYA3tdwggPbxr//u3YSZwmsthza4vgUnY
         IOT2TMDg893t4q3APlG6l3Msobk+NnFOEKr4WJ4uJH97peMD3CVwIsBqreUKUWvqNHrM
         Tahg==
X-Forwarded-Encrypted: i=1; AJvYcCU9kXpPjP3tJiolNJjyRYETpswgil3TKx+W0fAU8DAM/nZ2y8RizheWR7p+kshHBidVKO34Q8yRMqpQDo81yqZ2Rzm4ZFU2fMIN0UJVIiYY4oCWMjyde4hXiIGjCkUBhFi8Yds0g8GHJo/JIaSZcDIr0TMWzyUmk6jFKMnj3j8wKzB81w==
X-Gm-Message-State: AOJu0YxKuANkwJtCvN1laMFZf/NaKkw6ghzcscVyC7wczKc4u8Ph+SIS
	GVUtZaC4CYwI2BsuIohXYz5/7XEXZdCCrLYy9w7xH98NEmyUtsPnmA6bEjzmaXs1vsN0grjvNJV
	gRoOzZKAJd/ne1vM+mHmDz8/wcEo=
X-Google-Smtp-Source: AGHT+IG84yp2N2u//oppiy9VfZeUtMlsnudrPF6qYg6OzGwQn9hnl4H12B2h7YD93C53LomgBM+eXFKAJcl7j+eAqLE=
X-Received: by 2002:a17:90b:1497:b0:299:3036:9ab5 with SMTP id
 js23-20020a17090b149700b0029930369ab5mr3026822pjb.43.1708115149899; Fri, 16
 Feb 2024 12:25:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214063708.972376-1-irogers@google.com> <20240214063708.972376-2-irogers@google.com>
 <Zcz3UO5Jq4zAqSfx@x1> <CAP-5=fXeLX8i8sK8EVquDqnV31rtum_K4TLtw5nG=nfL9-PKvQ@mail.gmail.com>
In-Reply-To: <CAP-5=fXeLX8i8sK8EVquDqnV31rtum_K4TLtw5nG=nfL9-PKvQ@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 16 Feb 2024 12:25:38 -0800
Message-ID: <CAM9d7cjb7XDH6JgbKg07RJ4ypzPm12+mpBDE7mGXyUP3SJ8V1g@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] perf report: Sort child tasks by tid
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 9:42=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Feb 14, 2024 at 9:24=E2=80=AFAM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Tue, Feb 13, 2024 at 10:37:03PM -0800, Ian Rogers wrote:
> > > Commit 91e467bc568f ("perf machine: Use hashtable for machine
> > > threads") made the iteration of thread tids unordered. The perf repor=
t
> > > --tasks output now shows child threads in an order determined by the
> > > hashing. For example, in this snippet tid 3 appears after tid 256 eve=
n
> > > though they have the same ppid 2:
> > >
> > > ```
> > > $ perf report --tasks
> > > %      pid      tid     ppid  comm
> > >          0        0       -1 |swapper
> > >          2        2        0 | kthreadd
> > >        256      256        2 |  kworker/12:1H-k
> > >     693761   693761        2 |  kworker/10:1-mm
> > >    1301762  1301762        2 |  kworker/1:1-mm_
> > >    1302530  1302530        2 |  kworker/u32:0-k
> > >          3        3        2 |  rcu_gp
> > > ...
> > > ```
> > >
> > > The output is easier to read if threads appear numerically
> > > increasing. To allow for this, read all threads into a list then sort
> > > with a comparator that orders by the child task's of the first common
> > > parent. The list creation and deletion are created as utilities on
> > > machine.  The indentation is possible by counting the number of
> > > parents a child has.
> > >
> > > With this change the output for the same data file is now like:
> > > ```
> > > $ perf report --tasks
> > > %      pid      tid     ppid  comm
> > >          0        0       -1 |swapper
> > >          1        1        0 | systemd
> > >        823      823        1 |  systemd-journal
> > >        853      853        1 |  systemd-udevd
> > >       3230     3230        1 |  systemd-timesyn
> > >       3236     3236        1 |  auditd
> > >       3239     3239     3236 |   audisp-syslog
> > >       3321     3321        1 |  accounts-daemon
> >
> >
> > Since we're adding extra code for sorting wouldn't be more convenient t=
o
> > have this done in an graphically hierarchical output?
> >
> > But maybe to make this honour asking for a CSV output the above is
> > enough? Or can we have both, i.e. for people just doing --tasks, the
> > hirarchical way, for CSV, then like above, with the comma separator.
> >
> > But then perf stat has -x to ask for CSV that is used by the more
> > obscure --exclude-other option :-\
> >
> > Maybe we need a --csv that is consistent accross all tools.
>
> I've no objection to a graphical/CSV output, I was in this code as I
> was restructuring it for memory savings. Fixing the output ordering
> was a side-effect, the "graphical" sorting/indentation is mentioned as
> it is carrying forward a behavior from the previous code but done in a
> somewhat different way. Let's have other output things as follow up
> work.

Agreed, maybe a good project for GSoC students..

Thanks,
Namhyung

