Return-Path: <bpf+bounces-43160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2259B0466
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 15:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EC86284277
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 13:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45821D90DC;
	Fri, 25 Oct 2024 13:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/Xpa7fd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF5270820;
	Fri, 25 Oct 2024 13:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729863892; cv=none; b=M6UQl3JGsBvKU2EIiI8xTvsZDgAct+KvbEQvd3jdGuxn5CQMkfMMZK1xcV5l+2TpqBUAUNvr4NdUGEUlvMS8B0NJOGdbDWyouW9Xmylu0fpiypw2C6hqGqTWJbT8X3gWIqOVuxpnte3c/2phGjAaBXiOpEUy+mxi7+RKxgd6hi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729863892; c=relaxed/simple;
	bh=CAGdnmzdmoxehVcocaTIzbUj70Qf3mpqjSw3BlHYZLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XzRX/lqpqtATmPdLAYGCWRFbFCM9GqzdbpsjshVjD4SPNNrWne/GYe1aPoE7oRbYNk0vwgPqQdDuiZZ4PxoosSDBSq4DQs1TSlK5TYJzgG385V89R7KOMeBKLYRmnpPOay5XBlkZoi6U31TVmOtgU1s0Qwrx11u4ra4TQiCfqlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/Xpa7fd; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb6110c8faso20019111fa.1;
        Fri, 25 Oct 2024 06:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729863888; x=1730468688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4f0K/pz8OIuDj4u41V8cbDxkZ5f+rnJD0V2U71WHUqg=;
        b=P/Xpa7fd+gUs4Kqzjp0CRtZRC67ACNMMKJtnuuT5GWv3z6b1mKtXkjyKO+PxHdfaYB
         TAcc4wWAgFA4htd/vNmBLCOkv2rmHWU0svwUGF60/5H3RdPJNHCS/jsrLqyMBbaPEaZo
         zSpt7PjLV2/6+zhca44BUmTyY11AEwyGQcqXNb9V11LoOZmdfAaVRX7ZsmIvZVXBdwV2
         3uD2GQaIQ43HwIdpjyQDmCF5LBJTrCy48mP6FnL1VZjllIjWSvnPkijgPUL4FyeFGlxx
         0mP5B9uhuS9mbVe1kMuJ2gSLnjBnAs6MeB+QlP+utc8a0949M09jxHCtQpaH/h//nUQ0
         IH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729863888; x=1730468688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4f0K/pz8OIuDj4u41V8cbDxkZ5f+rnJD0V2U71WHUqg=;
        b=LZsvpK5G0uySEEAaxnfgXv4MtqZhA3NP/0xFrhK6AQ4CsKW72p5HQ700VLy3iFqTmS
         S0OWaKUkuh1CVy9Hy/bmP8+cWXj0+VBS7YB4OqP73KEgv9Oui3cTCAkB5+A9wBj/CYfc
         +aKK7SPwvpNb3Klf/ron2/iWJAJidv3E3fAOlnuUkfLYPp49pcUqP3pna+7yMhCKVGHe
         rNvoiE/zhCExLooff3cZIIJ7oC4dnPSm2KlTPB+ph96O1S+J9Zto9kZSRbCoQa/F/gQX
         q7o5cYRKCOW0ysZyvj83LtB6EqGp8eEDSbmbe5tBg06ds1kP00n5b4SBm79ytI0HkA6G
         SIJA==
X-Forwarded-Encrypted: i=1; AJvYcCUoCL2Hjpz+px9edyvGLO2oajPZCc2uQ3EPqFrgYBWAwgEm3H8gX8/oqjLgBKLtVVsFt/GT1xc7JJBPlmaN@vger.kernel.org, AJvYcCXE3b/Im+LKAqHIDlzJgvo0vbjyzwThTMIuR/roIzenkoKjcVMsrAs9mvWz5tamLdamN8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9CjnQzoWzxHVYlwOLR9yOscyO6h9CgYPchgGldzW4glNsnVXl
	P6lMcwqGRHtrq/mKrRmBe0m/nMubSqTuBIaJOU0N0Lo05cfD+BJI
