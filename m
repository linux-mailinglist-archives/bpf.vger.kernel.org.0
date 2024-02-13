Return-Path: <bpf+bounces-21824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9556E852789
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 03:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 701AA1C2337E
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 02:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6701F3D6D;
	Tue, 13 Feb 2024 02:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flN+DJdF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3701415B7;
	Tue, 13 Feb 2024 02:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707792141; cv=none; b=DmfXEYKVWFJuRQSCIVBYQal3E9auIDfAJr28YiHl6VEChrEOfqucEHPbRsLHU0QGavrfPU0U8kNwzqqQN47Bb3PNwJpeTbZk1aqp5xbFZUPUA+ebUEKXSC6okJAL+bOGWboth1IP6RcF/deRkNAnC4RyjrYxGaIVF6Vc77B5Aiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707792141; c=relaxed/simple;
	bh=/9hajlwYk/rvsyuO51iMyQDNbLLqRFyaoZc4ehCnN7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OmwCIL07N/nfpF78zAQWLwiAzsEVITdWxjpl1RQjvYTv0CzxHAiukHXwEHptsuzg2ntUs8m2Bd99yra7HVaE8zeWGUpt+nJtBrYf8nX6gS5ioJhr/mxrJLvWx483mHSWuxQxxXinoVV16A+KcJu3NhTzv0JNYn0FCLvqZ7uD0Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flN+DJdF; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33934567777so2544857f8f.1;
        Mon, 12 Feb 2024 18:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707792137; x=1708396937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rxk9tTynWHUWVnj9UZhwfBhaRWhwkQhpAgLGbZWzgJc=;
        b=flN+DJdFLib4HqTob2u90SLMPRx/1z9ta4Prye8Zbc3ZG05UTQ69PH38J4zwH0oGlH
         idQQHNqVZP30sHjJmcxLowdfMvuBzT2Em4kyDApNxVdFnpBU/YAF0NkGSeQN1JIzzqf8
         YO0FcRzrVvl1ZaTfROa9HHNj3FxM5avHJQjlW40cOg2ZB8hKcDmH2IRTM4m0APcB3s7A
         xj6sSnMDt85NdeFI9afin/pKnnB8B3OZMucxnyG0vPglAeui1F2SfE0KFo+sQosjomJ8
         H5y6mMnMOYTzNy4FWbiGd7SFl00k7YBWNNJ6csZk84Awqd2OvCiTFmQNsXQMBDlQRwS6
         lPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707792137; x=1708396937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rxk9tTynWHUWVnj9UZhwfBhaRWhwkQhpAgLGbZWzgJc=;
        b=GWHjBH6pz1vs81o+298Ui9ttdRMKIe7vfKNSLEAMFksGVmYKcJHPSajHTMWuVqYe7y
         f687sPv8sPa56jY/CEfNQlyGcC3KkAKZQxioy9ZxKOaJJ+O0A++GKAZcVxaHjU8JnTO7
         4g/worB22A0yldxSdHgvMp4R6pAicZyGvMg32wFdkchH+Bo5oPL+8VLK/te+TqY334l4
         JpYZg3jWqcbuTYhQVQQP58lfSfmDuUsB9XZSpWp1HYtEGaW7Jd6k1Xdg7wHmrkZ+7drf
         Kzey3DPQddSlqBI+iaowM7CveHh8m56SmjIGbTA+tf8cAGwRLC7kAa/6uwqoD93rUZq/
         8FPw==
X-Forwarded-Encrypted: i=1; AJvYcCWnZUG9EZUq9ZjcZQFfd4w9oRV5TIhOVb8PtjpfXL46Aes2S7nls0JpYjHqA2PlWqUM4kUS5/WfMM7rY3HQ5XpFoly8cf7O8jeruVrKpJe9DUE94x+7zguuxAXZs5a7Inhc
X-Gm-Message-State: AOJu0Ywk6lckl/7FLA7vzPeIlrKvae4AnVPozsNrgAwwcf00ghl3rOOm
	sOO+YLhqfyZ0eEG9dt5C3rDThPD5X0V5tE2eubA0KUtHlZ6SIzycGMf5dg5MwdaDOvQYrEEhQcE
	ZC+Jx64+6S4mVjcdSm+NyS6QhSSI=
X-Google-Smtp-Source: AGHT+IHtztV834P91o8nikwmI9WOia8raU0tU6uGzvQQMfDeYO1FL4vchpLUrS1j73DWy/WlKhq5Sc1ooP1iFZyiVX8=
X-Received: by 2002:a5d:5f93:0:b0:33a:e6e4:945d with SMTP id
 dr19-20020a5d5f93000000b0033ae6e4945dmr8307057wrb.2.1707792137151; Mon, 12
 Feb 2024 18:42:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122062535.8265-1-khuey@kylehuey.com> <CAP045Apecy=G_Wmcw6TMjSDfa3TbkMfFVkzGDJ9xTVksCLkZ0w@mail.gmail.com>
