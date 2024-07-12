Return-Path: <bpf+bounces-34680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A60CF930118
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 21:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 515271F23F8C
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 19:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1751B2AE7F;
	Fri, 12 Jul 2024 19:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJQsu/wO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4751C3A8D2
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 19:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720813625; cv=none; b=c3NRG2fwMGRZEQCzu9VXBoi6LsG0amM9f8AI5ndA3EuTtaO6PuTuVwQGyxkrPI9979xoofSvV1BTUCpXD1Mq6z/3iwTEMyaGanYnw0dZ7SviveDPY7iDDyU4DifqCj4xcqjIdyzXd47E8bWmIOsgTVJN5BHNrsYQuL1AfSWxWX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720813625; c=relaxed/simple;
	bh=rZbAxYnS2ZGny0NBmMav1VrDkV/1yJkEwToZTeDmftk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pFUG9E0WrVW+lsshwFqIv3Z5RWJPEVaf4w1Ksn0TYCY5YPMiW86m2BvjwMbuCcU6dh0vHB+OiH36KKWHLonJV7yFepReZq04m1TZjGJbCeCO3vS/B8XUka7Z9WEeTgzBi8iXEKcxdgql+8H8Z2b8v/Mn5bt1mLPJeIWdUun4kw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJQsu/wO; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2caeafd16deso46855a91.2
        for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 12:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720813623; x=1721418423; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1MwBQDIRuWVMABh6mDVBSIRRzcdSrvVXcMyaI+De0zg=;
        b=PJQsu/wO+FnioKsfnyXsj8tVMFnPtrvVrn0yl9T7m1QHZMMeP9Rl77w54lN0iVP7jG
         +EGGsaletUx9ckR7LIYe9DyVGBC79ZUUv2pvQHGblh9Cg1Y4rFdSRP7xHnYRRtX0v3l1
         xr0563JIwv3NM1w2bcC1Nh14FaZgSbHxCMKEjYwHzS2A+WpKinptht+q8l/YSSxn8AG9
         YBdqSGeG9p7m8TKIEvMRFFKwHLLEEfDo0tqATtiPuKeObAqq8yGO/in+9hu2C5XXLf8T
         FsSkGkdZX153kgDhJm+dFoqCv+4+jO6gUq5xKGChUtc2QLwtxHa/6wK4X6BDhcstS97N
         QzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720813623; x=1721418423;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1MwBQDIRuWVMABh6mDVBSIRRzcdSrvVXcMyaI+De0zg=;
        b=dXU6CwGQtA5eQfoegXJA3y8tlnwUb/P+GeEWB3t17rgE64JnB0pfiSeEEfSWUVX0C1
         YyPVasH/IOIzmbYMHzOozIEV8+FNUw3ofLYjen4A+PkB9KhUN4niNy0R1vjt8bFz+D1e
         CQh8klhsn+Igqpuwyx7OiAf6XCM7DyZLOP4sRJwJGL47BeG0gq2kZaSyD3PNnwlhQdt1
         mFv6TMpL5xPsPcZygUQdMpPauC3BpJgrseIEKaynTPAGMuvuskH60PJfCz9gOMS4g1V5
         4VCWSPny1u7cWxBjbzSxRxdj7dPwjbUSX7Axx18WhBbtkgIE07/d5cRSojljctQPxg3g
         yl8g==
X-Forwarded-Encrypted: i=1; AJvYcCVPIDZ1EkzMAr4Ln4N/q4jXjG9M3C2Zwqk7Eh08rN5kWmN/ZQCtsXreGrJj0JOZfBu3gmy67Pcqrcl7VEH8sTIWSKCc
X-Gm-Message-State: AOJu0YxVqFJ/7jEn4TZEBfmW/R74EH1lK2MZ/fTCXRehjeAnfQ14fHqO
	3BHtvv2v+WRJ8JSuNiSU2owajkBk1pRB+D9uZFW+uJ3awZh/GXA4
X-Google-Smtp-Source: AGHT+IGjWAbeSDc59+HGLhHaGPaqSo9N4DYIV8799bvUfclTD40SytmwMJt4UrQJhkXRWT3jxpEQvg==
X-Received: by 2002:a17:90b:4ece:b0:2bf:9566:7c58 with SMTP id 98e67ed59e1d1-2ca35d6e171mr10468748a91.41.1720813623525;
        Fri, 12 Jul 2024 12:47:03 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cacd40a513sm1946091a91.23.2024.07.12.12.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 12:47:03 -0700 (PDT)
Message-ID: <b97340645b9a730df46e69b03b3ccba39816c414.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: use auto-dependencies for
 test objects
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>, Daniel Borkmann
 <daniel@iogearbox.net>,  "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "ast@kernel.org" <ast@kernel.org>, "andrii@kernel.org" <andrii@kernel.org>,
 "mykolal@fb.com" <mykolal@fb.com>
Date: Fri, 12 Jul 2024 12:46:58 -0700
In-Reply-To: <CAEf4BzY4kXRSci3Lb6ZFT7++6fics-w4_8rYMB4vCEHgrCWEnQ@mail.gmail.com>
References: 
	<gJIk-oNcUE6_fdrEXMp0YBBlGqfyKiO6fE8KfjPvOeM9sq1eCphOVjbBziDVRWqIZK1gZZzDhbeIEeX41WA34qTz82izpkgG-F6EFTfX4IY=@pm.me>
	 <dcbf532f-bf17-bb8c-f798-987bce607e5d@iogearbox.net>
	 <R36QrBuK6nQziAeE9Xb-8295ISr8B1ofPVAdWaR3rygfaDiHUl2I5EmG2xoCrEskurmOmclGak3JXWwxso43KR9M1LHsdOIt48XS6xe3PVI=@pm.me>
	 <4d757f19ac6f7e17da2e87f482f129e75c6decf8.camel@gmail.com>
	 <CAEf4BzY4kXRSci3Lb6ZFT7++6fics-w4_8rYMB4vCEHgrCWEnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-07-12 at 12:20 -0700, Andrii Nakryiko wrote:

[...]

> > An alternative fix would be to specify additional dependencies for
> > core_reloc.test.o (and others) directly, e.g.:
> >=20
> >     core_reloc.test.o: test_core_reloc_module.bpf.o ...
> >=20
> > (with correct trunner prefix)
>=20
> I was about to say that not all tests use BPF skeleton headers just
> yet, so we have to have a way to explicitly specify dependencies. I
> think a separate list should be good enough for now, and in parallel
> we should try to switch remaining tests to skeleton headers. Even if
> we don't want to convert tests themselves to using skeleton structs,
> we can convert them to use elf_bytes from skeleton headers instead of
> loading .bpf.o files from disk. That should eliminate the need for
> extra dependencies.

For the scope of this patch-set, I'd say specifying dependencies
in the Makefile should be ok.
Or would you prefer migrating tests to use elf bytes?

[...]

