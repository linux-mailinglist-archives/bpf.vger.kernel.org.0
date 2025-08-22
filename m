Return-Path: <bpf+bounces-66269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB7FB311FD
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 10:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2312567F58
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 08:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016EC2EBBB7;
	Fri, 22 Aug 2025 08:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fnd660/q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A4021883E;
	Fri, 22 Aug 2025 08:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755852143; cv=none; b=eqZxOkETQBiw2tEM8eKnAyWR3zjtscF8gJ8KnaYYBKYH52Cj3DnnjgRNbXWwtiVbZTdfQVBbldnnHj0GH4Iv6pSGsZRqGptZWfaTa7xWwqEm7Mb3qoULEwJPw8uulMa2IIWlgAuY6wF/jC42C0kx5wM+64Gc1iApAv/VRAmsXko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755852143; c=relaxed/simple;
	bh=gapPfIhJK1bTzJFdvEuISzA1Cg/e4/Xhxu+TVD+Yn/E=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3DHba1mDCRkOjWSSLMckgfxAaD5V/8mLSrbHxkZczSSy7eU1zYsMwGHhJc9ALv2LIZdDuB2GNIOzF9/wYsrmMKNEL9bfTJ63aiUrk+aefI/fxJXDAZhzdk6DHv+nNm2gIw8zWHiShOeUQFjI3ANSUFX2Pi3DGwLHsMAA6Tzoow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fnd660/q; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb72d5409so279702266b.0;
        Fri, 22 Aug 2025 01:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755852140; x=1756456940; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rv504gma5TkYLFiZ69knEjNBP63zFcWG5Dn65W5C1o8=;
        b=Fnd660/qjWA9ExHJVrPHiORsX0Tv/GidyDIQ6pIo3prF0mZ9HDzhmeyUxiA1QyDBKl
         ANR2mze30o/IL6ek/Zc+ZA2Ll7X8wIxslKkar8AwrmMtBYvY5kOVG9RIHeR2nWWGrCRR
         5M+MqRndaZbHerC8D7NXrpz3qYK2ASOBkM8c9kkmkvZ2EGC/Brrpd7jVVZmVokqT5btt
         iKvqpUKQJjjyXA7ZPPEIHEhYgj6vbBrRiguu7aDtn7Q0uS0HtxfogJRk+JaefJ/5Phvd
         CfDPQOIaTUJqNyYDE1W025U0lp+3BKdxdA+cfdgXeNcfwC24PhWwWy8Vpi1VWslTsP2z
         jR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755852140; x=1756456940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rv504gma5TkYLFiZ69knEjNBP63zFcWG5Dn65W5C1o8=;
        b=JIZFlN82yZQCJnTx28S3UrSbgFHWb6qq9tKOvGG3BybBTLhGer+R+0n0L3zHzsR/Yl
         34N5La9aISouqmzv02iUcFWTQ+kfOqDoF6Fr9GPx6Cvu+ZN6ojL+LvBL5OKzQIzBCoCU
         XipSkYC5QUTvpq/DJb2pxojWQpBbAbQss9yMjJROxElH+DFCUJfQvptdSTiJYju0k0GH
         m8U/PSHUCFnqypbIo4S5QIorxMbMBx5kQou8KzRuJUvj9x8NkNByhuyjCRK4YJR1GYel
         jXC2DXGFGdhCxWSSZoRtQ2eoMg+jLrAFN11GLBcB36PKPxdBaPxyRW8mJZIqPSOHr8oF
         OiqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXPHjl48anFjNU/xp+6WgT4o4tf45o0hyKKujvcUEbhgWQh0cNxihRx7VP8ZgPOo3rhio=@vger.kernel.org, AJvYcCVCZVdFnHC8F15nQj3hJwufrzfqc7HrPWmSryZ4jkAOCQDQDvunNVEjAIEIZSbxDQLwOvrsqb/Ydm2poWAx@vger.kernel.org, AJvYcCVIN64w/0ek23FL0yEtBNqZPGaDul4ThoPycjBXiobYtvKXzqRpfh4l9O43EJWCeU2hcNKB+Wcn6jNU+7Y9X78PtONR@vger.kernel.org
