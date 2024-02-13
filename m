Return-Path: <bpf+bounces-21827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CE88527E5
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 04:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B39F2849C1
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 03:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326F9A93C;
	Tue, 13 Feb 2024 03:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="bfXONbeI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5AA883B
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 03:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707796676; cv=none; b=dIpO5FpiLBxYLgRpx0uD/MRvcD6YWyb+D/Dh5dLL+lISdVW3g9PvR3zjsWqWXXgK2QcKU3Jq+WR9TaazdPP6IyQyjJw5hM9ZUYE0GS6z6zrjNqkkS9L06ulH9cweJ8X4mNe3lsedQ+rSDLSHyxaxBwv8i1dTR6eKnnS2A760+zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707796676; c=relaxed/simple;
	bh=bN6dK6aD4FKyqegpnhvZEjDICtz9+BSGPPA7uv6RYgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ai0C4ZEibTdiO8j27GSLWwpJGDNAiGdqlyCgNVbu94FQOUXa6oAvkBJH8uJyjhJcsMhdN5QTY66t/I221OF0SXHP5RaSoH0j8cpUsaybp9k2OWVIZdHE21N9JVP4m66YouBb+3Q9DgBys6YmlDu0J+gHaOfvG6q1IZQT0fVT7ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=bfXONbeI; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-511490772f6so4835868e87.2
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 19:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1707796673; x=1708401473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGDUec+ltrfJRSqU4fW2OgD37xMy9JdASW7ExQePVdQ=;
        b=bfXONbeIwgulPmbNIGSf3ZL3eerOXb59wypn7JW2Io7Rp8kOgFTW3N+UWfs1IfPQBx
         cc/20zR2N/3OOt5j46uwtp1wSbw62eS2iUvpRHkEXYA2+JfYSfSjItBG+MrhDIFdEB8e
         9lfhIvyZT61V2Qv62C5AflXNlSQ24Dy4J75SKq+1xw++gBkrBovZUgj66WGJ3kEnSAKL
         GNOf/iFlguMLqybAXhYJgPsQgepHOmxNHK8lrb1Htz0/9rpObut8bUiN+zL9pMbGidll
         kgiGPotOEZaK55/n/ir5NSIBadEmltbCRGBxOqDYThNcqX6Vb/X6LAzJMqUtNkCELp+w
         aMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707796673; x=1708401473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGDUec+ltrfJRSqU4fW2OgD37xMy9JdASW7ExQePVdQ=;
        b=ae1Vd5fOWevBTBY5zFTTMjDUPYlBSap0jP8AnZz29zHTQwofZ5E196XcFd47Hla8VZ
         teIUgNiplINVTX8xocNuSann91GiptYI7LeBMzKvCOsSl3gVk6XryQvLybVuKwvmUlGL
         LTvMX6JkvILPxQ0H391mAysDDpbVveYNmhDH34Bt+U9MaKmTC9/EJMQOFhKyucOOdQ+U
         pu3ihaYGfimTUvRUXMJhjQajoSJAlFjOCZPFcB/SZFl3P5Qi2lrQ0NkyfzLrTaLLS26P
         IrApkgHjWEZJwVZxshFo+PsXRbGVL/xp7Qo0dDJg25y9ePPPVTmiZ+eksGsGusXS08YP
         dp6g==
X-Gm-Message-State: AOJu0YysI3E0xQ34qEQ+b/7ruc7pEvyxRMMxUS1d12w3XzSJHsyfzeFF
	eaE01zKeiWsnbK2KnUSVcBeh54IJ1UsCcQaDPy1tGw3EdKEwGRGfZmqr5Kj75O1360FhEikIQQy
	E2p2s7mCUx5YK0nW3XRF2rAG/R9Su/q6+7dus
X-Google-Smtp-Source: AGHT+IGQ73ms9lvthgj1vaExSwJhqchVTtOPhgRTVKEo8nXQ6D60UgUj5YD6xewgwpha12/NNyS7VOLR2tN8UZ5sPds=
X-Received: by 2002:a05:6512:2e9:b0:511:2e97:add2 with SMTP id
 m9-20020a05651202e900b005112e97add2mr5394630lfq.66.1707796672701; Mon, 12 Feb
 2024 19:57:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122062535.8265-1-khuey@kylehuey.com> <CAP045Apecy=G_Wmcw6TMjSDfa3TbkMfFVkzGDJ9xTVksCLkZ0w@mail.gmail.com>
 <CAADnVQ+tRwMZiPa9Zrf6nD22dfF9MAiqv-1ML5Z2pELFNKa9KQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+tRwMZiPa9Zrf6nD22dfF9MAiqv-1ML5Z2pELFNKa9KQ@mail.gmail.com>
