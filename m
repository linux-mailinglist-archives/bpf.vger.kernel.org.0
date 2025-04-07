Return-Path: <bpf+bounces-55414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CD1A7E60F
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 18:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5958B4450BB
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 16:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DEC2063CB;
	Mon,  7 Apr 2025 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOX2OWph"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7865E1F55EB
	for <bpf@vger.kernel.org>; Mon,  7 Apr 2025 16:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744041961; cv=none; b=ALQ1Y8wYYMk2ia3oQKWF3CoNp6K75hXxzVtdgQpVp/+kThZPQx3O9t0Bc2uCEx47ib3aEczY4qfDWVI7K/4pShU9aEGIthBeEBGr9KTX5rRVYg452pHFbXPdC2Zmucm3nXC9Ilw4K3CeyMSedNNWTRJ2P2SrlHX9koeWZZAD7ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744041961; c=relaxed/simple;
	bh=imyOalRdg1Zs5Uvx8ORdnubY5TPzQd9piSB/7IBy5qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O0wdWCouVM63CEzeU70MsUiHyJ/IUg3+gBdsZXHwLK8cRa8xZj/ca/9exg5Hi6SgKJ81qWtyM2BfmKz8vFla+XHfNx1Ov38d7noGdkFpXkbF4UqfptgOo0PCmlIP+pLPETcBU9MCJWLSbKX/HUH7pZ+NWyi2Rz4aqkeLmYLCgOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOX2OWph; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-227b650504fso40360615ad.0
        for <bpf@vger.kernel.org>; Mon, 07 Apr 2025 09:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744041958; x=1744646758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04a13O3xu8MleWctNe9kbCexkF6bI7CA3QIP6ofkmH4=;
        b=jOX2OWphXSaUSMcgp63WA38VjOZro9s/TGzhd/s3oisBaoBuDkVO3aty2KcsNCkYEW
         EmfIa7mfXFDfR9iwRVupRN3UaKACdigWoyYYFWMU+FLQyt7Q8MrsXocs8tCDXrdMCLxk
         bPT9F9TIcTe6jlcrTYhWRyVxNdVfNCFOT0hnhtCAWgg41N2ODlFzpw8xepCEOcB94IXq
         g9g2jiojF+xPKJFAQksf6nJLN8TnGEqppUeWg90fb1/8W+HirQ5j2FNbUiviKxtFYQsO
         +IJqsycn8ykvR86a0u7MLIoypEGDm04kSotnswMlS2dwC8GIbMWvTKl+3M3vuuDH3e9E
         BIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744041958; x=1744646758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04a13O3xu8MleWctNe9kbCexkF6bI7CA3QIP6ofkmH4=;
        b=Nm5cIX8zNp6hNQzx/xuNDkveSyslT6XdBNqBcfSMgaAiKDBqkS0sie6fSS+DmnXsRe
         +BcPULov6dSdPnxHfh6rpjKvK3F+5r2oIUGDgu+3H4zfjSZIeHXDjdz18iiOHbkP8Ccg
         xUUayq4QYL6picTI8MDWGsyuKY0/H7WY4E2Dv2I2i/PQsTQX+Tw+vGtpNTac0LCDKr/W
         8ZrrfmSjwUY8CXr5Apbxb/h+102uIYYZQyXz2nRQD0C1LxODCH+l2j5PxYOYzsCmfFcN
         GwbL2PUe1OCFh5OBO58uQXsHqQveN41J+GWwLA29lrPVdd8xy+N5nR2USRlmINFgxTgH
         izTg==
X-Gm-Message-State: AOJu0YwGL+XxUWAucSzXqXfObM+G7MJTUfM2KgtrGqvIp3dph8t6ayni
	vFX7l9NBtHmgFfnaHrII2krBQR+XD+SbsAtagjVyGcgV63b75qZjliH6FlwDEHfmxRXCweBOYTl
	eRq8G13mNa5wUr3xfp/NxkLaRDZLNzg==
