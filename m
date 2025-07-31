Return-Path: <bpf+bounces-64823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 176E6B1753D
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 18:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1787B560D69
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 16:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F9523D2B5;
	Thu, 31 Jul 2025 16:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="JY54LIN7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E28F22F770
	for <bpf@vger.kernel.org>; Thu, 31 Jul 2025 16:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753980585; cv=none; b=iHNDtyo4PbpcveFSzmF4kRm3rO09qpNcoyWJ6R0mDXKOeVIsZpJ9AjqsMlzUEsvBcd2zXPiLbUjhcys4YYL9qRetRj37o1H26hTHhV3A1ooyOchx+BDU28DHARR2RLRg3U/JODkc9Y2JNQmDmbhs0UHE9AQpjK0dPx5zcZ0e4sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753980585; c=relaxed/simple;
	bh=FJ0p48IFpypKYr1XSk7MfiOUOw0uee+C+NPGoFL7jCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=al6UWqZLB7Ussua4Bp2mI9sYWfAgm+KoVLmF8/e/+6ARdZHC6I7XJIusO16FMTtR/fNI9gIiw8gTXyXXu5ipwdCr1NIDzpB/1mfYZ1E2++gY6SREQLOzLuesh+MjNSLINRzXwucPBZirxmHvVXY5hwMM27opwHB/q/2mqMwO9MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=JY54LIN7; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2ea080f900cso190525fac.2
        for <bpf@vger.kernel.org>; Thu, 31 Jul 2025 09:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753980583; x=1754585383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rq9sv6xgHcn9tOtceIyiWXx6grAaNVR6jyTAwC4qpWc=;
        b=JY54LIN7iqPmwr0HtK0py/DPf6m/d63TJprZl7f4cnKvpuYryDfMetQkWCqu2tDJL6
         g/3mDXWSUp4GPx6vBetKXCEq0QR7c5wkLlVT2roid/4X14AT1WIXfG3ZKPbC3phRAAOP
         tkR1jDJSqSC7g2ZCuj+ipjHAffol5vQ0BjS/kxcMwt4Q4p76vR8LAnWaYngt3Q39U0YQ
         yNhdEXYv3RTI/6Fy6OE11n+/lQsaYN78VmVSQP4GBjGBuK/ZGlqZKiYNda7I3dpAeHC/
         pgVmNZjwdnktH51wNU2ElXGjLjlVOBgPfxtTYsdyssg24JHSjx4VYB9Attcrxd9+pqzS
         LbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753980583; x=1754585383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rq9sv6xgHcn9tOtceIyiWXx6grAaNVR6jyTAwC4qpWc=;
        b=ZR4GPtPC5fduFgJznJPaJ7MpO33hyWjrmccCPxkkjD6HtX5SpQ5BC22K5I7/IllSfx
         2i9xnznzZ5OD2QsTU1hKw+lp0va9Th0WuFLh6bO9OdLCZtm82zpGiRmW8/qeUcRyoANX
         C/EoYLnurMWNpNDu/uxt4QaKag2035W7i4e0G8uYGDxfDG8F7Vf+I/0qXcOBzM7SJ/z6
         rDcY+pYd0mz5YIQkW5IlMZM94PsfeaFK1wN2YJrDKnfScprB2HiIl2rjwWk4zFoDYMh/
         6UU983Pw0ZwxAjsBuIuhLPxE0ecaxKvxIXJbWFk1bZx2J+tY32bPeO6nYfkUzyTvWElp
         vHhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOBblOIfXRyxAA/W76GhiFU+q9EBSYWVEvzhPs05bnMRQFQ7RyVSbaTBzlqEigarQ+m8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs5LGaoQM/lqYZQE/N3TwCNGJAT3h3FXqIrMfIgXo7Vqe4nKAj
	TJrxojncfr21pR3OoFT1O0ZCIFxN/c4oru43WfFTgcyvONwavw/EDVexdT3XrU//aUM=
X-Gm-Gg: ASbGncvzpzgYIJuMeztSfSmmmkS9Jpwlya4WBOCBMyaxt8MmU3AYCSwJk3SCRhbsxSI
	rEWa1hhOKGnxl7obN7kPGg+D+EKWrSyAlEF+A1l7Gthlgvho3cyXDGJU+6uKtiUaoAIncCAfJiM
	4PdUgddHVRRRykf/IF282aKXXzMgAMuGh10kvWGdxgQfol+fkHFvb5Vnv65YSky6zDrPw180WaS
	2y+KK4qPBJzUr77TdcfPwxdSFUWRDmjxkrQZck3/wXaoZ+bQWhWiDkrweBvrrVt7qcYahexYk7D
	hJtEYlwJrSZqt9bn9lVQKFkSXTxxQzK9O7X3+IdR67QqfcnmJZ0HurovglRVubWyDpcYJbNicQZ
	6nZZnnQ==
X-Google-Smtp-Source: AGHT+IH7mtbXa6i5/8Z2w7KfBpWUW/kdgeknQHSXdTbGEahcNzhyEAXNu9vnj/Kqodt0KUh+ti+RKQ==
X-Received: by 2002:a05:6871:441a:b0:2ff:9ed6:2268 with SMTP id 586e51a60fabf-30785aaa3c4mr5628886fac.15.1753980583222;
        Thu, 31 Jul 2025 09:49:43 -0700 (PDT)
