Return-Path: <bpf+bounces-21740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7570A851963
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 17:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13D671F2275A
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 16:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B4E3DB91;
	Mon, 12 Feb 2024 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="Zs25J2r0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334043D96E
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755409; cv=none; b=nV7nFSPu7Guqj6R5xsWR0PkfTAH30vYMNs39BYEd+sttbubKv/+Gh6ClU/d1mASb3Q6hzTH3BgXnva9N9Wz+9qSNHVKN9/Ns3JXhCO/fZvqoSES/GTbDXlbPyVwwK06qpdvpzvGohLysBI7zV1OgojBWHrV3EHgszP0VCaKrnPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755409; c=relaxed/simple;
	bh=x7Wh7XTCkC+HIYtlIWvgYoPEMwJ1MLo8vCxPc9BeGE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bbQlbRnvctEqFyh8slkmfcNZ2TVLF4EfE6ysoUtSO09FTTnV7qB6Ro1xXbS1xCQ/RB0MD1xI92KwhOYEeq0adWlqBy2Be2xV4BgJpg7ch4uDZqaqHSrFbGsVtezeSgpEzV3ZUeAqlZQlDb5nNUUYKEbqGjbDOpC4iZN12LKNSXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=Zs25J2r0; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55790581457so5249337a12.3
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 08:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1707755405; x=1708360205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7Wh7XTCkC+HIYtlIWvgYoPEMwJ1MLo8vCxPc9BeGE4=;
        b=Zs25J2r0KSMuW1eAEehlrNBnjlygWgKfWQxBkA6+CdTsj2fPiEFobYHVyKnOTwpUJR
         VFFN+7SQoOkEOfsvZdKarCmerDUMUPTmjlqteyOpQT6a0oxMnMjEasR/lHCT8KmQm64i
         8XozkJvxCQibKKzBQYNDeJo6PSbai4H5IyCoJKY7DuI8ivBvrc1zCMPJDAYlDZmA9dkp
         JwI4DPR3kgGzxpfgNxvZW5DtH0rlA0K/rxSB2cpj9N2D7W0jC1qVSNYXAEQdOLey/jfx
         dONjoi/Z+bQgri0I4AYY067dIcyhCe30/+F2SQdVPA13+DeGFOdh28eF6wlaput3F0Ns
         k6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707755405; x=1708360205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x7Wh7XTCkC+HIYtlIWvgYoPEMwJ1MLo8vCxPc9BeGE4=;
        b=wDD3USro03zxnEzqAv/JmP5dw3fllNkrBkG5T4gjbqWpZEcQIKOcCXguPIUPUUxDLu
         WKu2Cngp8QOb2pz2OzWImQAEUXRPBAOyiKDXAPcwyu73zzHhY4+xxe4l+j7U2etVdnlQ
         wa/hwRezCUv5BFIepwhxhvduWERfKTdktEU9GyZCBTJaWWA8M3bcK+/2+a/FTxq07DZL
         PeEamm4K380FnYSySd+SYVfJqkYNOmTdC0LCO3oSvob7p2EBY8ZJap2tE89wf6ah+jo1
         yXXS/A5CCJaSk/x30lMeMNB5YzONmVPHKFBkDnP2DSSbl3K7jRmgBKhebMg/3iWFHf6d
         mG8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtJyoKAC0cjQx3OtSmim9fqwvVOk9boX0BQY/PVd9wHbkJBUB8okwIVGj4CbiwaGBVYm9c1ya+UoALnvC5EY40qH9d
X-Gm-Message-State: AOJu0YwpWufjRWFjm7RqCoY9+ZVKIEN610jhZRGteZAIQgse4lFOJ5p9
	GSxKzbadGMOgh/CaoJFQjJqiy2Nhh5NOVScD5e1Wm8bGbyV1WbZFQ3x59CbzmDqa1AnnHyHnZZw
	wtClWjJlnjxy+p5KZsUVp4UEgrV4kvdg81tM9