X-Gm-Gg: ASbGncuSkM8tFDRoYoARokFknuQheWl6Ftx4Ek7Bp1uUJrHGSxtus+sif5CyVxZUXZ0
	/YLrWO0O6/+fA4EtpWX5UTesVOVzUE61WxVuGqN/FhNLZRNuC48spmO/kevUpPGqoLHk3GSIM35
	hTv1kDy7bf2u8vRUaDrxjzCnwufwKMf0OHP402moY4bgEprPC5sCEs
X-Google-Smtp-Source: AGHT+IF4jkFJOpppQ2Cd4+kADFmAQQZ1piXHHYQPUndv78XUGcu6RWv+wISDjn/I+bBoVOlsDlEesLY3FtHthdnt1es=
X-Received: by 2002:a17:903:1251:b0:220:e1e6:4457 with SMTP id
 d9443c01a7336-22a8a06cdcdmr142855515ad.26.1744041958416; Mon, 07 Apr 2025
 09:05:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327083455.848708-1-houtao@huaweicloud.com>
 <20250327083455.848708-16-houtao@huaweicloud.com> <CAEf4BzY6Y=40NHs12r3Jb7u_N8CVapwRuF09+dmxBH85J2t88w@mail.gmail.com>
 <34a1d3a2-0b63-7f11-9da2-5966b24e179b@huaweicloud.com>
In-Reply-To: <34a1d3a2-0b63-7f11-9da2-5966b24e179b@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 7 Apr 2025 09:05:45 -0700
X-Gm-Features: ATxdqUGvJa5XNuSo2CaOZsXxnDcGg0YLIGXsWooGkmbidDOeh4ThWE3U0Z0fK7w
Message-ID: <CAEf4BzZY5OSBs3xEdhgC7hjwjQ9C4j+uyLxjjqAjc-ek_pJRog@mail.gmail.com>
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

