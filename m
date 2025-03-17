Return-Path: <bpf+bounces-54194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA32CA65196
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 14:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F31F3A84C5
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 13:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC1823C8A4;
	Mon, 17 Mar 2025 13:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FovhjW/f"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362574C74;
	Mon, 17 Mar 2025 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742219179; cv=none; b=CLbG6aNz1G+DqlZC6KwH253NgNpaqA42ZJFbTa4YN+FP0tJR1CGMCI6tFiOonERiuJadlpGelnLK9Wg1SHk5ZzZawNRInN4RVYdY4ev812eRqUp7Wi5R2VUZR7+jQS1gAXMZ1o7FlXoNoyrqNccrczpLCkR9W4ATUXuR3m5LQak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742219179; c=relaxed/simple;
	bh=aSRWTLBIYkccaycOahFlhqCVHc4u1bii3grWN/hWT+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJM8V4258xVQwcwQ5jc1Ta6Jpx/aOgG73JZV2BDbR7+i9wuK3tVqCI3onkLdVMb7LcXShYzdJVJkFu4fbNwL0hdE8zPJq/mkHp+4l1L9pIp9FuqKrWCiDdgm2XxHZBfX/YLZmNMUbNNpoJKkm5BooNNhAUrpvfxp3gGdpaO+OQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FovhjW/f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD40C4CEE3;
	Mon, 17 Mar 2025 13:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742219178;
	bh=aSRWTLBIYkccaycOahFlhqCVHc4u1bii3grWN/hWT+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FovhjW/fZ0dIjaPOJIdlpA6hXVHDLYryqG8CjyslGsNCfIDkyj9S5edkphABQNSPo
	 7Cn6o9YHeEj+Mm/POWJn1Ry2XBAUFQbwpVAM2q5BMIs92dp9HawcfgvLIn+DVx4shp
	 dByWx/HjGXfNSvVI4P9RWmuCEsTZEXkuz/9/7L+E=
Date: Mon, 17 Mar 2025 14:44:53 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
	Ricardo =?iso-8859-1?Q?Ca=F1uelo?= Navarro <rcn@igalia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@kernel.org>
Subject: Re: [PATCH stable] xdp: Reset bpf_redirect_info before running a
 xdp's BPF prog.
Message-ID: <2025031733-collide-dad-203a@gregkh>
References: <20250317133813.OwHVKUKe@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250317133813.OwHVKUKe@linutronix.de>

On Mon, Mar 17, 2025 at 02:38:13PM +0100, Sebastian Andrzej Siewior wrote:
> Ricardo reported a KASAN discovered use after free in v6.6-stable.
> 
> The syzbot starts a BPF program via xdp_test_run_batch() which assigns
> ri->tgt_value via dev_hash_map_redirect() and the return code isn't
> XDP_REDIRECT it looks like nonsense. So the output in
> bpf_warn_invalid_xdp_action() appears once.
> Then the TUN driver runs another BPF program (on the same CPU) which
> returns XDP_REDIRECT without setting ri->tgt_value first. It invokes
> bpf_trace_printk() to print four characters and obtain the required
> return value. This is enough to get xdp_do_redirect() invoked which
> then accesses the pointer in tgt_value which might have been already
> deallocated.
> 
> This problem does not affect upstream because since commit
> 	401cb7dae8130 ("net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.")
> 
> the per-CPU variable is referenced via task's task_struct and exists on
> the stack during NAPI callback. Therefore it is cleared once before the
> first invocation and remains valid within the RCU section of the NAPI
> callback.
> 
> Instead of performing the huge backport of the commit (plus its fix ups)
> here is an alternative version which only resets the variable in
> question prior invoking the BPF program.
> 
> Acked-by: Toke Høiland-Jørgensen <toke@kernel.org>
> Reported-by: Ricardo Cañuelo Navarro <rcn@igalia.com>
> Closes: https://lore.kernel.org/all/20250226-20250204-kasan-slab-use-after-free-read-in-dev_map_enqueue__submit-v3-0-360efec441ba@igalia.com/
> Fixes: 97f91a7cf04ff ("bpf: add bpf_redirect_map helper routine")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> 
> I discussed this with Toke, thread starts at
> 	https://lore.kernel.org/all/20250313183911.SPAmGLyw@linutronix.de/
> 
> The commit, which this by accident, is part of v6.11-rc1.
> I added the commit introducing map redirects as the origin of the
> problem which is v4.14-rc1. The code is a bit different there it seems
> to work similar.

What stable tree(s) is this for?  Just 6.6.y?  Why not older ones?

> Greg, feel free to decide if this is worth a CVE.

That's not how CVEs are assigned :)

If you want one, please read the in-tree documentation we have for that.

thanks,

greg k-h

