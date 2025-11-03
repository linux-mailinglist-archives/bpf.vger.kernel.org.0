Return-Path: <bpf+bounces-73366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 341ACC2D7CA
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 18:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4ACA1897C40
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 17:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137E531B810;
	Mon,  3 Nov 2025 17:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7f5aKLa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FF631281F
	for <bpf@vger.kernel.org>; Mon,  3 Nov 2025 17:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762191273; cv=none; b=i84UwvYiW8jUrchIuJc6UjedGbc/DXcQ4hOtDCAKz/WrCooXeV63mb36uSthrmY5vevd3V3goRzF4sH6aLyYzZqwE7xGmioVqeDwMQRSaTBaRa8vXCbtSg+N+74WQxgx6atB4Q7HvVE1Lkm5v7dw/uM4g93Qteq5XWbkDGS7Ak8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762191273; c=relaxed/simple;
	bh=N22f/gnj9rFVOZk9moVxD41IN0Dc/i7u/NCmrOnSO1k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rUTHS+XDgoihzcu9PhXFE35zIsZmOeCXMe2wsrhB40/0xMkymK7E6Ksk+yPnctkceUDiSlwkdW+52OjzGpvYFK/ROZiGyCQ7gpsLJWsbz+aKYQ4XEKOEpGNeVLH/eu6SokvWIwrF+ufhLNf6qbIRMN+Yh9uMOHwUlRR0XAl/L6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7f5aKLa; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b67684e2904so3281416a12.2
        for <bpf@vger.kernel.org>; Mon, 03 Nov 2025 09:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762191271; x=1762796071; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TyeY+bEWbSTlhOjrrlK8/D9Epm1DbcEpnj1aw1ylW08=;
        b=A7f5aKLaSCaA16xScnQdWmTj0+CDS42mahwwSI6QnSlgtJ2Yj28sZS4DJsBzwHtEvn
         +UW5+YW7MeGNXdX+FHdNskaqKNwIHSvC+Vt+XvOg7MUCAAWshTzQ9XsXcwsER520deMY
         mYJ9yC52+yHW+iDrGfuJXJpiEJENYXbV5dxONODAQgDG5tbYfM76roFmiCMbykAZUUHH
         OOO6g8wogW7CWu260lWsRFWoDM9K77goFc0MpKqFawcxNMsYPvEDWOVKHf+ShMFj7uSf
         n7V5ZsCSW7I4L2tJGQj69/5xmWctIQUl4OQBlhUC3d2iEAYgRtcRsImJ2lISwlP0UB5f
         cu3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762191271; x=1762796071;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TyeY+bEWbSTlhOjrrlK8/D9Epm1DbcEpnj1aw1ylW08=;
        b=kKncN9Xc6D2h+2dX+effvODBm6q+3HnWKHeHu2v/EDtPiZeyxhjI3hx9/GF+KdcKL7
         ZrCWQZbPaIHxv5T6oC7HRKqK+wBGp89BEYwGMgLAikPZpMgH6JEulUVmnSRv8ZiBZ0aa
         NlM2OKCK5X7xJg1t3cN8AOBMEBDkSZG+UGPK5dDpDE6XJUxVQfl6aY3Y9LyFx/MS+8tj
         p066daeA0Tl95GEunhXT2D67tJxsQ87RR6RbkEOw8mLA4lxPYeZQz856OFATL7vOhesL
         YrGY6/M5lThSYeDwiRG3T9OtDF0dqjGZiPZ96x1uNIfzTGt0DlEcBgIex7yc6A3tof7v
         h1IQ==
X-Gm-Message-State: AOJu0YypPcRWulxtxEjToW/JutfSqenshzxSka2qOzvS17wXXwSaRKWW
	m+FppEiSRKPi4UpKTMoRc4awGCw12Iq5DSZa8iEpnw/TP6udk6In9Jpf
