Return-Path: <bpf+bounces-22169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A858583ED
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 18:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C771282EA2
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 17:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9FE130E47;
	Fri, 16 Feb 2024 17:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAYdGpCy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63752E641
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 17:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103898; cv=none; b=OAAO13dTxgWztfezFJ7M743NrUCQY/68mb6adQBLQ/D+rZnUita3BwKXf3VTnKtWVIC/prDCA3K2GM2fURa/VhyIwcw8Nt2jG23fKfo9XRB+TUaXqTGAuyKF3oGjjV7j8Uu7eIDQ9Xnrxl6UTrP+h+t6dA8ibOLKuOIbV/mqlrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103898; c=relaxed/simple;
	bh=8ejHiYGzHvpliygLFvxIO3w4t7CIjLxTT4s3bLYDPK4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0DFyVzcEI9VywFbQfNNueNPKZrinC8GPTRe68cQJKVN14f2Atr9VBujQ/Jx7YGLTnGy64guR5rJDofqRVjSZyFrivUGMtU77zrHoflGWWPswBTWzm7MMQh+sbndcTTgNS5hAVldpSpBKnkdNzCv97PzCk0NFUFlXH7w5wosm8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAYdGpCy; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d220ad10b3so3845021fa.1
        for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 09:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708103895; x=1708708695; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wPLwlhY91L9qTZWCNsWjRuWkNsJGX2gH26bhSLROSnI=;
        b=EAYdGpCydgX0pmiZU0cHnmsx7+su9bDxciUqMfKixbRJwnG75I1/Bni9fC/oF5rKgl
         K21KYXDVLc57isXIcfn8Ol8oAGzE1SkjbLFZuXTbj16YisAtikdHKDT/K00qRGUfuG33
         bmLc7696o8X8ni8uGdgb3FuZTpW7VWP9HlfNjM0VwrM4ThxHCwXBH1OQa/fGUhTNuSZQ
         Vt8VSRZGR+UvEY0CSmdgDyO0L+WNnuLdijNgAt3rHlCtCW6AWDrR/fMVaQznaAXZbKWJ
         bq3DJoO1SbswA6qj/mjlaXzDLgiooV0Bb5eR3sRdRuI//Ot4aVbO8TkoBdMy0MnchArZ
         XFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708103895; x=1708708695;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wPLwlhY91L9qTZWCNsWjRuWkNsJGX2gH26bhSLROSnI=;
        b=YdkiIFPyKZOYZsRkYxcQ3OI6rGxUHLEwDYPcsHj7/csBRtNV8JEUW6xA8iW+2njmPV
         yokiLV7qxBbOrzhkdp23CGMbcqGrXA2XTEUV457dd8OwFyHJGu/tEtfhHSQyZAkRnNh5
         gUaoh/ZNfpTTuqMSNGfAI+fDzR90TCB1GsoNYStMf7mE/TmE7XKkVdtTXXn3yePBFPLO
         pOkl2DlgVqp4T9frsrAiEJ1c9cSSyEiW/HKUxCSkUZ6m+KxAn3sJx8sgg0LoSqZnLblh
         aNP5h8cFwo0biqDcFOfNkB+Q/VsDPlo6DPvq4QmTTKAaO3g63EUIuXHN3C6zbtNUNbCn
         9cgg==
X-Forwarded-Encrypted: i=1; AJvYcCVcSR9xCEgmH6GGvbe+B5J55SF8PLddBPhCxgagVj9vv1WaagcHVyM/+JyLffG1bjDQlOSGcaOZFiYEQaGiHgy9WyPf
X-Gm-Message-State: AOJu0Yz62KEZlzjfnWAoc4Nz2FnbUSsJLELWzXSY6fvmz656AR7u640t
	sCFCKFqVBwTXZptdiYaVg0peFzQV9ipfWum/FpKghtXPnexRM3Tc
X-Google-Smtp-Source: AGHT+IHv5z/KYz8K59TvIWSRmnoqhh/KI/68YnUgWMsLNgswIXXm4noNopRENorEe9kCplMhz+wWWw==
X-Received: by 2002:ac2:4e81:0:b0:512:8777:1f3e with SMTP id o1-20020ac24e81000000b0051287771f3emr3390823lfr.43.1708103894460;
        Fri, 16 Feb 2024 09:18:14 -0800 (PST)
Received: from pc636 (host-90-235-18-79.mobileonline.telia.com. [90.235.18.79])
        by smtp.gmail.com with ESMTPSA id v7-20020a197407000000b005128c3561b4sm23519lfe.13.2024.02.16.09.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 09:18:13 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 16 Feb 2024 18:18:11 +0100
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Eddy Z <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>,
	Barret Rhoden <brho@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>, linux-mm <linux-mm@kvack.org>,
	Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 04/20] mm: Expose vmap_pages_range() to the
 rest of the kernel.
Message-ID: <Zc-Y09fYxwbXOWj1@pc636>
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-5-alexei.starovoitov@gmail.com>
 <Zcx7lXfPxCEtNjDC@infradead.org>
 <CAADnVQKT9X1iSLXojVs1sWy4B-qEGccuk6S6u1d9GBmW9pBAeA@mail.gmail.com>
 <Zc22DluhMNk5_Zfn@infradead.org>
 <CAADnVQJ8azcUznU6KHhwEM99NUOx8oai8EOyay4dxLM6ho8mjw@mail.gmail.com>
 <Zc8rZCQtsETe-cxU@infradead.org>
 <CAADnVQJ_rn+PEETAApwK6iW5LYxGh=-rijpfTB6Y6r8K6sG4zA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJ_rn+PEETAApwK6iW5LYxGh=-rijpfTB6Y6r8K6sG4zA@mail.gmail.com>

On Fri, Feb 16, 2024 at 08:54:08AM -0800, Alexei Starovoitov wrote:
> On Fri, Feb 16, 2024 at 1:31 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Thu, Feb 15, 2024 at 12:50:55PM -0800, Alexei Starovoitov wrote:
> > > So, since apply_to_page_range() is available to the kernel
> > > (xen, gpu, kasan, etc) then I see no reason why
> > > vmap_pages_range() shouldn't be available as well, since:
> >
> > In case it wasn't clear before:  apply_to_page_range is a bad API to
> > be exported.  We've been working on removing it but it stalled.
> > Exposing something that allows a module to change arbitrary page table
> > bits is not a good idea.
> 
> I never said that that module should do that.
> 
> > Please take a step back and think of how to expose a vmalloc like
> > allocation that grows only when used as a proper abstraction.  I could
> > actually think of various other uses for it.
> 
> "vmalloc like allocation that grows" is not what I'm after.
> I need 4G+guard region at the start.
> Please read my earlier email and reply to my questions and api proposals.
> Replying to half of the sentence, and out of context, is not a
> productive discussion.
>
1. The concern here is that this interface, which you would like to add,
exposes the "addr", "end" to upper layer, so fake values can easily be
passed to vmap internals.

2. Other users can start using this API/function which is hidden now
and is not supposed to be used outside of vmap code. Because it is a
static helper.

3. It opens new dependencies which we would like to avoid. As a second
step someone wants to dump "such region(4G+guard region)" over vmallocifo
to see what is mapped what requires a certain tracking.

--
Uladzislau Rezki

