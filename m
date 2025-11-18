Return-Path: <bpf+bounces-74941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D2629C68E13
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 11:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 895D02A815
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 10:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FA134889B;
	Tue, 18 Nov 2025 10:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWmgDaQF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D3233C515
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 10:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763462572; cv=none; b=b/fCVRL1Xq+iQoG+wezK8dtQ6cp4MDQZJ2umanH9x5WHcvVTrADGBSc0oswpkupi8qxTe07d1IaOhHjltYWIiaaKystxVNaz0sJqBgnGqruFgq56sWaYNaLmCULq4wbduRFicICHDeYSBJs3fVGn03BDCypAdw7BS6OPfBid7jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763462572; c=relaxed/simple;
	bh=vpkBfMqQ3K5js2CMNGkRdtr+acWamucEKHJA/OdeC2U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YAffI5WYMf+SWHA5dAmSYmkbPOhBfHFpg0i7zhE+obV9I010Ptxq/LFHH+2EZHAgpfiQ+UrnPnXV6fi6Th+SPFSL6/KTcxnLrgQCDBNpR6mHfd7dd+bn/fynySO4dgPNjvforaRO2KX777FatzXyTL2h8aTWcc55bV5GAxuo3YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWmgDaQF; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47774d3536dso43970165e9.0
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 02:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763462569; x=1764067369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LNZ7kLM8T15IVuj4fqsK7U08DBmLHPEhW/eCbNKEog=;
        b=WWmgDaQFyhvA/kqq9+cGI1FJ/H6FW/W44bkeDaGERbIO/AXZBJivXy+ypDfuWnAFD1
         +/VFdfwGgBqEZ/S59jv4HiM+a22nr8gf1qRxYIq2kcRsECzq9VyK+ZX+2yYnpQGz7jXT
         k/m80+DtX0eBQh2TU28o1LJT9AWlzmlPfbiu/2B7FptO6t4P04aUL5Z52VPDwx6eI1r0
         GQ/KiznA/t2/qHN6ik/6zMliHWuefZEYdxDtIga09tuxUD7M0YOT1PPQZtxfkY2ITcb8
         lXgd3OnyatTkYqccTkaVB26IkgScY8c97vm30Jjs/t/60v/U/s4lyYT5PwsNrMYJ40E9
         S+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763462569; x=1764067369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3LNZ7kLM8T15IVuj4fqsK7U08DBmLHPEhW/eCbNKEog=;
        b=RcNUqSh8IHg5R8DczmEg/zsFr1ey8aSuS3nxGzn+cdUd4Fc74MThCnbroijawU6ZP/
         Sojb8T/+mdcfxL+PSS4hRQQ5pnfi2CHCzuqCb/37Ba1dEmNXZsbpN+gPguc6HQhWhlHn
         NTBmS1iKBk+ex2BYX003uCxvRfGmt0z213DrXLrEJpKUcjGYch+AxkzZOfMIgZPej7y2
         EjY2SXqapj5hsJMxARY5yoyrVcIbiWQ+BsnGnqBGKsq70cvTKgdbfkZKm9iQLdS95OJZ
         82nDztlMuEYzrpgz9L1f+ajsgFiX6gawFoki6sONMaDbu59vEwhYvD016LU52KbbscDa
         rUrw==
X-Forwarded-Encrypted: i=1; AJvYcCVLmWzSmZUOtk/ifFvxCr4NTWcLmUa4YNci+YE/JGoCiIO7ERLD4SZLjw62kqsQSDVW8qA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0J3Pvn47vZgJKhruIdwTKRphsIfaKKgXGGYRz4tvwIt+SrNFN
	kytJYYOo1Vct1mDRWYL7g7r8saokfxKtZIlYonWLgqkBJvqbeqXO3kbC
X-Gm-Gg: ASbGncugoIJPOuG8HiMFpiyYu+3fw2Y6EEsJIoMjQxn7jUrS0YTwvLPVm7GsTkMCMiA
	z6NhyVd+Z0KWnSocHki+5qXngJFAcS54y0xYL6/aPbxElXVXGtE8CpUK0DZjEj87AtvsnVnqg2S
	lm32JRqP7mvl13db/QCjr4Ai9B/U3m7GDuuCSDY+1VdteKDZxg40sXU1DE8ArBIM/IGPYJzfG4B
	p4uAoZceGYHIoKA7hGLuPftWywFrXPGyiaxSY92keApF+kPuHNhoAYP7U0o0eyeynUYNoYCpnJw
	oobNsVeA9P5kmxDcz0vBHeNjNvXr4Y/FwrO0u0fN2xWbKR+lLmJg/S5SAAIdF+jG+wPRnRfra5g
	d3n4CdYOMFkXRgPssy3VdaXAiWGRoMxPdHPHM5wmUgEgPooG4IT248OGy8SKcn7uHLPM3iFsA01
	DoSxQQqJ+bVxJd5xHbQkbDGfvBa9M1OYjIcD0ruI1oOAN0LeVfEmhdPTu+KFvfna9/+ZKdiuxSc
	w==
X-Google-Smtp-Source: AGHT+IEBUYaX4Bp2LkqHG3fEIEVxQRNem8L5c5rq2F9Th3HxY/EOPdLBnO8LsPHmltiaFAAMNb258A==
X-Received: by 2002:a05:600c:3b13:b0:477:9890:9ab8 with SMTP id 5b1f17b1804b1-477a94acd85mr27682085e9.3.1763462569245;
        Tue, 18 Nov 2025 02:42:49 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4779a2892c8sm182555035e9.1.2025.11.18.02.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 02:42:49 -0800 (PST)
Date: Tue, 18 Nov 2025 10:42:47 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v1 1/1] bpf: Annotate rqspinlock lock acquiring
 functions with __must_check
Message-ID: <20251118104247.0bf0b17d@pumpkin>
In-Reply-To: <CAP01T74CcZqt9W8Y5T3NYheU8HyGataKXFw99cnLC46ZV9oFPQ@mail.gmail.com>
References: <20251117191515.2934026-1-ameryhung@gmail.com>
	<CAP01T74CcZqt9W8Y5T3NYheU8HyGataKXFw99cnLC46ZV9oFPQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Nov 2025 05:16:50 -0500
Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:

> On Mon, 17 Nov 2025 at 14:15, Amery Hung <ameryhung@gmail.com> wrote:
> >
> > Locking a resilient queued spinlock can fail when deadlock or timeout
> > happen. Mark the lock acquring functions with __must_check to make sure
> > callers always handle the returned error.
> >
> > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---  
> 
> Looks like it's working :)
> I would just explicitly ignore with (void) cast the locktorture case.

I'm not sure that works - I usually have to try a lot harder to ignore
a '__must_check' result.

	David

