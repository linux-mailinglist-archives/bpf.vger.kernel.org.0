Return-Path: <bpf+bounces-56773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2A4A9D9A9
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 11:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 207583B17B7
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 09:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225E62512FA;
	Sat, 26 Apr 2025 09:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baMaB2TE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9D91C36;
	Sat, 26 Apr 2025 09:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745658883; cv=none; b=PfjN9q7+Sum2uGRPAsJKSXpZIl+Xd7//hrZHbb0KVZ6s7MugpcstRYqtuUspBi48q035F8r6JJUpKG4OsGPrkQ4VeWLPhw2vIPx9D4+LkwrpmXugqFv3RImBi/+jNFweQuSWKCJtfyXQUzCD1+741e6HV3i6UUTGUKs6ikimQFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745658883; c=relaxed/simple;
	bh=ajA2/KThvOLmdGQMQlMZ8JSc3s7TdqFCTO4mxSXZP2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWfBx05yVWw5DGWEceUyIj9Qe29A1yxv6ETxf+Z7Uc1qFsceOCmAoJDxEx0gM8CDt0P6HSY0izNe6/+xe5DE1jo88XmbRJNuhNAZjM8FU0vnlPDWLm31+TGbvtkpD68jO6FkyTlt5pjsw/9K0ygqu+O837fR94kJHoa5gaX2GFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baMaB2TE; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7376dd56eccso3383664b3a.0;
        Sat, 26 Apr 2025 02:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745658881; x=1746263681; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dpw6EJump0TSOrBYBam8lLy7cnOl6Tzi7s2IdyQv1Eo=;
        b=baMaB2TELWaNJ+72R5Y0/2CcMD+vTQDoO5alQ9SD7HHMjv8TEso9p6i5BZV3GoKmRz
         PW2/dD8d+Ab+8WNQEo3TqNUWg4Bd2m1PAqwY0QDBmMSbtXs7mWfYVvcILfXmN/NaC87R
         KUY+qKogKD4N40rQe+2G/GbS+ZRzMwe6rgkydDP8A+SkJ14hAbRYTvTuz1cmZ+8CfnS3
         KePlJoih4lDtBA9m8FbgABqn4RsIttUhhvmjGMrzHuL4NnvPTgXqu2x2wN3zbqUuJ2mQ
         tYonrB1gItZuNPs6pgrsXpBIcyDVia2FMradrNnFC6wBC3fc3nFwONC1dHAtV5hGz1Pt
         ffkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745658881; x=1746263681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dpw6EJump0TSOrBYBam8lLy7cnOl6Tzi7s2IdyQv1Eo=;
        b=LXD1xOUqjFHbItrm/xdFH5zVZJ8+St6JuaAJpGv1lUr1hIqJprvbJoAUpsLzUBlWrW
         3RZUQONwoQt5KeP2aIJCrrTqR/xvpHwQunZ3vSztZSNk1xN2Z3KEvgYesYBAlGMOAMdm
         2q+DS5UpzbwhT/H66OwqBQ1vyc2J/sqwgP+cmc90cuQ0jAipqfJlGrcv7LAJmoUumehO
         Gcs+SDRGoubh4MtxHVCmmCn3ALbchaSdByG8njuN6Av35/obvZQ1hecLkYGA3B3QINxN
         f40OG62+iJu+CE6//nnrYxFkN5SoPDBOAul5wfX/vP+ravajLk+/OQzXvBrkW8E0UGzg
         z89g==
X-Forwarded-Encrypted: i=1; AJvYcCUHmL3MRTyYH53zJFe/FhMjs8CZ5eH/cTRDHpJhh+zy+kRfrMQAJ/69rBJ9vcc0D/qCBQZcutkMITJDGTN4@vger.kernel.org, AJvYcCUO9jFbvNWjMknO+qYdcoau2GLV2IQ5vQm7lBUSPqvS6tLfV6OFY1PzdfIVZkyu8aaX5IcQvFgQ@vger.kernel.org, AJvYcCUmd4TUIeNWuF+Q2w3tLWqIPGamN2dNRcAvVHsA1sOhgBT2MW/U821B23VGxUmzCYjbK39wZmantsruUyc=@vger.kernel.org, AJvYcCV1wffdBc8IUd/bf/uNLA2GIG5CSBVcWe5c8tdaAvROagmS6uGGD3bFlR0Jd72P4vDcZSlKSE3AYoSVweQ=@vger.kernel.org, AJvYcCVGl+JkgkKgU8T8EmZcg2A0Nfx2z3yeX4V1HOyZGhb/rsUwgD/6MY45W7EPNEuHvWB0lIiYFkOdLvyEYiM8hto=@vger.kernel.org, AJvYcCVvn79c+RkbUr3SC5Xe6rPXRemTpf7Y/8O4c2YrBFF5T3/I1OeIX2N8gZS2Fpli2tFXIfw=@vger.kernel.org, AJvYcCW6g7RQE8FGKLeSdrXZTFQFx/6kCbL+5MhDOIaoUyofezzQHryrdnIyzwNmOCxPfoQFr9CaeabIhfLaz4sL@vger.kernel.org, AJvYcCXdna5tYEyZPZUZzQ4M+eDzjKLPKABxy2rus/XGxcZeF7mImgw/YGOO4DminwC3/1C9hzGA4qPNu0K7Vqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy19PXovEmwjPh5CceM33CLQCN9uRdvC0SFT0VY2UW3HXc9Wv1U
	3EiAP3D/inaCfGXiNNL3TeMeQTdth26A4Dk/mNO/e88ntO4da4hx
