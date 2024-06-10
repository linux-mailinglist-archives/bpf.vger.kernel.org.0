Return-Path: <bpf+bounces-31700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E48901C33
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 09:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99BC01C21C9D
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 07:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3AF2D05D;
	Mon, 10 Jun 2024 07:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bizgrowth.pl header.i=@bizgrowth.pl header.b="oscp58HU"
X-Original-To: bpf@vger.kernel.org
Received: from mail.bizgrowth.pl (mail.bizgrowth.pl [162.19.246.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612F52CCB7
	for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 07:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.19.246.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718006236; cv=none; b=U/FptBf7E5YSey8M4gVW1yaVmgQU2HvxpAdRhv/F1Ts3xCg7bVKVNbu7NpThoiiM+LyyYN2IgiX2n4PEA8iYrz2uOEkWIX2KJO34JXQ7pEjP7bajOxVSUb/DbEW32aI8Nvi7gYihuOnvAeQ5d9adxDvAxjkTIYdWWXBzgPNMjBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718006236; c=relaxed/simple;
	bh=cVP7OlBRTQnmgUtVnXVsWTNB9E3+yUvyHaP6Jl2bQWk=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=gMa/swqDio+wosiG7xPXcZcUsK5Hu48IeYyyyfB1WtUTijzEqbNfxHE8zEgIrdlqpftNiFJ6iToPnn/Y43Dk8qrzkG/A63Hd6214Igb4WVwVNaVQ5jlilU4xwQqo4XBi+aCacwbnrYy1G9RJYqL/ANt49lTkleasBNnKIqh91U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bizgrowth.pl; spf=pass smtp.mailfrom=bizgrowth.pl; dkim=pass (2048-bit key) header.d=bizgrowth.pl header.i=@bizgrowth.pl header.b=oscp58HU; arc=none smtp.client-ip=162.19.246.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bizgrowth.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bizgrowth.pl
Received: by mail.bizgrowth.pl (Postfix, from userid 1002)
	id 1CE4E2176B; Mon, 10 Jun 2024 07:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bizgrowth.pl; s=mail;
	t=1718005868; bh=cVP7OlBRTQnmgUtVnXVsWTNB9E3+yUvyHaP6Jl2bQWk=;
	h=Date:From:To:Subject:From;
	b=oscp58HUTXPUUPgbhgj0x3SiV3mhiFdtskpGWUD+twb0ghtybiiBVaCiFIpdcrsQ5
	 9ccDSxkyDVIdRZb5wTjqy9W5wuCJCWax5grNbMV0QvYLwQZ2MnkBznF3jwbqVSkwEn
	 7x+VP3ZiiJMliFqUIADcab8Dma7o7ydqbiFy5XRyY3vgSB9rahkfkGnUrnSBWK5his
	 JtJDIRIAINH7tm8W8wG2hkKJHpf5s3JPpmrKKsX0rd4utkIGr4jLUJ2WB1vVZoEdiA
	 1xJsDd2/cSXgmc2B+O4UYn0lYw/8VpRbFfGh4arB3yr29P8a7n2C21dtRvAd13nlSb
	 vi7obpHW3OI7g==
Received: by mail.bizgrowth.pl for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 07:50:45 GMT
Message-ID: <20240610064500-0.1.d.l10.0.0331nn790l@bizgrowth.pl>
Date: Mon, 10 Jun 2024 07:50:45 GMT
From: =?UTF-8?Q?"Bart=C5=82omiej_Gabrych"?= <bartlomiej.gabrych@bizgrowth.pl>
To: <bpf@vger.kernel.org>
Subject: Meble metalowe
X-Mailer: mail.bizgrowth.pl
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Szanowni Pa=C5=84stwo,

je=C5=9Bli poszukuj=C4=85 Pa=C5=84stwo sprawdzonego producenta mebli, kt=C3=
=B3ry dostarczy niezawodne i estetyczne rozwi=C4=85zania trwa=C5=82e na l=
ata, to my=C5=9Bl=C4=99, =C5=BCe zainteresuje Pa=C5=84stwa nasza oferta.

Produkujemy metalowe szafy, szafy kartotekowe, szafy BHP, szafy na akta, =
rega=C5=82y, stoliki i krzes=C5=82a, kt=C3=B3re znajduj=C4=85 zastosowani=
e zar=C3=B3wno w plac=C3=B3wkach edukacyjnych, jednostkach publicznych, j=
ak i firmach.

Oferujemy konkurencyjne ceny, posiadamy r=C3=B3wnie=C5=BC niezb=C4=99dne =
certyfikaty jako=C5=9Bci, w tym Certyfikat ISO 9001:2001 oraz atesty PZH.

Nasze rozwi=C4=85zania zosta=C5=82y wybrane przez wiele firm i instytucji=
, w tym General Electric, OPEL, Ferrero Rocher, Rossmann, LG Electronics,=
 Sejm RP, ABW i wiele innych. Wsp=C3=B3=C5=82pracujemy z firmami, kt=C3=B3=
re potrzebuj=C4=85 min. 20 sztuk mebli.

Chcieliby Pa=C5=84stwo sprawdzi=C4=87, co mo=C5=BCemy zaproponowa=C4=87?


Pozdrawiam
Bart=C5=82omiej Gabrych

