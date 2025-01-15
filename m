Return-Path: <bpf+bounces-48968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 202DAA12AD1
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 19:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F9A8188993E
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 18:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6521D63CA;
	Wed, 15 Jan 2025 18:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9d9uj6q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0471D61A4;
	Wed, 15 Jan 2025 18:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736965597; cv=none; b=UnsZhG9b44yuYkNiDiI46xXFHnpInZYc5qsT+Iufs+1zs4na9DpRCQgzWdvu08BIrbGhvzA9zd+cwL8soBpklbU5lbc/7hrORZHOie2YVxsB8bi0EHs8AkPtkwiXsVSLoea2N1YUvI+YrJmitRuF7leJ8ir4TuIW/9j4CMwC07I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736965597; c=relaxed/simple;
	bh=dAyz89EZoEzWIPFURAivydT9YnLv35q7fBjWn5AOeXM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nf22klOEha+K8Clp+/IvSgCAWx53AwciNVUz/HV7LIkCNGiIrcFXQuoHeIec5sjlKMhUwLXsu/3Yf29bs71KFMoEMxcIRISENIbNkXELWWKBq3T+smb7NDUL8V27ff9FW636qIO9SjFUdRQLFgreSLpIwDBeGu57gtiN7GoLgcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9d9uj6q; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9e44654ae3so16843666b.1;
        Wed, 15 Jan 2025 10:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736965594; x=1737570394; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h5XLRRKi/BnXe8mm5PslXAVqpPJMYf+9Ft4Tl+nHERA=;
        b=T9d9uj6qodXPvpvnh0FIH2x2+uJM/4Fo0M0lTIgyMGtLw8ENcfn9zAOGpTc/6E7tBS
         gdU1c3sG9UFgTIBmFnNxXHEshAQzm9vEZr11hJKNRJdV+C/vAxRUN/jFC2gZCOVcSQq6
         CFYzgi3aR/a8+lDY8ouW3jiOMCiu0lV9dPE+zdhpsoDBgHUATlFzVzT2+bYsiEJOfZuD
         0MDYML2Cbr2w+4mo3pmdctkADfEbH55+/ioRy15Da8Oc/qw+JSLfHY1rvKZkJVFRZ01S
         UL4c+Frw0Rnl8qoyg+JIVqbRGvqc4kn6LaTGtWKuB9AnF1jRoRBVQucvPsmmn+xGDUVe
         xPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736965594; x=1737570394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5XLRRKi/BnXe8mm5PslXAVqpPJMYf+9Ft4Tl+nHERA=;
        b=eyXqr49lK67vBQk3W9AzyAAAzige1Hnv1B8oq/ZuNo/r7XM7xKb/Ky4v5ebL+2nyIo
         pzqYaR01Ieoo22eaj5WWb82vf9vhqoIesYilDR85WigDs638TpZ4nUmRRKuD2RsT9wpq
         z7Dqtjd1+ss7CG6wb+4ZMqV0n4jdv6U0qNLsAmThmpRlDGPS2XqXyFIlQe+xGpEMpbXW
         PNiiCoeQ3ew6CpCXosC5+zuWqgv1e+TOHo/SBobPGiyDA/Pz3G3aahBnim3faRQ3QRcb
         W4XmaHrSZu1bIGO0xXpRi6pqU70l9EEGZhtBgaphrcPjIsV/NHzCKFwdpXxBt4brkonO
         dy/g==
