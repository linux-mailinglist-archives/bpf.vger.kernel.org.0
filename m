Return-Path: <bpf+bounces-34007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CD29294CF
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2024 19:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 301941C20B29
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2024 17:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C8213AD38;
	Sat,  6 Jul 2024 17:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJHOU6uy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836F528F0;
	Sat,  6 Jul 2024 17:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720285243; cv=none; b=ZbTiuAec1rP0HWA6FSEsIkp3N2czCQ5am+0uxZZkaxWTe+f2XgqBcFC6R9kCsDMTwPb8KbL8QKDEAZMP+LI6uN4y3+boZNnA8Bum83UNs+UrQ/JcvdmcuwMwuq2HMRBdTBtFkbxJ0Q2dbh69YU0kCk6N2WgQRv69nZ3QpyCmeU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720285243; c=relaxed/simple;
	bh=r62kLmk4KIOWduQ87dV6jX3JzApMJyAxRhaCFS8VmXc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sV0NqbGQCJS4V3fKzNmvInILj3iF9LaSzM2GfB6U6RgB6cFgCakrltg71u+JhIHxKz0uKlfP4XyS9OE5GbBdZNUilUXfyIpsDE0SSEZu3/z4XQCMQEq1IbH7zsCg2IfYu9GDx+5xN/0kjwXTI7oUEpC4Oz/12nOfJlesbDIVobo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJHOU6uy; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ebed33cb65so33328901fa.2;
        Sat, 06 Jul 2024 10:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720285239; x=1720890039; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QdBNstYQKMFk0gY6Xt+4H3zohwS5ELL5lmdf+bl1CzM=;
        b=dJHOU6uyo5ukn3lrG24kx7i033NZT+ugjQxaBlqmm9eZGqkOOWkeXQYREIG7v/dB+P
         HBmr7M4IUEymeAHVsEkxC6M19U197DzySBryju0RPfkseIpzfaujrADHfoEO+ozKPdW9
         robok1daQqqblP+U3k3n8ndnNGrbeJk2dIcGY2GQQTXTjZIuA4FuCLZGE27+xXF8m6/2
         sjexigR/02UsN5FVantKrUwK93H/WJWmSbEeZLyb5QeM05Z6WscMJmg9nKI66uy64Fb+
         S7Bg9Gwo2XN/vb97XQUX26HQXf8PmS7Ku9zR6sZIylmTCIRHpqYbakwWNIBVFCzyRx2a
         xtAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720285239; x=1720890039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QdBNstYQKMFk0gY6Xt+4H3zohwS5ELL5lmdf+bl1CzM=;
        b=ILKKYpPSm8UgJdkfHjQVNbuoztDXo1xhUhcgB9G49EfUEykjNPNLX2aj8/Z2mCxZ3J
         kLa3u30tRiT2n8MeItcGBCrGFywiiGpMi8NBjc/AR8IyBSpgqeCt70WQQ6qYjmpUeYOA
         3MoXUXw5pU5/TI3ONuGqMvODatANuFNf9kGNQnn82yeAChXIJDF21MaY930E4aDW4ubs
         NQn5b0LsFlcYJ+xW0s+m0sqK5QwGeyRFX0ecvRHEBEgEofxG6TXa+UmaIkzE4KFbWGAK
         O2/pPJPBU1AwcvbwMmsr+qB0iLdF7hUrMZFNe89GmtiFSpsjl/2EfvYKfZipWETjO+CD
         calA==
X-Forwarded-Encrypted: i=1; AJvYcCWDpwyxA+MhvazKy+qRdV90/cZKdZVAi5oqsSP+IC0sCM3Wg5u6YOviqzbFUvc6qDSXQSCs2DC/WjukuQLF/oPbG/JA+lb0W9Vz5l9MbeF8VSIhmWBJmD/fPSh3/vDYhQNmoFF4dHjY
X-Gm-Message-State: AOJu0Yy7D/je3oXbaoXxAGg8EKgFMCshnV+tYgBmbTwAJAsx77+456vg
	xjjpoeO608/y6BKaRxrxJbEb8EVrQWmFpxrikcFTUaRZOhnZDX3c
X-Google-Smtp-Source: AGHT+IF7GvNyOGw8499JfJfHxu7q1RkzVbaqWWFZCxtp1y18Sbc93JEtvdBAB6EFq8Dgigav6C9a0g==
X-Received: by 2002:a2e:9008:0:b0:2ec:1f9f:a876 with SMTP id 38308e7fff4ca-2ee8ed24cc0mr54130981fa.6.1720285239214;
        Sat, 06 Jul 2024 10:00:39 -0700 (PDT)
Received: from krava (37-188-174-24.red.o2.cz. [37.188.174.24])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58cf5bdeda0sm4614386a12.73.2024.07.06.10.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 10:00:38 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 6 Jul 2024 19:00:34 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org, peterz@infradead.org,
	mingo@redhat.com, bpf@vger.kernel.org, paulmck@kernel.org,
	clm@meta.com
Subject: Re: [PATCH v2 04/12] uprobes: revamp uprobe refcounting and lifetime
 management
Message-ID: <Zol4MjpXdXPXQKXI@krava>
References: <20240701223935.3783951-1-andrii@kernel.org>
 <20240701223935.3783951-5-andrii@kernel.org>
 <20240705153705.GA18551@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705153705.GA18551@redhat.com>

On Fri, Jul 05, 2024 at 05:37:05PM +0200, Oleg Nesterov wrote:
> Tried to read this patch, but I fail to understand it. It looks
> obvioulsy wrong to me, see below.
> 
> I tend to agree with the comments from Peter, but lets ignore them
> for the moment.
> 
> On 07/01, Andrii Nakryiko wrote:
> >
> >  static void put_uprobe(struct uprobe *uprobe)
> >  {
> > -	if (refcount_dec_and_test(&uprobe->ref)) {
> > +	s64 v;
> > +
> > +	/*
> > +	 * here uprobe instance is guaranteed to be alive, so we use Tasks
> > +	 * Trace RCU to guarantee that uprobe won't be freed from under us, if
> > +	 * we end up being a losing "destructor" inside uprobe_treelock'ed
> > +	 * section double-checking uprobe->ref value below.
> > +	 * Note call_rcu_tasks_trace() + uprobe_free_rcu below.
> > +	 */
> > +	rcu_read_lock_trace();
> > +
> > +	v = atomic64_add_return(UPROBE_REFCNT_PUT, &uprobe->ref);
> > +
> > +	if (unlikely((u32)v == 0)) {
> 
> I must have missed something, but how can this ever happen?
> 
> Suppose uprobe_register(inode) is called the 1st time. To simplify, suppose
> that this binary is not used, so _register() doesn't install breakpoints/etc.
> 
> IIUC, with this change (u32)uprobe->ref == 1 when uprobe_register() succeeds.
> 
> Now suppose that uprobe_unregister() is called right after that. It does
> 
> 	uprobe = find_uprobe(inode, offset);
> 
> this increments the counter, (u32)uprobe->ref == 2
> 
> 	__uprobe_unregister(...);
> 
> this wont't change the counter,

__uprobe_unregister calls delete_uprobe that calls put_uprobe ?

jirka

> 
> 	put_uprobe(uprobe);
> 
> this drops the reference added by find_uprobe(), (u32)uprobe->ref == 1.
> 
> Where should the "final" put_uprobe() come from?
> 
> IIUC, this patch lacks another put_uprobe() after consumer_del(), no?
> 
> Oleg.
> 

