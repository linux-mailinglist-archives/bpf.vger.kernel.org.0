Return-Path: <bpf+bounces-53866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0BCA5D236
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 23:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68B773A9D24
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 22:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C525265605;
	Tue, 11 Mar 2025 22:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Glh+VgsX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C801E7C06;
	Tue, 11 Mar 2025 22:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741730496; cv=none; b=iMKU5fv5w8DQplXB9ceH9OPz36hImOyXPqMtDD4h0zZB/zQUgetfr4hSnQcTpQ5arZABwqRxXyAoJdw2+2j3Udj8c466XGaHAUk2Uy6N1OIE/fy+UIemEzGI2F9+2+RgEJ/aakyVa7DjHjybHGB/+56cp86qc+DC80Y7cpzwbfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741730496; c=relaxed/simple;
	bh=XkgS0CXb/WAIjYy8ImyAbrfxCnE9VK/2zhIioxXm5h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jaosfdi6rvo9Kiwrgs7SrVs/w8XOMzzkINIYnQD+hvxE2C+fcf9/Jpl8K4r9ra1QfO1SSCwWl0J5k6rw9XOixdYyUpqJLpCaWvno5xwAebmi8R/lapPAl6SVNKjfiCPka1UkqHEMWvaImxo3pp0mXx7MtxY+8o6Mjzznnee4GLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Glh+VgsX; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22349bb8605so113363155ad.0;
        Tue, 11 Mar 2025 15:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741730494; x=1742335294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4nGdnQu24c+EnZ9jURP8a6eRlAbk5SN0M0qMNjAtkzg=;
        b=Glh+VgsXS8HPirf4rmtoKR1WPkA7FDOcEZ5BT+pwzbYtMzarrNjtojSxLMs9SlWymt
         wQB7YqY+adyhtvptFyFvIWqst6DtjUrZFJY/6DBCSvXpg4tUtfLTHzCBXLxLzEK/os8S
         egZeKfwwyTUW8n3O1Xu7sLEbgz42bfW9bSRYFk3N9dXhR+GQ+CcxCR+QGurNHUEv0toJ
         4Xm0DQm3J8KaDRV7FYKD148qMh5b5pj/85wtauqbUICmSvAMVAUGyJrvWT1WbJOiZs7K
         IBar+U/olayS3FJMUXoehpUlS1nAsZePPbJp/8mxW0faqjv2EU59HwhCY6f99e6oVdaC
         mZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741730494; x=1742335294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nGdnQu24c+EnZ9jURP8a6eRlAbk5SN0M0qMNjAtkzg=;
        b=um1Nn9ujXyP+XwQAXnsN+WhSxZVJxXY8dpnlhNN+2L/e9nFv1pAI11Bg9d5lR1E+lu
         U3xEzy66x2G3ilbXCQIgCH+uTeEBl53ojhKMd0zaJH44lL2dpphpioxqhWn+67CbcK4r
         W7OZfW4eZmSHzZW1GfhQ1XMhhSwohLD65EyLswqeN91mKSiol4QWUsYwPnaktiHoNLtU
         sFqmfzn9mp63Qo3s14FDaS4QttL2nFSDc9QvyYWikannt2bp2lrn8XFe/HwpJCGWOoo4
         9DAruxHkIfGeIjttUaoGRDgff1gHRRb8d54fizMCZkdUcAuD+/t/3prjafcdbqxzs6w2
         zerg==
X-Forwarded-Encrypted: i=1; AJvYcCVegTy6rREPhWaPEpDGTFlMxLDmMZq9Ft0hGecYdPdOOz5x8K3h2+ioLo2y9Tjk/DI9yya+rlIcq1Uqarc=@vger.kernel.org, AJvYcCW2EUlFLzGYyLRzkqVX2uIEASydyyXyHyKi6bfxv3z0tnBMrrANvGMggC449MrsFNHa3ew=@vger.kernel.org, AJvYcCWEV0XVUuSy5G8t45T2MW52j3CRW31LmzAgr6fZqks5Dg2q+yn3JaNck6cVa7dRPT4w9zKRT43Hvubyrgo=@vger.kernel.org, AJvYcCWWPoPgIdYY2mt/cRYfTUcddmFeQuq9ImwvD91zy0+P7C15oYzjodwV+B8L6sutUsWDY54NlbMj@vger.kernel.org, AJvYcCWaEdvdOPPq6UZfmaKXf7J+z40FO7scpnnpAx0sbD29vpan3O9HoptEFJR7TZLwOZvUnHx2vk+skeCk1W34@vger.kernel.org, AJvYcCXuxMJeaKA6PQXk3nnxSWlGVLHPVOFkTU1tiq0s4WEGF1EhaXoPKUd0SEXIidlDD+EOdUzfCVbTjXxsjAcDG8I=@vger.kernel.org, AJvYcCXwYH55WfCsoCTcOMwlSP21gH1BuvYPdfloxTecqGD0blh80O+QSGEVfIUl7/HEfi5Rol0afAbisdLa2Bvy@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9cKxf6vRjvmDueZzk/QcsubFVFsOzUpl0/+V1EygzYLH/oB7M
	qOmFUdRxyjGFK8CKki4wpm6ZGKn/qfo4dza3oMftNWe3qIcimdDs
