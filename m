Return-Path: <bpf+bounces-43157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8811C9B03C3
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 15:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 401461F215D1
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 13:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD08A1FDF89;
	Fri, 25 Oct 2024 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvLnBKK/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361D61D9668;
	Fri, 25 Oct 2024 13:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729862160; cv=none; b=M4zr5Ai8TKw/YI0xtAsMxxitvXdU3DyrzcxEi2vLbk5sTTzrVhY/L+hx3gV5GQnoDz6a4FmL4VjwGmwWntBJZueO24XTkU4+xYy0HGhZLqyCUhHKydSM55uoMY4bQfAu768Z/VcEhQu19HfUTyDsCZ7JE6nHVrgXbWmCb1ehaHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729862160; c=relaxed/simple;
	bh=6rIo+vdcMEuTUqZoMAe2vVb8Ms1aL7m1jUDOp7NaOlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cIQ/g93j7+8IAmooQmkBuEeQdxAfZnqKGpCxCt4TUi/iQYTIgJIeQopxW5QiBEN/mg/+bjgnTTMiK+0Y2Gb+NFJf6O5rMrMAaa2p7IRLwZEl6OfKs2/lbPeHbaCJXg+FTItaQrpYVi0aYOdkE+69E2yXrQnorSxRWvrkEoClZNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvLnBKK/; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb49510250so21739581fa.0;
        Fri, 25 Oct 2024 06:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729862156; x=1730466956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WFQYI9kn2KpyO6+Zh+n/B/mnlRE68l19bBjZd/mN70A=;
        b=jvLnBKK/l36Ic3qXJoPkya9U7Vw6LzbwzwePBvku5s1QHNNzr075+0EZwR2VL2lkhE
         +UHAWDcaCKD77YIUBi78VOmH2gbodYcIX7q36wpPKUmaMqz0R1AFZ6zFvfKJ5L2h54Hu
         SLD5I/3xqMIjoy4MMVwVg+PujFymdZHYC+8FQDaQfPxo7oiyLNvtVdh/MgfB+EBDmx0e
         cdEivtfgQb4prkyLRzz//bgp0g+GZDq2IBABpYpZ+HYaaYNKy7IJfBJafH5M2Z2aw+Bn
         7MVxlbsgLymj+nH7o8v6fIaQaZvPB41l58VKr5i4f0e3VaByCJeks+6leu3woKeYuybx
         WWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729862156; x=1730466956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFQYI9kn2KpyO6+Zh+n/B/mnlRE68l19bBjZd/mN70A=;
        b=bAZwmzl3KmhNOvTRGdiZX6QsqiSYsViNdXQZwyOd++uUBJ52vi/FlxxHqUA/CUG/rR
         ljIM+EOGHiSasCh5k9S8dYYrEcbnUoXiFEj1XClbVfWa0tIZndNdW5Xr/EGt9fZI2uYR
         Cu2sBmLbfDlYlCmE/YlzlW4TwZCnT0kVMpD+TvrrYJ+qCcEk3GAo8CPVoOHYT7VH45/0
         MDbIAkatXLOR0xtgRrOKCpuP8flbx2vGB+qdc+XZ3CFA2GfjvRQdAhDqdqjbuLvdQXYG
         VtXLQMhXaddMTLCkXkjt44iiWGlruktpHkymy26lu0XpBdJVVWSA2xZ4wxUGmKbjqeZ4
         xhRA==
X-Forwarded-Encrypted: i=1; AJvYcCVMWN4K9XU7FoThr7geEMmpfpDWSnwabWjZkglh9HcNIDEK9ep9tK4pqfMjErseEUpVnyXfxvvQpK0lyV3Z@vger.kernel.org, AJvYcCVi8I3V5FKwImocD3qqSn6XO5IxHjkc9S9kvS5OtzBaSMFSWTjJk8svGI370H567oUtYMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzACQxGBZEXuV4po6fReiAr3NN0WBMHk3MK0FooA2OdNus1fyBM
	ErAjf5PnHDVcBYo5JV7ljNqzRI9M5BEO/bRcnXbPdAJ97MO4XdYIgorqGmuSDrA=
X-Google-Smtp-Source: AGHT+IF/vki52w0HARzbFk6uhj5G7C/TJ4gfz4Tapn5tB1AJ7e6CiehZey0IQiNgqI5DznVN1grc8w==
X-Received: by 2002:a05:651c:198c:b0:2fc:97a8:48f9 with SMTP id 38308e7fff4ca-2fc9d35a491mr58028391fa.19.1729862155916;
        Fri, 25 Oct 2024 06:15:55 -0700 (PDT)
Received: from andrea ([2a01:5a8:300:22d3:a281:3d89:19cb:ed96])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb62580b1sm618645a12.15.2024.10.25.06.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 06:15:55 -0700 (PDT)
Date: Fri, 25 Oct 2024 16:15:51 +0300
From: Andrea Parri <parri.andrea@gmail.com>
To: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
Cc: puranjay@kernel.org, paulmck@kernel.org, bpf@vger.kernel.org,
	lkmm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: Some observations (results) on BPF acquire and release
Message-ID: <ZxuZ-wGccb3yhBAD@andrea>
References: <Zxk2wNs4sxEIg-4d@andrea>
 <daa60273-d01a-8fc5-5e26-e8fc9364c1d8@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daa60273-d01a-8fc5-5e26-e8fc9364c1d8@huaweicloud.com>

> > BPF R+release+fence
> > {
> >   0:r2=x; 0:r4=y;
> >   1:r2=y; 1:r4=x; 1:r6=l;
> > }
> >   P0                                 | P1                                         ;
> >   r1 = 1                             | r1 = 2                                     ;
> >   *(u32 *)(r2 + 0) = r1              | *(u32 *)(r2 + 0) = r1                      ;
> >   r3 = 1                             | r5 = atomic_fetch_add((u32 *)(r6 + 0), r5) ;
> >   store_release((u32 *)(r4 + 0), r3) | r3 = *(u32 *)(r4 + 0)                      ;
> > exists ([y]=2 /\ 1:r3=0)
> > 
> > This "exists" condition is not satisfiable according to the BPF model;
> > however, if we adopt the "natural"/intended(?) PowerPC implementations
> > of the synchronization primitives above (aka, with store_release() -->
> > LWSYNC and atomic_fetch_add() --> SYNC ; [...] ), then we see that the
> > condition in question becomes (architecturally) satisfiable on PowerPC
> > (although I'm not aware of actual observations on PowerPC hardware).
> 
> Are the resulting PPC tests available somewhere?

My data go back to the LKMM paper, cf. e.g. the R+pooncerelease+fencembonceonce
entry at https://diy.inria.fr/linux/hard.html#unseen .

  Andrea

