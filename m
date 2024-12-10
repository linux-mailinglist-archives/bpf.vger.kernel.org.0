Return-Path: <bpf+bounces-46534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8A49EB92F
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 19:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D4DF1889F2B
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 18:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59621B1422;
	Tue, 10 Dec 2024 18:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wmfk/fRE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC4D23ED59
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 18:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733854761; cv=none; b=ao9YTlO2IhYi7RCdXYChwLIJgtKdKjvuzrSzPOoGFkLKzkP3hyFgO1BhlrZQaawK4Ay6Teyx7KdvT8sroZW8zKS01VeYRqag84Sr9E2g7edTZEjuinPgqw2p1Oo+1ktYD1z1H0CmznUNLy/GU/CY99eauXGmAXxWRZd1xoixQFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733854761; c=relaxed/simple;
	bh=5FPP6XUQnKI1pfzM9BxlCDrqsaGJiC4GG4Nt7ZCqL3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=arqo8+MN3t9I/TvLKlbiD1ExBqCFRPndv+ZFrzw9RQiKkKySXZfe2erRDh38CzPgYRAZQM9WWiT8lZGIWuWCLsLDdzMgfTjx1H35Io+rkjBo4pzNFCjC9mFsIrQA30XjMK7sTRtGCGJSZcDBhs2lzG7a7SrMT4e3U5NdEs6O698=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wmfk/fRE; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2163bd70069so28241995ad.0
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 10:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733854758; x=1734459558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prRt4a+We2BWhE40LrsNppgYWEIViiZl5B8QwT4pzx8=;
        b=Wmfk/fRExfZikEh/NzQlyc5hJBqie6R9r/xX8Z+6Thh85XBqTqc5MvtyRm/N7FZXNl
         SmqCzlMlHeilO9tlfK4jZWfu0PCjr2Qtz5GDIlT83QEWxZFdXQrEc3LCA9qvZbD3H/qK
         oypYlKtsbhzHBTNwlc/RmcRD0FlnAlRqTT6FHE13axEtTBJJJH4ZpWHQ1XU7i3pS8Ytk
         9T/Ns15qt4SHTw3W7noEJaXzrgY69Seo2sXMYLfxMrM1Rq62J/jGTrze/SIk9FNMCdNG
         Cnb+MOmTveUJUakjufczZwQI4Cb4+650Gwb3jVdXLltzRX7mcJB/SgSS9NLeesUC0zf4
         xvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733854758; x=1734459558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prRt4a+We2BWhE40LrsNppgYWEIViiZl5B8QwT4pzx8=;
        b=B4Ul3Kqji/A1G+s90YSlDDunQo61NbwE95EXnfHyBm1K73yD48RbXUmSeprggDL7Fe
         RzJCTUIEKFVvzZVbUPht8wjeXoINrMopItKSvQRIooTDtyw+yNjAWNHJwVZjZF44tGt4
         M89GhFjsD3jdR4ebhPjy9n6ATz0DRZ/fdvbntWjyC++SGrBvZX7XsO7KpUhdBqpKixUW
         97WIma+UTgqD1MrPPNF3riQsqZElwu4otGrghumWxmWKENcuVf3hFf+bfjyj8ZM0kUtN
         Bal3k7AL8aB1nOPaOL9Ij5H+YNsg1ZdXav6zsRaw14Ps6yXqbwTz1ytlsmaAE4EYIyaP
         8uFg==
X-Gm-Message-State: AOJu0YwQ04TUbajJDQIrZe+j5V3kxaVi132/tWYqBMPMMrmZrY8b1mBF
	8fOhO3xwLPy6KN9aJ2/0b8GXXrTGiDZa24KaFMOQwUbwd6OSO3gzZaQ0BnHazAH6HQQq8QXtc2n
	idmC5vBAzsTIPl8ZAKu4XUTsibcWC4w==
X-Gm-Gg: ASbGncvaxaWQY6ZuhPA8KA6E3uRB8PWV9+9vINf1lnzLzilHqvLkjljtyTgjyzLBZCy
	AZju26RtHTSkV7NJTwgpAZn3+ZSd2ed3N6DwiQuNt2tRTQkgzfVg=
X-Google-Smtp-Source: AGHT+IGIm3kW/JRE4rQ6hJValJuCoOkgS9vc2IF4UCfq85UYsjD5rLUCexgxQb/TUUMkocFlERLzxoQ8Ytt1C7GB/cM=
X-Received: by 2002:a17:90b:380a:b0:2ee:df70:1ff3 with SMTP id
 98e67ed59e1d1-2f127e27c94mr19428a91.0.1733854757962; Tue, 10 Dec 2024
 10:19:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203135052.3380721-1-aspsk@isovalent.com> <20241203135052.3380721-4-aspsk@isovalent.com>
 <CAEf4BzZiD_iYpBkf5q5U9VoSUAFJN8dxOBWNJdT5y9DxAe=_UQ@mail.gmail.com>
 <Z1BJc/iK3ecPKTUx@eis> <CAEf4BzZVkNRV+8ROMMM-oGdHd1HUSx3WVv77TK+H4Fr8PhHHBQ@mail.gmail.com>
 <Z1FnPIuBiJFMRrLP@eis> <Z1gCmV3Z62HXjAtK@eis>