X-Gm-Message-State: AOJu0YzEeazpQeQ0T1p6G4qldsyHgbfxAFKA0u8IKOEHbQgdq0xevjkU
	1Mu8WUyDZ6N/Kcyc7TO9aFr4O3gREs6TsV2gXEwQasqipA1czcMkD0EbaZ54gQ==
X-Gm-Gg: ASbGncuWZVPy5+GzIzPZwb9m0K/gWV+Nmw4FSfo2ZklEhpKzh7kll8Jsbkl3c37vm3v
	SfD7ocmrcmGhPNbZpwG/TwGay6TFg0cHzwu1KSSVnB2o7rcOnJHWkyB7qDj3QzKE8v8XRAYGRiK
	nftZMsOfz1v1l7XzGcT6qaAkUlzgukAwQuX8KrPKif6B33pJmOSsr3xJ+rvQxNelFYg2ECwDj3n
	BAWQgkMdR4Cm9A8JfPfCeaisX9RL92sL1Z9jEVNBfQReoRVjgQ14fbG3uNcLeUYQP7hvfNGVDqh
	fRu/LnT5zRSeyUV2lPR6xsndw3RuUTDELaK0BLROoVAfj3u+8dJWIExxJeTvqWBEjw+hLlD7+6p
	fxXJjZdNY9g==
X-Google-Smtp-Source: AGHT+IGSf6+K2la/tSkUQ4GNOD/qo1AbJseKiNTlEmELE2J7QUmOoozQZ54HhPQKiE1W2oifM4sdcQ==
X-Received: by 2002:a17:907:9304:b0:af6:a10a:d795 with SMTP id a640c23a62f3a-afe2968f34cmr190105566b.55.1755852140043;
        Fri, 22 Aug 2025 01:42:20 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded479868sm565612666b.58.2025.08.22.01.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 01:42:19 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 22 Aug 2025 10:42:17 +0200
To: andrii@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, oleg@redhat.com,
	mhiramat@kernel.org, Jiri Olsa <olsajiri@gmail.com>,
	linux-kernel@vger.kernel.org, alx@kernel.org, eyal.birger@gmail.com,
	kees@kernel.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
	haoluo@google.com, rostedt@goodmis.org, alan.maguire@oracle.com,
	David.Laight@aculab.com, thomas@t-8ch.de, mingo@kernel.org,
	rick.p.edgecombe@intel.com
Subject: Re: [PATCH 0/6] uprobes/x86: Cleanups and fixes
Message-ID: <aKgtaXHtQvJ0nm_b@krava>
References: <20250821122822.671515652@infradead.org>
 <aKcqm023mYJ5Gv2l@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKcqm023mYJ5Gv2l@krava>

On Thu, Aug 21, 2025 at 04:18:03PM +0200, Jiri Olsa wrote:
> On Thu, Aug 21, 2025 at 02:28:22PM +0200, Peter Zijlstra wrote:
> > Hi,
> > 
> > These are cleanups and fixes that I applied on top of Jiri's patches:
> > 
> >   https://lkml.kernel.org/r/20250720112133.244369-1-jolsa@kernel.org
> > 
> > The combined lot sits in:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/core
> > 
> > Jiri was going to send me some selftest updates that might mean rebasing that
> > tree, but we'll see. If this all works we'll land it in -tip.
> > 
> 
> hi,
> sent the selftest fix in here:
>   https://lore.kernel.org/bpf/20250821141557.13233-1-jolsa@kernel.org/T/#u

Andrii,
do we want any special logistic for the bpf/selftest changes or it could
go through the tip tree?

thanks,
jirka

