Return-Path: <bpf+bounces-32944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B46D9157BD
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 22:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59C6B1C21FB3
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 20:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D611A073B;
	Mon, 24 Jun 2024 20:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDkuVBdz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602D91A0709;
	Mon, 24 Jun 2024 20:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719260266; cv=none; b=LicgDmO6VsAq21AzioZN9TGDcS/ciMMzf5obfq/ypHRAWAP5GTFQMNXMJvbBUE2rzuZMaoJelBzH1aymaNmO62hAAL1diZdzbmkxOsemwGXRV1pQjDjcZjkEJ5upyJl0eUBkBTujUQmfMkjttEAjf5iuH99bHXoOIUeP/YAb2d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719260266; c=relaxed/simple;
	bh=FLJYoeXrniyswxiGr8SK+EYXTgjtwtBTZYC63bZVQ+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eN7hPagvUBw6gkljCDt9ECd5jJSiF5D2nWDIndtTVD6FGzSckYtIMGKn1ZvGhbbxslahHS2OXJNsqSbaGUM7HaoEbOcuz8qTYnNDVJ7N1EQgHFSUzFKV2bP5SX4XVof5E01q2HZN5tGwcGcLvdEcNyqi5VlttaW3w+iyz4ISOH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDkuVBdz; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fa55dbf2e7so7719915ad.2;
        Mon, 24 Jun 2024 13:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719260264; x=1719865064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RAOmh2hiuNXBNZg9LvLKgZeR4KPpPOQQTmzgyGyp2R4=;
        b=dDkuVBdzDKkPhPEPRxEt0IsrQt+TiwaXm9A+PM1E2xPm+phG+46Kjp2fW7v2gvLZNx
         xVtQ+PVE/qm/PHGNoRv10GbTGhc3zpWpfWkpiw+2k6wPe+BHM3oslZwQJZ5yiuEj0fkZ
         HE+MaJOUD63aDUbOCN00DPFmWdFL66jrKFNk6mCdOfwLPSiUHClVtYJLU8jhSsM46U7w
         FHAivgnzR/Nb0RFhITaB+BzSqJ+Sq0JQlfHBxCR1Sjm9Z739/iJmz/6/SPtkKCujbzbN
         lap4kfzZu/jAdzmA3ABqopeZO7Q0oi0eygntVyNKWKtumzY7Qj0xDFUf4BUqeb6wyy5K
         Fnxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719260264; x=1719865064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAOmh2hiuNXBNZg9LvLKgZeR4KPpPOQQTmzgyGyp2R4=;
        b=il7+LWavTnkKmQ7UfRDIv7CTIVbGnyWJe8jLqLhuxIR+1Ds0ezgvg/V+jsy+B97UR9
         0k2t+AS/VJ+pqa9cav2Gfwfba+FGgnvJ6XhQEQl7HfLSfJK3GD/7XutBl3V3p54gprKs
         sBfqY2UARuZFLpTJR5Vcpd3ceCqAKx/wrO7sDwEyTgkYOHdOOZaQ5VChYv2skaHMZPRF
         HUWWvG+ymeyIvXX6DGu5nKKkteIs8cCwPoqFAvvelvUOvXUSEZzfH5AGct3NMKXTnRlO
         RAWD3PLh9bskjyTpQknqF2QUCS3ZC0PsVgu9dFQatTpYueFd8FXrS9al5DQnon1wK5RM
         l2Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUrHWm743kiwyLb/CIdmxcVH8cLgJiBLNo5t9Jlf7jG4YIar0TIYI98VYwSVo9S7twlMNMfZvpja+VH6vMeYa9vMPlwe7hRccopFdemFUc5k8cYokU8Ghw34/BOwRtdH6Ks
X-Gm-Message-State: AOJu0YxTjtc3qVfcSP5QtFTTzxMfSnqVQAlLyxGmwFvbTP4BkgHnY/ct
	ts1uEx6wx22TBa0YMnhMowXZ8oa5s3MPv2yEpVm6URiDQ3Bp/U18
X-Google-Smtp-Source: AGHT+IE70VyLy0yRdeTJQHWF/PBBJsL/g9MeTDgW6uX6Zo3X9NCq4ElR1YUb551XBWykbYLXrTfgIA==
X-Received: by 2002:a17:902:f611:b0:1f6:89b1:a419 with SMTP id d9443c01a7336-1fa158de8e8mr61706495ad.17.1719260264453;
        Mon, 24 Jun 2024 13:17:44 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb5df727sm66433865ad.217.2024.06.24.13.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 13:17:44 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 24 Jun 2024 10:17:42 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@kernel.org, joshdon@google.com, brho@google.com,
	pjt@google.com, derkling@google.com, haoluo@google.com,
	dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
	riel@surriel.com, changwoo@igalia.com, himadrics@inria.fr,
	memxor@gmail.com, andrea.righi@canonical.com,
	joel@joelfernandes.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
Message-ID: <ZnnUZp-_-igk1E3m@slm.duckdns.org>
References: <CAHk-=wg88k=EsHyGrX9dKt10KxSygzcEGdKRYRTx9xtA_y=rqQ@mail.gmail.com>
 <871q4rpi2s.ffs@tglx>
 <ZnSJ67xyroVUwIna@slm.duckdns.org>
 <20240624093426.GH31592@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624093426.GH31592@noisy.programming.kicks-ass.net>

Hello, Peter.

On Mon, Jun 24, 2024 at 11:34:26AM +0200, Peter Zijlstra wrote:
> I'm confused. Once you've loaded the BPF thing, 'all' tasks you care
> about should already be in the bpf class. So any fork() thereafter
> should not need to switch classes.
> 
> This means we can have this rwsem be strictly for the bpf tasks as
> Thomas suggested.
> 
> What are we missing?

Maybe I am confused but let's say the BPF scheduler gets unloaded and
reloaded. What would prevent a forking thread which didn't acquire the read
lock from racing against the second loading?

Also, let's say we can make it conditional but would the extra complication
be justifiable? percpu_down_read()'s hot path is one likely() cond test
followed by this_cpu_inc() wrapped in preempt_disable(). I'm not really sure
eliding that can justify much.

That said, as Thomas pointed out, the dl cancel path is silly. Let me clean
that up.

Thanks.

-- 
tejun