Received: from 861G6M3 ([2a09:bac1:76a0:540::3ce:18])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-307a73ffa37sm457926fac.27.2025.07.31.09.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 09:49:42 -0700 (PDT)
Date: Thu, 31 Jul 2025 11:49:40 -0500
From: Chris Arges <carges@cloudflare.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Dragos Tatulea <dtatulea@nvidia.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>, horms@kernel.org,
	kuba@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	longli@microsoft.com, kotaranov@microsoft.com, ast@kernel.org,
	daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me,
	lorenzo@kernel.org, michal.kubiak@intel.com,
	ernis@linux.microsoft.com, shradhagupta@linux.microsoft.com,
	shirazsaleem@microsoft.com, rosenp@gmail.com,
	netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, ssengar@linux.microsoft.com,
	dipayanroy@microsoft.com, kernel-team <kernel-team@cloudflare.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Yunsheng Lin <linyunsheng@huawei.com>
Subject: Re: [PATCH v2] net: mana: Use page pool fragments for RX buffers
 instead of full pages to improve memory efficiency.
Message-ID: <aIuepME92Q9iR22Z@861G6M3>
References: <20250723190706.GA5291@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <73add9b2-2155-4c4f-92bb-8166138b226b@kernel.org>
 <20250729202007.GA6615@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <i5o2nzwpd5ommosp4ci5edrozci34v6lfljteldyilsfe463xd@6qts2hifezz3>
 <01c9284d-58c2-4a90-8833-67439a28e541@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01c9284d-58c2-4a90-8833-67439a28e541@kernel.org>

On 2025-07-31 18:36:04, Jesper Dangaard Brouer wrote:
> 
> 
> On 30/07/2025 09.31, Dragos Tatulea wrote:
> > On Tue, Jul 29, 2025 at 01:20:07PM -0700, Dipayaan Roy wrote:
> > > On Tue, Jul 29, 2025 at 12:15:23PM +0200, Jesper Dangaard Brouer wrote:
> > > > 
> > > > 
> > > > On 23/07/2025 21.07, Dipayaan Roy wrote:
> > > > > This patch enhances RX buffer handling in the mana driver by allocating
> > > > > pages from a page pool and slicing them into MTU-sized fragments, rather
> > > > > than dedicating a full page per packet. This approach is especially
> > > > > beneficial on systems with large page sizes like 64KB.
> > > > > 
> > > > > Key improvements:
> > > > > 
> > > > > - Proper integration of page pool for RX buffer allocations.
> > > > > - MTU-sized buffer slicing to improve memory utilization.
> > > > > - Reduce overall per Rx queue memory footprint.
> > > > > - Automatic fallback to full-page buffers when:
> > > > >     * Jumbo frames are enabled (MTU > PAGE_SIZE / 2).
> > > > >     * The XDP path is active, to avoid complexities with fragment reuse.
> > > > > - Removal of redundant pre-allocated RX buffers used in scenarios like MTU
> > > > >    changes, ensuring consistency in RX buffer allocation.
> > > > > 
> > > > > Testing on VMs with 64KB pages shows around 200% throughput improvement.
> > > > > Memory efficiency is significantly improved due to reduced wastage in page
> > > > > allocations. Example: We are now able to fit 35 rx buffers in a single 64kb
> > > > > page for MTU size of 1500, instead of 1 rx buffer per page previously.
> > > > > 
> > > > > Tested:
> > > > > 
> > > > > - iperf3, iperf2, and nttcp benchmarks.
> > > > > - Jumbo frames with MTU 9000.
> > > > > - Native XDP programs (XDP_PASS, XDP_DROP, XDP_TX, XDP_REDIRECT) for
> > > > >    testing the XDP path in driver.
> > > > > - Page leak detection (kmemleak).
> > > > > - Driver load/unload, reboot, and stress scenarios.
> > > > 
> > > > Chris (Cc) discovered a crash/bug[1] with page pool fragments used
> > > > from the mlx5 driver.
> > > > He put together a BPF program that reproduces the issue here:
> > > > - [2] https://github.com/arges/xdp-redirector
> > > > 
> > > > Can I ask you to test that your driver against this reproducer?
> > > > 
> > > > 
> > > > [1] https://lore.kernel.org/all/aIEuZy6fUj_4wtQ6@861G6M3/
> > > > 
> > > > --Jesper
> > > > 
> > > 
> > > Hi Jesper,
> > > 
> > > I was unable to reproduce this issue on mana driver.
> > > 
> > Please note that I had to make a few adjustments to get reprodduction on
> > mlx5:
> > 
> > - Make sure that the veth MACs are recognized by the device. Otherwise
> >    traffic might be dropped by the device.
> > 
> > - Enable GRO on the veth device. Otherwise packets get dropped before
> >    they reach the devmap BPF program.
> > 
> > Try starting the test program with one thread and see if you see packets
> > coming through veth1-ns1 end of the veth pair.
> > 
> 
> Hi Dipayaan,
> 
> Enabling GRO on the veth device is quite important for the test to be valid.
> 
> I've asked Chris to fix this in the reproducer. He can report back when
> he have done this, so you can re-run the test.  It is also good advice
> from Dragos that you should check packets are coming through the veth
> pair, to make sure the test is working.
> 
> The setup.sh script also need to be modified, as it is loading xdp on a
> net_device called "ext0" [0], which is specific to our systems (which
> default also have GRO enabled for veth).
> 
> [0] https://github.com/arges/xdp-redirector/blob/main/setup.sh#L28
> 
> --Jesper


I pushed some updates to the setup script to make it easier to use. If you have
issues running the script, please share the output.

--chris


