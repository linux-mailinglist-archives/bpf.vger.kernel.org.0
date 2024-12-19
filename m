Return-Path: <bpf+bounces-47310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D75A39F7664
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 08:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3B5C1897F9E
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 07:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A17216E30;
	Thu, 19 Dec 2024 07:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VvYn2RUf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A2B216E2D
	for <bpf@vger.kernel.org>; Thu, 19 Dec 2024 07:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734594756; cv=none; b=IeBcfSbwlAExbuQQrBolT9xY1Umd6Sl3v05YtyAwEtO1RrfJ84W7VC0oRbeBpMO+dlRgYOVVzB7fS0lKU0HKxBqYVwsaaJWTD26yW1DzKW2tjXpChA+Rjx8fNHCHfldvr+XHY9HvspvyLqMuGp13RYYp+qa2c65R3XHVCyyd2LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734594756; c=relaxed/simple;
	bh=K0X8qQPJJ8/59BUZW1kFSDkfSFVaPSPKH+6PB39FTn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxfS+u6PWMP3zJgeVO3ZakdEKcqZducUs9rBJ/8oQeXMUV87Lsol7XLoF3DoPki2XPwiFD2Pc1zILhdWJQqQAfHnUqdZv0+KFOhHRb0IoDbde3inkY+/XLEpjwqxG28p2vAP0zBg++SWrs+yPIXqs3QMpXwKimMb4eaGNWCufJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VvYn2RUf; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d7e527becaso729127a12.3
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 23:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734594752; x=1735199552; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PSh5zdBRE0Lx5DSukPiPhNlF87R8ZTZj0121Qz9y/bE=;
        b=VvYn2RUf5b4D14MSVWKVESmCXlpVUkaPM4awhJ0xxI06LwuNr/R1X1dr+FFsMLlDX5
         wayG+v3EiLyOxWIeJRfWmyppfhuhwzzPCqbvmOsx3/kAyocStWhLdBjfR9h+7zEjsir7
         ttuPqKw7UJkYuVgrHkv9K8qJ62ccW9K1ha3ryU4ZAGeuM04iNmoDly1RsCJwSfj/gmCo
         hJXy7x0W++XJTncuSL0VvfNk0s2PQNHw8ZN315zZUFljGYQDWNArzzCIn/9zB9QVsFYg
         +EBO7AuZdU6931+qMEcdt0DY+s8ng2oYsNBkOBeVJRKyCEw8O7aFHQax3qiAFFy+/2xD
         5nhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734594752; x=1735199552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PSh5zdBRE0Lx5DSukPiPhNlF87R8ZTZj0121Qz9y/bE=;
        b=ZWgqg9cvFhZI2Dz55CekVsT5SpwRd4T/JJ9SKmZoCJvFy/DOasZ2+FegSa13Y7Wwid
         zfuaM52bpFiRODJUsHapinDqmB1xWkn4WFaEKT+dWBIZk0VijzLBYPugueY+vqnhQk8T
         +os5tGC7MBdvadbQaR1/du3Xfv+XHme70cJMN4rmSOv60IRe4Uf9UmETN/ynOCvqfGdj
         YrTNCwHfbT+cWMohyoiCpFiW/uITUItAGAaMYvAfzVw+uWTNPZ/XwFnXiVpyK8Fo9MKu
         j2SrfWTEsi02In3nbr0VtAcYVvwQMF1TgKLma3YhWAJ9uknMh+DzHafZ9NR81YhI9Wjx
         TGJg==
X-Gm-Message-State: AOJu0YyqHKew7Gz5eghQUdcu/9LhieSifZrDK59QC8XPIM2KFblReuuE
	dGXIGaCMjxIbGW08KYgnS6p57Cszs/ctBeuCHmeSTEpTrySBUGgY9Xo5uxrNQRY=
X-Gm-Gg: ASbGnctBqPI6usdyCRVmcUnBzXk6gxNxFY/nNz+jPDt5MVFWk8LfpoKpJAhLHgohJZ1
	Gmi3j+1YcoqloVvUdkXN6RzdXtP9eURW9zZ57qtnJkJbtT0iHRR1bdP70nSTRTBVYGnuACQ/BIv
	A68Q4gFkb2sNWqzrrqQIgUjwiwfWqor9kTxqb6kdFX4JkCQ8F93SD0ZoLyXeKEwPmChhMvUIC92
	2rYKwnc5uHS/vB0R03Lg+k7IzPjliEAsf9PiwyjBOuNPEkqKQFPjfbI6ybPVQON
X-Google-Smtp-Source: AGHT+IGmdcFGiE+dyHXWcxYMeYetvrccLjZHhMlUrN4PpMv4Z/QfsdlsYoYYFwlCHTc2Lt7pBsfY4A==
X-Received: by 2002:a05:6402:4492:b0:5d3:ff93:f5f9 with SMTP id 4fb4d7f45d1cf-5d8025caf0bmr4517867a12.20.1734594752623;
        Wed, 18 Dec 2024 23:52:32 -0800 (PST)
Received: from localhost (109-81-88-1.rct.o2.cz. [109.81.88.1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0efe415dsm36745066b.123.2024.12.18.23.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 23:52:32 -0800 (PST)
Date: Thu, 19 Dec 2024 08:52:31 +0100
From: Michal Hocko <mhocko@suse.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Sewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Matthew Wilcox <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>,
	Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>,
	Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v3 4/6] memcg: Use trylock to access memcg
 stock_lock.
Message-ID: <Z2PQv8dVNBopIiYN@tiehlicka>
References: <20241218030720.1602449-1-alexei.starovoitov@gmail.com>
 <20241218030720.1602449-5-alexei.starovoitov@gmail.com>
 <Z2Ky2idzyPn08JE-@tiehlicka>
 <CAADnVQKv_J-8CdSZsJh3uMz2XFh_g+fHZVGCmq6KTaAkupqi5w@mail.gmail.com>
 <Z2PGetahl-7EcoIi@tiehlicka>
 <Z2PKyU3hJY5e0DUE@tiehlicka>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2PKyU3hJY5e0DUE@tiehlicka>

On Thu 19-12-24 08:27:06, Michal Hocko wrote:
> On Thu 19-12-24 08:08:44, Michal Hocko wrote:
> > All that being said, the message I wanted to get through is that atomic
> > (NOWAIT) charges could be trully reentrant if the stock local lock uses
> > trylock. We do not need a dedicated gfp flag for that now.
> 
> And I want to add. Not only we can achieve that, I also think this is
> desirable because for !RT this will be no functional change and for RT
> it makes more sense to simply do deterministic (albeit more costly
> page_counter update) than spin over a lock to use the batch (or learn
> the batch cannot be used).

So effectively this on top of yours
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f168d223375f..29a831f6109c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1768,7 +1768,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
 		return ret;
 
 	if (!local_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
-		if (gfp_mask & __GFP_TRYLOCK)
+		if (!gfpflags_allow_blockingk(gfp_mask))
 			return ret;
 		local_lock_irqsave(&memcg_stock.stock_lock, flags);
 	}
@@ -2211,6 +2211,9 @@ int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	if (consume_stock(memcg, nr_pages, gfp_mask))
 		return 0;
 
+	if (!gfpflags_allow_blockingk(gfp_mask))
+		batch = nr_pages;
+
 	if (!do_memsw_account() ||
 	    page_counter_try_charge(&memcg->memsw, batch, &counter)) {
 		if (page_counter_try_charge(&memcg->memory, batch, &counter))
-- 
Michal Hocko
SUSE Labs

