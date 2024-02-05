Return-Path: <bpf+bounces-21232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5338849DEE
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 16:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CE36283E2E
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 15:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A002B2D047;
	Mon,  5 Feb 2024 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="JiGWQyuB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="ZENORk08"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7536D3A1A6
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707146594; cv=none; b=JQoDFDP34KEMYdLV6DLeJEXWz+L8qOoIVCAW0ZVXJPDibair+94cr8uq5tM89xuuqeSYkSPIXXWLfXhflbxTQk5LeYDDO6FT8wBSSiFKI8WVPpT39sdsCwB1AmFBJ/hCs5jZvkCUzMQsAHppWEUqH6cQ6GfC3m/YopamLrVoIpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707146594; c=relaxed/simple;
	bh=5Mr/C/0onvMRCoRMTA0mQqCkiqLCOgVCKVptJS3UEXo=;
	h=Date:From:To:Cc:Message-ID:References:MIME-Version:In-Reply-To:
	 Subject:Content-Type; b=iBWX6HOxcVOPJaTxtDxraN0Be1ceYZwibZLvpO46H6V2WsH2/pnRA9TRjviOZoJctqsUGFruKiHtkUzmX6db6sBuin7c2iLIgufPfoT81oIFDOgnNxXcGU+M6hUDr1gsxNMRzUd+rXMjjXqtiJPGJ7dcHTh4+zGD9Oe6arydZ0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=JiGWQyuB; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=ZENORk08; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 0FA26C18DB8E
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 07:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1707146586; bh=5Mr/C/0onvMRCoRMTA0mQqCkiqLCOgVCKVptJS3UEXo=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=JiGWQyuBZqjGS7UguYUwW1nD9In/lEg6NZF5h6GacQYa+GMvY7GBkIsCwXWRlCT5B
	 ISnCZi8j98voKhpfTTjFPfGDcDXbtgsDKSqB0AdM9EW90QuU85V7Wgl011oWh9EhTc
	 BDmEIfp99ttEyG5oKah/EsFcPifId/GTl7UV9FDg=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Feb  5 07:23:05 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id A51FAC1519AA;
	Mon,  5 Feb 2024 07:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1707146585; bh=5Mr/C/0onvMRCoRMTA0mQqCkiqLCOgVCKVptJS3UEXo=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=ZENORk08wef2cILkL0dtYgsVLOmmkBTe00WintPuvt7uE6NY3QjqsZBITayQhHSFP
	 T05UzagoOrcwwp9J7WQguCZoux+4YG+03QvuKoFhA4NiXZq1JXcH/NKl8nBMxT7BCT
	 RtVUqklkIE15/ir2pt92tMwuTW8j0E7x1UviMpT4=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id C18D3C15155C
 for <bpf@ietfa.amsl.com>; Mon,  5 Feb 2024 07:23:04 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.41
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kcCOacSUpV9k for <bpf@ietfa.amsl.com>;
 Mon,  5 Feb 2024 07:23:01 -0800 (PST)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com
 [209.85.167.181])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id A1036C165518
 for <bpf@ietf.org>; Mon,  5 Feb 2024 07:23:01 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id
 5614622812f47-3be61772d9aso2260694b6e.3
 for <bpf@ietf.org>; Mon, 05 Feb 2024 07:23:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707146581; x=1707751381;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c3+dls/bzKewWIrGbJpibIVsaZdK1iKYO/C+lKISuzs=;
 b=mDsGw+BCQ+x4fhKc96hlrSbX5bWr7979H7SbJB45BWxnXvdFHmW/OdruUawnGyuTYi
 vao8PLnwyPlcJICNaLcxEPK3TWddyaHeSq5qwzyYhpxZBJe/OdUcT+FL5/thO6AnPY0G
 AwqXgv+BzmBqJ6LDMTmh70doj6dvOSdTsU4J5US3sD2tDsEw0wzWmVVAY3haW0FJu3BU
 ss/epaJpHsfUCXvGpGH0E7JJypfQ33y0Czi859LAYTuV1ycYZUjaN9nzwxHVE1S2mNAo
 O4BeZm+g0tnjo1vXwNrbAtDx4TQlPpRIZDnFpjv5gU8veiCc6KcNdPM/VBKjPZBAe1mO
 1THw==