X-Gm-Gg: ASbGncsRWz/1CptRdSeun8+N20K9SnUNooCnq/ApOZ/VnECTmb8bcikaKoTW3ADLP0I
	n6DYyPsU8UJQuUq34/5V72or1ibVHBPZZ/QmhBCO+51JZ+Inz48F/Ih7BpdAHnsIQw+SsCxzPYb
	IjMR4ehtZo7WshFh+eS8PjdKodeKAjAXNtYbE9ziwxs5QwtTI9Z5gR/tS6rMRrsv+JH7HzO1r0z
	coEABvaf6kxNZDT3UyjcFVaZqQl5iWw0sB9givS8LKN3wXxn7zOs7JzaSSNAqUPq/vR0Rwy+R+Z
	DSAwU+n5DR3+iSMl1Ld4bNfnWViRXx6OKJCEuI+K0w8GfflEQzUhe2g=
X-Google-Smtp-Source: AGHT+IHfvnoVJgHMih9pvYSUsyOoOI7rh3JUtGAJjtASiqZVTFfrJXIMw23oGqwW4/w5VR3B4dwAMw==
X-Received: by 2002:a17:903:32ce:b0:223:4b8d:32f1 with SMTP id d9443c01a7336-22428882233mr316949475ad.1.1741730493639;
        Tue, 11 Mar 2025 15:01:33 -0700 (PDT)
