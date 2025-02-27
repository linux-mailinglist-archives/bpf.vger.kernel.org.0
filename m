Return-Path: <bpf+bounces-52710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C31B1A471E4
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 03:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C97D77AD65F
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 01:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDEB1465AB;
	Thu, 27 Feb 2025 01:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFine1U6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B577E0E4;
	Thu, 27 Feb 2025 01:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740621593; cv=none; b=KXdn8kPLAcUtRUvEVb5/Idojn1Zm/a1SXN5ltOP0X9fpyOmKgUl/VRdOAKxvi0LhqqnQr9GJfqxF3cisBtG/sQJjfiOd4w3ITVLC5X1fLfYrxOkSjuRchgOkaQslL/v59wS5n0L0AWacsVWvJ3z7+qrgVwz8IvlAHZsoEnc+voc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740621593; c=relaxed/simple;
	bh=f0Z5kRx+dR4soY3vCbMiYydu9e/yMavT0U1XWdNsNXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pgeJHa3a7pnbiTP9sGeK+oeCW8Fs1xxIDApR3CIkiuwQ5WBwyN8s5Q+Qq4s+9UYm5ypJB2o20l5X2H5/8Qr1marE4501+yBpO7tN7jzQKbPMsrmSU0bv1xjjup1whSFiDDi3P7yQE73L1mluUOVvbUUNDBeqStJkREYmq9hfQE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFine1U6; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-439ac3216dcso2841575e9.1;
        Wed, 26 Feb 2025 17:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740621590; x=1741226390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqwvNkA3NWkjysaFqna5rqnzFyhX/oYcK1gAr6tgHOk=;
        b=SFine1U6VtHiLB/HVVQJaA3Ba3zmBNrsafDo44Tfu3D0Yu4Mcc1vsUTNMVlbShcFzV
         nwCFtWjacDocDnFQwKXyw8N31kSR4xAML/Tv3znuY5+j9LHOnG2Syy6eKmzWoOemuuRF
         3LCqVxgNF0fJhToYspJu+HudNGEXnBQLgGNnn7Du89H2hqi/NRPZwSL+hc4g1ZMARspA
         t7+DBanC+M+6gBXJOQb/8p6cIjxyBIsAGUtyWtgiGq3NYavMIgVzdIawC73tS48XB4P6
         jmwD0cPDZ1eBqjqEc7Ao6w4bIZbynuJXry4J64YV4OlkFb8cCLnOSMHKysgyxIjCIhew
         NO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740621590; x=1741226390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqwvNkA3NWkjysaFqna5rqnzFyhX/oYcK1gAr6tgHOk=;
        b=KGlUCMu1AW0mWLS2XrH8nEDL439HDu6GfvdDR59Z+c80sczZhTeoGKSQTdhhRfmLdq
         XGtOA3VToXDebyVUtXzu3JQtzpZ9Kei6cdAB3e7JDxHjxpfKYS2RkL4f0TmA0do500gR
         sepcVE56msBlqUgiat8xPm+MFeNpeV+1AUKVhtYzvfC6MsVNGODYMyZk+L2MkfhlLEXH
         6MgzR76NlDuI/Aag2hgm8rJc44HG0z++EH7/HdXWr5X/TVP3nI322DlqTL9xqr0/YN8V
         DNye7hdkA/llc5DNTFZsHxbqrgk2nG22we+zDVy6LGHb8lEmPT1a2/XmMa3ek08nUXH0
         o/Mw==
X-Forwarded-Encrypted: i=1; AJvYcCWdxnBS7NbdOpSq6YOa4vp7TBjgmzvITDVyT1RZm7QE0coYJeMCNCSdLxA71o7ZwxGx47K3@vger.kernel.org, AJvYcCX8LZrRWZPBZ6AsI+z/S+5PzjtaVW5/bnDbmMaRlZ/fQbVOwPnG71dnbBxzG/y8e4BKIxqNJP3nAx/T4uRy@vger.kernel.org, AJvYcCXgz6iXZRN3hv9Fss1nALUBVo0jhgZ5/7JoLFQcRvbameIfQJ+nMgGV4+XU2KDmX7HYLws=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvRfzKR7ZpGRuU3ArDwK4bVOhHhDJc7X43P4c1x00LW6bl2FRV
	CFqWEBmQNkPSookNuBMpr2jeOx7lhxZ2qqmmyKMjGnAzK2opkuKpehx/iHcvPToQEbEymlAfLeW
	LBCaS53qHwiPVVKwpU8XRaD2X7a3/Pger
