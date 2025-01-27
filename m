Return-Path: <bpf+bounces-49900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25926A2017B
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 00:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A9BF1881847
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 23:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071991DD88D;
	Mon, 27 Jan 2025 23:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwfA5nxG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ED018D626
	for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 23:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738019929; cv=none; b=spfUIy1j/qFRBaDamivwvMhHU4cd4QsuutDnzM3dDPjxBDzh5NDFWMWyG3yxDQOVp7gQX0Y/MX/Poiw+vY98cx3ihcYEXg1WRldD42I2bzTv3EyJRbYsBcN0ROhkg3TaVHd0KhBjrCuHjg5jz9MgwZTbxJ2cJTvx05PMyX3+B5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738019929; c=relaxed/simple;
	bh=vt5UotNTMGTX00QYci2EOXlX6SHDQ3OJNgnORgrnN/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MsWXQebCPEQIwmB/k3ANuYeHj5VMtaSMrrBP5QuqQFXZ5AluNoLvgCrPUpjTuPuSmVMKPWstMTaAWLFPpXI8YCsfZmVPAp8w42tLWhdSmMHBrV4Eq6AAD1mE1lUSHLrjOZmAe6WE0ICGKFoDRhGMdG4ShloAK5HZyT2n59ae5d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwfA5nxG; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ee709715d9so6942810a91.3
        for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 15:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738019927; x=1738624727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bl3ilLQHXIEfUM7DHoWBXsuLijvMCVSP7avI0r22GM=;
        b=jwfA5nxGkVEFIEEfcUdKMM9n8Flp28HNe+MPaVyiF7ajwe/o/d1vPILa1fh4mXpQsw
         jrZvqTDZHrtjKb9TcDN2wra3JuAxZgP9+AxMg+JmNQBGcBZBlwNhYOUJSWGOSQzZ0r0I
         u5ChH9I1u3aVX0VcGyGgesY4/HSmM0lSTYRefC3UrBWnIF8bAMsEhgs2VQOS8gAUmQHg
         UViDyt7Tp37w475O7U96aAlze2H9CU7tzeC/ESn86gIp8v8lxQHc8wboigBWFOvDRZq4
         M0vaUca4406A1I+EExz/jXspuX0bdDkVEZvHjUhUqQY967dPjWQO5WKYzk2Nitp4UgHe
         D2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738019927; x=1738624727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9bl3ilLQHXIEfUM7DHoWBXsuLijvMCVSP7avI0r22GM=;
        b=dwWJiabOblXA8+lb66qlXtMlLOgc96pDOwOF8yCjYHCUCd7T+LwVkMQBsLwfYjNsSd
         h7hqyblQb7XUWtl8lDvpMXKCGoNjxtEK5W1UbxWpJmA7W4rh7VeEU3L/mH9+w+WFwHHY
         tAT3YAUuLmLWG6k6R0nsJBnWyzFi8e1J8mTdZf1HWxf9lp6vP28nBhbZWJyKWHCDpWM6
         uaoYfKksZb6J2dxfaVUMeiOxnB4jvdJ0e9TWRZwSLR9qJgiRpLnK4pw62ORItGMYPQQA
         yUb//r0gWKLltej3YBRajERh/vILP8AmOCUr0SXpGKD4QJoDDympSwnRl/yYnbWl6RGs
         DJ7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWnm9SsSF1xeNUnLPx1zHIgNEPoxE8yyX23SWXNpqnlIHmDA6vOdMiVXqi6xtutBZBmXmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhZskvH/018EvDMAOqbmwDmhQWhP5xsE/BtjnYlM4VALhHw8De
	pbMteg2Oe7hUqFYpnUL9Md8LjrplZXV0XMEp71n+Nz6UgnP2R1StHIdqdA+BUwKsa13QZo1w1vQ
	RpFvoDE3JsxgRexFKUwEiFrCy+U0=
X-Gm-Gg: ASbGncu0B30ikUiOrPqJ89QelNC8cs2JaNCdPl83CTDRyuCSij6KK4YUlGm5uvyLHyl
	Qrwf/ndKHRr6BIk6nFIyRMiogcN1xZkV7/OOrByRCgNMw4uOVPFpBhZUbhtfK5MiZS1Ke2GOwqk
	qx4A==
X-Google-Smtp-Source: AGHT+IEMEqiNpBQ5i/5ByCaV7fkLnua9LU4H558xw8WcBZlwQ50gWBTusxk95a5Zx4236X6RLIJ53RBMaFIdxTOEFuw=
X-Received: by 2002:a05:6a00:418d:b0:71e:21:d2d8 with SMTP id
 d2e1a72fcca58-72daf946789mr62135455b3a.7.1738019927175; Mon, 27 Jan 2025
 15:18:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250124195600.3220170-1-andrii@kernel.org> <CAADnVQJ-QiXv6FA0n6N9+2z4sxksg2HSdzyS2z00CCqP3CbfGQ@mail.gmail.com>
