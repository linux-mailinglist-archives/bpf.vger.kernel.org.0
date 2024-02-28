Return-Path: <bpf+bounces-22958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8889986BC3D
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 00:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E1801F2251A
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 23:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513057291C;
	Wed, 28 Feb 2024 23:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yn53G8CQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8198872907
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 23:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709163256; cv=none; b=GzeqRoYj094XQznWXbLsneAa3j6ubEHP+out/znCCh7gSdZuA0EHEZii/u5Zlo7gNYWCdKKU+bnPKGhBAPZm9f6mWaLbswUbbrRhjxNxuQ/Qyubrs7PsUjJocSxJR813e6m2sX48MebATzRd1L07x0RKN3c5vAtYt5dONkBM+QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709163256; c=relaxed/simple;
	bh=uZcOPTgbFMgwsJxLmr0Dly9ml9Pa09plrCIag5ocXMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jq2yofupkCGkdCw/7dekVdfJ2eByYpXuhzI3LBvQRJrGQuUQofseMzFp1hyV8Xq0eNoxu8ieSwv+kUxTLHrK05ItLLLvSK9jlBtieJjlUlk6mbggvxx6ps7i8v203hqmHOkV/kyMzlnoquFeO8edyPISiByaxGwcUICgJzh6iy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yn53G8CQ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dcab44747bso3451885ad.1
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 15:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709163255; x=1709768055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vp6GO5nmfZUmlOmAJ9AEyqcTWZfPnxCKJtxYMnQLWbI=;
        b=Yn53G8CQ6I/NVgken1l5Gv3FQG82Qad8qg0aLxRq6igiAf519H2GH9TUOPz1Qir3O0
         Pr/JEPg8r2h0wK3kCCq2hpa+MpSh2IPhEhUXcLAKuKIc9SCZSO0C850EIcWJ3viIM4A3
         ch3R4FD2Nr/Mh/bnCeV3qe9hCWg/oOU+XbUKJDTV70ZAM2Sz+hd9bKPs2B5b23Fbc7Lj
         c555hvaqJF0Q3P5/du34krJfgfKNcqF/dKZeoWCjXJZYn39F119jBK/K6gUzO+g/VklP
         qpFtGBg0Z8k/iYpYYTbXs69COKD/8t0ZmN+vblKmoOo7P8jct5AJ+mqB6ozStrjzJGFo
         Q8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709163255; x=1709768055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vp6GO5nmfZUmlOmAJ9AEyqcTWZfPnxCKJtxYMnQLWbI=;
        b=HNClGXvwLhJNzRvz9CtxdN2AgoFiGfOZC1MlIcJAF68XGRPNRgepY6xYyghZsYY1D+
         +30FG7ZqRiwLe03bw9XlUp7JBqHisrwA10gpxpGPKs1RnSfSkYwJW2aa6tzR0zQB6aGU
         zDIEFW3JExVBjwVzlHapcoRr98y8p9EohaSk9zKVh++Wlefh3y7NyTsUGgsE1ChvCxK7
         /0cS42yMnj5sB5g7U/3KKdCXUMl4T9roIOEvTItoY3wmNG5FuQBFO6NXohhFrEHhvGHo
         xVp3FWTAm2N+JgHu8Eo+x0fGjH4LTufNC8w4Xp2JXLLcLCVGuh0RzK5iO3aUVq7lG++1
         DBag==
X-Gm-Message-State: AOJu0Yz1EGmiwYD8eAIb435FoAkGcAfKlH2Fj+mgnS4iu/L4H+3Q+i7X
	ozQF7pC4nH56f64Hk03ArewERScet7VNPs6R+NaOabU1Ks5lC1Dw/ZTOVPWsXlVFcVMZF32WYxX
	r7CONR6HJEkYfZ2PmWQcXevS41RE=
X-Google-Smtp-Source: AGHT+IGOL1W/yaS2lqdsiSL3OGspTG3TAi5uvkIeI7a70r/9ZPI62LgbLcDw1WSxgemnntXIZuP/QibmLq9EGIL3TMI=
X-Received: by 2002:a17:903:181:b0:1dc:2d65:5fd1 with SMTP id
 z1-20020a170903018100b001dc2d655fd1mr531235plg.2.1709163254842; Wed, 28 Feb
 2024 15:34:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227204556.17524-1-eddyz87@gmail.com> <20240227204556.17524-3-eddyz87@gmail.com>
 <CAEf4BzZL3+g0cN9swTGkH4bZgSFm-McUAyYnpcKLTPMENnW9qw@mail.gmail.com> <a4db633f27c18d09f773eb68c55d77adb68ddc82.camel@gmail.com>
In-Reply-To: <a4db633f27c18d09f773eb68c55d77adb68ddc82.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 28 Feb 2024 15:34:02 -0800
Message-ID: <CAEf4BzZ66b0GBM=AMGZN56W2P5LwTuKvnvE6AZ8qqBmU_cBOcg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/8] libbpf: tie struct_ops programs to kernel
 BTF ids, not to local ids
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, void@manifault.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 3:31=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2024-02-28 at 15:28 -0800, Andrii Nakryiko wrote:
> [...]
>
> > > @@ -1134,8 +1134,27 @@ static int bpf_map__init_kern_struct_ops(struc=
t bpf_map *map)
> > >
> > >                         if (mod_btf)
> > >                                 prog->attach_btf_obj_fd =3D mod_btf->=
fd;
> > > -                       prog->attach_btf_id =3D kern_type_id;
> > > -                       prog->expected_attach_type =3D kern_member_id=
x;
> > > +
> > > +                       /* if we haven't yet processed this BPF progr=
am, record proper
> > > +                        * attach_btf_id and member_idx
> > > +                        */
> > > +                       if (!prog->attach_btf_id) {
> > > +                               prog->attach_btf_id =3D kern_type_id;
> > > +                               prog->expected_attach_type =3D kern_m=
ember_idx;
> > > +                       }
> > > +
> > > +                       /* struct_ops BPF prog can be re-used between=
 multiple
> > > +                        * .struct_ops & .struct_ops.link as long as =
it's the
> > > +                        * same struct_ops struct definition and the =
same
> > > +                        * function pointer field
> > > +                        */
> > > +                       if (prog->attach_btf_id !=3D kern_type_id ||
> > > +                           prog->expected_attach_type !=3D kern_memb=
er_idx) {
> > > +                               pr_warn("struct_ops reloc %s: cannot =
use prog %s in sec %s with type %u attach_btf_id %u expected_attach_type %u=
 for func ptr %s\n",
> >
> > Martin already pointed out s/reloc/init_kern/, but I also find "cannot
> > use prog" a bit too unactionable. Maybe "invalid reuse of prog"?
> > "reuse" is the key here to point out that this program is used at
> > least twice, and that in some incompatible way?
>
> Ok, I'll change the wording.
> And split the line despite the coding standards.

please don't split format strings, it makes grepping harder