X-Gm-Gg: ASbGncvJb4dO4VJUIxXblGlN21Bbn5gVdIGvgFENnEKl1RpHTpu+6yD8F2TQypv8rw2
	j06uRZ0j+khz5AFQzET/MJPW8sRaJarM5I3T2Voj5eJKq1kGHnSy8Dugbds1WZ1TVtR36Lg/LRd
	0vxWOFtgp6Kq7/AMLy10JKuHI=
X-Google-Smtp-Source: AGHT+IG+rtsSCV3WwzXwUaqCz1Qu9gUmgxusmLrBia8mvrVBQVfM6F0oN7T2bQb+eJJ0g9Uc0Bw6f8Z/K8uOajf3xoU=
X-Received: by 2002:a05:600c:1383:b0:439:8a44:1e65 with SMTP id
 5b1f17b1804b1-439aeafaa00mr201026955e9.7.1740621589446; Wed, 26 Feb 2025
 17:59:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204082848.13471-1-hotforest@gmail.com> <20250204082848.13471-3-hotforest@gmail.com>
 <cca6daf2-48f4-57b9-59a9-75578bb755b9@huaweicloud.com> <8734gr3yht.fsf@toke.dk>
 <d191084a-4ab4-8269-640f-1ecf269418a6@huaweicloud.com> <CAADnVQKD94q-G4N=w9PJU+k6gPhM8GmUYcyfj=33B_mKX6Qbjw@mail.gmail.com>
 <6a84a878-0728-0a19-73d2-b5871e10e120@huaweicloud.com> <CAADnVQLrJBOSXP41iO+-FtH+XC9AmuOne7xHzvgXop3DUC5KjQ@mail.gmail.com>
 <CAC1LvL0ntdrWh_1y0EcVR6C1_WyqOQ15EhihfQRs=ai7pcE-Sw@mail.gmail.com> <7e614d80-b45b-e2f9-5a39-39086c2392dc@huaweicloud.com>
In-Reply-To: <7e614d80-b45b-e2f9-5a39-39086c2392dc@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 26 Feb 2025 17:59:38 -0800
X-Gm-Features: AQ5f1JrtDlHPcrwBLDwNsRZeFDc4x5hD9HvSyCtZKrQ1g-q1TNCxTEiwMqcqRMI
Message-ID: <CAADnVQJU9OWAWFk89P6i1RK6vXkuee5s76suHjF+uP+V4iepqQ@mail.gmail.com>
Subject: Re: [RESEND] [PATCH bpf-next 2/3] bpf: Overwrite the element in hash
 map atomically
To: Hou Tao <houtao@huaweicloud.com>
Cc: Zvi Effron <zeffron@riotgames.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>, 
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

