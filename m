Return-Path: <bpf+bounces-60025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D031AD17B2
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 06:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57A7B1675D6
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 04:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4657526F463;
	Mon,  9 Jun 2025 04:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlOonVhV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746293A1DB;
	Mon,  9 Jun 2025 04:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749442844; cv=none; b=eVy14TFPvbtj6w6vzm8kaZOcMHdn6WEpse/9YUpakWWusLZkNV61jcZDuDEIbhNziBrvbE4WtBVXJ16wFTpRxT7w+BPrCdzw+fB//JbdLc9tEes0rULbeNwQFsy4FYtOp68N4EyC5po+9JgLWMoQkyarzZluB55HljTIipjJLPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749442844; c=relaxed/simple;
	bh=U0lQ7XugEXKGGzfczw8VnB1sNM8SX9qezu7R5K9s8Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfWRLI+W5owohihQT1Q2i8YHJAEn8iC/e+GaVu8FZl7feSuSq56qB9Wb1zOUhOB7UNVwAM0ZgQX56NWGQGB0HJ/Y5/ovxXjqUm0UX64bpGvMHcjOHH0HdxKg9cFRGSSC0F2FVgRRWksni6bDD6dNqKg3OBvPlk88n7kym29w7cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlOonVhV; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-747e41d5469so4319474b3a.3;
        Sun, 08 Jun 2025 21:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749442843; x=1750047643; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V4URcKEOTtG7gkDcQ+As7WhEjMnb7PTh9qAPDmOqKGs=;
        b=FlOonVhVY/u8D2jrD1jAnzagfVynPBkBTyfLuMlCqiFnXK43goaLqIG8tjq7LYf86f
         pxNyeKpnszOdYlUuuWWfVNcLlhsVGj2jAUDAlT6AB8tlISnBXPldbJLMZHO5LUArxH8u
         lHhWaQmJ775CSqgcHqc0TT8EB1SVA5/xa6h4ZOpsmP9jCaFjkahS8e3bo0amphMKjPyV
         Cgzu2oCpSgZP4d8QuttRz/WZ/TLyifxn6JSLwZ9GgE0xii1H2MnDqmdLQJQYefwtmNn/
         Ur2dIE6Qs2ppq3xPK5BcJjQHHWPkfxhuJh/9B6TRZbQSq0koSy8A7G2aWDLKsLDNW10u
         vn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749442843; x=1750047643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4URcKEOTtG7gkDcQ+As7WhEjMnb7PTh9qAPDmOqKGs=;
        b=aEvJi5c8FOyBumf7nH2syoa+onYZZ7IF+nEejR9q/jRr52S/oNP2ME0g5U0WoPAmFm
         cX423xw9G+m0rJYy67McBWp7DRR3pirUFVplQ3L1m159ZulRdLhidOEqAVcWVam3bd3M
         cPUUqoSEmmFtmC/x9OjdpWH4QHhkECwIGB9+ndaR25CQmNsfWMK9nSUTZJibKVeAQgWT
         4MMMlUy88dxN2LlqmrIQyY9WYbVaeOlhuZGB744YQ3iOrJmUnbumYLWfgSmVgVdgd40f
         M9/EaNseeoKIoUbpYyJ+JRYa6bshplhxGzyAew/UXH6glknD/nuAYZQJIYj/Zw37LZ/D
         zd6A==
X-Forwarded-Encrypted: i=1; AJvYcCU/vIIVTAjnYtd6f6xAPZ6xtaNAqtmdLMn2/NUBaczcNtIcDr3PsA5LpjAuACSOhu8cj7D4T6VP@vger.kernel.org, AJvYcCXtLXO9X0SiCNBsAmUTJwI7QTEBSThxkhGQconjvrePYGiNkpaJQDboy4aqA94pO8Ge7kw3+e8JTKeCF1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJtbXpcMIF9mMTTNg4vIMXJ7DBBD2BHad4C9J2Z+qcMDF6Xinz
	fdyeS38WSG6+REyQm0IRJZqTho5ZnZC5tSDnthPe0czkG0JGY3964cjwCy9z3w==
X-Gm-Gg: ASbGncuCesICUCz7eLIgS3X5+y+cm3iFgy/Tlj4fA2vCVkdjI+ijhu/K6xHzkN2DpGo
	kA9/0t61bxbzhpYxYC9crww/4WV/9GQXWhMlREbWGIF1rUCoK0BqadEyEKLMm6xTUCfJaVnWB64
	Dws1XhkOS7xZX80bzwyE/cwvOkGkUB4++G+k0BTwDZhwjwfOwU/En47KZd7KE3WF9oQ/AR2zkSB
	kfFGgYJZgx8MpAvCDQ0yK72Wvum3poh46eFHMvnuPyWicKJcp61IxD6o5fVt6C+olwmh80bHk0G
	MLED2YOHdMtpMNOxcllpj/iwPTQDwaYZe6jCNVjvX1JhQS20NlvK
X-Google-Smtp-Source: AGHT+IGPvy4kykj0lhb+spVXVfcSeM4rDVBSnkPv1sXyzGwUgPowc1odOEOQkiDn15B6rBudrNukHQ==
X-Received: by 2002:a05:6a00:1d89:b0:748:2d1d:f7b7 with SMTP id d2e1a72fcca58-7482d1df920mr14224065b3a.21.1749442842714;
        Sun, 08 Jun 2025 21:20:42 -0700 (PDT)
Received: from gmail.com ([98.97.41.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7483318cc55sm3942180b3a.88.2025.06.08.21.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 21:20:42 -0700 (PDT)
Date: Sun, 8 Jun 2025 21:20:24 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, Jakub Sitnicki <jakub@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] bpf, sockmap: Fix psock incorrectly pointing
 to sk
Message-ID: <20250609042024.ta4fuiogxxklolst@gmail.com>
References: <20250609025908.79331-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609025908.79331-1-jiayuan.chen@linux.dev>

On 2025-06-09 10:59:08, Jiayuan Chen wrote:
> We observed an issue from the latest selftest: sockmap_redir where
> sk_psock(psock->sk) != psock in the backlog. The root cause is the special
> behavior in sockmap_redir - it frequently performs map_update() and
> map_delete() on the same socket. During map_update(), we create a new
> psock and during map_delete(), we eventually free the psock via rcu_work
> in sk_psock_drop(). However, pending workqueues might still exist and not
> be processed yet. If users immediately perform another map_update(), a new
> psock will be allocated for the same sk, resulting in two psocks pointing
> to the same sk.
> 
> When the pending workqueue is later triggered, it uses the old psock to
> access sk for I/O operations, which is incorrect.

[...]

> 
> Note: We cannot call cancel_delayed_work_sync() in map_delete() since this
> might be invoked in BPF context by BPF helper, and the function may sleep.
> 
> Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> 
> ---
> V1->V2: Use existing flag instead of adding new one.
> https://lore.kernel.org/bpf/20250605142448.3llri3w7wbclfxwc@gmail.com/
> 
> Thanks to Michal Luczaj for providing the sockmap_redir test case, which
> indeed covers almost all sockmap forwarding paths.
> ---
>  net/core/skmsg.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

