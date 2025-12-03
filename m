Return-Path: <bpf+bounces-75973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9EECA091C
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 18:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05FFF342F853
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 17:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D318434A76F;
	Wed,  3 Dec 2025 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="3LFOsW/U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2407434A3BC
	for <bpf@vger.kernel.org>; Wed,  3 Dec 2025 16:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764778445; cv=none; b=L0eA3f0CWJ5yZqbfFtTHM9hFoJeugckSOmP7uQcRJQHX9MhtoaMXsjZcviJX4qXB/KYCfsfBjtMSbHQ0JoBJHJMK3pNzvn9RgCzZchfLCVvJKjRLTLbRQr/ODpVfP64LbYlQFRvn9CLa7zNp75xX3KFkdrY+rv++8Sj+ZOPIV1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764778445; c=relaxed/simple;
	bh=lbFmLAq8O9b8Y0eusBa884sScItt5IQPTAG1KUJ0gtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nvzw8okVK2m1B4LtQfJbOw21MGW+jqBqMwxigQovuilJhx3F6B2LHHSdQwqRa84Qf2WaqJQAncf5XlNM56fe78/h4PdpBHx7XGmxpJsE0Pv8A01FgccO73Xi8EuSVTF2mYW/YslVGfFZpO+KFJvh46+63O7fZdOlNT/UjQ1HD2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=3LFOsW/U; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-787e35ab178so60941027b3.2
        for <bpf@vger.kernel.org>; Wed, 03 Dec 2025 08:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1764778442; x=1765383242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZ3BkB0x7VzSWIQM32hvAkKttva8UlfrqjkpSnd7mQA=;
        b=3LFOsW/Uac1NoCI6iYvKORw4+ksHZJRD/WQXaaiLktacH9sblaPbZgMiLUA9fd6qW0
         MwPAlpE7ZaLO1XPHrbJ9X4WWWCF+O/uR6Y97Q/eBQCbUElRLte0bO3m3q3YCEVmcqP4y
         RLVB0XssFJBS7DHThONvth03rWKwKiTriw7uhcSFO5n8txFuT01ZD3QQhdAZIZOl0CPG
         vg5lBPXUvZln2SdyjUXIr1rpxY0MZ2xmoLh4X40TcwGwA3Z67Ce8s7fG5vzP4Fump/nz
         wPXUdCK6atTrwmVjXMEoy97QFGu9TzpbPgjz5iTXnl2QOtjTtWg8ShXbsvOZ4Qzh+g0y
         KZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764778442; x=1765383242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PZ3BkB0x7VzSWIQM32hvAkKttva8UlfrqjkpSnd7mQA=;
        b=gOHAtndelTbbM7on7HWO5n/3XjMguOZjSANv+Cdw82inq9UsNCeDk9CN9KHDUEYGL6
         /Q/zSgu0AzlMA578VLfBOYKCDZcQEZBuVGK5PT8Xt7CsLRDPstfd9jMj0kQ48x/1FZB4
         loSiuU1PrUbv8DKxHQKoLbdG3RfFqWi1pN+HbCvACavUwp0Z31hDmdHe9dLBEGLS6E8N
         mDVMmOMJA0SMOjjzBr6iu8spPaXINeBIFtlJsTbjnXYuvWm2mkniPY3BSnLbu0waA/LH
         yX+2RRhKq3TotMr/ZduzyW32suojUJNKaMW7Xmv54JAWceRpVReeCCFsInYwi55KLqri
         /Z3w==
X-Gm-Message-State: AOJu0Yyify1AMwGWrmGTPjus2W63Z/cDXa07+d6U1R3ayusVOuWTW13r
	1adHdM7xmzaSwvb/A2CswdXW7p6gTydzODyJmT3PmCD4xKjvjXIBVXEspAt5caHcjPiP5VJSZWR
	YSQrws+F2Z5uW//sAPB7GNZbiJ+5QbRMlYDbZZISbxw==
X-Gm-Gg: ASbGnctX9zyo38g5u55jr6Q4YupRx8xqw20p/A3w2K2v9BMrThyazVqmFZtYmS+VBL0
	I/Db1GbgjZjhQBVPx4w1mzXQ5xxahMN0viC18mXBj/dYilGI2dOHL2N01CKH46f56Mg62pO4HCY
	2GG9OWL3IxFkkjAKCIfClEc8RaVPDgUvWkzu97YoNyhcvOEIWVnVx7C64MwmcnJHCtkTyMVGs5z
	Z6QrDrerKXfGKFPdLKMywxZWfUkxKJCop48DhSQlST75Cye2RWndQwVrwjN1OHv1byfyJjW3g==