In-Reply-To: <CAP045Apecy=G_Wmcw6TMjSDfa3TbkMfFVkzGDJ9xTVksCLkZ0w@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 Feb 2024 18:42:05 -0800
Message-ID: <CAADnVQ+tRwMZiPa9Zrf6nD22dfF9MAiqv-1ML5Z2pELFNKa9KQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Combine perf and bpf for fast eval of hw
 breakpoint conditions
To: Kyle Huey <me@kylehuey.com>
Cc: Kyle Huey <khuey@kylehuey.com>, LKML <linux-kernel@vger.kernel.org>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, "Robert O'Callahan" <robert@ocallahan.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 8:37=E2=80=AFAM Kyle Huey <me@kylehuey.com> wrote:
>
> On Sun, Jan 21, 2024 at 10:25=E2=80=AFPM Kyle Huey <me@kylehuey.com> wrot=
e:
> >
> > rr, a userspace record and replay debugger[0], replays asynchronous eve=
nts
> > such as signals and context switches by essentially[1] setting a breakp=
oint
> > at the address where the asynchronous event was delivered during record=
ing
> > with a condition that the program state matches the state when the even=
t
> > was delivered.
> >
> > Currently, rr uses software breakpoints that trap (via ptrace) to the
> > supervisor, and evaluates the condition from the supervisor. If the
> > asynchronous event is delivered in a tight loop (thus requiring the
> > breakpoint condition to be repeatedly evaluated) the overhead can be
> > immense. A patch to rr that uses hardware breakpoints via perf events w=
ith
> > an attached BPF program to reject breakpoint hits where the condition i=
s
> > not satisfied reduces rr's replay overhead by 94% on a pathological (bu=
t a
> > real customer-provided, not contrived) rr trace.
> >
> > The only obstacle to this approach is that while the kernel allows a BP=
F
> > program to suppress sample output when a perf event overflows it does n=
ot
> > suppress signalling the perf event fd or sending the perf event's SIGTR=
AP.
> > This patch set redesigns __perf_overflow_handler() and
> > bpf_overflow_handler() so that the former invokes the latter directly w=
hen
> > appropriate rather than through the generic overflow handler machinery,
> > passes the return code of the BPF program back to __perf_overflow_handl=
er()
> > to allow it to decide whether to execute the regular overflow handler,
> > reorders bpf_overflow_handler() and the side effects of perf event
> > overflow, changes __perf_overflow_handler() to suppress those side effe=
cts
> > if the BPF program returns zero, and adds a selftest.
> >
> > The previous version of this patchset can be found at
> > https://lore.kernel.org/linux-kernel/20240119001352.9396-1-khuey@kylehu=
ey.com/
> >
> > Changes since v4:
> >
> > Patches 1, 2, 3, 4 added various Acked-by.
> >
> > Patch 4 addresses additional nits from Song.
> >
> > v3 of this patchset can be found at
> > https://lore.kernel.org/linux-kernel/20231211045543.31741-1-khuey@kyleh=
uey.com/
> >
> > Changes since v3:
> >
> > Patches 1, 2, 3 added various Acked-by.
> >
> > Patch 4 addresses Song's review comments by dropping signals_expected a=
nd the
> > corresponding ASSERT_OKs, handling errors from signal(), and fixing mul=
tiline
> > comment formatting.
> >
> > v2 of this patchset can be found at
> > https://lore.kernel.org/linux-kernel/20231207163458.5554-1-khuey@kylehu=
ey.com/
> >
> > Changes since v2:
> >
> > Patches 1 and 2 were added from a suggestion by Namhyung Kim to refacto=
r
> > this code to implement this feature in a cleaner way. Patch 2 is separa=
ted
> > for the benefit of the ARM arch maintainers.
> >
> > Patch 3 conceptually supercedes v2's patches 1 and 2, now with a cleane=
r
> > implementation thanks to the earlier refactoring.
> >
> > Patch 4 is v2's patch 3, and addresses review comments about C++ style
> > comments, getting a TRAP_PERF definition into the test, and unnecessary
> > NULL checks.
> >
> > [0] https://rr-project.org/
> > [1] Various optimizations exist to skip as much as execution as possibl=
e
> > before setting a breakpoint, and to determine a set of program state th=
at
> > is practical to check and verify.
>
> Since everyone seems to be satisfied with this now, can we get it into
> bpf-next (or wherever) for 6.9?

The changes look fine, but since they change perf side we need
perf maintainer's ack-s before we can land the patches.
And none of them were cc-ed.
So please resend the whole set and cc
PERFORMANCE EVENTS SUBSYSTEM
M:      Peter Zijlstra <peterz@infradead.org>
M:      Ingo Molnar <mingo@redhat.com>
M:      Arnaldo Carvalho de Melo <acme@kernel.org>
M:      Namhyung Kim <namhyung@kernel.org>

