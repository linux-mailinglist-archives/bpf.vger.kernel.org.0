Return-Path: <bpf+bounces-32635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 210669112A2
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 21:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BF60B21762
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 19:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD5E1B5814;
	Thu, 20 Jun 2024 19:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="aiNOXI64"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D77D3D575
	for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 19:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718913504; cv=none; b=SOZjJJus0R/6JIu8QCihg4cJCrG/r+ustvVVBRy0rQoD1Gycr48L7wrzf8cK8P+ACpPgR6T5Dv6yBo+pSWhz8cxo0dlmFxwL5e+eXrrGveLCXJXmPDdTt0YNgrZqwgWUNMBW5snWx/JVGMCb8sOUkEHcDLmfCSbH8SuRwDjmWgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718913504; c=relaxed/simple;
	bh=Potmkm6voPBPNzxgXsmvsfZc4MiOJ8b/TbfuwlrA33c=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=FhhKXXOIUZIzrGe4Eajz6BS06N+F/TH5ffeQnltArmN5b4J9XhxJkUmk0CRPSmmKDNsWFuf+CtDVgGW++2RxvWCvJLITisXs/USrPY6mywMk4X4vQSd28okeU44r0egJaBXIgF7B7vBw/4gyRwLxxfzYxEeGkLtU/LiYvc95+84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=aiNOXI64; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-633629c3471so13096567b3.1
        for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 12:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1718913502; x=1719518302; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zcvZYLOScb+/oW3/WVg/h2Scd9FY9aOUmiQFOB/rav8=;
        b=aiNOXI64MsbY5LQoDRRrvEG+W2cLto56YO1JqbGTeYgLXvfizaUCSZNCD4V0DrpEtu
         AF24mvXVzN9q2IG+ZSsswegw3uK6e0MewuW7xcyFeDxIQnkZSLslMqJgboTZ/bU0uKOB
         EkqKTUucchongP249/UnImoa0MZHeF5Lu8EoY9nZdsCJMEnuUQO/uidAvIBfrPkwUvNU
         eFmdWRQgAEzbv4Ds3h9v64C7vijaULkmSGOI6t1MdjOai7vujlzYIGwv4eSr4pHQEBn4
         1cuf+O0E5UQrD3d8b+oc3VHbggN5Uq1+P/AExJac0J7X2XLaRKfocEEOQenYmj157RiJ
         uSrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718913502; x=1719518302;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zcvZYLOScb+/oW3/WVg/h2Scd9FY9aOUmiQFOB/rav8=;
        b=v7Gy2d7tvjMTZOKOfs3awhjDwwnB3npuv3zFpWK3gvlw+ZAA5ggos8witphMN6BZSs
         aDwRtLD1VtZQNfBFkDhQDde00iGHZeKc5mRq8zVtDIYZfV3MMUYe4ZLHD0Mu2qhlffDL
         sAm6goKQrroLeZFbSXLxXIQBmn/g++atRDHSLIIgAoHh/N9b3et1TVThZEnaOrtoKF6c
         IjFUil4iTAQEcKUOF2vc9FtZA/vMop06IMgzA2xZuPTNIVJGccYaTIvurWDVTbSN91dN
         9JZiwlTIdH69qaicJ8aiASCJkcj9/H4DHGmvwCfH/WTQpBQWHt+A+FJHcsy2Pe5MC2P2
         N3pg==
X-Forwarded-Encrypted: i=1; AJvYcCWqD2Jugoz7BNFdWV5IuYfCP6nVdGzcEQTSlgiTepk+mvs1VCXApArx32lJmvGGo34ZWpRidsNvW/0omk/uM1u8TV+0
X-Gm-Message-State: AOJu0YydnNytuIwJdD3x9DfhOuDp5vXDlbw1k1Ip9i98e8xoHIb7XY71
	c2VTYq3myVJ0OI499Q3l9mXUvp2BjpqueLcH/ZkR85Nfvb0yPvsX
X-Google-Smtp-Source: AGHT+IGJq4cY0j8YwGaRz0X6OJ5+wPEuke1d7oG1DHMJqKedr89nqQFYGg8juiMCl0/7/gGkyylGUg==
X-Received: by 2002:a0d:c1c2:0:b0:627:778f:b0a8 with SMTP id 00721157ae682-63a8fddc0a0mr66997317b3.42.1718913501931;
        Thu, 20 Jun 2024 12:58:21 -0700 (PDT)
