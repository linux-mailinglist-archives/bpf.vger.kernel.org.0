Return-Path: <bpf+bounces-37912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD5295C29F
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 02:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 389E91F24137
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 00:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E03171BD;
	Fri, 23 Aug 2024 00:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="uIJCdRfo"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2119E12B6C
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 00:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724374337; cv=none; b=FWDrDeSv5lzOb0VR1y2Iv+8MKT1KoT+vdBMnzCltmZs/5iagTeWJMpN4y0rJAEBhhiqukfuuCotUtveI4QSnWZMgFjNvorl7eRQr45Hhuazvz09X4ipXbXUrnf8vezlvg/RUU/+m+36bZSVMFg7J98yDPRfrACI5Z4Uei8Kr2rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724374337; c=relaxed/simple;
	bh=46j5B9DMn6aw2JBK3P8GUksY1e28rIvFoDmx9rmKTFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=azw6vTsSvV0vsoxakPHnK2XDj64JtcVKWnxKg/wvUf88GdSoZk3B7vsyD9sTuC4Banb13ik2Uny8LsFtQAfbhZRHtyb7iC9XyO7p4zj/f+KgtyNPxUWpSNtMFk5nFZCP0OJ2PiE6SI+wk0zixt3ax/7jVtW+3nEj56XI0jqSxg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=uIJCdRfo; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1724374328; x=1724979128; i=linux@jordanrome.com;
	bh=HqFRld01nOHN/o0KqFqkAUjKrOueYHYzAEILhxC3UbM=;
	h=X-UI-Sender-Class:MIME-Version:References:In-Reply-To:From:Date:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uIJCdRfowPFMUcDgCpt7Y5uZ4uGl8m87ajvVZgFcvDLYEWSz9HPIIntI9+kwhIaM
	 ngGBYIYfCBdn0zoNc1I8gbthzXYj0zY0GFETQFUeW+o8X0gyv8kCR33O/JEc4kuwL
	 Eso2gIfJpxcLLkSXXSWjkrk9KgSHP/cXBhOHZEYcN0L+ozHrOrZ/yKaamEtStDh/D
	 ICnFDlfI41C1PEVXAEfhtli8T19Fs+H6FGs6afPQ8La7aK5q2A76GX2CC9G8/DgRN
	 XdlT4WsW1JJx27iAQJubWsJSRQgBgruu0tsTxXlu7PbfY8hNBUDFrPa+WKS3hCdlo
	 jqRWlIo29swnXAXXZA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from mail-io1-f54.google.com ([209.85.166.54]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MFe8h-1st8MH0d2T-006m4z
 for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 02:52:08 +0200
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-81f95052c2cso82387539f.0
        for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 17:52:08 -0700 (PDT)
X-Gm-Message-State: AOJu0YzHxOBu+Fbslq61MQiksThgstik4CW3Fq9CbCDvRk04hY9Rjxtu
	cSU1iQOb54RyV057CQorKWxyL4JCFIwyNOt7AU76AGAP7qsgHLSpZ/qkVMp2G/miCde+3rpZQ4e
	7SgvO9avWeeHZyVJSQj6zR8X175Q=
X-Google-Smtp-Source: AGHT+IExOfPSCqnw7b7ZGkThFw97pERoPbVcRXeCqhH+WfPtMGBLRCS2FwiQVV76n6LNflaF3oyn04FQugqp3ZgP9Mg=
X-Received: by 2002:a05:6e02:1c01:b0:399:ed4:6e9e with SMTP id
 e9e14a558f8ab-39e3c9c0d01mr5120945ab.17.1724374327682; Thu, 22 Aug 2024
 17:52:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823000552.2771166-1-linux@jordanrome.com>
 <CAADnVQKW0HepVOqjCeiDVAMfz-Yj0OYaNGiYJXJy5_JE3GVu5w@mail.gmail.com>
 <CA+QiOd6zG_5tP=aSJ1-e80RP8xa9chQ3HP5yHuAd5wi11LLgZw@mail.gmail.com> <CAADnVQKdT5F4OPtz464ZoZQ_hGed9WYorpzc3Ga=hbtdp-yJgw@mail.gmail.com>
In-Reply-To: <CAADnVQKdT5F4OPtz464ZoZQ_hGed9WYorpzc3Ga=hbtdp-yJgw@mail.gmail.com>
From: Jordan Rome <linux@jordanrome.com>
Date: Thu, 22 Aug 2024 20:51:56 -0400
X-Gmail-Original-Message-ID: <CA+QiOd5yfwFx+2KXawiDPOTkcYS_MWwaGBokxcvqAeOhwctNqw@mail.gmail.com>
Message-ID: <CA+QiOd5yfwFx+2KXawiDPOTkcYS_MWwaGBokxcvqAeOhwctNqw@mail.gmail.com>
Subject: Re: [bpf-next v8 1/2] bpf: Add bpf_copy_from_user_str kfunc
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Kui-Feng Lee <sinquersw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BSKGi/uvi69VmvMoiwdiybW06RviacHQZyi8uAL5j21xg3ctEYT
 prCfECeuvmI9aWH9p80GUG8+f544VxI6dumlK/utVZWGU4yMbxmclvhKNoyUnY0VVw2uAgO
 Bsh/m+/vF694VjTS9jh1WTtNDi3/PqTHYB/Z6WaOx1u+N1YaqLBA0M647pbqD1tDRNCY9Zg
 VGmOqPdhR6KhOsKYKpUgw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pb1Yrtn4do4=;4dv0NEWUhCtkQ94dC3PtTDiPDMI
 H2MtqIzk9pBBqYxsRr+eBdKqW1R8zngFDiRTnugXwzo4uilRG/XfsXQQwAO204/HBlmtWHD2p
 f1eK1xMH8qWY3wUWlCSDIX2r0qCDB+/8VZtUYZ6uqjHze26Ujw6dUrSgk+LSrqWXUjP73ED4Q
 9e4GXdcZH2/cCNH59mPh0rf/URuaVxXNEQbF2ziM1a3XDTFNt3bwS6ryu+CyNRV0xImvUY0hS
 VO5RSzOa9qPaOau16HfVnLoiK82g2CSazLLGqVYHJv3dQ7rWB6+r9pmpPl44fROg/6oDRERno
 N2Uh56E1bA5WmQ963+Nm80V26tM0XUCqTU4xjLoaYfKrjB7r9zBn72sXcYXY0dxfWOVTSF2sV
 yIKdUKIk0kR8GKHn5kMnTFGG/jG1Q7e9ivcJLZHfX3myUt2NoSENdCirrGN1PwnIlN8zMR8IL
 Rk+PsZm7AZOAmlgF+VIvgWnp/JOcdVx0YpF8ZYMGsM5qxuCOUwhLuPBL6iZ5yec/Q3o9WMQRD
 qplD0l0hksq1j/HoDXjMZTgeqX1HwkL8UAAZtkE7q0w3lUFMkI0HVXX3JcQBTdhXJSLwoLr9V
 oMjRK/cc63XdJh5ffMO1P9oXaIain3VYZsvLJzJGUNO2ZHLyLInac4J4ngBLW86Zxqplw7JLK
 PFZOl5bAaN3xvdZ3Fxv1GDo3reY0VG9iHyUJzx2OmDetlheJ8SJFOuGuy+e8QUUqu2RfdV1v6
 jV5rh6LACuw11kMV4q7IqR1QxiVHrmaAQ==

On Thu, Aug 22, 2024 at 8:45=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Aug 22, 2024 at 5:22=E2=80=AFPM Jordan Rome <linux@jordanrome.com=
> wrote:
> >
> > On Thu, Aug 22, 2024 at 8:15=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Aug 22, 2024 at 5:06=E2=80=AFPM Jordan Rome <linux@jordanrome=
.com> wrote:
> > > >
> > > > +/**
> > > > + * bpf_copy_from_user_str() - Copy a string from an unsafe user ad=
dress
> > > > + * @dst:             Destination address, in kernel space.  This b=
uffer must be at
> > > > + *                   least @dst__szk bytes long.
> > > > + * @dst__szk:        Maximum number of bytes to copy, including th=
e trailing NUL.
> > > > + * @unsafe_ptr__ign: Source address, in user space.
> > > > + * @flags:           The only supported flag is BPF_F_PAD_ZEROS
> > > > + *
> > > > + * Copies a NUL-terminated string from userspace to BPF space. If =
user string is
> > > > + * too long this will still ensure zero termination in the dst buf=
fer unless
> > > > + * buffer size is 0.
> > > > + *
> > > > + * If BPF_F_PAD_ZEROS flag is set, memset the tail of @dst to 0 on=
 success and
> > > > + * memset all of @dst on failure.
> > > > + */
> > > > +__bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__szk, co=
nst void __user *unsafe_ptr__ign, u64 flags)
> > >
> > > Did you miss my previous comment re __szk vs __sz ?
> > >
> >
> > Ah, yes, I did miss it. Will fix.
> >
> > > > +enum {
> > > > +       BPF_F_PAD_ZEROS =3D (1ULL << 0),
> > > > +};
> > >
> > > Pls give enum a name, so it's easier for CORE logic to detect the
> > > presence of this feature in the kernel.
> >
> > How about 'bpf_copy_str_flags' ? As I imagine we will use this flag on
> > 'bpf_copy_from_user_task_str', when I add that.
>
> Maybe 'enum bpf_kfunc_flags' ?
> since BPF_F_PAD_ZEROS is supposed to be generic and apply to various kfun=
cs.

Works for me.

