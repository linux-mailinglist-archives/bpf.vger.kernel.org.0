Return-Path: <bpf+bounces-44021-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3F99BC8D7
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 10:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D16EC1F21106
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 09:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AA81D0F60;
	Tue,  5 Nov 2024 09:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCwyxRdm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E5118953D;
	Tue,  5 Nov 2024 09:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730798110; cv=none; b=HJM7K6sdKwFY5h+zByMK40/W6LoIqKkxVjDPNbWfjdNq0xoMyqJuyHeEmZ1NRYgawWy07DeksKYv4kbDYcRy9y6Rm8VQ+mP/x8ttFuUlj2V8RI2tLNidzHIhjCytpcK1l14YkJFzoOUpQcoe7OF54SChnYzrjLDBNSjVQkegeUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730798110; c=relaxed/simple;
	bh=14CNKxktVrIXSvXhbiFpvz3Rf9GP+5/M/fSs3GIO6AI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DB9A/y3mslF+VrENMgnarWjijEGhTTNStKG5F7OyPT5Dc+hX22cWJREUL8c8qx4wIL3a5PIDk5ui1za2qIrEcVJVtwZHDH2sVFIz2LCAWi8VLfjens6qycp++ZC8orIbOBcTwnkKZY3trDCLRAdqaea16beYyBUmgYoIxOmMd48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZCwyxRdm; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43155afca99so38054945e9.1;
        Tue, 05 Nov 2024 01:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730798107; x=1731402907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tKl2auZ2E/RrfHwQmKMB0HALAZPgDwx6wHcuNMuoIGI=;
        b=ZCwyxRdmhM2ZQKBzh5gfKQTUi3vBFNoJfbicMx0JZi/mvLR8Ugdi4SWq9Vx4whh+1v
         vQPSXzjztS2EzsL0V29IAHa3DmMaBGW9DSo0Rx/i2lTd6UMKPWp+Zxvap26Uh6XuGkmh
         hAeHOB4FeXbHS5mOHmUNBGSgvNW9EK43EEwREk+NCMW27B8yUdVVoWmZrjgrqGQY5Xe3
         t3cI2TXMCNK7qVx/9c+QfGV2z/SJO5pJMEXAfbBT//IsCQnGTQNTtx1C+qMFrevS1iWg
         7Q8fyyi+dKt5qPnBZY3J5TwmDZlLPG5jY9m8whGaqzTgvQuQ3x7xucvjME7YsrRmq6kZ
         9mfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730798107; x=1731402907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKl2auZ2E/RrfHwQmKMB0HALAZPgDwx6wHcuNMuoIGI=;
        b=Fon5gMkgI5vPns6AoUDw3diRI1Ha5+bB+SWgX8rFl1zZJnlESGj5/rGAFCdl8FD7iH
         Q4kzWIolv0TngiL+vaElWQ2YkORkmjCSgNdmkgnGezgjPCv565swGO5z8BFvuAjKfP0e
         VevoRRHTy53vT0DUUDbbJi+ZNzw/efACPLslHZmYMkCobo41IfH3tuTiUucyY/ZxLGds
         h+XbQIVAOdruzM93jey1VzL7z0ibkcpxbzpPFlVd7pqbasv0js/H9VVoCyyC7yRgOUqw
         7iuxJZTtK/qStC+buF3DagSAi5YLzInurj2j3QqCddwMaI1EDYYp0y3zDGlysWP1IC9h
         2oFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTLZ/BdY8q5c42ID5NmqL1zD4KoKrJaaY9CC3XtFKJoB0FiS3y3s1Tp1ztKDfxMHK3hLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwYElrxDTEaAAP0fL3QXKkAJrK/V8lMAUZfTSDioH/I17ETz7M
	g7uSTMXjleuczZMcVHpUyjjyvwKpir9AcCPZupJsEeYiryRmHFDH
X-Google-Smtp-Source: AGHT+IHtJBIY/LRmN/ZDDuyyzGKSxGQfz1wGOcIiCPO0FyFJHteJeBQlYp40M64o3dqwMSLfd4hJ2g==
X-Received: by 2002:a05:6000:401f:b0:37c:ccba:8c93 with SMTP id ffacd0b85a97d-381c145e818mr14681220f8f.11.1730798106475;
        Tue, 05 Nov 2024 01:15:06 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e69fsm15478097f8f.69.2024.11.05.01.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 01:15:06 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 5 Nov 2024 10:15:04 +0100
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: Fix build ID parsing logic in stable trees
Message-ID: <ZyniGMz5QLhGVWSY@krava>
References: <20241104175256.2327164-1-jolsa@kernel.org>
 <2024110536-agonizing-campus-21f0@gregkh>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024110536-agonizing-campus-21f0@gregkh>

On Tue, Nov 05, 2024 at 07:54:48AM +0100, Greg KH wrote:
> On Mon, Nov 04, 2024 at 06:52:52PM +0100, Jiri Olsa wrote:
> > hi,
> > sending fix for buildid parsing that affects only stable trees
> > after merging upstream fix [1].
> > 
> > Upstream then factored out the whole buildid parsing code, so it
> > does not have the problem.
> 
> Why not just take those patches instead?

I guess we could, but I thought it's too big for stable

we'd need following 2 changes to fix the issue:
  de3ec364c3c3 lib/buildid: add single folio-based file reader abstraction
  60c845b4896b lib/buildid: take into account e_phoff when fetching program headers

and there's also few other follow ups:
  5ac9b4e935df lib/buildid: Handle memfd_secret() files in build_id_parse()
  cdbb44f9a74f lib/buildid: don't limit .note.gnu.build-id to the first page in ELF
  ad41251c290d lib/buildid: implement sleepable build_id_parse() API
  45b8fc309654 lib/buildid: rename build_id_parse() into build_id_parse_nofault()
  4e9d360c4cdf lib/buildid: remove single-page limit for PHDR search

which I guess are not strictly needed

jirka

