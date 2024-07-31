Return-Path: <bpf+bounces-36183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D12494384C
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 23:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9942B211C5
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 21:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DF616CD01;
	Wed, 31 Jul 2024 21:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6sl+I3Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1058914B097;
	Wed, 31 Jul 2024 21:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722462875; cv=none; b=Nfd9HJ2zRQPFzEweCAKiCIy85Ldiy0arjPgbOWpVn2l3Pw/LDVHyCu5pcjemyu9H2PjuAM7sMwU7+M5upiYuIVUCR1Yc03d+9AY/chJkTlcitlg89lqCmpM7Wk/Kb6xYXbmZ00utVcWNawmm1Ljtl3ayBXbeWisebdi0P4bPUZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722462875; c=relaxed/simple;
	bh=IAIOcfTftLXawVj8Jk/HONlcCzkdiwR1PjftJw9imv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A7xdhn1mh7aRxoOYvBtEwk7SvzAZzUwtdnm6aV2XY7ngsYQ0N8C63TZj6MGa3Qz27+IY+xS/HcRcMfRBL0sr/WQRDv4uQP+3r5emRtMR2W5up4EI0ZR1suCDw44GC7vXdy84lh8Uz9JSR/qjBtSd1+5nisximT3vKl3YIjbXQfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6sl+I3Z; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2cd48ad7f0dso4817724a91.0;
        Wed, 31 Jul 2024 14:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722462873; x=1723067673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/rXO4mCik4v5ZM/0xrXVb6srv7OeLYb0n97FVaS0Jg=;
        b=V6sl+I3Zn+tmq2vH3vGylXWZ70tmdiYtUaAtMrL3vkL5WcqXvhK6HD2OEQXELUZBD8
         L3xQsfBQF6iVcozZkiw+7Sn30At1WsFL8xEQ4p7cPBKa+T8TUPiuNgqh7dBA9ctB5xOH
         FRtJeteCes9JnVRYQ4hDzxn3a0Y2QB3iSh2Smtex36mrK+Gi4GSNO/wht39EkSk6zrng
         0yZvXkTQmlpnyS7UbxcqOaw2SZ68e7paWxS6eGgQojoohm8OkG3qpH0IBrwLJDhiiK8/
         G2xxJES+4mS6MZ1O99BILfs81AjF0dxuhgM+OC1nsFj+INF08stLblMTMZyoT4iKedlK
         IKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722462873; x=1723067673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/rXO4mCik4v5ZM/0xrXVb6srv7OeLYb0n97FVaS0Jg=;
        b=G6qZra49Kbg8GHTdIMhh60n738R+jQdV0BxmqRSpu7Ex4gwe1fMEBoMGcY7v8OToil
         hrheqvBkwwwoUn3hj39jYnPyg8Zaq1lspTGNeDs7eSKSZr3JcvUCyx4AA9M0HQZ25Q7D
         pqSebHCWgyA+o7N2eD50dhLHokxiJVXO/yWJVJESliNUbFYHp7VlP6fC6R0kEROciRKN
         HGqDlU2I0823eAoAMUhLEtKix8v+0Ed0zzxxH/aQOFru2NHOJ20VmCQVesWj6X7pT4hZ
         DJeTYeJ1fjNxxA02czq9YKixmBNAufj+XdviM1NsXskXOa5Q8gZqyDSwuCYyNDhySOyn
         5Cfw==
X-Forwarded-Encrypted: i=1; AJvYcCXSNp8qpybUrdZoQcXpsaOmMLib7dNMrvnOr2JHoWJSHttLNCumJhCxcUee8NqcbSgX7bgyLDCzxbT7hu5it5MFUgF42/mr7SqN2ph8yvzUiqsERpvXK2VdyNCx
X-Gm-Message-State: AOJu0Yw22VJnHZ6jp5DEbcOz8K2LMlA2xtyhjaTuZNb0NraHsKaX7dI9
	2CamPLnx0j011EkyxLie0QKk/UD1gkfby6yiGOmjafmoSksrzk3G7ODyLvOy6xIGMD5gM4hqVQT
	EFwAU2Mfnbg3dscJZ5TMDdfJSOM4=
X-Google-Smtp-Source: AGHT+IGQC+31dROEL7EphsN+jLKU8mH4eZi+7nR71Ehyw4gI3lDIvQYh6tWRJrUn7bQGlvPKXHV0IisNvT2+2wqfbdA=
X-Received: by 2002:a17:90b:33d0:b0:2c9:754d:2cba with SMTP id
 98e67ed59e1d1-2cfe7755473mr753669a91.3.1722462873010; Wed, 31 Jul 2024
 14:54:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730203914.1182569-1-andrii@kernel.org> <20240730203914.1182569-2-andrii@kernel.org>
 <Zqm36i0Afe48193Z@tassilo>
In-Reply-To: <Zqm36i0Afe48193Z@tassilo>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 31 Jul 2024 14:54:20 -0700
Message-ID: <CAEf4BzYxsUyWki=2S+ZY7_wV2cujN+w3CJGXsz7s23CG1EFCqA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 01/10] lib/buildid: harden build ID parsing logic
To: Andi Kleen <ak@linux.intel.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, adobriyan@gmail.com, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, osandov@osandov.com, song@kernel.org, jannh@google.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 9:05=E2=80=AFPM Andi Kleen <ak@linux.intel.com> wro=
te:
>
> >       while (note_offs + sizeof(Elf32_Nhdr) < note_size) {
> >               Elf32_Nhdr *nhdr =3D (Elf32_Nhdr *)(note_start + note_off=
s);
> >
> > +             name_sz =3D READ_ONCE(nhdr->n_namesz);
> > +             desc_sz =3D READ_ONCE(nhdr->n_descsz);
> >               if (nhdr->n_type =3D=3D BUILD_ID &&
> > -                 nhdr->n_namesz =3D=3D sizeof("GNU") &&
> > -                 !strcmp((char *)(nhdr + 1), "GNU") &&
> > -                 nhdr->n_descsz > 0 &&
> > -                 nhdr->n_descsz <=3D BUILD_ID_SIZE_MAX) {
> > -                     memcpy(build_id,
> > -                            note_start + note_offs +
> > -                            ALIGN(sizeof("GNU"), 4) + sizeof(Elf32_Nhd=
r),
> > -                            nhdr->n_descsz);
> > -                     memset(build_id + nhdr->n_descsz, 0,
> > -                            BUILD_ID_SIZE_MAX - nhdr->n_descsz);
> > +                 name_sz =3D=3D note_name_sz &&
> > +                 strcmp((char *)(nhdr + 1), note_name) =3D=3D 0 &&
>
> Doesn't the strcmp need a boundary check to be inside note_size too?
>
> Other it may read into the next page, which could be unmapped, causing a =
fault.
> Given it's unlikely that this happen, and the end has guard pages,
> but there are some users of set_memory_np.
>
> You could just move the later checks earlier.

Yep, good catch! I'll move the overflow check and will add a note_size
check to it, thanks!

>
> The rest looks good to me.
>
> -Andi
>

