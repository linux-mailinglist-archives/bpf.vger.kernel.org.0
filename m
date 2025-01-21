Return-Path: <bpf+bounces-49414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B39DDA18792
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 23:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 340FA7A4485
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 22:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F64E1B87F3;
	Tue, 21 Jan 2025 22:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NwOA65IL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C911BD4E4
	for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 22:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737496992; cv=none; b=JbgTnibtuZCcVBUca0SYnSawND6lPTq/3xerjuQClEtI3S+nzx1Z3oXPV1oPJSj8Emxtr2EnHg3Z5O/+L5sg9Zj3OO5FJoqAl9h6MJpS0Ctx8I/Ff6q40r0ZmhhrCTUM3Ip1Oek0hSSeidCi5rcZbGNbS/C6Tl+wM0FD1Vlv0Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737496992; c=relaxed/simple;
	bh=mFkvari2z1fWmLsvq6Omj2Wn6kRaHkVGQj4jhZc19bQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=thDG0KELEM+LUrz1byFnour4QCzdhBjWlZaZQYg7NfDbdFIi2NnP7CWmi+5TlUaV6gg8l9gSDhG90SUzO1I9IrbA1CKg0bimu9KiTVlCTYrRa7INnSYKDIbpjy9szf1B4SgMkBlM4aqr/5uvtIb1wPKkSv+lQMYnp5F+XgvsedI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NwOA65IL; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa69107179cso1173886366b.0
        for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 14:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737496989; x=1738101789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Pf5ReTbt0QrHvKNrJy0BbTY66yNBal6L8d/3IlahQ8=;
        b=NwOA65ILeg9bI3QRmKEX6kg5ytTy7rcThgaZciEp03/LH28ojzKkKA3y30Q2DOPqfe
         HxtnxQb/+5PguwMwrlOlQKMmIaSCwMNgJQNyoeXwGHmb7/UTuFbeH+ge+RozOjI5zhLl
         L99OErWr1dpnRmTVWc6VOgdhLBVmBcFx3GktFdM4r9ReJuk4pC96wr7p2yNGmYUQ1AoG
         HNNWiblodb7Nc+JdrIN+sa0SrSOdD+yFgw4aANBpVtNnNRpdMRb10h/3EwN5kR5QCiCX
         BeL/yH1I2VzVE+5VvSgXXUNf+9m37LHrarh34KdtGwc202x02FOy9iqKGhQYbUNjSM+m
         SSkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737496989; x=1738101789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Pf5ReTbt0QrHvKNrJy0BbTY66yNBal6L8d/3IlahQ8=;
        b=uMafW0L8oltwKogX5jgs28WDNnBJzx7SWPq2pc10Rwrpr+1wO5taySAuHkYJc8Z26p
         qfdbSYMJQed3OkP9iHALrJMHIf05DDOejw57btmR9PXZzp7+K0cyOn614bc65HgBNRG3
         d2QH5uUFZvumq0X0NugvoUvq7/qRBbL0cwHF4ddMc+Km2t3fzoL9m5txgoX17ziJ33LK
         5gMh9sISTYQgTF3sjRKZTFnLiHHs+SNo/Jj9wLAnPC0LAUJ0KXOfH7TubTBrgBkQxbX6
         fS/aJAacp2Nw+jl8NabfcD609BqS3HMndy9kMRpAuMb5ef61wzLMNN60lfsD36T11Q2T
         ymCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIF4WCe9uj0726D1i8n4XIlFZSvZrSsycEW+//HlAJmjcGF9f85igtCq6y3WLIbaJUa5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YywNolVqdnzK6cis3qKWMGa/piQaWv/KDQibtV38bmynrymgxD7
	bg0Ul15AA+c+vmZgEzIoRWXsy8j7Tsiv7WdPy56bwKVEcbKVkDKlx0ETqsw+sgWEZH/j79uzg2U
	guAMFljHUe2bfapWT0SQGIvc/XbMcG9lEWpJV
X-Gm-Gg: ASbGncuuAiJeN1hkvXOjTF2x+hqa17OVM0rZHZS5eR2DgEH3uNnyLjP8Q7xe/OIdWo1
	65bVIhHbdJvWIhntYbWeOd+zg4QMii9HnEtU10BuuyNsLiS+jJeXlecRBV095SP+0Fg3DIHksBk
	wjQSWgkw==
X-Google-Smtp-Source: AGHT+IH9C1DgWkCx/IF4GEs7d9XZatTYKETnSowzdKonvoodh953CDLims5pFZm6C/i2cli3mzBo9Aq8dlLsp6D4WLY=
X-Received: by 2002:a17:907:940d:b0:aa6:a05c:b068 with SMTP id
 a640c23a62f3a-ab38b3d6ec1mr1466946166b.56.1737496988737; Tue, 21 Jan 2025
 14:03:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113052220.2105645-1-ctshao@google.com> <20250113052220.2105645-2-ctshao@google.com>
 <Z4XUfjdaooYNpkFt@google.com>
