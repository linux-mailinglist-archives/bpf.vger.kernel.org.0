Return-Path: <bpf+bounces-42938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8E69AD33D
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 19:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE3271F21490
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 17:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16301CFED4;
	Wed, 23 Oct 2024 17:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAGGuZ4Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2821C9EAF;
	Wed, 23 Oct 2024 17:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729705672; cv=none; b=nSowSDRms5XJdKSqvpMbCvhDoYZ5c5+E4R6v4jtSer1qmK/DY3RaFCDfYK4nJ1QTgGLSEFZbUdTr8wB3N+griRPdCcDAm6T1zfms7KwiRY2n5mhuOQS4ZAo9G+c/DIqrrgWUvMue2E2ZQnjgSi/tdJ+Fbw8jCe5w1549isvU23k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729705672; c=relaxed/simple;
	bh=0JSR/C0aaUKQyCYLqYnEH9NlNoyVdX7cXoEVoQ7gOi0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Cd4w+3pQ8opM4PZoG3Of8kxhdDbVupY8jUUXAOO5fmjTB6ucL/E9D0N01Bmu5/tEIOOFxu+icuK5298SIFnpu9FvW7ZLYzspclzhD3HzhGEf8Vo3A8pc3ujghZvdmhM7LG2V2xZcHg44vpCcLWK61YhoOZsdoLMtMr4H/bzwo4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAGGuZ4Y; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a0c40849cso1087793566b.3;
        Wed, 23 Oct 2024 10:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729705669; x=1730310469; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VZr1MAZgkbdeNI4DK+93o1V0wyV+u7PfGU/TxQhTQLU=;
        b=QAGGuZ4YyJBalfd7Y75oOhHsbH+bHkDX1JdEgt8mdU+K3YsQzIEzEiH/AutE4ek7fh
         ZUYPOPGCt+pjSaxJu8F3zIUyHYU7pJ55ePLl/sMADAgK3FzANuH77yhmedXN8SfTWR4M
         pWnZ0bZkvfj6ClGPsRPQ+/j+hL5m6XT+Tl8nt4Zl6etrMypcmfWuUunRawKzXs2xvpnL
         6NUoFsKdGF9rNAitHD8GIFAApshv6xb1dNw7wszYjVhe48ZKiC0TsJElOlIBFdNwHvPp
         aQUIeo9SXWii9KeepqfaDnid4XA5DlLG6CngYH4c5CFRL+NxMQT8wImm+XJCDfd3URWR
         KIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729705669; x=1730310469;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VZr1MAZgkbdeNI4DK+93o1V0wyV+u7PfGU/TxQhTQLU=;
        b=WHUcx207XLDWKsvIK9ejd9+/jCUT8udxrPhIoqeFLY2nHoOGnGgryf+l6YOMpXiR1V
         rfr9NB7yPmoHbVXzILD4luy9vBX9qlDd2BalWorEbkwCJijOxH+wBukSxUoevT/tKk2c
         cxIH2ajr+7gGkP32KpHfUVDwkIlob0NQ5MHIAnBbpbZziZqHfx9LCo/v5/FlyxEuklsn
         C8O8eOvlwUWMu5MZFNblwhaudGvklMyJV/BZ0fTMjWHzdOfvDHCgDFzD/6TnO9N2pnPs
         3Snu6/wATRZJB8t+YQbDUm1Wk/rYtxdEwix620DD0h77ckiFbPPrBJxZDrGeVfkzSrUC
         ZqOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWga4nXz9u0fFiwrxgWljqzjWRrhT1Ssy1yfkKOh1+oYGmfGs5+PZPCkZeGrv6Ge/WkzQZo22CpyKY8AvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHFUAR38i6J0YVvs9NlRYcfTlUA4MrmKBydBMNB7+jF0FdWibI
	7fYClF0UDAt0S091EMGeDahkODcofpnLv4hgzwz5gjMkd1iQTrR7
X-Google-Smtp-Source: AGHT+IGTJy7nZOVbGMX0rk+p4LbKdbZhs2O/9xbXpQGbE+31PN4fx6b6Rjj0ExWSH17bFS56yJzvPw==
X-Received: by 2002:a17:907:9452:b0:a9a:76d:e86c with SMTP id a640c23a62f3a-a9abf92cce4mr321005166b.49.1729705668601;
        Wed, 23 Oct 2024 10:47:48 -0700 (PDT)
