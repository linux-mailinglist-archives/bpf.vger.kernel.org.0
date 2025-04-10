Return-Path: <bpf+bounces-55664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88945A8474D
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 17:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 611274A2D6A
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 15:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CCA1DEFE7;
	Thu, 10 Apr 2025 15:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amDTfSbD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C114A1DD0F2;
	Thu, 10 Apr 2025 15:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744297655; cv=none; b=WJpkS3pfTeWRpTZAWfQjJrFtQqpJ0y9644gItdMV7RYn15yFH4SycGf1MjUNkqvxQR0xlPOKC8a4QpNBiLAHUi+oYL3SD0orjsAUae1WdqjBGVoHFhQuQkW39E9QnrTIZPD+I7o0sLmxraTssnHjnmhpf42uHridDrF3m7SykkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744297655; c=relaxed/simple;
	bh=29zjlfK0mXnUdbnnsCXfS6Oi8Qrp5HNYmCj3Q7Up+6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFA8T5/E69kW2ox6TRFwZyRUP84kZPN1lVaB59MAnI4jQ2pRjrag3T/vyEpCa82OxjT1c1VYojosoK0TWZxB6FhZa+AQ/PDIXLHSjCRPQE0A5hIBaI/4Kn90cNLAZn6hjAjdD/p130JtWi7dentQLMFmZRoYNOHs9A13WxQjysc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amDTfSbD; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso925995b3a.2;
        Thu, 10 Apr 2025 08:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744297653; x=1744902453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3D5EegHjNXWtRqs7oVUZyDcWwG0k9rfQtFHn9dOK4Lo=;
        b=amDTfSbD53YThn8o+gHPCYOPaXb3ht5o+9iKLu1o8PGhl4GpZUUeanQNe27NLA8QqB
         O4WVra5EoYRlYnIuhpRllVhR8IRIqI/2JiLnhZm/D7QD0t8pCjCQpp+THJGEXWLj3Qg8
         OkZTXtaSwuzjyQZhtPFNBvEkOv5bBPo7Q9v+yFcMmjQfJwh1u8IC7aAyMvzgDUf4fiMp
         7u1kVUArdSUPogbagebUmlDBxKcr15uUCVS2BPetFHz11bXGdg9YCXx/OTyrqOJiXM2f
         +FS8Hr6MaSXRd4iikSg7hTTfnDZtHtKYwHBnK9FSzklkFdYGRDB9erLEXwDGwdwIdMkG
         qRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744297653; x=1744902453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3D5EegHjNXWtRqs7oVUZyDcWwG0k9rfQtFHn9dOK4Lo=;
        b=Rwbnt88uwAgdeZE/7/6ZPxWrmiAB5+XBCF5NxE64049+Lozqgcr8uVXedjUKTiVpCl
         7/G3uVjQCIkbzgiGOnXhBDH3jQ++xuadQueY9ox5UGiJlYAgSn8oxvLXGNnCjhqFfY2M
         GXiNQVCV9KvRKq5CyRE3d53loMR4aIEfIDdrwX02ZS1I+HguoxvLJPVGYF0I2FF3okCV
         SbjdvXaITe8fnK/BE7ipjTkJXWCz4R8PyGJXNTLRrLl9zbXhsl2t9wyQcqFi5iUmmL6v
         5kSiw49H0sRrRJjQIwOkpIJCWksNkEEyNSc+Q7hKwypqPZgr3y9t+sAsZw4V2j1X0j9o
         Tqxw==
X-Forwarded-Encrypted: i=1; AJvYcCUOXZc/jSHOaGYJZ8V9U3oGXV91M2rU7mUlsWvjjXce98piQd0KgaaUsC5biHt6u1HQBN/A8pnb6VxDFNo=@vger.kernel.org, AJvYcCUtV5dT5rk3w9GBdMX/eau0G0v3F2jG+O2VW4uINRyUHWb2/Qg+FS11+mJR7sfN3d+xvQlcQWErHRgozTlfyq8=@vger.kernel.org, AJvYcCUvp9CHFBXUToar8Pc6Id4+IT0PAhwXBfnNhDeCl1xFoyB4dxcVLqHm4aLo/UG47gAQlYi0LjO+YXmUJiA=@vger.kernel.org, AJvYcCV8/8EubvyJx+OkrdRqrgGX0xdbf6V4OtpPhaON/RaRLZNmVnf2dYSmy9bGeSKhweIGt+PAyUSQcNbZTvim@vger.kernel.org, AJvYcCVa6OSqmh4AqIVHFOKC7ASrcX+jCf4kOprby2u2Q8RyfNCU2+y5GVn5WnX7eE3t0ADQrZ9+HQWr@vger.kernel.org, AJvYcCWMEYGjekVzJ+XYFaYRw9Q5QiJsTdJBipT1nKrKqthRDzIVtwzuYVKiciVqSfyOGRYg8hXJEo4Gp35fuog=@vger.kernel.org, AJvYcCX40BhYTeD5D25GEcix4kPLNhNREHZW1Chb3JtiEzNqXXxqg8GGwYnJsKDx9tWWVm2q8es=@vger.kernel.org, AJvYcCXD8go/IeqNJ4ZtWOfTUg2nK00VdAJDxJI0jmEIhBI4ySF/0u3uVLOtFpbc2r0WUdfyu7aWoewHufQThMOm@vger.kernel.org
X-Gm-Message-State: AOJu0YxRNV0Ni7lrRayLQw40texyWx54h8br7248G9tHz1Eo4QJTICMS
	EQ8ftGmiZwLPqb/q4lG59kQEHuFQfZEj05olQCzA0nndfiHRnM6K
