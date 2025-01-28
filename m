Return-Path: <bpf+bounces-49925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6486DA202B7
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 01:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99ADF3A73EC
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 00:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC22F9F8;
	Tue, 28 Jan 2025 00:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M57yx/2E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B41C4400
	for <bpf@vger.kernel.org>; Tue, 28 Jan 2025 00:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738025258; cv=none; b=U2CBrcNFh6DsnQj72lLk58ZW0vHszpR/tOdTu1qzvCeDVkwlYQ3s0BtkUgJbHwvcMbWV5gyFmN0DBIZAqWwb9V27+lxJPptA/FZhW3XWZyL90WOCERFY/lIRRauSnT6cFaNviys/hz7CfelIeTshbp5kfQfkvQ/o3DcmyfdjQws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738025258; c=relaxed/simple;
	bh=98Qy5qOqjstL45H53uwSdfSx5FdcY229M7oQ/f6jlcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FbOJslmVwWEfouv4Dp5jVh1okV0UKtoraS9w9Qk03NUDWit/ZcYKt3a60n+wuY4TZsxA5xqZC7t9xk9rKnoY4klW8ofL/1TwGUgWEtBgrN+K3CPGN+F8PpmVKqUgxNqZqnxjtW1vZpsHm1nLeVxw8MC/Wu4uFyV5hYMTSvRRmAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M57yx/2E; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so3081696f8f.0
        for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 16:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738025255; x=1738630055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pURgQetqYAK34V440rsNKOsqPCXR0IzIz1Eqhgmc5XA=;
        b=M57yx/2E+iq2K5HscEKxHmCQ7G63wkj46K4/rzMPR4bg07ljakLhr2agoqOKUqhkrn
         bVl5k6i4GI7hNXgDnKBF639qoXteNAKB+PPKwRvG2z1Sn+u50+ONSyvv/bls31NezXF9
         AwQ9lKkWF+IckLvwsJYN/mJWDXMlHTf5eCMWwsuy2/wsAJkIIrKGYrszGmAoCpkZOS2q
         uRLrcLrGBUz8UMlyoUQOnoM4PBJvKeitGKJu3oIdd5gk/n2+L4PthKRZIfYUDSNQGDRf
         JJ9AdzeAQhlP3CI3r91tKbBopVq9So/0s4F047XOLIhqslrFbzBLD36uRH6kYPIAEDNS
         I3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738025255; x=1738630055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pURgQetqYAK34V440rsNKOsqPCXR0IzIz1Eqhgmc5XA=;
        b=kP4aWk+LI8Q2DFC2h6nKB+j04IN4VFSjd+LGHAkFMPUBnV1ziv/V4MuhIUAIhKAedm
         mRkZBuPrIY2vyrOkqeD0sSXQqLBsjKqPh9sEDd5HhjNWBY14VuZtkapliGk8MAzvT1xq
         jd4ie/ePepopugwwqX7Z7K8LdHw4DCb88TYT/SYUxmeKq6ZvZtUyu73ssTKOa9M6BiVB
         vxSqYbVjksiG9Xs18ZsTnu0zKDDVAm3pCfPCPX/lTfutc66eEiAsBka/2jxWwxyc57K3
         1Wj74xPVmSt/mihvStvc/ggblkn3GRWvgd5w74CjRcYac9+dTGanACW2AbbZYwVNH07h
         X6IA==
X-Forwarded-Encrypted: i=1; AJvYcCW7DaMP3Z1S/aLgkNJHGN9XJaryqXRrdw0AJWH9geggE9J4vOAjWvz1fd57sAYFsTXk/Ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ2yCULfAE7yr0PGzKpjKk9dG699Kn0eDGl/BdOsGBxt4MChJJ
	b7vaenK5m2vKgdhySJMsk9DviJ9zGfx5UbJxTbsivAm5xpNtqYbS0MVBWWREyTqGouVMUKrC0m+
	f5Po8AOZs0CaTZs1yIdvHRkm5RdRKWQ==
X-Gm-Gg: ASbGncs8v3rfJztZmtUvp5VVAVPOIz4fYB/p+7qceSRtu0fEnAEfEhNh+PW3aWB69Sw
	BP5YHXEIm04KdkoIiD6BbxAPgk4hNk4T57kJGpSgrmljKveFAsjr6r+WyY/+4TbkARJggArLilp
	XwbdG9Cz0TBhZbCrp+GQ==
X-Google-Smtp-Source: AGHT+IGMdeZBzi1wly5lur1EweOt8UY8Bu6zS330omVc3UPHdOQaark71R8lyWmCoMoXcDLP0SnV4BjX88sLWHsDyU8=
X-Received: by 2002:a05:6000:2c4:b0:386:42b1:d7e4 with SMTP id
 ffacd0b85a97d-38c49a63397mr1281669f8f.19.1738025254515; Mon, 27 Jan 2025
 16:47:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250124195600.3220170-1-andrii@kernel.org> <CAADnVQJ-QiXv6FA0n6N9+2z4sxksg2HSdzyS2z00CCqP3CbfGQ@mail.gmail.com>
 <CAEf4BzY5aMHSu4JvtHrb8S5Ln5F9wf7qFE72gpX1Zzth3g8kyQ@mail.gmail.com>