From: Kyle Huey <me@kylehuey.com>
Date: Mon, 12 Feb 2024 19:57:39 -0800
Message-ID: <CAP045Aoc3e1NE8VMWz67LZNVo68nGhxfgapjd30vAaSyBD4kFg@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Combine perf and bpf for fast eval of hw
 breakpoint conditions
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kyle Huey <khuey@kylehuey.com>, LKML <linux-kernel@vger.kernel.org>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, "Robert O'Callahan" <robert@ocallahan.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 6:42=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Feb 12, 2024 at 8:37=E2=80=AFAM Kyle Huey <me@kylehuey.com> wrote=
:
> >
> > On Sun, Jan 21, 2024 at 10:25=E2=80=AFPM Kyle Huey <me@kylehuey.com> wr=
ote:
> > >
> > > rr, a userspace record and replay debugger[0], replays asynchronous e=
vents
> > > such as signals and context switches by essentially[1] setting a brea=
kpoint
> > > at the address where the asynchronous event was delivered during reco=
rding
> > > with a condition that the program state matches the state when the ev=
ent
> > > was delivered.
> > >
> > > Currently, rr uses software breakpoints that trap (via ptrace) to the
> > > supervisor, and evaluates the condition from the supervisor. If the
> > > asynchronous event is delivered in a tight loop (thus requiring the
> > > breakpoint condition to be repeatedly evaluated) the overhead can be
> > > immense. A patch to rr that uses hardware breakpoints via perf events=
 with
> > > an attached BPF program to reject breakpoint hits where the condition=
 is
> > > not satisfied reduces rr's replay overhead by 94% on a pathological (=
but a
> > > real customer-provided, not contrived) rr trace.
> > >
> > > The only obstacle to this approach is that while the kernel allows a =
BPF
> > > program to suppress sample output when a perf event overflows it does=
 not
> > > suppress signalling the perf event fd or sending the perf event's SIG=
TRAP.
> > > This patch set redesigns __perf_overflow_handler() and
> > > bpf_overflow_handler() so that the former invokes the latter directly=
 when
> > > appropriate rather than through the generic overflow handler machiner=
y,
> > > passes the return code of the BPF program back to __perf_overflow_han=
dler()
> > > to allow it to decide whether to execute the regular overflow handler=
,
> > > reorders bpf_overflow_handler() and the side effects of perf event
> > > overflow, changes __perf_overflow_handler() to suppress those side ef=
fects
> > > if the BPF program returns zero, and adds a selftest.
> > >
> > > The previous version of this patchset can be found at
> > > https://lore.kernel.org/linux-kernel/20240119001352.9396-1-khuey@kyle=
huey.com/
> > >
> > > Changes since v4:
> > >
> > > Patches 1, 2, 3, 4 added various Acked-by.
> > >
> > > Patch 4 addresses additional nits from Song.
> > >
> > > v3 of this patchset can be found at
> > > https://lore.kernel.org/linux-kernel/20231211045543.31741-1-khuey@kyl=
ehuey.com/
> > >
> > > Changes since v3:
> > >
> > > Patches 1, 2, 3 added various Acked-by.
> > >
> > > Patch 4 addresses Song's review comments by dropping signals_expected=
 and the
> > > corresponding ASSERT_OKs, handling errors from signal(), and fixing m=
ultiline
> > > comment formatting.
> > >
> > > v2 of this patchset can be found at
> > > https://lore.kernel.org/linux-kernel/20231207163458.5554-1-khuey@kyle=
huey.com/
> > >
> > > Changes since v2:
> > >
> > > Patches 1 and 2 were added from a suggestion by Namhyung Kim to refac=
tor
> > > this code to implement this feature in a cleaner way. Patch 2 is sepa=
rated
> > > for the benefit of the ARM arch maintainers.
> > >
> > > Patch 3 conceptually supercedes v2's patches 1 and 2, now with a clea=
ner
> > > implementation thanks to the earlier refactoring.
> > >
> > > Patch 4 is v2's patch 3, and addresses review comments about C++ styl=
e
> > > comments, getting a TRAP_PERF definition into the test, and unnecessa=
ry
> > > NULL checks.
> > >
> > > [0] https://rr-project.org/
> > > [1] Various optimizations exist to skip as much as execution as possi=
ble
> > > before setting a breakpoint, and to determine a set of program state =
that
> > > is practical to check and verify.
> >
> > Since everyone seems to be satisfied with this now, can we get it into
> > bpf-next (or wherever) for 6.9?
>
> The changes look fine, but since they change perf side we need
> perf maintainer's ack-s before we can land the patches.
> And none of them were cc-ed.
> So please resend the whole set and cc
> PERFORMANCE EVENTS SUBSYSTEM
> M:      Peter Zijlstra <peterz@infradead.org>
> M:      Ingo Molnar <mingo@redhat.com>
> M:      Arnaldo Carvalho de Melo <acme@kernel.org>
> M:      Namhyung Kim <namhyung@kernel.org>

They're all CCd to the three non-test patches in this set, Namhyung
Kim is CCd to all of them and this cover email, and he both suggested
the first patch and acked the third.

- Kyle

