Return-Path: <bpf+bounces-21862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A55DC853860
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 18:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B26F1F2892D
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 17:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE8A604D7;
	Tue, 13 Feb 2024 17:35:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC60604BC;
	Tue, 13 Feb 2024 17:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845754; cv=none; b=fcIH73j84jZ6uwXhkpyK/cU91EgHxo7i/w8Hl3kBy/Dgox5fEDyOXvj7pzzuQWKZ0ooreXw+5bhUGBalQ8n63I+WPJW+hLf9xDitzKPGHKYA98qYfB2t3IYGyZMUT0oAT2Kc6zAVsouHU/WpVqiCPMyaHeIMRexGso6c8jF4tOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845754; c=relaxed/simple;
	bh=w1JomXnVeLI4MA0rDKNXo6hV6XaIbmS9RWIewRAWYFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ilKFHE6xncmCaSkg+4KKfWtibJmR7NEUn0GCmTcx7YfJ96aruP0H4mzzVukmRLtq+wXbMoRf7fcuqGzfr3HuH8EC5TWR9FZ5hqJWGWOcQ1eDfga2EflrCwEa1FKbGznom4HWf7Jj725mudY0JymzsxPrLKjDBN/D7YhCJhcziDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d73066880eso42553895ad.3;
        Tue, 13 Feb 2024 09:35:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707845752; x=1708450552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whrnsXTyKI9UGwzj48XrHgmMnZYTDLT9RoWvxO8dIUQ=;
        b=flPKUS7wgC+6gJMUoQw+P9rS8A937fY2GyChAp2KD9lQUrJEGZFLF2JHWuml1byart
         x27PyjRumK/PXRc/XrOt9izxUy1UqDpbre1KTxLaijKzorcg39+0m+IXpuqHkOBLBJqE
         pj6QgW1x9QyGH9xUT/zI0G4IAHMilo2DMcJFdhqsJQ4u+yjRLhwdA2o1wtDC3qe1y+/Y
         yTFxM3IsO5fgqK13EUiHrMAtnSVKwgtLQ/x2mzcZYaWviMZQxkXeWu2ZkD+1iKfAJ47B
         CQJlTLZnKacIgLA8sh2mOShkIlBfzZRVaBb3KCX6NorG192DVFJ/lL3VgIern4Gb8iUR
         t0MQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNbNsk/OO5l+dkENVYSDVuvtWqWjSceuzWbyZ2A/yXSn5Q85tG6w7rPQXD601zoAbX2Q3YxKil4qW7iAyVQZtrI3q0UeJfs0jrN6UMoaDFaRYwXPenFmAOiF7WfeHGRARh
X-Gm-Message-State: AOJu0Yx3JtvdLGxv5ScJ207kHfNMPtb7BXVA26M4Zz6XWhv6ZcOsHPBx
	4S4C19E1G6r97ofPuvkj+cw1RG9Aj5GSZbIJrQ/iXYkEgyapePF3dfqJdMKmf0EYdkx6q56UqmL
	Xw2kljckPS0h27pSRr8F7r9r+gyc=
X-Google-Smtp-Source: AGHT+IGsJHfa6vUZvMxcrVEarhYgpxxjvzmv0NPalE8qE+SJN0CHD1l4sGTv0XjvlcsqBIaw/bHlCbpOgnu/i/eLcyE=
X-Received: by 2002:a17:902:cecc:b0:1d9:87b6:e09e with SMTP id
 d12-20020a170902cecc00b001d987b6e09emr256807plg.21.1707845751877; Tue, 13 Feb
 2024 09:35:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122062535.8265-1-khuey@kylehuey.com> <CAP045Apecy=G_Wmcw6TMjSDfa3TbkMfFVkzGDJ9xTVksCLkZ0w@mail.gmail.com>
 <CAADnVQ+tRwMZiPa9Zrf6nD22dfF9MAiqv-1ML5Z2pELFNKa9KQ@mail.gmail.com> <CAP045Aoc3e1NE8VMWz67LZNVo68nGhxfgapjd30vAaSyBD4kFg@mail.gmail.com>
In-Reply-To: <CAP045Aoc3e1NE8VMWz67LZNVo68nGhxfgapjd30vAaSyBD4kFg@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 13 Feb 2024 09:35:39 -0800
Message-ID: <CAM9d7chDGjpQ7dJ_EvhaV3RpudDw6e1ns-MZ=T0Q_nkKb4NvEQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Combine perf and bpf for fast eval of hw
 breakpoint conditions
To: Kyle Huey <me@kylehuey.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Kyle Huey <khuey@kylehuey.com>, 
	LKML <linux-kernel@vger.kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Jiri Olsa <jolsa@kernel.org>, Marco Elver <elver@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, "Robert O'Callahan" <robert@ocallahan.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Feb 12, 2024 at 7:57=E2=80=AFPM Kyle Huey <me@kylehuey.com> wrote:
