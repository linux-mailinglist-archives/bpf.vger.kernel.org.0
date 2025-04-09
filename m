Return-Path: <bpf+bounces-55607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2DCA834B4
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 01:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 961F7446919
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 23:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A8221CC7C;
	Wed,  9 Apr 2025 23:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C26RjVJD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B332135AD
	for <bpf@vger.kernel.org>; Wed,  9 Apr 2025 23:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744242061; cv=none; b=klMmKCGyh99PIzUpdiKvPyBZf6VfSVdWm9LFHNOpb12exPqB3+xcz9cz0AuLgGrCjfRJDTKhdBL/mrs6c2eDOz1VbLCQ2QHmATc7t5CVaQmT0eK0sp5hk3TMtpaiaDM3qKsSKmIDrYVvjbPrafKTkTpzEyRVTw6knlLGE9n+4hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744242061; c=relaxed/simple;
	bh=Y1ToJHLzD2MCX4Ki53pJ2GESU4uZYelz+LQZ+qh3t+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O7aVWa6aav4B4dNOJV1bUtM1/Vv970AChneBE4xuqI9gkgZ1duig9RKxsRXxQnFD8U5VdE53x0iTo3bjUk/Eww7ZjOdhwTKXH9q7I1vYvzwkndiOXcOG8TqspfLYSZMhcAqRJ1npR+EdFOEu56zXPsyS3UONk2aXl5L9K7U+0Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C26RjVJD; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-736c1cf75e4so103985b3a.2
        for <bpf@vger.kernel.org>; Wed, 09 Apr 2025 16:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744242059; x=1744846859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8cFdxx6rIz04dC0cdJT8TXDAuxhRGBIg5XQa/gSDpI=;
        b=C26RjVJD80aJ46bsBTMxz5+022vZJrpfl6bDGUGANEmQT23NfRS5Ot30sKb+HP5QTb
         7fyxV0rUouB2vAY/emL5TNaJrp9+7RFLhUFCgsv0geaJADZrBoI439hMrKKr6y5gaUXE
         hiPChCjcQUDehoKlc0qIOi9wFJYYkCI0Q7zGgBoC2sQLothaZ9iylzjwFmyf94GIbnW7
         53IIITUET8xocLSAvyV5iC7zy2Dbnp8L7rQ0CGJolz80Dd5p8BoiJK2d0LA7D91i8K6b
         zT6EEMB1EesJgxmYwvdUfoyU9/qTU56gPu+GX4KNMWzPUJRLEoyHcY52/HmUbUXhYGJe
         hQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744242059; x=1744846859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M8cFdxx6rIz04dC0cdJT8TXDAuxhRGBIg5XQa/gSDpI=;
        b=gzkJxrhlzb2G6io7NHJKFe0PQazM6K6bomkFM9/I93i1xUTkiFasGSkl2uD4vDBTb7
         cv5XKGKfLKqdDM+APOOADOpcsbf1YVV+4tgBvnQa+YUvIig38kdRRyJPTq4GS63aX3qn
         CN1CeWKZLCswxOI6AOHHwLSOsi/0NcaPwxJPfpOgqRtJCS3kOlRTyRlT8Bhl+gwkEXkc
         6ARQAq/3ywgVE8V21dP7QL9ueDYlKc3wf4DAz8fklwuyoKI28yodEQ4wVryuHx2lU6nO
         ZqpaJCZAHt1VaTYn6KOcx4YAJupowx8uYGKbrrBq7AtjWQ/E2wPcqX5+5shYO/UUVjXY
         IlMw==
X-Gm-Message-State: AOJu0Yy5Ma9bWByoS8dp4W6+BUW/aKgj9nrXri2os5p3FCNJ08Vn8Avk
	5nUk9yFuLL7Re+HhZP8TQRHlZSMBwHL5g5mbnbinsgHKG250qdZTlgNz/C9WOWNSCpQquJjdGq9
	52FDh6F+TUAUjxcgUlm+s3DMMK4k=