X-Gm-Gg: ASbGncvfkEqpBZOp6NmoidGmlOg/H6Alef5TOOMeFS3BhqEg/xm6stFwQ2Fg1o+sS6L
	0iaG4xBzrNjQIfmYgh92t1cwgCkf7ulfXo4SNev4FHsa+PckPQuhn6XMzabQ4AEKKgxDfYSJs+d
	jra33XU8hzClUiPmKKTENCxlfxMbG68/bzIyKntuQrsTtXVVOHOQc2u4b9ALYMLCbVYYF7kZ5lu
	gnaDC0PLj8/vYXRtHWCAqk6d9WsOWag2lXOE13yKzpDSN6IMUM3R8Or8VCLmP3qDraTaLl0WTLx
	aZvoZo4NF7Zt0yQ9PM7eRPrdvbPhZLEMylq4g8qjrInS2vljmT9FwKVfGnJ1iXHzdY8H
X-Google-Smtp-Source: AGHT+IFgnshRXYAm4vLgOrmgYGZWM8t1SObZHkSRdPxsGHvAJ5uKKQ60xC74a/vGxL92untQtleJTA==
X-Received: by 2002:a05:6a00:1306:b0:736:73ad:365b with SMTP id d2e1a72fcca58-73fd74c23c4mr7475320b3a.14.1745658881199;
        Sat, 26 Apr 2025 02:14:41 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e259412b2sm4594535b3a.66.2025.04.26.02.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 02:14:40 -0700 (PDT)
Date: Sat, 26 Apr 2025 17:14:29 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>, Yury Norov <yury.norov@gmail.com>
Cc: Yury Norov <yury.norov@gmail.com>, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	jk@ozlabs.org, joel@jms.id.au, eajames@linux.ibm.com,
	andrzej.hajda@intel.com, neil.armstrong@linaro.org,
	rfoss@kernel.org, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch, dmitry.torokhov@gmail.com, mchehab@kernel.org,
	awalls@md.metrocast.net, hverkuil@xs4all.nl,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	louis.peens@corigine.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	parthiban.veerasooran@microchip.com, arend.vanspriel@broadcom.com,
	johannes@sipsolutions.net, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, akpm@linux-foundation.org, jdelvare@suse.com,
	linux@roeck-us.net, alexandre.belloni@bootlin.com, pgaj@cadence.com,
	alistair@popple.id.au, linux@rasmusvillemoes.dk,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux-fsi@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
	linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
	oss-drivers@corigine.com, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com, linux-serial@vger.kernel.org,
	bpf@vger.kernel.org, jserv@ccns.ncku.edu.tw, Frank.Li@nxp.com,
	linux-hwmon@vger.kernel.org, linux-i3c@lists.infradead.org,
	david.laight.linux@gmail.com, andrew.cooper3@citrix.com,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH v4 00/13] Introduce parity_odd() and refactor redundant
 parity code
Message-ID: <aAyj9SMvYrN9tXZC@visitorckw-System-Product-Name>
References: <20250409154356.423512-1-visitorckw@gmail.com>
 <Z_amQp3gK5Dm8Qz3@yury>
 <Z/a5Qh/OeLT8JBS4@visitorckw-System-Product-Name>
 <Z_a9YpE46Xf8581l@yury>
 <e97a83a2-dabd-4dc3-b69a-840ca17d70b5@zytor.com>
 <Z/lEkDwefWvw4ZA3@visitorckw-System-Product-Name>
 <8571fd6f-4e71-4a6d-b2e8-16d9d72fa56e@zytor.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8571fd6f-4e71-4a6d-b2e8-16d9d72fa56e@zytor.com>

On Fri, Apr 25, 2025 at 12:33:21PM -0700, H. Peter Anvin wrote:
> On 4/11/25 09:34, Kuan-Wei Chiu wrote:
> > > 
> > > In either case, instead of packing the cascade into one function, make good
> > > use of it.
> > > 
> > > In the latter case, __builtin_constant_p() isn't necessary as it puts the
> > > onus on the architecture to separate out const and non-const cases, if it
> > > matters -- which it doesn't if the architecture simply wants to use
> > > __builtin_parity:
> > > 
> > > #define parity8(x)  ((bool) __builtin_parity((u8)(x)))
> > > #define parity16(x) ((bool) __builtin_parity((u16)(x)))
> > > #define parity32(x) ((bool) __builtin_parity((u32)(x)))
> > > #define parity64(x) ((bool) __builtin_parityll((u64)(x)))
> > > 
> > > As stated before, I don't really see that the parity function itself would
> > > be very suitable for a generic helper, but if it were to, then using the
> > > "standard" macro construct for it would seem to be the better option.
> > > 
> > > (And I would be very much in favor of not open-coding the helper everywhere
> > > but to macroize it; effectively creating a C++ template equivalent. It is
> > > out of scope for this project, though.)
> > > 
> > IIUC, you prefer using the parity8/16/32/64() interface with
> > __builtin_parity(), regardless of whether there are users on the hot
> > path?
> 
> As a per-architecture opt-in, yes.
> 
I'd prefer to see Yury agree first, otherwise there's a high risk of a
maintainer NAK after the next submission.

Regards,
Kuan-Wei

