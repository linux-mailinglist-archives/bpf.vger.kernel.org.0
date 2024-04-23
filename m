Return-Path: <bpf+bounces-27589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 931158AF7D0
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 22:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83A88B2181F
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 20:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B832F14264C;
	Tue, 23 Apr 2024 20:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="JcnyXWZI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="JcnyXWZI"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61801422D4
	for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 20:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713903128; cv=none; b=Sp0hJvHjxKaXmHkyaKnjvh1I5aj89VlwTcEuRRTQAhh3u01M1/kD7U7kMBoWpthQ//YPIXbTY2j54crhPfJit3w4mUcMmNdGEgsvzymj+VRGVwFJgdEjj1viipqIznHg4t9VO2ZbNSGCovgKGq1V5gJoV9Nvkf6HKA3+1j/rbKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713903128; c=relaxed/simple;
	bh=m/RoZEm68SFwEPpXsmr6g8PQy2q82b2BiE6KbLVSoyY=;
	h=Date:From:To:Cc:Message-ID:References:MIME-Version:In-Reply-To:
	 Subject:Content-Type; b=ST36AqMNAQdpoZLTnKboeGSbN7SO+880CMuNPjpQYD/gOSZ3wm3vebE5q+IRCr6UZXIVWbC1jcp7KaBokL/PUTNImL+RLU7RWMoxT4PiO9tbNSIpM38DwJVoFL5/8+BBMQIyQHpSwVfX1Y5vRy3WTgfsi5tiMoK56e8ZT4HTfjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=JcnyXWZI; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=JcnyXWZI; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 36002C151985
	for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 13:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1713903126; bh=m/RoZEm68SFwEPpXsmr6g8PQy2q82b2BiE6KbLVSoyY=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=JcnyXWZIgfpiyU64zRPzGxRzkpIC3BKP+vEd0qXkgYg8cOYqHOlAnnUifuIFuFs/T
	 myfbBy3XlUVFO0zXfxzCDkYDEdL0t/PF2K7NpVjwWig3b2yd3JUSRkq5Z0QDRTEpPX
	 +2iSyHBrs1wZ6BB1Z7ExhYhf5XDzEZ2sZH2l44Cw=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue Apr 23 13:12:06 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id ED599C151520;
	Tue, 23 Apr 2024 13:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1713903126; bh=m/RoZEm68SFwEPpXsmr6g8PQy2q82b2BiE6KbLVSoyY=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=JcnyXWZIgfpiyU64zRPzGxRzkpIC3BKP+vEd0qXkgYg8cOYqHOlAnnUifuIFuFs/T
	 myfbBy3XlUVFO0zXfxzCDkYDEdL0t/PF2K7NpVjwWig3b2yd3JUSRkq5Z0QDRTEpPX
	 +2iSyHBrs1wZ6BB1Z7ExhYhf5XDzEZ2sZH2l44Cw=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 14004C151520
 for <bpf@ietfa.amsl.com>; Tue, 23 Apr 2024 13:12:05 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.647
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zC_yv1EZBY0x for <bpf@ietfa.amsl.com>;
 Tue, 23 Apr 2024 13:12:01 -0700 (PDT)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com
 [209.85.166.43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 51F4BC14F617
 for <bpf@ietf.org>; Tue, 23 Apr 2024 13:12:01 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id
 ca18e2360f4ac-7c8ad87b2acso156400739f.3
 for <bpf@ietf.org>; Tue, 23 Apr 2024 13:12:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713903120; x=1714507920;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z3aP+FmqqZb2PiRqw+THTIveevSLD0UDyr8x8U+Bw7Y=;
 b=dt83vANX3QhJbs69jnKOVbVH79Th5etLtB7ydPWBFHEmxxmT5vvYcMt6Ww7mu5UD/B
 46WT1LFlP1YhB2qz3wmAHRF0IjGu7mWsHKYnsl9lTHhPTYewUlIcTt8EL24lEP/J/YYu
 3JkhJCrgq79kqWGsQQpIFAK3LnjRihsOt2Bv9AOa/JMvEQENnTKchlraMuJQh8L4euGu
 ZkheNg1DDtz6qj+4gTdAu4ENjBuT8kQONtY7sxGVUR+dH/8BYoT4B1nmiWlOfIG3cKoL
 80Ugz7EH4aFgwGEUGDizX+oyrtJgdJMBXvMLXk0bEFtia/liqjq1w/m1dGl+3QkO39yf
 xvtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXpX0auU2rz4Gwn/7edmjhDkiSdd5n2rosynVeUGWVoALYhfJR3u/m2ZyE6njHaLEo1RBIy7nOI4j18LU=
X-Gm-Message-State: AOJu0YzAZqta2MMquLrE7wqkrMiYSsmBHzqP4qV+0w8OfPQBhCIXuVsO
 zGGCztB7AA+f2xBl6xGOlvtI3o6APEaP8sBYpknxenEiOqxWD59M
X-Google-Smtp-Source: AGHT+IGv8DSprWITp8lNkzx0B1M0+oFfF8OoIHbda3A/PXH39lq70Gi4rGRRpzV1CiwpOTvlNZbcZg==
X-Received: by 2002:a05:6602:2568:b0:7da:b30e:df6e with SMTP id
 dj8-20020a056602256800b007dab30edf6emr659741iob.0.1713903120482; 
 Tue, 23 Apr 2024 13:12:00 -0700 (PDT)
Received: from maniforge (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
 by smtp.gmail.com with ESMTPSA id
 lb2-20020a056638950200b00486cc2a8c36sm381565jab.44.2024.04.23.13.11.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 13:12:00 -0700 (PDT)
Date: Tue, 23 Apr 2024 15:11:57 -0500
From: David Vernet <void@manifault.com>
To: dthaler1968@googlemail.com
Cc: bpf@vger.kernel.org, bpf@ietf.org
Message-ID: <20240423201157.GA89570@maniforge>
References: <20240422190942.24658-1-dthaler1968@gmail.com>
 <20240422193847.GB18561@maniforge>
 <15c701da94f2$30a7c9f0$91f75dd0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <15c701da94f2$30a7c9f0$91f75dd0$@gmail.com>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/YXOOdBoCsVyyAVrbfv_4kgsMyT4>
Subject: Re: [Bpf] [PATCH bpf-next] bpf,
 docs: Add introduction for use in the ISA Internet Draft
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============4839443959129762916=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


--===============4839443959129762916==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VJ5kLZQ0n0fSb94c"
Content-Disposition: inline


--VJ5kLZQ0n0fSb94c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 01:18:05PM -0700, dthaler1968@googlemail.com wrote:
> David Vernet <void@manifault.com> writes:=20
> > On Mon, Apr 22, 2024 at 12:09:42PM -0700, Dave Thaler wrote:
> > > The proposed intro paragraph text is derived from the first paragraph
> > > of the IETF BPF WG charter at
> > > https://datatracker.ietf.org/wg/bpf/about/
> > >
> > > Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
> > > ---
> > >  Documentation/bpf/standardization/instruction-set.rst | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/bpf/standardization/instruction-set.rst
> > > b/Documentation/bpf/standardization/instruction-set.rst
> > > index d03d90afb..b44bdacd0 100644
> > > --- a/Documentation/bpf/standardization/instruction-set.rst
> > > +++ b/Documentation/bpf/standardization/instruction-set.rst
> > > @@ -5,7 +5,11 @@
> > >  BPF Instruction Set Architecture (ISA)
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > -This document specifies the BPF instruction set architecture (ISA).
> > > +eBPF (which is no longer an acronym for anything), also commonly
> > > +referred to as BPF, is a technology with origins in the Linux kernel
> > > +that can run untrusted programs in a privileged context such as an
> >=20
> > Perhaps this should be phrased as:
> >=20
> > ...that can run untrusted programs in privileged contexts such as the
> > operating system kernel.
> >=20
> > Not sure if that's actually a grammar correction but it sounds more
> > correct in my head. Wdyt?
>=20
> That sounds less grammatically correct to my reading, since "contexts"
> would be plural but "kernel" is singular.   The intent of the original
> sentence was that multiple programs (plural) can run in the same
> privileged context (singular) such as a kernel (singular).

Fair enough. My ack above stands.

Thanks,
David

--VJ5kLZQ0n0fSb94c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZigWDQAKCRBZ5LhpZcTz
ZNFyAP94Y3m+iIzWFNWz60YlG+5VsSoQm4uRiXnLDYb0qcXksgD/ZKb27CycgiDx
/B1aSLzZdhhhjl44n4/UfWgIwzBXCQE=
=8+UF
-----END PGP SIGNATURE-----

--VJ5kLZQ0n0fSb94c--


--===============4839443959129762916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============4839443959129762916==--


