Return-Path: <bpf+bounces-52610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B574A453F8
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 04:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBD3D16D569
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 03:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E8D254877;
	Wed, 26 Feb 2025 03:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSdR47BB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1B719DF7D;
	Wed, 26 Feb 2025 03:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740540309; cv=none; b=orF6XEqojpK08S4U9gsBX51jbM5gZ5wVu8xrP7TayOgVopEMog+a4ZmR2QTF5VM1LtPePtO9z27YrwkpuOau0ecyPvKS0KgH7tn3V6JE4mWJhnrM1dhE4ZKRlOo+ABsRJMUucWsXRHMqOgp9MjrLH/p5aqyj/G+56RGi+rd6w+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740540309; c=relaxed/simple;
	bh=dFmnEL7tdGsyVm38+0uwSCE+G21Xl+Tvd7JQoPE4ocI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f2Pl0eCY6a4A626+AgBo6bhNWhuuHHwnjEejMWQkcHKSGBoZ+N0S8Hn7W3IXMVRNyNpoiiapObczvjghdkZvUgPCCAl92fXUY5tDb7v2ykPTjcds1gENWyHD01fcSgR/RZbnfJLfmT+PsmXixShNFLDhbbB3yYmFT7xjTyWeDj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSdR47BB; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43998deed24so59940995e9.2;
        Tue, 25 Feb 2025 19:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740540306; x=1741145106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzqTi1AQE5sC4W17cptqWOe4gVnr9yxjwJGxRjayufA=;
        b=FSdR47BBqbqHMy52iGz+MVLJr+BhlkdLzsZPQKprDi7sFwKO3NkuccDI5ur2ekF+83
         lK8Qh9cPNf5n8cNNDUYe5kt/HarpCgcyBdvnIPxsdBOrLNkcvjNqLDlq0wDhZxMSqf4/
         +wDyrxc0qYYUbgP9P5i8RyE1MYDAEY28GXo6NiLilMYaTlsicA8y+vvyByf9Y2bOHwIn
         WlwQTaueLJaMST8mMmXVX/5nLvF3GyNkiRY+dKxOLl4bB73Jn7oZnTfQD1nLpSNIZb2F
         hfCVKvUBPiW4wAABkQKD6y9CE+7RtfKnrukdx0OZlnyiJ5rOX+0pOK46vUHH9AaTjGxP
         xEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740540306; x=1741145106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AzqTi1AQE5sC4W17cptqWOe4gVnr9yxjwJGxRjayufA=;
        b=rqtyuwSuLYTtXHnsUjyCrQt7CPFzSniLoAy7aTpyycU4QtmJiIBmtwGkV0PHx1y7xM
         TjpLS9Xe8thtcl4QxaM1bJrMCowypBlbuL7o9HIYYg0h2mJg+dpRjVekGTDDxNAQ379J
         9MFYCwMDREtwNAMiFJcy9ojE3I/8d83lBY0fESmtMg1Mhsu1zcSQkFIeHzep1zjcNJGJ
         i+/txznIdZQ2oCxx9vPbcB7wE5Mqq/zgKYGWb34CnOnnerJIrHDA0HakEbnDeBVPW3cb
         skRjBqGEUDAND1aNR7soPGYi3B95b/zVBuWbh16RgqT1JkNAhjseW9fbg0pC4w6Qo7n2
         Ivvg==
X-Forwarded-Encrypted: i=1; AJvYcCU5ZSdAkS2ljq2kLvb4acoJ64b4EwngDyt63t4pV/aRT+X9R2r3/C2L9HzqZy8riArKi0U=@vger.kernel.org, AJvYcCUoMT0bmhRMA1kVtJwugUOhHCxT1e7unQLUHk3kuQcMjkrIMOzWvnzsmK5L6N45rumcMz52@vger.kernel.org, AJvYcCX4+KreXy/j6TC22Bkhi/XtYpQ/Kj9+Fd9D1aTQPzIPhPzHQlNxLxLP9BqUNtTlzbK34smLGXC6U8q5Mf5w@vger.kernel.org
X-Gm-Message-State: AOJu0YwtqMk0dEdDfv4iyY8ffvm3OWh3eCkZSsKK6CR8CwXrV1oFk7nR
	TnHGaOI/aqlSlEasqPkEHbIoDejwDiMZRM9u4AsArxTWIBs6OBJykTOVso7mYLEoIVboLPd14Pv
	tOUEPBguNgId2j8EVW6PMvNoF9cVgMw==
X-Gm-Gg: ASbGnctgaBn1ebCEkTswjbdLZJoI05VDJKHX2Q2aV3PCPPb2oqNrW7jnPl1VjwpIyIV
	b3OQ9yVyCqtWcO/sHbJO61wlId/nEvVz7Z5nWlcQLw3Ka34tp9e7U/iw7sd76paWm2V/sHquoMr
	hBc9kKD3jGOT1OIcdFxfw7S2Y=
X-Google-Smtp-Source: AGHT+IEooBlNTp4RMXo8uB8s3ApEb/P85w54nO/owFRgNhva92I3zr/WLBejg93GY2bJTnm9CRyGMt8dKZYy358Hccs=
X-Received: by 2002:a05:600c:4687:b0:439:9aca:3285 with SMTP id
 5b1f17b1804b1-439b6ad5cbfmr139779135e9.6.1740540306251; Tue, 25 Feb 2025
 19:25:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204082848.13471-1-hotforest@gmail.com> <20250204082848.13471-3-hotforest@gmail.com>
 <cca6daf2-48f4-57b9-59a9-75578bb755b9@huaweicloud.com> <8734gr3yht.fsf@toke.dk>
 <d191084a-4ab4-8269-640f-1ecf269418a6@huaweicloud.com>
