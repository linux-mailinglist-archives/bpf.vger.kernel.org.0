Return-Path: <bpf+bounces-75839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E53EEC99105
	for <lists+bpf@lfdr.de>; Mon, 01 Dec 2025 21:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 60573345560
	for <lists+bpf@lfdr.de>; Mon,  1 Dec 2025 20:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B65258ED5;
	Mon,  1 Dec 2025 20:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="APg/Hg5A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5769E21257B
	for <bpf@vger.kernel.org>; Mon,  1 Dec 2025 20:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764621701; cv=none; b=ZtvDHfenJ0HU2+bVmMSoa+HwU/HhVP2qw4v+RyZeiwDh/cSRBnG10Us2ACbC9oUDpXNOgzCTDmhOZ4AKs5JaRr4iZ4c59jrxyigUcGYpviBGICFiJ9z76kbohfzN2Ctq9xVDKjzyQSEfhvTekQQkpIkhXikQG1f9zDsEKroi5CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764621701; c=relaxed/simple;
	bh=rojeFZl9DECXVctEg/aWLm4+fSjAiN6//F2Lf4P3ntU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VJeUC5gzEpQUnf8tPfUBLfflDIBRKtX8ZQT7f7WBZYTDxFix3fNQGr3p0xP4mv/NGVBlFTGrS278MRjMZywcNfQo1Sw5x55J2r6D0O3yaWXCNztDdhYzDdAznvNDTylBqB+HLs7Bb7VMM6I1deoP95GVVxEbS5v3OjXFY0MoP5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=APg/Hg5A; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-78ab03c30ceso41329987b3.2
        for <bpf@vger.kernel.org>; Mon, 01 Dec 2025 12:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1764621698; x=1765226498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ViI99oB4wBZrgicUAC3GFIYlnmQOtalnlFTqID56pw=;
        b=APg/Hg5AjJ4jltC4ed8C8tmmM2E1FtESnr9SmkTTvaDFLGuJTRTOqDEDyjcgfRVNEW
         wKELqbl242qpjs4MKbPma0AB1r6pN8ntmlasGVP6XnwtjNJ0kK1ePUA91Xr0aGN2thyu
         NnS+bxhbjwhPFSLh+Q0LtVpztyqC4hTIxTRi+mXiaf35G9AKXHStR9r/eN9Z2Kw3cAnr
         aSjhEVib1aP0nlkgr6pVTfdu+ahu/V+Ptt3l5VLnMjZVpo6ISWMvPq0i8+x2VtOJ63M1
         6rKbGZXv0E7ZbgBQuz8rMioN8YhwKy+b/bNXv1/tI7IER1/tJ++LoHcluAbVYdxHIV+B
         WgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764621698; x=1765226498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7ViI99oB4wBZrgicUAC3GFIYlnmQOtalnlFTqID56pw=;
        b=hCNTejLrUGpT6cCb7Ogh8nD6EuEqPM0lTeeyiTznonRi5d1oLc3f/5X/STjZNI8BZu
         jhmUK+iWzUoOSgw6zb2GZ0zD3zeIGkjb9YO6c017Gq+DUTKtYMd/KezpEGemS5SsdQBV
         cLg8EfyaxucS3bLyMNy72JSByUl9kegr8dG4yP06e4gWnVuPgcCu9TRNmHKZMGDRG1QH
         WbpJpZiK42dlrK59gLbQapdl+p8z3SPXsRmsLooAp8rOPFyrcjMZFoJx2uk49Hu3gqHW
         UFUCDS9JkAF/rQxs1zpl7Nu46wmGCs3TLB/1UBEdxV50IrsHNBBTMJGT3IiuOHMsmaNq
         5yXg==
X-Gm-Message-State: AOJu0Yx29/ufuNxPe/V9i8Fuv4iXAsHFsq/aD7fVHKoFPe3qd4CFbYc8
	yNmKsrnv3rIudSXtbZNDE84lhVU20/iWM7f3T9UaRuyNqZwz2Uz4HqpbcetgZbceKUnawBtcj1h
	j0odCXZi1iYtrCH/I0o1tOhUX8j6Xdtw8D0Kdow1LBQ==
X-Gm-Gg: ASbGnctniILL4YOb3e6qcVMp7pkgR7OzxQKTOlwj9pyXF4zey0rQCO52I6drNAB6TjQ
	gc8VSzqrC9jPjG0qhU8/MjKB6UHrhBsuImnLwcgBfsneJjW04hHcdw0rfRk5OwKli2aZKFEBGmw
	dJhBhHgg5sGtn7DFCAVMzLAuBzHesd1W3YtT0NBV8Y4BN3LH3/C9P+0RzivIHoAGTM5WuIVhwoK
	2YqwoJF2YmqwRRHMaiplPlPvY0aXhwWE+izRPcpTHE1gVfAuM+2aOBfM+JNZ9/nJMe4LnoRjQ==
X-Google-Smtp-Source: AGHT+IEtlK2expMtm8jrmHb9KZi+cGdxmOySuuJSvU12xDJbhTd3thXhgoOMKw7Csk9W4gw438h1GJHprFMd7RTam+Y=
X-Received: by 2002:a05:690c:4b91:b0:789:3f0f:ac46 with SMTP id
 00721157ae682-78a8b47abc7mr340822757b3.14.1764621698141; Mon, 01 Dec 2025
 12:41:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118030058.162967-1-emil@etsalapatis.com> <20251118030058.162967-4-emil@etsalapatis.com>
 <CAEf4BzZC_3D8__a_j+A9bBJaKoHXP0Z3V+vmoDkg5gmhFnm5PA@mail.gmail.com>
