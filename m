Return-Path: <bpf+bounces-74305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB80C52E71
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 16:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7AB7135053D
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 14:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B620333D6FC;
	Wed, 12 Nov 2025 14:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="yC2KFtED"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F5733F361;
	Wed, 12 Nov 2025 14:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958891; cv=none; b=h8U4d0vuUJwCwy17N5ihv31bijZAdmyEYO2rHTt3druUW/NACc19zorj1SVtvaTK9A7UKW2SDM1enSNL0wOaa+RhVdZoPOoccwd11GJ8WT7jt4WtdOpsoYI8a/AwYdXnirZiv0HjQM1C7OBkXSRz0Kcl7VHjqJPULKmEXFMRQzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958891; c=relaxed/simple;
	bh=IQuK8rL97BNEfgMOVveuyFpWPQ5iO0/Fn4mlb+DBFNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCJDR5BqyhmIbSK+QbkGT0brWZL5+kYniw1MVfWpn7EAKPA3DTsn7GoY0KG7Qv5NUyA1/rAqUyc3bFv2zUyiyQfnKgEYclydJ4xIG0zn3DBkd8RwNLpur9oR2BIycbLV2/a7ja0GpzCUqEFcWa1dqnDKCYUZDhlTfD6JYvU4Vb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=yC2KFtED; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4d65qM3SY9z9tyC;
	Wed, 12 Nov 2025 15:47:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1762958879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ej6O0iHmvQV6vixUAEP8L03Ws5zQ5xmtbhyoD8rFeWw=;
	b=yC2KFtEDXXB6ScrGVGkvVgkc2eU1Ea1KmmPsdRpGlil2FirEcx+FnYczmyaCfGelUjkUhv
	GHzLRRXN9iT2lZJ7XntSGWMz16kU1iGvuWMAs43gpGBd/aBv2mWZhkNIMFg7ViiYeyOBQ2
	Zgxjyh3ueSInG3uf2d+a0UlyLliKyEvhbb/fxD9BGrn+2o83ityVdzh9WkTj1St82/GE6I
	Cn0vGIxN3Hk7IiKhbvniaQRFQKo+8vlInw1XdnDayozhKBvVqqaUMyuoNADcF3dR0AT/S1
	ZqtQSGPzVEWWmcQGRn6UxsXzQcpQW0c9JzkQqfjNrCqJLRROFHl2nLBbdW4M4A==
Date: Wed, 12 Nov 2025 20:17:47 +0530
From: Brahmajit Das <listout@listout.xyz>
To: David Laight <david.laight.linux@gmail.com>
Cc: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com, 
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, contact@arnaud-lcm.com, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v3] bpf: Clamp trace length in __bpf_get_stack
 to fix OOB write
Message-ID: <u34sykpbi6vw7xyalqnsjqt4aieayjotyppl3dwilv3hq7kghf@prx4ktfpk36o>
References: <691231dc.a70a0220.22f260.0101.GAE@google.com>
 <20251111081254.25532-1-listout@listout.xyz>
 <20251112133546.4246533f@pumpkin>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251112133546.4246533f@pumpkin>

On 12.11.2025 13:35, David Laight wrote:
> On Tue, 11 Nov 2025 13:42:54 +0530
> Brahmajit Das <listout@listout.xyz> wrote:
> 
...snip...
> 
> Please can we have no unnecessary min_t().
> You wouldn't write:
> 	x = (u32)a < (u32)b ? (u32)a : (u32)b;
> 
>     David
>  
> >  	copy_len = trace_nr * elem_size;
> >  
> >  	ips = trace->ip + skip;
> 

Hi David,

Sorry, I didn't quite get that. Would prefer something like:
	trace_nr = (trace_nr <= num_elem) ? trace_nr : num_elem;
The pre-refactor code.

-- 
Regards,
listout

