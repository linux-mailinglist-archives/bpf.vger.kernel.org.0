Return-Path: <bpf+bounces-76079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B582CA4E35
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 19:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75BC7313B5F9
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 18:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3008359717;
	Thu,  4 Dec 2025 17:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEFIw/ay"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A003587B2
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764871000; cv=none; b=qXYLBywlCQ/zC06ZPT5JBEdRBNYLZ6sf+0gmoHfMRaLF0QccEo4/ki/x+WYkxptlDhzSrLhhhRxZUuQCGv102p4yu/3Fuu9SVbFKphsorr/BCt0VIKcYOJp2KsSmmt+QZ8ICW1gyK39Zkw8yRH/z3t5G9lmqToRON5aue3sGYPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764871000; c=relaxed/simple;
	bh=LssZyxnB/Qt9JOrc1wZ9fPSlCWdCRitPmmyrurmq8kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c36O3HQB/rQbwtoO82hTt0s1CXwW2DgPb9nQ5nebc8SQaY3um1pHSBEtkCBQiQByZIiDEpda+Wq/VmJBB4dm9Pn0iZSbMWGPFtco1tMY7JToGJqNuK0i9GWSMOqL9H8IZrogb3DKsvbGy8kcFYqEgCwZqdACuvAHRkq/KjWKtpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEFIw/ay; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7baf61be569so1483967b3a.3
        for <bpf@vger.kernel.org>; Thu, 04 Dec 2025 09:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764870996; x=1765475796; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lRdN5rrU2peC6f2Ho/CsA9zM52zEMWOlMu7pxRw/JVQ=;
        b=HEFIw/ayyhHN8KhM6O47o3ytvOcTKfR4wcPQ+DbAc8FZpt84Ejwyp/pXj/rraBRcVk
         G795k7cu6Gs1uOnmQWc+HXG3C8UxJ4+z64LAtszbwRzgGnrCPJomRVcXGJpoOSSYT1UE
         fAyefQCFn/3nnbF66t8aecoDTjOcaLar8CnZspzpc+d70UEcAYW9G8D/I/ZKHQIbM/vg
         bs9VuL+Z3VBUACQHzIfQ01WSA0c0Q1G0dt4QEK+ukUl2jFxVTNOsF6qkBQU6axesywRW
         pqlMpS1Tl9qZ/FJaB/6YfS26hptQACIQH+RT6iVTLDU2EuMqRVp1xRnymTmjBG4tKeG3
         vfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764870996; x=1765475796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lRdN5rrU2peC6f2Ho/CsA9zM52zEMWOlMu7pxRw/JVQ=;
        b=A46vAD9sHf3CVOGPE68ip/Dze3I+9LjKNarJ8mnMlvLGoiWfPrfJaYHltDQgjluqoQ
         1YSE9+4tliV0VVkU3zGan443D71NqW5yk3iD3VASIoqE2mLSatGThW2zb7LAiehpqnbf
         u7a192PwgbPiaGPlaXboecV0oJiOSNZaFyA7mogSE0vVhv099aGkf+1xPTTxLb7XDcdq
         cEECANMJisn1UsZK32zTL6GGjieuoEiQo7ceBEY7tB6JnNp255dVoGPKepwNJ9XhGfAa
         XkAiy3P0TMdXUvINYeXneBO4oAGSGCc9GNgDNWzPgUBonvJ/PbbcIzMn4xSiuBD+ep/P
         pGCw==
X-Forwarded-Encrypted: i=1; AJvYcCXtePxeFjVtvUuCeyGT5GzNVekfGAYgr48N69Fyji8Au4Kaz/d9EOcZhmL4OFgt63hzX+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOjgQBVIN3BQniQeh3suLpsv5AURqjgWkXwU9okv1A/WEPIrv+
	HidhpqHOSffBp1oQ+BwCgDCCMxG/uV4JNHhSWDXCfypfc5FE9pIIz7bg