X-Gm-Message-State: AOJu0YzTMnmTsrYOHuvp+eAygYYH8xY7v7THlW64uKacVjre61brSQYh
 y6lJUXWa7KI6DcI+b9AZ8DSTkr+xm3S1aMuKv/tn8vD4f5XB1KreGkRlz6IDXN6iQQ==
X-Google-Smtp-Source: AGHT+IEKGBtEj8MreTL4qOJQyUHRGIerDOT7LnpJGW+IyUyWbPvQnl6vDKAwru+1glUcet/kMCTWHg==
X-Received: by 2002:a05:6359:4598:b0:176:9bfd:d092 with SMTP id
 no24-20020a056359459800b001769bfdd092mr120077rwb.18.1707146580707; 
 Mon, 05 Feb 2024 07:23:00 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWbfTYQo13makG7kMuHNSbLOjmTH/dSot1/y9LGiv7gyeRzzU9EH+9Lp9kXZxV/43osNeRii9pD+FNq9Mx+Yk6v71TF
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
 by smtp.gmail.com with ESMTPSA id
 w9-20020ae9e509000000b007856ed8ff83sm28853qkf.45.2024.02.05.07.22.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 07:23:00 -0800 (PST)
Date: Mon, 5 Feb 2024 09:22:57 -0600
From: David Vernet <void@manifault.com>
To: dthaler1968=40googlemail.com@dmarc.ietf.org
Cc: bpf@ietf.org, bpf@vger.kernel.org
Message-ID: <20240205152257.GG120243@maniforge>
References: <00f801da565a$7e999250$7bccb6f0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <00f801da565a$7e999250$7bccb6f0$@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/S_W_Gg4ahWj1Om6_yrUoJ__vNWQ>
Subject: Re: [Bpf] ISA: do individual instructions still need their own IANA
 status?
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============7732348929276628755=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


--===============7732348929276628755==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m+H6bO6gQwMkhEk8"
Content-Disposition: inline


--m+H6bO6gQwMkhEk8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2024 at 08:36:02PM -0800, dthaler1968=3D40googlemail.com@dm=
arc.ietf.org wrote:
> Previously (draft -00) we said that each instruction would have a
> status of Permanent, Provisional, or Historical in the IANA registry.
>
> However, we now have conformance groups about to be merged into the
> ISA doc, and at IETF 118 we discussed having each conformance group
> have a status of Permanent, Provisional, or Historical.  That is, it
> makes sense for the status to be at the granularity of conformance
> group since one should implement all instructions in a conformance
> group together.
>
> As a result I now believe that each individual instruction no longer
> needs its own status since it can be derived from the status of the
> conformance group(s) it belongs to.  So in the IANA Considerations
> section, I plan to remove "status"
>
> from the list of fields in the instruction sub-registry and ONLY have
> "status" in the list of fields for the conformance group
> sub-registry).
>=20
> Let me know if anyone has a good reason to keep it per-instruction.

No objection from me. AFAICT this matches what RISC-V does, which again
seems reasonable to emulate.

Thanks,
David

--m+H6bO6gQwMkhEk8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZcD9UQAKCRBZ5LhpZcTz
ZPrzAPwMBv0Cb9WrqIecLSKWg9mhx4jH7gApoA69JoxovlKxxgD+PqrTleFtAu7T
oKv71pm6aEF2cOG6NjY20GpoI5R8vgU=
=H6gV
-----END PGP SIGNATURE-----

--m+H6bO6gQwMkhEk8--


--===============7732348929276628755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============7732348929276628755==--


