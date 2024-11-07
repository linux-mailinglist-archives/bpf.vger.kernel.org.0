Return-Path: <bpf+bounces-44293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C199C0F87
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 21:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2E3F1C22933
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 20:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8FC21767B;
	Thu,  7 Nov 2024 20:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="I++vinjj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CDE20F5D7
	for <bpf@vger.kernel.org>; Thu,  7 Nov 2024 20:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731009849; cv=none; b=Le8Fdds2DjG/jrhnz+qvBa6eKgFafwetmrk6jp9SjmJbWVDSU1+JGG0xDToBAjs/z8BhTugRLdiujIwjXPPlOhGrfbEXFZzH8nnLB13hgc+skOzVzLS3433QSoBxL3YgrJR9rW/R3ta3zd/cxbOL+3zLgSMRcKlmPybFmPUG7M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731009849; c=relaxed/simple;
	bh=Elp7y14xBOB4diE3acIW3Dc2vPvxtedgKHGsmmGj7Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qU7GMtc3PnHnpHiWVFr2b48khadsoMWmg3lIW+H5d86IW8CZJ7yNyh38iMbBcIvikQedtX+czjiijeQ6j+mpW0Mc1hyLDme3zI9PqFuAMFYIDciL7GayBCgrJkmxQ2WgjeZjp0yVmIcNdn5X6JGjeVpKk69I6rlxlOnfAB1/xyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=I++vinjj; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7240bb9cd22so106051b3a.3
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2024 12:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1731009848; x=1731614648; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YWUmKGMjr/6BN+GiYS1kBbGj8WMSXJNpnH1lTl9Nl5E=;
        b=I++vinjjWCn0ZMC81x/5+zGBb8HdvUu52YA/eW8uhims5gI/PQF884eQJUr5PmoQkm
         97xTTQ1UYPED0axcr3DsQxeKkiGBxydQHEM/DRyfjOVQGLA6a9EVxw9YZHIbsWIZGjdR
         Ee7yqZ6R8KeM5welX71HsrsCOtYdAzLQOOsiUHWP4S/143IFyyhcMHRGDuffKNqD9Mj4
         ofIKx4ITiqdcLPAPQK8UmF5xlWNWhbE53VVzPb8WS2pn9NJEJ4vqU0PKQIgZR5yXx7Fp
         q9A/Poy3OABfT1h1h34E3Z133ZKsJWavgvERa5jK3G/5dv3iLtaM94nE3kGmvDfKxiMG
         ocgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731009848; x=1731614648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWUmKGMjr/6BN+GiYS1kBbGj8WMSXJNpnH1lTl9Nl5E=;
        b=eelU9HuznJb9Tu88R4VZ+WM9S/1lgcg371RfVEknqqlzIOkvFhHdyvcmgTmYrL/vzV
         qhCB7TJuqlJAJbB/LMQZeogg3nPQwAwTlwLeL7u3uh8/kEeqWeSlAyck+ifmonQSUuDV
         psToIlvEIgV+rDvwFdCSAB61JYajezHjDMgf0jLZh5bP890dwrQJfumUMP1M/JWLv2ph
         aUQKF7cHHsmcXoA7JTL32fyVpHV8ZtNyyh4g3M+Et2N04NCLq7G6KF6zz33sdZGIt0d0
         WiNRejvDRKimEzvYY5WFn6s3Se6/ICi97DouqRpKTEw96zTXWQotIPtLSk6pw2g+IjHU
         tdew==
X-Forwarded-Encrypted: i=1; AJvYcCVA4Of4CIY5R29z0Et+U6EMgqVnxHhN9xeA0nFvlBcWkxA08QLjYgBNa6OJ2HwDQNTsjo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhJTg/Op+0rzRKvV7LcLW6kjaXCbdn9m01S6Kg/LuTzmAkCKkf
	YLlDcnU35tiFPdAn62yACTRI5nkFIKsGnNys7C4Q+XASGoTLJnr+2zKW0tEYoqg=
X-Google-Smtp-Source: AGHT+IF6P0+yerU0FHqW/gSF+wzFyJeaPm8UMmSFVr4Moj/eVfBEHxBKds5yvhJlYTNJ1Em/fE2s2A==
X-Received: by 2002:a05:6a00:18a1:b0:71e:5132:da7b with SMTP id d2e1a72fcca58-72413359755mr178409b3a.3.1731009847784;
        Thu, 07 Nov 2024 12:04:07 -0800 (PST)
Received: from telecaster ([2620:10d:c090:400::5:5e37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a89f4sm2097962b3a.61.2024.11.07.12.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 12:04:06 -0800 (PST)
Date: Thu, 7 Nov 2024 12:04:05 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: Fix build ID parsing logic in stable trees
Message-ID: <Zy0dNahbYlHISjkU@telecaster>
References: <20241104175256.2327164-1-jolsa@kernel.org>
 <2024110536-agonizing-campus-21f0@gregkh>
 <ZyniGMz5QLhGVWSY@krava>
 <2024110636-rebound-chip-f389@gregkh>
 <ZytZrt31Y1N7-hXK@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZytZrt31Y1N7-hXK@krava>

On Wed, Nov 06, 2024 at 12:57:34PM +0100, Jiri Olsa wrote:
> On Wed, Nov 06, 2024 at 07:12:05AM +0100, Greg KH wrote:
> > On Tue, Nov 05, 2024 at 10:15:04AM +0100, Jiri Olsa wrote:
> > > On Tue, Nov 05, 2024 at 07:54:48AM +0100, Greg KH wrote:
> > > > On Mon, Nov 04, 2024 at 06:52:52PM +0100, Jiri Olsa wrote:
> > > > > hi,
> > > > > sending fix for buildid parsing that affects only stable trees
> > > > > after merging upstream fix [1].
> > > > > 
> > > > > Upstream then factored out the whole buildid parsing code, so it
> > > > > does not have the problem.
> > > > 
> > > > Why not just take those patches instead?
> > > 
> > > I guess we could, but I thought it's too big for stable
> > > 
> > > we'd need following 2 changes to fix the issue:
> > >   de3ec364c3c3 lib/buildid: add single folio-based file reader abstraction
> > >   60c845b4896b lib/buildid: take into account e_phoff when fetching program headers
> > > 
> > > and there's also few other follow ups:
> > >   5ac9b4e935df lib/buildid: Handle memfd_secret() files in build_id_parse()
> > >   cdbb44f9a74f lib/buildid: don't limit .note.gnu.build-id to the first page in ELF
> > >   ad41251c290d lib/buildid: implement sleepable build_id_parse() API
> > >   45b8fc309654 lib/buildid: rename build_id_parse() into build_id_parse_nofault()
> > >   4e9d360c4cdf lib/buildid: remove single-page limit for PHDR search
> > > 
> > > which I guess are not strictly needed
> > 
> > Can you verify what exact ones are needed here?  We'll be glad to take
> > them if you can verify that they work properly.
> 
> ok, will check

Hello,

I noticed that the BUILD-ID field in vmcoreinfo is broken on
stable/longterm kernels and found this thread. Can we please get this
fixed soon?

I tried cherry-picking the patches mentioned above ("lib/buildid: add
single folio-based file reader abstraction" and "lib/buildid: take into
account e_phoff when fetching program headers"), but they don't apply
cleanly before 6.11, and they'd need to be reworked for 5.15, which was
before folios were introduced. Jiri's minimal fix works for me and seems
like a much safer option.

Tested-by: Omar Sandoval <osandov@fb.com>

Thanks,
Omar

