Return-Path: <bpf+bounces-47230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7391A9F64E9
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 12:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CAF6188C089
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 11:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFAD19ABD4;
	Wed, 18 Dec 2024 11:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="X7Ko9W75"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCF7158853
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 11:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734521567; cv=none; b=Rrd8IPIx5OKPSAXG6KlnlqZIaMHwNAiLRavQhs8Aydt4+oTVSGIBO4+6Pz9YCzJ19MqB45JSHBY8CwfsjqHhKxV8pksBjxqjtnDO0S7wWKLcDfBtP/YvCKgcFQ1iF03SbUzSbtaSaoFHKYupGfhydM2ufWMpYEQRLKsb6dTPeYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734521567; c=relaxed/simple;
	bh=QadkTB0yKyfoei21YxKhsZ/TYFHrVwLQwjUokBlPjFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQbnYXSVYrDrc79po95u3NXpUS7tIfNl3/25i9qKdJiZWHDhEWw69ou4F54jzMO2QxkaiztWNbkP8RahFcEYz/YsggQIRM6sVLA9i/wlqMrFHsgRcshJZV7K15DZl2L9kQdQPshNy2nqJkiklmVs58MwW6D5DwE7YvruBgSUnw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=X7Ko9W75; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3e6f6cf69so3661055a12.1
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 03:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734521563; x=1735126363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LZJwwmcQBEF7Vv0pbmFocrZnFohz2fBt7d/cH/Oco8c=;
        b=X7Ko9W7544vs8TkJWGRUWI+nqrTyrszlg/7/IIzfOlKrtMZtE1tnugNs3G4YiOuOA+
         OBQFNdJU+uHrWwfMoObyMbtiPmg7bQOmMMCB5RZBMPgPD6KDS1F02pcyCAOayiRAiDLn
         0E153y4gw9C0kT4XY3vjZc/mvTxzpyFOhMJwzVhSJTS/KHXmIaMSRTCfMpP+n9+g14h8
         SDg90NyR8BYi3dkmlKRIVq3cYsKNdVN/+GCEHazs6m13JO/74WsjxEN54jPLlNDL6gpT
         2c2Svi+EXN13BMofViB6PL5FDQ5aQIxGb6dRxXDW/83iNal1ZyN6gNkLmVs8J1NW+V+E
         phdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734521563; x=1735126363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZJwwmcQBEF7Vv0pbmFocrZnFohz2fBt7d/cH/Oco8c=;
        b=HxhliBNwlPuTwULApslU7O9GtzgT5CC6BiwL3Kf02oph/XJJMQQyan0qGEZkCvK4P+
         sMyu8mtFcAxpARtL4qWo+QuAAsiUodncWDxNR5Qs3ToilpWl8f/eBX5JUCEbYdQkuWg/
         97gmX2DCyabTAAGSS7rDZDZC+ugTCYrPeFie4AkbnAmmq1/4Hko7H+ZkYi2UYKvF9RQu
         4cf7PkjMzG4Nkj2O2UTHVkAGDsoxhoNEJrgKWtCrI6IRr+PTmp9csdfyEciAbeHGCBka
         gr4Wtb0Shn63vM58mBaHSMhTNfAWAyoIq35MeLMJYKUrErhRo857Ksw5JT8GalLLn6nJ
         zpGA==
X-Gm-Message-State: AOJu0YxNg4HTnDlL3hR1ZiYg514E4yDZ1V1rV5Oi50Rmzk57BxC5VUyL
	/+eEiU7QMQMURL97kAIajbGCm9f2QkHojWHaHRlOTGQGNFHpMfh2OMocxYFSl+s=
X-Gm-Gg: ASbGnctHVxL6vPe1uUT8No8u+rfPWMoWuSR4u6bu+PMPGEuYNsM4HR0SAaJK0Ool0zv
	l41bL+RK62EBfOn4AEMHsPAOfIu4YNUCFCC7sytq5p0Kp6ic1aK/aXiyhWLLd7kvWFRYhkggFue
	YsKxn+7zB331nYLxr6kS9EKJ18J8iaZtfzNhOKORGioWVV1D6Nx9Q+SgRrrDpuFijHKOHC85W9U
	PE/KuSbnqj9EQCRq2t29FwnC6wV6NJJCaY9DEgPHkAPR5AQ0sQ+edVuRfXbJpV8OMo=
X-Google-Smtp-Source: AGHT+IE5VujHh3Dnv9oj0fGchFrHkd+6EqA5Iv+rxWcXjMtHztBOzGDREwwyqalQIENpXUEQsgVa2g==
X-Received: by 2002:a05:6402:2113:b0:5d3:d8b9:674d with SMTP id 4fb4d7f45d1cf-5d7ee2dcfd5mr2281660a12.0.1734521563418;
        Wed, 18 Dec 2024 03:32:43 -0800 (PST)
Received: from localhost (109-81-89-64.rct.o2.cz. [109.81.89.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d7e5ceff0bsm1303313a12.65.2024.12.18.03.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 03:32:43 -0800 (PST)
Date: Wed, 18 Dec 2024 12:32:42 +0100
From: Michal Hocko <mhocko@suse.com>
To: alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org, andrii@kernel.org, memxor@gmail.com,
	akpm@linux-foundation.org, peterz@infradead.org, vbabka@suse.cz,
	bigeasy@linutronix.de, rostedt@goodmis.org, houtao1@huawei.com,
	hannes@cmpxchg.org, shakeel.butt@linux.dev, willy@infradead.org,
	tglx@linutronix.de, jannh@google.com, tj@kernel.org,
	linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v3 4/6] memcg: Use trylock to access memcg
 stock_lock.
Message-ID: <Z2Ky2idzyPn08JE-@tiehlicka>
References: <20241218030720.1602449-1-alexei.starovoitov@gmail.com>
 <20241218030720.1602449-5-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218030720.1602449-5-alexei.starovoitov@gmail.com>

On Tue 17-12-24 19:07:17, alexei.starovoitov@gmail.com wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Teach memcg to operate under trylock conditions when
> spinning locks cannot be used.

Can we make this trylock unconditional? I hope I am not really missing
anything important but if the local_lock is just IRQ disabling on !RT.
For RT this is more involved but does it make sense to spin/sleep on the
cache if we can go ahead and charge directly to counters? I mean doesn't
this defeat the purpose of the cache in the first place?
-- 
Michal Hocko
SUSE Labs