In-Reply-To: <Z1gCmV3Z62HXjAtK@eis>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 10 Dec 2024 10:19:05 -0800
Message-ID: <CAEf4Bzau=UnvGFskeyeBK2y3-O8x887ucUpX0bKhoHS-P-SwSg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 3/7] bpf: add fd_array_cnt attribute for prog_load
To: Anton Protopopov <aspsk@isovalent.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 12:56=E2=80=AFAM Anton Protopopov <aspsk@isovalent.=
com> wrote:
>
> On 24/12/05 08:41AM, Anton Protopopov wrote:
> > On 24/12/04 10:08AM, Andrii Nakryiko wrote:
> > > On Wed, Dec 4, 2024 at 4:19=E2=80=AFAM Anton Protopopov <aspsk@isoval=
ent.com> wrote:
> > > >
> > > > On 24/12/03 01:25PM, Andrii Nakryiko wrote:
> > > > > On Tue, Dec 3, 2024 at 5:48=E2=80=AFAM Anton Protopopov <aspsk@is=
ovalent.com> wrote:
> > > > > >
> > > > > > The fd_array attribute of the BPF_PROG_LOAD syscall may contain=
 a set
> > > > > > of file descriptors: maps or btfs. This field was introduced as=
 a
> > > > > > sparse array. Introduce a new attribute, fd_array_cnt, which, i=
f
> > > > > > present, indicates that the fd_array is a continuous array of t=
he
> > > > > > corresponding length.
> > > > > >
> > > > > > If fd_array_cnt is non-zero, then every map in the fd_array wil=
l be
> > > > > > bound to the program, as if it was used by the program. This
> > > > > > functionality is similar to the BPF_PROG_BIND_MAP syscall, but =
such
> > > > > > maps can be used by the verifier during the program load.
> > > > > >
> > > > > > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > > > > > ---
> > > > > >  include/uapi/linux/bpf.h       | 10 ++++
> > > > > >  kernel/bpf/syscall.c           |  2 +-
> > > > > >  kernel/bpf/verifier.c          | 98 ++++++++++++++++++++++++++=
++------
> > > > > >  tools/include/uapi/linux/bpf.h | 10 ++++
> > > > > >  4 files changed, 104 insertions(+), 16 deletions(-)
> > > > > >
> > > > >
> > > > > [...]
> > > > >
> > > > > > +/*
> > > > > > + * The add_fd_from_fd_array() is executed only if fd_array_cnt=
 is non-zero. In
> > > > > > + * this case expect that every file descriptor in the array is=
 either a map or
> > > > > > + * a BTF. Everything else is considered to be trash.
> > > > > > + */
> > > > > > +static int add_fd_from_fd_array(struct bpf_verifier_env *env, =
int fd)
> > > > > > +{
> > > > > > +       struct bpf_map *map;
> > > > > > +       CLASS(fd, f)(fd);
> > > > > > +       int ret;
> > > > > > +
> > > > > > +       map =3D __bpf_map_get(f);
> > > > > > +       if (!IS_ERR(map)) {
> > > > > > +               ret =3D __add_used_map(env, map);
> > > > > > +               if (ret < 0)
> > > > > > +                       return ret;
> > > > > > +               return 0;
> > > > > > +       }
> > > > > > +
> > > > > > +       /*
> > > > > > +        * Unlike "unused" maps which do not appear in the BPF =
program,
> > > > > > +        * BTFs are visible, so no reason to refcnt them now
> > > > >
> > > > > What does "BTFs are visible" mean? I find this behavior surprisin=
g,
> > > > > tbh. Map is added to used_maps, but BTF is *not* added to used_bt=
fs?
> > > > > Why?
> > > >
> > > > This functionality is added to catch maps, and work with them durin=
g
> > > > verification, which aren't otherwise referenced by program code. Th=
e
> > > > actual application is those "instructions set" maps for static keys=
.
> > > > All other objects are "visible" during verification.
> > >
> > > That's your specific intended use case, but API is semantically more
> > > generic and shouldn't tailor to your specific interpretation on how i=
t
> > > will/should be used. I think this is a landmine to add reference to
> > > just BPF maps and not to BTF objects, we won't be able to retrofit th=
e
> > > proper and uniform treatment later without extra flags or backwards
> > > compatibility breakage.
> > >
> > > Even though we don't need extra "detached" BTF objects associated wit=
h
> > > BPF program, right now, I can anticipate some interesting use case
> > > where we might want to attach additional BTF objects to BPF programs
> > > (for whatever reasons, BTFs are a convenient bag of strings and
> > > graph-based types, so could be useful for extra
> > > debugging/metadata/whatever information).
> > >
> > > So I can see only two ways forward. Either we disable BTFs in fd_arra=
y
> > > if fd_array_cnt>0, which will prevent its usage from light skeleton,
> > > so not great. Or we bump refcount both BPF maps and BTFs in fd_array.
> > >
> > >
> > > The latter seems saner and I don't think is a problem at all, we
> > > already have used_btfs that function similarly to used_maps.
> >
> > This makes total sense to treat all BPF objects in fd_array the same
> > way. With BTFs the problem is that, currently, a btf fd can end up
> > either in used_btfs or kfunc_btf_tab. I will take a look at how easy
> > it is to merge those two.
>
> So, currently during program load BTFs are parsed from file
> descriptors and are stored in two places: env->used_btfs and
> env->prog->aux->kfunc_btf_tab:
>
>   1) env->used_btfs populated only when a DW load with the
>      (src_reg =3D=3D BPF_PSEUDO_BTF_ID) flag set is performed
>
>   2) kfunc_btf_tab is populated by __find_kfunc_desc_btf(),
>      and the source is attr->fd_array[offset]. The kfunc_btf_tab is
>      sorted by offset to allow faster search
>
> So, to merge them something like this might be done:
>
>   1) If fd_array_cnt !=3D 0, then on load create a [sorted by offset]
>      table "used_btfs", formatted similar to kfunc_btf_tab in (2)
>      above.
>
>   2) On program load change (1) to add a btf to this new sorted
>      used_btfs. As there is no corresponding offset, just use
>      offset=3D-1 (not literally like this, as bsearch() wants unique
>      keys, so by offset=3D-1 an array of btfs, aka, old used_maps,
>      should be stored)
>
> Looks like this, conceptually, doesn't change things too much: kfuncs
> btfs will still be searchable in log(n) time, the "normal" btfs will
> still be searched in used_btfs in linear time.
>
> (The other way is to just allow kfunc btfs to be loaded from fd_array
> if fd_array_cnt !=3D 0, as it is done now, but as you've mentioned
> before, you had other use cases in mind, so this won't work.)
>
> > > >
> > > > > > +        */
> > > > > > +       if (!IS_ERR(__btf_get_by_fd(f)))
> > > > > > +               return 0;
> > > > > > +
> > > > > > +       verbose(env, "fd %d is not pointing to valid bpf_map or=
 btf\n", fd);
> > > > > > +       return PTR_ERR(map);
> > > > > > +}
> > > > > > +
> > > > > > +static int process_fd_array(struct bpf_verifier_env *env, unio=
n bpf_attr *attr, bpfptr_t uattr)
> > > > > > +{
> > > > > > +       size_t size =3D sizeof(int);
> > > > > > +       int ret;
> > > > > > +       int fd;
> > > > > > +       u32 i;
> > > > > > +
> > > > > > +       env->fd_array =3D make_bpfptr(attr->fd_array, uattr.is_=
kernel);
> > > > > > +
> > > > > > +       /*
> > > > > > +        * The only difference between old (no fd_array_cnt is =
given) and new
> > > > > > +        * APIs is that in the latter case the fd_array is expe=
cted to be
> > > > > > +        * continuous and is scanned for map fds right away
> > > > > > +        */
> > > > > > +       if (!attr->fd_array_cnt)
> > > > > > +               return 0;
> > > > > > +
> > > > > > +       for (i =3D 0; i < attr->fd_array_cnt; i++) {
> > > > > > +               if (copy_from_bpfptr_offset(&fd, env->fd_array,=
 i * size, size))
> > > > >
> > > > > potential overflow in `i * size`? Do we limit fd_array_cnt anywhe=
re to
> > > > > less than INT_MAX/4?
> > > >
> > > > Right. So, probably cap to (UINT_MAX/size)?
> > >
> > > either that or use check_mul_overflow()
> >
> > Ok, will fix it, thanks.
>
> On the second look, there's no overflow here, as (int) * (size_t) is
> expanded by C to (size_t), and argument is also (size_t).

What about 32-bit architectures? 64-bit ones are not a problem, of course.

>
> However, maybe this is still makes sense to restrict the maximum size
> of fd_array to something like (1 << 16). (The number of unique fds in
> the end will be ~(MAX_USED_MAPS + MAX_USED_BTFS + MAX_KFUNC_BTFS).)
>
> > > >
> > > > > > +                       return -EFAULT;
> > > > > > +
> > > > > > +               ret =3D add_fd_from_fd_array(env, fd);
> > > > > > +               if (ret)
> > > > > > +                       return ret;
> > > > > > +       }
> > > > > > +
> > > > > > +       return 0;
> > > > > > +}
> > > > > > +
> > > > >
> > > > > [...]

