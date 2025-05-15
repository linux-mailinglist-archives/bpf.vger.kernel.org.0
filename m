Return-Path: <bpf+bounces-58280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE6CAB7F8F
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 10:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13C244C505F
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 08:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DD32253E9;
	Thu, 15 May 2025 08:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B52Q/CCd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218D612CD96;
	Thu, 15 May 2025 08:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747296146; cv=none; b=NomH3bnGwQNFWE1nva6XPrB8B3ohS8qsPsovJpHMRcIuAd3SClAtscM6DHbwi3Q0rCya4RO0UYYpy5D9UXf3flo+0vIBTek/bsPqGgLV2a0hmAJeN9unLNA4Vc3NiTDbSEFY296v+cv51TOafx6SZEjKqGAf0t2VvA+A/nuPte8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747296146; c=relaxed/simple;
	bh=yTGSvbpFVh95op3RrLDfNZwCA3stiU2sfgg44eugPtc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJ1MFQrIKBe5D+NZ4Gs0Tt4BJXwI7SCBDIqOx5anWJspxefUEBXH+pY3wFlLtx3piz8/qsCq5zIUl+1tpiHS7Iv4G3Z0cv8haCVcrFJUBNszS2idhm+kbOarZJBiO0HTpxt/csEaNqcXae4BWfUzXiu3IxcNgUxaB34FiV17zKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B52Q/CCd; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2302d90c7f7so7687135ad.3;
        Thu, 15 May 2025 01:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747296144; x=1747900944; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gZEKSsAVAm7tLGYRVOWvvqg+w/D70pTel7iaUlMrOmI=;
        b=B52Q/CCdmCoOHKIU9PAHqWo38ptony0h7lE/goEJWS28THMwqlX8kFxE17QT/P1syq
         FUPsYZdwwWGmLnEwRk5Zt8kXYnFfmhynzFlrJRicZtvYGbZmcuEHzMdp9qUuaLKk9FIk
         LRWmgtvQRwqLGUVYKuiSmHbWavbuBYwQ052mz30oTKIztd3SLO/9imGRh7opF8l95CRm
         nEUrIkSFWcedm4BAzBE4narS+e+8BUCeQb4Rxp5tg4aTvJ7xJSTr0mqlN+iywWA/WZW0
         +843RcMnbNC06egYkbt/HM/dYGKJ4ge6jjatN309onGpB7/g85YmOfu3pyKvHsVC7izF
         zWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747296144; x=1747900944;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gZEKSsAVAm7tLGYRVOWvvqg+w/D70pTel7iaUlMrOmI=;
        b=NVe8Trqz/iWd9xxYr19th4QOpFnXNzt7wFpztAjg+3OMxDcGLQFSmpa+/A0iEZ0fHn
         1ApI8vPRNHVmmtEqpBIgAP98VHjI+PHHH/Hukiz4lnBmSVvlZbvy20VjXWVjWyauqAJX
         zBCag+IoqccPu05JZdzlwA+F5fNyzPBOvgGZW7BCajOmHlN093QWpN8r/O+wbk/lcC9r
         q1GTyb7nW22zt9zVtIzyiOWNEdGdKi96itPLczRXSY85L7/faqTy84I2k4V3r4oXcaVW
         mFnOKJ/xg6QIGDXXVgPt4STv7Y+iz4wXyU/ySRsofBI/dKIsrFdt3BwGUQHsFJ0dTwXL
         SkaA==
X-Forwarded-Encrypted: i=1; AJvYcCUzhnjwcF9oCeFwTp8MfrtomJ+sM8npNclP/9ZVXRPxZrehCQFmP8gVvPUSZb+aX/qO48c=@vger.kernel.org, AJvYcCW3ZVGNYCm5rcy9MBJl9UKQsXISCGghGqykbZivg7h8K6vesgqRUHt7CBRPAQzdYlz37F6GPqpAoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzF+yYO0jfgaqzNr8ybi1vHwZjQiMAL3h5tB3y/E2AfzZosuD1N
	pgingnK8a0wI3dB1cLInctdlK8RetpKmfIm3HPJE67i9cnrHe5VWveUFYw==