In-Reply-To: <CAADnVQJ-QiXv6FA0n6N9+2z4sxksg2HSdzyS2z00CCqP3CbfGQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 27 Jan 2025 15:18:35 -0800
X-Gm-Features: AWEUYZlIZ_9VWMtlpgaq2j4YpY9JU3F21OnY3u7XzrtgpWaLV4aPorCVDHtrAeE
Message-ID: <CAEf4BzY5aMHSu4JvtHrb8S5Ln5F9wf7qFE72gpX1Zzth3g8kyQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: avoid holding freeze_mutex during mmap operation
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	syzbot+4dc041c686b7c816a71e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 2:27=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jan 24, 2025 at 11:56=E2=80=AFAM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> >
> > We use map->freeze_mutex to prevent races between map_freeze() and
> > memory mapping BPF map contents with writable permissions. The way we
> > naively do this means we'll hold freeze_mutex for entire duration of al=
l
> > the mm and VMA manipulations, which is completely unnecessary. This can
> > potentially also lead to deadlocks, as reported by syzbot in [0].
> >
> > So, instead, hold freeze_mutex only during writeability checks, bump
> > (proactively) "write active" count for the map, unlock the mutex and
> > proceed with mmap logic. And only if something went wrong during mmap
> > logic, then undo that "write active" counter increment.
> >
> > Note, instead of checking VM_MAYWRITE we check VM_WRITE before and afte=
r
> > mmaping, because we also have a logic that unsets VM_MAYWRITE
> > forcefully, if VM_WRITE is not set. So VM_MAYWRITE could be set early o=
n
> > for read-only mmaping, but it won't be afterwards. VM_WRITE is
> > a consistent way to detect writable mmaping in our implementation.
>
> bpf_map_mmap_open/bpf_map_mmap_open use VM_MAYWRITE,
>
> Do they need to change as well?

So I didn't want to elaborate too much on this (because of
verboseness), but it is indeed non-obvious (I was confused by this for
a bit while working on the patch).

We have this piece of logic in the middle of bpf_map_mmap():

if (!(vma->vm_flags & VM_WRITE))
    vm_flags_clear(vma, VM_MAYWRITE);

After this point, VM_WRITE and VM_MAYWRITE are equivalent (when it
comes to BPF maps mmap-ing). I.e., if we have writable mapping, we'll
have both VM_WRITE and VM_MAYWRITE; if we have read-only mapping, we
won't have either. We can't have any other mix of those two.

bpf_map_write_active_inc() used to happen after this point, and so we
were checking VM_MAYWRITE, but I had to move
bpf_map_write_active_inc() before that point, so I switched to
VM_WRITE check.

bpf_map_mmap_open/bpf_map_mmap_close happen after this
vm_flags_clear(vma, VM_MAYWRITE), so whether they use VM_MAYWRITE or
VM_WRITE doesn't matter. So they should be fine as is.

It is confusing, though, I agree. So maybe we should just normalize
all the checks to VM_WRITE and leave a comment that MAYWRITE and WRITE
are coupled with our custom mmaping logic?

>
> >   [0] https://lore.kernel.org/bpf/678dcbc9.050a0220.303755.0066.GAE@goo=
gle.com/
> >
> > Fixes: fc9702273e2e ("bpf: Add mmap() support for BPF_MAP_TYPE_ARRAY")
> > Reported-by: syzbot+4dc041c686b7c816a71e@syzkaller.appspotmail.com
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  kernel/bpf/syscall.c | 20 +++++++++++++-------
> >  1 file changed, 13 insertions(+), 7 deletions(-)
> >
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 0daf098e3207..0d5b39e99770 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -1035,7 +1035,7 @@ static const struct vm_operations_struct bpf_map_=
default_vmops =3D {
> >  static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
> >  {
> >         struct bpf_map *map =3D filp->private_data;
> > -       int err;
> > +       int err =3D 0;
> >
> >         if (!map->ops->map_mmap || !IS_ERR_OR_NULL(map->record))
> >                 return -ENOTSUPP;
> > @@ -1059,7 +1059,12 @@ static int bpf_map_mmap(struct file *filp, struc=
t vm_area_struct *vma)
> >                         err =3D -EACCES;
> >                         goto out;
> >                 }
> > +               bpf_map_write_active_inc(map);
> >         }
> > +out:
> > +       mutex_unlock(&map->freeze_mutex);
> > +       if (err)
> > +               return err;
> >
> >         /* set default open/close callbacks */
> >         vma->vm_ops =3D &bpf_map_default_vmops;
> > @@ -1070,13 +1075,14 @@ static int bpf_map_mmap(struct file *filp, stru=
ct vm_area_struct *vma)
> >                 vm_flags_clear(vma, VM_MAYWRITE);
> >
> >         err =3D map->ops->map_mmap(map, vma);
> > -       if (err)
> > -               goto out;
> > +       if (err) {
> > +               if (vma->vm_flags & VM_WRITE) {
> > +                       mutex_lock(&map->freeze_mutex);
> > +                       bpf_map_write_active_dec(map);
> > +                       mutex_unlock(&map->freeze_mutex);
>
> Extra lock/unlock looks unnecessary.
>
> This functiona and map_freeze() need to see frozen and write_active coher=
ent,
> but write_active_dec looks like without mutex.
> It's atomic64_dec.

Yep, I think you are right. I wanted a no-brainer change and not
having to think about any memory ordering effects or anything like
that. But seeing bpf_map_is_rdonly() checks this without any lock
anyways, I think we should be fine. I can drop this lock/unlock for
v2.

