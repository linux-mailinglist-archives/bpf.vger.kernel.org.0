Return-Path: <bpf+bounces-53602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AAAA571BD
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 20:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61A9D172FC6
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 19:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF7E21A440;
	Fri,  7 Mar 2025 19:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k795jQfJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C48253331;
	Fri,  7 Mar 2025 19:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741375813; cv=none; b=mO7ugUfuy0f5yoFxZ7qe9ca2NJ1UPGU1jRoMRr1yffvPXJ0v/Hr4gQptakrhfRHwEP+Ya+zxNabzpHZ7QQHahNa+zPMELzcWJSb3ycHiJJsv27Fb2GAyvRZwYX1xRNzwLHAj/qIfmhok5j4/HnFNAT3gk2rNK+eCwEaOMuiy67A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741375813; c=relaxed/simple;
	bh=ES8fce8TYJh0CUhG3aOJvKwa0LbilzpFk3jZFOZFALk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJSXmsZFgSJhKGxw7rSoS35pZtYdjs+TWyguzsokybCmtRj5C2YGaBlejMCoNqSSPbaRCPE3y9PrPTtd8SU7h3z6CKmnqWbVi5fYsiJjU6PVSCu4CFY0Dl+1/CPsHKHtmwz9rDgwKy8efrNBKVXyVmJiXCKPh7juPlrHd5T6B9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k795jQfJ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22337bc9ac3so47928205ad.1;
        Fri, 07 Mar 2025 11:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741375811; x=1741980611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ujnt93n2ZnNyLSMeIXg1bvl3lYCF/JQ06NeoxLK/MdQ=;
        b=k795jQfJ/zzlzUwEZr/oHdEIvecaTikfrnbUCZVRPMd4a9W7lW7eRwLkflGNgCy7xT
         u8CzIFJtkWKhRbI4Tnlou2is5wquE3QC+TvYDyZoAVKdOLBvuE+N9CLjUAcZFnoMvPA7
         G1d5VNP1NfETUpSr5IvNJ02vEeo3s/gyFcL4sTGiv7GqncD6OkyXc4qMIhCqXxhM8Rq8
         zK9+LixthdUsqqOLN/C4PIvObYVKf/S133sG0DJcLUSEMkoetYaxtv68km5rFgI81mE9
         zlP36AaqebkgQcDR2yN9W+jatsFWnAKbkrsabjP7uJFaI757EBotJknHsFvXWHEGuWQS
         r5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741375811; x=1741980611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ujnt93n2ZnNyLSMeIXg1bvl3lYCF/JQ06NeoxLK/MdQ=;
        b=mZiocy50tlG+Lwd8q6cPxbAWfv2uJ0nFZiyCUhVOSvD70Cb+Z7rAznSm9Pz6pLmS5f
         XRkXhFWd2DU/BOtQTw9/TvciEwhz3GNU929aSmg9Tz9qygzOET6XSSMzFdgDHUwBB1DM
         mF9VFBVqyO1sx7cesgyZQd0G9zvjoPamfgCWe3pDnV4kOu+FlouBcsKT6P5RYvBhw0qQ
         WVUjkImylLsTpTlOwDv3GU39+MxjtSX9icC7RuY4YyVsEoClqR2TlW91tT1iqlUBr+is
         Xf2xLM8PBz8wncHvocY4X03uW1JNdSCBGaTFJDfYzRuENwbdFkXqwCTlZUq/S5XEZk6f
         5OTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXklk6DS1feOVDHJpfOyp/fYlqTEdXVnCAVkV0H3rAr6/323Fln7v+te8UWU0wKIJ6Uck=@vger.kernel.org, AJvYcCVzRgHGEt0uaiPsbLpBh2nRx7+5vWvHnjeYzYDLw8gJjNgC4gyC2vG7UXFn8CxSoTJVbm2Ye47ys6INsHs=@vger.kernel.org, AJvYcCWT1efVcmO5uGKIOATaqA6ydovsoz+goQB2t+tRYbocEp6B5zleT12bORdFNFBZH+fqj/l2VmzR@vger.kernel.org, AJvYcCWYOBCr1t/Afhdb9Fh3kzQRqtFRSQcElr484q8NWKoKf8fOH0/oNhenR32XV+M+JXReu91mg2Q/HyIbBESU@vger.kernel.org, AJvYcCWmfynWcFz0WNHNNUlKYFVop562SMPos+IODr6KxMi0texGrlXE3Kk/gJh7qpr/jFJeQgRHktkGlVJj2Bc1@vger.kernel.org, AJvYcCX12v54ypJj2ZN+wkBgK9kn/A3WEePP6bgrt+fmyDAd+0VHwXSmphkKr5JSEYq63FuPdu3mY7gg7Tbjv5E=@vger.kernel.org, AJvYcCXTVphQ5SlBe4i+WLC0OreG8dTQqUIWjX1OVSkuFcnIX3PDVrvTcDtw56a7BfaqR2PZ1Bu2bNIH3EqKSSzDsH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS0yN0Q3tnqZdLzBtQiZMcBgyPsY8fjNxaNu80+KUYj/0vQyd/
	4R51NJX7BwNgZJeF/lE3HrUQxFcNy5Xhbvvo9WxfjjEe5U2r2bg2
X-Gm-Gg: ASbGnctZFA5GP1FgYj2/6mvz5v34R4ghj5YedoU9qbVOZl5pHd04cYubg+YOUtNkmt9
	aHpoN0jpRxgnuLUgXeXLyAkCdNSLlDjrjD+HTqy8nGCWlKPv5dksIPkghJUuX9SSZszqPv68WVT
	msgl/1Bxt4JKlxTQ83id3DjXl/DmQUUqQEIraMjUIENgdTTockwLRfo5YYAq4tuFSGSVO+oXp/G
	6QIs5pnNJptIiLzOgC6WEJx47oOFlXDwKbJEgxVer5VEYPaI8DhPTa5eEYsCQiiK7Px4QI0AwsJ
	22AfMb0m9RAmmOtKAt4m3z1TivOEFW2qufrBIdiTQ+qU
