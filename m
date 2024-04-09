Return-Path: <bpf+bounces-26289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2CA89D9F4
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 15:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C83111F22D47
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 13:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AAA12F36B;
	Tue,  9 Apr 2024 13:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VEIiwGvH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175DC7F47E
	for <bpf@vger.kernel.org>; Tue,  9 Apr 2024 13:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712668597; cv=none; b=OgWVAj2/rTn4Wp3ksbJ8Ct+zJuukmtY30nJVtdPnHqh65pRLkB5Y6EQIZuWUqWBFXCXX+aT7FypBEZVu+7bmyZR9dmcsGaDdJXDVQ36IGG16CbRQGHNkpZ4g31vdnUbO67ltbz4FsklSi+ZtTJ8OJtfNluF+4OL/7OrkzNy30vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712668597; c=relaxed/simple;
	bh=phJMhIBVDBaqGVfRsivP2R4+eY5Tic9quqiYD1cmeAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SeBKIlrq4gBWjYBw66bXlWrQGiZovB22jOfwx3rCyS3iNVh13IJwu0u2uX4Eyt3E8VUQyyU84k5KIcH8x4DVQWGtCY3F6tnjSmN5Wocsk+q8cUVIeppNNclWZia57xXka+0sVe2VdNXjJ96MO/ptupmldpmT2PCsc7Y1fpWj178=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VEIiwGvH; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d895138ce6so26910091fa.0
        for <bpf@vger.kernel.org>; Tue, 09 Apr 2024 06:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712668593; x=1713273393; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=89DtCtFIzkBOcJ+3ntnvcyi+RWzHywHNe0Lj3QwBK9k=;
        b=VEIiwGvHUVoimdcz4mUhrpHCZjB3uarOoHxPo6+OFnaJnVovmUwxG8PfYLIdG01sNM
         rbkMnfabSDLiR1FA+0qU93HVEKUwmo+MpUKNq27ZFYNw6o/qjkxMR6siJbQykKxSiEMr
         2k3sHQAE1m0g+pKSfW5FdWM7SiNJfZdCvoeDNJR4ZrmEBCqaMv3Re/FfZNrPJ9++N/IP
         JK4YnyON2da1nOmqI6eYpPyF/sDn+5NsT3N1sJE+7Rl17K+BeOzKM7PaM2HNRCF4lfeb
         +NpRb/aQVzt2J7q8eC1eRBY4pUmXMpSI6BN70k3eRzSj8BjvzvYB1YqDNLpCnURJUbyp
         wx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712668593; x=1713273393;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=89DtCtFIzkBOcJ+3ntnvcyi+RWzHywHNe0Lj3QwBK9k=;
        b=VJHpbPbaBYoyPi9h4Kws+wXmst+SvEfni2+ieQ7cZzVIrO6WViWX2hxg1Awb4H4Le/
         bghnxDXuaU8dq2bf/KHtTu+qRipqZ2MmIZGf0fsS6pNVCEfXvPPZCV845vrZHsxxMuhQ
         DhlOhxTYWZIc11toATStNAHkyqJRY9l02fUQXjrxs5Ka+qGEzWD41pr2Xmyl1Aw8Wrpm
         uS94x9AQQiPHdMNcDKtFu6GXneYo5lNFCtWAx4m4z7nF4pskxS1WcUi56xYJkNadFxGm
         g6GMCAuhdLybAveF/ph3XMSWvoqyCykXuVvd9FMVy7nENQGcLEBS8NuDvIxGdgdGaYKm
         YbkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSKZ5y4rAYOId82Ls8+1AGxgv1Rw9Lh84flE1aQwVTtCPRRfykV3RxA3Ajlbh49Gsa+qdIiA6kwNoI8p1tRcUpUU4o
X-Gm-Message-State: AOJu0Yz8WFJyphpI09V2Odsp9GWOuv3YZ6wtWe6cN+YZUn9lLI4kOrEe
	6jngYifNlI9SYb/lzMOpgXxE54imxC+9/D3QDeNCxXlXUTvxus/k+Mxdg5J1b2o=
X-Google-Smtp-Source: AGHT+IGulCp4NlG8KcyE9McFUHzx4Q3D8Qsy7LPmUzRrPbECg/4e0lX3+xLH3VjehoL+x/qj1UHHkw==
X-Received: by 2002:a2e:b0fc:0:b0:2d8:87e2:3a4a with SMTP id h28-20020a2eb0fc000000b002d887e23a4amr4120399ljl.27.1712668593203;
        Tue, 09 Apr 2024 06:16:33 -0700 (PDT)