X-Google-Smtp-Source: AGHT+IE2J0XM8lTr+U2Ie9ouS4EpvgzlaYeitim/2NvdEzZnr1+2NAZtDtF8pKLzTD2s1tIdyRB1DMeaTMVCYLku9I0=
X-Received: by 2002:a05:690c:7087:b0:78a:27a9:d471 with SMTP id
 00721157ae682-78c0c2133b9mr22349907b3.69.1764778441908; Wed, 03 Dec 2025
 08:14:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118030058.162967-1-emil@etsalapatis.com> <20251118030058.162967-4-emil@etsalapatis.com>
 <CAEf4BzZC_3D8__a_j+A9bBJaKoHXP0Z3V+vmoDkg5gmhFnm5PA@mail.gmail.com>
 <CABFh=a72sdfoH2RJ7BmqyhBoK2P+=eXy21VrmM5H0nw=4m2Y4A@mail.gmail.com> <CAEf4BzYCnPUiyT2JpDPFYtUdJbbnOCk5ufD5gtc6LY90-qgdPQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYCnPUiyT2JpDPFYtUdJbbnOCk5ufD5gtc6LY90-qgdPQ@mail.gmail.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Wed, 3 Dec 2025 11:13:51 -0500
X-Gm-Features: AWmQ_bngUnZhljevqONXxvX5mU29_AviNTsgkZNITPnqKjWbwgY0GiIh68fAPCI
Message-ID: <CABFh=a5rvWysd=fZp8VL5qRx+R28RE8HMH2uX28t8jpkgzdk+w@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] libbpf: offset global arena data into the arena if possible
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, memxor@gmail.com, andrii@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 5:45=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Dec 1, 2025 at 12:41=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis=
.com> wrote:
> >
> > On Tue, Nov 25, 2025 at 5:12=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Mon, Nov 17, 2025 at 7:01=E2=80=AFPM Emil Tsalapatis <emil@etsalap=
atis.com> wrote:
> > > >
> > > > Currently, libbpf places global arena data at the very beginning of
> > > > the arena mapping. Stray NULL dereferences into the arena then find
> > > > valid data and lead to silent corruption instead of causing an aren=
a
> > > > page fault. The data is placed in the mapping at load time, prevent=
ing
> > > > us from reserving the region using bpf_arena_reserve_pages().
> > > >
> > > > Adjust the arena logic to attempt placing the data from an offset w=
ithin
> > > > the arena (currently 16 pages in) instead of the very beginning. If
> > > > placing the data at an offset would lead to an allocation failure d=
ue
> > > > to global data being as large as the entire arena, progressively re=
duce
> > > > the offset down to 0 until placement succeeds.
> > > >
> > >
> >
> > Hi Andrii,
> >
> > > I'm not a big fan of adding a single-purpose bpf_map__data_offset(),
> > > tbh, and the whole "let's try to place it within the first 16 pages"
> > > logic also looks a bit random...
> > >
> >
> > Giving it some thought, I think we can get away with removing the new A=
PI call.
> > The intended use is for userspace to know where the global data is plac=
ed
> > within the arena. For example, we've had sched-ext code in the past
> > that allocated
> > arena pages from userspace using read faults, and that code had to star=
t in the
> > had to start in the middle of the arena to avoid conflicting with globa=
ls.
> >
> > I think it is reasonable to have users call mincore(2) into the
> > mapping to find which
> > pages were populated by libbpf when loading the globals in the arena.
> > I can't think
> > of any other use cases for the API call, so we can remove it. Does
> > this make sense?
>
> I don't know if I agree that it's reasonable to expect users to use
> mincore() to learn where libbpf put global variables. Most natural
> location is at the beginning of arena map, but if that doesn't work,
> then I expected that at the very end of arena would be ok.
>
> >
> > For the 16 pages rule I chose 16 as a sane default because we don't
> > want users choosing
> > it themselves. The logic is to make sure there's no "false negatives" w=
rt to
> > relocation, to add as many guard pages as we can in case the arena is s=
mall.
>
> I tried to understand what you are saying about false negatives, but
> I'm not sure I get it, sorry. I do agree that asking users to choose
> the offset is suboptimal, though.
>
> >
> > Is it the number or the logic for choosing the offset that looks random=
?
>
> The offset you chose is a bit random, plus that piece of logic where
> you will be shifting from 16 down to 0 pages, if you happen to fail to
> mmap.
>
> > How would you like to simplify it? Possible ways I see are:
> >
> > 1) Choose a different number, maybe just a single page. That does open =
up the
> > possibility of very large offsets added to NULL pointers ending up in
> > the globals
> > regions, and 1 isn't really any less arbitrary than 16 or any other cho=
ice.
>
> Yeah, I was guessing you didn't choose just one page because you
> wanted to catch large field offsets added to NULL. (but yes, 1 is way
> less arbitrary than 16, but that's beside the point)
>
> >
> > 2) Simplify the logic for choosing the offset. Right now it's just
> > exponential backoff
> > from 16 all the way to 0, in which case we fall back to existing
> > behavior. We can
> > make it that relocation either succeeds at an offset or fails, and avoi=
d trying
> > intermediate offsets.
>
> Yes, if we absolutely have to go with 16 page offset instead of
> putting globals at the end, I'd just fix the offset and it either
> works or not. It still feels wrong to hard-code 16 as part of API,
> though.
>
> >
> > Unless the code is very confusing (I don't think it is, but it's my
> > own code so I'm
> > not exactly impartial :) ) I don't think removing the backoff gets us m=
uch.
> >
> > > Can't we just say that arena-based global variables are always placed
> > > at the end of the arena? Obviously, page aligned all that stuff, so
> > > it's deterministic and well-defined. Seems like we always expect
> > > BPF_MAP_TYPE_ARENA arena explicitly defined in BPF object file with
> > > max_entries set, so that should always work as expected?
> > >
> >
> > The main problem I see with this is that it will cause complications
> > with the arena shadow
> > map. Putting the global variables at the end requires us to either
> > forfeit the possibility of
> > applying ASAN to them, or to complicate the mapping function. The
> > latter will have implications
> > for performance and code complexity, since it will add a conditional
> > jump on every ASAN
> > check.
> >
>
> So maybe elaborate a bit on this? I can't say to understand why
> locating globals at the end of arena would change anything for your
> ASAN logic. Wouldn't ASAN have to track data at any possible location
> anyways? I'm sure you have a good answer here, but please lay it out.
>

