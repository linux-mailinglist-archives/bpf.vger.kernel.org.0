Return-Path: <bpf+bounces-39184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A4696FE8E
	for <lists+bpf@lfdr.de>; Sat,  7 Sep 2024 01:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89B581F22CAF
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 23:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E7815B546;
	Fri,  6 Sep 2024 23:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dATY4C/u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C057615697A
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 23:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725666277; cv=none; b=bNp9fgCYMX6WjS2dhc75KdPy8/DbOCmF51o9IuoXYdk/KZrqNthLtjUZ8+kIUCAJHyjd/oOCadPL5G/mGfsNiaE+HK57ZoUhyCfYN1u8WtTH86x088ICpvgYXhmP45Nvu7UWstm8hevqBmZSrMLcOP+64scEurNw4/IQIOa0wiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725666277; c=relaxed/simple;
	bh=BOv+4W2senQqkvNx2/6Tk18zqQpUpI10akXY4qr8hO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pAphTBPgCfRSPGAj0qp4aIo9Z/qtS2lM7qGrvYVr8mdg5CROh6z8C5KGHZ4E8JJPAItxjQ+5YwXM9Q9G2s3tBTs/GCbWnWH6Qff6TqZEDeSW76njwrhBDkm2LpzWJKU80A0UNNxvDCeLvh1mR+6VMdlSiBJyoVToGFh/fL4zOSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dATY4C/u; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-374cacf18b1so1699303f8f.2
        for <bpf@vger.kernel.org>; Fri, 06 Sep 2024 16:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725666274; x=1726271074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y01pZ4xvz66B8X54xHNrPK7EonzIgm65LzyWpwJb+yU=;
        b=dATY4C/uFRgy03kkCbYoOZbW8i8rxTqaS9nD5tHDwWgzBAIyBe2LBOiYDRHy7/efZ+
         AlNnXoj9BFcItQq28a+SqymB4T7pV78/0hvGjodgzhjZVKDWp5SXtofmvKdbUTYAZM5k
         iZbcRJ6CXj3Am5d/DK3n1bbAmA6HIIAXya/slUhJfQVo3ExghIfU0E3bqozM4jZGITTT
         Gc52B+nRCMyjFBtmc2n8+stylhpVH/9cHZIGDDq5rFCl5YdiuPTMGZ0G8cRjj7EF1zyd
         4Jqrr9I/Rv+BeW/eP6SGL16Nha8o3Zxcij/QgQ6Izth+dXLzpXkkcnriXvJ/c/ZFdTId
         vkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725666274; x=1726271074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y01pZ4xvz66B8X54xHNrPK7EonzIgm65LzyWpwJb+yU=;
        b=kADho5KynWEq6L94AxiJ0SsDeu44WAI5nZ+Q4YHpgQtaQ/g85fjKxzWyJhM/O3vQaA
         H1eAUl2KFqrAq/QW/yGTEZKR2+u6IPqVOwN9aCrimTJkBU+MK6MSdF8WHZE4ZPJnjUYm
         ivBRtxv+bwIp0YOKojd+awdegi2FJmcBA3yHyV3wfUPATmlr5G8LvROSPqjWr9Bc1PnN
         FCW+RLXbys2J3ag4dw2Q9V8ZAn/a5TMfkkvOIxTgmGOPM7is1tfBNyzWz34VUJkNGLbn
         3VzpbadWpPydVvfFIgnyZF4P9nAiwETleq/0Tvz7PoK7/D6pHyJ0lImUbMxNUzqTqvc5
         D3tg==
X-Forwarded-Encrypted: i=1; AJvYcCUeRnSOsFeMFnwzRGr9csDHuX6uatAgYY6v5GYMTKLIQGU7YuIru5VzXfzNcQjv5rAxTqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAx2JwmXuH8g63Q7HzuhygBHfg4sagMF3J0Fx6urZBHTZsOL+K
	H6vSHC+xqEr+0WVbPqRKNUz7bzyAt0s20yfeMoBKyQ4R5vzyFgKbv+r6Oy8rLB1AajyjR3WXake
	IoWUNctb0fsZoLwvks/vdmHiiTls=
X-Google-Smtp-Source: AGHT+IHXV27ow3w/krD2rqORlsNLr2Vh4FMnJY/8mRxBYLlKmk6AebkUdX06hLd0JET17D1iS7eGK1zcBxchDmFHYtU=
X-Received: by 2002:a5d:4991:0:b0:368:5bb4:169b with SMTP id
 ffacd0b85a97d-378926858b2mr407679f8f.4.1725666273800; Fri, 06 Sep 2024
 16:44:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816191213.35573-1-thinker.li@gmail.com> <20240816191213.35573-5-thinker.li@gmail.com>
 <CAADnVQLUN1XLzV0kVbXWm5TaQyH5pN4M3agha-uZoWP3Dkcw8Q@mail.gmail.com>
 <70a1b24f-84cd-464c-8fb6-a2c52fd3d703@linux.dev> <f84e4a86-976a-4fd2-94e7-8026dc3ae56e@linux.dev>