X-Gm-Gg: ASbGncvhBFLkssMIeTxPuCszj71VX90xoGFhiDCQZI7LiXFLJ4CB86+7J6tuh9it6cc
	EqfKU3baUWQhgs9U7olsVC0SD5Wg1Wdc1kUCsTN6zj+3Ty6zToNRUlZvaBLJcp8r/TvCZdefHRV
	yPg3jdxH9LrnZ5+ZwiXKflP5Jhc4lAwa+IlSlg/Nk0m7Np3S0HgcFrWKrIlmhQ7aZzwSUrBM2LG
	UqA7cDaavadIquGtk0NJvxiZPk6fy2SQmQMzaV5V1fCGwX4Pb/4ieqCGH9M6kf6u7o8TWBH/JKS
	uAbWiclpqvy0AO51+yfrv8QAZvsd+Gbib0PLX/mDNoKsRQ36nQE/0dSWDx1YoZTUaa2Adg1d2rU
	LvpmvpHG4riFa996MowkKEO/DXQdbJhzfNWu5ONavIlfO9wi3yIuixWeRW4g1ahH6k3yoLUgVHW
	eronvDTK1jb3i5N9HbbNVwyIZVVA==
X-Google-Smtp-Source: AGHT+IF1+2Q0SRzZyPTgJi8RXkawpG+glFb5bP6bRLaAUyVeno+rC/Y5OI42V7Y/WIo6Ip14i+QrcA==
X-Received: by 2002:a17:902:e54c:b0:295:32ea:4cf6 with SMTP id d9443c01a7336-29532ea4fa8mr152898015ad.5.1762191271344;
        Mon, 03 Nov 2025 09:34:31 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:3eb6:963c:67a2:5992? ([2620:10d:c090:500::5:d721])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2955a5cfc12sm89961975ad.70.2025.11.03.09.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 09:34:30 -0800 (PST)
Message-ID: <c6fdb21818f04bad1235aa1987db0b53aed070ee.camel@gmail.com>
Subject: Re: [PATCH bpf] bpf: tail calls do not modify packet data
From: Eduard Zingerman <eddyz87@gmail.com>
To: "Teichmann, Martin" <martin.teichmann@xfel.eu>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org
Date: Mon, 03 Nov 2025 09:34:29 -0800
In-Reply-To: <1564653446.19948617.1762160169008.JavaMail.zimbra@xfel.eu>
References: <20251029105828.1488347-1-martin.teichmann@xfel.eu>
	 <ec29fa64723036f672afd18686454d02857ea4e9.camel@gmail.com>
	 <1564653446.19948617.1762160169008.JavaMail.zimbra@xfel.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-11-03 at 09:56 +0100, Teichmann, Martin wrote:
> Dear Eduard,
>=20
> thanks for the review!
>=20
> > I don't think this is safe to do, consider the following example:
> >=20
> >  main:
> >    p =3D pkt
> >    foo()
> >    use p
> >=20
> >  foo: // assume that 'foo' is a static function (local subprogram)
> >    if (something) do tail call
> >    don't modify packet data
>=20
> You are absolutely right, this would not work. This should actually
> be covered by tests... I'll write a test. I also already have an
> idea how to fix also this problem, and will come back to you once
> I'm done.
>=20
> > Alexei vaguely remembers discussion about using decl_tag's to mark
> > maps containing programs that don't modify packet pointers.
>=20
> I am actually against that, I think this would be the wrong way to
> go. In my use case, I have written a dispatcher for packets that
> tail call other programs depending on the content of the packet
> processed. These programs do change during runtime.
>
> Until now I had no restrictions on those programs, they could modify
> the packet or not, as they wished, as the code does not return at
> all anyways. Tagging the programs would only limit their usefulness,
> without giving any benefits.

The idea behind annotation was that map without annotation would only
allow programs that do not modify packet data as values, while map
with annotation would allow programs that do modify and those that
don't. So, for your use-case it would be sufficient to add annotations
to the map.

But really, I don't see that many options on the table:
a. Be conservative and assume that every tail call modifies packed data.
b. Use map annotations as described above.
c. Assume that the map is pre-filled before main program verification
   and infer the "allows packet modifying programs" property from
   programs already there, after which seal the property.

What do you suggest?

