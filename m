Return-Path: <bpf+bounces-52716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 113C1A47384
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 04:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76E7C1896753
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 03:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26546189F36;
	Thu, 27 Feb 2025 03:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpIa8aii"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEC0270039;
	Thu, 27 Feb 2025 03:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740626242; cv=none; b=C/tKl99F9rXZ37dBsrkQVaN+muEn7OLPu1sjo5n5Nat3wLA2eyVlVOEDxxyss3K0XCW6yxd/GLV+BcnedA+1RUlcHpWRZY1jQveRwTB1p79Bu3xQ5cMKEGrYkZmaTV4JFkS9mBmr0tCosQijSMJpP7YzB1lJ1GyTRkXwX7xaCd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740626242; c=relaxed/simple;
	bh=9AS3Hc9v2DOGdZTMZqp5nK9ONH+qjbjZwNPhNyqpfS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cZLEhYbn+fs3RLv20C6ymEGBwRh82sTyJ8E13k8ktkbiNB4+XdpANo9i3DNtVtGWZqmBz7AOCv7QWK/o892h0E59vNZK4PJEoeiE+kOi8YmK1PsmDwQlSmnTwiS1TUVlP6LxxSQAPf+DCFCcgWl7vLpLfzsyH4Y+sYSFkGnnX3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpIa8aii; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38f378498c9so412460f8f.1;
        Wed, 26 Feb 2025 19:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740626239; x=1741231039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=186RQJEPxOQii793CYJkBqMJYUwTqOLmAOv049AKC2A=;
        b=bpIa8aiiLXUn9ySxpKSWk0XC/MHapqfscsCyTWdBCG7VcyKUv+vn62+BBw+2cTX/E/
         0sAkya3DN/VP7NrOqUDc87jQUlV3BWqaACLyJKmAuxGBIlkLZHaQXq8T8WpTzF6p6gAw
         9kCl1vujes0APdHHJmapnIgy0wyRJYWq4W6KyaKFtetcVzeoLSAso1gq8yuASYASMtop
         uBGN1fVbQihsKEXvRAtQ4csAMmJ0msgSjxXiUfakX9UX8+S/iFIEkeGC+/34eueIU1eC
         nOw/Y1+OLDajfih+PdoSPfwMrNa/Lu7hoRqltpZ6IhxMlhBV0W5jL9niEvtR51RZJU0S
         tXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740626239; x=1741231039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=186RQJEPxOQii793CYJkBqMJYUwTqOLmAOv049AKC2A=;
        b=p2XHd8Qp3fPUW9dLv/rcuApSEwJuHLV+NdyO3sJsf8ACoPqQYM28OJ18oXiFkFhX1M
         JI1ASx943C/99RtTNGxvUs/+cWWJEIZXPn8mrZ6avEw/B/cqL9zUs8+up2H/LXGfiyI7
         PsTtFBf8b9sAas6JEjm3cnvX/oSSPDxaC4r3ZxU7k6zgyQwTTtkLhgVWxjcvxxB5ZLi4
         cY8O0wOgJGQfuRXG04nARgOzZsBfnsoGO8aM8HWQ3USyE3IAMa925f646S90qQHTXmbj
         mLW/QhE0eRJT7OaDA9OPQWuH+R2sBxcBh24AWo4dqohGncVvyhsRa8hfHWy9xeH9d4Wk
         bpbg==
X-Forwarded-Encrypted: i=1; AJvYcCW2vJ6HFyiuPTqBlO1VpNv9JyRWIsSI2T290ZgAlnQrwzBv0I585aF8lAbARJ/Hng8u4Hs=@vger.kernel.org, AJvYcCWkXKtlCQcJQZ+g6TX0eSZUaHFsJ3PcEHoKs1XZvw2Pw1T5OxbvGdN3fPn1HY8uQvbY4fBsU2LBCpH6Y+mc@vger.kernel.org, AJvYcCX3llmC1axla/kZ+c9GGU6/gMdNMkXjUwwFGLLy9y+fd4tztKcF5XkjiXKj+OR3fXSGWAOM@vger.kernel.org
X-Gm-Message-State: AOJu0YzrJO41106RYLNZ4zROhoAIYkTmEmoRuJ4+/6z04WjtU8aHXgeh
	3k8Uqe2f4JtITMKdXPcSoJchs8CyFeF8nqWWSUIP7XARhCJRISQs9lhfuz9QD9u5/uI4DyihMi2
	TLSa9pH0mNrx36PiRXrOL0nUYb+s=
X-Gm-Gg: ASbGncv919uGpsAKkf7fV/TGZE4WQnozDwbbOuOmRaQNGw7O3W8xNDni9f3mRfpZfuB
	6iISCHpAcXz4xNOnc2+dZtB+W5Y3buddnKUjSznTvNYaFrgPknNQ4D5j7/kzOtx+YU8hXNjgw+N
	7GaIsxjn+DSEGsUKP+iaEwZlg=
