Return-Path: <bpf+bounces-46492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 102E19EA7ED
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 06:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7599A2844D7
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 05:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7DD226185;
	Tue, 10 Dec 2024 05:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfY3eYyW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D984279FD;
	Tue, 10 Dec 2024 05:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733809009; cv=none; b=upw1kmDJ7gqZZEFowffgoHWM+q7AZ4Hgt4ykR31wuhoxd1gXOW4iFkRVTTvvht+kzujtoahgWaYpRyklziuYufkOZ2rliReP3UWIQQD4Iu4wqmB3HensSNBQyOIWUUeEU7k7o+7u1EceR9EPO7UPANsYIEg8NZ0tw1cwXTzG3Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733809009; c=relaxed/simple;
	bh=JrJ8Bm8JAnzs1EDVbuscoVCjq060UBSwKRMNnYePMhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRDguUCIrorpjqu54Gml3U1facKl6/zBMfAvfW/dsijcTF6qbsFupqznjp3Hyz40igaH/Y9QSP+mbxnwcGaWDHPhYMqwnwKjrcL8F7s1H3vEL3fE8BxZywh5l68KuPxh05t6X235KMMv8YPEmfnz+he8fdx6YaPPgErx0X4PD2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BfY3eYyW; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7253bc4d25eso3869284b3a.0;
        Mon, 09 Dec 2024 21:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733809007; x=1734413807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cTgulTHtQgDK3Mg//RjyfQF5xBtvjN618kewj0RHl1g=;
        b=BfY3eYyWwaqcBFmmsJHqoTjE+AbmmNXz8o7q51BFwyvCoa1oAW/J38Ove54t4oUnjb
         I2I37Aj9NS1b7H3Po0NqfBcbLDoBSh+fRIDRnQDXWRwrqjtw4AOsyhGcEij1lBhCd852
         DhznimzHaQkPMm15EO88H+VFmhwzOFZoH6LVAq8doad4t4SS4oGI1z+6/bd5OUz7lPuu
         cRPiTRaHPYjmw5L0qYEMv9EGqA2N5re+qUBm/ZxRJP0LqdDJR2bIHYLwMtLR+yPr7Yru
         7eAInku6u1/PgFg5KCrVSQIoIIp/m61gLexw9NiFEilZUH9rgh9DD/Srx8psV0AKRcTs
         3YuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733809007; x=1734413807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTgulTHtQgDK3Mg//RjyfQF5xBtvjN618kewj0RHl1g=;
        b=GP8rVWizUK/SHNhq08OSIAZF9Ez9AujzTvOQAlodksD7PKjTKt69dd7yoqh2yQCYVQ
         DeXQBXC8TZp9p4UyMBAFOZnoLbSLW4wnvuGrpbFNB7GxTFEaJks0b7bhEC/lwqcFeHyK
         yNdi3Yi8/q2lErGwUns/jGlo3bFj6gZCb0QVjUYahxP2Zc1ARXRq0O3K6wpurDiNJD2w
         d1Aj9WlsuD8lK6zaoY7Wd9ESY3XppwL5oEz0BwI4UUp2WkaraFz7FaxIYVIaNXVfKfYd
         LzR0N5flC6ZCFGj2GDunZO2zLUOIT18DEm6nnJN40umOCMK0Wi9EYWHbdrQdwtNW7Oyx
         3C8g==
X-Forwarded-Encrypted: i=1; AJvYcCUrVibksZY8Z7EA3ZBtkiB0fo1wjD3+mS6RSCo/76QaGxEvWv7XHNxn3YXqwf3p5rj6KRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVjk99yi4Z1Jl5ACXceCSYzv7XAP3OYHVYvJfMauZk0x8Qqf2m
	hhV/QmDh3bRwdmv5BD97cQxeWzqc3LY09PrciMPlKwXh9HuD0AHA
X-Gm-Gg: ASbGncuwetcgrXlVI2Z4WcjmGSZaYPwSxyvBNLbmkAdx4imrLULFmqEL8lN90X7y0st
	uSn1MmYMbn9ksQsN7K+r1Uy8fWhvhcyovHP6KlnlmDjENYXGU4PTfnmTgzREJSV4Lv/flyD2+to
	DtLr8G8q62jLmfyxQp9irsvAVgpMn2CZznhrkgcWRHCFbfDFta1ZYXFI5BLjKxb04dxBQP3pn8l
	nJrHfrb3TOxD4RtNN/lbEElNDRERAyHB4WzHB6X8vHPZW64swjzseD5mAxg
X-Google-Smtp-Source: AGHT+IGHCqGeWuQm2+dMRoAuMKgYdZfZTJOHBx4K+uZBGL3xSO7lJhwZtv/hOxw2+xYvOwpijgnniw==
X-Received: by 2002:a05:6a00:4c8c:b0:725:4915:c10 with SMTP id d2e1a72fcca58-72889f31971mr3592224b3a.10.1733809006971;
        Mon, 09 Dec 2024 21:36:46 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:5939:82cc:e9ac:c4c3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725d251137bsm5186974b3a.62.2024.12.09.21.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 21:36:46 -0800 (PST)
Date: Mon, 9 Dec 2024 21:36:45 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	Cong Wang <cong.wang@bytedance.com>
Subject: Re: [Patch bpf v2 0/4] bpf: a bug fix and test cases for
 bpf_skb_change_tail()
Message-ID: <Z1fTbcRiDRPU9IPQ@pop-os.localdomain>
References: <20241129012221.739069-1-xiyou.wangcong@gmail.com>
 <fac7e933-a1cc-4863-9610-f5429da0d849@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fac7e933-a1cc-4863-9610-f5429da0d849@iogearbox.net>

On Fri, Dec 06, 2024 at 10:35:28PM +0100, Daniel Borkmann wrote:
> Hi Cong,
> 
> On 11/29/24 2:22 AM, Cong Wang wrote:
> > From: Cong Wang <cong.wang@bytedance.com>
> > 
> > This patchset fixes a bug in bpf_skb_change_tail() helper and adds test
> > cases for it, as requested by Daniel and John.
> > 
> > ---
> > v2: added a test case for TC where offsets are positive
> >      fixed a typo in 1/4 patch description
> >      reduced buffer size in the sockmap test case
> 
> I ran the selftest several times but it's repeatedly failing whereas
> without the series bpf tree CI seems fine. The CI fails on tc tests,
> so potentially patch 4 is causing this.

Ah, thanks for catching it. 

Previously, the CI job failed due to flaky tests, which are tests that
inconsistently pass or fail. However, this time the failure indicates
a genuine issue.

> 
> Switching over to tcx APIs from libbpf might automatically address
> this given the failures seem to be in 'revision unexpected' which is
> likely due to legacy libbpf tc APIs detaching but not deleting the
> underlying qdisc.

Sure, thanks for the hint. I will update this patchset.

Thanks.

