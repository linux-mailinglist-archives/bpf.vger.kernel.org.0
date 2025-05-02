Return-Path: <bpf+bounces-57184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E5AAA68C3
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 04:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A0335A201B
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 02:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E393C14EC62;
	Fri,  2 May 2025 02:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFnmBJSz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5C210A1F;
	Fri,  2 May 2025 02:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746152566; cv=none; b=g7Q6x8uNTbO3g+BHgrhMrIqvgpDuwNosDgJAVSGywpDgA2px09iFHdnmXKHwyaVXH4bNC2o+o9lGZlOllPfMBILLV6GIaXjz/C3gUn+dOfqKhN/VqwM4fxCQdFrNO9rxTXrX5HZ8XizXhngvuoCFr+KVIMovTXQm+/HFhHyMu+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746152566; c=relaxed/simple;
	bh=xFanYIkrDiDLXoIhqhfJx9xfZzWrKQ6bATMWHQuY1gY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bw/VjYu+A0RtCggos11altyQP4Zo70pXQxlSGhY0bUOHm5H08RLS8t4Oy6OvP82IlVStc3ff+2ioohuZOhxhjLnLQMj6/0L32PYnQOaui7W9cretmM3P3I9A4+6qdN4+yd8ybsW4wYDr4y4+ftTXSlcjN4aR06o1a1ZxKBIfr3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFnmBJSz; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-30a5094df42so166525a91.0;
        Thu, 01 May 2025 19:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746152564; x=1746757364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mgGIDkntaG353CpknxEB8WtHZk1NjP4JXUYvEYhweI=;
        b=CFnmBJSzFgEHrqbtOqLbGZxjmlitufab5oELLkC0ueWyUzt/shagmq3GmAdt9uNzoU
         7FINL5dKYcDXZu/tsNJVBn2Qhzo7E4byGrEJ/76TXt0eu0v17OPYRpTsS4brO99pgr0t
         YZDAO+YfuozJntxbtrUx+5APPh9+UF3Ztu1tbmPsixxr9bjqIzpc1R7lVGwqZkhZ+yxw
         LfKGEe3nFuDQTEa97vOc2RvLHkkYSOcEngiSopPCecxioClVUdNMnS5FIaTt8cz7U46q
         0FoXBFszzFcDXToBAUwEB+a/QLz3TUDlHHim8R87j0+ngzLPH9UJJy80UoYIoaZxIYfw
         XiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746152564; x=1746757364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mgGIDkntaG353CpknxEB8WtHZk1NjP4JXUYvEYhweI=;
        b=ZZX3Kufnzh9KLeyvEEVHVdcmJq77iV7092Gn6nCvIdbsbfAN/GR3bPZrvKxV+OFMga
         dK5BWLpkchkO9qW8noz6jkQ15IuwYhTav93EeHSG8z2eq1lRLAXo1JSp4OxW8nma9/xb
         1cTDLcWgKBhptxAXuZhw4WfhMpKTJzSIKF4qHKWS0D4cPUxyLrDyk+WSYkydPjdow39W
         cNwUD1RpWoJEdiicm0bsBHbsZV0WZ19q+dfkwM8eRICKML7IRAUNmyGpiNp26sFtNXOk
         H7P9Kw3rG+vxUvnUyGJwQciK5XBhR3tSE7kNDzxlu9O34yavQkMPE4/yKSptpA5naHtp
         JoSA==
X-Forwarded-Encrypted: i=1; AJvYcCUKK4E1OeyytHQG/dax711bdyK1kD7qlISfbtuHBppvEZ5hHWKAwOnWuWBHZF79RonZtRhUpuLK@vger.kernel.org, AJvYcCWetcRHpbc+38EWxxhK+n8+yLjG1CY9rLqS52xvHfWp21oAqWhmjPDHSi/8N8gkrurYJc8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0VW5iK0SMaOoYqwFZyJs16gVHR0cDcLRR43O6BKucY33s1Ryg
	NfJkqTAyWxAr3U9yMIuGvG37+a5BWdj2Kqb2mIaHyvGgxqFtcK/zgOF0SPzii1DqT8L9GqfapoZ
	IegB94CAR1s3jZTkDGb8I7yeXrFo=
