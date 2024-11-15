Return-Path: <bpf+bounces-44956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F289CEA48
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 16:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B78FB350F6
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 15:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDEE1D47A2;
	Fri, 15 Nov 2024 15:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Om/DhNyB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100BC1CEAD6;
	Fri, 15 Nov 2024 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731682821; cv=none; b=txhT6rJ6BCSOSQRFzVECsv6dIwOtPUS7/tltQRXenLcliVlopQZb3Il8Uc5Y2lZ2ZRm5TO6Jg9OhV2x6otkqrbAWwcELiRWaOZQPAvdepZtB8vto3Z0QQhWp31vQMaFOVwgua1vvipZSsM5AHEoroXLEX2u46hUEMBGwH9/90K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731682821; c=relaxed/simple;
	bh=F5SP4uxEH44imQO8ADRy6LxWycLZEjGv1neL8yEJaKc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZKvceg/Fx5/FSuvG2uA67BVJoP5CF2+yaToVK9rTr5NGPEiuHozye/bb833weXaQdbFLE0J887y0YcpfsCxdAz03YwKEtoXlEGPM9g2uVISqx0cdV7hVhqRajYXZ3n5gSbcBKj5+FYDC9oOgSETLa17Esx4Cwjm/7eBq9x5BZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Om/DhNyB; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539e5c15fd3so1904384e87.3;
        Fri, 15 Nov 2024 07:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731682818; x=1732287618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NLo8DhivFTHQJmP4mLoG4uPzIlOe4auTF9W+B620tuw=;
        b=Om/DhNyBjmTsJ4uZ87H5y9M8SgMCGNMymmT9WaiJT5k+AW3HY+uW/L5y0dfMcPbmEN
         Csi1tU1Mfcbmq7IUa3XQLMtFYv3+0Wr9uKQm5jKnXmd/nA5bdYt86gqpDaOLy3+QAavb
         t7+gsbrBJ0K9DxPdF27XaUQznFxXmFbHnDwmDEU2dbcpCipi9Wd6SXGbjafM0tU+sC0B
         v9S+0sbeEkC7/BMSwVAlmc0k389m+zyUfRc14aGwtTckCmUcWPEWEpvZbkrd/XHNnvyv
         VAukRvQs7qjifZniPQ0B0EC+DE+PMxZ3uzl4WMgLuHOWl795EDec6Nf0D9TZSXRlF51O
         YK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731682818; x=1732287618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLo8DhivFTHQJmP4mLoG4uPzIlOe4auTF9W+B620tuw=;
        b=SNadvLxbWrTNwL5wxJIGl2vvdzVVI2GeAPTq1DEUPtMIy+8Yqo94yPSkpBvvW53vHR
         VZrao0Hqg9XUzqYfR+5eq6gEJ4ffj3I69CFvbLadjx55IsHYkEWptpxlR3XUb+aWgg3G
         4qRm52htfNrzWO5j2G5IxQeiVQC2W+Mrj2ZC5Ito4Ijxmy4qFKT1cyGucQhmFwvFx5Vs
         AkOD85W/B5X/2T6slBj/Ld8jod+iGC/nvnNEHxPkNh7KOQFI2CwPLL154Kn1+C7GLUjU
         de3w8D98Jv+F2EQEkTB2rPYeErlbPWu+ldxT6r4S8fAe1TbTNOG2BW/ZBgOZaQBPz5KQ
         dhFA==
X-Forwarded-Encrypted: i=1; AJvYcCWp5VD2dmBBrYurj0W4yds5aMWriq+7rbWwUKqyJbefrXSQV2KVeznfIUtTO5yvW61TxyguTehnUg==@vger.kernel.org, AJvYcCX95PUuSpN2rNVzE+gHyyjHn5VSZTJlI58mXrHFsElaAD9d8TlVW9G99yAJnAj/kz7BJBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaCrl6yWdiQSghdxPdeTMxULgqYCJmdxPxptRcxlRbGR9U71C3
	u9KDSHh5wWPoLrIP6Qc4GfzBCp0tpnjnvF2nqyY/Q1gemXfswKlH
