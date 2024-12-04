Return-Path: <bpf+bounces-46099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDAD9E4300
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 19:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04A9D166DC1
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 18:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880E41A8F60;
	Wed,  4 Dec 2024 18:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVamlkm+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB5A2B9B4
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 18:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733335740; cv=none; b=LFapDgpPYiFkvt+ouSQAmfXsa02pArTlBy9OGPoKqxa4Tj66yklNR0lx3KOXWbuW3Zynk4GeDm6MWk7yBFI9UDmlblgvLLBWyzhVPVN4ZMSeg7Wv4/ZxxSwVg2sqGmSkjPxWNNHuvxw2zpNrLnC0QZjLOZYhdtZX6iWMq5Fjg70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733335740; c=relaxed/simple;
	bh=aai92D0q3lxQkpYp6a6L+AjNCmuBnj8LLOwevlp7RZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k8koeMtskdqeSzj3qo7w+gGxdOedjEH4/jWHGn3poaQAIK1SVxyIACWCptKL5kNQLc4zDi+9QEsJ6MZL9bQ1Hxdj92PtsDvRI7HdQmQnUEKVBBjYwpyGSl+fGm0qOMhbguPX0/lmO09q/ShS5Dyd3umc/AmO7SJ/rIuPruiiTgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVamlkm+; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ee50ffcf14so1026855a91.0
        for <bpf@vger.kernel.org>; Wed, 04 Dec 2024 10:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733335737; x=1733940537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1yizenPsgWkfdhte50yxjFcNJ2t9IU4LBGDBeoo6Ts=;
        b=ZVamlkm+lKcfB4RN1qqi6aGSZG9b8803r5PCVl0UqQ23ROfAj63xwigMrZPY4/tibM
         etbk1Ug1LVkrJBmQExWK4pO3oA/4QgOrEGdZ+ehRRyZe3ppnXoTZVn6ymFfm0JpP82NQ
         X/DPNC4Zgz33H3qMjBLoJlDOdsCkhwHMDaa2r85F9WMXlzNpWrp9NGETtfHKKB7pAYRv
         iezX2QBmPmoiute89/rq8UCS4QKRzzNlayTA65PqOQZQsjFTimo6gP0V8ABSP3D0Qu2W
         oOi56ljo4xZZbWfc/ezxjsR70/A+tTdHywGruAr7HpwT6LoF/5Z3HTS40OZPXaNFARHa
         IusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733335737; x=1733940537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1yizenPsgWkfdhte50yxjFcNJ2t9IU4LBGDBeoo6Ts=;
        b=SX5t8XV6/p0OEK+KLvVIquitg8bTsN0zSCb7sp3G8WwpfSh2ojZGCSMFJgkO1R5LYz
         vmM/MK4S6v/MnCEgjJHyMz6fGEsc6eVK1Y0dIB4VlFb37GSCmfE781q8ybTqANbe5hcX
         4nGHKTg6zYagB+pfvuXjfihmDGyRofE9lPnOLtLHmFg3m6SvNW8JplixeitcUTRzt9k2
         Fa2d/VvN+CDWQ7FPlfzIeolPbtbdo16bd0TlXsUf/Rmz+Suit76qQJWg0XqhFEeIoYRZ
         1wJYH60lkpe0bjkFBgMX8wfJbgcWiW/OTC2PKZ+xUjIsp/R70+8vQ5CkHOZL6zECACd4
         9DiQ==
X-Gm-Message-State: AOJu0Yxhl81EkTa940oohdlECUrprlhHnObd739Y1/Z+nGMGLsZCgTp0
	H5JRn1RF4+OkLfPsUq1l4+7IXFQg90aEpf7QP5jQxiNslvhLW6DzT3N0BiP/q7Nv7iQbanb3qRK
	VMfVDmmTmyanhaHC5SRDUv6X8HTPmbOnx
X-Gm-Gg: ASbGncsTrU48eWmTR4oTEzfmTXC4NtBCRh5L+NTq1E+1C8fz0/cJKPI8x4AwdCT31rh
	GEpYQOwSSUYWlj3n0CXcVCoibmrXS/eVQ560sxLTW6xVg/JI=
X-Google-Smtp-Source: AGHT+IH7QU0ZBKq89n06MFB2NlBNK4nzYHB83WKG5EGgRTE69QMTtSLsTBCz1bw3nycGJ34asgqAce9pzZyW1nX+3wI=
X-Received: by 2002:a17:90b:1b10:b0:2ee:ee77:226d with SMTP id
 98e67ed59e1d1-2ef41bd644bmr477555a91.4.1733335737478; Wed, 04 Dec 2024
 10:08:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203135052.3380721-1-aspsk@isovalent.com> <20241203135052.3380721-4-aspsk@isovalent.com>
 <CAEf4BzZiD_iYpBkf5q5U9VoSUAFJN8dxOBWNJdT5y9DxAe=_UQ@mail.gmail.com> <Z1BJc/iK3ecPKTUx@eis>
