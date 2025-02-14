Return-Path: <bpf+bounces-51616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77072A36791
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 22:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A907F3A9594
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 21:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DA61DACA1;
	Fri, 14 Feb 2025 21:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5OL14Tt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682531B6CE3;
	Fri, 14 Feb 2025 21:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739568654; cv=none; b=WZNoXJWUhIzyyao1XWGYEJ1TB2HRFALEBCfsyGHUVTIV2xDdc9mpaDRqtxS/l7IwRaPVh7sk9S/M5aO14CY5E1ZPL6lSJwJRXM17260ltcJWh9pfdik1d0taTgkgYZATVpTOK7uKsQpy85VT66CWN/bEMpAGYJw1SiWNjA9dQns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739568654; c=relaxed/simple;
	bh=WChCpgQjp/T0HhntDtQpfdSju1c4Ml/WpSWTjIbp50g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZY5vXj/jiiXYRvzFuKhUaATxZtW2v00KsIYZmlSPwPldu2vuCqt7x0Ui56suLGzt71N2WRwLMYg7upkcqnuatuWeOZKIwYyY4VsejmU74Q1Ktwz389hhoDD+weff1PJur0rfxJJr/uhn/lDXcDlEQP0SJdD55dD0d3GLr2st/eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5OL14Tt; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6fb0200b193so24207227b3.0;
        Fri, 14 Feb 2025 13:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739568652; x=1740173452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OdZFz2Kwwn+jgSjv9PpBRJMHd4hwibzisgcULNMcQ5c=;
        b=K5OL14Ttn/Pjb6YVy4n8yHiFD7N2Ka1aZtQcdXYKFdsognqPGf9mwGnsQyS4GRgLsU
         Flp56wR/VP9nvFNXse3NNmF214Wj+Sfryn3BJAk3wF2LxwFSFq0e7KWITvVohWtawxAB
         M0Myi4rvUj6cZxbq92U+1ec4BVK42NprdxtHnYrr1QDMGorBEAQwSUEHG8foQwO+WJ89
         q/jy2/pPzVehVo7Z7O8tkL4pE9DiIXGobDgN8c416ZAxouG5DwoLGgvxIdsQaLE/nfr/
         JRyCUuy0soPM9AYxBFFkLcU8TTqC9l2YbHsWuTXYwgE9S5mBDEp+ROxWmHrZ1Dp3uJbT
         EaaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739568652; x=1740173452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdZFz2Kwwn+jgSjv9PpBRJMHd4hwibzisgcULNMcQ5c=;
        b=LKzIZ/QoMYvM1GjZSl9FPB4qCF6SpdNEAY5vyljvPGvY7z/flWKx13V5iXCSJ3IrOm
         L2ql5vxLEyhb3IquZUapi1AVQDy9dyZ6C0TbzEo7kgZc99+Fq5ZtpG6r/XpbjqgJetW+
         bou7N21/JfCMWf5ZN67VrohqHYI9b3leAT7x1L6xYYr/Q+YkTUK8vi9KEPjOElsvkq1E
         tSbpTtic1UUs9QG3noc1wGj/ZwJWoTgWmTZ0RsrX9NxQlcKdhAa1Iw6baBNQRUMf4rA+
         D1QpDyr1P0SriBtvyXbcvqVmhccHzxn/0dnJOb6VU+B5YK4kAsMjXGCFlS7QNLKmekwA
         JS4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUKmQtcf5SvH7RVb+7ZcYTEHrUmWTUAETIdWhFFfj44R1IyqL1VEYBScTa2AjMFPJBpULc=@vger.kernel.org, AJvYcCV2zDeyuNJhslvEWY94iTPMy/PxSdWxXhxx42q0zIvMqaAGIyCDAnz7k2p80jzkjv/g6raVuajW1QFoVrTz@vger.kernel.org
X-Gm-Message-State: AOJu0YxowjkjhfJsBbFI9GskOq59UyACU6saBrfBHyFeVT+ztt1K7UZz
	Ugz6xiGFAvuWZ8MQUnOCkhX15kjKIbVeGJ5+2XW6xhW7mFrMz16Z
X-Gm-Gg: ASbGncuh6Op7WVhbv7fXG7TdvlVsbyqnz01iytVTcu6KXy4rNtAwxyB38D4kCCdTOnr
	VsIv0bxyqFRBu9pdvrWHrwTJY1Iv5n5fF0b3Fc/AwZ6fNrERw7p4XztzPsyE7u3bNU7TQgIQIDS
	OrLGIBmQnF+TkHteIvpkV4hE274qP+Qa9MvpqUFpOZIEX9mFl0zoijlKKstjiEb/0X0NU9sgXVh
	WVT4HTGoGvyHDc/mt8X87PrttqVsg6nVe894c3XTaCO3EXjcjNkdAuHMtntWR62b7eK3ZfuFlXU
	b1S6W9vXCTGkcKtIgUI8xRGlGTamrTvzALiQ951yeLIWZ/s4VJ4=
X-Google-Smtp-Source: AGHT+IE4YL9Wa3jcMWsFiYrpqCc8+qqMF+tp72GGXNZri3AvAcFqJrHOoaboRfK6F/23fET4+/Ssrw==
X-Received: by 2002:a05:690c:63c7:b0:6f7:598d:34c2 with SMTP id 00721157ae682-6fb5836638fmr11580777b3.24.1739568652171;
        Fri, 14 Feb 2025 13:30:52 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fb361bcac7sm9226497b3.103.2025.02.14.13.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 13:30:51 -0800 (PST)
Date: Fri, 14 Feb 2025 16:30:50 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: Andrea Righi <arighi@nvidia.com>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joel@joelfernandes.org>, Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] sched/topology: Introduce for_each_node_numadist()
 iterator
Message-ID: <Z6-2ClIa30DpI5X1@thinkpad>
References: <20250214194134.658939-1-arighi@nvidia.com>
 <20250214194134.658939-5-arighi@nvidia.com>
 <Z6-yxTEbuJZUZW8f@thinkpad>
 <Z6-1nzIPYlFV60dB@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6-1nzIPYlFV60dB@slm.duckdns.org>

On Fri, Feb 14, 2025 at 11:29:03AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Fri, Feb 14, 2025 at 04:16:53PM -0500, Yury Norov wrote:
> > > Suggested-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
> > > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > 
> > Acked-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
> 
> Yury, how do you want to route the topology updates? Do they usually go
> through tip?

Can you take it with the rest of the series? I can move it with my
branch if you prefer.