On Sun, Apr 6, 2025 at 7:47=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> Hi,
>
> On 4/5/2025 1:58 AM, Andrii Nakryiko wrote:
> > On Thu, Mar 27, 2025 at 1:23=E2=80=AFAM Hou Tao <houtao@huaweicloud.com=
> wrote:
> >> From: Hou Tao <houtao1@huawei.com>
> >>
> >> Add three positive test cases to test the basic operations on the
> >> dynptr-keyed hash map. The basic operations include lookup, update,
> >> delete and get_next_key. These operations are exercised both through
> >> bpf syscall and bpf program. These three test cases use different map
> >> keys. The first test case uses both bpf_dynptr and a struct with only
> >> bpf_dynptr as map key, the second one uses a struct with an integer an=
d
> >> a bpf_dynptr as map key, and the last one use a struct with two
> >> bpf_dynptr as map key: one in the struct itself and another is nested =
in
> >> another struct.
> >>
> >> Also add multiple negative test cases for dynptr-keyed hash map. These
> >> test cases mainly check whether the layout of dynptr and non-dynptr in
> >> the stack is matched with the definition of map->key_record.
> >>
> >> Signed-off-by: Hou Tao <houtao1@huawei.com>
> >> ---
> >>  .../bpf/prog_tests/htab_dynkey_test.c         | 446 +++++++++++++++++=
+
> >>  .../bpf/progs/htab_dynkey_test_failure.c      | 266 +++++++++++
> >>  .../bpf/progs/htab_dynkey_test_success.c      | 382 +++++++++++++++
> >>  3 files changed, 1094 insertions(+)
> >>  create mode 100644 tools/testing/selftests/bpf/prog_tests/htab_dynkey=
_test.c
> >>  create mode 100644 tools/testing/selftests/bpf/progs/htab_dynkey_test=
_failure.c
> >>  create mode 100644 tools/testing/selftests/bpf/progs/htab_dynkey_test=
_success.c
> >>
> > [...]
> >
> >> diff --git a/tools/testing/selftests/bpf/progs/htab_dynkey_test_succes=
s.c b/tools/testing/selftests/bpf/progs/htab_dynkey_test_success.c
> >> new file mode 100644
> >> index 0000000000000..84e6931cc19c0
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/bpf/progs/htab_dynkey_test_success.c
> >> @@ -0,0 +1,382 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/* Copyright (C) 2025. Huawei Technologies Co., Ltd */
> >> +#include <linux/types.h>
> >> +#include <linux/bpf.h>
> >> +#include <bpf/bpf_helpers.h>
> >> +#include <bpf/bpf_tracing.h>
> >> +#include <errno.h>
> >> +
> >> +#include "bpf_misc.h"
> >> +
> >> +char _license[] SEC("license") =3D "GPL";
> >> +
> >> +struct pure_dynptr_key {
> >> +       struct bpf_dynptr name;
> >> +};
> >> +
> >> +struct mixed_dynptr_key {
> >> +       int id;
> >> +       struct bpf_dynptr name;
> >> +};
> >> +
> >> +struct multiple_dynptr_key {
> >> +       struct pure_dynptr_key f_1;
> >> +       unsigned long f_2;
> >> +       struct mixed_dynptr_key f_3;
> >> +       unsigned long f_4;
> >> +};
> >> +
> > [...]
> >
> >> +       /* Delete the newly-inserted key */
> >> +       bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(systemd_name), 0, =
&key.f_3.name);
> >> +       err =3D bpf_dynptr_write(&key.f_3.name, 0, (void *)systemd_nam=
e, sizeof(systemd_name), 0);
> >> +       if (err) {
> >> +               bpf_ringbuf_discard_dynptr(&key.f_3.name, 0);
> >> +               err =3D 10;
> >> +               goto out;
> >> +       }
> >> +       err =3D bpf_map_delete_elem(htab, &key);
> >> +       if (err) {
> >> +               bpf_ringbuf_discard_dynptr(&key.f_3.name, 0);
> >> +               err =3D 11;
> >> +               goto out;
> >> +       }
> >> +
> >> +       /* Lookup it again */
> >> +       value =3D bpf_map_lookup_elem(htab, &key);
> >> +       bpf_ringbuf_discard_dynptr(&key.f_3.name, 0);
> >> +       if (value) {
> >> +               err =3D 12;
> >> +               goto out;
> >> +       }
> >> +out:
> >> +       return err;
> >> +}
> >
> > So, I'm not a big fan of this approach of literally embedding struct
> > bpf_dynptr into map key type and actually initializing and working
> > with it directly, like you do here with
> > bpf_ringbuf_reserve_dynptr(..., &key.f_3.name).
> >
> > Here's why. This approach only works for *map keys* (not map values)
> > and only when **the copy of the key** is on the stack (i.e., for map
> > lookups/updates/deletes). This approach won't work for having dynptrs
> > inside map value (for variable sized map values), nor does it really
> > work when you get a direct pointer to map key in
> > bpf_for_each_map_elem().
>
> Yes. The reason why the key should be on the stack is due to the
> limitation (or the design) of bpf_dynptr. However I didn't understand
> why it doesn't work for map value just like other special field in the
> map value (e.g., bpf_timer) ?

bpf_timer and other special things that go into map_value have to
painfully and carefully handle simultaneous access and modification of
map value. So they either do locking (and thus are not compatible or
reliable under NMI), or would need to be implemented locklessly.

Dynptr is by design assumed to not be dealing with concurrent
modifications, so bpf_dynptr_adjust(), for instance, can just update
offset in place without any locking. Reliably and quickly.

> >
> > Curiously, you do have bpf_for_each_map_elem() "example" in patch #16
> > in benchmarks, but you are carefully avoiding actually touching the
> > `void *key` passed to your callback. Instead you create a local key,
> > do lookup, and then compare the pointers to value to know that you
> > "guessed" the key right.
> >
> > This doesn't seem to be how bpf_for_each_map_elem() is really meant to
> > work: you'd want to be able to work with that key for real, get its
> > data, etc. Not guess and confirm, like you do.
>
> Er, bpf_for_each_map_elem() for dynptr-keyed hash map has not been
> implemented yet (as said in the cover letter), so I used the values in
> the array map as the lookup key for the hash map.

It would be interesting to see an example on how you were thinking to
implement dynptr inside map key. Can you provide a hypothetical
example on how you were thinking to approach this?

