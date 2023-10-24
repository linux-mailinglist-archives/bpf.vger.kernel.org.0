Return-Path: <bpf+bounces-13152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5327D5A6C
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 20:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD14C1C20D34
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 18:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D3F3CCEF;
	Tue, 24 Oct 2023 18:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bvDZ6+N/"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F182A3B2B4
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 18:27:18 +0000 (UTC)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6280FB9
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 11:27:17 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1c9be0884ffso34936445ad.2
        for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 11:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698172037; x=1698776837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vpnVxDUoXZXPbsu71ld1wnr0DCJM9qoaA81AmF/Tg5o=;
        b=bvDZ6+N/ljrcgyEk/UTLQT1zNn7UR2gvM3EpRXqgEHkEfAsFZ36xifA9OXiD/xZ+lJ
         Zftf4Zo9vy+R6TEzb/2CnM+T++x/YJdTZmPMChebdXOWx5la/QIhnGDVr1bwup4OUcV+
         qGFMiGb7c68XrHaYXQ6TT+oxWTSDwnCYZZqn6iSd9ibkgr5g+9Ihn6UOCq/XaMhLmBYG
         C5UpKnxxv0YyHBbqcA33UaV2U1mCZZKH88kBK8lBM6UKtKzoi4LXgSf6ouikfxAPUIEO
         ieY+xEW9ijvUoFgs9OuINHOQLp/bQZRX/0r/sz5IqF7sPDt0fWQD2qoYo1dkXgsRRxM9
         RVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698172037; x=1698776837;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vpnVxDUoXZXPbsu71ld1wnr0DCJM9qoaA81AmF/Tg5o=;
        b=wC05du1hyqAwHG75K6h7DKN7yl1MzCYNFU7ag16bujxJcrXycK65WwvkIXhY6eYgvg
         y6CSnoiA0Zo5b5NUXrpyXFo8GG5TWyw1vxJrsD7wWXASz1qFGOOgrztXlchKYXTeCAXM
         mYMGMg3W2ABrsZf1t/Z5z8RR9lPpZ0UDjOAfanTeRBRPl5crofmeQ/o0L1d9tXpCgDga
         nHO/MsnnuNdLiiO+FHYHUb1lCKGdxE5iTn1swWQsuAeKJXPvP5F4B8auT3PcsOTfpi8z
         jPZc43FCZwBzIb6Rwi0FXJHNdxZbyBMbNgQQCOUpp+fuSmkKnmPjoNAmuxHePJ7T2C78
         uuTw==
X-Gm-Message-State: AOJu0YxAqfHdLc0NHK7cnvj1lzxb0rKRyeEKavU04GdkdlJer+CDkcbH
	5s3D0uNTO1d9wVZefkBtgoBLQsg=
X-Google-Smtp-Source: AGHT+IEvAsnhyN0I8736rcZmez3drzDpxGiuVDFRQiJIr8SsGNuTSfJh3rhjnni4eg0l30dbbR421OU=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:903:26c6:b0:1bb:a78c:7a3e with SMTP id
 jg6-20020a17090326c600b001bba78c7a3emr269854plb.3.1698172036775; Tue, 24 Oct
 2023 11:27:16 -0700 (PDT)
Date: Tue, 24 Oct 2023 11:27:15 -0700
In-Reply-To: <ca1f0aaa-94c2-5e7d-1d00-a640bb3be44a@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231023171856.18324-1-daniel@iogearbox.net> <20231023171856.18324-2-daniel@iogearbox.net>
 <ZTfza8hC_79X10F8@google.com> <ca1f0aaa-94c2-5e7d-1d00-a640bb3be44a@iogearbox.net>
Message-ID: <ZTgMg3HfFohvISSF@google.com>
Subject: Re: [PATCH bpf-next v3 1/7] netkit, bpf: Add bpf programmable net device
From: Stanislav Fomichev <sdf@google.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, martin.lau@linux.dev, 
	razor@blackwall.org, ast@kernel.org, andrii@kernel.org, 
	john.fastabend@gmail.com, toke@kernel.org, kuba@kernel.org, andrew@lunn.ch
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 10/24, Daniel Borkmann wrote:
> On 10/24/23 6:40 PM, Stanislav Fomichev wrote:
> > On 10/23, Daniel Borkmann wrote:
> [...]
> > The series looks great! FWIW:
> > Acked-by: Stanislav Fomichev <sdf@google.com>
>=20
> Thanks for review!
>=20
> > One small question I have is:
> > We now (and after introduction of tcx) seem to store non-refcounted
> > dev pointers in the bpf_link(s). Is it guaranteed that the dev will
> > outlive the link?
>=20
> The semantics are the same as it was done in XDP, meaning, the link is in
> detached state so link->dev is NULL when dev goes away, see also the
> dev_xdp_uninstall(). We cannot hold a refcount on the dev as otherwise
> if the link outlives it we get the infamous "unregister_netdev...waiting
> for <dev>... refcnt =3D 1" bug.

Yeah, I remember I've had a similar issue with holding netdev when
adding dev-bound programs, so I was wondering what are we doing here.
Thanks for the pointers!=20

And here, I guess the assumption that the device shutdown goes via
dellink (netkit_del_link) and there is no special path that reaches
unregister_netdevice_many_notify otherwise, right?

What about that ndo_uninit btw? Would it be more safe/clear to make
netkit_release_all be ndo_uninit? Looks like it's being triggered
in a place similar to dev_xdp_uninstall/dev_tcx_uninstall.

> > > +	ret =3D netkit_link_prog_attach(&nkl->link,
> > > +				      attr->link_create.flags,
> > > +				      attr->link_create.netkit.relative_fd,
> > > +				      attr->link_create.netkit.expected_revision);
> > > +	if (ret) {
> > > +		nkl->dev =3D NULL;
> > > +		bpf_link_cleanup(&link_primer);
> > > +		goto out;
> >=20
> > What happens to nkl here? Do we leak it?
>=20
> No, this is done similarly as in XDP and tcx, that is, bpf_link_cleanup()=
 will
> trigger eventual release of nlk here :
>=20
> /* Clean up bpf_link and corresponding anon_inode file and FD. After
>  * anon_inode is created, bpf_link can't be just kfree()'d due to deferre=
d
>  * anon_inode's release() call. This helper marks bpf_link as
>  * defunct, releases anon_inode file and puts reserved FD. bpf_prog's ref=
cnt
>  * is not decremented, it's the responsibility of a calling code that fai=
led
>  * to complete bpf_link initialization.
>  * This helper eventually calls link's dealloc callback, but does not cal=
l
>  * link's release callback.
>  */
>=20
> Thanks,
> Daniel

=F0=9F=91=8D