In-Reply-To: <CAEf4BzY5aMHSu4JvtHrb8S5Ln5F9wf7qFE72gpX1Zzth3g8kyQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 27 Jan 2025 16:47:23 -0800
X-Gm-Features: AWEUYZnIDcD40RMqBWHDXLojaYHmRQqY0cSSAWEZfARs_aSyYAcBiUKmd9MWaX8
Message-ID: <CAADnVQJNhtEAv661xet5AuK=oeXwUQydRa+8kFnqxr8P3BaLPQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: avoid holding freeze_mutex during mmap operation
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	syzbot+4dc041c686b7c816a71e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 3:18=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Jan 27, 2025 at 2:27=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Jan 24, 2025 at 11:56=E2=80=AFAM Andrii Nakryiko <andrii@kernel=
.org> wrote:
> > >
> > > We use map->freeze_mutex to prevent races between map_freeze() and
> > > memory mapping BPF map contents with writable permissions. The way we
> > > naively do this means we'll hold freeze_mutex for entire duration of =
all
> > > the mm and VMA manipulations, which is completely unnecessary. This c=
an
> > > potentially also lead to deadlocks, as reported by syzbot in [0].
> > >
> > > So, instead, hold freeze_mutex only during writeability checks, bump
> > > (proactively) "write active" count for the map, unlock the mutex and
> > > proceed with mmap logic. And only if something went wrong during mmap
> > > logic, then undo that "write active" counter increment.
> > >
> > > Note, instead of checking VM_MAYWRITE we check VM_WRITE before and af=
ter
> > > mmaping, because we also have a logic that unsets VM_MAYWRITE
> > > forcefully, if VM_WRITE is not set. So VM_MAYWRITE could be set early=
 on
> > > for read-only mmaping, but it won't be afterwards. VM_WRITE is
> > > a consistent way to detect writable mmaping in our implementation.
> >
> > bpf_map_mmap_open/bpf_map_mmap_open use VM_MAYWRITE,
> >
> > Do they need to change as well?
>
> So I didn't want to elaborate too much on this (because of
> verboseness), but it is indeed non-obvious (I was confused by this for
> a bit while working on the patch).
>
> We have this piece of logic in the middle of bpf_map_mmap():
>
> if (!(vma->vm_flags & VM_WRITE))
>     vm_flags_clear(vma, VM_MAYWRITE);
>
> After this point, VM_WRITE and VM_MAYWRITE are equivalent (when it
> comes to BPF maps mmap-ing). I.e., if we have writable mapping, we'll
> have both VM_WRITE and VM_MAYWRITE; if we have read-only mapping, we
> won't have either. We can't have any other mix of those two.
>
> bpf_map_write_active_inc() used to happen after this point, and so we
> were checking VM_MAYWRITE, but I had to move
> bpf_map_write_active_inc() before that point, so I switched to
> VM_WRITE check.
>
> bpf_map_mmap_open/bpf_map_mmap_close happen after this
> vm_flags_clear(vma, VM_MAYWRITE), so whether they use VM_MAYWRITE or
> VM_WRITE doesn't matter. So they should be fine as is.

I see. Yeah. I think this analysis is correct.
It seems to be fine as-is.

> It is confusing, though, I agree. So maybe we should just normalize
> all the checks to VM_WRITE and leave a comment that MAYWRITE and WRITE
> are coupled with our custom mmaping logic?

Yeah. That would be nice.

> >
> > >   [0] https://lore.kernel.org/bpf/678dcbc9.050a0220.303755.0066.GAE@g=
oogle.com/
> > >
> > > Fixes: fc9702273e2e ("bpf: Add mmap() support for BPF_MAP_TYPE_ARRAY"=
)
> > > Reported-by: syzbot+4dc041c686b7c816a71e@syzkaller.appspotmail.com
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  kernel/bpf/syscall.c | 20 +++++++++++++-------
> > >  1 file changed, 13 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > > index 0daf098e3207..0d5b39e99770 100644
> > > --- a/kernel/bpf/syscall.c
> > > +++ b/kernel/bpf/syscall.c
> > > @@ -1035,7 +1035,7 @@ static const struct vm_operations_struct bpf_ma=
p_default_vmops =3D {
> > >  static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vm=
a)
> > >  {
> > >         struct bpf_map *map =3D filp->private_data;
> > > -       int err;
> > > +       int err =3D 0;
> > >
> > >         if (!map->ops->map_mmap || !IS_ERR_OR_NULL(map->record))
> > >                 return -ENOTSUPP;
> > > @@ -1059,7 +1059,12 @@ static int bpf_map_mmap(struct file *filp, str=
uct vm_area_struct *vma)
> > >                         err =3D -EACCES;
> > >                         goto out;
> > >                 }
> > > +               bpf_map_write_active_inc(map);
> > >         }
> > > +out:
> > > +       mutex_unlock(&map->freeze_mutex);
> > > +       if (err)
> > > +               return err;
> > >
> > >         /* set default open/close callbacks */
> > >         vma->vm_ops =3D &bpf_map_default_vmops;
> > > @@ -1070,13 +1075,14 @@ static int bpf_map_mmap(struct file *filp, st=
ruct vm_area_struct *vma)
> > >                 vm_flags_clear(vma, VM_MAYWRITE);
> > >
> > >         err =3D map->ops->map_mmap(map, vma);
> > > -       if (err)
> > > -               goto out;
> > > +       if (err) {
> > > +               if (vma->vm_flags & VM_WRITE) {
> > > +                       mutex_lock(&map->freeze_mutex);
> > > +                       bpf_map_write_active_dec(map);
> > > +                       mutex_unlock(&map->freeze_mutex);
> >
> > Extra lock/unlock looks unnecessary.
> >
> > This functiona and map_freeze() need to see frozen and write_active coh=
erent,
> > but write_active_dec looks like without mutex.
> > It's atomic64_dec.
>
> Yep, I think you are right. I wanted a no-brainer change and not
> having to think about any memory ordering effects or anything like
> that. But seeing bpf_map_is_rdonly() checks this without any lock
> anyways, I think we should be fine. I can drop this lock/unlock for
> v2.

Not only that. map_update/delete do it as well.
So extra mutex_lock provokes questions like mine :)
So pls remove.

