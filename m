Return-Path: <bpf+bounces-78167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB18BD0055D
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 23:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4196130169B5
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 22:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7367F277CBF;
	Wed,  7 Jan 2026 22:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpIdvfQr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2EB18027;
	Wed,  7 Jan 2026 22:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767825293; cv=none; b=bmqOpD/uPOcNa1+0QC1e9Ux93gAXXemHyan5t9ToXcP0nb/cy3HeU5nkCbABKW+S5B+ZV1RSUJOTyPV93qdXLd7edkU2hoW61Q0OkjB+ZOIWFcvlos0sdx1p4JPDonhKAbKrXsc9+REJqal+GzCdAkn7na+uJ4WCDTL/jSQPIl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767825293; c=relaxed/simple;
	bh=u2djh5HTea2QgQAtKE8wrDS39r3GdGnQy6gR3KSDYo8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uiOI576Kjrju8+yBFIkdSiAw9w2g0ykGC22pa0NxdqySARdvrHFHpS6bfSb4cRbbKPKfWN9dCQ9iuvafnFIVZlU4A49p1zq3/Ts6yiFedTFrYNL9KgZ68C0B5Z69t30Rir1XOYA7QHr7EpOozCjOW/HWtKN0O6f0fWw+ajIANgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpIdvfQr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF6BC4CEF1;
	Wed,  7 Jan 2026 22:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767825291;
	bh=u2djh5HTea2QgQAtKE8wrDS39r3GdGnQy6gR3KSDYo8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=kpIdvfQrxqcdWmTnAlntF/vZqTBIV/dYi2cpN6FGularoO0Ce+glktt9n3X43t00Y
	 LbANnAjw7W2dRUg4YvSms29eNjfW8EpVkKrNu3jsJQWHmqkpRzcqsj91Ww9gyP55p2
	 WuIzknUf0JP43QyZ/MIzEjAR2xrb6j77mHBAahXUGWj5WTgcOwaBw1QwzP9XeGdYF2
	 AGMtFXAVr4h//JpvQhgYDNBGYAvYmzocfxWJXxBNhDZjmGCbGrWfXkS5sUDyIxi6y8
	 K2np+ZUVoKbW40KNeKgIKR5ZzTNlwtmcmcYe6MSgYJ0WsgpExgC3uQKp+t7t5e8wCi
	 7yFBeHOqhBoaA==
Date: Wed, 7 Jan 2026 15:34:48 -0700 (MST)
From: Paul Walmsley <pjw@kernel.org>
To: Yunhui Cui <cuiyunhui@bytedance.com>
cc: aou@eecs.berkeley.edu, alex@ghiti.fr, andybnac@gmail.com, 
    apatel@ventanamicro.com, ast@kernel.org, ben.dooks@codethink.co.uk, 
    bjorn@kernel.org, bpf@vger.kernel.org, charlie@rivosinc.com, cl@gentwo.org, 
    conor.dooley@microchip.com, cyrilbur@tenstorrent.com, daniel@iogearbox.net, 
    debug@rivosinc.com, dennis@kernel.org, eddyz87@gmail.com, 
    haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
    kpsingh@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
    linux-riscv@lists.infradead.org, linux@rasmusvillemoes.dk, 
    martin.lau@linux.dev, palmer@dabbelt.com, pjw@kernel.org, 
    puranjay@kernel.org, pulehui@huawei.com, ruanjinjie@huawei.com, 
    rkrcmar@ventanamicro.com, samuel.holland@sifive.com, sdf@fomichev.me, 
    song@kernel.org, tglx@linutronix.de, tj@kernel.org, thuth@redhat.com, 
    yonghong.song@linux.dev, yury.norov@gmail.com, zong.li@sifive.com
Subject: Re: [PATCH v3 1/3] riscv: remove irqflags.h inclusion in
 asm/bitops.h
In-Reply-To: <20251216014721.42262-2-cuiyunhui@bytedance.com>
Message-ID: <bb259f36-6a5a-1bb8-75de-9bb62ade44a8@kernel.org>
References: <20251216014721.42262-1-cuiyunhui@bytedance.com> <20251216014721.42262-2-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 16 Dec 2025, Yunhui Cui wrote:

> The arch/riscv/include/asm/bitops.h does not functionally require
> including /linux/irqflags.h. Additionally, adding
> arch/riscv/include/asm/percpu.h causes a circular inclusion:
> kernel/bounds.c
> ->include/linux/log2.h
> ->include/linux/bitops.h
> ->arch/riscv/include/asm/bitops.h
> ->include/linux/irqflags.h
> ->include/linux/find.h
> ->return val ? __ffs(val) : size;
> ->arch/riscv/include/asm/bitops.h
> 
> The compilation log is as follows:
> CC      kernel/bounds.s
> In file included from ./include/linux/bitmap.h:11,
>                from ./include/linux/cpumask.h:12,
>                from ./arch/riscv/include/asm/processor.h:55,
>                from ./arch/riscv/include/asm/thread_info.h:42,
>                from ./include/linux/thread_info.h:60,
>                from ./include/asm-generic/preempt.h:5,
>                from ./arch/riscv/include/generated/asm/preempt.h:1,
>                from ./include/linux/preempt.h:79,
>                from ./arch/riscv/include/asm/percpu.h:8,
>                from ./include/linux/irqflags.h:19,
>                from ./arch/riscv/include/asm/bitops.h:14,
>                from ./include/linux/bitops.h:68,
>                from ./include/linux/log2.h:12,
>                from kernel/bounds.c:13:
> ./include/linux/find.h: In function 'find_next_bit':
> ./include/linux/find.h:66:30: error: implicit declaration of function '__ffs' [-Wimplicit-function-declaration]
>    66 |                 return val ? __ffs(val) : size;
>       |                              ^~~~~
> 
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>

Thanks, queued this patch for v6.19-rc.


- Paul

