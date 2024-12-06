Return-Path: <bpf+bounces-46226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBC69E6381
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 02:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13B9816A2A0
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 01:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D202813D28F;
	Fri,  6 Dec 2024 01:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLjRe1wj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE462BE46
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 01:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733449479; cv=none; b=qkLuSvXgr2RrGqaEju4X89syDEUgGVLOAcN0syrTPB9N9bE5LYQejh6D3n+2gwibrQBDynf1C2JKhTt8tOSWZHJLN/0pMrHegh8WWl8t6kj3nF0W1rGRwQjkBbBQHbiD2OtWLQwCscDfhcjHJSznJvOYIE7oFme1PKooebRxa6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733449479; c=relaxed/simple;
	bh=i7boByzzS1vJXIP+6xyDGF5Fv8Sh6Y90stCj3gXxlpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qiA/cEyyjy4jB+oNufX3pJYnpssoFe8AJ078if2jyuyTINiySNgLeJsmtrqrWrDsWR53Crry2uukI1utLWkvjoBatRwLrSmxTfYxbP+JdXgmnYtsiJnzu04pEeD8K1ou/uRE6h6bRZ2u/SAH3FBKodlcfLUsFfgtY9BN1Aquzpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLjRe1wj; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434aa222d96so17799935e9.0
        for <bpf@vger.kernel.org>; Thu, 05 Dec 2024 17:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733449476; x=1734054276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7boByzzS1vJXIP+6xyDGF5Fv8Sh6Y90stCj3gXxlpA=;
        b=nLjRe1wjZYs8M16V5+aBzKEqYpuQ+ZSRSmHWsy0VsE5bkMFPlMKZzAziOj506CzuFv
         JjcvnykvQgH/CdK7+Q+uoI92mPWDw/SRVnUvLDr5xm83BEvd+QN9FAvwFEtCMNT5YwHL
         VrCVHcQLIA4axc4khKR8bYGk4J62z3Dt1A+L0QPMzej30JVyV2je28YaNr2I94xM/ITk
         4zgKW5MLoqPEkK8qUY3AkJaJdaZ034G6dRUwt9kiCz3/uiiylc9F6c/aSeYSsQ0LDNxe
         5b6LVGmg70zffnInD/99AIqmjDIkSMwjyEjjPYSNnIVQ/IRq4G9gmeLHIj/YN9ZhhIUc
         axTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733449476; x=1734054276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i7boByzzS1vJXIP+6xyDGF5Fv8Sh6Y90stCj3gXxlpA=;
        b=o9EX3syYkqLjs/T6nZb4OaWB+jbCiEM7tncOUM8Ka7qMCqK0JDd4iCCVBxSDnLoy+f
         DzMDEbdETcvBVZ6C1IZmCvDSTLrBkhVigVyCRToA8JlZ0v6Br2kkPEsn6Fj0adPZc5dY
         IepBY/W+AXOg8EXXFA+Cvd+E1MuNQ4ri4jJ+efybDjOIeMd5yBRHOrrNmM+fRGRuUMhj
         FNO+pBLAXwX+04wIXaraaFC0FlNfHZzCPcOBj7nTe5lyr6YASh3WNsi0wlBj3E++Wr8a
         cAAfdyeJKwuQ7REieldC5wZrTtO1Uae/A+/okyiWNAEN2K9VQDy9srwpsWXbGnj9faM4
         Shbw==
X-Forwarded-Encrypted: i=1; AJvYcCVtqqWLEuQWvKSaFJmlpr/VEBC6ejwiZY/9NAODuBXuyksn/5WTzHA2gQROMPsP9FZUTK0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs22zGqJAXIuiTxPdW4NHz3wS3t05hI6CnI5GKQdndPbs5fQDw
	QeBE6Es/sa2QLPLHfEhnOzsnxFi3PWsj+Ll4UFrfapHlm5XE7MhjbO6UHOagYabSSL39m6RO0wJ
	772P/e909QkOtbjlHh66PUaBwkRw/gA==
X-Gm-Gg: ASbGncu00yKcXJwsG939y99JFAy4P5vR4OHE8hBoq/7HQpYgQR8vxbIAHQDsZR+9scK
	69YNf7Ppa5PLZGgrUjL025C2rwIWsDivspoFn9NJu8PDI4kA=
X-Google-Smtp-Source: AGHT+IFuaQW9E+MkoGFGy54BYBCXj7134ayA7AZOrVsF5IcZP4Bomsgrm/8EWmRXptuejAc9FL3F6DA3i0+qltR/apU=
X-Received: by 2002:a05:6000:4601:b0:385:ee3f:5cbf with SMTP id
 ffacd0b85a97d-3862b363658mr810273f8f.20.1733449475900; Thu, 05 Dec 2024
 17:44:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0498CA22-5779-4767-9C0C-A9515CEA711F@gmail.com>
 <1b8e139bd6983045c747f1b6d703aa6eabab2c82.camel@gmail.com>
 <47f2a827d4946208e984110541e4324e653338e0.camel@gmail.com>
 <CAEf4BzZBPp40E-_itj1jFT2_+VSL9QcqjK4OQvt6sy5=iJx8Yw@mail.gmail.com> <4bbdf595be6afbe52f44c362be6d7e4f22b8b00f.camel@gmail.com>
In-Reply-To: <4bbdf595be6afbe52f44c362be6d7e4f22b8b00f.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 5 Dec 2024 17:44:24 -0800
Message-ID: <CAADnVQKscY7UC-5nAYxaEM4FQZGiFdLUv-27O+-qvQqQX0To5A@mail.gmail.com>
Subject: Re: Packet pointer invalidation and subprograms
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	andrii <andrii@kernel.org>, Nick Zavaritsky <mejedi@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 4:29=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> so I went ahead and the fix does look simple:
> https://github.com/eddyz87/bpf/tree/skb-pull-data-global-func-bug

Looks simple enough to me.
Ship it for bpf tree.
If we can come up with something better we can do it later in bpf-next.

I very much prefer to avoid complexity as much as possible.

