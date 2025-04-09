Return-Path: <bpf+bounces-55573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC35A82ED2
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 20:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CFA77A7177
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 18:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66AD27781F;
	Wed,  9 Apr 2025 18:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9v2pL24"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB76C1D432D;
	Wed,  9 Apr 2025 18:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744223591; cv=none; b=NMbHNBKoL/XIIGN39V9ZDBI+rucKqAfVeqxR+9kmNSfCPqJxDkrAvSqTlCR4FiK7Zlf15/xqb08yXNPAl4euxATcH8990ebcqPkjYtkTk6sbo/L83/Plgs8uKD3xppfYcABJMiIbewV6M88RmHY6YWyDprB+AqV1z1n1xTQu9no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744223591; c=relaxed/simple;
	bh=MGeq7y7ME+KPgk832sLNyoOePOBNHMNAWhFiPL63pr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5LHIbhTXFheNIkWXuZLX0pJaO6uzEqFSzPSyFrs1vHaS86g8HL6hrTmAlKIfjGHNFfntYB/aj2rkSzZOLy818Im+p9pMvu+Obl07TTV3pnswLZ6Wjuxl/DezfL8VJAua6v/RebafZus32WT3XbHrWOzsm0mdKAdKUmh7VGYCBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9v2pL24; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22403cbb47fso77158175ad.0;
        Wed, 09 Apr 2025 11:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744223589; x=1744828389; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pEZZtQmHxD6cS3JefhP/59PsGmANbj8tqGBgctIT62U=;
        b=A9v2pL24auIE5Um8q6USerrL3w7QVAt/Q9kIQKSuqTkfp7RA2n4hxDkZjFRWv5tpKY
         TLJUz97U5pMQOVbRXtQLHCI5pUQhKCmrnJpV1QVHCbd+AIB/SybJw6wivfIHshckpffq
         sGeYn5StCzmBcKzAZ5k4Y5d38tJno8ZzRTWVNxyN3/Gw+tfS14dNNI8YgSLuHryBlwpY
         w4cb6q/PJsv8M/7jTOLuTRjnTevNihXM+TF485ywWEpV5nZRdiN08Y8bgZUdwXED9Qe8
         Pq2BVXi4mBbBTNveKwa3Opp3+qDZ2vTCSOSP0qa7jGicncvvTQqdP6m2JPNMWx9vHpf4
         J0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744223589; x=1744828389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEZZtQmHxD6cS3JefhP/59PsGmANbj8tqGBgctIT62U=;
        b=H4+hT+uj/nxliOb6bR8fG+vjpnRLulb8knYN6VahfoSVtYNi4CZY/Y/vIGHyluCGyr
         WjqgWXpskvCjdUJDgk5miRJ/zdetSmyoQkdtYuHTeytPsawuHZ6TvWYevWsWyKcP55pE
         M7s7TTn46j7MEpaEK89sTgQp1vtvKnqZdFfeP65iziOEWsfBjuv7SpCdl5UeG/ryCFdm
         oj2Ms/H6V34R+i8EElrXRLErYU4Webvf84XGtDMxI2us3Jzu1rwwj5Z879ZgtTkx8MzJ
         4Ien8+Ep4ZgrRmnTYlowMyTUqP88Yhu5PgKWR/1k4VMwSYlJS1RyPCqN5YBy/qqsaQ5J
         6I4w==
X-Forwarded-Encrypted: i=1; AJvYcCUgi0ab4ZhxJSTJuf2YxZzLeDfiZB9ZaouxPSEVIAydSjqgAeeg9ph+cPv0RrHgAnWQgR1N8rsn5OIgU0c=@vger.kernel.org, AJvYcCUtiAVxVw6m70AONoYa5yPVS+fTmBogUQE0mOs/MXKPz+da1MHcUPN+w49J1dRdZDO2MI764kVEF8KvF+09y6E=@vger.kernel.org, AJvYcCVjnII4DlZdNfOh2nFbzS7b9lsCMW54Izpgtwgz6MzvJ9R6lRg75j+GL/KCxn/2/N6RdK9xn9CyKOE4MfY=@vger.kernel.org, AJvYcCVm7elTPjdld7ThmjlPf1o818karFrrZlUCZUKQnjf1NYW0Gq5cVRCY4I+FSnB5z2H7sjtxOHRxWI18Xc+D@vger.kernel.org, AJvYcCVtGuAkeBAiKIFZurTjOuhsI7Oo7Ps4jDA4gQ5DYil0MX+J+nzYGpiQx07oAUyjsPnrLfp/eiajQstWBr41@vger.kernel.org, AJvYcCWESMN/FYvBo7Q2qYCGIvzVocGQ8MSAAH0K3h2r4Ku55Sg7eFn3UYlJm8Nq73prYAsfJxc=@vger.kernel.org, AJvYcCX344eXCuQYhv9c7BsxLVTQX53d6mjG7ep5OjCHLBHWhRDCf2EXJmv8sjhTU3piSU4JDkHHfSNo2UFh8aM=@vger.kernel.org, AJvYcCXYZsdWUar81LM3ReyLu+6M7joQUeHbAOIB73rlo/VkA3JPZ9JCXpQfa19pisMgrlTDdUVaHRzR@vger.kernel.org
X-Gm-Message-State: AOJu0YzD7IAIyLmPU/JOGMXg5CDsi8dF/yIO++a1elZCMsunbo855ss8
	kUHYK2fKTbACT/jaCi/QWCQfOYsNRE/3/PB1wmXDlTl2eAMFZUd8
