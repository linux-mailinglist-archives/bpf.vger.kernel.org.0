Return-Path: <bpf+bounces-75843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EABC9969C
	for <lists+bpf@lfdr.de>; Mon, 01 Dec 2025 23:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6ED77344B9C
	for <lists+bpf@lfdr.de>; Mon,  1 Dec 2025 22:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E3729346F;
	Mon,  1 Dec 2025 22:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqCJWW1d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28643245005
	for <bpf@vger.kernel.org>; Mon,  1 Dec 2025 22:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764629132; cv=none; b=GKglhxzpg86NN/Y72DNHNqR5+kFS7ltZqG8nWJCO02TBFaUAUxyUOo93hLX4hb4C7zaj/4UZcAMa0uMKWd+ULgdb54+3Kn0fGmL28Z5m5uPiD1PglicMtc64rtNrwwyhpbPnyWd+iHAuGgl9PInX/TB+5CZxBdR7vqyKr2m63zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764629132; c=relaxed/simple;
	bh=nfvq4iJOmtxzxA25MF2lDiapNf1y8Xvjd/aE5reohwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HL0DBhfdaOXwjOasu2XmfJNkOuuRcAqiffqDfinyaGyfcnz2dWBpY4+TypLLD8LNr81GvELso//hMG+rQMb9AjnwAi/kG/NXXAU/NV1PZdRehP13kdHyOWml/1rjGf9WmcZDoUsCoMfT5pc6DAp5/OJDWgBE7Gu9s1KBLPFSlDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqCJWW1d; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3438231df5fso5482372a91.2
        for <bpf@vger.kernel.org>; Mon, 01 Dec 2025 14:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764629130; x=1765233930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XraticQtOObDgNMtXk44M1uUjdW7zYSpr1YoDnS3tYQ=;
        b=lqCJWW1dsQJh7t8sGL3TTqlWvtCt26bL4aDvavxinPzZFulcl/K/35WOa2kkJAP2fC
         VsIGLsNj7hIfIgQemSCJBQAJ85YRmNlWSXfqfFU7km7ao9vMJEx0tcni3ffbjnHDspYP
         h5edOnJ17suGiEyy2VM9ARX3JkM/HPJnxlbrYLYpIMJHwDTCFBhUTzMJgCWhctunw1b0
         eNOT6KlDAto3m4CgOsUzaiuJ36ozdBDNrr8sZD07TlCRHaR8bMcQ8xGpd2g4lutadjqd
         GYGhyc3ZtJuFaS0RqYqXeMtEAxV2VNOFH8OkQdNOocokktLPSEJiKEf4E8/6/HKSi4+u
         EWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764629130; x=1765233930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XraticQtOObDgNMtXk44M1uUjdW7zYSpr1YoDnS3tYQ=;
        b=jEdkQcgLEBF7u7RAJbGl5mnr4wFDn125ghxaf4J9tIORZtdCZ4bwg1tGIvNivBUsAU
         Jaw9YE5crRuyftMr9chjqT0Vlh3Xc952tP5D3nhoS/WRdJp/NZVgSVXlN0JHMTeK7puO
         TQmCkCHSFW0zTkmFsZUMRjD8A96Ks4LhISNlyjvFx1lN7FwXqmIPOOoKGO4HNsGQO87r
         KxQrL0CCQjr+0PAWGk2tYW9Glc3quqodptI4IsrJLdf3gG99SGKhbdAwDljBjyA2QIBi
         5TfZoPKO/igwSjLph5MFTl8souxMyGimycE3bUVJGP68GtGb3xpZK+nF2eU8k5I+C2jv
         JUKQ==
X-Gm-Message-State: AOJu0YyTaF3kzAhVRYBhUu470QXbnAA5UAFwFuFrkrP3549jOQsB0Tcb
	DepxuIXlCI/fxvy1KcAKBy6YXH7btVMScauePCgVIpinZcxvngS1yKLPjW3G1dVxptWmkTXfPIM
	7ygZMzMtc46UgTjGg5mxIhXrK9INGp4Y=
X-Gm-Gg: ASbGncs59o18RoQ0yUa+1KQpfOJzQW+89XLvk68MtT0lQ8KlEUpYDlcOi5sK+3LorAt
	Sf14fNyXxxv2IzAMtdqvjfWecdH4rw7p7sTB/BQBGa/BuBVynAE4RxExS75kz1s8/wnZdE0UgAp
	Gt8/vAnurR5wMa4dqbKUwDg+tntYeao4aUCeI7ZAsO/Siy7mrXkrORsgheTX5Coo/Xz2xdRD90P
	UR5KbkLhXLgZVoEX/VkP0yWIm7RYSay+ZcAVHgS+Sm6P/23nGb5vU3QKba2DkNZegn+8cRrnwSn
	qIKCLlWV0kODgXNiOz5Klg==
