Return-Path: <bpf+bounces-72354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9D5C0F884
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 18:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A822402681
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 17:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF10E30C35E;
	Mon, 27 Oct 2025 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2Q3A7MD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9532D23B9
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 17:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761584702; cv=none; b=NgItAUpfoCA65KE5BN3vqFjPiBEwFI4exm7SisPv0oRjgpkMhkcRHJ6Nna8grVnsmfsaqfL3ywoXwxxD3Wd6eR/aSqMnhez3wMWDqQxzNsni1h/mBqmL+Ekt2tJmPWy30F00PlT8zZDbFbvx0Z02OK2JFiqWoC+JAUVrGav+5Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761584702; c=relaxed/simple;
	bh=5GzkYMM+fPyPu2CUWcfzDIO9ZgWS2a7dc1YB56U+LLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A1yFwbzOtuOsGJpZWEzrvY55BV6ImNg3gnvDnb5fDXmrsVs7BUsdlyagTdM+4QIkBxEb9JS/N4B/jfFZjRg4Boa7WxNNk40gWMqvt27OmxnjPE5ZCQKEF+tt5SW4PXfRUfLU8T7Odk6AF5n0SQHV0jM90SwXJNldAH81f//Uq0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2Q3A7MD; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d6014810fso48323327b3.0
        for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 10:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761584700; x=1762189500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/pGzl7BvfQC6Ltlu7o6vv7/TF5tkl6HNvHVP3Xc/d8=;
        b=K2Q3A7MD0Qp73gLYQdapRMUEig66GSo7e84Vxjli8Au3F2WjdjiSNbP0J6AjnfITsE
         TzxDHYG32ORjWzkDqXElsf0VNqq1dgVn8IjB+mv0vNv6jMqcNHdL+aHv2OwhcYIT9lZy
         dlGlDIlTAgqItoHbIsTuhG//6h9ObjGKLJFXJYBi6TQXQPfeWd/Gnw9QyfR2/f8/CtCI
         j64CuJBOQOmxQpeerCtqjfgP5TmG/5kjch8xQpA+qnAMebApTOfmMTtQNDQE6thsMp1Z
         cjvAAB1FvA1KZBrweNBgk6l9iQubMuqB6dkSa9cOf7yshA49BvzwQ3Nz4YShZo4pRQJC
         Qh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761584700; x=1762189500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/pGzl7BvfQC6Ltlu7o6vv7/TF5tkl6HNvHVP3Xc/d8=;
        b=XulEGCJld9bP0Pzcw0n/W9rLnJgRw6ZxRRjiqCdGM8KcuRA6IgDHk4h/viQaarFqfL
         U2LZaA7gVntd+sEisnimwQi6pVBrzULZBWtjq9iRXuo9lGyKER6wRjJ7x/zX47nQ6cQL
         G8RcJQE/T2Ne4fLnAqyB/DB2GQ0KU6CpRTgDyLYNe7jyDz73HayylLH2zCh2VFjyCYTx
         TBLo15P+UV1FnxERXTSNTzB3izz97EMLPtgMRUoQ6DgnNVDxpVImgXFsuW+NFYtrOSO+
         7ZqB0q7yqD2GR5iL3L/Ng+kFS/c/yF3Je4Iq0sg+UqMVuX5ZJ0MLlcF1nEde/frZTh1T
         rgaQ==
X-Gm-Message-State: AOJu0YxMlGAraRBs9iHnoihQWu6J2f3PvOQJcz6itgvmjFiM+9hZPum2
	4IszTindsGsc1TAfDgNFBvs6ErQY3givhTx+VUiG1nCckuU5U6OtiGshb8ZPt/vbsfMrNUZRYG+
	yzjJ6sW1QtEBtUzgB+r3S/Yrtu3o3q0A=
X-Gm-Gg: ASbGnctOvOu/pxj9+/QA6G+jCmpQxR5CIqHCG43ni0760UOGsHsJJZhaYlz1d4v9Sot
	pcG0a4igLkHAQWDWAUYyR5XjWKd43Vincvm7BwvGooAFj0Xr00RFHT2LTlctbdwYiL/N1r3/41z
	eaQaz4uiGFRqPsr8uGZrOrb8uGYrR6cFP6xEqOTjmUwvwuDWpRJWzVpN6dBbciw7R9kSm1iEQMl
	lz3XNQ0G7T+Mf4OFRpatnM2U31vpk7MdRRhdNIfNXNIqwuFKGGrXnPin34M
