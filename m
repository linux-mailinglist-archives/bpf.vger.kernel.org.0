Return-Path: <bpf+bounces-56042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0E7A905B3
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 16:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE2243AA290
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 14:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5347921ABA5;
	Wed, 16 Apr 2025 13:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i7I1TT60"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0BD219A71
	for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 13:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744811924; cv=none; b=LGWF12u9/VRLDWlhMX9BCrdnzjRj/hUrHm7xZFIJQEbIsSZhX5zCCjFn46A+cM/9a5B7JwCh+Cb+gpO1EhcSo27YBgJQ5GIm4ECOVyMR6wlKPZaNvCsINmsFzSvK1LPvMwu+HbQEfxXEicYRqohwGLeEkM1HDJauq1OENCXcv7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744811924; c=relaxed/simple;
	bh=8EM9BruECeiQqpmSu5JthfQXoLeNBFmHqAhot8Jq1Xs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pxn6CjmO901KaBxtMmbuVgsTwwuYSXMQ/DQ0GyZvCMmiyNeZXIRT/tlRrTSqoA4W0TBia1o34uYUtYD8O2A/AUtYkCDdGPQv33x1yZD44ySHwJtEW9KpEU8w1JbMG+A6JnpvEBulG12fRn9gb8PRexEijBBFFvMMNzjXxcLgr2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i7I1TT60; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744811922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1N10mZ+kpKiQYbX+sNKEw8ESo27Q4EehsQAThfgN6Kc=;
	b=i7I1TT60u/j+ecRPO+GEwOrlm1ulkxFGUSuIOiUU0nhOWkbp+6vF5HjgZzR9CCh986ETiI
	9uUpROoQyUXf1QB8CY7oLt7Qu87uDPh1D6NVe2nN//iPAsi89dcupyd2U9T0zmzHcftYYM
	aEaodRsCGJDoZ1nyB9jTWgYFJHH+gn0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-ajhelcOiMsaBfXBF0LJbtw-1; Wed, 16 Apr 2025 09:58:27 -0400
X-MC-Unique: ajhelcOiMsaBfXBF0LJbtw-1
X-Mimecast-MFC-AGG-ID: ajhelcOiMsaBfXBF0LJbtw_1744811906
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac31adc55e4so546467666b.3
        for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 06:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744811906; x=1745416706;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1N10mZ+kpKiQYbX+sNKEw8ESo27Q4EehsQAThfgN6Kc=;
        b=QHzbCvo3Cuyof1yf9NSgSb4iDn9V8QYH7N8HSPhLRfzAMjEcJlA/GkhG2rVYp12OP4
         HDvw8X7bNzfimLy3B5jc5BuQiKUfYc3dTllh15cl59Hsyr6/Y6Ncrg83wDjgm6f6HD7l
         7IQxW8A8jbwVzKW8mK6uTxE9NBnpm15ssaHFFL1Iqj/5KYl6KOLke7dOixfVfwUhKh2t
         8WWd+aN1mEOnKOUhh3csoYm7NOVu/0IslhcCiQOwB97iIaHnihJTQ+4W602s7e20zaBp
         K0VgW9aeSn+Ih0jBWGVTAzm6OuzAvsdCg31kOrFWcqGwJL54XmgB3pYTxZuzJkj3/sf4
         kzoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP6g2D0EVyr2aDHGOmq7drFbA9BN2HOMAzSmV2TWeLHuEIx67u+oWoupF3TqMMazGfL5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0MMhVGGjqSx+bD71VuMZe82PBK09YFnntOTUf1k4BxJFuO5xk
	qz/PTACOtmvx8MZvI930qi6J9ne3qaziWI2wkSidArjXaJ2yAuXnwHYxFqLIpZMKzKs5qLMGw14
	e8RegYgwM2St2mbXvTOTLC0xW+RT1uzEuxequm+IZd+bi8AwqrQ==
X-Gm-Gg: ASbGncsBJk782g/PJRXaiWhmV1ZsU9zDGrVdvHCzaBaTY2j2C2yqGduPyo8GU8z8scv
	aG7xbwWQ8200IeGXGb9kSXsa3FfNtSePipMlp87dwyIHFBgKiN+Ca1hD6uUF+8QjsK0wQa9CnOC
	h4jRlWTmDdOsrCaG440mkJylM9PP6D2GXLZ4Di/urF/fZ60ZpJ1XTVriuMez52dXiw4rnduyw3s
	X1xd001WOXHH5d5XPwU8z/oHtyt/5LdHIgw5u5pNvbFpcXF9AGFVTaB8Sl1XeUCnpztpapCJyrg
	dV34Y6iSFIRYRGWS9u79YB6lJGvc7mUNZTwJ
X-Received: by 2002:a17:907:9494:b0:acb:349d:f909 with SMTP id a640c23a62f3a-acb42a50028mr161010866b.31.1744811906200;
        Wed, 16 Apr 2025 06:58:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzy9DzmjmdBXDssMZ4LwJxwTRh/bRvt8RWJJn9qTge4GJkEWLxrIw1aLgJPYwpUtVRtYJYQA==
X-Received: by 2002:a17:907:9494:b0:acb:349d:f909 with SMTP id a640c23a62f3a-acb42a50028mr161009266b.31.1744811905828;
        Wed, 16 Apr 2025 06:58:25 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb3d128583sm136615866b.98.2025.04.16.06.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 06:58:25 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 31E07199293F; Wed, 16 Apr 2025 15:58:24 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, tom@herbertland.com, Eric
 Dumazet <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, dsahern@kernel.org,
 makita.toshiaki@lab.ntt.co.jp, kernel-team@cloudflare.com, phil@nwl.cc
Subject: Re: [PATCH net-next V4 2/2] veth: apply qdisc backpressure on full
 ptr_ring to reduce TX drops
In-Reply-To: <20250416063813.75fb83dc@kernel.org>
References: <174472463778.274639.12670590457453196991.stgit@firesoul>
 <174472470529.274639.17026526070544068280.stgit@firesoul>
 <20250416063813.75fb83dc@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 16 Apr 2025 15:58:24 +0200
Message-ID: <87r01si4xr.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 15 Apr 2025 15:45:05 +0200 Jesper Dangaard Brouer wrote:
>> In production, we're seeing TX drops on veth devices when the ptr_ring
>> fills up. This can occur when NAPI mode is enabled, though it's
>> relatively rare. However, with threaded NAPI - which we use in
>> production - the drops become significantly more frequent.
>
> It splats:
>
> [ 5319.025772][ C1] dump_stack_lvl (lib/dump_stack.c:123) 
> [ 5319.025786][ C1] lockdep_rcu_suspicious (kernel/locking/lockdep.c:6866) 
> [ 5319.025797][ C1] veth_xdp_rcv (drivers/net/veth.c:907 (discriminator 9)) 
> [ 5319.025850][ C1] veth_poll (drivers/net/veth.c:977)

I believe the way to silence this one is to use:

rcu_dereference_check(priv->peer, rcu_read_lock_bh_held());

instead of just rcu_dereference()

-Toke


