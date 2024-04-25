Return-Path: <bpf+bounces-27813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4878B2367
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 16:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0578CB2845F
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 14:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD1B149C6E;
	Thu, 25 Apr 2024 14:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="CWylmAt7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69143149C67
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 14:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714053703; cv=none; b=Z6Y1LskFdAePxq1Qk/31FAqdld0y1R6dj3EVeZl+l6WMy4V7Mu1YFo32qeGBwPlCCCX6VfYCE9obp/J5oylSzatjP2aZN6+ADsgoMua7ioEkZWXklwM7ZDpuxGEHM99f5ViuGiBk+78pTPY2VRpHgluEmEgdueAtxz2eZe2s22k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714053703; c=relaxed/simple;
	bh=ulYE0VHNMZy9EO2UbfcdnnLqLAB4c7Fjw+n0PZCpRjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dilUfyAumNoBUN322qljzDOH/+YAaR5Ssqbpzrzl5/ce7MliJPNbCwHS+GGEe229Su3kOsHy45NUellCkookgYuLuW4TnBuOKm/NdwiQUi2MFGh238Fl73MO1hdIArLOB9V5B0IDJdyEiLXaY24ChsDPezSKY3Y6WH0qfd7hsMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=CWylmAt7; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6E5B04059B
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 14:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1714053698;
	bh=Vh9MMkltQi2FaezzyNlR84OxmhjgaayN9uBNja5LyNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=CWylmAt7P6vxE//l4V0Ci8m/HrsttJBZ9hpCkyRiNK3ShN7QFIqhPZQHyX8KBmBHw
	 ATVVEKMgGicekkW6Bqj2UJwSDheIT3O/zKdp06o8Azsd7WaZemSiNWJ/uOLlkUP13t
	 g3b6TJq1M6C9+Zbb960Ud11/GtMT2K3xvrWyCMizqBR9bRp4/vDhsIPOFIfU6GTxCC
	 fkXYDzJFcCHVjyRs/Vwn6of53TLbOl6kUC16uXtpjjoNtRSa07dTfcOQELIQrGhn74
	 Nj9GTcYvu+/U9W1zRsrNYu/Sms0tHkP/9oJEeMk5DTOFL2Ov1ko5GP6PnGISSSU2/k
	 Ihk2KAH1SrEog==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a51fdbd06c8so72339466b.3
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 07:01:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714053698; x=1714658498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vh9MMkltQi2FaezzyNlR84OxmhjgaayN9uBNja5LyNc=;
        b=jPOStIiqF57vqLfMPgoYsTKxjAtsMIyLMTdrxYtK7MdcWR2oMzbO8Fp+wApIBNNbeM
         tCaaJBZxjrR5kS8RRjgo/3MJdMDX2h8l1wndhFOL81oE2QvSnekAt55+FF6UhLgEDKto
         Vsf5ury/MvvMtiRu1qrEPW/5xftaFcn8DmB/skhed8dvbgTHURJ0YUvwBeacDw7vZhhD
         a3DjwEXfrF81jaUVxhoKckohGtUJLDOM+1dja6BMCsMkJY97hjtAXtzjGtUpkFHL/f/d
         o+bcaV/vCeDOVFgtMqn5lxPQ8W+YQGBsVITV/NG3cY0SEoJbJ5DXIPx3PXZbS6rg0BzP
         ftcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHh4AzBGyqOuedor+PMd4mhSBY8ehZS4CG0TjHLCHwT1NkSVJUAodfu39pDZOZZF8oKRywEnzCbJFn/BRhqJb9B+YK
X-Gm-Message-State: AOJu0YyJzSz+2F+BRvJefK8yKbsDuoibmadiiztVxGpGT/76iiJ6SeIk
	z0+azwvd789+PL6/G87nnOW5vteDhjXhIbEJoauvRjZAU6vVwZHYykV4OHgY75ulQjZMD/IkCJG
	lQhDeL/Ik2GoQIh/ejH7IXBtf+GY8+oL1xdyU+0kAtYl9fN+X+pb0qQFuTbXW2ADhGw==
X-Received: by 2002:a17:906:4a10:b0:a58:9707:6857 with SMTP id w16-20020a1709064a1000b00a5897076857mr3086701eju.12.1714053697249;
        Thu, 25 Apr 2024 07:01:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUGdvGOdoFM2DQyrp81U9KOxMYphBYPxvDtGDUe2+ZgkEDQFsgVuviPGlX+re7UWJw+WvOAA==
X-Received: by 2002:a17:906:4a10:b0:a58:9707:6857 with SMTP id w16-20020a1709064a1000b00a5897076857mr3086667eju.12.1714053696684;
        Thu, 25 Apr 2024 07:01:36 -0700 (PDT)
Received: from localhost (host-82-49-69-7.retail.telecomitalia.it. [82.49.69.7])
        by smtp.gmail.com with ESMTPSA id u24-20020a1709060b1800b00a58767c1120sm3711046ejg.10.2024.04.25.07.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 07:01:35 -0700 (PDT)
Date: Thu, 25 Apr 2024 16:01:33 +0200
From: Andrea Righi <andrea.righi@canonical.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/bpf: Add ring_buffer__consume_n test.
Message-ID: <ZipiPZia5iY_UsHQ@gpd>
References: <20240420155904.1450768-1-andrea.righi@canonical.com>
 <ZiVy9bYrX-w24huD@krava>
 <Zin12J-emVljvVrJ@gpd>
 <ZipLQmwPd--EajCk@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZipLQmwPd--EajCk@krava>

On Thu, Apr 25, 2024 at 02:23:30PM +0200, Jiri Olsa wrote:
> On Thu, Apr 25, 2024 at 08:19:04AM +0200, Andrea Righi wrote:
> > On Sun, Apr 21, 2024 at 10:11:33PM +0200, Jiri Olsa wrote:
> > ...
> > > >  static struct test_ringbuf_map_key_lskel *skel_map_key;
> > > > +static struct test_ringbuf_n_lskel *skel_n;
> > > 
> > > seems like there's no need for this to be static variable
> > 
> > Can you elaborate more? I think we want these pointers to be static to
> > limit the scope to this file, no?
> 
> I meant to move it directly inside ringbuf_n_subtest function,
> I don't see reason why it's defined outside of that function

Oh I see! Yeah, that makes sense, I'll send a v3 soon.

Thanks,
-Andrea