In-Reply-To: <Z4XUfjdaooYNpkFt@google.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Tue, 21 Jan 2025 14:02:57 -0800
X-Gm-Features: AbW1kvaa11xh-6ChK4SsaO-FFoq4twz-OU0zgXLvRtPsaq-J9zamERG4ixA9i8o
Message-ID: <CAJpZYjXMd4+UbaO8y-HGkPor4M1L7W1iMWYe+ak1EYSOxwqXiw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] perf lock: Add bpf maps for owner stack tracing
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namhyung, thanks for your reply!

On Mon, Jan 13, 2025 at 7:05=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Sun, Jan 12, 2025 at 09:20:14PM -0800, Chun-Tse Shao wrote:
> > Add few bpf maps in order to tracing owner stack.
>
> If you want to split this code as a separate commit, I think you'd
> better explain what these maps do and why you need them.
>
> >
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > ---
> >  tools/perf/util/bpf_lock_contention.c         | 17 ++++++--
> >  .../perf/util/bpf_skel/lock_contention.bpf.c  | 40 +++++++++++++++++--
> >  tools/perf/util/bpf_skel/lock_data.h          |  6 +++
> >  3 files changed, 56 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bp=
f_lock_contention.c
> > index 41a1ad087895..c9c58f243ceb 100644
> > --- a/tools/perf/util/bpf_lock_contention.c
> > +++ b/tools/perf/util/bpf_lock_contention.c
> > @@ -41,9 +41,20 @@ int lock_contention_prepare(struct lock_contention *=
con)
> >       else
> >               bpf_map__set_max_entries(skel->maps.task_data, 1);
> >
> > -     if (con->save_callstack)
> > -             bpf_map__set_max_entries(skel->maps.stacks, con->map_nr_e=
ntries);
> > -     else
> > +     if (con->save_callstack) {
> > +             bpf_map__set_max_entries(skel->maps.stacks,
> > +                                      con->map_nr_entries);
> > +             if (con->owner) {
> > +                     bpf_map__set_value_size(skel->maps.owner_stacks_e=
ntries,
> > +                                             con->max_stack * sizeof(u=
64));
> > +                     bpf_map__set_value_size(
> > +                             skel->maps.contention_owner_stacks,
> > +                             con->max_stack * sizeof(u64));
> > +                     bpf_map__set_key_size(skel->maps.owner_lock_stat,
> > +                                             con->max_stack * sizeof(u=
64));
> > +                     skel->rodata->max_stack =3D con->max_stack;
> > +             }
> > +     } else
> >               bpf_map__set_max_entries(skel->maps.stacks, 1);
> >
> >       if (target__has_cpu(target)) {
> > diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/per=
f/util/bpf_skel/lock_contention.bpf.c
> > index 1069bda5d733..05da19fdab23 100644
> > --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > @@ -19,13 +19,37 @@
> >  #define LCB_F_PERCPU (1U << 4)
> >  #define LCB_F_MUTEX  (1U << 5)
> >
>
> Can we rename these shorter and save some typings?

I tend to use longer variable names with full descriptions with some
easy to understand abbreviations. Would a shorter name be preferable
in Linux kernel?

>
> > -/* callstack storage  */
> > + /* tmp buffer for owner callstack */
> >  struct {
> > -     __uint(type, BPF_MAP_TYPE_STACK_TRACE);
> > +     __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> >       __uint(key_size, sizeof(__u32));
> >       __uint(value_size, sizeof(__u64));
> > +     __uint(max_entries, 1);
> > +} owner_stacks_entries SEC(".maps");
>
> I think this can be 'stack_buf'.
>
> > +
> > +/* a map for tracing lock address to owner data */
> > +struct {
> > +     __uint(type, BPF_MAP_TYPE_HASH);
> > +     __uint(key_size, sizeof(__u64)); // lock address
> > +     __uint(value_size, sizeof(cotd));
> >       __uint(max_entries, MAX_ENTRIES);
> > -} stacks SEC(".maps");
> > +} contention_owner_tracing SEC(".maps");
>
> owner_data.
>
> > +
> > +/* a map for tracing lock address to owner stacktrace */
> > +struct {
> > +     __uint(type, BPF_MAP_TYPE_HASH);
> > +     __uint(key_size, sizeof(__u64)); // lock address
> > +     __uint(value_size, sizeof(__u64)); // straktrace
>
> Typo.
>
> > +     __uint(max_entries, MAX_ENTRIES);
> > +} contention_owner_stacks SEC(".maps");
>
> owner_stack.
>
> > +
> > +/* owner callstack to contention data storage */
> > +struct {
> > +     __uint(type, BPF_MAP_TYPE_HASH);
> > +     __uint(key_size, sizeof(__u64));
> > +     __uint(value_size, sizeof(struct contention_data));
> > +     __uint(max_entries, MAX_ENTRIES);
> > +} owner_lock_stat SEC(".maps");
>
> owner_stat.  What do you think?
>
> By the way, I got an idea to implement stackid map in BPF using hash
> map.  For owner stack, you can use the stacktrace as a key and make a
> value an unique integer.  Then the return value can be used as a stack
> id (like from bpf_get_stackid) for the owner_data and owner_stat.
>
> Something like:
>
>   s32 get_stack_id(struct owner_stack *owner_stack, u64 stacktrace[])
>   {
>         s32 *id, new_id;
>         static s32 id_gen =3D 1;
>
>         id =3D bpf_map_lookup_elem(owner_stack, stacktrace);
>         if (id)
>                 return *id;
>
>         new_id =3D __sync_fetch_and_add(&id_gen, 1);
>         bpf_map_update_elem(owner_stack, stacktrace, &new_id, BPF_NOEXIST=
);
>
>         id =3D bpf_map_lookup_elem(owner_stack, stacktrace);
>         if (id)
>                 return *id;
>
>         return -1;
>   }
>
> Later, in user space, you can traverse the owner_stack map to build
> reverse mapping from id to stacktrace.

