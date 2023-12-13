Return-Path: <bpf+bounces-17637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FF38107C2
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 02:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D1161F21C4F
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 01:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5A0EDF;
	Wed, 13 Dec 2023 01:38:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB3DDC;
	Tue, 12 Dec 2023 17:38:45 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6d855efb920so5079384a34.1;
        Tue, 12 Dec 2023 17:38:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702431525; x=1703036325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YIWyx+xVFC2u/BA+JksVQths0h28NvpxYOOQa54kPF4=;
        b=EFGQfdiiwRYwCoFGDdwWFDPhVvXuqtpK/4c+YrkBGlUdNMn3AzZTac1zEleEFCf6aY
         CG0oT5mypW+NZCNRiTDgj6HxB4R8pOQw1hgeH9HyqafgLcGWns1egL8BK5lfgmPEQX6H
         RC5700fwaRQ7ScFJGBwvHhaT+zlKj3dMhcsCeSIkqN2nYHlMvCAw92sVTxlM6yxcr2xJ
         T/Z9rwLWyrtB0hTgtyz8fifxhVMn8BuNUTb9Wh9ArooLfUPUeFntFZgAOj1xGoCoIDIM
         0fK+nPK9NpyIc14UiPZiAYBBi3y24Djz/CBGgqHE5AIlBJ9czMdUsU4ttAOgWDIXb4H8
         baTw==
X-Gm-Message-State: AOJu0YxurFebBOG1eT4G+UHREMKsUX8TA+QX6wMASPXzG5fkmHdj8478
	03W4k6xIyLeZYj7bN0E/O+xQV2OGo5UbBbme6OY=
X-Google-Smtp-Source: AGHT+IGlZ816ibGJ8fDaIkml7iSqJhiWarKEM7x1sTAEAA3o0fynxk7QISFQW23IR7l5lf+U58/lXVVtZGhr9A5i4Hg=
X-Received: by 2002:a9d:6349:0:b0:6d9:d567:7c36 with SMTP id
 y9-20020a9d6349000000b006d9d5677c36mr7620957otk.71.1702431525092; Tue, 12 Dec
 2023 17:38:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211045543.31741-1-khuey@kylehuey.com>
In-Reply-To: <20231211045543.31741-1-khuey@kylehuey.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 12 Dec 2023 17:38:34 -0800
Message-ID: <CAM9d7ciZaK5=TkX8RhmszKKYP12k4k6A1monOP7vJJ+ivZG_bQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Combine perf and bpf for fast eval of hw
 breakpoint conditions
To: Kyle Huey <me@kylehuey.com>
Cc: Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Marco Elver <elver@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	"Robert O'Callahan" <robert@ocallahan.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Dec 10, 2023 at 8:55=E2=80=AFPM Kyle Huey <me@kylehuey.com> wrote:
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

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

>
> [0] https://rr-project.org/
> [1] Various optimizations exist to skip as much as execution as possible
> before setting a breakpoint, and to determine a set of program state that
> is practical to check and verify.
>
>