In-Reply-To: <d191084a-4ab4-8269-640f-1ecf269418a6@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 25 Feb 2025 19:24:54 -0800
X-Gm-Features: AQ5f1JpGMqna7zKRv-d34RaxDYwjiYV3ASBLQvkvRZ7y5rABCKQSiZPBHQffft4
Message-ID: <CAADnVQKD94q-G4N=w9PJU+k6gPhM8GmUYcyfj=33B_mKX6Qbjw@mail.gmail.com>
Subject: Re: [RESEND] [PATCH bpf-next 2/3] bpf: Overwrite the element in hash
 map atomically
To: Hou Tao <houtao@huaweicloud.com>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>, 
	bpf <bpf@vger.kernel.org>, rcu@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "Paul E . McKenney" <paulmck@kernel.org>, Cody Haas <chaas@riotgames.com>, 
	Hou Tao <hotforest@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 8, 2025 at 2:17=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> Hi Toke,
>
> On 2/6/2025 11:05 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > Hou Tao <houtao@huaweicloud.com> writes:
> >
> >> +cc Cody Haas
> >>
> >> Sorry for the resend. I sent the reply in the HTML format.
> >>
> >> On 2/4/2025 4:28 PM, Hou Tao wrote:
> >>> Currently, the update of existing element in hash map involves two
> >>> steps:
> >>> 1) insert the new element at the head of the hash list
> >>> 2) remove the old element
> >>>
> >>> It is possible that the concurrent lookup operation may fail to find
> >>> either the old element or the new element if the lookup operation sta=
rts
> >>> before the addition and continues after the removal.
> >>>
> >>> Therefore, replacing the two-step update with an atomic update. After
> >>> the change, the update will be atomic in the perspective of the looku=
p
> >>> operation: it will either find the old element or the new element.

I'm missing the point.
This "atomic" replacement doesn't really solve anything.
lookup will see one element.
That element could be deleted by another thread.
bucket lock and either two step update or single step
don't change anything from the pov of bpf prog doing lookup.

> >>>
> >>> Signed-off-by: Hou Tao <hotforest@gmail.com>
> >>> ---
> >>>  kernel/bpf/hashtab.c | 14 ++++++++------
> >>>  1 file changed, 8 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> >>> index 4a9eeb7aef85..a28b11ce74c6 100644
> >>> --- a/kernel/bpf/hashtab.c
> >>> +++ b/kernel/bpf/hashtab.c
> >>> @@ -1179,12 +1179,14 @@ static long htab_map_update_elem(struct bpf_m=
ap *map, void *key, void *value,
> >>>             goto err;
> >>>     }
> >>>
> >>> -   /* add new element to the head of the list, so that
> >>> -    * concurrent search will find it before old elem
> >>> -    */
> >>> -   hlist_nulls_add_head_rcu(&l_new->hash_node, head);
> >>> -   if (l_old) {
> >>> -           hlist_nulls_del_rcu(&l_old->hash_node);
> >>> +   if (!l_old) {
> >>> +           hlist_nulls_add_head_rcu(&l_new->hash_node, head);
> >>> +   } else {
> >>> +           /* Replace the old element atomically, so that
> >>> +            * concurrent search will find either the new element or
> >>> +            * the old element.
> >>> +            */
> >>> +           hlist_nulls_replace_rcu(&l_new->hash_node, &l_old->hash_n=
ode);
> >>>
> >>>             /* l_old has already been stashed in htab->extra_elems, f=
ree
> >>>              * its special fields before it is available for reuse. A=
lso
> >>>
> >> After thinking about it the second time, the atomic list replacement o=
n
> >> the update side is enough to make lookup operation always find the
> >> existing element. However, due to the immediate reuse, the lookup may
> >> find an unexpected value. Maybe we should disable the immediate reuse
> >> for specific map (e.g., htab of maps).
> > Hmm, in an RCU-protected data structure, reusing the memory before an
> > RCU grace period has elapsed is just as wrong as freeing it, isn't it?
> > I.e., the reuse logic should have some kind of call_rcu redirection to
> > be completely correct?
>
> Not for all cases. There is SLAB_TYPESAFE_BY_RCU-typed slab. For hash
> map, the reuse is also tricky (e.g., the goto again case in
> lookup_nulls_elem_raw), however it can not prevent the lookup procedure
> from returning unexpected value. I had post a patch set [1] to "fix"
> that, but Alexei said it is "a known quirk". Here I am not sure about
> whether it is reasonable to disable the reuse for htab of maps only. I
> will post a v2 for the patch set.
>
> [1]:
> https://lore.kernel.org/bpf/20221230041151.1231169-1-houtao@huaweicloud.c=
om/

yes. we still have to keep prealloc as default for now :(
Eventually bpf_mem_alloc is replaced with fully re-entrant
and safe kmalloc, then we can do fully re-entrant and safe
kfree_rcu. Then we can talk about closing this quirk.
Until then the prog has to deal with immediate reuse.
That was the case for a decade already.