In-Reply-To: <Z1BJc/iK3ecPKTUx@eis>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 4 Dec 2024 10:08:45 -0800
Message-ID: <CAEf4BzZVkNRV+8ROMMM-oGdHd1HUSx3WVv77TK+H4Fr8PhHHBQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 3/7] bpf: add fd_array_cnt attribute for prog_load
To: Anton Protopopov <aspsk@isovalent.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 4:19=E2=80=AFAM Anton Protopopov <aspsk@isovalent.co=
m> wrote:
>
> On 24/12/03 01:25PM, Andrii Nakryiko wrote:
> > On Tue, Dec 3, 2024 at 5:48=E2=80=AFAM Anton Protopopov <aspsk@isovalen=
t.com> wrote:
> > >
> > > The fd_array attribute of the BPF_PROG_LOAD syscall may contain a set
> > > of file descriptors: maps or btfs. This field was introduced as a
> > > sparse array. Introduce a new attribute, fd_array_cnt, which, if
> > > present, indicates that the fd_array is a continuous array of the
> > > corresponding length.
> > >
> > > If fd_array_cnt is non-zero, then every map in the fd_array will be
> > > bound to the program, as if it was used by the program. This
> > > functionality is similar to the BPF_PROG_BIND_MAP syscall, but such
> > > maps can be used by the verifier during the program load.
> > >
> > > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > > ---
> > >  include/uapi/linux/bpf.h       | 10 ++++
> > >  kernel/bpf/syscall.c           |  2 +-
> > >  kernel/bpf/verifier.c          | 98 ++++++++++++++++++++++++++++----=
--
> > >  tools/include/uapi/linux/bpf.h | 10 ++++
> > >  4 files changed, 104 insertions(+), 16 deletions(-)
> > >
> >
> > [...]
> >
> > > +/*
> > > + * The add_fd_from_fd_array() is executed only if fd_array_cnt is no=
n-zero. In
> > > + * this case expect that every file descriptor in the array is eithe=
r a map or
> > > + * a BTF. Everything else is considered to be trash.
> > > + */
> > > +static int add_fd_from_fd_array(struct bpf_verifier_env *env, int fd=
)
> > > +{
> > > +       struct bpf_map *map;
> > > +       CLASS(fd, f)(fd);
> > > +       int ret;
> > > +
> > > +       map =3D __bpf_map_get(f);
> > > +       if (!IS_ERR(map)) {
> > > +               ret =3D __add_used_map(env, map);
> > > +               if (ret < 0)
> > > +                       return ret;
> > > +               return 0;
> > > +       }
> > > +
> > > +       /*
> > > +        * Unlike "unused" maps which do not appear in the BPF progra=
m,
> > > +        * BTFs are visible, so no reason to refcnt them now
> >
> > What does "BTFs are visible" mean? I find this behavior surprising,
> > tbh. Map is added to used_maps, but BTF is *not* added to used_btfs?
> > Why?
>
> This functionality is added to catch maps, and work with them during
> verification, which aren't otherwise referenced by program code. The
> actual application is those "instructions set" maps for static keys.
> All other objects are "visible" during verification.

That's your specific intended use case, but API is semantically more
generic and shouldn't tailor to your specific interpretation on how it
will/should be used. I think this is a landmine to add reference to
just BPF maps and not to BTF objects, we won't be able to retrofit the
proper and uniform treatment later without extra flags or backwards
compatibility breakage.

Even though we don't need extra "detached" BTF objects associated with
BPF program, right now, I can anticipate some interesting use case
where we might want to attach additional BTF objects to BPF programs
(for whatever reasons, BTFs are a convenient bag of strings and
graph-based types, so could be useful for extra
debugging/metadata/whatever information).

So I can see only two ways forward. Either we disable BTFs in fd_array
if fd_array_cnt>0, which will prevent its usage from light skeleton,
so not great. Or we bump refcount both BPF maps and BTFs in fd_array.


The latter seems saner and I don't think is a problem at all, we
already have used_btfs that function similarly to used_maps.

>
> > > +        */
> > > +       if (!IS_ERR(__btf_get_by_fd(f)))
> > > +               return 0;
> > > +
> > > +       verbose(env, "fd %d is not pointing to valid bpf_map or btf\n=
", fd);
> > > +       return PTR_ERR(map);
> > > +}
> > > +
> > > +static int process_fd_array(struct bpf_verifier_env *env, union bpf_=
attr *attr, bpfptr_t uattr)
> > > +{
> > > +       size_t size =3D sizeof(int);
> > > +       int ret;
> > > +       int fd;
> > > +       u32 i;
> > > +
> > > +       env->fd_array =3D make_bpfptr(attr->fd_array, uattr.is_kernel=
);
> > > +
> > > +       /*
> > > +        * The only difference between old (no fd_array_cnt is given)=
 and new
> > > +        * APIs is that in the latter case the fd_array is expected t=
o be
> > > +        * continuous and is scanned for map fds right away
> > > +        */
> > > +       if (!attr->fd_array_cnt)
> > > +               return 0;
> > > +
> > > +       for (i =3D 0; i < attr->fd_array_cnt; i++) {
> > > +               if (copy_from_bpfptr_offset(&fd, env->fd_array, i * s=
ize, size))
> >
> > potential overflow in `i * size`? Do we limit fd_array_cnt anywhere to
> > less than INT_MAX/4?
>
> Right. So, probably cap to (UINT_MAX/size)?

either that or use check_mul_overflow()

>
> > > +                       return -EFAULT;
> > > +
> > > +               ret =3D add_fd_from_fd_array(env, fd);
> > > +               if (ret)
> > > +                       return ret;
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> >
> > [...]