X-Gm-Gg: ASbGncvdkUrCwqlQWhmLcfGsS7VACQ2wgSLn7udbNKETzCa8sK+QqYovDdmN9nyQL35
	wdm9YGzeKcMJsMIhYCklQckChZHPRgJydRgHGx1Kf5n3R5KYCkDwQOLCPO30CTWXRdHCdbxRNR9
	Kymj48NDLC6asG1qZBfO2Sv0oQf666LcqwDHQT4dO30aVpo1Q3XpgHgB4cIoXuvOSOQ1eKVxUMN
	PWzWzgMuHi5g86v5XzAPJQQaD2uF9ZjFuLrPVZ61KJhJXjE+wcSGQhx3QSGQwxGiJ7quHbREdav
	FGWkEjkVdH3XtlhDyQPgOpQH/DAUoQ2YDwVFTUjGYmTfiqNO5O/jwrHbgvHrnvqyP9QJ8TyqRi7
	qIZgvu5qhwn7IKBUIdg==
X-Google-Smtp-Source: AGHT+IEm6SOUK/WmdISB6zy+Zco2mnrSrTGDz/0bAf2EHk/YolZr4+BdL/dvi3WRFpN8ac/TfoEEmA==
X-Received: by 2002:a17:902:ef45:b0:22f:f747:8fbe with SMTP id d9443c01a7336-231983de15bmr110822605ad.53.1747296144404;
        Thu, 15 May 2025 01:02:24 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc7544cd4sm110357045ad.2.2025.05.15.01.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 01:02:23 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Thu, 15 May 2025 01:02:20 -0700
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, martin.lau@linux.dev,
	ast@kernel.org, andrii@kernel.org, alexis.lothore@bootlin.com,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
	bpf@vger.kernel.org, dwarves@vger.kernel.org
Subject: Re: [RFC bpf-next 0/3] bpf: handle 0-sized structs properly
Message-ID: <aCWfjGXbLCiGxSf8@kodidev-ubuntu>
References: <20250508132237.1817317-1-alan.maguire@oracle.com>
 <CAEf4BzZfFixwy4vQG8jrUBtAOUFx=t1KG2F+AtKPVNCsMz0vQw@mail.gmail.com>
 <aCG8kz1eZjjw+sSU@kodidev-ubuntu>
 <4bc9b6c3-4e02-48d3-9b07-c7b1069bfd35@oracle.com>
 <CAEf4BzZoWiBqSBhmxviQ21hQ21m5eKQ=CUYk9AMAB+Z3xFkpGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZoWiBqSBhmxviQ21hQ21m5eKQ=CUYk9AMAB+Z3xFkpGw@mail.gmail.com>

On Wed, May 14, 2025 at 09:22:00AM -0700, Andrii Nakryiko wrote:
> On Wed, May 14, 2025 at 3:31 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> >
> > On 12/05/2025 10:17, Tony Ambardar wrote:
> > > On Fri, May 09, 2025 at 11:40:47AM -0700, Andrii Nakryiko wrote:
> > >> On Thu, May 8, 2025 at 6:22 AM Alan Maguire <alan.maguire@oracle.com> wrote:

[...]

Hi Alan, Andrii,

> > > Given pahole (and my related patch) assume pass-by-value for well-sized
> > > structs, I'd like to see this too. But while the pahole patch works on
> > > 64/32-bit archs, I noticed from patch #1 that e.g. ___bpf_treg_cnt()
> > > seems to hard-code a 64-bit register size. Perhaps we can fix that too?
> > >
> >
> > So I think your concern is the assumptions
> >
> >
> >         __builtin_choose_expr(sizeof(t) == 8, 1,        \
> >         __builtin_choose_expr(sizeof(t) == 16, 2,        \
> >
> > ? We may need arch-specific macros that specify register size that we
> > can use here, or is there a better way?
> 
> we know the target architecture, so this shouldn't be hard to define
> the word size accordingly and use that here?
> 

Well, I'm now unsure if this is a problem after reading the code more
closely.  The ctx is a u64 array and the PROG2-related macros process ctx
elems within the BPF VM using 64-bit regs. Does this mean the macro/union
magic all works OK then?

Unfortunately, I cannot test a 32-bit host easily since JIT trampoline
support is still a WIP in my arm32 test setup. But perhaps someone can
share tracing experience with ppc32 JIT, which supports trampoline?

Thanks,
Tony
 
[...]