On Wed, Feb 26, 2025 at 5:48=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi,
>
> On 2/27/2025 7:17 AM, Zvi Effron wrote:
> > On Tue, Feb 25, 2025 at 9:42=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >> On Tue, Feb 25, 2025 at 8:05=E2=80=AFPM Hou Tao <houtao@huaweicloud.co=
m> wrote:
> >>> Hi,
> >>>
> >>> On 2/26/2025 11:24 AM, Alexei Starovoitov wrote:
> >>>> On Sat, Feb 8, 2025 at 2:17=E2=80=AFAM Hou Tao <houtao@huaweicloud.c=
om> wrote:
> >>>>> Hi Toke,
> >>>>>
> >>>>> On 2/6/2025 11:05 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >>>>>> Hou Tao <houtao@huaweicloud.com> writes:
> >>>>>>
> >>>>>>> +cc Cody Haas
> >>>>>>>
> >>>>>>> Sorry for the resend. I sent the reply in the HTML format.
> >>>>>>>
> >>>>>>> On 2/4/2025 4:28 PM, Hou Tao wrote:
> >>>>>>>> Currently, the update of existing element in hash map involves t=
wo
> >>>>>>>> steps:
> >>>>>>>> 1) insert the new element at the head of the hash list
> >>>>>>>> 2) remove the old element
> >>>>>>>>
> >>>>>>>> It is possible that the concurrent lookup operation may fail to =
find
> >>>>>>>> either the old element or the new element if the lookup operatio=
n starts
> >>>>>>>> before the addition and continues after the removal.
> >>>>>>>>
> >>>>>>>> Therefore, replacing the two-step update with an atomic update. =
After
> >>>>>>>> the change, the update will be atomic in the perspective of the =
lookup
> >>>>>>>> operation: it will either find the old element or the new elemen=
t.
> >>>> I'm missing the point.
> >>>> This "atomic" replacement doesn't really solve anything.
> >>>> lookup will see one element.
> >>>> That element could be deleted by another thread.
> >>>> bucket lock and either two step update or single step
> >>>> don't change anything from the pov of bpf prog doing lookup.
> >>> The point is that overwriting an existed element may lead to concurre=
nt
> >>> lookups return ENOENT as demonstrated by the added selftest and the
> >>> patch tried to "fix" that. However, it seems using
> >>> hlist_nulls_replace_rcu() for the overwriting update is still not
> >>> enough. Because when the lookup procedure found the old element, the =
old
> >>> element may be reusing, the comparison of the map key may fail, and t=
he
> >>> lookup procedure may still return ENOENT.
> >> you mean l_old =3D=3D l_new ? I don't think it's possible
> >> within htab_map_update_elem(),
> >> but htab_map_delete_elem() doing hlist_nulls_del_rcu()
> >> then free_htab_elem, htab_map_update_elem, alloc, hlist_nulls_add_head=
_rcu
> >> and just deleted elem is reused to be inserted
> >> into another bucket.
>
> No. I mean the following procedure in which the lookup procedure finds
> the old element and tries to match its key, one update procedure has
> already deleted the old element, and another update procedure is reusing
> the old element:
>
> lookup procedure A
> A: find the old element (instead of the new old)
>
>               update procedure B
>               B: delete the old element
>               update procedure C on the same CPU:
>               C: reuse the old element (overwrite its key and insert in
> the same bucket)
>
> A: the key is mismatched and return -ENOENT.

This is fine. It's just normal reuse.
Orthogonal to 'update as insert+delete' issue.

> It can be reproduced by increasing ctx.loop in the selftest.
> >>
> >> I'm not sure whether this new hlist_nulls_replace_rcu()
> >> primitive works with nulls logic.
> >>
> >> So back to the problem statement..
> >> Are you saying that adding new to a head while lookup is in the middle
> >> is causing it to miss an element that
> >> is supposed to be updated assuming atomicity of the update?
> >> While now update_elem() is more like a sequence of delete + insert?
> >>
> >> Hmm.
> > Yes, exactly that. Because update_elem is actually a delete + insert (a=
ctually
> > an insert + delete, I think?), it is possible for a concurrent lookup t=
o see no
> > element instead of either the old or new value.
>
> Yep.
> >
> >>> I see. In v2 I will fallback to the original idea: adding a standalon=
e
> >>> update procedure for htab of maps in which it will atomically overwri=
te
> >>> the map_ptr just like array of maps does.
> >> hold on. is this only for hash-of-maps ?
> > I believe this was also replicated for hash as well as hash-of-maps. Co=
dy can
> > confirm, or use the reproducer he has to test that case.
>
> The fix for hash-of-maps will be much simpler and the returned map
> pointer will be correct. For other types of hash map, beside switching
> to hlist_nulls_replace_rcu(),

It's been a long time since I looked into rcu_nulls details.
Pls help me understand that this new replace_rcu_nulls()
is correct from nulls pov,
If it is then this patch set may be the right answer to non-atomic update.

And for the future, please please focus on "why" part in
the cover letter and commit logs instead of "what".

Since the only thing I got from the log was:
"Currently, the update is not atomic
because the overwrite of existing element happens in a two-steps way,
but the support of atomic update is feasible".

"is feasible" doesn't explain "why".

Link to xdp-newbie question is nice for additional context,
but reviewers should not need to go and read some thread somewhere
to understand "why" part.
All of it should be in the commit log.

> map may still be incorrect (as shown long time ago [1]), so I think
> maybe for other types of map, the atomic update doesn't matter too much.
>
> [1]:
> https://lore.kernel.org/bpf/20221230041151.1231169-1-houtao@huaweicloud.c=
om/

A thread from 3 years ago ?! Sorry, it's not helpful to ask
people to page-in such an old context with lots of follow ups
that may or may not be relevant today.

