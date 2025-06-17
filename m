Return-Path: <bpf+bounces-60833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E32BAADDAC7
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 19:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B81F1881CA0
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 17:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963182ECD08;
	Tue, 17 Jun 2025 17:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqGhbHxq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E5F2EBDCE;
	Tue, 17 Jun 2025 17:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750181973; cv=none; b=TeXDPFFnfx6x7x7sr9l6ys8+H3SPI20ARdobzCaOMRT9haQojZpKBmneR48QZfbp8G9jsBWsUzU+EVabHVP07n41xz24sp2+RYDTxQp3ngzeAmVAsWYvOCz2QcIAmvOt8FTFHQbk/GVgcBiajkL2jbGYCINdw99pfIeJcdkAgO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750181973; c=relaxed/simple;
	bh=aovmwJppxQ5EUY9kTY+2eWgz7wb5WTNaM9V3Rsj37Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVEP/SLqTEJoT6VB2UdzGyyv6lEwJ0mSjQnH59u8x4bDz4zHV5UsqQAZP/TEm+SAKhFlqX7cw2LTe4E8d+6wK2BfPAVTKxYqkmZLtvqgFYvHCqs7aiiKNL8A5OBn9+PtvekRQOmGNGTIVaZM3NGz0mPoY70ibnK8nzA1KghvHf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqGhbHxq; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22c33677183so52536905ad.2;
        Tue, 17 Jun 2025 10:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750181971; x=1750786771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PMAgeAYRe30GkmHI52gu54EheRaASSmGH4F4VXsmj8w=;
        b=AqGhbHxqp68z1NYAawsonZYWoNUSqRyxu4G3NQkYSyY6LwmOW7sMBiRQq4WT68sszq
         n0I1AUfQVWrIIfyaCJ1gVGXLD0Y2cn13CVzzl4t/mJ6nI1MdcdivLebu55b8bWDm+zU9
         ntzo7IhTt3xpnLz4y1Xyi5uviXUwhG3dYovQmlXb6ppMG04kbAtRj4hBLJ67LTZfnkr7
         N6gdBkXsOgxnWGptL09b5D0eUOLNwfmnvG2WtawUysLvyRFZVzM4iWIF6nNKP1eQ+dGs
         gLFramX33V/HMG8/xBkAuuNJ0aCwAcQiZBTXlBMLjgLKXapzDy5xkbFHdjPzB3EWTpTB
         g8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750181971; x=1750786771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMAgeAYRe30GkmHI52gu54EheRaASSmGH4F4VXsmj8w=;
        b=DdFhn7bAL2MvYxN006TUR0dpL6J6jnp0u6VbEL5JQEadJnbA4AUtLTo7yiAWXD+9gZ
         VvhRKgWAHQjGKybqiY+Hi0Ap6S+j9yXlhI185VOw5mEnfkMDels4Z72Mjon4jLLHWCfZ
         7Ha7piRL2y7FKDZUD6ti1a+tg6s1evHzIJBPWN1NAHqDldeLylXFPNzoNXS+3m4kRQsR
         gQmmcdo6EogdeJU62g2lCUBhZ+GsvbboKnfqGvnH9wkC9qqd7uGUyrDC063w9t0TPAtP
         Ida0AvvK2YUVhoYxX+xM28v6noMWUiVyffR4YKttiT1aD9eHHvcY8WrV1itVnBpNVwXL
         0q5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXs+d6LCKkw9LdXEeTZntJjnwIDKXQS6Jc5uo7dHsXvP5ECWLHgtfCekc1FFnqjf9jvupHaEh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ3wO5pMTsLd8jd+2DUD9ycoivfl0NqEIG2ma11tKVTzjO8Job
	yNBqEGMVLj9fAq5hvdZ8ApBzo2zkjKtEoB71DVz+hpPdeWV4fg+7TkU=
X-Gm-Gg: ASbGnctfK7yRMDSINeh8EI2QNhkNmGARys65BFAYRS9k0kq11ylFJPmj7IvfZjRRxV+
	iAvRprEe3pCvsqm8yzGNRLZ6JSZTCreU4wk9pRoVxx+NPTGHwAjCYh1X8oj5CrssMDittnTK/Q6
	RrSM/GdJoNAmOrpClc9ziGMBnK8J0vwoXGQ4oYnViCr+fr+eHnbZugmMtDQcBq7pyEf+QGqZtJs
	1wveDZGHTOZhJSdOhe+eTeO3mT0+17gF5A6mmm8p/2Z5EYw08Mf7OG4HjMUBZJ6W+PzDDoYSMmw
	r87gznKy0qlyblG0xlsDCoNmht2Vts3PvVM/Mcj4LuGSESLBERV9si8iEYYzBDiON8H1e5SFWMr
	He2lK/JD3QWgNuYafh5/Z49Q=
X-Google-Smtp-Source: AGHT+IHmdVgiTP4J4fskM7Mr3KC7YdGvAKGrKuP6jhUL142GRbYDEqtL6YLqe3xf79vUXPu05V8Hug==
X-Received: by 2002:a17:903:b88:b0:236:7050:74af with SMTP id d9443c01a7336-23670507940mr187518395ad.9.1750181970871;
        Tue, 17 Jun 2025 10:39:30 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2365deb2cedsm82970745ad.163.2025.06.17.10.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 10:39:30 -0700 (PDT)
Date: Tue, 17 Jun 2025 10:39:29 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, john.fastabend@gmail.com,
	martin.lau@linux.dev, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH bpf-next] bpf: lru: adjust free target to avoid global
 table starvation
Message-ID: <aFGoUWgo09Gfk-Dt@mini-arch>
References: <20250616143846.2154727-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250616143846.2154727-1-willemdebruijn.kernel@gmail.com>

On 06/16, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> BPF_MAP_TYPE_LRU_HASH can recycle most recent elements well before the
> map is full, due to percpu reservations and force shrink before
> neighbor stealing. Once a CPU is unable to borrow from the global map,
> it will once steal one elem from a neighbor and after that each time
> flush this one element to the global list and immediately recycle it.
> 
> Batch value LOCAL_FREE_TARGET (128) will exhaust a 10K element map
> with 79 CPUs. CPU 79 will observe this behavior even while its
> neighbors hold 78 * 127 + 1 * 15 == 9921 free elements (99%).
> 
> CPUs need not be active concurrently. The issue can appear with
> affinity migration, e.g., irqbalance. Each CPU can reserve and then
> hold onto its 128 elements indefinitely.
> 
> Avoid global list exhaustion by limiting aggregate percpu caches to
> half of map size, by adjusting LOCAL_FREE_TARGET based on cpu count.
> This change has no effect on sufficiently large tables.

The code and rationale look good to me! There is also
Documentation/bpf/map_lru_hash_update.dot which mentions
LOCAL_FREE_TARGET, not sure if it's easy to convey these clamping
details in there? Or, instead, maybe expand on it in
Documentation/bpf/map_hash.rst? This <size>/<nrcpu>/2 is a heuristic,
so maybe we can give some guidance on the recommended fill level for
small (size/nrcpu < 128) maps?

