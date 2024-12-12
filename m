Return-Path: <bpf+bounces-46711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018499EEB22
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 16:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3A72819E3
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 15:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7265F215798;
	Thu, 12 Dec 2024 15:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GAufUW/u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF016215776
	for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 15:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734016893; cv=none; b=S6HnWtKPom4qmn4Os8cFmpRqLuDWr7Cm7EyZj02T5Rl92n4RSbudoqrxSQ8jSx5Dh6vTNSWyVYy+JjEkklmDAiJoRGpaaC0jFtn2z478DSLNUjIzN9Ih0vshrNevLqg3CWx2/W3IT4GyUdf6BPjuge/n5eTSISkb5X6eEk8w3Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734016893; c=relaxed/simple;
	bh=bk3STfDAAv/V3LnY1I/AoedPy1flrRGJGjRU8Fp+hNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+dSj0OD/dO73T4Wo+FPSapY9eyYdeNKLwUz3AwhZKGR15K3FdK29qQkkvRTYxCJSxR2N+AXCMwYX+kMmZTHVp2frzGHp8ZbxTqhkStnOmyX3EChueccrMy+0Zyy22n5yYQWpvZGIQQvuDi4FDMl5RBVVYDK4foD1bIh01M1c5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GAufUW/u; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434e69857d9so4845935e9.0
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 07:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734016889; x=1734621689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mZgbeOMR0zgVvnSYvzJKoDi9Utjk6AdxNEMQzQ7gxDs=;
        b=GAufUW/uacyakM5kgsJeCoR36HcN6UU0R4KzAceFV2jlCgKpEZ4dkFxIrux5JGpww4
         fmOnveafciQeWdNJjyoFebucG7/zLtksjf+4Gg2gPzwkYLFEX1LL3GF2QS0Tk3sBUagO
         MF+9LeXYJ1tx2DTNhwoOQEP3+gHxQ6n6lS1TIXzjLsaVF6CWTdoSHUpv6mcu7Uo4WG2x
         R5XzAlQxIw0GkN7ruHcZOw5NndbhbGpV+I3Gx9T+0Q/KByyzSOisCk5MOf10IxrmITPR
         BmjPsSh2ykn94nQza82WgAO7WS6ZYESLFsxLnuHE0ywinc6gqV9gWDFQENARHNNXGeYQ
         PIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734016889; x=1734621689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZgbeOMR0zgVvnSYvzJKoDi9Utjk6AdxNEMQzQ7gxDs=;
        b=VUd4Vu2ch7CA7xma3g7biQT1heLkhwqMW5wltM/pmvorGXzAvWp5+JBspJ8H56hXTP
         z3e31h93vjxz0KJdi0SCACcxkDJIXd2nOBv83cSNptS2PBIjQiNAmzzJhv07jSE33HTT
         2yE3GTOaxHgcI1F3nmmVb9G3e3xhIwYWdeldfAbLfULGoRSW3G8sLJRQukZNZMGDvOgA
         nHtgBBMoWfQGZLCiqEANuWXZ/ClbjHOqTL5M22elBnE+FIvjtgMizZ5nnS3oPyuyLP/v
         KYFQgI/+YzPMzv0uSlJsDprBeLCm+3e04MWgudiG6jgaFFiCZP3uaNdGNzIRGcIbLNSD
         mAsg==
X-Forwarded-Encrypted: i=1; AJvYcCXqxJJOYcIEFKSY5kA5tCfUDDbX4orrDxtrA1za/2Mq41SKKKnJXQOrqvv/XgXqyDM3VZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj7oESDOuXhnSy+0TevPYzmJuLGAZ6OKXf7nlEYj7yzMr/n9H5
	H3Vj1lMr9wSaxg+KNXMEIMCmS2r2WVTPyKdn1VeHxaYeHWVe94wDOlraKjXbGYI=
X-Gm-Gg: ASbGncvOIOL5GQGpKoTb6XdqmuQWDP7mrrkzxhBJVfFRb/Ol1Rc6cli7VrFjIog9RGb
	wZud8tMrFBoJ55TW+0xzOI1LgfxEwo+T/2qbVJ4mMevQq5dAUsayancLJGUaxunuwCuPl9bkEnb
	LYK8ofQOfGnbhnS1MyJ090JinEmfEwWlX49o4AP6EeF9yLxlZcnZ72nFtnQmBGF4QYtPAQ1X2O6
	PrjGIVbbQ6T4c0EF+NzBRbtj8OHxJ08HwlbdJSrVntTX58=
X-Google-Smtp-Source: AGHT+IHZ8ARVzgG1bVH56SzNqfVZv1llTYjjlv2rUxxfSg8wKw0wG2wIDftVgfeTx4Rcd8jElw47Rg==
X-Received: by 2002:a05:600d:1:b0:434:9f90:2583 with SMTP id 5b1f17b1804b1-436230e9734mr29316715e9.11.1734016889213;
        Thu, 12 Dec 2024 07:21:29 -0800 (PST)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436255531dasm19430415e9.8.2024.12.12.07.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 07:21:28 -0800 (PST)
Date: Thu, 12 Dec 2024 16:21:28 +0100
From: Michal Hocko <mhocko@suse.com>
To: Sebastian Sewior <bigeasy@linutronix.de>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Matthew Wilcox <willy@infradead.org>, bpf <bpf@vger.kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>,
	Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev,
	Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <tj@kernel.org>,
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v2 1/6] mm, bpf: Introduce __GFP_TRYLOCK for
 opportunistic page allocation
Message-ID: <Z1r_eKGkJYMz-uwH@tiehlicka>
References: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
 <20241210023936.46871-2-alexei.starovoitov@gmail.com>
 <Z1fSMhHdSTpurYCW@casper.infradead.org>
 <Z1gEUmHkF1ikgbor@tiehlicka>
 <CAADnVQKj40zerCcfcLwXOTcL+13rYzrraxWABRSRQcPswz6Brw@mail.gmail.com>
 <20241212150744.dVyycFUJ@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212150744.dVyycFUJ@linutronix.de>

On Thu 12-12-24 16:07:44, Sebastian Sewior wrote:
> But since I see in_nmi(). You can't trylock from NMI on RT. The trylock
> part is easy but unlock might need to acquire rt_mutex_base::wait_lock
> and worst case is to wake a waiter via wake_up_process().

Ohh, I didn't realize that. So try_lock would only be safe on
raw_spin_lock right?
-- 
Michal Hocko
SUSE Labs

