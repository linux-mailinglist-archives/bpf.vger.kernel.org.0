Return-Path: <bpf+bounces-44124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 061649BE669
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 12:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B97B02891E9
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 11:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290C81DFDB7;
	Wed,  6 Nov 2024 11:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1z6Yzd0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024941DF75B;
	Wed,  6 Nov 2024 11:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730894259; cv=none; b=BaVSWnHHt//r61ArXwWg8a7RIgyiwO9UcmzV4avw9ToWctxh0rWNWh10DXaLUxZCEw9UMeXeGHUClUkAMpkF5p4eejuXFd757vEcma8CdFr3/3TlpbYn5SjlWt5L5Rf84FIsBrHNGJFDt04K+M68A/uiStxi9aj3vQBRMDvUGL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730894259; c=relaxed/simple;
	bh=3cM9io5BaBvSOMyu+vFonLL+6dXmNJJz4aK1pr8oJ4o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUKi8MoYlVQqb3fqc79VTRvbmfdZcJ6Sk/FtN7zR0NGt2wOzERij08M50qmBwZg5HCwRx4zz0m2uNa7TnKVSQ7XEvi5a29ue+y1/NB7J2H6iEDqY6BZJhD8pTl0v21NQPlj2AN/U/Rl2nOUX/phKlSQ82aagwMZC0OyTu5v4Jaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1z6Yzd0; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d47eff9acso4291282f8f.3;
        Wed, 06 Nov 2024 03:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730894256; x=1731499056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pLQYg9RuJAWTG+x0qeNpHmygK2E9Tw/T0eD3DXAdoUE=;
        b=Z1z6Yzd08zVMeCOsFWqpQxsAE8Y/y/BiY4bxPXpllikOUcMVlmRYe65KfDg1TfKw/Y
         N1XIfdOngPQTQQUci+wVIJWhzPyCCa54GBK3GK1c2NMZMXKfaPh/luAcqsY+2zQACnx2
         0Y1b1Mdhh2HR5pK7lfUfva8NkAhr72BEOqSlaO9vcQ0yY/l4Icj6CieCoTaDj3z/WCrI
         tOqU+qSWEnM0vHTnsvZjttJrbAkimhi9expKwt0sZG3BsglxHUMPh7CXjfm+fuEKb18p
         lCXjkAdVMJTqtrtoQqYMMhuAF/z7zSFVA4Eah0TZpbqhhejNr5CVdsFjZmpwSF3fZPhl
         gz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730894256; x=1731499056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLQYg9RuJAWTG+x0qeNpHmygK2E9Tw/T0eD3DXAdoUE=;
        b=KIFZ3VrRE3zZRTZooEUyn7bbJszZZ6j2nlL0nXDdtZ7velmkG6A3hv2XerSbi2tYUN
         UBrqYkI69DUYgJYYAmb2F22puSBWMAnN+FALP5VjERDgAS1WSObHegF9FDuwRSajktbD
         ZKnV66ag2PuH60ti2O8UG7yijmYrDRlN8U1olt9R3lb8vysdWd78a2FAVvjlsBZU+gcQ
         10wVXUfipo9RrwtEsALlltg2MQJFjM2lcUdViGQRpDwoglJgRZUJuRrLyr8x6ja04s29
         hnuGBuHzGf0PLQjgBhSeTGFEp3JbXwPQwCEZAvZ6vsC0QeTftS0dK/or2+4M7QeKXVhd
         OrVg==
X-Forwarded-Encrypted: i=1; AJvYcCVdYRQDw7X3jRI5ejM3IpmSMg/nwXd8OiBf+BdJD9c97Zq2aUEfVfQpj+xzLChdcm8X1iTN7uAZ@vger.kernel.org, AJvYcCWvy56CZwV26uKGR0vAs0TpHlpAIQnyfyk67XetHqZ75rvwya/GcQl/FF3C6C5wyoc5aMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh54fsNuYH+JG1Uqszyy1dIEly6NwHT7lJJ3s23lQKZi4dBfGX
	TYwwVfWIFKxFsJ2RDkaZOGcFikmccIygKHDOPtWtnF/GFs7oElOF
X-Google-Smtp-Source: AGHT+IEqWNEYGpxegCh+oIDyY+Y9DtMrA6Lr3Ohztp1vVsEUidwbFZjLVaIT6TV7pEVVgQax1kOAMw==
X-Received: by 2002:a5d:6c63:0:b0:37d:3973:cb8d with SMTP id ffacd0b85a97d-381c7a5e9d5mr15380620f8f.24.1730894256175;
        Wed, 06 Nov 2024 03:57:36 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e6aasm18899215f8f.67.2024.11.06.03.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 03:57:35 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 6 Nov 2024 12:57:34 +0100
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, stable@vger.kernel.org,
	bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: Fix build ID parsing logic in stable trees
Message-ID: <ZytZrt31Y1N7-hXK@krava>
References: <20241104175256.2327164-1-jolsa@kernel.org>
 <2024110536-agonizing-campus-21f0@gregkh>
 <ZyniGMz5QLhGVWSY@krava>
 <2024110636-rebound-chip-f389@gregkh>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024110636-rebound-chip-f389@gregkh>

On Wed, Nov 06, 2024 at 07:12:05AM +0100, Greg KH wrote:
> On Tue, Nov 05, 2024 at 10:15:04AM +0100, Jiri Olsa wrote:
> > On Tue, Nov 05, 2024 at 07:54:48AM +0100, Greg KH wrote:
> > > On Mon, Nov 04, 2024 at 06:52:52PM +0100, Jiri Olsa wrote:
> > > > hi,
> > > > sending fix for buildid parsing that affects only stable trees
> > > > after merging upstream fix [1].
> > > > 
> > > > Upstream then factored out the whole buildid parsing code, so it
> > > > does not have the problem.
> > > 
> > > Why not just take those patches instead?
> > 
> > I guess we could, but I thought it's too big for stable
> > 
> > we'd need following 2 changes to fix the issue:
> >   de3ec364c3c3 lib/buildid: add single folio-based file reader abstraction
> >   60c845b4896b lib/buildid: take into account e_phoff when fetching program headers
> > 
> > and there's also few other follow ups:
> >   5ac9b4e935df lib/buildid: Handle memfd_secret() files in build_id_parse()
> >   cdbb44f9a74f lib/buildid: don't limit .note.gnu.build-id to the first page in ELF
> >   ad41251c290d lib/buildid: implement sleepable build_id_parse() API
> >   45b8fc309654 lib/buildid: rename build_id_parse() into build_id_parse_nofault()
> >   4e9d360c4cdf lib/buildid: remove single-page limit for PHDR search
> > 
> > which I guess are not strictly needed
> 
> Can you verify what exact ones are needed here?  We'll be glad to take
> them if you can verify that they work properly.

ok, will check

jirka

