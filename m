Return-Path: <bpf+bounces-32638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 094129112A9
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 21:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BD011C20BA8
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 19:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CE11B9AAD;
	Thu, 20 Jun 2024 19:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="QJoRRFeE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961994778C
	for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 19:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718913585; cv=none; b=amQ3SDIq/go8ileMe1+/7Bv7L8bivN0KyO7FMRkrommibVwYWprCfpEdNRU80dHIBRdElaJckYHjKOis5x7ASEXy6nhS+OgK6ur6HHnSjcERS1/JQbCJkPpEfFwhy+i5gc3fKai2tvHyCPeDrAzixW8bKlpdrpj5lASH4uugHz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718913585; c=relaxed/simple;
	bh=jS4KlPhX2mr+k621kXhV25BKIYGPIwXBb1WaeYkl9NE=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=e2cmQj80awnXglxhserb49AQtQSfnTlrhQ/rsQ9P5EyU2z04Ik73IgCSKU+3KbeJVualjsQLQh0h5FUO4XYad/O4RZxOumhOISF+1WvyZxpXu9YdS4F7+ILjgQkrZid0EegzkBwJ6uuRaWZK5iAvVxoLqN6kUeM5nqDKDbSr4kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=QJoRRFeE; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-63127fc434aso11180257b3.0
        for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 12:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1718913582; x=1719518382; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=s1gm4mrkLYYNsR1aNVEW8CLMsBv5dgCHIpVEZYhiuGs=;
        b=QJoRRFeEvUR+Jso92eXfK3Y8DYnZPjcau0gsxdHsTdDOxSqJCT4bBlcb+LZ8pVCbLb
         wZx3e1eqlM54Do8D41P9yPvP/wv4oIKgrGCBdt47kXBJmUex1frBpuEsi5jj+6z28//c
         GfURnm+SzQl76vFEFWsC7mKra0p32ojun4PQhDqZFjXqOxZTcTwz+q3hAsEVoyaCTv5X
         hVVG4xvuBP2ZHAkUIJxiUlsfqgroLePEkFemKVRWK4K1/rDKjWGR6AAucJ3XmcWdj0v6
         pJ5lvJVDqKME+tXfP1X3T+Bt9kWTs7P+RGz+8Sbyk2d+w/PnGXIIva48LsKnL4Jbw9DM
         HwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718913582; x=1719518382;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s1gm4mrkLYYNsR1aNVEW8CLMsBv5dgCHIpVEZYhiuGs=;
        b=hXX0CEz71TvA+ixpnnljqOcu7nVmzIvco09dr5fBlE3+F+QDB1qjgFb/SAEt4wKPNi
         lpwS/P02j8fKRqzgnf7T9ehRc1C90UW9B0evzfgSPHBDdjW2FiOktAKfIf7f2q+s7Ovn
         D93hOXQaZ4Sw7OdoKdRzbGIjxGwQ0A98c2mAq187ULy62UcNUCWhZ4nihQ8juqCXH4vJ
         iSJX+jCTBez5uqIr5d4qYy9Sqo0JGxWRLeqPtjNivpqsu7WyCg/2758h+jO6HG44udSX
         kLLugaeMgZ8ww/LvuzbCqDKFwwrd3PX05k9FyRme944CKtjxP2gNdVB+Oak8btlFBhJw
         IZFw==
X-Forwarded-Encrypted: i=1; AJvYcCVHyfp+XLxoyGW7qUN6j73z0H8ekN11pPIBt4YkDlPFMuxLWSPCo3dDPoGMhzga5cHNB59RVIvSq9tR02Yq8ySjOXx9
X-Gm-Message-State: AOJu0YxTT6zffZewnM4syjZfyvLVfbW1vALxTUg+EYuPjpJvm68QK/mI
	rFlezztDwVEZ4vYblFx3HcYV4PJkIAU0+gIsWeVSeS/cLcFfux1W
X-Google-Smtp-Source: AGHT+IEnCM7sTEOQc+HgbTvVTkTKj6uv4J1Fa4tZj8SS4EfpHnkwa29SXrCl0TJ/Ps4Ui+I7GnXDUw==
X-Received: by 2002:a0d:eb08:0:b0:62c:c660:72af with SMTP id 00721157ae682-63a8e0e3110mr65740137b3.24.1718913582421;
        Thu, 20 Jun 2024 12:59:42 -0700 (PDT)
Received: from ArmidaleLaptop ([2600:381:bf1c:7784:eca4:cc56:8003:c9fb])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-63f14a3cabfsm313327b3.88.2024.06.20.12.59.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2024 12:59:42 -0700 (PDT)
From: Dave Thaler <dthaler1968@googlemail.com>
X-Google-Original-From: "Dave Thaler" <dthaler1968@gmail.com>
To: =?utf-8?Q?'=C3=89ric_Vyncke'?= <evyncke@cisco.com>
Cc: <draft-ietf-bpf-isa@ietf.org>,
	<bpf-chairs@ietf.org>,
	<bpf@ietf.org>,
	<void@manifault.com>,
	<bpf@vger.kernel.org>
References: <171811793126.62184.9537540105321678706@ietfa.amsl.com>
In-Reply-To: <171811793126.62184.9537540105321678706@ietfa.amsl.com>
Subject: =?utf-8?Q?=C3=89ric_Vyncke's_feedback_on_bytesw?=
	=?utf-8?Q?ap_functions?=
Date: Thu, 20 Jun 2024 12:59:37 -0700
Message-ID: <1b3701dac34c$6337e7f0$29a7b7d0$@gmail.com>
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
Thread-Index: AdrDTFRuaKtttYUtSxCgO66OsWwKwQ==
Content-Language: en-us

=C3=89ric Vyncke wrote:=20
> 2) I find puzzling the absence of betoh16() in the presence of =
htobe16()
> functions.

Since the implementation is identical, I believe it wouldn't make sense =
to
use up another instruction with the same implementation. =20

Table 6 in section 4.2 uses the direction-agnostic description for TO_BE =
of
"convert between host byte order and big endian" which I think is good.
But then it says:

> {END, TO_BE, ALU} with 'imm' =3D 16/32/64 means:
>
> dst =3D htobe16(dst)
> dst =3D htobe32(dst)
> dst =3D htobe64(dst)

Where section 2.2 confusingly defines it as direction-specific as you =
noted:

> htobe16: Takes an unsigned 16-bit number in host-endian format and
> returns the equivalent number as an unsigned 16-bit number in =
big-endian format.

Whereas bswap16 is direction agnostic:
> bswap16: Takes an unsigned 16-bit number in either big- or =
little-endian format
> and returns the equivalent number with the same bit width but opposite =
endianness.

I think the right way to address your comment is to change 2.2 and =
perhaps
the function name to be direction agnostic and match the description in =
table 6.
For example:

* bebswap16: Takes an unsigned 16-bit number and converts it between =
host byte
order and big endian.  That is, on a big-endian platform the value is =
left unchanged
and on a little-endian platform the behavior is the same as bswap16.

Dave


