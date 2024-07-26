Return-Path: <bpf+bounces-35724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C19593D301
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 14:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CDAA1C21D2C
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 12:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8586B17A5A1;
	Fri, 26 Jul 2024 12:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsMJLqAy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BFB23775
	for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 12:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721997101; cv=none; b=h1Ux2Y3L4hfGt3jEM+P2wUjhz4y8QCKDA30zc7roSONKeYbAHa2qKP+t7cIpkZB4zu89Kl0B6tts2b3cr5rfPq49094Vhx7r9zpooX98Oe/oIXR/a6noX0sEiunAbWUrAhtrqwmnOBwbRHAex9wdUBFDY1EvEJxG9/HGGSyVxRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721997101; c=relaxed/simple;
	bh=jQZjG5/btz9gPY/CxEIVekQbicm+SG7rpXQ5Q9C6aXE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgMcapak+NkqdK4o54LsHG0IcdFw396vzH/+F3nKhnujZyjgq/mNvRJul6dX+L1ns6yf9lOaAtuQYJVYAoGjfwKHU+8jGMBZ3wEY07eaKPzBwV/ZOZxKA30O/6z9B590VDWFX+vZxZ3cEGBF7RAnOmcUj8ZcK+JYTYRAd2sHlpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UsMJLqAy; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7a8caef11fso183546866b.0
        for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 05:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721997098; x=1722601898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PJrBvfo2zlrU7WCRKlFsrOVZ5D9Gg7mMKJJjvLeiuM0=;
        b=UsMJLqAymw3aihBGAGPN67OKernWIVzbaC2uMW/r95k/p092lWvRCEiGG6C5hmA2Fg
         cVOS2LpkS1GUSobB2be0SUcNLDBo9HXoE5+plaQB82O9eLtXdY1ddDELPKU4JzRcn/67
         eO0wcrtHrCWZ/18KXIUP9FfOYVOHYOrZYW4ns72pa4y7sslaU2M2Y0iIX6EDEkiUc17N
         v4unr29Cc9VV0CRsIrFti4YcvIB8PaQHWGIuaQ41GD5H57Wk4HsuJuP73NrjbIvlhK9e
         +cJsVpLmNkkssvYbL357T/mP2Hz7F2/+uprqO27ONomXrp1U+pjlm0OdiWMp9x46Kou+
         0X2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721997098; x=1722601898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJrBvfo2zlrU7WCRKlFsrOVZ5D9Gg7mMKJJjvLeiuM0=;
        b=lJ2i9aM9gHe8r2a/NQStXBjth3tgpHQqzRhpTzKFFxklna9kKidI8po40SHedTDtYG
         XVj4gr0Gr8hoL3BSbWyq6eob+jgcj3edJEGhEKcAjM9cCTC4IX1TeZvCJoZJvU/2Xued
         wBdQYc6Xvqj9jq4gYnSQWqv9vGSEW2M1N/Gb1oyKYHPaJwzJ/2tyWjzyQhqf2RRiC53B
         Rtxb5TRZrIUbaQot9yACquXuhJeM5s7xPthzYVhkumCu/PIHBP/TU4MfP0IHQeo0DD2q
         +dkXgfdlrJ30kEMrmrSR94y4cknShs6WVEieqS4RrmfaG1CXW/73/dKBWlS022UI/b8M
         TekA==
X-Forwarded-Encrypted: i=1; AJvYcCX0wyMUt39Il+LWnPcm5q8u+i3Ls6YX4Vfv/8R6UFZ/8d2ip70TD8dMQNEixq+6nRIq/5QFdXCNtEhHsLEctwJuaHiM
X-Gm-Message-State: AOJu0YwY7q+nUZgX3imuY+R8uLcQZ4y1jH3vVAzUJi7oo+4NGT9XLD/N
	uDxdFjEq4YwzJIITYB3bWeK/IoVkxM/sof9/6kAqJV+HgfJqVgIf
X-Google-Smtp-Source: AGHT+IEiAOpGjH+5oVk5mj6Jk5s6YAp3UHE1t27F/6HE/HVaR3ZJ+Tl6UB2NPmtUbvMeoJdyrCjl4Q==
X-Received: by 2002:a17:906:2acf:b0:a77:dc70:b35f with SMTP id a640c23a62f3a-a7ac508186dmr379063066b.58.1721997097510;
        Fri, 26 Jul 2024 05:31:37 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad91005sm171415166b.173.2024.07.26.05.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 05:31:37 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 26 Jul 2024 14:31:35 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
	adobriyan@gmail.com, shakeel.butt@linux.dev, hannes@cmpxchg.org,
	ak@linux.intel.com, osandov@osandov.com, song@kernel.org
Subject: Re: [PATCH v2 bpf-next 01/10] lib/buildid: add single page-based
 file reader abstraction
Message-ID: <ZqOXJ4KfbGx3YSsa@krava>
References: <20240724225210.545423-1-andrii@kernel.org>
 <20240724225210.545423-2-andrii@kernel.org>
 <ZqI_I2iDLwNTJy4h@krava>
 <CAEf4Bza5pLkH4QAxD6dmWUcZcV4Tth2QDQ-K6PXhByCXgAu8UQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bza5pLkH4QAxD6dmWUcZcV4Tth2QDQ-K6PXhByCXgAu8UQ@mail.gmail.com>

On Thu, Jul 25, 2024 at 12:58:04PM -0700, Andrii Nakryiko wrote:

SNIP

> 
> >
> > SNIP
> >
> > >  int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size)
> > >  {
> > > -     return parse_build_id_buf(build_id, NULL, buf, buf_size);
> > > +     struct freader r;
> > > +
> > > +     freader_init_from_mem(&r, buf, buf_size);
> > > +
> > > +     return parse_build_id_buf(&r, build_id, NULL, 0, buf_size);
> >
> > could use a coment in here why freader_cleanup is not needed
> >
> 
> probably better to just include freader_cleanup() call, just in case?

ok, future-proof

jirka

> 
> > jirka
> >
> > >  }
> > >
> > >  #if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID) || IS_ENABLED(CONFIG_VMCORE_INFO)
> > > --
> > > 2.43.0
> > >
> > >