Received: from localhost ([216.228.125.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736ded451c1sm4125755b3a.119.2025.03.11.15.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 15:01:32 -0700 (PDT)
Date: Tue, 11 Mar 2025 18:01:30 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	David Laight <david.laight.linux@gmail.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Laurent.pinchart@ideasonboard.com, airlied@gmail.com,
	akpm@linux-foundation.org, alistair@popple.id.au,
	andrew+netdev@lunn.ch, andrzej.hajda@intel.com,
	arend.vanspriel@broadcom.com, awalls@md.metrocast.net, bp@alien8.de,
	bpf@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
	brcm80211@lists.linux.dev, dave.hansen@linux.intel.com,
	davem@davemloft.net, dmitry.torokhov@gmail.com,
	dri-devel@lists.freedesktop.org, eajames@linux.ibm.com,
	edumazet@google.com, eleanor15x@gmail.com,
	gregkh@linuxfoundation.org, hverkuil@xs4all.nl,
	jernej.skrabec@gmail.com, jirislaby@kernel.org, jk@ozlabs.org,
	joel@jms.id.au, johannes@sipsolutions.net, jonas@kwiboo.se,
	jserv@ccns.ncku.edu.tw, kuba@kernel.org, linux-fsi@lists.ozlabs.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-serial@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux@rasmusvillemoes.dk, louis.peens@corigine.com,
	maarten.lankhorst@linux.intel.com, mchehab@kernel.org,
	mingo@redhat.com, miquel.raynal@bootlin.com, mripard@kernel.org,
	neil.armstrong@linaro.org, netdev@vger.kernel.org,
	oss-drivers@corigine.com, pabeni@redhat.com,
	parthiban.veerasooran@microchip.com, rfoss@kernel.org,
	richard@nod.at, simona@ffwll.ch, tglx@linutronix.de,
	tzimmermann@suse.de, vigneshr@ti.com, x86@kernel.org
Subject: Re: [PATCH v3 00/16] Introduce and use generic parity16/32/64 helper
Message-ID: <Z9CyuowYsZyez36c@thinkpad>
References: <4732F6F6-1D41-4E3F-BE24-E54489BC699C@zytor.com>
 <efc2ee9d-5382-457f-b471-f3c44b81a190@citrix.com>
 <5A790652-1B22-4D13-AAC5-5D9931E90903@zytor.com>
 <20250307195310.58abff8c@pumpkin>
 <EB85C3C1-8A0D-4CB9-B501-BFEABDF3E977@zytor.com>
 <Z824SgB9Dt5zdWYc@visitorckw-System-Product-Name>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z824SgB9Dt5zdWYc@visitorckw-System-Product-Name>

On Sun, Mar 09, 2025 at 11:48:26PM +0800, Kuan-Wei Chiu wrote:
> On Fri, Mar 07, 2025 at 12:07:02PM -0800, H. Peter Anvin wrote:
> > On March 7, 2025 11:53:10 AM PST, David Laight <david.laight.linux@gmail.com> wrote:
> > >On Fri, 07 Mar 2025 11:30:35 -0800
> > >"H. Peter Anvin" <hpa@zytor.com> wrote:
> > >
> > >> On March 7, 2025 10:49:56 AM PST, Andrew Cooper <andrew.cooper3@citrix.com> wrote:
> > >> >> (int)true most definitely is guaranteed to be 1.  
> > >> >
> > >> >That's not technically correct any more.
> > >> >
> > >> >GCC has introduced hardened bools that intentionally have bit patterns
> > >> >other than 0 and 1.
> > >> >
> > >> >https://gcc.gnu.org/gcc-14/changes.html
> > >> >
> > >> >~Andrew  
> > >> 
> > >> Bit patterns in memory maybe (not that I can see the Linux kernel using them) but
> > >> for compiler-generated conversations that's still a given, or the manager isn't C
> > >> or anything even remotely like it.
> > >> 
> > >
> > >The whole idea of 'bool' is pretty much broken by design.
> > >The underlying problem is that values other than 'true' and 'false' can
> > >always get into 'bool' variables.
> > >
> > >Once that has happened it is all fubar.
> > >
> > >Trying to sanitise a value with (say):
> > >int f(bool v)
> > >{
> > >	return (int)v & 1;
> > >}    
> > >just doesn't work (see https://www.godbolt.org/z/MEndP3q9j)
> > >
> > >I really don't see how using (say) 0xaa and 0x55 helps.
> > >What happens if the value is wrong? a trap or exception?, good luck recovering
> > >from that.
> > >
> > >	David
> > 
> > Did you just discover GIGO?
> 
> Thanks for all the suggestions.
> 
> I don't have a strong opinion on the naming or return type. I'm still a
> bit confused about whether I can assume that casting bool to int always
> results in 0 or 1.
> 
> If that's the case, since most people prefer bool over int as the
> return type and some are against introducing u1, my current plan is to
> use the following in the next version:
> 
> bool parity_odd(u64 val);
> 
> This keeps the bool return type, renames the function for better
> clarity, and avoids extra maintenance burden by having just one
> function.
> 
> If I can't assume that casting bool to int always results in 0 or 1,
> would it be acceptable to keep the return type as int?
> 
> Would this work for everyone?

Alright, it's clearly a split opinion. So what I would do myself in
such case is to look at existing code and see what people who really
need parity invent in their drivers:

                                     bool      parity_odd
static inline int parity8(u8 val)       -               -
static u8 calc_parity(u8 val)           -               -
static int odd_parity(u8 c)             -               +
static int saa711x_odd_parity           -               +
static int max3100_do_parity            -               -
static inline int parity(unsigned x)    -               -
static int bit_parity(u32 pkt)          -               -
static int oa_tc6_get_parity(u32 p)     -               -
static u32 parity32(__le32 data)        -               -
static u32 parity(u32 sample)           -               -
static int get_parity(int number,       -               -
                      int size)
static bool i2cr_check_parity32(u32 v,  +               -
                        bool parity)
static bool i2cr_check_parity64(u64 v)  +               -
static int sw_parity(__u64 t)           -               -
static bool parity(u64 value)           +               -

Now you can refer to that table say that int parity(uXX) is what
people want to see in their drivers.

Whichever interface you choose, please discuss it's pros and cons.
What bloat-o-meter says for each option? What's maintenance burden?
Perf test? Look at generated code?

I personally for a macro returning boolean, something like I
proposed at the very beginning.

Thanks,
Yury

