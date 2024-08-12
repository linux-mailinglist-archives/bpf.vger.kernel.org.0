Return-Path: <bpf+bounces-36918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B3594F613
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 19:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB24328221F
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 17:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBA018952E;
	Mon, 12 Aug 2024 17:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzqHcWYg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2758418950A;
	Mon, 12 Aug 2024 17:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723484981; cv=none; b=KvP9293938KsK8767LAHGIBfVl3aQUHQRxDkwCEae+gmHmRijQFGctpeZdxKMiZGpFYHmBEBFloK0Kd9N/ERjlsalZ/yipImr/I6/43zu3E5Bp7EDK1PT4Carly4v/VsVV4Y9D3IF0ZoAspA3Q+Cf2tpOsE20WPc90wwxAGjcCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723484981; c=relaxed/simple;
	bh=u+oS+V/6h+7NxaHW/munhBTgt/CeDkNesLNfS4Yvo6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jT69P1MboQPN5WLx0KSGaAUk8ReRPAmJK6rTx+DA1iGAy1aUQ1N7EklXY9OthHPHpVCLG7yLboGd5JHb93GdAGkVJpJajvs18QNzEbdBS6E9ZhPmAKKZESizacEA4Ia0cMwdJEgyTkqauKkmibJlvZ8BpPhGFkhLWNeIZDV5+Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzqHcWYg; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f025b94e07so54148571fa.0;
        Mon, 12 Aug 2024 10:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723484977; x=1724089777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KyV0shQA6TIAcqdzVYHe6tGzviGmCFol708Uq7iVvLw=;
        b=lzqHcWYg5qIJ3lmc++b85EO4L9blcBlYplifW9jtv23kM2mT2FrvjkDpfbXfvgxUzp
         g9mXOWbqutInQnQm8AZ+rNgfACpSu6FP6xtkOfaHEkiEWe8u0wZmY/sBnxQk3A+Wa6Xm
         V6FQsO+3bk3xTTsL1HSA4eRCCN6pRGiflzhCd7y3Mdwo28EJNrewXjM2eNc6+NCa5ozY
         UyUOV9e1uPlU4yYa84HKYPCX4MwemlXwMkuKieKThx4PBwdYoyj06U6bOTZTdB4y5/xC
         JayG5Q06WpJqvGS9uVWoTZgWpBGIacv1Tp9yhLDS86gMsf9apmtZiJ/l7wo8n7q6BaP+
         7Usg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723484977; x=1724089777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KyV0shQA6TIAcqdzVYHe6tGzviGmCFol708Uq7iVvLw=;
        b=ZMRSSfPFOHHZiPCWgJQOWfBR2knuL6ek8M+0bAypYM3xFSjlvf0UI+JAfOwi9B7GZG
         garn2FvyZtVrJooJFlz6uCza3nOVhGAkOC5lDrjlGVKwOyABwurpRsdACLmoHgpPgQdI
         9TOdiwSPJlWFQrpEa2TTbpdY2pWq9CIXi1N0UxRHQW8hNHXZBLyZoMV7Y8sw5LodpTwW
         x+WtNhGZDAEEIZMKbb4WWxXptpgu83AQu3N/LVAfT6vm/jIslI0pK282wQrSaCP6zaJm
         z1SIapLopIJBKmtTlheNO+hA98z/LZ3mRscjqjvKQUvukeM/0T/JpmAXQtVVUrFoW7sr
         aCXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyuvl+aHR7neYdQXYr1miRAbDInnqprKX1lSSsiowAcM8qA4A6bvaPpZnqNU6dRhXjLBn8WmmVs79X68QKBWYBGXzgLkpaYEeSgAvClvcHRvYeFwzTXqAzFpkBpm7dd05L
X-Gm-Message-State: AOJu0YyLoTC1vENPclfaVi3z9xRXIrUByCWZYKXL0AL92IwuS9vn+ia1
	Y4sx27a6lTqftwgmCfmPkFFcqM6ctai/Ayt6R6qfPO0gm4YfHuwNTwsFtd6NTnw=
X-Google-Smtp-Source: AGHT+IGR4j+7/rR9G6erzkDK6bRBK0zlsxOfsHgs/YAAmuIyBC3SlXqLbYUIZS7yRBl6+Cx77mstfA==
X-Received: by 2002:a2e:be8a:0:b0:2f0:2a55:8c4a with SMTP id 38308e7fff4ca-2f2b7280998mr9035951fa.49.1723484976749;
        Mon, 12 Aug 2024 10:49:36 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c7a255csm197681945e9.41.2024.08.12.10.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 10:49:34 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 16FAEBE2DE0; Mon, 12 Aug 2024 19:49:34 +0200 (CEST)
Date: Mon, 12 Aug 2024 19:49:34 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
	Akemi Yagi <toracat@elrepo.org>,
	Hardik Garg <hargar@linux.microsoft.com>,
	Quentin Monnet <qmo@kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH 6.1 00/86] 6.1.104-rc1 review
Message-ID: <ZrpLLoQeag1Fe_3r@eldamar.lan>
References: <20240807150039.247123516@linuxfoundation.org>
 <ZrPafx6KUuhZZsci@eldamar.lan>
 <2024081117-delusion-halved-9e9c@gregkh>
 <ZrjS0V-tCQ1tGkRu@eldamar.lan>
 <2024081143-grouped-blah-dd52@gregkh>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024081143-grouped-blah-dd52@gregkh>

Hi Greg,

On Sun, Aug 11, 2024 at 05:40:58PM +0200, Greg Kroah-Hartman wrote:
> On Sun, Aug 11, 2024 at 05:03:45PM +0200, Salvatore Bonaccorso wrote:
> > Hi Greg,
> > 
> > On Sun, Aug 11, 2024 at 12:09:30PM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Aug 07, 2024 at 10:35:11PM +0200, Salvatore Bonaccorso wrote:
> > > > Hi Greg,
> > > > 
> > > > On Wed, Aug 07, 2024 at 04:59:39PM +0200, Greg Kroah-Hartman wrote:
> > > > > This is the start of the stable review cycle for the 6.1.104 release.
> > > > > There are 86 patches in this series, all will be posted as a response
> > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > let me know.
> > > > > 
> > > > > Responses should be made by Fri, 09 Aug 2024 15:00:24 +0000.
> > > > > Anything received after that time might be too late.
> > > > 
> > > > 6.1.103 had the regression of bpftool not building, due to a missing
> > > > backport:
> > > > 
> > > > https://lore.kernel.org/stable/v8lqgl$15bq$1@ciao.gmane.io/
> > > > 
> > > > The problem is that da5f8fd1f0d3 ("bpftool: Mount bpffs when pinmaps
> > > > path not under the bpffs") was backported to 6.1.103 but there is no
> > > > defintion of create_and_mount_bpffs_dir(). 
> > > > 
> > > > it was suggested to revert the commit completely.
> > > 
> > > Thanks for this, I'll fix it up after this release.
> > 
> > Thanks! Note today Quentin Monnet proposed another solution by
> > cherry-picking two commits:
> > 
> > https://lore.kernel.org/stable/67bfcb8a-e00e-47b2-afe2-970a60e4a173@kernel.org/
> 
> They don't apply cleanly, so I'll just add a revert...

FYI: Just realized that the breaking commit was as well queued for
older series 5.15.y, 5.10.y and 5.4.y, so that needs to be dropped
from those queues as well.

Regards,
Salvatore