X-Gm-Gg: ASbGncvnP7V+JbFoxlQHRojPKZ59dT6UKDFhYGNCYGjZt9+nKzqPMP8z+BP2rODyJ04
	dSo3OPLv+yRNigKmBbl/GPgVHN8HaA6uigJmMNTCzzJwbOBD7pKRWnkH0+nJ3FF9+0jiab8UE7k
	mTUeKTn/w872dhqEnrTqzJRFGNVMuRJIU=
X-Google-Smtp-Source: AGHT+IHUSP2KHN1kItInFpH9NUDxYdcy1iEEBFT7Eipo4wT/6hGgyA2pzr0oR/oqJ2Pprf6RFytRD1yQrPG27UTJ1FA=
X-Received: by 2002:a17:90a:dfc5:b0:2f4:4003:f3ea with SMTP id
 98e67ed59e1d1-30a4e6addf7mr2236090a91.33.1746152563885; Thu, 01 May 2025
 19:22:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425214039.2919818-1-ameryhung@gmail.com> <CAEf4BzYUNckc9pXcE7BawxWFVfY--p12c3ax8ySP1P+BEww91w@mail.gmail.com>
 <CAADnVQL92e=-Nzr0O5Geev4y7cWG2m1UR_D7izF+Rd2ccPMNKQ@mail.gmail.com>
In-Reply-To: <CAADnVQL92e=-Nzr0O5Geev4y7cWG2m1UR_D7izF+Rd2ccPMNKQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 1 May 2025 19:22:31 -0700
X-Gm-Features: ATxdqUGwXr5jzas4VYO1w5EgNROhCQvG0M32gCj5Q4oijEHN-buoSKjIm21i9Vw
Message-ID: <CAEf4BzY3oYWkUshYD7ybiB5bcGoLnQxukYObmgRtRZoEi=ZMTw@mail.gmail.com>
Subject: Re: [PATCH RFC v3 0/2] Task local data API
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Tejun Heo <tj@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 1, 2025 at 4:27=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, May 1, 2025 at 1:37=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > Lack of support for shared libraries is a big limitation, IMO, so I
> > think we should design for that support from the very beginning.
> >
> > FWIW, I think this compile-time static __thread variable definitions
> > are unnecessarily limiting and add a non-trivial amount of complexity.
> > I think it's more reasonable to go with a more dynamic approach, and
> > I'll try to outline what an API (and some implementation details)
> > might look like.
> >
> > Note, all this is related to the user-space side of things. BPF-side
> > is unchanged, effectively, except you get a guarantee that all the
> > data will definitely be page-aligned, so you won't need to do these
> > two uptr pages handling.
> >
> > First, data structures. You'll have one per-process metadata structure
> > describing known keys and their assigned "offsets":
> >
> > struct tld_metadata {
> >     int cnt;
> >     char keys[MAX_KEY_CNT];
> >     __u16 offs[MAX_KEY_CNT];
> >     __u16 szs[MAX_KEY_CNT];
> > };
>
> In Amery's proposal it's
> u16 key_cnt;
> struct {
>   char key[TASK_LOCAL_DATA_KEY_LEN];
>   u16 off;
> } keys[];
>
> If we start allocation from the end of the page then we
> don't need 'szs' array.

I wasn't trying to optimize those few bytes taken by szs, tbh.
Allocating from the end of the page bakes in the assumption that we
won't ever need more than one page. I don't know if I'd do that. But
we can just track "next available offset" instead, so it doesn't
really matter much.

>
> > typedef struct { int off; } tld_off_t;
>
> This is a good tweak.
>
> > tld_off_t tld_add_key_def(const char *key_name, size_t key_size);
>
> Dropping bpf_ prefix and sticking to tld_ is a good move too.
>
> > This API can be called just once per each key that process cares
> > about. And this can be done at any point, really, very dynamically.
> > The implementation will:
> >   - (just once per process) open pinned BPF map, remember its FD;
> >   - (just once) allocate struct tld_metadata, unless we define it as
> > pre-allocated global variable;
>
> The main advantage of the new scheme is support for shared libraries.
> That's a big plus, but the requirement that everything (shared libs,
> static libs, application itself) has to go through this library
> (it would have to be shared ?) is quite inconvenient imo.

It's simple enough to be contained within a single .h file. Everything
else is just __weak symbols for per-process state, so I'm not sure
this is a limitation of any sort.

>
> Let's tweak this proposal and make the kernel the source of truth.
> Then shared libs, static and application would only need to agree
> on the protocol of accessing bpf task local storage instead of
> being forced to use this "tld" library because it's stateful.
> "tld" library will be there, but it will be stateless.