X-Google-Smtp-Source: AGHT+IG4P/E7tBn2OSAvPjZLo7Q2tebpeNllf9JDnQYAer7ePP0wYXUoPEWrpjk9O7PAKHsXBK8WD0DIoUQznutO21o=
X-Received: by 2002:a17:90b:4a51:b0:341:3ea2:b615 with SMTP id
 98e67ed59e1d1-3475ebe854dmr29402239a91.15.1764629130259; Mon, 01 Dec 2025
 14:45:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118030058.162967-1-emil@etsalapatis.com> <20251118030058.162967-4-emil@etsalapatis.com>
 <CAEf4BzZC_3D8__a_j+A9bBJaKoHXP0Z3V+vmoDkg5gmhFnm5PA@mail.gmail.com> <CABFh=a72sdfoH2RJ7BmqyhBoK2P+=eXy21VrmM5H0nw=4m2Y4A@mail.gmail.com>
In-Reply-To: <CABFh=a72sdfoH2RJ7BmqyhBoK2P+=eXy21VrmM5H0nw=4m2Y4A@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 1 Dec 2025 14:45:17 -0800
X-Gm-Features: AWmQ_bnWPnhQAPW3pV3xOyPiUcSRQLm9xiuXH1LxXUoCJj1hOcG_Bm3CKok1hno
Message-ID: <CAEf4BzYCnPUiyT2JpDPFYtUdJbbnOCk5ufD5gtc6LY90-qgdPQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] libbpf: offset global arena data into the arena if possible
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, memxor@gmail.com, andrii@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 12:41=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.c=
om> wrote:
>
> On Tue, Nov 25, 2025 at 5:12=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Nov 17, 2025 at 7:01=E2=80=AFPM Emil Tsalapatis <emil@etsalapat=
is.com> wrote:
> > >
> > > Currently, libbpf places global arena data at the very beginning of
> > > the arena mapping. Stray NULL dereferences into the arena then find
> > > valid data and lead to silent corruption instead of causing an arena
> > > page fault. The data is placed in the mapping at load time, preventin=
g
> > > us from reserving the region using bpf_arena_reserve_pages().
> > >
> > > Adjust the arena logic to attempt placing the data from an offset wit=
hin
> > > the arena (currently 16 pages in) instead of the very beginning. If
> > > placing the data at an offset would lead to an allocation failure due
> > > to global data being as large as the entire arena, progressively redu=
ce
> > > the offset down to 0 until placement succeeds.
> > >
> >
>
> Hi Andrii,
>
> > I'm not a big fan of adding a single-purpose bpf_map__data_offset(),
> > tbh, and the whole "let's try to place it within the first 16 pages"
> > logic also looks a bit random...
> >
>
> Giving it some thought, I think we can get away with removing the new API=
 call.
> The intended use is for userspace to know where the global data is placed
> within the arena. For example, we've had sched-ext code in the past
> that allocated
> arena pages from userspace using read faults, and that code had to start =
in the
> had to start in the middle of the arena to avoid conflicting with globals=
.
>
> I think it is reasonable to have users call mincore(2) into the
> mapping to find which
> pages were populated by libbpf when loading the globals in the arena.
> I can't think
> of any other use cases for the API call, so we can remove it. Does
> this make sense?

I don't know if I agree that it's reasonable to expect users to use
mincore() to learn where libbpf put global variables. Most natural
location is at the beginning of arena map, but if that doesn't work,
then I expected that at the very end of arena would be ok.

>
> For the 16 pages rule I chose 16 as a sane default because we don't
> want users choosing
> it themselves. The logic is to make sure there's no "false negatives" wrt=
 to
> relocation, to add as many guard pages as we can in case the arena is sma=
ll.

I tried to understand what you are saying about false negatives, but
I'm not sure I get it, sorry. I do agree that asking users to choose
the offset is suboptimal, though.

>
> Is it the number or the logic for choosing the offset that looks random?

The offset you chose is a bit random, plus that piece of logic where
you will be shifting from 16 down to 0 pages, if you happen to fail to
mmap.