X-Google-Smtp-Source: AGHT+IEmnovg8SODODeYbL7InF2WSqC9McWE/UoY4IWxbTzIc1jrQMfyhDSc++tBv5NrR3IGNpr8rQ==
X-Received: by 2002:a17:902:f645:b0:21f:4c8b:c4de with SMTP id d9443c01a7336-22428ac90a6mr73028235ad.42.1741375810720;
        Fri, 07 Mar 2025 11:30:10 -0800 (PST)
Received: from localhost ([216.228.125.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109ddffesm34081415ad.40.2025.03.07.11.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 11:30:10 -0800 (PST)
Date: Fri, 7 Mar 2025 14:30:08 -0500
From: Yury Norov <yury.norov@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	Kuan-Wei Chiu <visitorckw@gmail.com>, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, jk@ozlabs.org, joel@jms.id.au,
	eajames@linux.ibm.com, andrzej.hajda@intel.com,
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
	akpm@linux-foundation.org, alistair@popple.id.au,
	linux@rasmusvillemoes.dk, Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se, jernej.skrabec@gmail.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux-fsi@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
	linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
	oss-drivers@corigine.com, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com, linux-serial@vger.kernel.org,
	bpf@vger.kernel.org, jserv@ccns.ncku.edu.tw,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH v3 01/16] bitops: Change parity8() return type to bool
Message-ID: <Z8tJNt83uVBca0cj@thinkpad>
References: <20250306162541.2633025-1-visitorckw@gmail.com>
 <20250306162541.2633025-2-visitorckw@gmail.com>
 <9d4b77da-18c5-4551-ae94-a2b9fe78489a@kernel.org>
 <Z8ra0s9uRoS35brb@gmail.com>
 <a4040c78-8765-425e-a44e-c374dfc02a9c@kernel.org>
 <Z8ri5h-nvNXNp6NB@gmail.com>
 <04AA7852-2D68-4B3F-9AA7-51AA57E3D23D@zytor.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04AA7852-2D68-4B3F-9AA7-51AA57E3D23D@zytor.com>

On Fri, Mar 07, 2025 at 04:14:34AM -0800, H. Peter Anvin wrote:
> On March 7, 2025 4:13:26 AM PST, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >* Jiri Slaby <jirislaby@kernel.org> wrote:
> >
> >> On 07. 03. 25, 12:38, Ingo Molnar wrote:
> >> > 
> >> > * Jiri Slaby <jirislaby@kernel.org> wrote:
> >> > 
> >> > > On 06. 03. 25, 17:25, Kuan-Wei Chiu wrote:
> >> > > > Change return type to bool for better clarity. Update the kernel doc
> >> > > > comment accordingly, including fixing "@value" to "@val" and adjusting
> >> > > > examples. Also mark the function with __attribute_const__ to allow
> >> > > > potential compiler optimizations.
> >> > > > 
> >> > > > Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
> >> > > > Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> >> > > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> >> > > > ---
> >> > > >    include/linux/bitops.h | 10 +++++-----
> >> > > >    1 file changed, 5 insertions(+), 5 deletions(-)
> >> > > > 
> >> > > > diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> >> > > > index c1cb53cf2f0f..44e5765b8bec 100644
> >> > > > --- a/include/linux/bitops.h
> >> > > > +++ b/include/linux/bitops.h
> >> > > > @@ -231,26 +231,26 @@ static inline int get_count_order_long(unsigned long l)
> >> > > >    /**
> >> > > >     * parity8 - get the parity of an u8 value
> >> > > > - * @value: the value to be examined
> >> > > > + * @val: the value to be examined
> >> > > >     *
> >> > > >     * Determine the parity of the u8 argument.
> >> > > >     *
> >> > > >     * Returns:
> >> > > > - * 0 for even parity, 1 for odd parity
> >> > > > + * false for even parity, true for odd parity
> >> > > 
> >> > > This occurs somehow inverted to me. When something is in parity means that
> >> > > it has equal number of 1s and 0s. I.e. return true for even distribution.
> >> > > Dunno what others think? Or perhaps this should be dubbed odd_parity() when
> >> > > bool is returned? Then you'd return true for odd.
> >> > 
> >> > OTOH:
> >> > 
> >> >   - '0' is an even number and is returned for even parity,
> >> >   - '1' is an odd  number and is returned for odd  parity.
> >> 
> >> Yes, that used to make sense for me. For bool/true/false, it no longer does.
> >> But as I wrote, it might be only me...
> >
> >No strong opinion on this from me either, I'd guess existing practice 
> >with other parity functions should probably control. (If a coherent 
> >praxis exists.).
> >
> >Thanks,
> >
> >	Ingo
> 
> Instead of "bool" think of it as "bit" and it makes more sense

So, to help people thinking that way we can introduce a corresponding
type:
        typedef unsigned _BitInt(1) u1;

It already works for clang, and GCC is going to adopt it with std=c23.
We can make u1 an alias to bool for GCC for a while. If you guys like
it, I can send a patch.

For clang it prints quite a nice overflow warning:

tst.c:59:9: warning: implicit conversion from 'int' to 'u1' (aka 'unsigned _BitInt(1)') changes value from 2 to 0 [-Wconstant-conversion]
   59 |         u1 r = 2;
      |            ~   ^

Thanks,
Yury