Yes, data structures and the protocol of accessing and synchronizing
the updates is what matters.

>
> We may need to tweak the kernel uptr api a bit, but at a high level
> let all user space things assume that two __uptr-s in that special
> task local storage map are the source of truth.
> First, the user space (.so, .a or a.out) will do is
> map_lookup_elem(tls_map_fd) and if __uptr are pointing somewhere
> use that memory regardless of which part of this process allocated it
> (assuming that .so, .a or a.out won't be freeing it until exit).
> If __uptr udata is still NULL, allocate page-aligned page and
> map_update_elem(). The kernel doesn't need to deal with races
> here since it's a task local value.

Sure. Keep in mind, though, that in practice, whatever different
libraries constitute your application, they all will need to agree on
how the BPF task local storage map FD is obtained.

> If __uptr umetadata is there after lookup, use that to find
> and add keys. Here we need some generic locking mechanism,
> since umetadata is per-process. Like test-and-set spinlock
> that sits within umetadata region and all .so-s, .a-s, a.out
> have the same algorithm to lock and access it.

Yep, see below.

>
> If not there, allocate a page of umetadata and map_update_elem().
> Here the kernel would need to deal with races, but I hope
> BPF_NOEXIST should already work correctly? I haven't checked.
> Worst case we'd need to add support for BPF_F_LOCK (if not already there)=
.

yeah, BPF_NOEXIST should work, I wouldn't do BPF_F_LOCK.

>
> >   - (locklessly) check if key_name is already in tld_metadata, if yes
> > - return already assigned offset;
> >   - (locklessly) if not, add this key and assign it offset that is
> > offs[cnt - 1] + szs[cnt - 1] (i.e., we just tightly pack all the
> > values (though we should take care of alignment requirements, of
> > course);
>
> I'm not quite sure how different processes can do it locklessly.

There are no different processes, it's all one process, many
threads... Or is that what you meant? tld_metadata is *per process*,
tld_data is *per thread*. Processes don't need to coordinate anything
between themselves, only threads within the process.

As for how I'd do offset allocation and key addition locklessly. You
are right that it can't be done completely locklessly, but just
looping and yielding probably would be fine.
=3D

Then the sequence of adding the key would be something like below.
I've modified tld_metadata a bit to make this simpler and more
economical (and I fixed definition of keys array of array of chars,
oops):

struct tld_metadata {
    int cnt;
    int next_off;
    char keys[MAX_KEY_CNT][MAX_KEY_LEN];
    __u16 offs[MAX_KEY_CNT];
};

struct tld_metadata *m =3D ...;
const char *new_key =3D ...;
int i =3D 0;

/* all m->offs[i] are set to -1 on creation */
again:

    int key_cnt =3D m->cnt;
    for (; i < key_cnt; i++) {
       while (m->offs[i] < 0) /* update in progress */
            sched_yield();

       if (strcmp(m->keys[i], new_key) =3D=3D 0)
            return m->offs[i];

       if (!cmpxchg(*m->cnt, key_cnt, key_cnt + 1)) {
            goto again; /* we raced, key might have been added
already, recheck, but keep i */

       /* slot key_cnt is ours, we need to calculate and assign offset */
       int new_off =3D m->next_off;
       m->next_off =3D new_off + key_sz;

       m->keys[key_cnt][0] =3D '\0';
       strncat(m->keys[key_cnt], new_key, MAX_KEY_LEN);

       /* MEMORY BARRIERS SHOULD BE CAREFULLY CONSIDERED */

       m->offs[key_cnt] =3D new_off; /* this is finalizing key -> offset
assignment */

       /* MEMORY BARRIERS SHOULD BE CAREFULLY CONSIDERED */

       return new_off; /* we are done */
    }

Something like that. There is that looping and yield to not miss
someone else winning the race and adding a key, so that's the locking
part. But given that adding a key definition is supposed to be one
time operation (per key), I don't think we should be fancy with
locking.

> But if we allocate from the top of the page and there is only one
> 'offset' field then we can do it lockless. Like:
> allocate(size sz)
> {
>        size_t old =3D atomic_read(&obj->offset);
>
>        if ((ssize_t)(old - sz) >=3D 0 &&
>            atomic_cmpxchg(&obj->offset, old, old - sz) =3D=3D old)
>                return ..; // success

does it really matter whether it's from the top or bottom of the page?


> }
>
> No suggestions for the rest of the proposal.