X-Forwarded-Encrypted: i=1; AJvYcCV7HEyrvR8DCMcsdd/boDjuTomVUPD7M6H1ZPg1tEdu0ybtIMbHnKM+rp1e0mbIetrWCgFjRUnBigy2QmLPDUAPGNLl@vger.kernel.org, AJvYcCWiHRzScUdVUTZZfPL42l2NA8thArbfgK6FSsq5ACC9WAhrK05y/BxU3xzjFatlEvLCOyoPa0+N2gRFlOn1@vger.kernel.org, AJvYcCXEJv4T+p5cSr8TLpiJbgHYuX0dDmqdh3w++cKEkVS7JlHRl+1MtL7qTvAOKQAmNUiRkyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+iPcbTsM9uXWd7SKl8M91y7Z4Q+RYHsPRWmheMcPTZw0W3cNo
	/KxvLlDXoDP3FMACk7ybL/fGn7gqCdjujGVp7Mo4qMXdEnEgRs8SGMGmyQ==
X-Gm-Gg: ASbGncsgfH54d0wOHKYUJ7eQhQpl6zj9fEThKYSr5BKC5tPI9uCTv/TrmRQcwwrNYVz
	FSsicBXKqboTaxOuDQIee7RElSCFG+y9oq1iDS6DUGwmQ8eUsn0AgOWt0sO0P/4qLQ5tmq4NEKg
	k2dTXtDIM89F+gVxz8yXdm5lGBK/xzXO0xIsDrq/maQyK94KbqpqUZI+fNNzpVVmbbdtH3OxDxb
	mcdbi1aRRzGeJZfAKZGnebDXmBIm45BSA+OShKrWQ==
X-Google-Smtp-Source: AGHT+IFvh8cjZKvBu1i/Z84VVP8RrVEC2PYJri+pYoLzmdo5Uc6hJX93IkB84KZmtQG+GcYsqBxSKA==
X-Received: by 2002:a17:907:1c8c:b0:aa6:7cf3:c6ef with SMTP id a640c23a62f3a-ab2ab70a362mr2731381766b.15.1736965593853;
        Wed, 15 Jan 2025 10:26:33 -0800 (PST)
Received: from krava ([95.82.160.96])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c9060db6sm791648366b.8.2025.01.15.10.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 10:26:33 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 15 Jan 2025 19:26:29 +0100
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	David Laight <David.Laight@aculab.com>,
	lkml <linux-kernel@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	x86@kernel.org
Subject: Re: [RFC] x86/alternatives: Merge first and second step in
 text_poke_bp_batch
Message-ID: <Z4f91RUP8sDniss7@krava>
References: <20250114140237.3506624-1-jolsa@kernel.org>
 <20250114141723.GS5388@noisy.programming.kicks-ass.net>
 <Z4Z1MoJV0WW-vIHp@krava>
 <20250114103604.7388352c@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114103604.7388352c@gandalf.local.home>

On Tue, Jan 14, 2025 at 10:36:04AM -0500, Steven Rostedt wrote:
> On Tue, 14 Jan 2025 15:31:14 +0100
> Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > > IIRC this is the magic recipe blessed by both Intel and AMD, and
> > > if we're going to be changing this I would want both vendors to sign off
> > > on that.  
> > 
> > ok
> 
> Right. In fact Intel wouldn't sign off on this recipe for a few years. We
> actually added to the kernel before they gave their full blessing. I got a
> "wink, it should work" from them but they wouldn't officially say so ;-)
> 
> But a lot of it has to do with all the magic of the CPU. They have always
> allowed writing the one byte int3. I figured, if I could write that one
> byte int3 then run a sync on all CPUs where all CPUs see that change, then
> nothing should ever care about the other 4 bytes after that int3 (a sync
> was already done). Then change the 4 bytes and sync again.
> 
> I doubt the int3 plus the 4 byte change would work, as was mentioned if the
> other 4 bytes were on another cache line, another CPU could read the first
> set of bytes without the int3 and the second set of bytes with the update
> and go boom!
> 
> This dance was to make sure everything sees everything properly. I gave a
> talk about this at Kernel-Recipes in 2019:
> 
>   https://www.slideshare.net/slideshow/kernel-recipes-2019-ftrace-where-modifying-a-running-kernel-all-started/177509633#44

nice! thanks for all the details,
jirka

