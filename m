Return-Path: <bpf+bounces-63491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7217AB08001
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 23:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5F8189ACC1
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 21:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAD1290BA5;
	Wed, 16 Jul 2025 21:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bw2f3qS+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905552C3756;
	Wed, 16 Jul 2025 21:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752702749; cv=none; b=aNagisK4NgUfCb1Zya+/NpwB1P8FaeJVCVqHF+JtHKIlyySAKvXJDRcSfzX026Ni10P6jE8tGmeRJvvX8MRnpxlIAqtargOW/8CAUQx9nBWvOYvGmUk48FQ0LCx3WOPO2akuk4m3iqf65709WXMf1Jg3KxSmhz1ZEBOAMVcDokQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752702749; c=relaxed/simple;
	bh=pu5kG1T/KMVVcdlrXVbtqFQEUAofawxyACSzem6mCDg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YYXDZfHzuNG1biwNCajfRuGgN7D8Q0TLuK21+VS6Glr2xnPZHMfVuwcmjk9pV4kpUek01jzxw82qnnPiNhWm/aHxibIx7nhtYbOY+ajh7gUTpT6CPv2uKKB+Iz+0a8y+oaagbABoEbuSO0avCdfmXkE65OkELnIn02TH2eaX9ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bw2f3qS+; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-234bfe37cccso2467875ad.0;
        Wed, 16 Jul 2025 14:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752702747; x=1753307547; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQQuwwE2RTOzruEBZJqUH9P3+HUt1hu98+FDJ+WmXg0=;
        b=Bw2f3qS++WPFTgHNE6chn+6Drql1uABgA+nMYFtwAYLG9vRYOteP0XHlA9P+jWEKNi
         PHACqyXPLbzywkrHmDavGk0ArfgvUVtsieYznBvBvAFPWs9p05n5vi7aqq1KeWWjf4M9
         sfvHheEBXoo+cIFCVGCMVC7WBI0h93NYlsX8AuEFyWbncyWnqM0NCvwqAFpYKjiaIeby
         oZKqxEQvLHNXt4l1uiyKGgbJz0p0MKixXMyOhx0ag/xo77GnPT2t1al1LzuXaVLM64mK
         8f7eLxwKhZ6Fv5K3f67G70GGoTu+8L1dc7xaH0DuHXov5hIfm+JCMuFsVSTpTwCoD8+l
         lGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752702747; x=1753307547;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IQQuwwE2RTOzruEBZJqUH9P3+HUt1hu98+FDJ+WmXg0=;
        b=l5bFurok3uzZlOZAB6TSzUYtyI360R1YHtji8WST262+8oN6WBJIEWYcudZ4NG6lQL
         KzL1aTE/gitNn+b/mSWIfLsbc7YUpUrzbCormeYYlrrZjwPGZb3GRClVE7lS+sbAhrPE
         2CThyXus+2JA2w4BgESyflRKEc6QCDOJ6iBqKIW5QnfMsKcL80rQ4VSDWIw6w3nfiBQn
         CfLtRlPc0Gawv/AJ3PF1mBNZUDm7CozNNcHMjrwFBMsQWuM2X1MI63cEV6XwuW6deKCH
         dAxIs87lozJPKaDybwXyfX/ql/DsJJ3eLuDXbkhZC6u8Rv5C3xalfl84Oc1tSM1lI6/p
         iOzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHWinb+wqoku6KJ0+o0p52VulbL1EwOwPz+tmDiBiGtslmMUH5HARLRwNWDTBUGBFYw9dNstCjEg==@vger.kernel.org, AJvYcCXPYDgbGZvGNG//TPPF5PDf+GQLguVRANflnZv5pDwKckdxJXOmrs7VY9WQNuczQDMtfBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRC4hg02gYG66Gifv3k09orIAXOj0luzn2Kj4UohjKlSoRIRWx
	p3QeFfEOCQwhvCshjHgdd45G4BJzeLsF+td+ezrFyfgnLqb963PX9wxPLi3UfM8v
X-Gm-Gg: ASbGncsXfN3695M6WWIvqsts9AnQjZxPlkJdMtt9zMCbeUsnrI792k8xPtrbkeGnFfn
	7hWaVKuf/areD0pcPx+noCq7VPZCVpVsjTSYV1xJWfYphPFP5OpL8l784SmsVgBN2nDLu6Hv2cr
	CIj1NaVd0akrxWADyv2ZFYlOGohzFH9TfzAspSip6qqZEOBHXM3XCUeQWHMzCfz7iSe0TJLx6sY
	32hkOmszcXOSQFts+ZLLKVCNMsEBIwbEvZzpVsH3+J7wnmna7OUWR9btTL/I+kJRjbaR0Au372m
	mbeFTDziaynhdfJXcBkSocXPVAIt/ptu7AYIZcTnL88qeIGT7iyNPhIoXNumJo7ij09HlxVl8Mr
	mj2uoPD0dNPpeww1pNGMgXkZ2uabx6WeO6NY3qANHK2oA9g==
X-Google-Smtp-Source: AGHT+IGI3dSE2IEO7zVRyWtpNmo1U2v7SD0Fl9HmadQqU5ee2gv/cL0gwngR7Ib77+Gfd37697eb4w==
X-Received: by 2002:a17:902:f68e:b0:234:c549:d9dd with SMTP id d9443c01a7336-23e24f70b21mr67377665ad.48.1752702746711;
        Wed, 16 Jul 2025 14:52:26 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:a02:8860:a96d:e9f4? ([2620:10d:c090:500::5:8a60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ad406sm137394605ad.69.2025.07.16.14.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 14:52:26 -0700 (PDT)
Message-ID: <5fdc2316c63b27d768503f056771ad6a77c803b3.camel@gmail.com>
Subject: Re: Linking BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Nick Alcock <nick.alcock@oracle.com>, dwarves <dwarves@vger.kernel.org>,
  bpf <bpf@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com,
 alan.maguire@oracle.com, 	stephen.brennan@oracle.com,
 jose.marchesi@oracle.com, david.faust@oracle.com, 
	elena.zannoni@oracle.com, bruce.mcculloch@oracle.com
Date: Wed, 16 Jul 2025 14:52:24 -0700
In-Reply-To: <87bjpkmak2.fsf@esperi.org.uk>
References: <87bjpkmak2.fsf@esperi.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-07-16 at 16:15 +0100, Nick Alcock wrote:

[...]

>  - So... a third option, which is probably the most BTFish because it's
>    something BTF already does, in a sense: put everything in one section,
>    call it .BTF or .BTFA or whatever, and make that section an archive of
>    named BTF members, and then stuff however many BTF outputs the
>    deduplication generates (or none, if we're just stuffing inputs into
>    outputs without dedupping) into archive members.
>=20
> So, here's a possibility which seems to provide the latter option while
> still letting existing tools read the first member (likely vmlinux):
>=20
> The idea is that we add a *next member link field* in the BTF header, and=
 a
> name (a strtab offset).  The next member link field is an end-of-header-
> relative offset just like most of the other header fields, which chains B=
TF
> members together in a linked list:
>=20
> parent     BTF
>             |
>             v
> children   BTF -> BTF -> BTF -> ... -> BTF
>=20
> The parent is always first in the list.

Hi Nick,

You are talking about BTF section embedded in a final vmlinux binary, right=
?
Could you please elaborate a bit on why do you need multiple members
within this section (in the context of your third option)?
I re-read the email but don't get it :(

[...]

