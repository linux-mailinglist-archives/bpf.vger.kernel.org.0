Return-Path: <bpf+bounces-73066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F433C21CEE
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 19:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE0BB1A2054D
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 18:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544A436CDED;
	Thu, 30 Oct 2025 18:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mr6yogZa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F64036CA95
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 18:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761849749; cv=none; b=BsJwxG22/h/ZioWlkp+JnBgogL2gG0yIbSbQ6Oxnw+gOTY5eWM7fZKNxXAsUQgUuN80B24O4mhQLJwBlDapNojebfd+gqNLqhwOaD5gLBLXZGP26b+0rSUK36cR9NSw/nef4K7sYBUYK9MEudLCD62QnFqLcGbTC5Z5lAYLMS7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761849749; c=relaxed/simple;
	bh=fqtnOdojOdFfgjwtxnv71uAMW/0p0vRttvQJJj7ox8Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l9QXNRjtIVKRtQlDVKokBUT/j3AR3eHMXuLKJOPMmqHqqhCV/1guj1qKGSQfarE82HVz79cJH4aMegQY6iKXfc64wKW0o4wLrnlLwk0FsREn8qZ/gTCi0OUMyKJU98gKNqjnY0Z13LwjQsSqnhs6wux5TRjeLlGDeR9TuDBM0UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mr6yogZa; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33f9aec69b6so1861251a91.1
        for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 11:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761849748; x=1762454548; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fwrkrZIUazJ7bwJv5R2Mr8CVBfe2F2MQtH76Kc4QL0U=;
        b=mr6yogZards/f+97gGCpQxv75Gfbai9BnLx5ecRHTldW644NNqJ7Im/2K+FqU8mtUU
         K1yGCHSrm/9uBDxf1X+kksYl0tijQH64AgYGanho6JU4tDv6YaKeW/lMhChWOMcofflQ
         itzvzD/hq1vsHXnPhN+co8LWMFNHrjTrJskC4WQkW29ToHVjfM/h99Fskr2412Ez6Fu/
         Bs8yFfA9+SWZ5dTHDu0NgB3Ko4LswpOtgO7nb7c4OlR1BuirilyBaUHTszq4vpWGwFr5
         TpWg1aCk+67/FVFFhtAfEp+zglWFa0jR2DSTWt3bWgeXDNE0z8Ni1x47GvGEthq358Ay
         bONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761849748; x=1762454548;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fwrkrZIUazJ7bwJv5R2Mr8CVBfe2F2MQtH76Kc4QL0U=;
        b=f/lZw2Qi1tJAgnASozGz9RUEldAq1tKnnx0YTA6wKH5g1AOT05A3t++sPceDz/BUT3
         vcr05kzQ8U/zezW/m07/7ONiyGGOciPTRalUFpLUGIrA/W869A7w3Vql5NYR/GvNuSby
         3YslbOGYye0h8CcKcfEAI4+6LfaMiQskidkBzGCOBUKb74hkDAdib1FHOiNwaqSq8Oty
         K1QfqyZbG+8l/S1cGDjgDQvOt+rE1XK6zgAniUyCW3K09IZFd9qG7DcwMehJz3yFW9a0
         p9W5ECBPZNsT5sI19KYZSw2WraTGwr3/B0oJ7FvBM8amUTINBFUivsXuXW0rGg6eFrsP
         TGfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1mYRu7k5Fq+II9A8i0t4DCquT6MfB66kJvWc3iZ/3M9MXhM4YMYRy7SaxYZ2nI2pZgNU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywng+QKbV8MLrlWBB1+5UmcGX/Ta36AtxFxjxUhKm0J/4ovN+mo
	Kypx1Wo9HjSsNDeTvKGVtpewj8AAlWPYCLvsxYC6m+bi+oKNGR6pnLvD
X-Gm-Gg: ASbGncvoQ+pI7jGgj54gbn3ST4D8zJi+4uj90AYPXwG+HVjTkrK0ANCMMAirX/WaQwf
	OhuKT7LyWd7f3UaBAejirUxR0zrDN0ha/DRQhTT97e9C3Ou0eJ8lJ1WsDhp80/YdFovTgXhojC+
	9PLNLQXslysQfshWyRz9f/rzlGocxjGhUzauiSHG8cvVyYvJ5NWeTcJvJJILz0iKWoeY1/iQHmj
	Dqk+xY+5p8qdPJFtWwL35+/KmTrm0G7X/CxCgwexKkwSPW3PCkOwFA9faniIvTtcrC1GbVeNTbi
	u/5zEY7wxYp+PW/CTFJJ0gbdlcFz1RMU968lhGsH2GOAQwIFeJudiLMQ9cQOvoUjPgHb5WZOMyh
	qLr41MmxtxPVWmhzXvxZgkAXwXYtp28bWBIcs1pAcvC05QaJ3jU26TsKjcpR+bhHsT7emzaaqWv
	KBB+MJd8ap
X-Google-Smtp-Source: AGHT+IEOmCJTpNFIXtxyOp5mwzIkcVae3pLCciRt7rZVx/1uKSxUgWjvR9oDLlzFVkUnfq1L5jZwPA==
X-Received: by 2002:a17:90b:530c:b0:339:ec9c:b26d with SMTP id 98e67ed59e1d1-34082fa950bmr1078051a91.8.1761849747632;
        Thu, 30 Oct 2025 11:42:27 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34050b9edeasm3349299a91.14.2025.10.30.11.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 11:42:27 -0700 (PDT)
Message-ID: <4558f35eb191c2605542b368f1dab4f69231ab8c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 0/8] bpf: magic kernel functions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, Ihor Solodrai	
 <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, andrii@kernel.org,
 ast@kernel.org
Cc: dwarves@vger.kernel.org, acme@kernel.org, tj@kernel.org,
 kernel-team@meta.com
Date: Thu, 30 Oct 2025 11:42:24 -0700
In-Reply-To: <145364f5-3752-41b7-92d9-c97437b95b9a@oracle.com>
References: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
	 <50ddff79d33d6e2d57e104f610273d647530ddbc.camel@gmail.com>
	 <99115d79a7808ca1290726561e36b64ec56e2a1e.camel@gmail.com>
	 <6e0b67d02cf7243b01a163589b3b58d1e4a0fdd8.camel@gmail.com>
	 <145364f5-3752-41b7-92d9-c97437b95b9a@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-30 at 18:26 +0000, Alan Maguire wrote:

[...]

> Okay so bear with me as this is probably a massive over-simplification.
> It seems like what we want here is a way to establish a relationship
> between the BTF associated with the _impl function and the kfunc-visible
> form (without the implicit arguments), right? Once we have that
> relationship, it's sort of implicit which are the implicit arguments;
> they're the ones the _impl variant has and the non-impl variant doesn't
> have. So to me - and again I'm probably missing a lot - the key thing is
> to establish that relationship between kfunc and kfunc_impl. Couldn't we
> leverage the kernel build machinery around resolve_btf_ids to construct
> these pairwise mappings of BTF ids? That way we keep pahole out of the
> loop (aside from generating BTF for both variants as usual) and
> compatibility issues aren't there as much because resolve_btfids travels
> with the kernel, no changes needed for pahole.
>=20
> I'm guessing the above is missing something though?

Andrii does not like having to declare two functions manually in C code:

  __bpf_kfunc foo_impl(p__implicit);
  __bpf_kfunc foo(void);    <-------- don't want to declare this explicitly

But prototypes for both functions are needed in the BTF.
And the only place that can invent new BTFs is pahole.
Imo, that's a bit of an over-complication =C2=AF\_(=E3=83=84)_/=C2=AF.
 =20