X-Gm-Gg: ASbGncuVaxee7EFtP0oYPeH7/wNXgdokfASRZqj5kZ4uHf4CSlmOB61oIBg1mI6K7ND
	O4KBeFBY1HEqw6Beb07ZSS4SuAHteng9105NeRK2hAnEvpaEmxjCzQbtsHu0y2W1E4UJzW0V6g7
	l0PaL1VK5zxlB6V6omCpMiJKX2Maek7vhqhEwmi21Pntgv1pWOROCEqvmKda3ln0zkMtMTyF6pd
	TK2lwYcT4NmI9iO2h3Bmaf3HvqmmGrOSO2Kx+3BoAOxDbJoCgZt0d819oTrzNXJLJDDi0sDFJ00
	GUQzvIibs32L/z7fADewmahsxCYmPc1i33JpYdP4
X-Google-Smtp-Source: AGHT+IE8wK8xLsT0Kpo2+eqnCnHqRBL6GoNWR5XNtZUkQwRprgm7rO+knOmPkUYsLXDP1SYqhAYEsw==
X-Received: by 2002:a17:903:2f86:b0:224:10a2:cae1 with SMTP id d9443c01a7336-22ac2a25780mr61351915ad.37.1744223589016;
        Wed, 09 Apr 2025 11:33:09 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a0817f2dsm1575586a12.11.2025.04.09.11.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:33:08 -0700 (PDT)
Date: Wed, 9 Apr 2025 14:33:06 -0400
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
Subject: Re: [PATCH v4 00/13] Introduce parity_odd() and refactor redundant
 parity code
Message-ID: <Z_a9YpE46Xf8581l@yury>
References: <20250409154356.423512-1-visitorckw@gmail.com>
 <Z_amQp3gK5Dm8Qz3@yury>
 <Z/a5Qh/OeLT8JBS4@visitorckw-System-Product-Name>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z/a5Qh/OeLT8JBS4@visitorckw-System-Product-Name>

On Thu, Apr 10, 2025 at 02:15:30AM +0800, Kuan-Wei Chiu wrote:
> On Wed, Apr 09, 2025 at 12:54:35PM -0400, Yury Norov wrote:
> > On Wed, Apr 09, 2025 at 11:43:43PM +0800, Kuan-Wei Chiu wrote:
> > > Several parts of the kernel contain open-coded and redundant
> > > implementations of parity calculation. This patch series introduces
> > > a unified helper, parity_odd(), to simplify and standardize these
> > > cases.
> > > 
> > > The first patch renames parity8() to parity_odd(), changes its argument
> > 
> > Alright, if it's an extension of the area of applicability, it should be
> > renamed to just parity(). I already shared a table that summarized the
> > drivers authors' view on that, and they clearly prefer not to add the
> > suffix - 13 vs 2. The __builtin_parity() doesn't care of suffix as well. 
> > 
> > https://lore.kernel.org/all/Z9GtcNJie8TRKywZ@thinkpad/
> > 
> > Yes, the argument that boolean function should explain itself sounds
> > correct, but in this case, comment on top of the function looks enough
> > to me.
> > 
> > The existing codebase doesn't care about the suffix as well. If no
> > strong preference, let's just pick a short and sweet name?
> > 
> I don't have a strong preference for the name, but if I had to guess
> the return value from the function prototype, I would intuitively
> expect an int to return "0 for even and 1 for odd," and a bool to
> return "true for even, false for odd." I recall Jiri and Jacob shared
> similar thoughts, which is why I felt adding _odd could provide better
> clarity.

I think they said they are convinced that parity should return 1 for
odd because of folding and __builtin_parity() arguments.
 
> However, I agree that if the kernel doc comment is clear, it might not
> be a big issue. But David previously mentioned that he doesn't want to
> rely on checking the function's documentation every time while reading
> the code.

He's wrong. Kernel engineers _must_ read documentation, regardless.
 
> Regardless, I'm flexible as long as we all reach a consensus on the
> naming.
> 
> > > type from u8 to u64 for broader applicability, and updates its return
> > > type from int to bool to make its usage and return semantics more
> > > intuitive-returning true for odd parity and false for even parity. It
> > > also adds __attribute_const__ to enable compiler optimizations.
> > 
> > That's correct and nice, but can you support it with a bloat-o-meter's
> > before/after and/or asm snippets? I also think it worth to be a separate
> > patch, preferably the last patch in the series.
> > 
> I quickly tested it with the x86 defconfig, and it appears that the
> generated code doesn't change. I forgot who requested the addition
> during the review process, but I initially thought it would either
> improve the generated code or leave it unchanged without significantly
> increasing the source code size.

That's what I actually expected, but was shy to guess openly. :). It's
hard to imagine how compiler may improve code generation in this case...

This attribute is used when there's an asm block, or some non-trivial
function call. In this case, the function is self-consistent and makes
no calls. And you see, const annotation raises more questions than
solves problems. Let's drop it.

Thanks,
Yury