X-Gm-Gg: ASbGnctNFJsDPmH8HUwmwcK/kywv7+6grj+N45P3EgWbLuY+VyoybIPSO95snBW4Uee
	e0B34UoHk9lolod3i+GEyLX9tXkrOZfEU/uT3RmXK6H28AoeBv3++DNP2MguXKZjGMT5fVBiHnU
	dMRS3kAJsJyIMsVauYgFpIp7t73wipbRoMhT098BVDHD3NLCAq
X-Google-Smtp-Source: AGHT+IG4BZVIO0uXN8tOZqFm98XbaPb6mfaOdSFIeM/eWqhF1pXLL8pwK5cGPEfurtqzTXHlmLKq+286A/qdOp6giso=
X-Received: by 2002:a05:6a00:130a:b0:736:2a73:675b with SMTP id
 d2e1a72fcca58-73bc0b7a46emr415491b3a.19.1744242058492; Wed, 09 Apr 2025
 16:40:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327083455.848708-1-houtao@huaweicloud.com>
 <20250327083455.848708-16-houtao@huaweicloud.com> <CAEf4BzY6Y=40NHs12r3Jb7u_N8CVapwRuF09+dmxBH85J2t88w@mail.gmail.com>
 <34a1d3a2-0b63-7f11-9da2-5966b24e179b@huaweicloud.com> <CAEf4BzZY5OSBs3xEdhgC7hjwjQ9C4j+uyLxjjqAjc-ek_pJRog@mail.gmail.com>
 <07052375-1923-9a3e-2eee-a3bb9eae372d@huaweicloud.com>
In-Reply-To: <07052375-1923-9a3e-2eee-a3bb9eae372d@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 9 Apr 2025 16:40:46 -0700
X-Gm-Features: ATxdqUEcZCALKzihip82aaTCRj9igqxVpmcvn3XQXdIfHn6j4q466vskxnPHIXw
Message-ID: <CAEf4BzbiTTi=3RYwW6F4+DiPEB0t1K+ToHH0yhF38dR9d0mfJw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 15/16] selftests/bpf: Add test cases for hash
 map with dynptr key
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 7:24=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> Hi,
>
> On 4/8/2025 12:05 AM, Andrii Nakryiko wrote:
> > On Sun, Apr 6, 2025 at 7:47=E2=80=AFPM Hou Tao <houtao@huaweicloud.com>=
 wrote:
> >> Hi,
> >>
> >> On 4/5/2025 1:58 AM, Andrii Nakryiko wrote:
> >>> On Thu, Mar 27, 2025 at 1:23=E2=80=AFAM Hou Tao <houtao@huaweicloud.c=
om> wrote:
> >>>> From: Hou Tao <houtao1@huawei.com>
> >>>>
> >>>> Add three positive test cases to test the basic operations on the
> >>>> dynptr-keyed hash map. The basic operations include lookup, update,
> >>>> delete and get_next_key. These operations are exercised both through
> >>>> bpf syscall and bpf program. These three test cases use different ma=
p
> >>>> keys. The first test case uses both bpf_dynptr and a struct with onl=
y
> >>>> bpf_dynptr as map key, the second one uses a struct with an integer =
and
> >>>> a bpf_dynptr as map key, and the last one use a struct with two
> >>>> bpf_dynptr as map key: one in the struct itself and another is neste=
d in
> >>>> another struct.
> >>>>
> >>>> Also add multiple negative test cases for dynptr-keyed hash map. The=
se
> >>>> test cases mainly check whether the layout of dynptr and non-dynptr =
in
> >>>> the stack is matched with the definition of map->key_record.
> >>>>
> >>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
> >>>> ---
> >>>>  .../bpf/prog_tests/htab_dynkey_test.c         | 446 +++++++++++++++=
+++
> >>>>  .../bpf/progs/htab_dynkey_test_failure.c      | 266 +++++++++++
> >>>>  .../bpf/progs/htab_dynkey_test_success.c      | 382 +++++++++++++++
> >>>>  3 files changed, 1094 insertions(+)
> >>>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/htab_dynk=
ey_test.c
> >>>>  create mode 100644 tools/testing/selftests/bpf/progs/htab_dynkey_te=
st_failure.c
> >>>>  create mode 100644 tools/testing/selftests/bpf/progs/htab_dynkey_te=
st_success.c
> >>>>
> >>> [...]
> >>>
> >>>> diff --git a/tools/testing/selftests/bpf/progs/htab_dynkey_test_succ=
ess.c b/tools/testing/selftests/bpf/progs/htab_dynkey_test_success.c
> >>>> new file mode 100644
> >>>> index 0000000000000..84e6931cc19c0
> >>>> --- /dev/null
> >>>> +++ b/tools/testing/selftests/bpf/progs/htab_dynkey_test_success.c
> >>>> @@ -0,0 +1,382 @@
> >>>> +// SPDX-License-Identifier: GPL-2.0
> >>>> +/* Copyright (C) 2025. Huawei Technologies Co., Ltd */
> >>>> +#include <linux/types.h>
> >>>> +#include <linux/bpf.h>
> >>>> +#include <bpf/bpf_helpers.h>
> >>>> +#include <bpf/bpf_tracing.h>
> >>>> +#include <errno.h>
> >>>> +
> >>>> +#include "bpf_misc.h"
> >>>> +
> >>>> +char _license[] SEC("license") =3D "GPL";
> >>>> +
> >>>> +struct pure_dynptr_key {
> >>>> +       struct bpf_dynptr name;
> >>>> +};
> >>>> +
> >>>> +struct mixed_dynptr_key {
> >>>> +       int id;
> >>>> +       struct bpf_dynptr name;
> >>>> +};
> >>>> +
> >>>> +struct multiple_dynptr_key {
> >>>> +       struct pure_dynptr_key f_1;
> >>>> +       unsigned long f_2;
> >>>> +       struct mixed_dynptr_key f_3;
> >>>> +       unsigned long f_4;
> >>>> +};
> >>>> +
> >>> [...]
> >>>
> >>>> +       /* Delete the newly-inserted key */
> >>>> +       bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(systemd_name), 0=
, &key.f_3.name);
> >>>> +       err =3D bpf_dynptr_write(&key.f_3.name, 0, (void *)systemd_n=
ame, sizeof(systemd_name), 0);
> >>>> +       if (err) {
> >>>> +               bpf_ringbuf_discard_dynptr(&key.f_3.name, 0);
> >>>> +               err =3D 10;
> >>>> +               goto out;
> >>>> +       }
> >>>> +       err =3D bpf_map_delete_elem(htab, &key);
> >>>> +       if (err) {
> >>>> +               bpf_ringbuf_discard_dynptr(&key.f_3.name, 0);
> >>>> +               err =3D 11;
> >>>> +               goto out;
> >>>> +       }
> >>>> +
> >>>> +       /* Lookup it again */
> >>>> +       value =3D bpf_map_lookup_elem(htab, &key);
> >>>> +       bpf_ringbuf_discard_dynptr(&key.f_3.name, 0);
> >>>> +       if (value) {
> >>>> +               err =3D 12;
> >>>> +               goto out;
> >>>> +       }
> >>>> +out:
> >>>> +       return err;
> >>>> +}
> >>> So, I'm not a big fan of this approach of literally embedding struct
> >>> bpf_dynptr into map key type and actually initializing and working
> >>> with it directly, like you do here with
> >>> bpf_ringbuf_reserve_dynptr(..., &key.f_3.name).
> >>>
> >>> Here's why. This approach only works for *map keys* (not map values)
> >>> and only when **the copy of the key** is on the stack (i.e., for map
> >>> lookups/updates/deletes). This approach won't work for having dynptrs
> >>> inside map value (for variable sized map values), nor does it really
> >>> work when you get a direct pointer to map key in
> >>> bpf_for_each_map_elem().
> >> Yes. The reason why the key should be on the stack is due to the
> >> limitation (or the design) of bpf_dynptr. However I didn't understand
> >> why it doesn't work for map value just like other special field in the
> >> map value (e.g., bpf_timer) ?
> > bpf_timer and other special things that go into map_value have to
> > painfully and carefully handle simultaneous access and modification of
> > map value. So they either do locking (and thus are not compatible or
> > reliable under NMI), or would need to be implemented locklessly.
> >
> > Dynptr is by design assumed to not be dealing with concurrent
> > modifications, so bpf_dynptr_adjust(), for instance, can just update
> > offset in place without any locking. Reliably and quickly.
>
> Thanks for the explanation here and below. I got it now: multiple bpf
> program could get the same map value through lookup and modify it
> concurrently through helpers or kfuncs. A bit of slow for me to figure
> out by myself. However, I think there is a big difference between
> bpf_dynptr and bpf_timer or other special fields. For bpf_timer, we
> could not update it through bpf_map_update_elem, so extra helpers or
> kfuncs are needed. However, for bpf_dynptr in map key/value, it could be
> updated through bpf_map_{update|delete}_elem(). Therefore, for dynptr in
> map key or map value, does it really need to allow update through
> non-map-update helpers and kfuncs ? Will it be enough to make the dynptr
> in map key/value be read-only ? If the dynptr in map key could be
> modified by bpf_dyptr_adjust(),  the lookup procedure may fail to find
> the target map element.