> How would you like to simplify it? Possible ways I see are:
>
> 1) Choose a different number, maybe just a single page. That does open up=
 the
> possibility of very large offsets added to NULL pointers ending up in
> the globals
> regions, and 1 isn't really any less arbitrary than 16 or any other choic=
e.

Yeah, I was guessing you didn't choose just one page because you
wanted to catch large field offsets added to NULL. (but yes, 1 is way
less arbitrary than 16, but that's beside the point)

>
> 2) Simplify the logic for choosing the offset. Right now it's just
> exponential backoff
> from 16 all the way to 0, in which case we fall back to existing
> behavior. We can
> make it that relocation either succeeds at an offset or fails, and avoid =
trying
> intermediate offsets.

Yes, if we absolutely have to go with 16 page offset instead of
putting globals at the end, I'd just fix the offset and it either
works or not. It still feels wrong to hard-code 16 as part of API,
though.

>
> Unless the code is very confusing (I don't think it is, but it's my
> own code so I'm
> not exactly impartial :) ) I don't think removing the backoff gets us muc=
h.
>
> > Can't we just say that arena-based global variables are always placed
> > at the end of the arena? Obviously, page aligned all that stuff, so
> > it's deterministic and well-defined. Seems like we always expect
> > BPF_MAP_TYPE_ARENA arena explicitly defined in BPF object file with
> > max_entries set, so that should always work as expected?
> >
>
> The main problem I see with this is that it will cause complications
> with the arena shadow
> map. Putting the global variables at the end requires us to either
> forfeit the possibility of
> applying ASAN to them, or to complicate the mapping function. The
> latter will have implications
> for performance and code complexity, since it will add a conditional
> jump on every ASAN
> check.
>

So maybe elaborate a bit on this? I can't say to understand why
locating globals at the end of arena would change anything for your
ASAN logic. Wouldn't ASAN have to track data at any possible location
anyways? I'm sure you have a good answer here, but please lay it out.

> > And also, I don't think we need to change anything about skeleton
> > generation logic for the arena. That padding is not necessary, libbpf
> > should be able to point arena struct to the beginning of arena global
> > variables, no? As you implemented patch #2, it breaks backwards compat
> > for no good reason.
> >
> > WDYT?
> >
>
> IIUC you mean modifying the address returned by the arena to point
> where the globals are
> placed instead of the guard region, right? I considered it at first
> but I think it has its own set
> of caveats, mainly that it assumes the program never wants to access
> the region below the
> globals.

Hm... I guess it depends on how we look at that *arena pointer. I was
thinking about it as more of pointer to arena-placed global variables,
not some sort of generic way to access any place within the arena. So
in that sense it's natural for that *arena pointer to point to just
global variables, wherever within the arena data area it might be
located.

If user needs to work with other arena pages, they can fetch
memory-mapped memory for arena map itself through
bpf_map__initial_value(skel->maps.arena). I.e., they take `struct
bpf_map` object, ask libbpf where its data is, and then work with it
in "untyped" way.

>
> Right now the patch makes the assumption that the program will set a
> guard region themselves.
> It may not do so and instead use the zero page to store data. In that
> case, accessing the page
> requires a negative offset on the arena page. It also breaks the
> mincore(2) trick I describe
> above for finding the offset into the arena without a new API call.
> AFAICT expanding the
> libbpf API is the bigger problem of the two, but I am not sure.

It just feels like we are exposing way too much implementation details
here. See my point above about using bpf_map__initial_value() (the
name is not great, but it's used to get memory-mapped area for
mmap-able BPF maps).

>
> If we'd like both to avoid the extra API and to avoid the padding, we
> can always set up the guard
> mapping by default in libbpf at load time. Would that be acceptable?
> It does take away control
> from the user, but unless they have very good reason to constrain
> arena size to a handful of pages
> I don't see how the extra guard mapping can be a problem.
>

Again, I'm only guessing what you are trying to say here. Please be
more specific.

> > pw-bot: cr
> >
> >
> > > Adjust existing arena tests in the same commit to account for the new
> > > global data offset. New tests that explicitly consider the new featur=
e
> > > are introduced in the next patch.
> > >
> > > Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> > > ---
> > >  tools/lib/bpf/libbpf.c                        | 30 +++++++++++++++--=
--
> > >  .../bpf/progs/verifier_arena_large.c          | 14 +++++++--
> > >  2 files changed, 37 insertions(+), 7 deletions(-)
> > >
> >
> > [...]