X-Gm-Gg: ASbGncsL8grGWDAQr1i6TSNBSc+wld1REmC3pWVCP3mkBnyzdMZCsco8uRpcoBTF3E5
	LSSqjsIEDLnoziLPNW1keCurTmP1UiMfReMYbLXy/kOf/GfEmTAP7t8G+L+9wNccmz4bacWds5L
	oHXIYXxiHD7Gs+BGebuiV6gxJ5gH8P66r3EkP27tzUTNs+meNroit0NhwBOK+M0npUnNQa7B2JD
	NiB3p1caI5yLBIsJfC4T1f9v+P5c4WJxtzXiBFpVMAW+06yV5pubCSFl47yB84btq+pd5lc6lxN
	G1ao0p5pvy/iAAzCucXdLEI0k8l9hsqMMwM/WJYY9U+wpgs6uT7luwcMD2MkaaO3KnTKg6nP12S
	pONBfEW7ThyAgk5dY/JIsLKOHDnYDdvyTPouwWTLfXxRKCQyWKb9x6SlL6wLy+Qj9hqMS2A0jC3
	7DPKqZMilvkS3zWpjSC+4eFZA=
X-Google-Smtp-Source: AGHT+IErVS2JOE3R5hBQa8n4PbPRX0Rck8OX69DTgD6n4Zc+qBzm/AdH+8FlYt/3YOXPNZAECFyIAw==
X-Received: by 2002:a05:7022:6094:b0:11b:ceee:b760 with SMTP id a92af1059eb24-11df0c3b2ebmr5592261c88.23.1764870996269;
        Thu, 04 Dec 2025 09:56:36 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76ff44asm9415387c88.9.2025.12.04.09.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 09:56:35 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 4 Dec 2025 09:56:34 -0800
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
Message-ID: <2e069056-645e-46a5-b1a1-44583885e63a@roeck-us.net>
References: <20251204161729.2448052-1-linux@roeck-us.net>
 <20251204082754.66daa1c3@kernel.org>
 <536d47f4-25b1-430a-820d-c22eb8a92c80@roeck-us.net>
 <20251204094320.7d4429d1@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204094320.7d4429d1@kernel.org>

On Thu, Dec 04, 2025 at 09:43:20AM -0800, Jakub Kicinski wrote:
> On Thu, 4 Dec 2025 09:16:16 -0800 Guenter Roeck wrote:
> > On Thu, Dec 04, 2025 at 08:27:54AM -0800, Jakub Kicinski wrote:
> > > On Thu,  4 Dec 2025 08:17:14 -0800 Guenter Roeck wrote:  
> > > > This series fixes build errors observed when trying to build selftests
> > > > with -Werror.  
> > > 
> > > If your intention is to make -Werror the default please stop.
> > > Defaulting WERROR to enabled is one of the silliest things we have done
> > > in recent past.
> > 
> > No, that is not the idea, and not the intention.
> > 
> > The Google infrastructure builds the kernel, including selftests, with
> > -Werror enabled. This triggers a number of build errors when trying to
> > build selftests with the 6.18 kernel. That means I have three options:
> > 1) Disable -Werror in selftest builds and accept that some real problems
> >    will slip through. Not really a good option, and not acceptable.
> > 2) Fix the problems in the upstream kernel and backport.
> > 3) Fix the problems downstream only. Not really a good option but I guess
> >    we'll have to do it if this series (and/or follow-up patches needed to
> >    support glibc older than 2.36) is rejected.
> > 
> > We'll have to carry the patches downstream if 2) is rejected, but at
> > the very least I wanted to give it a try.
> 
> Understood, of course we should fix the warnings!
> If we're fixing warnings, tho, I wouldn't have mentioned -Werror in 
> the _subject_. It doesn't affect which warnings are enabled, AFAIK?

I'll update the subjects and descriptions accordingly.

Thanks,
Guenter