>
> On Mon, Feb 12, 2024 at 6:42=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Feb 12, 2024 at 8:37=E2=80=AFAM Kyle Huey <me@kylehuey.com> wro=
te:
> > >
> > > On Sun, Jan 21, 2024 at 10:25=E2=80=AFPM Kyle Huey <me@kylehuey.com> =
wrote:
> > > >
> > > > rr, a userspace record and replay debugger[0], replays asynchronous=
 events
> > > > such as signals and context switches by essentially[1] setting a br=
eakpoint
> > > > at the address where the asynchronous event was delivered during re=
cording
> > > > with a condition that the program state matches the state when the =
event
> > > > was delivered.
> > > >
> > > > Currently, rr uses software breakpoints that trap (via ptrace) to t=
he
> > > > supervisor, and evaluates the condition from the supervisor. If the
> > > > asynchronous event is delivered in a tight loop (thus requiring the
> > > > breakpoint condition to be repeatedly evaluated) the overhead can b=
e
> > > > immense. A patch to rr that uses hardware breakpoints via perf even=
ts with
> > > > an attached BPF program to reject breakpoint hits where the conditi=
on is
> > > > not satisfied reduces rr's replay overhead by 94% on a pathological=
 (but a
> > > > real customer-provided, not contrived) rr trace.
> > > >
> > > > The only obstacle to this approach is that while the kernel allows =
a BPF
> > > > program to suppress sample output when a perf event overflows it do=
es not
> > > > suppress signalling the perf event fd or sending the perf event's S=
IGTRAP.
> > > > This patch set redesigns __perf_overflow_handler() and
> > > > bpf_overflow_handler() so that the former invokes the latter direct=
ly when
> > > > appropriate rather than through the generic overflow handler machin=
ery,
> > > > passes the return code of the BPF program back to __perf_overflow_h=
andler()
> > > > to allow it to decide whether to execute the regular overflow handl=
er,
> > > > reorders bpf_overflow_handler() and the side effects of perf event
> > > > overflow, changes __perf_overflow_handler() to suppress those side =
effects
> > > > if the BPF program returns zero, and adds a selftest.
> > > >
> > > > The previous version of this patchset can be found at
> > > > https://lore.kernel.org/linux-kernel/20240119001352.9396-1-khuey@ky=
lehuey.com/
> > > >
> > > > Changes since v4:
> > > >
> > > > Patches 1, 2, 3, 4 added various Acked-by.
> > > >
> > > > Patch 4 addresses additional nits from Song.
> > > >
> > > > v3 of this patchset can be found at
> > > > https://lore.kernel.org/linux-kernel/20231211045543.31741-1-khuey@k=
ylehuey.com/
> > > >
> > > > Changes since v3:
> > > >
> > > > Patches 1, 2, 3 added various Acked-by.
> > > >
> > > > Patch 4 addresses Song's review comments by dropping signals_expect=
ed and the
> > > > corresponding ASSERT_OKs, handling errors from signal(), and fixing=
 multiline
> > > > comment formatting.
> > > >
> > > > v2 of this patchset can be found at
> > > > https://lore.kernel.org/linux-kernel/20231207163458.5554-1-khuey@ky=
lehuey.com/
> > > >
> > > > Changes since v2:
> > > >
> > > > Patches 1 and 2 were added from a suggestion by Namhyung Kim to ref=
actor
> > > > this code to implement this feature in a cleaner way. Patch 2 is se=
parated
> > > > for the benefit of the ARM arch maintainers.
> > > >
> > > > Patch 3 conceptually supercedes v2's patches 1 and 2, now with a cl=
eaner
> > > > implementation thanks to the earlier refactoring.
> > > >
> > > > Patch 4 is v2's patch 3, and addresses review comments about C++ st=
yle
> > > > comments, getting a TRAP_PERF definition into the test, and unneces=
sary
> > > > NULL checks.
> > > >
> > > > [0] https://rr-project.org/
> > > > [1] Various optimizations exist to skip as much as execution as pos=
sible
> > > > before setting a breakpoint, and to determine a set of program stat=
e that
> > > > is practical to check and verify.
> > >
> > > Since everyone seems to be satisfied with this now, can we get it int=
o
> > > bpf-next (or wherever) for 6.9?
> >
> > The changes look fine, but since they change perf side we need
> > perf maintainer's ack-s before we can land the patches.
> > And none of them were cc-ed.
> > So please resend the whole set and cc
> > PERFORMANCE EVENTS SUBSYSTEM
> > M:      Peter Zijlstra <peterz@infradead.org>
> > M:      Ingo Molnar <mingo@redhat.com>
> > M:      Arnaldo Carvalho de Melo <acme@kernel.org>
> > M:      Namhyung Kim <namhyung@kernel.org>
>
> They're all CCd to the three non-test patches in this set, Namhyung
> Kim is CCd to all of them and this cover email, and he both suggested
> the first patch and acked the third.

I think we need to wait for Peter or Ingo for the kernel part.

Thanks,
Namhyung