In-Reply-To: <f84e4a86-976a-4fd2-94e7-8026dc3ae56e@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 6 Sep 2024 16:44:22 -0700
Message-ID: <CAADnVQLzFDb8Hi9jnW46f2UFYZUre6UpLg-3g=xcEvfv=wkFxA@mail.gmail.com>
Subject: Re: [RFC bpf-next v4 4/6] bpf: pin, translate, and unpin __uptr from syscalls.
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Kui-Feng Lee <sinquersw@gmail.com>, 
	linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 1:11=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 9/4/24 3:21 PM, Martin KaFai Lau wrote:
> > On 8/28/24 4:24 PM, Alexei Starovoitov wrote:
> >>> @@ -714,6 +869,11 @@ void bpf_obj_free_fields(const struct btf_record=
 *rec,
> >>> void *obj)
> >>>                                  field->kptr.dtor(xchgd_field);
> >>>                          }
> >>>                          break;
> >>> +               case BPF_UPTR:
> >>> +                       if (*(void **)field_ptr)
> >>> +                               bpf_obj_unpin_uptr(field, *(void **)f=
ield_ptr);
> >>> +                       *(void **)field_ptr =3D NULL;
> >> This one will be called from
> >>   task_storage_delete->bpf_selem_free->bpf_obj_free_fields
> >>
> >> and even if upin was safe to do from that context
> >> we cannot just do:
> >> *(void **)field_ptr =3D NULL;
> >>
> >> since bpf prog might be running in parallel,
> >> it could have just read that addr and now is using it.
> >>
> >> The first thought of a way to fix this was to split
> >> bpf_obj_free_fields() into the current one plus
> >> bpf_obj_free_fields_after_gp()
> >> that will do the above unpin bit.
> >> and call the later one from bpf_selem_free_rcu()
> >> while bpf_obj_free_fields() from bpf_selem_free()
> >> will not touch uptr.
> >>
> >> But after digging further I realized that task_storage
> >> already switched to use bpf_ma, so the above won't work.
> >>
> >> So we need something similar to BPF_KPTR_REF logic:
> >> xchgd_field =3D (void *)xchg((unsigned long *)field_ptr, 0);
> >> and then delay of uptr unpin for that address into call_rcu.
> >>
> >> Any better ideas?
> >
>
> I think the existing reuse_now arg in the bpf_selem_free can be used. reu=
se_now
> (renamed from the earlier use_trace_rcu) was added to avoid call_rcu_task=
s_trace
> for the common case.
>
> selem (in type "struct bpf_local_storage_elem") is the one exposed to the=
 bpf prog.
>
> bpf_selem_free knows whether a selem can be reused immediately based on t=
he
> caller. It is currently flagged in the reuse_now arg: "bpf_selem_free(...=
., bool
> reuse_now)".
>
> If a selem cannot be reuse_now (i.e. =3D=3D false), it is currently going=
 through
> "call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_trace_rcu)". We can do
> unpin_user_page() in the rcu callback.
>
> A selem can be reuse_now (i.e. =3D=3D true) if the selem is no longer nee=
ded because
> either its owner (i.e. the task_struct here) is going away in free_task()=
 or the
> bpf map is being destructed in bpf_local_storage_map_free(). No bpf prog =
should
> have a hold on the selem at this point. I think for these two cases, the
> unpin_user_page() can be directly called in bpf_selem_free().

but there is also this path:
bpf_task_storage_delete -> task_storage_delete -> bpf_selem_free
 -> bpf_obj_free_fields

In this case bpf prog may still be looking at uptr address
and we cannot do unpin right away in bpf_obj_free_fields.
All other special fields in map value are ok,
since they are either relying on bpf_mem_alloc and
have rcu/rcu_tasks_trace gp
or extra indirection like timer/wq.

> One existing bug is, from looking at patch 6, I don't think the free_task=
() case
> can be "reuse_now =3D=3D true" anymore because of the bpf_task_release kf=
unc did not
> mark the previously obtained task_storage to be invalid:
>
> data_task =3D bpf_task_from_pid(parent_pid);
> ptr =3D bpf_task_storage_get(&datamap, data_task, 0, ...);
> bpf_task_release(data_task);
> if (!ptr)
>         return 0;
> /* The prog still holds a valid task storage ptr. */
> udata =3D ptr->udata;
>
> It can be fixed by marking the ref_obj_id of the "ptr". Although it is mo=
re
> correct to make the task storage "ptr" invalid after task_release, it may=
 break
> the existing progs.

Are you suggesting that bpf_task_release should invalidate all pointers
fetched from map value?
That will work, but it's not an issue for other special fields in there
like kptr.
So this invalidation would be need only for uptr which feels
weird to special case it and probably will be confusing to users writing
such programs.
Above bpf prog example should be ok to use.
We only need to delay unpin after rcu/rcu_task_trace gp.
Hence my proposal in bpf_obj_free_fields() do:
 case UPTR:
   xchgd_field =3D (void *)xchg((unsigned long *)field_ptr, 0);
   call_rcu(...) to unpin.

