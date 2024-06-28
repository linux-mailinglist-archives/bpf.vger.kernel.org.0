Return-Path: <bpf+bounces-33387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8380991C971
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 01:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B1CCB2399A
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 23:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D3686255;
	Fri, 28 Jun 2024 23:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdsrR5pf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028F1626CB;
	Fri, 28 Jun 2024 23:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719615848; cv=none; b=jRtEDoKFpT82rIqiF7ajHDnEcSUtpg5N5MU5Z/jo4JI2atn6a+EZIwlc79baRHwXccMqnjHzmzm46IYt9D9Rk/rJ3LHiImw90HYwZeZeZnqK9bKrTvsRTlqG//7msoprRSLdaitbnEMx3d5cBb3LA0sbp76pKQLtCDRut3ztF00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719615848; c=relaxed/simple;
	bh=CicfcCuTUeA3+aYRckSO282iLosokX13Zplor8yam/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wy2uW/s4I0nBAAFvJlpkqkZxNp3n6iNJ3SSMOTfPK/yIQ3wSzjvI0CCYmuLhjIiApjGSC4ue/zYTvAYZ11gZYIYhnWIwCpY+W5RHrlfWC1+Zez3yxoGNnVjod6fdZp3ciULgE1wgUljHy/FxVU53KENO5gLuwYGQYl5qjmam6rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdsrR5pf; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f6a837e9a3so6749565ad.1;
        Fri, 28 Jun 2024 16:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719615846; x=1720220646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gEw45/hMrqCm3ZcIasFSkp0KUjPNgmD4UCT3kyA30cg=;
        b=UdsrR5pfyBvLuAOD6+WCcq9TEM9ZNGLg23MSd27DNds0OhgpW5F2gn6UvHsJrhsDFA
         9n9xTbe5N0NI+NknvzLdtyqVFHANp+0oeUQh+ksN7lvjFnOonQc+XW812mxgGc4vT3Z4
         7ugFL+OkXD+KWGqx6kc7FsMymf9CDa/2RrqdtFuWL+YO3Ay+gqHApFfRIu2vdz05l4PB
         Cz/k2rd33D4gOg4idA99zlVhyyHrtml16BAtfdoxkd/hEKSweffd8lrHwXXSZWnzDHL5
         72u1L9IjA4f26Ovg/btUAMKJ7/A0hHdGMiiFf6mdbH84ksbz2zmCl+pL6fKZOs4oZ1sm
         0Lyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719615846; x=1720220646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gEw45/hMrqCm3ZcIasFSkp0KUjPNgmD4UCT3kyA30cg=;
        b=IlxLilT5ttwvlVpamgSPEq73v7+y+NUUym7HfKjlFTQ1Q+uFSsTKkr6gB2bcaCueCF
         2YLbddXzl3oCUoJVnq3CE7WTStbLPbe9YCMuztJLXm2hwAshItbSQwqKqBrxVXd3t3FM
         jhnR7zW1bzC1zULjZq2dY79FGP1B4bqlgRMJ1I8FpYlr0/Vf5qVUGwa0WGcEgsPRPgPJ
         GT9zYsMckC1WiMvkaQ4ZVskP+mddjCc0c3KO0U5hZnFOotlRgZi6jEPTgUuFy7LWq2ao
         56dKZj4HeoWfZ1+QwHTHMC682DOjXDCUG9MiJWkX/UvV+nIc0bxRd3inM/AKj9TE0YsY
         VD9g==
X-Forwarded-Encrypted: i=1; AJvYcCUlUJ3NwJokn+y22dCM1JTU79aCUEnwn+QWaYCvfedKkfw5xHbZgu5/M6TUKU1t+HH5WVOJeO0lTxHZEqGODiZckJhnm+HJPdX0fvrSt+CAMB6l9Cm3rc+E7pdha5O5dD6h
X-Gm-Message-State: AOJu0Yz1HGGQQ4lLYiaIhsZWa7ef9U8DaECxQTMaui9kTaBxUWspMhZ4
	SKMyeEfTEytF7bTHhwTBf6RLx+8/fkGoAArCaa9QuIuIdxugm59J3ExBjg==
X-Google-Smtp-Source: AGHT+IGluF7VP0Kvv/2Nqpvtn+6qDC8jtPkiWpGEJuJXSl7u4qKZ1UnQNufrKKtQP/SzNyJl9iRTLg==
X-Received: by 2002:a17:902:f709:b0:1fa:95d3:80ce with SMTP id d9443c01a7336-1fa95d38173mr85869975ad.68.1719615846139;
        Fri, 28 Jun 2024 16:04:06 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15991bbsm20533755ad.286.2024.06.28.16.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 16:04:05 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 28 Jun 2024 13:04:04 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
	David Vernet <void@manifault.com>
Subject: Re: [PATCH sched_ext/for-6.11 2/2] sched_ext: Implement
 scx_bpf_consume_task()
Message-ID: <Zn9BZB8tE-CySXnn@slm.duckdns.org>
References: <Zn4BupVa65CVayqQ@slm.duckdns.org>
 <Zn4Cw4FDTmvXnhaf@slm.duckdns.org>
 <CAADnVQJym9sDF1xo1hw3NCn9XVPJzC1RfqtS4m2yY+YMOZEJYA@mail.gmail.com>
 <Zn8xzgG4f8vByVL3@slm.duckdns.org>
 <CAEf4BzbVorxvJdGA0eLviRhboaisxe4Ng=VErZVh3MG9YrRaKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbVorxvJdGA0eLviRhboaisxe4Ng=VErZVh3MG9YrRaKw@mail.gmail.com>

Hello, Andrii.

On Fri, Jun 28, 2024 at 03:34:01PM -0700, Andrii Nakryiko wrote:
> > This should work but it's not as neat in that it now involves three dsq_id
> > -> DSQ lookups. Also, there's extra subtlety arising from @barrier_seq being
> > different from the barrier seq that the scx_dsq iterator would be using.
> 
> maybe a stupid question, but why scx_dsq iterator cannot accept
> scx_dispatch_q pointer directly instead of dsq_id and then doing
> lookup? I.e., what if you had a kfunc to do dsq_id -> scx_dispatch_q
> lookup (returning PTR_TRUSTED instance), and then you can pass that to
> iterator, you can pass that to scx_bpf_consume_task() kfunc.

Not a stupid question at all. It's just that all the existing interface is
based on IDs. This is partly because there's not much the BPF code can do
with the DSQ data structure and partly because DSQs are usually not accessed
multiple times in sequence (ie. if the BPF code isn't going to look it up
and hold it persistently, it's going to have to look it up each time
anyway).

The multiple lookups aren't the end of the world. They're all on a resizing
hashtable, so lookups should be pretty low cost. It's just a little bit sad
to look at.

> Technically, you can also have another kfunc accepting scx_dispatch_q
> and returning current "timestamp" as some special type (TRUSTED and
> all), which will be passed into consume_task() as well.
> 
> Is this too explicit in terms of types?

That would work fine too and maybe we can make the iter init function to
accept NULL pointer to start its own scope so that users who don't want to
use consume_task() can skip the extra step.

Thanks.

-- 
tejun

