Return-Path: <bpf+bounces-47515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BEE9F9F02
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 08:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD239188CF19
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 07:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F385B1DF986;
	Sat, 21 Dec 2024 07:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OI6FIDqK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327892E40E
	for <bpf@vger.kernel.org>; Sat, 21 Dec 2024 07:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734765610; cv=none; b=kFF5vqYixw+n3/9F/WH7wuiysPKz37CoQBGb4pPnnRb+ruj7RyCZ0TF6n0AM8DbMa/IZEb1fA0aiVu6aa7j28ap2t6TxDnsNWoFCs5VbfeRPwZJP4k4Gb+N/c6PnfbBXNHBBtD515sbq+I/hvZgVnGOWuGsc4yI8TOvmKhK5fZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734765610; c=relaxed/simple;
	bh=fDEi0+OixBIWkicdkPlFKEAe6AUENWC3w/QJh28yTpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g38xaFxXXwMUkWB0VVheiCmvCO56HHeCA4vEcmvw65lvOwiLSYHskHn4YlWIGE4zAoz6NwQry3NpdClQ5E7w3k6jK6yhk66kbGI4epJ7tlR6L1+806IXrRczpZGIuiXFPrN8kQAXO0Do8gX0ISCkqqmZf6DXXyrgx4aPwmmOe8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OI6FIDqK; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3e829ff44so6678504a12.0
        for <bpf@vger.kernel.org>; Fri, 20 Dec 2024 23:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734765606; x=1735370406; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ta8by0OOD3Sje5pGqMunjNYqORLTA1uzBkZO/jeEobE=;
        b=OI6FIDqKlKReZJAnUODyeMuCCgRm+YeYnt/pWetjRxLAOXfUkqnmxIH7/1zXiqb5wR
         EbEMWz99gJ9OMzyF7GNs4LWMbnEzyaG+cpYqKk1D+9z1vubZuBTJVcGbMY4gLwTZ8FKK
         o+5x5GWTJ5IbaxYvSTTn+5EUXc+2Uhfi0W2zB1IdvdJSNxiD6+C8X6Y/sTLDEAAQgAFz
         TXggyP0sfJwt90bzNzsQGqvkicTUmcW8Y7pFYZfRutXnl0ro48RWa5Oyc51D+3QOOi6I
         ETaBL4YVYwHMaJwCYCiF2PO42cGG4i+5d3QFv8nPHi0ikiDXcWLwx8AU/GLMYYr3O8D/
         RmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734765606; x=1735370406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ta8by0OOD3Sje5pGqMunjNYqORLTA1uzBkZO/jeEobE=;
        b=deLBMmPGXt3K9K7vHn2m1SGFY3lTtHyHFhP2fRT94FKF6gHlr0Haz+1ZBIegqFzbVa
         ft4HFeF1noMm7ULiBusJfABaE6RTf/5mZ87wyVDErUYZiW+QQCnQj15+R6eEENgSB0fy
         WaZtJddGBq3E1YSFAVLjdlaW0ImMfrE6VDjZ3Cyiv9rDjMCUyY46pkM9ZGTWvCAH9/I8
         fiMzva4Fd//35yNR7ryvdD8ARIclx3HDtKyhaFBLHB2QtawlAXLA1HaU6XNPn4td4FvN
         V8FtSxJ+KJa1mPfVI391mNk146wKKJNEiBwTUVUMi0psnRwIwCADqsRo1Hc93h37m1vq
         v8tA==
X-Forwarded-Encrypted: i=1; AJvYcCW+DfN6mHvmoXXeRGjxhr2D96NcPHHDT8Ib69JcYB9LrNus9xgYpRGatnorSUdBVR3uhXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9I16fy10jZKSKcQohYNyw3CVUzUx6uJ0NjVRqmh5Vg9A0Ej31
	hX0U2tcf66Y+RaUkkp+7qHFPYksmkey0Ch0W7mhTXv1SAkoFrfEGCWI5ArRCo9U=
X-Gm-Gg: ASbGncvW49QhU0zhbEzQQZQL3LBZeQ/pPgHE8VUbatFY4eeK6XwihAfYPhuXcmvNkZC
	IpAkb00xmGfE/7/MNWzCbdonsc+kQG9TT2whW7HVW9A8gn9orUn4plWphmLGRy/5NnWcjkUfk+N
	qIoudg4O0ioXawlNM/TPJGfkL4RgQG/OrKMj2+fclkab1O5lL38g3EkHYxE294yIHZJiLNuAJlr
	BaJi4Y7oDXpJ5NOwcCzd6hSIFg4UakbJnr+caMbWHJl+yXjF5Vuj0xGovceSptl
X-Google-Smtp-Source: AGHT+IENdU3mOi2Igfre+P34YkECiGLr+qi5rkhYGGdHBIiE2OaGzKDRo6utwmhYH1GG+lh6Jw7sgQ==
X-Received: by 2002:a05:6402:401f:b0:5d6:3716:950e with SMTP id 4fb4d7f45d1cf-5d81e8c1344mr5062942a12.11.1734765606493;
        Fri, 20 Dec 2024 23:20:06 -0800 (PST)
Received: from localhost (109-81-88-1.rct.o2.cz. [109.81.88.1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80701c94csm2460513a12.85.2024.12.20.23.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 23:20:06 -0800 (PST)
Date: Sat, 21 Dec 2024 08:20:05 +0100
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Sewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>,
	Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>,
	Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v3 4/6] memcg: Use trylock to access memcg
 stock_lock.
Message-ID: <Z2ZsJXgysg-lamGC@tiehlicka>
References: <20241218030720.1602449-5-alexei.starovoitov@gmail.com>
 <Z2Ky2idzyPn08JE-@tiehlicka>
 <CAADnVQKv_J-8CdSZsJh3uMz2XFh_g+fHZVGCmq6KTaAkupqi5w@mail.gmail.com>
 <Z2PGetahl-7EcoIi@tiehlicka>
 <Z2PKyU3hJY5e0DUE@tiehlicka>
 <Z2PQv8dVNBopIiYN@tiehlicka>
 <CAADnVQLm=gSAh2u3iF4HoGmLEqa-AV0FAEnDqcoFYDgZ06d+gQ@mail.gmail.com>
 <Z2Up17maf6FHkVu5@tiehlicka>
 <CAADnVQ+t3EF_CDrsYuY4eR87u1YnoSoj2S7fCQS7gi67cdhz0A@mail.gmail.com>
 <7s6fbpwsynadnzybhdqg3jwhls4pq2sptyxuyghxpaufhissj5@iadb6ibzscjj>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7s6fbpwsynadnzybhdqg3jwhls4pq2sptyxuyghxpaufhissj5@iadb6ibzscjj>

On Fri 20-12-24 11:45:47, Shakeel Butt wrote:
[...]
> I think the code is fine as the overcharge amount will be refilled into
> the stock (old one will be flushed). 
> 
> 	if (gfpflags_allow_spinning(gfp_mask))
> 		batch = nr_pages;
> 
> The above code will just avoid the refill and flushing the older stock.
> Maybe Michal's suggestion is due to that reason.

Exactly. This surely begs for a comment to explain that.

> BTW after the done_restock tag in try_charge_memcg(), we will another
> gfpflags_allow_spinning() check to avoid schedule_work() and
> mem_cgroup_handle_over_high(). Maybe simply return early for
> gfpflags_allow_spinning() without checking high marks.

Right you are.

Btw. I will be mostly offline until Jan 6.
-- 
Michal Hocko
SUSE Labs