> >
> > And in case it's not obvious why this approach won't work when dynptrs
> > are stored inside map value. Dynptr itself relies on not being
> > modified concurrently. We achieve that through *always* keeping it on
> > BPF programs stack, guaranteeing that no concurrently running BPF
> > program (BPF program sharing the map, or same program on different
> > CPU) can touch the dynptr. This is pretty fundamental. And I don't
> > think we should add more locking to dynptr itself just to enable this.
>
> I didn't follow that. Even dynptr is kept in map value, how will it be
> modified concurrently ? When there are special fields in the map value,
> the update of the map value will be out-of-place update and the old
> dynptr will be kept as intact.

Easy. bpf_map_lookup_elem() for the same key from two concurrent CPUs.
You get a pointer to the same map value, which BPF programs can modify
without any locking absolutely concurrently and in parallel.

So you don't even have to do bpf_map_update_elem() to run into troubles.

>
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
>
> It will be an ABI for both bpf program and bpf syscall just like
> bpf_dynptr, right ? Therefore, when bpf_stashed_dynptr is used in the
> bpf program, we need to implement something similar for the struct just
> like dynptr, because we need to ensure both ->data and ->size are valid,

Yes, direct BPF program (or user space) access to this
bpf_stashed_dynptr has to be restricted, of course, just like for any
other embedded special struct (timer, wq, lock). Only the kernel and
stashing/unstashing API should be able to access this data directly
(and very carefully, of course).

> right ? If it may be not safe to keep dynptr in the map key/value, how
> will it be safe to keep bpf_stashed_dynptr in the map key/value ?

Because you'll have a carefully written two APIs to stash/unstash BPF
dynptr into/out of map value. Those two will do this operation
atomically in the face of concurrent map value modifications. But once
you have a local dynptr, all existing dynptr APIs (including
bpf_dynptr_adjust) will deal with local dynptr that is safe to modify.


You can't really achieve the same with dynptr even if you restrict
what kind of API can be called on dynptr-in-map-value. Because even
read-only APIs like bpf_dynptr_slice() assume that underlying dynptr
can be accessed without locking and won't be concurrently modified.
This is not true at least for per-CPU maps, isn't it? So user space
can update per-CPU map value while it is being accessed from the BPF
program. This will inevitably lead to problems when working with
dynptr inside map value directly.

> >
> > struct id_dname_key {
> >        int id;
> >        struct bpf_stashed_dynptr name;
> > };
> >

[...]

> > /* FOR_EACH_MAP_ELEM_KEY READING */
> > static int cb(void *map, void *key, void *value, void *ctx)
> > {
> >     struct id_dname_key *k =3D key;
> >     struct bpf_dynptr dptr;
> >     const void *name;
> >
> >     /* create local real dynptr from stashed one in the key in the map =
*/
> >     bpf_dynptr_unstash(&k->name, &dptr);
> >
> >     /* get direct memory access to the data stored in the key, NO COPIE=
S! */
> >     name =3D bpf_dynptr_slice(&dptr, ....);
> >     if (name)
> >         bpf_printk("my_key.name: %s", name);
> > }
>
> The point here is to avoid keeping bpf_dynptr in the map key and to save
> it in the stack instead, right ?

yes

> >
> > ...
> >
> > bpf_for_each_map_elem(&htab, cb, NULL, 0); /* iterate */
> >
> >
> >
> > And I'm too lazy to write this for hypothetical map value use case.
> > Map value has an extra challenge of making sure stashing/unstashing
> > handle racy updates from other CPUs, which I believe you can do with
> > seqcount-like approach (no heavy-weight locking).
> >
> > BTW, this dedicated `struct bpf_stashed_dynptr` completely avoids that
> > double-defined `struct bpf_dynptr` you do in patch #6. Kernel will
> > know it's something like a real dynptr when doing update/lookup/delete
> > from on-the-stack key copy, and that it's a completely different thing
> > when it's actually stored inside the map in the key (and, eventually,
> > in the value). And in user space it will be a still different
> > definition, which kernel will provide when doing lookups from user
> > space.
> >
> > Hope this makes sense.
>
> Thanks for the suggestion.
> > [...]
>

