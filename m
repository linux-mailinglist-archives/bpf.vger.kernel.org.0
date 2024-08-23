Return-Path: <bpf+bounces-37910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CC295C255
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 02:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94B71B21D35
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 00:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B61F1CD31;
	Fri, 23 Aug 2024 00:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="ntLd92xz"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1250B1CD00
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 00:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724372563; cv=none; b=QiT2NC3vm01hkyJvUEsh9Va3Cn9UBmIhoUhxfwd+g9I5IIJIQZj32gf4h4+HZzgn7m27AJ9/LC6pgzMzVnbrR9DVS1zmGcVZMIZ/K9pY870ngsE4qw2ooyMEoR7KPVRwOOPrxwljTHgMLbkuNqB459/Y+48Etot9uNM77FG8LFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724372563; c=relaxed/simple;
	bh=LjMm/IVn+lHwBBoOX8PyQez00LS+mSGBjIhW3+ZHdAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X4BDX484aXaEvBtv5r5h1ePwW/x10wd8Tbv01UxECCVV+cUsQQOhU1roFl7lCA0eH2z8j2lGfr7S1fBr2G0d6uceeSfhyUvtXzpRDt243wZemwyPwXwVQaLHnuISV9lH4PzLVRqtoHQ/RNWUfzNUpSb8DDh4G+Fb7OLnGnCTBog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=ntLd92xz; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1724372561; x=1724977361; i=linux@jordanrome.com;
	bh=6HAETy2mschKR2TSb77KT8tau0gWSkldeyEnPy7xVjk=;
	h=X-UI-Sender-Class:MIME-Version:References:In-Reply-To:From:Date:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ntLd92xzz9Bo26jybwgKYSu5OX93rmgwkCaKoWytnDiqtP12JpULHxU7AN5gB1H5
	 +0gpiyH/kMHq3hyZpf/dnyD1TDDcck/Alk/WufGCZKpa2800UswJr3b6efn801jrn
	 8ZwL2/uZ1JYFSWRupbE+KbCxvfQOmDdA6+LNMoxqit1CqHR0Muv+e6bTB9fDzv06n
	 hW7U8TmQuET/ol0jJAsyY+i66998l1kW8d4XF6jKTYIb4iKl24yihUddFnNHXCBjY
	 HzSoHIZkVgSs/sYC6pjOWs9T3IWuMO0iF3F7Sr4pOsId2UqbQebSnN6W5Aj9BlF8Z
	 NH8uTSsBuFKSlOOHuw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from mail-il1-f180.google.com ([209.85.166.180]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0MDRDX-1svKyT44Hl-004Zi9 for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 02:22:41
 +0200
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-39d3b89ded1so5105855ab.0
        for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 17:22:40 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz06bDxqd3w8WroNX3rqzfADIdthYzXomGW3QHWVo+w9HBRa6fT
	t22GIY6ok0XXwqTQhmHfFBgcQuIdKqzaf3QZhkOha/DeCfg/f3VkU78inksAWzMAIQz9yJpSFfx
	RttHLC93ZtNSdQGcBlVhMQcAD7TU=
X-Google-Smtp-Source: AGHT+IH00e+gSAhiqr1XxbZLOzYkT1ImpE2/ft7NUNFA12gWH+slTmmegWeMRILmb9/Z7su18PmmH5l8X6fHufgnRUg=
X-Received: by 2002:a05:6e02:1d01:b0:38b:48c9:55d5 with SMTP id
 e9e14a558f8ab-39e3c98c89emr5167855ab.13.1724372560488; Thu, 22 Aug 2024
 17:22:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823000552.2771166-1-linux@jordanrome.com> <CAADnVQKW0HepVOqjCeiDVAMfz-Yj0OYaNGiYJXJy5_JE3GVu5w@mail.gmail.com>
In-Reply-To: <CAADnVQKW0HepVOqjCeiDVAMfz-Yj0OYaNGiYJXJy5_JE3GVu5w@mail.gmail.com>
From: Jordan Rome <linux@jordanrome.com>
Date: Thu, 22 Aug 2024 20:22:29 -0400
X-Gmail-Original-Message-ID: <CA+QiOd6zG_5tP=aSJ1-e80RP8xa9chQ3HP5yHuAd5wi11LLgZw@mail.gmail.com>
Message-ID: <CA+QiOd6zG_5tP=aSJ1-e80RP8xa9chQ3HP5yHuAd5wi11LLgZw@mail.gmail.com>
Subject: Re: [bpf-next v8 1/2] bpf: Add bpf_copy_from_user_str kfunc
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Kui-Feng Lee <sinquersw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DXV5XnfwX4ZrmtAc4mlgWXz4FItFxJuZL80GiEyX5uuA42S/AmG
 G4TLkZSXhR0jjOvBwz96U474tAn/KUN0GMGP2bxlqesw6RZ/gJ2pfp8Cg+5zzQpfYGB0+e1
 QmeqtioEA4ESamSodVNWlXuYqvyW6pxnOyB0D5UgfWW9yUo8OgK5i9NrzzzMfmePvR7s5A4
 5XQ7fuMlJYV2L8IyZ855Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bB9B9nX5UdA=;lwqAqdsX65/viveCR0oA077qrwt
 GhwJF2CbTAOSbD8l/kFNYVVdJU+9IPS+VltNk5jjgpikEcQMWaM/3kjUzuZscOMMYOW+5MSpQ
 bCA6klap0B6r0VFvl6mfImSIT1Yex0JGispvmAbF9UnaK5ehYwv01UX/S18JBz1sg0yRvo/y7
 pJuyMJ1+xjFRRVawA9VjrgeZZQiPSRNx6Hn3lZU4mOBqqGOX6Q/byVTcNAhV1OQrFYGGZP18w
 AeInqeI3EnVAOwDy+MQXtBgqWkVdTBGj9KlzpBzhj6cPQXq0+c0glEArAUGgAt9UvR2pQG28P
 e/9lUvvSiDhxfRj+9K9/zu1JKY6sBEQBAzB7UR1031kYsG/Kb7D9PJKfTrcEcTD5gaSVWdZVb
 B9AmkVhCFSX5YfBZQM12vkOeO/l3c6Kzs6Es7L3JmTzOHof19lsrpBxKRUb00FEYbwecHx+yS
 8PxoFzGmwErCwzizekYTIk6SlzLou36xJmQtD1dSPBNqu851zgMoB8xb3HqNmcF9T7EoU8fhU
 nvNuB19d/sGTA1c/8n0kX/LOk2ssoQYvi5/nt8aLDtIX00R2rD2Chy0ccXygPxjiLVRTJSQhi
 AAa6xTO1zELFiDKxPcho1SPqzGoZSSxJ08M0E3ZQ4IgU27zHrgDeOEW6kcoee4GyLqXcZPIz7
 WPNl0FEiaIOsiTbS013+fjX6ZkSTLo3Xv9NyEVF0Os/e7y5M1l+YvWvILNZ8ormhOwQvQxZq7
 v6Aj1NsYfuVJuT+sMS7mngOpeXrfzZPCg==

On Thu, Aug 22, 2024 at 8:15=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Aug 22, 2024 at 5:06=E2=80=AFPM Jordan Rome <linux@jordanrome.com=
> wrote:
> >
> > +/**
> > + * bpf_copy_from_user_str() - Copy a string from an unsafe user addres=
s
> > + * @dst:             Destination address, in kernel space.  This buffe=
r must be at
> > + *                   least @dst__szk bytes long.
> > + * @dst__szk:        Maximum number of bytes to copy, including the tr=
ailing NUL.
> > + * @unsafe_ptr__ign: Source address, in user space.
> > + * @flags:           The only supported flag is BPF_F_PAD_ZEROS
> > + *
> > + * Copies a NUL-terminated string from userspace to BPF space. If user=
 string is
> > + * too long this will still ensure zero termination in the dst buffer =
unless
> > + * buffer size is 0.
> > + *
> > + * If BPF_F_PAD_ZEROS flag is set, memset the tail of @dst to 0 on suc=
cess and
> > + * memset all of @dst on failure.
> > + */
> > +__bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__szk, const =
void __user *unsafe_ptr__ign, u64 flags)
>
> Did you miss my previous comment re __szk vs __sz ?
>

Ah, yes, I did miss it. Will fix.

> > +enum {
> > +       BPF_F_PAD_ZEROS =3D (1ULL << 0),
> > +};
>
> Pls give enum a name, so it's easier for CORE logic to detect the
> presence of this feature in the kernel.

How about 'bpf_copy_str_flags' ? As I imagine we will use this flag on
'bpf_copy_from_user_task_str', when I add that.

