Return-Path: <bpf+bounces-76091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FA9CA54AE
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 21:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F9D830DC392
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 20:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD2935E53C;
	Thu,  4 Dec 2025 20:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N62e52w7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BE435CBD4
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 20:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764878855; cv=none; b=HMQs/dZJXzz2iZ7pa4/F8P+Df10grLbSw8Eq2D/XZq7+SAtCwWP87pY/Z8YYxEnVPZfMwip+AD2gPEATrTtGBJbGkKw/o13VrJsRNZtdGlc9QtyZXlTqN2TOVna+NOiA2cKlVN+z/FtdlY08cauTMogftdR66SFCrMYioCPQBDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764878855; c=relaxed/simple;
	bh=t9dWGhzFN9RsOEfXcG7dxUErpgknpFW7IobkU4qVlBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHTvXg6Vy1C+CaM1cUKyPIbFha8tvtgERP2CcBKFcsyUganVLYzxWH813l4AVRAo4f2HcIEyFsXVcUUlO3L78CNiOURiw3fFKPoxA1d9y+ez1dN8Ue2AvA8sgrLLZcc1QLIL/xslITb8RbuOcDs5fNquYyHKGk3g+vivgNs2Ga4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N62e52w7; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-297d4a56f97so18388255ad.1
        for <bpf@vger.kernel.org>; Thu, 04 Dec 2025 12:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764878854; x=1765483654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vwQDJvoYGc3nz2GzVMDge8eRjx46D+CfeX3mSjr8SeE=;
        b=N62e52w7nqEmdnMJG6OiIt5p9OqhHolPDi1no5b7NSSIJdFmcjWdzSnitjS07UCRPw
         SA+9nHA6jhM7THjX5+ErqQLZ0vdhFQnR8wSMrytxY9OVe8K0p8vH5qW3pYgdsSFcPnry
         wnTIcNPwX5IJkJtbZh5KNkRt/tl1NaX1bVRoJihIlnM7FsuQ4CMCEwWA76N0rOUmT1ma
         99xeZVXzEU1yuaaPYbjxbMH457PXUVHIA89Y5i1U8S8a4lDN3vPDKqvCErVXcck27NEM
         ZfDMuID7PauRhnq2oj3FxtPG9bnitXYF2fFL2W4GMljLxhtbfkFICWhDPse2zpnhL+k+
         CaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764878854; x=1765483654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vwQDJvoYGc3nz2GzVMDge8eRjx46D+CfeX3mSjr8SeE=;
        b=cqTr8YRe406kDYpgaCsGPDp2jJdrKL4+6ZYoXcZ/x/Qy86vidRm4y8/9j4Yx+NuU5z
         QRrfvWwcwVrzTeP7/UnOPtaM2mCf7BJ98ZxlKkwIvoOzRoB+vi0Oi5Kx6vFIjfxnW/Ei
         F3J0N9EdQg7EDKuGq/TD3yZ0kogfvF4Nah8yWjDjLnpbQ+uBD6ZiaYHvkyuvmodQZEyG
         j8BMTmSRd+cRI4DmRUn5eHupUuEQgCDl1RwjTB2aecanVFdtNPEnQPauSrQm/ristLr+
         UlC4qNP77xZShXN1pI4E9ZLPpEHutmRfIuF2kjcPJB4baM5wignFHHw2hEllb+C++Ppt
         CaWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0ELVkpuJUP2vK9NuW57z5WLl2mWVMxMJiZDftY+s9IQTrJJXWkYEuaUjFrM51SjAGYyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrj5z+YHVCHcM1CvFFLTGBrgAScgilQE5hQvcv23hM5Bu/po7q
	dR46ICE3X3SQiCOVz3ijPr/i+V+eC7Czk/fPeD+yhIX1KJMQh/N8fnn3
X-Gm-Gg: ASbGncssgcWutwKKNFktSOwlW+reSx+LQylH9h3OJAk8/myF5ArpIq9m6zU8NptJooa
	YSU19cdekiQ3uQfhDRo4Fq+ANIKWxIBt+hhilPjbzT+K+1bZ/CyMMqkyuLnaDAlO6g0u2wyT8b6
	cycdm8VSWS/fQYmDo2kE6U7EJnKbW6l4FQLk6nfh2ZnsGlGNi+xvOUHdEfLvsMpFUsEOCkkTKGj
	rTt94ZP8q2wt3RgN0KYbxjr+4dTfiPeiMeD40jDzy26ML5IhZhGZ8ShI+k2fiHVONHv+e7e5Eqz
	PAaI137Sd2TtcvwE04AgS0kpdEb9tdPsCjs+bUaYw9jjdjTset4REXWevbNwuFATW4nwpV2IlWT
	7UYmKWHo27Ex1hw6yyRlNlBAxMn9bWmStgmPAtqqKqxCoJF6ZCnbm6BvDSUDXAWOoiQv47usGKq
	HcJvC/WcYsIOfGCtCIlgknRsI=
X-Google-Smtp-Source: AGHT+IG9RhYAdYFpkikbhLyKLRnmTqvWGyuDRO7QxR1lVaPfukVM+lNdimabKudFcB5i2SDvSqWrXw==
X-Received: by 2002:a17:902:e807:b0:299:d5a5:3f7b with SMTP id d9443c01a7336-29d684764b1mr90997395ad.53.1764878853433;
        Thu, 04 Dec 2025 12:07:33 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae99f006sm27567195ad.50.2025.12.04.12.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 12:07:32 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 4 Dec 2025 12:07:31 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Kees Cook <kees@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Elizabeth Figura <zfigura@codeweavers.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, wine-devel@winehq.org,
	netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 00/13] selftests: Fix problems seen when building with
 -Werror
Message-ID: <0b4dd065-4f96-48e8-a44c-24d891c68a68@roeck-us.net>
References: <20251204161729.2448052-1-linux@roeck-us.net>
 <20251204082754.66daa1c3@kernel.org>
 <536d47f4-25b1-430a-820d-c22eb8a92c80@roeck-us.net>
 <202512041201.EBE3BF03F5@keescook>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202512041201.EBE3BF03F5@keescook>

On Thu, Dec 04, 2025 at 12:03:29PM -0800, Kees Cook wrote:
> On Thu, Dec 04, 2025 at 09:16:16AM -0800, Guenter Roeck wrote:
> > On Thu, Dec 04, 2025 at 08:27:54AM -0800, Jakub Kicinski wrote:
> > > On Thu,  4 Dec 2025 08:17:14 -0800 Guenter Roeck wrote:
> > > > This series fixes build errors observed when trying to build selftests
> > > > with -Werror.
> > > 
> > > If your intention is to make -Werror the default please stop.
> > > Defaulting WERROR to enabled is one of the silliest things we have done
> > > in recent past.
> > > 
> > 
> > No, that is not the idea, and not the intention.
> > 
> > The Google infrastructure builds the kernel, including selftests, with
> > -Werror enabled. This triggers a number of build errors when trying to
> > build selftests with the 6.18 kernel. That means I have three options:
> > 1) Disable -Werror in selftest builds and accept that some real problems
> >    will slip through. Not really a good option, and not acceptable.
> > 2) Fix the problems in the upstream kernel and backport.
> 
> The series fixes build warnings that appear regardless of -Werror,
> yes? That on its face is an improvement, so maybe just adjust the
> Subject/changelogs?
> 
Yes, I'll do that.

Thanks,
Guenter