X-Google-Smtp-Source: AGHT+IH0Ze3xjA1KYpKBfttix5UqLPTPhNBnRN9WL9RcMpkxZK1OKgo3ADN0ICP0fCpuEVChTUDYyOY7hCZkC0iC66g=
X-Received: by 2002:a53:ce92:0:b0:63e:2715:5ace with SMTP id
 956f58d0204a3-63f6ba84d2emr498593d50.42.1761584698262; Mon, 27 Oct 2025
 10:04:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026154000.34151-1-leon.hwang@linux.dev> <20251026154000.34151-4-leon.hwang@linux.dev>
 <CAMB2axPhcYctJYz0bH032-Kc1h2LcJL74O5iS5g=8Qp74GPK_g@mail.gmail.com> <377791b5-2294-4ced-a0d3-918c7e078b2b@linux.dev>
In-Reply-To: <377791b5-2294-4ced-a0d3-918c7e078b2b@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 27 Oct 2025 10:04:47 -0700
X-Gm-Features: AWmQ_blT_P1_WTCjkjfvapLkw00GeA0aYEpC3ig11F-8VU7IenB_yLMtEO-rWLU
Message-ID: <CAMB2axPx2RajLzhoOsnffhrOxkw7Zy=D=vHam_Y_5wKS0cqf0g@mail.gmail.com>
Subject: Re: [PATCH bpf v3 3/4] bpf: Free special fields when update local
 storage maps
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	memxor@gmail.com, linux-kernel@vger.kernel.org, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 9:15=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> Hi Amery,
>
> On 2025/10/27 23:44, Amery Hung wrote:
> > On Sun, Oct 26, 2025 at 8:41=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >> When updating local storage maps with BPF_F_LOCK on the fast path, the
> >> special fields were not freed after being replaced. This could cause
> >> memory referenced by BPF_KPTR_{REF,PERCPU} fields to be held until the
> >> map gets freed.
> >>
> >> Similarly, on the other path, the old sdata's special fields were neve=
r
> >> freed regardless of whether BPF_F_LOCK was used, causing the same issu=
e.
> >>
> >> Fix this by calling 'bpf_obj_free_fields()' after
> >> 'copy_map_value_locked()' to properly release the old fields.
> >>
> >> Fixes: 9db44fdd8105 ("bpf: Support kptrs in local storage maps")
> >> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> >> ---
> >>  kernel/bpf/bpf_local_storage.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_sto=
rage.c
> >> index b931fbceb54da..8e3aea4e07c50 100644
> >> --- a/kernel/bpf/bpf_local_storage.c
> >> +++ b/kernel/bpf/bpf_local_storage.c
> >> @@ -609,6 +609,7 @@ bpf_local_storage_update(void *owner, struct bpf_l=
ocal_storage_map *smap,
> >>                 if (old_sdata && selem_linked_to_storage_lockless(SELE=
M(old_sdata))) {
> >>                         copy_map_value_locked(&smap->map, old_sdata->d=
ata,
> >>                                               value, false);
> >> +                       bpf_obj_free_fields(smap->map.record, old_sdat=
a->data);
> >
> > [ ... ]
> >
> >>                         return old_sdata;
> >>                 }
> >>         }
> >> @@ -641,6 +642,7 @@ bpf_local_storage_update(void *owner, struct bpf_l=
ocal_storage_map *smap,
> >>         if (old_sdata && (map_flags & BPF_F_LOCK)) {
> >>                 copy_map_value_locked(&smap->map, old_sdata->data, val=
ue,
> >>                                       false);
> >> +               bpf_obj_free_fields(smap->map.record, old_sdata->data)=
;
> >
> > The one above and this make sense. Thanks for fixing it.
> >
>
> Thanks for your review.
>
> >>                 selem =3D SELEM(old_sdata);
> >>                 goto unlock;
> >>         }
> >> @@ -654,6 +656,7 @@ bpf_local_storage_update(void *owner, struct bpf_l=
ocal_storage_map *smap,
> >>
> >>         /* Third, remove old selem, SELEM(old_sdata) */
> >>         if (old_sdata) {
> >> +               bpf_obj_free_fields(smap->map.record, old_sdata->data)=
;
> >
> > Is this really needed? bpf_selem_free_list() later should free special
> > fields in this selem.
> >
>
> Yes, it=E2=80=99s needed. The new selftest confirms that the special fiel=
ds are
> not freed when updating a local storage map.
>

Hmmm. I don't think so.

> Also, bpf_selem_unlink_storage_nolock() doesn=E2=80=99t invoke
> bpf_selem_free_list(), unlike bpf_selem_unlink_storage(). So we need to
> call bpf_obj_free_fields() here explicitly to free those fields.
>

bpf_selem_unlink_storage_nolock() unlinks the old selem and adds it to
old_selem_free_list. Later, bpf_selem_free_list() will call
bpf_selem_free() to free selem in bpf_selem_free_list, which should
also free special fields in the selem.

The selftests may have checked the refcount before an task trace RCU
gp and thought it is a leak. I added a 300ms delay before the checking
program runs and the test did not detect any leak even without this
specific bpf_obj_free_fields().

> Thanks,
> Leon
>
> [...]
>
>

