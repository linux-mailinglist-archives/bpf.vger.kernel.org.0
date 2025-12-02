Return-Path: <bpf+bounces-75878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C09C6C9B692
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 13:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E76F4E2F12
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 12:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC973112B2;
	Tue,  2 Dec 2025 12:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="as0F+brr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A73253340
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 12:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764676908; cv=none; b=f+S9afAimmr6c+xYhg29J5scXRtGSRPsmvo36FZ5WGK2fO4AdI2Srd6V7NI/oAylKD0XvsI1HlbyEyxKv84qHfdEPFmbrg90CySBO+4utcctr3hinzoJENueXni7GA6dZPTy2+fdwiFdSSCVOgmg5lcJ4tef8qjhm8jdc6UTAR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764676908; c=relaxed/simple;
	bh=/GyXvn7GazQD4+579rjQK9qMywbuNjlWxtvuM8AcxqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBpQHhmVAa5XbwDalRke8oJSm5I9hAVOeXtxYVREH/CjaKk+jJaJc7+oa7J8K1dlvxBycIGoAk7DrzCMUc0m3g3bmozEUKFqVCDpFmhmLFowyCBS/ag+nbzIayFIjnTUSe3PCcX4uYmpdL6dAwWeDSmqp7Rfs2OpLb6vMjveYFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=as0F+brr; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 140433FB62
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 12:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1764676905;
	bh=Bx6LiHCBObth8YNMGBQIfSklEUU3DVX8SHP2R+cWAD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=as0F+brrxuysCACAG/RX4jujUd4N3fRP6t251kTNOcX7vaoTV82qsWYlKGV5x3yGd
	 MWzhc/cygiM9ISHMRR5STdD2djTlT/oBiZ+zpLntW69wxS4uDEhwpcYQLVfnc4m3D+
	 kqVhB59pI5bhFrZ8Zaz177J6cfgvtSABz2rX/4o9H11AXisuizEG0r+JRTbbicrOaq
	 ZMkn3EH6pFK3tmBtjZX4hcermdxJCGS5KZi9eadMgcGcy/N6li0umjnCkWw62F+nGB
	 Ez9n7QxrvXCmTK9OvYXQGxsEPVIWmovd4X7gvRfuB/UMU9PjGBx2xg7Sg5GcroVeUW
	 IKkoCVUyWwl+m0FWervlCH4/4G4836OGCbeoIDLqS3YGACEzKvpMo6n/+1GwSK1GCh
	 8h1JNGEeJ6O3HsPJSDn9p+PBAMbP1YzNaXxG/H8kNSK8vOGITClR7kZDb/dsfGsZJw
	 GcM65IId0apPAGikQFxeYnVc4ACWzM5Ew15iQbGuzR5KEYoODdBeNKR0QP3DXlCQWD
	 1AaZBhCqYdQKREdImKfEA7TV5fv8YgvlzWtgRUuQDbbDdtRWFH450xQmVtvI20qzJx
	 7zscAyXkGQH6lbwd/f8McMpnpM5uNXfNmwi+yoDuukd0Hju+1kBqvRQn60vtXlpnm/
	 ypCZkzApi2yD4UoFtIDlYbo4=
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-5e3e7dce304so4922439137.1
        for <bpf@vger.kernel.org>; Tue, 02 Dec 2025 04:01:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764676903; x=1765281703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bx6LiHCBObth8YNMGBQIfSklEUU3DVX8SHP2R+cWAD8=;
        b=nEKWnpb8AOwkfzeWsEFTg5vy4HHkl2Tx/DIwX6jMkElNhnCiUMYAjXeJ6HO0q+2EYV
         fcKDuBJhhvjq2sQCS/qgedmAZOO2ERU9n7Wk5v+Lc48odJ7XtK8JIfa4wT2lJITlM2Uy
         CLar7OrEsi6bni6JI0KXctdKMUDaEaHf+D9pctWzVqTPaFSYWv/6WMpfwkzDUZBgJks8
         o5CuzMXxe3uaiFFAGVt6fHrzbGd9dvn6RWAtLt8t6+zMBnork81TEGJ9eZWJuefIsGrg
         WbislGMMhlCPFCg1tUj0p+QooHQNMdTccXZZcACZlbnB+rShKpy9qT2RgM9oLbUta62D
         dPsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPZZRhvEWsnGp0WsTle6HjymcbMGh5n2uq/mueA64YQFQqD5uD81nsJeUEebsHuKElAvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGuuh++jhjeuhzKNRsX2YMrrr3K3WzaBADNVLqqe+Zq5HHCzxf
	dcnBYS37MXFdpZXwxBu9Hl9DAzlror22yIARji0E8vYgwEUSCPmtGWOzPnp/FUz3b1DIjrcqMT3
	/pw3032+JYdzuHIP7iHqKSbg06G9wuVyrcwe+wa5pnUkU3oziBi5ihQQzCJ4GY8+w4Dh7g4/z4q
	nQ2uqRU4YrzPiN2JOzq2mzvrJvrLnpGeTLBL34U3+wAwWD