X-Google-Smtp-Source: AGHT+IGoqZxgt4vnEFXeIWFdTuQwrFVFALq98fDR3NB0uwiegeoRX/yP0fQXW4Mkw5d0K3PQFPgCTA==
X-Received: by 2002:a2e:4e12:0:b0:2fb:70a0:91e7 with SMTP id 38308e7fff4ca-2fca81d7213mr25486181fa.10.1729863887846;
        Fri, 25 Oct 2024 06:44:47 -0700 (PDT)
Received: from andrea ([2a01:5a8:300:22d3:a281:3d89:19cb:ed96])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb629f338sm638903a12.35.2024.10.25.06.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 06:44:47 -0700 (PDT)
Date: Fri, 25 Oct 2024 16:44:44 +0300
From: Andrea Parri <parri.andrea@gmail.com>
To: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
Cc: puranjay@kernel.org, paulmck@kernel.org, bpf@vger.kernel.org,
	lkmm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: Some observations (results) on BPF acquire and release
Message-ID: <ZxugzP0yB3zeqKSn@andrea>
References: <Zxk2wNs4sxEIg-4d@andrea>
 <daa60273-d01a-8fc5-5e26-e8fc9364c1d8@huaweicloud.com>
 <ZxuZ-wGccb3yhBAD@andrea>
 <d8aa61a8-e2fc-7668-9845-81664c9d181f@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8aa61a8-e2fc-7668-9845-81664c9d181f@huaweicloud.com>

On Fri, Oct 25, 2024 at 03:28:17PM +0200, Hernan Ponce de Leon wrote:
> On 10/25/2024 3:15 PM, Andrea Parri wrote:
> > > > BPF R+release+fence
> > > > {
> > > >    0:r2=x; 0:r4=y;
> > > >    1:r2=y; 1:r4=x; 1:r6=l;
> > > > }
> > > >    P0                                 | P1                                         ;
> > > >    r1 = 1                             | r1 = 2                                     ;
> > > >    *(u32 *)(r2 + 0) = r1              | *(u32 *)(r2 + 0) = r1                      ;
> > > >    r3 = 1                             | r5 = atomic_fetch_add((u32 *)(r6 + 0), r5) ;
> > > >    store_release((u32 *)(r4 + 0), r3) | r3 = *(u32 *)(r4 + 0)                      ;
> > > > exists ([y]=2 /\ 1:r3=0)
> > > > 
> > > > This "exists" condition is not satisfiable according to the BPF model;
> > > > however, if we adopt the "natural"/intended(?) PowerPC implementations
> > > > of the synchronization primitives above (aka, with store_release() -->
> > > > LWSYNC and atomic_fetch_add() --> SYNC ; [...] ), then we see that the
> > > > condition in question becomes (architecturally) satisfiable on PowerPC
> > > > (although I'm not aware of actual observations on PowerPC hardware).
> > > 
> > > Are the resulting PPC tests available somewhere?
> > 
> > My data go back to the LKMM paper, cf. e.g. the R+pooncerelease+fencembonceonce
> > entry at https://diy.inria.fr/linux/hard.html#unseen .
> > 
> >    Andrea
> 
> I guess I understood you wrong. I thought you had manually "compiled" those
> to PPC litmus format (i.e., doing exactly what the JIT compiler would do). I
> can obviously write them manually myself, but I find this painful and error
> prone (I am particularly bad at this task), so I wanted to avoid this if
> someone else had already done it.

FWIW, a comprehensive collection of PPC litmus tests could be found at

  https://www.cl.cam.ac.uk/~pes20/ppc-supplemental/ppc002.html

(just follow the link on the test pattern/variants to see the sources);
be aware the results of those tables date back to the PPC paper though.

Alternatively, remind that PPC is well supported by the herdtools7 diy7
generator; I see no reason for having to (re)write such tests manually.

  Andrea