Received: from ArmidaleLaptop ([2600:381:bf1c:7784:eca4:cc56:8003:c9fb])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-63f154d5df7sm303737b3.107.2024.06.20.12.58.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2024 12:58:21 -0700 (PDT)
From: Dave Thaler <dthaler1968@googlemail.com>
X-Google-Original-From: "Dave Thaler" <dthaler1968@gmail.com>
To: =?utf-8?Q?'=C3=89ric_Vyncke'?= <evyncke@cisco.com>,
	<gunter.van_de_velde@nokia.com>
Cc: <draft-ietf-bpf-isa@ietf.org>,
	<bpf-chairs@ietf.org>,
	<bpf@ietf.org>,
	<void@manifault.com>,
	<bpf@vger.kernel.org>
References: <171811793126.62184.9537540105321678706@ietfa.amsl.com>
In-Reply-To: <171811793126.62184.9537540105321678706@ietfa.amsl.com>
Subject: =?utf-8?Q?BPF/eBPF_non-acronym_feedback_fr?=
	=?utf-8?Q?om_Gunter_Van_de_Velde_and_=C3=89ric_?=
	=?utf-8?Q?Vyncke?=
Date: Thu, 20 Jun 2024 12:58:16 -0700
Message-ID: <1b3301dac34c$3347df50$99d79df0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdrDTCZXKUDNVTXeTPW8fVu0QvWxug==
Content-Language: en-us

Gunter Van de Velde, RTG AD, wrote:
> > 12 eBPF (which is no longer an acronym for anything), also commonly
>
> I assumed that 'e' was for 'extended' and that BPF stands for 'BSD =
Packet
> Filter' originally described and specified in a paper titled "The BSD
> Packet Filter: A New Architecture for User-level Packet Capture" by
> Steven McCanne and Van Jacobson, presented at the 1993 Winter
> USENIX Conference. This paper introduced the BPF architecture, which
> was designed for efficient packet filtering and capture.
>
> Hence a bit surprised why the first words of the first line in
> the first paragraph of the draft abstract suggest that its
> not an acronym?

=C3=89ric Vyncke wrote:=20
> =C3=89ric Vyncke has entered the following ballot position for
> draft-ietf-bpf-isa-03: Yes
>=20
> When responding, please keep the subject line intact and reply to all =
email addresses
> included in the To and CC lines. (Feel free to cut this introductory =
paragraph,
> however.)
>=20
>=20
> Please refer to =
https://www.ietf.org/about/groups/iesg/statements/handling-ballot-
> positions/
> for more information about how to handle DISCUSS and COMMENT =
positions.
>=20
>=20
> The document, along with other ballot positions, can be found here:
> https://datatracker.ietf.org/doc/draft-ietf-bpf-isa/
>=20
>=20
>=20
> ----------------------------------------------------------------------
> COMMENT:
> ----------------------------------------------------------------------
>=20
> Nice document, easy to read and understand and the shepherd's write-up
> companion is also clear.
>=20
> Just two COMMENTs (no need to reply, but replies will be appreciated):
>=20
> 1) like Gunter, having an expansion to "eBPF is related or is the =
successor of
> extended Berkeley Packet Filter" would comfort the readers about what =
they are
> reading.

The existing text is derived from what is at =
https://ebpf.io/what-is-ebpf/
and a much longer exposition would be more appropriate for a different =
document on the WG charter ("[I] an architecture and framework =
document").

However, https://ebpf.io/what-is-ebpf/#what-do-ebpf-and-bpf-stand-for =
does have the FAQ answer for "What do eBPF and BPF stand for?":

> BPF originally stood for Berkeley Packet Filter, but now that eBPF
> (extended BPF) can do so much more than packet filtering, the acronym
> no longer makes sense. eBPF is now considered a standalone term that
> doesn=E2=80=99t stand for anything. In the Linux source code, the term =
BPF
> persists, and in tooling and in documentation, the terms BPF and eBPF
> are generally used interchangeably. The original BPF is sometimes
> referred to as cBPF (classic BPF) to distinguish it from eBPF.

That paragraph, or some variation of it, would in my opinion be =
appropriate
in the architecture/ framework document, but do we really want it in =
*every*
other document from the WG?  That would seem needlessly redundant to me.

There are plenty of examples in the world of things that started as =
acronyms
and no longer stand for anything and so are not expanded (AT&T,
NPR, CBS, 3M, SOS, etc.)   See
http://blog.writeathome.com/index.php/2013/10/12-initials-that-stand-for-=
nothing/
for one of many articles with a list of such terms, but web searches =
will turn
up plenty of other references.

Trying to explain in every news article that uses
one of those terms what it originally stood for but doesn't any more, =
doesn't
seem particularly helpful to me and certainly isn't commonly done.

Dave