So you are saying that we would allow to update dynptr using
bpf_map_update_elem() (from BPF side), but allow to use bpf_dynptr
read-only APIs directly on dynptr inside the map_value, is that right?

If that's the case, don't we still have a race between read-only
dynptr usage from BPF program and in-place update from BPF program or
user space from another CPU (through bpf_map_update_elem)?

> >>> Curiously, you do have bpf_for_each_map_elem() "example" in patch #16
> >>> in benchmarks, but you are carefully avoiding actually touching the
> >>> `void *key` passed to your callback. Instead you create a local key,
> >>> do lookup, and then compare the pointers to value to know that you
> >>> "guessed" the key right.
> >>>
> >>> This doesn't seem to be how bpf_for_each_map_elem() is really meant t=
o
> >>> work: you'd want to be able to work with that key for real, get its
> >>> data, etc. Not guess and confirm, like you do.
> >> Er, bpf_for_each_map_elem() for dynptr-keyed hash map has not been
> >> implemented yet (as said in the cover letter), so I used the values in
> >> the array map as the lookup key for the hash map.
> > It would be interesting to see an example on how you were thinking to
> > implement dynptr inside map key. Can you provide a hypothetical
> > example on how you were thinking to approach this?
>
> Haven't started it yet. The early thoughts were:
> 1) support using map key of dynptr-keyed map as the map key for other
> dynptr-keyed map
> 2) support using dynptr in dynptr-keyed map key as dynptr directly
>
> so the following code snippet could work:
>
> struct dynkey_key {
>         int cookie;
>         struct bpf_dynptr desc;
> };
>
> struct {
>         __uint(type, BPF_MAP_TYPE_HASH);
>         __type(key, struct bpf_dynptr);
>         __type(value, unsigned int);
>         __uint(map_flags, BPF_F_NO_PREALLOC);
> }  htab_1 SEC(".maps");
>
> struct {
>         __uint(type, BPF_MAP_TYPE_HASH);
>         __type(key, struct dynkey_key);
>         __type(value, unsigned int);
>         __uint(map_flags, BPF_F_NO_PREALLOC);
> } htab_2 SEC(".maps");
>
> int lookup_dynkey_htab(void *map, void *key, void *val, void *ctx)
> {
>          struct dynkey_key *dkey =3D key;
>
>          bpf_map_lookup_elem(map, dkey);
>          bpf_map_lookup_elem(&htab_1, &dkey->desc);
>
>          bpf_dynptr_read(buf, sizeof(buf), &dkey->desc, 0, 0);
>

All right, and this works just because map key is read-only (and
hopefully we don't reuse that memory until after RCU GP). But how that
should work with map_value? I.e., if you had a dynptr inside `val`
here, would the same approach work?

>          return 0;
> }
>
> bpf_for_each_map_elem(&htab_2, lookup_dynkey_htab, NULL, 0);
>
> >
> >>> And in case it's not obvious why this approach won't work when dynptr=
s
> >>> are stored inside map value. Dynptr itself relies on not being
> >>> modified concurrently. We achieve that through *always* keeping it on
> >>> BPF programs stack, guaranteeing that no concurrently running BPF
> >>> program (BPF program sharing the map, or same program on different
> >>> CPU) can touch the dynptr. This is pretty fundamental. And I don't
> >>> think we should add more locking to dynptr itself just to enable this=
.
> >> I didn't follow that. Even dynptr is kept in map value, how will it be
> >> modified concurrently ? When there are special fields in the map value=
,
> >> the update of the map value will be out-of-place update and the old
> >> dynptr will be kept as intact.
> > Easy. bpf_map_lookup_elem() for the same key from two concurrent CPUs.
> > You get a pointer to the same map value, which BPF programs can modify
> > without any locking absolutely concurrently and in parallel.
> >
> > So you don't even have to do bpf_map_update_elem() to run into troubles=
.
> >
> >
> >
> > So I have an alternative proposal that will extend to map values and
> > real map keys (not they local copy on the stack).
> >
> > I say, we stop pretending that it's an actual dynptr that is stored in
> > the key. It should be some sort of "dynptr impression" (I don't want
> > to bikeshed right now), and user would have to put it into map key for
> > lookup/update/delete through a special kfunc (let's call this
> > "bpf_dynptr_stash" for now). When working with an existing map key
> > (and map value in the future), we need to create a local real dynptr
> > from its map key/value "impression", say, with "bpf_dynptr_unstash".
> >
> > bpf_dynptr_stash() is effectively bpf_dynptr_clone() (so all the
> > mechanics is already supported by verifier). bpf_dynptr_unstash() is
> > effectively bpf_dynptr_from_mem(). But they might need a slight change
> > to accommodate a different actual struct type we'll use for that
> > stashed dynptr.
> >
> > So just to show what I mean on pseudo example:
> >
> >
> > struct bpf_stashed_dynptr {
> >    __bpf_md_ptr(void *, data);
> >    __u32 size;
> >    __u32 reserved;
> > }
> >> It will be an ABI for both bpf program and bpf syscall just like
> >> bpf_dynptr, right ? Therefore, when bpf_stashed_dynptr is used in the
> >> bpf program, we need to implement something similar for the struct jus=
t
> >> like dynptr, because we need to ensure both ->data and ->size are vali=
d,
> > Yes, direct BPF program (or user space) access to this
> > bpf_stashed_dynptr has to be restricted, of course, just like for any
> > other embedded special struct (timer, wq, lock). Only the kernel and
> > stashing/unstashing API should be able to access this data directly
> > (and very carefully, of course).
>
> OK.
> >
> >> right ? If it may be not safe to keep dynptr in the map key/value, how
> >> will it be safe to keep bpf_stashed_dynptr in the map key/value ?
> > Because you'll have a carefully written two APIs to stash/unstash BPF
> > dynptr into/out of map value. Those two will do this operation
> > atomically in the face of concurrent map value modifications. But once
> > you have a local dynptr, all existing dynptr APIs (including
> > bpf_dynptr_adjust) will deal with local dynptr that is safe to modify.
> >
> >
> > You can't really achieve the same with dynptr even if you restrict
> > what kind of API can be called on dynptr-in-map-value. Because even
> > read-only APIs like bpf_dynptr_slice() assume that underlying dynptr
> > can be accessed without locking and won't be concurrently modified.
> > This is not true at least for per-CPU maps, isn't it? So user space
> > can update per-CPU map value while it is being accessed from the BPF
> > program. This will inevitably lead to problems when working with
> > dynptr inside map value directly.
>
> Thanks for the explanation. So let me summarize the reasons for choosing
> (and not choosing) `bpf_stashed_dynptr`:
>
> 1) always keep bpf_dynptr in the stack to keep its design be simple (no
> concurrent update)
> However, we could make the bpf_dynptr in map key and value be read-only.