X-Google-Smtp-Source: AGHT+IECwbTexoKDr6CNxvZALutSuwGaQQfU6njciBj3lS0XBOo6gEtJ5pgGpgQxmjrX4o+OZkxCvw==
X-Received: by 2002:a05:6512:3e1a:b0:53d:a883:5a3e with SMTP id 2adb3069b0e04-53dab3b99d9mr1548882e87.39.1731682817845;
        Fri, 15 Nov 2024 07:00:17 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf79bb5e0bsm1636758a12.53.2024.11.15.07.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:00:17 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 15 Nov 2024 16:00:15 +0100
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alan Maguire <alan.maguire@oracle.com>,
	yonghong.song@linux.dev, dwarves@vger.kernel.org, ast@kernel.org,
	andrii@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
	kernel-team@fb.com, song@kernel.org, eddyz87@gmail.com
Subject: Re: [PATCH v2 dwarves 0/2] Check DW_OP_[GNU_]entry_value for
 possible parameter matching
Message-ID: <Zzdh_4Z-e8nl50L6@krava>
References: <20241114155822.898466-1-alan.maguire@oracle.com>
 <ZzcVq8zcdFm0mNxJ@krava>
 <ZzdgNqf14cTjonaF@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzdgNqf14cTjonaF@x1>

On Fri, Nov 15, 2024 at 11:52:38AM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Nov 15, 2024 at 10:34:35AM +0100, Jiri Olsa wrote:
> > On Thu, Nov 14, 2024 at 03:58:20PM +0000, Alan Maguire wrote:
> > > Currently, pahole relies on DWARF to find whether a particular func
> > > has its parameter mismatched with standard or optimized away.
> > > In both these cases, the func will not be put in BTF and this
> > > will prevent fentry/fexit tracing for these functions.
> > > 
> > > The current parameter checking focuses on the first location/expression
> > > to match intended parameter register. But in some cases, the first
> > > location/expression does not have expected matching information,
> > > but further location like DW_OP_[GNU_]entry_value can provide
> > > information which matches the expected parameter register.
> > > 
> > > Patch 1 supports this; patch 2 adds locking around dwarf_getlocation*
> > > as it is unsafe in a multithreaded environment.
> > > 
> > > Run ~4000 times without observing a segmentation fault (as compared
> > > to without patch 2, where a segmentation fault is observed approximately
> > > every 200 invokations).
> > > 
> > > Changes since v1:
> > > 
> > > - used Eduard's approach of using a __dwarf_getlocations()
> > >   internal wrapper (Eduard, patch 1).
> > > - renamed function to parameter__reg(); did not rename
> > >   __dwarf_getlocations() since its functionality is based around
> > >   retrieving DWARF location info rather than parameter register
> > >   indices (Yonghong, patch 2)
> > > - added locking around dwarf_getlocation*() usage in dwarf_loader
> > >   to avoid segmentation faults reported by Eduard (Jiri, Arnaldo,
> > >   patch 2)
> > 
> > looks good, I got 95 more functions in clang build including perf_event_read
> > and there's no change in generated functions with gcc build
> > 
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> I think since you tested it we can stick this, right?
> 
> Tested-by: Jiri Olsa <jolsa@kernel.org>

yep, sure

jirka

>  
> > thanks,
> > jirka
> > 
> > > 
> > > Alan Maguire (1):
> > >   dwarf_loader: use libdw__lock for dwarf_getlocation(s)
> > > 
> > > Eduard Zingerman (1):
> > >   dwarf_loader: Check DW_OP_[GNU_]entry_value for possible parameter
> > >     matching
> > > 
> > >  dwarf_loader.c | 121 +++++++++++++++++++++++++++++++++++++++----------
> > >  1 file changed, 96 insertions(+), 25 deletions(-)
> > > 
> > > -- 
> > > 2.31.1
> > > 