X-Gm-Gg: ASbGncsNSYc5k9RpBlkjv2zau/fW183kDN8nqJFcxJMoH4mXEQCezpJTmUtcGZrzaw6
	krbqntr0f3+7VEO4fKCLNbBkoU5Cd5ZjA1HMyicVMoRHaw496/VQo3aB5oCDM5WPeSSpMakN/rC
	iD8R5Knw8TmlxQYtOfQ9IlLVoeFug2RwuIPwRk3C0iLbegi4Q8zeKhZuq0uaglHklUf14BvKZVF
	bnZLEQdAHlj+QUidSeLqx/NDqKtwcE2pGaB8nsPa8AHe/EtqUfa2AM045i/cZoxTa8iVa30eRNW
	SvmP8diy5i4+3ZeAgQEXn7CeEmpSYNM1csAmLnzH
X-Google-Smtp-Source: AGHT+IFy1ewRYIQi2QM4ZSLkQhokapTj0gR7Ltj5GpPkDsZlOlyCTjP19Ec1IKFhcZrwo1l74Iw4rg==
X-Received: by 2002:a05:6a00:240a:b0:736:ab1d:83c4 with SMTP id d2e1a72fcca58-73bbec49f99mr4365817b3a.0.1744297652831;
        Thu, 10 Apr 2025 08:07:32 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1e51f1csm3501019b3a.145.2025.04.10.08.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 08:07:31 -0700 (PDT)
Date: Thu, 10 Apr 2025 11:07:29 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, jk@ozlabs.org,
	joel@jms.id.au, eajames@linux.ibm.com, andrzej.hajda@intel.com,
	neil.armstrong@linaro.org, rfoss@kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	dmitry.torokhov@gmail.com, mchehab@kernel.org,
	awalls@md.metrocast.net, hverkuil@xs4all.nl,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	louis.peens@corigine.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	parthiban.veerasooran@microchip.com, arend.vanspriel@broadcom.com,
	johannes@sipsolutions.net, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, akpm@linux-foundation.org, jdelvare@suse.com,
	linux@roeck-us.net, alexandre.belloni@bootlin.com, pgaj@cadence.com,
	hpa@zytor.com, alistair@popple.id.au, linux@rasmusvillemoes.dk,
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
Subject: Re: [PATCH v4 02/13] media: media/test_drivers: Replace open-coded
 parity calculation with parity_odd()
Message-ID: <Z_fesYbCnSjAo-K4@yury>
References: <20250409154356.423512-1-visitorckw@gmail.com>
 <20250409154356.423512-3-visitorckw@gmail.com>
 <Z_aobrK3t7zdwZRK@yury>
 <Z/a7DecDljuLtKeS@visitorckw-System-Product-Name>
 <Z_a_PzmNnvC2z7se@yury>
 <Z/bC6cygo0hem5IO@visitorckw-System-Product-Name>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z/bC6cygo0hem5IO@visitorckw-System-Product-Name>

On Thu, Apr 10, 2025 at 02:56:41AM +0800, Kuan-Wei Chiu wrote:
> On Wed, Apr 09, 2025 at 02:41:03PM -0400, Yury Norov wrote:
> > On Thu, Apr 10, 2025 at 02:23:09AM +0800, Kuan-Wei Chiu wrote:
> > > On Wed, Apr 09, 2025 at 01:03:42PM -0400, Yury Norov wrote:
> > > > On Wed, Apr 09, 2025 at 11:43:45PM +0800, Kuan-Wei Chiu wrote:

> > > > So, if val == 0 than parity_odd(val) is also 0, and this can be
> > > > simplified just to:
> > > >         return parity(val) ? 0 : 0x80;
> > > > Or I miss something?
> > > >
> > > If val == 0x01, the return value of calc_parity() will remain 0x01.
> > > If changed to return parity_odd(val) ? 0 : 0x80;, the return value will
> > > be changed to 0x00.
> > 
> > Sorry, I meant
> >         return val ? 0 : 0x80;
> > 
> > This 'val | (parity_odd(val)' is only false when val == 0, right?
> > When val != 0, compiler will return true immediately, not even calling
> > parity().
> >
> I'm still confused.
> 
> Maybe you're interpreting the code as:
> 
> 	(val | parity(val)) ? 0 : 0x80
> 
> But what we're trying to do is:
> 
> 	val | (parity(val) ? 0 : 0x80)
> 
> So, for example, if val == 0x06, the return value will be 0x86.
> Only returning 0 or 0x80 seems wrong to me.
> Or did I misunderstand something?

I misread the whole construction. Sorry, you're right. Scratch this.