See above, it could work for map key. It cannot work for map value,
even if we make it "read-only" for BPF program side. Because user
space can still update it. Or even another BPF program, if we allow
bpf_map_update_elem(). Which we should, otherwise it's some kind of
write-once or write-only-from-user-space map_value, no?

>
> 2) need to support concurrent update through non-bpf_map_update_elem help=
ers
> However, if the dynptr in map key and value is read-only, there will be
> no concurrent update. The update could be done through
> bpf_map_update_elem helper.
>
> 3) need to support in-place update through bpf_map_update_elem helper
> (e.g., for per-CPU map)
> However, if we need to support dynptr in map value, maybe we should
> change the in-place update to out-of-place update.
>
> Hope I didn't miss any point.

So, basically, if we unnecessarily restrict usability of dynptr, we
might carve out some way to work with dynptrs inside map key (but not
really map value, as I explained).

On the other hand, we can have "stashed dynptr" and make it work the
same way in all situations.

Tough choice, isn't it? ;)

>
> >
> >>> struct id_dname_key {
> >>>        int id;
> >>>        struct bpf_stashed_dynptr name;
> >>> };
> >>>
> > [...]
> >
> >>> /* FOR_EACH_MAP_ELEM_KEY READING */
> >>> static int cb(void *map, void *key, void *value, void *ctx)
> >>> {
> >>>     struct id_dname_key *k =3D key;
> >>>     struct bpf_dynptr dptr;
> >>>     const void *name;
> >>>
> >>>     /* create local real dynptr from stashed one in the key in the ma=
p */
> >>>     bpf_dynptr_unstash(&k->name, &dptr);
> >>>
> >>>     /* get direct memory access to the data stored in the key, NO COP=
IES! */
> >>>     name =3D bpf_dynptr_slice(&dptr, ....);
> >>>     if (name)
> >>>         bpf_printk("my_key.name: %s", name);
> >>> }
> >> The point here is to avoid keeping bpf_dynptr in the map key and to sa=
ve
> >> it in the stack instead, right ?
> > yes
> >
> >>> ...
> >>>
> >>> bpf_for_each_map_elem(&htab, cb, NULL, 0); /* iterate */
> >>>
> >>>
> >>>
> >>> And I'm too lazy to write this for hypothetical map value use case.
> >>> Map value has an extra challenge of making sure stashing/unstashing
> >>> handle racy updates from other CPUs, which I believe you can do with
> >>> seqcount-like approach (no heavy-weight locking).
> >>>
> >>> BTW, this dedicated `struct bpf_stashed_dynptr` completely avoids tha=
t
> >>> double-defined `struct bpf_dynptr` you do in patch #6. Kernel will
> >>> know it's something like a real dynptr when doing update/lookup/delet=
e
> >>> from on-the-stack key copy, and that it's a completely different thin=
g
> >>> when it's actually stored inside the map in the key (and, eventually,
> >>> in the value). And in user space it will be a still different
> >>> definition, which kernel will provide when doing lookups from user
> >>> space.
> >>>
> >>> Hope this makes sense.
> >> Thanks for the suggestion.
> >>> [...]
>