X-Gm-Gg: ASbGncuXHRm6B2yGQ+swq3ZNv4GskYUBYtBkcK6JgLFIaSpHGoa0nlQ8HL7x8wgXHZt
	PNuis/KC/+PcX8B+oRqMGU/0hL16XmN3hoEqUf3xcLPezecTtxaVlOEvXC6W3YfFhN8KIAx8ohX
	OBfYm3xuaE9tlGQpKkAjkvZpkfa6R1Nk9nvnZfw79Kiw8BlE7TyIHEQq7Dziw54yu+viceuzNyG
	Y69eZvqmPZD1SnRiB3hrdBV
X-Received: by 2002:a05:6102:2d07:b0:5dd:89f2:555b with SMTP id ada2fe7eead31-5e1de3b6cc1mr18029663137.21.1764676903552;
        Tue, 02 Dec 2025 04:01:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/4otaajU0FZAjzIEkB9dC/A9MVnbGEDXAmWQ60JU9Yo6/+Y6WS/HURSDRP3EfXRvVM/iUCRkRiukF9XnfWsE=
X-Received: by 2002:a05:6102:2d07:b0:5dd:89f2:555b with SMTP id
 ada2fe7eead31-5e1de3b6cc1mr18029593137.21.1764676903195; Tue, 02 Dec 2025
 04:01:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201122406.105045-1-aleksandr.mikhalitsyn@canonical.com>
 <20251201122406.105045-5-aleksandr.mikhalitsyn@canonical.com> <aS2offcUPOkfkye1@tycho.pizza>
In-Reply-To: <aS2offcUPOkfkye1@tycho.pizza>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Tue, 2 Dec 2025 13:01:31 +0100
X-Gm-Features: AWmQ_bmtgq2rOTVDE8E5GTweBir_PK_AxQ8Wyv5R_RplUDXalh6xhtQgsMWrY_Y
Message-ID: <CAEivzxe2GbA7TAyRb1TZceWxdzBibz2awA1NYMO+ZnHaMAwhig@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] seccomp: handle multiple listeners case
To: Tycho Andersen <tycho@kernel.org>
Cc: kees@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <shuah@kernel.org>, Andrei Vagin <avagin@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 3:39=E2=80=AFPM Tycho Andersen <tycho@kernel.org> wr=
ote:
>
> On Mon, Dec 01, 2025 at 01:24:01PM +0100, Alexander Mikhalitsyn wrote:
> > If we have more than one listener in the tree and lower listener
> > wants us to continue syscall (SECCOMP_USER_NOTIF_FLAG_CONTINUE)
> > we must consult with upper listeners first, otherwise it is a
> > clear seccomp restrictions bypass scenario.
> >
> > Cc: linux-kernel@vger.kernel.org
> > Cc: bpf@vger.kernel.org
> > Cc: Kees Cook <kees@kernel.org>
> > Cc: Andy Lutomirski <luto@amacapital.net>
> > Cc: Will Drewry <wad@chromium.org>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Shuah Khan <shuah@kernel.org>
> > Cc: Tycho Andersen <tycho@tycho.pizza>
> > Cc: Andrei Vagin <avagin@gmail.com>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: St=C3=A9phane Graber <stgraber@stgraber.org>
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> > ---
> >  kernel/seccomp.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > index ded3f6a6430b..ad733f849e0f 100644
> > --- a/kernel/seccomp.c
> > +++ b/kernel/seccomp.c
> > @@ -450,6 +450,9 @@ static u32 seccomp_run_filters(const struct seccomp=
_data *sd,
> >                       ret =3D cur_ret;
> >                       matches->n =3D 1;
> >                       matches->filters[0] =3D f;
> > +             } else if ((ACTION_ONLY(cur_ret) =3D=3D ACTION_ONLY(ret))=
 &&
> > +                         ACTION_ONLY(cur_ret) =3D=3D SECCOMP_RET_USER_=
NOTIF) {
> > +                     matches->filters[matches->n++] =3D f;
> >               }
> >       }
> >       return ret;
> > @@ -1362,8 +1365,17 @@ static int __seccomp_filter(int this_syscall, co=
nst bool recheck_after_trace)
> >               return 0;
> >
> >       case SECCOMP_RET_USER_NOTIF:
> > -             if (seccomp_do_user_notification(match, &sd))
> > -                     goto skip;
> > +             for (unsigned char i =3D 0; i < matches.n; i++) {
> > +                     match =3D matches.filters[i];
> > +                     /*
> > +                      * If userspace wants us to skip this syscall, do=
 so.
> > +                      * But if userspace wants to continue syscall, we
> > +                      * must consult with the upper-level filters list=
eners
> > +                      * and act accordingly.
>

Hi Tycho,

> This looks reasonable to me, pending whatever the outcome is of your
> discussion of plumber's (I won't be there), feel free to add:

off:
I will be there only virtually too, btw.
Hope we can make it on FOSDEM 2026 ;)

>
> Reviewed-by: Tycho Andersen (AMD) <tycho@kernel.org>

Added in -v2. Thanks ;)

>
> I did have to think a bit about why matches.filters would be
> guaranteed to have a user notification for this filter, but it's
> because of your =3D=3D check above in seccomp_run_filters(). Maybe worth
> noting that here.

i agree absolutely, I've added some more explanatory comments to ensure tha=
t
we are all on the same page and further code readers too.

>

Kind regards,
Alex

> Tycho

