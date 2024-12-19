Return-Path: <bpf+bounces-47303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B13F59F7521
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 08:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCF907A3E66
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 07:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B052165EF;
	Thu, 19 Dec 2024 07:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MDAi1mVN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09722216E3D
	for <bpf@vger.kernel.org>; Thu, 19 Dec 2024 07:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734592131; cv=none; b=bsiFJVTcaOc3q7+ZI4dkcyYsyFg6aEWriMhwJVAfN/G1OiPDLQlNcZbOZ4E7FIoV65Q9ROYX1cXghsnQkl7xoPbsCRkZ/DCWgh3JKKAqezm3WSKq99lNAZHKoTOyV0cTmm5xb5pHRNeiypImO4eHFfpHq/gq8qtypZ8/A3QhT54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734592131; c=relaxed/simple;
	bh=46+9uwWedKCwpk5aOox1MGZLDvopJkv9DlptqYeCxp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nX7mZuNUsXEK3Llx07lN1oRG0cs6Ptj8WMxKWlPwoep2LgqgIhZdDce3FjkpIwVD6o++HYOFe7bDaqi77ErYaGKoiJ8uBeBPYNjuNRZ6pggtHomaK/ezxrqOjh7gDJC4hn+4XpWEzEHCogFCsAz52lsams4YHq+fnejwCy6SGTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MDAi1mVN; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d7e3f1fc01so774273a12.2
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 23:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734592124; x=1735196924; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZHL2jwSQ1yG7oeFTY7JlDNx5B7u32acM12Cti4taGy4=;
        b=MDAi1mVNED6k/YlHmhaQKXjKajT/yUu8mcCNoxGpPK5aZxpro47MV1YgU1XqHxWSjk
         meqibiI3J46zVWV3PgV/FaDKa6S/0DaPfp2rUWU1eiaBH3ybnFL3zy84k8DFKbADiXJ9
         J2cUFmWp4J3TjAaQcGLYxQT7UXivNHF6NNlhwZsmGfu1BM+HIBWe9pp3zIrzIuoJs0wR
         n+j2w84De1v2wbd0S+fSz531n3cFbHkjSGqWfrrKkDtcCZFREbq7dewOuPAHmYbjlu28
         JiwTrjvcKLSzAFtYrrkl6CjYymjylM8DZqdmJpKnMffEUbDFqAmK9nJuis5hX0xYi2l/
         tdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734592124; x=1735196924;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHL2jwSQ1yG7oeFTY7JlDNx5B7u32acM12Cti4taGy4=;
        b=jU+78ayuyfxF2BHBIYVQAot5g+xm9bAV8rUi9+vuKpd9Wl4i78xE22Mgnsvdq4qKAi
         bLpn0R5ZwGeE7N/CnqwhHzNkg8klGFdf4ngCLIE0eV1aXWYniNU1zut6n+aoMuHNLAaS
         EKABqA55ptSObDVZzFuma07krxHAz1+1GLvIiGwFd260/f+GtnYZmNhiMxsWPdtAuOin
         G8jFJfc8KbceDzDHBnRkh+vVKiA2CfCTX/jBwn2I7ofE0K/J11crf2kKfkCS5hGS0A7N
         Z9tBRTaWGKrmmSdRZrQdOfWbQSQ/Sa/ik6vLDV+oleECFYagk8JerzfPDc3aaGjahcRW
         Ddfg==
X-Gm-Message-State: AOJu0YwBQIRETBdrjNubc6NSQDs65ypgXu+fc2ziSE8x+zwW/VYTtgUU
	aNkBrnsbyD3owH4nRHiiCujZFDfNKzxcUrqtADHxcCv0nZxwjCrXl/WCGnLN+EA=
X-Gm-Gg: ASbGncuO6EiA5+A56OVUxgLRj/HQFOvSb0qYAMj+FJJ1coNDsm5rmsLIkMIhRlfmvqS
	9yui6nP52dSBVnxR/PC/sd6v0a11Xa4aDc+ebtZ0O4bOFjk6Q6zSlfmVGpzgLejhGMzr0xmd1z0
	LJfBy9PsPKEasT/U1dyEW5DUOg4zPDUfqVuKWrkIlD8/r1iTtKrUvuNX6QRBPdchFPBlyegLeLG
	CzM/0MpXa8Ud/NqRSMAN9518Jzs8uFa5u9pWIhB5ROZaI7PKgR5zCHTckwwQ/a1
X-Google-Smtp-Source: AGHT+IGTVI9kKHu5wo1mjFBaySP65vDXi9HtTwaKXDh7R9Q5bDou23Y4HuhQu3StGXwcLT8+7DZH1g==
X-Received: by 2002:a05:6402:354c:b0:5d3:cdb3:a66 with SMTP id 4fb4d7f45d1cf-5d8025cfcf6mr1713961a12.18.1734592124409;
        Wed, 18 Dec 2024 23:08:44 -0800 (PST)
Received: from localhost (109-81-88-1.rct.o2.cz. [109.81.88.1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80675a49fsm339750a12.15.2024.12.18.23.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 23:08:43 -0800 (PST)
Date: Thu, 19 Dec 2024 08:08:42 +0100
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
Message-ID: <Z2PGetahl-7EcoIi@tiehlicka>
References: <20241218030720.1602449-1-alexei.starovoitov@gmail.com>
 <20241218030720.1602449-5-alexei.starovoitov@gmail.com>
 <Z2Ky2idzyPn08JE-@tiehlicka>
 <CAADnVQKv_J-8CdSZsJh3uMz2XFh_g+fHZVGCmq6KTaAkupqi5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKv_J-8CdSZsJh3uMz2XFh_g+fHZVGCmq6KTaAkupqi5w@mail.gmail.com>

On Wed 18-12-24 17:53:50, Alexei Starovoitov wrote:
> On Wed, Dec 18, 2024 at 3:32 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Tue 17-12-24 19:07:17, alexei.starovoitov@gmail.com wrote:
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > Teach memcg to operate under trylock conditions when
> > > spinning locks cannot be used.
> >
> > Can we make this trylock unconditional? I hope I am not really missing
> > anything important but if the local_lock is just IRQ disabling on !RT.
> > For RT this is more involved but does it make sense to spin/sleep on the
> > cache if we can go ahead and charge directly to counters? I mean doesn't
> > this defeat the purpose of the cache in the first place?
> 
> memcg folks please correct me.
> My understanding is that memcg_stock is a batching mechanism.

Yes, it is an optimization to avoid charging the page_counter directly
which involves atomic operations and that scales with the depth of the
hierarchy. So yes, it is a batching mechanism to optimize a common case
where the same memcg charges on the same cpu several allocations which
is a common case.

> Not really a cache. If we keep charging the counters directly
> the performance will suffer due to atomic operations and hierarchy walk.
> Hence I had to make sure consume_stock() is functioning as designed
> and fallback when unlucky.
> In !RT case the unlucky part can only happen in_nmi which should be
> very rare.

Right

> In RT the unlucky part is in_hardirq or in_nmi, since spin_trylock
> doesn't really work in those conditions as Steven explained.

Right

All that being said, the message I wanted to get through is that atomic
(NOWAIT) charges could be trully reentrant if the stock local lock uses
trylock. We do not need a dedicated gfp flag for that now.
-- 
Michal Hocko
SUSE Labs

