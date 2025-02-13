Return-Path: <bpf+bounces-51368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 116E4A337BC
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 07:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FF681887BA0
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 06:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B673A20765F;
	Thu, 13 Feb 2025 06:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ea7p+gwC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADE24A01;
	Thu, 13 Feb 2025 06:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739427127; cv=none; b=kVQ9JXGsYHiaXiH3oTG+ibth7lVpawQT3A/N9YAfw4/mwuRvVFi1dqS+jpI1uFYic4LfQ69l8tu+HnkXGI/s6vIZNoK0gBRwOSHuo653QqcFA4DTEcTjOsc+NgokU85dmE+fMe632/cTFFbYqc7ozjcNkR1vhc069JD8S/MuQ0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739427127; c=relaxed/simple;
	bh=B3TsXGEgiYxwgveuXwE3SOg7k5pvyULhsB1fYCdYYto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XchXsCt4IK9xReo6KnGYha7H5xRRvK0MuGFZ3VbjYpuxii8XS25fmOOWky4l5No5NSgIToqcG61Q5SHzwxHtUNv0BUGYOAcl70qHh0PAFlsQwCCEToWuEqJT8suRb1QhAYtWCQnOVis+SFNEVWvu4dI1GJfMi1yPyalybr9OXYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ea7p+gwC; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5deb0d6787cso649462a12.0;
        Wed, 12 Feb 2025 22:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739427124; x=1740031924; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ezVasPHsv6V2uw24MQZZeCDA47yUS9BZKb8CbZfcyRM=;
        b=Ea7p+gwCZlm97IKVJrFBI9tziuqrCUwVF/oO4nyHU+CNobHT1lPTQ/NWW+CRKZF3wx
         L9zIgxTNhreu2pY3pIfdBjj+yzZdrSAA27jgb98eP+ssdTsMKMpzE/gM3KXhpvabIwl0
         r1bOq9NZJ6zRsrbJWWyl6EIOIzoW2u1D0N/NTI7M+5XLAeKo2+OqA4ydYUasJeYRWk9L
         ASwsfITqM6F7Xy7QRM9OPjtz3UDpFlLjswxv3K5h2YZKmPaaczHPlD+ugpmoFtPYsFfj
         kLaHBIIbP1fTWgFo4oiV0KaqHoy88RSKlhhDkKHIoQrvn5gZVr8UAaCUZq91DBl4UOWi
         ADdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739427124; x=1740031924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ezVasPHsv6V2uw24MQZZeCDA47yUS9BZKb8CbZfcyRM=;
        b=TJBWzeXLYpPB5SNZ+OtwcjT23CrvXtTtg+2Vn8PX9B6m/ng/i8udaQWLNTjHTcAMhn
         lNLLsYsGRjf6M52jTF+5meLgWw3Wfstfe1hNh9HFerCtshlyuXnkR/YnQKGcFFfOMl8y
         QneUp3MMrtJ8r4+/WDQaVoFGg476yTiWUnaZutCyBPg546eSKftaRgwCnAY/F7Wg03NB
         WCLBOqnNPJa3J3cjJi/wrQzuui1SHhmqMxhJ6TOyh/uBnS0Sv6nIZVM7dOsgVIsS4K76
         JgdvcMtgjJrVNpr7NbDta3R0P9b54V8/RYielcrAOnV+K+Pz9pWYZrSxcVdOHJrRkJsC
         WaUw==
X-Forwarded-Encrypted: i=1; AJvYcCVELq4OSFGfLXA9CJxQBIHNXd03ZIj54v3atuDe1U1Cqcg+QOP76FJ123NopdyVQnvMEliKsZOkMtfhGfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg8m5Wjp230D8z9ndVJKi6PcVM4rIYvvNOR3/5dX7cgGKqW+Rh
	FW1UT2bOqC5PvNRCBz6Lfbsc1BNm0Sw9Ls5jBuu5r+nPBxeJP8vC/PDAzFwB/AnGDJe/IRc/dhc
	D6uZoOLuTKMKAqZNDG3eQ/S9U3ho=
X-Gm-Gg: ASbGncsd2sDVGY8pvuKNVULpq17hElfagaQ3ypInZDh2UYquWuFb7VoBunfj/QkHLjW
	9a/rnnzr+qoqwkmtnjaBbhCWEdjQh221bHoTkUO0qIR3l/bhllnOyv+exiwQOR3wzyPkeImz53Q
	==
X-Google-Smtp-Source: AGHT+IG2eCeOPgCOnfGgxoLTFoRqudRFD0yDNYDBsizZdYJdOGMvWhiMMp4wcf8x7uF7eCoVLmRRUIu9w8hyfikuXvA=
X-Received: by 2002:a05:6402:4615:b0:5dc:c9ce:b029 with SMTP id
 4fb4d7f45d1cf-5deadd843c1mr4927202a12.5.1739427123579; Wed, 12 Feb 2025
 22:12:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206105435.2159977-1-memxor@gmail.com> <20250206105435.2159977-12-memxor@gmail.com>
 <20250210102139.GJ10324@noisy.programming.kicks-ass.net>
In-Reply-To: <20250210102139.GJ10324@noisy.programming.kicks-ass.net>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 13 Feb 2025 07:11:27 +0100
X-Gm-Features: AWEUYZluH8U6jOgJVL2P2i7WHZujKsTDPdGeLz2NLA-8PMOJxjeSQqy9UVO92K4
Message-ID: <CAP01T75Z0GjUPiKWCPU7isSMvA+1uMtYE2Nm-iQnvpjFxk0OUQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 11/26] rqspinlock: Add deadlock detection and recovery
To: Peter Zijlstra <peterz@infradead.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, 
	Waiman Long <llong@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>, Dohyun Kim <dohyunkim@google.com>, 
	linux-arm-kernel@lists.infradead.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Feb 2025 at 11:21, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Feb 06, 2025 at 02:54:19AM -0800, Kumar Kartikeya Dwivedi wrote:
> > +#define RES_NR_HELD 32
> > +
> > +struct rqspinlock_held {
> > +     int cnt;
> > +     void *locks[RES_NR_HELD];
> > +};
>
> That cnt field makes the whole thing overflow a cacheline boundary.
> Making it 31 makes it fit again.

Makes sense, I can make RES_NR_HELD 31, it doesn't matter too much.
That's one less cacheline to pull into the local CPU during remote CPU reads.