X-Google-Smtp-Source: AGHT+IHPhjGekzFaAxOSY3AMoXRTFxX3dpE7iDUR78El8uM/U7K4LFQWafnE7Y9AmTxxssX1hIBGdqnq/CfbOXChbDk=
X-Received: by 2002:aa7:db54:0:b0:561:e8c:793a with SMTP id
 n20-20020aa7db54000000b005610e8c793amr5269696edt.33.1707755405177; Mon, 12
 Feb 2024 08:30:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122062535.8265-1-khuey@kylehuey.com>
In-Reply-To: <20240122062535.8265-1-khuey@kylehuey.com>
From: Kyle Huey <me@kylehuey.com>
Date: Mon, 12 Feb 2024 08:29:53 -0800
Message-ID: <CAP045Apecy=G_Wmcw6TMjSDfa3TbkMfFVkzGDJ9xTVksCLkZ0w@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Combine perf and bpf for fast eval of hw
 breakpoint conditions
To: Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>
Cc: "Robert O'Callahan" <robert@ocallahan.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 21, 2024 at 10:25=E2=80=AFPM Kyle Huey <me@kylehuey.com> wrote:
>
> rr, a userspace record and replay debugger[0], replays asynchronous event=
s
> such as signals and context switches by essentially[1] setting a breakpoi=
nt
> at the address where the asynchronous event was delivered during recordin=
g
> with a condition that the program state matches the state when the event
> was delivered.
>
> Currently, rr uses software breakpoints that trap (via ptrace) to the
> supervisor, and evaluates the condition from the supervisor. If the
> asynchronous event is delivered in a tight loop (thus requiring the
> breakpoint condition to be repeatedly evaluated) the overhead can be
> immense. A patch to rr that uses hardware breakpoints via perf events wit=
h
> an attached BPF program to reject breakpoint hits where the condition is
> not satisfied reduces rr's replay overhead by 94% on a pathological (but =
a
> real customer-provided, not contrived) rr trace.
>
> The only obstacle to this approach is that while the kernel allows a BPF
> program to suppress sample output when a perf event overflows it does not
> suppress signalling the perf event fd or sending the perf event's SIGTRAP=
.
> This patch set redesigns __perf_overflow_handler() and
> bpf_overflow_handler() so that the former invokes the latter directly whe=
n
> appropriate rather than through the generic overflow handler machinery,
> passes the return code of the BPF program back to __perf_overflow_handler=
()
> to allow it to decide whether to execute the regular overflow handler,
> reorders bpf_overflow_handler() and the side effects of perf event
> overflow, changes __perf_overflow_handler() to suppress those side effect=
s
> if the BPF program returns zero, and adds a selftest.
>
> The previous version of this patchset can be found at
> https://lore.kernel.org/linux-kernel/20240119001352.9396-1-khuey@kylehuey=
.com/
>
> Changes since v4:
>
> Patches 1, 2, 3, 4 added various Acked-by.
>
> Patch 4 addresses additional nits from Song.
>
> v3 of this patchset can be found at
> https://lore.kernel.org/linux-kernel/20231211045543.31741-1-khuey@kylehue=
y.com/
>
> Changes since v3:
>
> Patches 1, 2, 3 added various Acked-by.
>
> Patch 4 addresses Song's review comments by dropping signals_expected and=
 the
> corresponding ASSERT_OKs, handling errors from signal(), and fixing multi=
line
> comment formatting.
>
> v2 of this patchset can be found at
> https://lore.kernel.org/linux-kernel/20231207163458.5554-1-khuey@kylehuey=
.com/
>
> Changes since v2:
>
> Patches 1 and 2 were added from a suggestion by Namhyung Kim to refactor
> this code to implement this feature in a cleaner way. Patch 2 is separate=
d
> for the benefit of the ARM arch maintainers.
>
> Patch 3 conceptually supercedes v2's patches 1 and 2, now with a cleaner
> implementation thanks to the earlier refactoring.
>
> Patch 4 is v2's patch 3, and addresses review comments about C++ style
> comments, getting a TRAP_PERF definition into the test, and unnecessary
> NULL checks.
>
> [0] https://rr-project.org/
> [1] Various optimizations exist to skip as much as execution as possible
> before setting a breakpoint, and to determine a set of program state that
> is practical to check and verify.

Since everyone seems to be satisfied with this now, can we get it into
bpf-next (or wherever) for 6.9?

- Kyle

