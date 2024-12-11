Return-Path: <bpf+bounces-46669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA33A9ED813
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 22:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A63C916A11B
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 21:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D2522968A;
	Wed, 11 Dec 2024 21:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i699xUTH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F7A20B81C;
	Wed, 11 Dec 2024 21:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950985; cv=none; b=piMHiF9rvdn5ApnD/lkGiR/u4njs0kKO8tpRKF6DYAx2zvO0hwqEQ9VoBGS2SBqQaAdRdgqfAONq4bp3hJAm1St9l553TvmjAjR2/OrOqOvLDeV0vuLX68miUDvHVgVZCZhnCgCki+NKKyTe8mrsB1cK+nqKCMeSiOUS55+D+2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950985; c=relaxed/simple;
	bh=wKJnPm5lMavO6XE0LeAKRNBBXes4QK1QVjgJ3j9A/D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtXmf3FK+Kgye4GjM6i8M8OKf0nVuLJy1zXwO+Ugc+5yeHzSCDfph/wzHQsO1RU77WHwHrACeWP6tE9ZufznhyY7gLkcNMT5FUWJMszCm2imoUvofe9d4kJPZTeSY++1SWNyoYBC7iCupbn6bDASQyJYQ+5efdBKnv0MD8GG3LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i699xUTH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4591DC4CED2;
	Wed, 11 Dec 2024 21:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733950985;
	bh=wKJnPm5lMavO6XE0LeAKRNBBXes4QK1QVjgJ3j9A/D8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i699xUTHZtdgA8pqfap7bhaRw5RjyYwOrYUdF7ZFmD08xuDlEAnrsKOdWlfXHftIe
	 KlJBn0oYQ9hzWfetSPfZ+HOoFz0AgdCIK/y7wyOvRD8X9AftdI7o8Ors1JH6lx410z
	 OSnwUwQHTILTWix0D+FtsbQMi59V0ZyK0Bxdr0qaVIWUkkxufHjYDnJTJLOkv8OVHj
	 4/mHPW374fhfZGBI/XTyy3PKrKSKTyjOyYZ+w8gKH/cnme0vrzTUomqHD2DnvPB1+/
	 vUs4QX8IQn3TMEOMarEm6YYNn0nRb2qYKW+n0NvNzAcNPUV8VkyFilr0nYXnjRjpma
	 28MAT+9gx2eNA==
Date: Wed, 11 Dec 2024 11:03:04 -1000
From: Tejun Heo <tj@kernel.org>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: David Vernet <void@manifault.com>, sched-ext@meta.com,
	kernel-team@meta.com, linux-kernel@vger.kernel.org,
	bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH sched_ext/for-6.13-fixes] sched_ext: Fix invalid irq
 restore in scx_ops_bypass()
Message-ID: <Z1n-CEHxgn2YaTVQ@slm.duckdns.org>
References: <20241209152924.4508-1-void@manifault.com>
 <qC39k3UsonrBYD_SmuxHnZIQLsuuccoCrkiqb_BT7DvH945A1_LZwE4g-5Pu9FcCtqZt4lY1HhIPi0homRuNWxkgo1rgP3bkxa0donw8kV4=@pm.me>
 <Z1n9v7Z6iNJ-wKmq@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1n9v7Z6iNJ-wKmq@slm.duckdns.org>

On Wed, Dec 11, 2024 at 11:01:51AM -1000, Tejun Heo wrote:
> While adding outer irqsave/restore locking, 0e7ffff1b811 ("scx: Fix raciness
> in scx_ops_bypass()") forgot to convert an inner rq_unlock_irqrestore() to
> rq_unlock() which could re-enable IRQ prematurely leading to the following
> warning:
> 
>   raw_local_irq_restore() called with IRQs enabled
>   WARNING: CPU: 1 PID: 96 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x30/0x40
>   ...
>   Sched_ext: create_dsq (enabling)
>   pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>   pc : warn_bogus_irq_restore+0x30/0x40
>   lr : warn_bogus_irq_restore+0x30/0x40
>   ...
>   Call trace:
>    warn_bogus_irq_restore+0x30/0x40 (P)
>    warn_bogus_irq_restore+0x30/0x40 (L)
>    scx_ops_bypass+0x224/0x3b8
>    scx_ops_enable.isra.0+0x2c8/0xaa8
>    bpf_scx_reg+0x18/0x30
>   ...
>   irq event stamp: 33739
>   hardirqs last  enabled at (33739): [<ffff8000800b699c>] scx_ops_bypass+0x174/0x3b8
>   hardirqs last disabled at (33738): [<ffff800080d48ad4>] _raw_spin_lock_irqsave+0xb4/0xd8
> 
> Drop the stray _irqrestore().
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Ihor Solodrai <ihor.solodrai@pm.me>
> Link: http://lkml.kernel.org/r/qC39k3UsonrBYD_SmuxHnZIQLsuuccoCrkiqb_BT7DvH945A1_LZwE4g-5Pu9FcCtqZt4lY1HhIPi0homRuNWxkgo1rgP3bkxa0donw8kV4=@pm.me
> Fixes: 0e7ffff1b811 ("scx: Fix raciness in scx_ops_bypass()")
> Cc: stable@vger.kernel.org # v6.12

Applying to sched_ext/for-6.13-fixes.

Thanks.

-- 
tejun