X-Google-Smtp-Source: AGHT+IF1DGhFf9YwvPe6WrEE56EGDwZi4/BZ2x4+eFfkz5avtcJPkCN3jzsZ2Bh5Ry6Iyq4lQWFdUc5ZRSQ2wOdXM0Y=
X-Received: by 2002:a05:6000:4027:b0:38f:4e30:6bbb with SMTP id
 ffacd0b85a97d-390cc60a437mr11956487f8f.25.1740626239009; Wed, 26 Feb 2025
 19:17:19 -0800 (PST)
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
 <CAC1LvL0ntdrWh_1y0EcVR6C1_WyqOQ15EhihfQRs=ai7pcE-Sw@mail.gmail.com>
 <7e614d80-b45b-e2f9-5a39-39086c2392dc@huaweicloud.com> <CAADnVQJU9OWAWFk89P6i1RK6vXkuee5s76suHjF+uP+V4iepqQ@mail.gmail.com>
 <e1b65f13-a426-d707-0319-f57e8b15575a@huaweicloud.com>
In-Reply-To: <e1b65f13-a426-d707-0319-f57e8b15575a@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 26 Feb 2025 19:17:07 -0800
X-Gm-Features: AQ5f1Jq1fcbJkFAdT5yUh773lJn5P-P9VjdWujeJsDT-CJu9e1AyvAlVcd4f_AU
Message-ID: <CAADnVQLev2V-ARjPc9EPYaSssCev_87Lc0NWkLvL-5tuy=3Veg@mail.gmail.com>
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

On Wed, Feb 26, 2025 at 6:43=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> >>
> >> lookup procedure A
> >> A: find the old element (instead of the new old)
> >>
> >>               update procedure B
> >>               B: delete the old element
> >>               update procedure C on the same CPU:
> >>               C: reuse the old element (overwrite its key and insert i=
n
> >> the same bucket)
> >>
> >> A: the key is mismatched and return -ENOENT.
> > This is fine. It's just normal reuse.
> > Orthogonal to 'update as insert+delete' issue.
>
> OK. However, it will break the lookup procedure because it expects it
> will return an valid result instead of -ENOENT.

What do you mean 'breaks the lookup' ?
lookup_elem_raw() matches hash, and then it memcmp(key),
if the element is reused anything can happen.
Either it succeeds in memcmp() and returns an elem,
or miscompares in memcmp().
Both are expected, because elems are reused in place.

And this behavior is expected and not-broken,
because bpf prog that does lookup on one cpu and deletes
the same element on the other cpu is asking for trouble.
bpf infra guarantees the safety of the kernel.
It doesn't guarantee that bpf progs are sane.

> > It's been a long time since I looked into rcu_nulls details.
> > Pls help me understand that this new replace_rcu_nulls()
> > is correct from nulls pov,
> > If it is then this patch set may be the right answer to non-atomic upda=
te.
>
> If I understand correctly, only the manipulations of ->first pointer and
> ->next pointer need to take care of nulls pointer.

hmm. I feel we're still talking past each other.
See if (get_nulls_value() =3D=3D ...) in lookup_nulls_elem_raw().
It's there because of reuse. The lookup can start in one bucket
and finish in another.

> >
> > And for the future, please please focus on "why" part in
> > the cover letter and commit logs instead of "what".
> >
> > Since the only thing I got from the log was:
> > "Currently, the update is not atomic
> > because the overwrite of existing element happens in a two-steps way,
> > but the support of atomic update is feasible".
> >
> > "is feasible" doesn't explain "why".
> >
> > Link to xdp-newbie question is nice for additional context,
> > but reviewers should not need to go and read some thread somewhere
> > to understand "why" part.
> > All of it should be in the commit log.
>
> OK. My original thought is that is a reported problem, so an extra link
> will be enough. Will try to add more context next time.
> >
> >> map may still be incorrect (as shown long time ago [1]), so I think
> >> maybe for other types of map, the atomic update doesn't matter too muc=
h.
> >>
> >> [1]:
> >> https://lore.kernel.org/bpf/20221230041151.1231169-1-houtao@huaweiclou=
d.com/
> > A thread from 3 years ago ?! Sorry, it's not helpful to ask
> > people to page-in such an old context with lots of follow ups
> > that may or may not be relevant today.
> Let me reuse part of the diagram above to explain how does the lookup
> procedure may return a incorrect value:
>
> lookup procedure A
> A: find the old element (instead of the new element)
>
>
>               update procedure B
>               B: delete the old element
>               update procedure C on the same CPU:
>
>
> A: the key is matched and return the value in the element
>
>               C: reuse the old element (overwrite its key and value)
>
> A: read the value (it is incorrect, because it has been reused and
> overwritten)

... and it's fine. It's by design. It's an element reuse behavior.

Long ago hashmap had two modes: prealloc (default) and
NO_PREALLOC (call_rcu + kfree)

The call_rcu part was there to make things safe.
The memory cannot be kfree-ed to the kernel until RCU GP.
With bpf_mem_alloc hashmap elements are freed back to bpf_ma
right away. Hashmap is doing bpf_mem_cache_free()
(instead of bpf_mem_cache_free_rcu()) because users need speed.
So since 2022 both prealloc and no_prealloc reuse elements.
We can consider a new flag for the hash map like F_REUSE_AFTER_RCU_GP
that will use _rcu() flavor of freeing into bpf_ma,
but it has to have a strong reason.
And soon as we add it the default with prealloc would need
to use call_rcu() too, right?
and that becomes nightmare, since bpf prog can easily DoS the system.
Even if we use bpf_mem_cache_free_rcu() only, the DoS is a concern.
Unlike new things like bpf_obj_new/obj_drop the hashmap
is unpriv, so concerns are drastically different.