Received: from andrea ([2a01:5a8:300:22d3:88b4:6602:b225:25ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91573645sm499088866b.182.2024.10.23.10.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 10:47:48 -0700 (PDT)
Date: Wed, 23 Oct 2024 20:47:44 +0300
From: Andrea Parri <parri.andrea@gmail.com>
To: puranjay@kernel.org, paulmck@kernel.org
Cc: bpf@vger.kernel.org, lkmm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Some observations (results) on BPF acquire and release
Message-ID: <Zxk2wNs4sxEIg-4d@andrea>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Puranjay and Paul,

I'm running some experiment on the (experimental) formalization of BPF
acquire and release available from [1] and wanted to report about some
(initial) observations for discussion and possibly future developments;
apologies in advance for the relatively long email and any repetition.


A first and probably most important observation is that the (current)
formalization of acquire and release appears to be "too strong": IIUC,
the simplest example/illustration for this is given by the following

BPF R+release+fence
{
 0:r2=x; 0:r4=y;
 1:r2=y; 1:r4=x; 1:r6=l;
}
 P0                                 | P1                                         ;
 r1 = 1                             | r1 = 2                                     ;
 *(u32 *)(r2 + 0) = r1              | *(u32 *)(r2 + 0) = r1                      ;
 r3 = 1                             | r5 = atomic_fetch_add((u32 *)(r6 + 0), r5) ;
 store_release((u32 *)(r4 + 0), r3) | r3 = *(u32 *)(r4 + 0)                      ;
exists ([y]=2 /\ 1:r3=0)

This "exists" condition is not satisfiable according to the BPF model;
however, if we adopt the "natural"/intended(?) PowerPC implementations
of the synchronization primitives above (aka, with store_release() -->
LWSYNC and atomic_fetch_add() --> SYNC ; [...] ), then we see that the
condition in question becomes (architecturally) satisfiable on PowerPC
(although I'm not aware of actual observations on PowerPC hardware).


At first, the previous observation (validated via simulations and later
extended to similar but more complex scenarios ) made me believe that
the BPF formalization of acquire and release could be strictly stronger
than the corresponding LKMM formalization; but that is _not_ the case:

The following "exists" condition is satisfiable according to the BPF
model (and it remains satisfiable even if the load_acquire() in P2 is
paired with an additional store_release() in P1).  In contrast, the
corresponding LKMM condition (e.g load_acquire() --> smp_load_acquire()
and atomic_fetch_add() --> smp_mb()) is not satisfiable (in fact, the
same conclusion holds even if the putative smp_load_acquire() in P2 is
"replaced" with an smp_rmb() or with an address dependency).

BPF Z6.3+fence+fence+acquire
{
 0:r2=x; 0:r4=y; 0:r6=l;
 1:r2=y; 1:r4=z; 1:r6=m;
 2:r2=z; 2:r4=x;
}
 P0                                         | P1                                         | P2                                 ;
 r1 = 1                                     | r1 = 2                                     | r1 = load_acquire((u32 *)(r2 + 0)) ;
 *(u32 *)(r2 + 0) = r1                      | *(u32 *)(r2 + 0) = r1                      | r3 = *(u32 *)(r4 + 0)              ;
 r5 = atomic_fetch_add((u32 *)(r6 + 0), r5) | r5 = atomic_fetch_add((u32 *)(r6 + 0), r5) |                                    ;
 r3 = 1                                     | r3 = 1                                     |                                    ;
 *(u32 *)(r4 + 0) = r3                      | *(u32 *)(r4 + 0) = r3                      |                                    ;
exists ([y]=2 /\ 2:r1=1 /\ 2:r3=0)


These remarks show that the proposed BPF formalization of acquire and
release somehow, but substantially, diverged from the corresponding
LKMM formalization.  My guess is that the divergences mentioned above
were not (fully) intentional, or I'm wondering -- why not follow the
latter (the LKMM's) more closely? -  This is probably the first question
I would need to clarify before trying/suggesting modifications to the
present formalizations.  ;-)  Thoughts?

  Andrea


[1] https://github.com/puranjaymohan/herdtools7/commits/bpf_acquire_release/