You're actually right, it's trivial to move. I'll send a new version
of the patch
that places all globals at the end. I think this removes all problems prese=
nt in
the current version. The only extra bit in the new version will be a slight
verifier change to handle large direct offsets into arena maps.

> > > And also, I don't think we need to change anything about skeleton
> > > generation logic for the arena. That padding is not necessary, libbpf
> > > should be able to point arena struct to the beginning of arena global
> > > variables, no? As you implemented patch #2, it breaks backwards compa=
t
> > > for no good reason.
> > >
> > > WDYT?
> > >
> >
> > IIUC you mean modifying the address returned by the arena to point
> > where the globals are
> > placed instead of the guard region, right? I considered it at first
> > but I think it has its own set
> > of caveats, mainly that it assumes the program never wants to access
> > the region below the
> > globals.
>
> Hm... I guess it depends on how we look at that *arena pointer. I was
> thinking about it as more of pointer to arena-placed global variables,
> not some sort of generic way to access any place within the arena. So
> in that sense it's natural for that *arena pointer to point to just
> global variables, wherever within the arena data area it might be
> located.
>
> If user needs to work with other arena pages, they can fetch
> memory-mapped memory for arena map itself through
> bpf_map__initial_value(skel->maps.arena). I.e., they take `struct
> bpf_map` object, ask libbpf where its data is, and then work with it
> in "untyped" way.
>
> >
> > Right now the patch makes the assumption that the program will set a
> > guard region themselves.
> > It may not do so and instead use the zero page to store data. In that
> > case, accessing the page
> > requires a negative offset on the arena page. It also breaks the
> > mincore(2) trick I describe
> > above for finding the offset into the arena without a new API call.
> > AFAICT expanding the
> > libbpf API is the bigger problem of the two, but I am not sure.
>
> It just feels like we are exposing way too much implementation details
> here. See my point above about using bpf_map__initial_value() (the
> name is not great, but it's used to get memory-mapped area for
> mmap-able BPF maps).
>

Wasn't aware about bpf_map__initial_value(), if we have an existing way
of finding the arena's vm_user_start already then I don't see a problem wit=
h
changing the arena pointer to point to the globals instead. I'll remove the
additional libbpf call in the next version.

> >
> > If we'd like both to avoid the extra API and to avoid the padding, we
> > can always set up the guard
> > mapping by default in libbpf at load time. Would that be acceptable?
> > It does take away control
> > from the user, but unless they have very good reason to constrain
> > arena size to a handful of pages
> > I don't see how the extra guard mapping can be a problem.
> >
>
> Again, I'm only guessing what you are trying to say here. Please be
> more specific.
>

I meant we could do bpf_alloc_reserve_pages() on arena load times, but
the point is mott.

> > > pw-bot: cr
> > >
> > >
> > > > Adjust existing arena tests in the same commit to account for the n=
ew
> > > > global data offset. New tests that explicitly consider the new feat=
ure
> > > > are introduced in the next patch.
> > > >
> > > > Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> > > > ---
> > > >  tools/lib/bpf/libbpf.c                        | 30 +++++++++++++++=
----
> > > >  .../bpf/progs/verifier_arena_large.c          | 14 +++++++--
> > > >  2 files changed, 37 insertions(+), 7 deletions(-)
> > > >
> > >
> > > [...]

