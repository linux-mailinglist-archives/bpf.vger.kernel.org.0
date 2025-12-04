Return-Path: <bpf+bounces-76072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 160ABCA4BAF
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 18:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17BDD30341F7
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 17:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A109A301032;
	Thu,  4 Dec 2025 17:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiA+oq9p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1D52EC09F
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 17:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764868583; cv=none; b=a4d76sTfeSbXhEjG0psiUsnAYV1Nie1pVMWLM1SP4Gs1Suz+ygzXz/OHJ0rX3xpzl8aH1EdM6Y85SNNZu/80C5AKKTXfjxDJY6tlg8BDfDC7yn7yPC0CUmGJE1wUTZ+o0DN6EAqHjtJnicT+rMd4iQUOafQ2axz1YushECiajCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764868583; c=relaxed/simple;
	bh=km4Dh9hQxInKzZx/6CVtSmfiE01GeOx+hzC3RItzZCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZ0+qhbHZqNLaS/wHNpEUTcc/ZDHeGlwkzeSM1caTpX72W8+lV+DZ9vV+tU0yFhzcJoUe3gbXMdTowPHKOEjPPueOA2fRj+5e3k/o0Zok6k5t443WFiyjT0f5D+4iqe0Aie8FIKgWtvU3+/4YSLOVPeIwE+Rz625n0oQCwypBls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BiA+oq9p; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7e2762ad850so1069647b3a.3
        for <bpf@vger.kernel.org>; Thu, 04 Dec 2025 09:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764868579; x=1765473379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9as9K2dHITRu6IU+yIjl4J9GL6vgxblmI/uo3LDmiDA=;
        b=BiA+oq9pF4b6fLwzzpFCXc3BWr2q7jmMqSh7Y1G3BALUyBhaEmta8HkkX3qUHa4H9Y
         oI1s5FC66uKaW3k42HXLHdqG46JyjGZunzg2oLW/K+bPSuzy8xapjecNrnPBs36TocvU
         Dda+FuY7i5Ti6TinHUN95K2A27UkuBy6HBtwflNYQDyeAzzvh3PyqakZRmjx7jsUWKv/
         OhCy7DGnm92V1HCzfcRyas5gImTgQkXm8t1iFW4TcZTHcJLWRzwn2u+GerHMs5QaCHsW
         PNr3lCrasUwnrxNv43Fr3223E3yh55PFoxRmR+hkl/1T6QS8yMqm2ham5i+fXwetIaIy
         CUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764868579; x=1765473379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9as9K2dHITRu6IU+yIjl4J9GL6vgxblmI/uo3LDmiDA=;
        b=JsYVDKz53ke+Av3sPcBk9+QOYjkZH76lmZx7i+hJRvxe/OQOXFKjM7hrezSCqbjbsP
         r0ZzYSuviJdn9LIMCY5Ea/F/AbSb0H4QsHbGS02OUX5V6oU/NBz3iWRj3VEkAvNqmfJX
         2A3XESzyr9oVh0tBObPyugQ+wnfCNMaKo8z5Azysmp2IaPeRchxjPXHuSzJC7OZgeryi
         bWPs5x5m9bdYAV7gIYhf9w44pU7AOLDVxz/auDkBtFKEx/E3cpi+mnaeRDJz56XDeZZ4
         TCStJh0bUhYiuGAaQUSebBM89m1R3rZ7ZW4srRYbazFPhR1+RbI0pYr48tElQiCsjRX0
         ar6A==
X-Forwarded-Encrypted: i=1; AJvYcCUiNTDaOeYSIpDZ6t317n/vpNKK1YGrckliNy4FkomdCiJoGqmkk0xgUCe7k9vyldlqprA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPko3T2rNMHQjRLAeM74vLw7/jZmZGvilqdqqXP8XG3ZR5LOhh
	z5v/WVNEBY3f/YWMSczWHZV+A6q+Kl2n9RcOOWvLV64EAdR2A7ywmgb1
X-Gm-Gg: ASbGnct8LJKiPJVBnaJWw7FQycbuW6eSWuc6hKGLgta/BH4W5X/bxiiHMATH5pb0OPH
	CE617cXjNrdo42u/s6B9OwnKjEc8VeFNaoT7GZicp1gxd//1Rb3X5Ou9/TA/ffFT/dc9gVkrVHd
	oDR7upQeVzId8e4Q2cARw6Q/VOEQ4qiDkARFIToqsgb+BG/Za/oE71OhKSUbwggBPYpFRwyAEsF
	V8KlRt7F48/Q7EZsNc3XMoD5uYt46RREaxjAUc0YjEy8NL9SgAZPj01TLmdRXyW+B2MreB+FPwZ
	5tjZtMETN3AvjjqII0A44Hb7nU6RK6Y493aRN9i/Xy7K1fE+FM8vkTXpUUaL0SDrfpDgBs6OxIA
	8iz6PMt2KN0y/542SXi1wKfp7ACDzLORm3vLYRk6C3vnxQHUmYcvI//5cxK2OFUFwYSEGskGITL
	Of7GUDrtyDXsuC7s4UrYxXsYc=
X-Google-Smtp-Source: AGHT+IHAXVYFQ4q367vSeW5sz0uxGvn2ZjIkZaA1NzUcPpPtZ5Mf5JbmRDgnfViVXo5wuRHDOwdH8g==
X-Received: by 2002:a05:6a20:958e:b0:350:1a0e:7fc5 with SMTP id adf61e73a8af0-363f5ed53c9mr8451647637.60.1764868578709;
        Thu, 04 Dec 2025 09:16:18 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf686b3bad4sm2375297a12.10.2025.12.04.09.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 09:16:18 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 4 Dec 2025 09:16:16 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Elizabeth Figura <zfigura@codeweavers.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>, Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	wine-devel@winehq.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 00/13] selftests: Fix problems seen when building with
 -Werror
Message-ID: <536d47f4-25b1-430a-820d-c22eb8a92c80@roeck-us.net>
References: <20251204161729.2448052-1-linux@roeck-us.net>
 <20251204082754.66daa1c3@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204082754.66daa1c3@kernel.org>

On Thu, Dec 04, 2025 at 08:27:54AM -0800, Jakub Kicinski wrote:
> On Thu,  4 Dec 2025 08:17:14 -0800 Guenter Roeck wrote:
> > This series fixes build errors observed when trying to build selftests
> > with -Werror.
> 
> If your intention is to make -Werror the default please stop.
> Defaulting WERROR to enabled is one of the silliest things we have done
> in recent past.
> 

No, that is not the idea, and not the intention.

The Google infrastructure builds the kernel, including selftests, with
-Werror enabled. This triggers a number of build errors when trying to
build selftests with the 6.18 kernel. That means I have three options:
1) Disable -Werror in selftest builds and accept that some real problems
   will slip through. Not really a good option, and not acceptable.
2) Fix the problems in the upstream kernel and backport.
3) Fix the problems downstream only. Not really a good option but I guess
   we'll have to do it if this series (and/or follow-up patches needed to
   support glibc older than 2.36) is rejected.

We'll have to carry the patches downstream if 2) is rejected, but at
the very least I wanted to give it a try.

Guenter

