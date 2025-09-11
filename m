Return-Path: <bpf+bounces-68184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F44AB53BEA
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 20:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6CB5167D9E
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 18:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999FB23E23C;
	Thu, 11 Sep 2025 18:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e43Om9u2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14272DC76B
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 18:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757616940; cv=none; b=gAOvUWjo4Yq2UM1Do/gHQC39UcaAcQm+vZzFTyLgnaA8sDDOlMFYyFHgaGkA/nZUQT5mIxScd6LLqKRfAVd8RznaHzjvPvrhEoNruua0nXtq36QjAlGVyzKw4yt0D82C6XMIhlCdY1ejN7r5MH4urCmeAybhn1tzZCmMBka86Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757616940; c=relaxed/simple;
	bh=m2jcVNZG5ZEX//KdhkQchWo3YzS/HwpPe9b6xmpZ+pA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hruEsFoUbRg47ZWXD/TkQfYg/8doXv58jhlzhOk+F1Mztr3O6UgTGgpLvNY1EXXIHQklwfdQPNJ+1ueuxykr98McFmCEyQeK3L6q4akWh2+hGz+oxw6WoNumby/rXY8RCAltSHc6XkO/J130tkACPDbgL4ylMJzdIJHek12UY4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e43Om9u2; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-62ed8943293so74774a12.0
        for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 11:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757616937; x=1758221737; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m2jcVNZG5ZEX//KdhkQchWo3YzS/HwpPe9b6xmpZ+pA=;
        b=e43Om9u2J4wXAVUmZPey6WMydZR97hRakWgwclHSxn3RIVsSwwYJOxj6BetrMGaTEo
         EKjBtfUUwzVtTFMIb4GK7fvnehY5gvvKIQDB24k830QbZ9+eZjLzV0MqoHGU7bZDPpoG
         uuS1AXzrLg0vL3ZmUICjJiel7lHxtcwDURrfqN9Ipw0ahsBA17gr2AdSd9oORiWsR8ru
         wieSOsMs5MXZe+Ql5UfUy7WgCQXXLsNikz3WRSEAd9OIejvZwYaatl5fjVFlctPyMeYS
         cD5NSeRJpun56gCasga3pYV83JCUctorf4MCDOs/F+hzoUGJrUtF/S0PO3OjxW2ZaPIE
         kRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757616937; x=1758221737;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m2jcVNZG5ZEX//KdhkQchWo3YzS/HwpPe9b6xmpZ+pA=;
        b=a44jMCIKka5d0a49LPg3dUN8S72gYMZSQVNfQp4jArtpFTrDY5hBqa/SYU3oYGk2Vl
         5/w0cA9FkOOA9MjtcSoI7Ug4efzWk+iDxcU29j/vLwFL2KYU8vIWu5Tq0ZRfq8qxDcBp
         m6iI4vQpMbJby1+PobXyr0JkcpzuiLMb31SJvcJvUxLYDsZYdnCc/Zh5a3pBsCzDwQo0
         oyj++0FDXfyxTPro1NatrDfFJl28w+xYRfRCYRrW9nemHCBXyMxFWQljShk2my7np8UO
         wbLY+Ym3ctJJPR9mgVtXXmFnx7ooTLU/XlAw48SvfPzVJAo8hW63NP96lV+SEvHkxY+v
         vh5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlmG6/hYoVWAEzkTnRaaiZP6AKKPuuWVZ8Rufv41HwRkkl+iuGH8atGjlgVU7yXU7Sinw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIA1TW62QR4knK4jeSyxNf01hhle0J4DZRH5w/kUXA1CavjmI3
	MKaPhV1TDY6BaxrUVNf703E6/I5Fz2dqyEGAHdkP7ihlHf4nLHy4V6UERUriW7kyHSOZKuME6nn
	d7B+A1mgYPy6ztihNZWvqGRozScSZIMo=
X-Gm-Gg: ASbGncuZp1rTdSRV5CHu0dO+0xN2wIMWwQUelxTk4LzO92VlMiuIW14y0hsQXkPOFyC
	OxrxUt1sKklJ3eIqUs7ZYGX7GevC3z/D1ShH/mo25TyoqOG0WsCS6p/swhrB4wPD8Zt3Cfjnvmf
	1s12bJbChSyZKHkFZfyiXDnCsVXnNekGaM0KIVRYHYeVSZhq5/XTifwmFYjzX6Q6EQJmnwXXyG4
	NYOfUfOuPRJ6kw6SP5RBQTpb1MxAOWNRD2OmPmucoQvnXbZnSs=
X-Google-Smtp-Source: AGHT+IEr/IXWvEUVKNsBGH0b6WKj5dtPERuUwd65HpbSHS/Si0ATzF+dMBUKu5XaI1NgzAcEsMt3X3T2BqcjI5LqX3w=
X-Received: by 2002:a05:6402:34c2:b0:615:5f47:8873 with SMTP id
 4fb4d7f45d1cf-62ed9b83478mr361064a12.14.1757616936967; Thu, 11 Sep 2025
 11:55:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911034655.3916002-1-ankur.a.arora@oracle.com>
 <20250911034655.3916002-6-ankur.a.arora@oracle.com> <aMLdZyjYqFY1xxFD@arm.com>
In-Reply-To: <aMLdZyjYqFY1xxFD@arm.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 11 Sep 2025 20:54:59 +0200
X-Gm-Features: AS18NWBPwTweWbcsaGIAULsh2_u-nhPNn7i8e_4UZM3wX-YxIBKFfG4Cq4wNso0
Message-ID: <CAP01T74XjRJGzT7BV3PYQOQOwZVud3nL7HfcW3kzU_fPFekNHg@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] rqspinlock: Use smp_cond_load_acquire_timeout()
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	bpf@vger.kernel.org, arnd@arndb.de, will@kernel.org, peterz@infradead.org, 
	akpm@linux-foundation.org, mark.rutland@arm.com, harisokn@amazon.com, 
	cl@gentwo.org, ast@kernel.org, zhenglifeng1@huawei.com, 
	xueshuai@linux.alibaba.com, joao.m.martins@oracle.com, 
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Sept 2025 at 16:32, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Wed, Sep 10, 2025 at 08:46:55PM -0700, Ankur Arora wrote:
> > Switch out the conditional load inerfaces used by rqspinlock
> > to smp_cond_read_acquire_timeout().
> > This interface handles the timeout check explicitly and does any
> > necessary amortization, so use check_timeout() directly.
>
> It's worth mentioning that the default smp_cond_load_acquire_timeout()
> implementation (without hardware support) only spins 200 times instead
> of 16K times in the rqspinlock code. That's probably fine but it would
> be good to have confirmation from Kumar or Alexei.
>

This looks good, but I would still redefine the spin count from 200 to
16k for rqspinlock.c, especially because we need to keep
RES_CHECK_TIMEOUT around which still uses 16k spins to amortize
check_timeout.

> > [...]