Received: from u94a (2001-b011-fa04-1643-b2dc-efff-fee8-7e7a.dynamic-ip6.hinet.net. [2001:b011:fa04:1643:b2dc:efff:fee8:7e7a])
        by smtp.gmail.com with ESMTPSA id z14-20020aa7990e000000b006e664031f10sm8204339pff.51.2024.04.09.06.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 06:16:32 -0700 (PDT)
Date: Tue, 9 Apr 2024 21:16:23 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Edward Cree <ecree@amd.com>
Cc: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, 
	ast@kernel.org, harishankar.vishwanathan@rutgers.edu, paul@isovalent.com, 
	Matan Shachnai <m.shachnai@rutgers.edu>, Srinivas Narayana <srinivas.narayana@rutgers.edu>, 
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Edward Cree <ecree.xilinx@gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpf: Fix latent unsoundness in and/or/xor
 value tracking
Message-ID: <hjovxjcwishjy6mwqxz42ek5qhs626udfmmnnasmbj3mlb7mlr@fjbedhdsetjc>
References: <20240402212039.51815-1-harishankar.vishwanathan@gmail.com>
 <77f5c5ed-881e-c9a8-cfdb-200c322fb55d@amd.com>
 <CAM=Ch04xd5u75UFeQwVrzP7=A5KPAw3x7_drqQHK3C-43T4T2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM=Ch04xd5u75UFeQwVrzP7=A5KPAw3x7_drqQHK3C-43T4T2w@mail.gmail.com>

On Wed, Apr 03, 2024 at 10:40:23PM -0400, Harishankar Vishwanathan wrote:
> On Wed, Apr 3, 2024 at 9:25 AM Edward Cree <ecree@amd.com> wrote:
> > On 4/2/24 22:20, Harishankar Vishwanathan wrote:
> > > Previous works [1, 2] have discovered and reported this issue. Our tool
> > > Agni [2, 3] consideres it a false positive. This is because, during the
> > > verification of the abstract operator scalar_min_max_and(), Agni restricts
> > > its inputs to those passing through reg_bounds_sync(). This mimics
> > > real-world verifier behavior, as reg_bounds_sync() is invariably executed
> > > at the tail of every abstract operator. Therefore, such behavior is
> > > unlikely in an actual verifier execution.
> > >
> > > However, it is still unsound for an abstract operator to set signed bounds
> > > such that smin_value > smax_value. This patch fixes it, making the abstract
> > > operator sound for all (well-formed) inputs.
> >
> > Just to check I'm understanding correctly: you're saying that the existing
> >  code has an undocumented precondition, that's currently maintained by the
> >  callers, and your patch removes the precondition in case a future patch
> >  (or cosmic rays?) makes a call without satisfying it?
> > Or is it in principle possible (just "unlikely") for a program to induce
> >  the current verifier to call scalar_min_max_foo() on a register that
> >  hasn't been through reg_bounds_sync()?
> > If the former, I think Fixes: is inappropriate here as there is no need to
> >  backport this change to stable kernels, although I agree the change is
> >  worth making in -next.
> 
> You are kind of right on both counts.
> 
> The existing code contains an undocumented precondition. When violated,
> scalar_min_max_and() can produce unsound s64 bounds (where smin > smax).
> Certain well-formed register state inputs can violate this precondition,
> resulting in eventual unsoundness. However, register states that have
> passed through reg_bounds_sync() -- or those that are completely known or
> completely unknown -- satisfy the precondition, preventing unsoundness.
> 
> Since we haven’t examined all possible paths through the verifier, and we
> cannot guarantee that every instruction preceding a BPF_AND in an eBPF
> program will maintain the precondition, we cannot definitively say that
> register state inputs to scalar_min_max_and() will always meet the
> precondition. There is a potential for an invocation of
> scalar_min_max_and() on a register state that hasn’t undergone
> reg_bounds_sync(). The patch indeed removes the precondition.
> 
> Given the above, please advise if we should backport this patch to older
> kernels (and whether I should use the fixes tag).

I suggested the fixes tag to Harishankar in the v1 patchset, admittedly
without a thorough understanding at the same level of above.

However, given smin_value > smax_value is something we check in
reg_bounds_sanity_check(), I would still vote to have the patch
backported to stable (with "Cc: stable@vger.kernel.org"?) even if the
fixes tag is dropped. The overall change should be rather well contained
and isolated for relatively ease of backport; and probably save some
head scratching over the difference of behavior between mainline and
stable.

> [...]