In-Reply-To: <CAEf4BzZC_3D8__a_j+A9bBJaKoHXP0Z3V+vmoDkg5gmhFnm5PA@mail.gmail.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Mon, 1 Dec 2025 15:41:26 -0500
X-Gm-Features: AWmQ_blM3mhzOFftCGTiSqfosuHy8kAGL7Bnw0mD-mlsz5zfcxUew_9lM79oZPw
Message-ID: <CABFh=a72sdfoH2RJ7BmqyhBoK2P+=eXy21VrmM5H0nw=4m2Y4A@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] libbpf: offset global arena data into the arena if possible
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, memxor@gmail.com, andrii@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 5:12=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Nov 17, 2025 at 7:01=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis=
.com> wrote:
> >
> > Currently, libbpf places global arena data at the very beginning of
> > the arena mapping. Stray NULL dereferences into the arena then find
> > valid data and lead to silent corruption instead of causing an arena
> > page fault. The data is placed in the mapping at load time, preventing
> > us from reserving the region using bpf_arena_reserve_pages().
> >
> > Adjust the arena logic to attempt placing the data from an offset withi=
n
> > the arena (currently 16 pages in) instead of the very beginning. If
> > placing the data at an offset would lead to an allocation failure due
> > to global data being as large as the entire arena, progressively reduce
> > the offset down to 0 until placement succeeds.
> >
>

Hi Andrii,

> I'm not a big fan of adding a single-purpose bpf_map__data_offset(),
> tbh, and the whole "let's try to place it within the first 16 pages"
> logic also looks a bit random...
>

Giving it some thought, I think we can get away with removing the new API c=
all.
The intended use is for userspace to know where the global data is placed
within the arena. For example, we've had sched-ext code in the past
that allocated
arena pages from userspace using read faults, and that code had to start in=
 the
had to start in the middle of the arena to avoid conflicting with globals.

I think it is reasonable to have users call mincore(2) into the
mapping to find which
pages were populated by libbpf when loading the globals in the arena.
I can't think
of any other use cases for the API call, so we can remove it. Does
this make sense?

For the 16 pages rule I chose 16 as a sane default because we don't
want users choosing
it themselves. The logic is to make sure there's no "false negatives" wrt t=
o
relocation, to add as many guard pages as we can in case the arena is small=
.

Is it the number or the logic for choosing the offset that looks random?
How would you like to simplify it? Possible ways I see are:

1) Choose a different number, maybe just a single page. That does open up t=
he
possibility of very large offsets added to NULL pointers ending up in
the globals
regions, and 1 isn't really any less arbitrary than 16 or any other choice.

2) Simplify the logic for choosing the offset. Right now it's just
exponential backoff
from 16 all the way to 0, in which case we fall back to existing
behavior. We can
make it that relocation either succeeds at an offset or fails, and avoid tr=
ying
intermediate offsets.

Unless the code is very confusing (I don't think it is, but it's my
own code so I'm
not exactly impartial :) ) I don't think removing the backoff gets us much.

> Can't we just say that arena-based global variables are always placed
> at the end of the arena? Obviously, page aligned all that stuff, so
> it's deterministic and well-defined. Seems like we always expect
> BPF_MAP_TYPE_ARENA arena explicitly defined in BPF object file with
> max_entries set, so that should always work as expected?
>

The main problem I see with this is that it will cause complications
with the arena shadow
map. Putting the global variables at the end requires us to either
forfeit the possibility of
applying ASAN to them, or to complicate the mapping function. The
latter will have implications
for performance and code complexity, since it will add a conditional
jump on every ASAN
check.

> And also, I don't think we need to change anything about skeleton
> generation logic for the arena. That padding is not necessary, libbpf
> should be able to point arena struct to the beginning of arena global
> variables, no? As you implemented patch #2, it breaks backwards compat
> for no good reason.
>
> WDYT?
>

IIUC you mean modifying the address returned by the arena to point
where the globals are
placed instead of the guard region, right? I considered it at first
but I think it has its own set
of caveats, mainly that it assumes the program never wants to access
the region below the
globals.

Right now the patch makes the assumption that the program will set a
guard region themselves.
It may not do so and instead use the zero page to store data. In that
case, accessing the page
requires a negative offset on the arena page. It also breaks the
mincore(2) trick I describe
above for finding the offset into the arena without a new API call.
AFAICT expanding the
libbpf API is the bigger problem of the two, but I am not sure.

If we'd like both to avoid the extra API and to avoid the padding, we
can always set up the guard
mapping by default in libbpf at load time. Would that be acceptable?
It does take away control
from the user, but unless they have very good reason to constrain
arena size to a handful of pages
I don't see how the extra guard mapping can be a problem.

> pw-bot: cr
>
>
> > Adjust existing arena tests in the same commit to account for the new
> > global data offset. New tests that explicitly consider the new feature
> > are introduced in the next patch.
> >
> > Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> > ---
> >  tools/lib/bpf/libbpf.c                        | 30 +++++++++++++++----
> >  .../bpf/progs/verifier_arena_large.c          | 14 +++++++--
> >  2 files changed, 37 insertions(+), 7 deletions(-)
> >
>
> [...]