I wonder if stack_id is necessary here. So far I have three bpf maps.
2 bpf maps for tracing owner stack on given lock address in bpf program:
  key: lock_address, value: a struct for tracing owner pid, count of
waiters and contention begin timestamp.
  key: lock_address, value: owner stack, which is variable length so I
have to put it in a separate bpf map.

1 bpf map for reporting owner stack in user mode:
  key: owner stack, value: struct lock_stat.

With stackid I think there will still be 3 bpf maps, one for
lock_address to owner's info with stackid, one for stackid to stack,
and one for contention_key (has stackid inside) to lock_stat. I think
it is just another way to implement and does not simplify the
implementation. WDYT?

>
> >
> >  /* maintain timestamp at the beginning of contention */
> >  struct {
> > @@ -43,6 +67,14 @@ struct {
> >       __uint(max_entries, 1);
> >  } tstamp_cpu SEC(".maps");
> >
> > +/* callstack storage  */
> > +struct {
> > +     __uint(type, BPF_MAP_TYPE_STACK_TRACE);
> > +     __uint(key_size, sizeof(__u32));
> > +     __uint(value_size, sizeof(__u64));
> > +     __uint(max_entries, MAX_ENTRIES);
> > +} stacks SEC(".maps");
> > +
> >  /* actual lock contention statistics */
> >  struct {
> >       __uint(type, BPF_MAP_TYPE_HASH);
> > @@ -126,6 +158,7 @@ const volatile int needs_callstack;
> >  const volatile int stack_skip;
> >  const volatile int lock_owner;
> >  const volatile int use_cgroup_v2;
> > +const volatile int max_stack;
> >
> >  /* determine the key of lock stat */
> >  const volatile int aggr_mode;
> > @@ -436,7 +469,6 @@ int contention_end(u64 *ctx)
> >                       return 0;
> >               need_delete =3D true;
> >       }
> > -
> >       duration =3D bpf_ktime_get_ns() - pelem->timestamp;
> >       if ((__s64)duration < 0) {
> >               __sync_fetch_and_add(&time_fail, 1);
> > diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf=
_skel/lock_data.h
> > index de12892f992f..1ef0bca9860e 100644
> > --- a/tools/perf/util/bpf_skel/lock_data.h
> > +++ b/tools/perf/util/bpf_skel/lock_data.h
> > @@ -3,6 +3,12 @@
> >  #ifndef UTIL_BPF_SKEL_LOCK_DATA_H
> >  #define UTIL_BPF_SKEL_LOCK_DATA_H
> >
> > +typedef struct contention_owner_tracing_data {
> > +     u32 pid; // Who has the lock.
> > +     u64 timestamp; // The time while the owner acquires lock and cont=
ention is going on.
> > +     u32 count; // How many waiters for this lock.
>
> Switching the order of timestamp and count would remove padding.

Thanks for the nit!

>
> > +} cotd;
>
> Usually we don't use typedef to remove the struct tag.
>
> Thanks,
> Namhyung
>
> > +
> >  struct tstamp_data {
> >       u64 timestamp;
> >       u64 lock;
> > --
> > 2.47.1.688.g23fc6f90ad-goog
> >

