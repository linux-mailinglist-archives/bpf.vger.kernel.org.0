Return-Path: <bpf+bounces-56388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4024EA96638
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 12:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 260843BC0EA
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 10:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E69202C26;
	Tue, 22 Apr 2025 10:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d2gk/1TM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D643B1EE7BC;
	Tue, 22 Apr 2025 10:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745318619; cv=none; b=ZnPmDM3lpDrmvk2x0inqcr5DD6TMGcTssuBdZlkeja+ICZ8ddseFTk51YKHcnp9WdRwMzYyMHXYmKjl+BPwPPHUaEMTd36cVMtfyZEAZQGrQsr1qnuFon0+PK72PzPklWFAbnPKBbLp76NZ9SWUXtinuLBRKvMBQVoUjNR1aD3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745318619; c=relaxed/simple;
	bh=qJxguF5XzFQ70DcwywAq3gNy1HdlL2Sn/ai5szCPS4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpgUde/N5QJorL2ak71igJPRMAbIo9//clPWWo9ZExFZWE49aX0IE1FldqkOrhxZiUsXWBYCHAnK8qzGprBGL01xwwrtfd7kZjUUc4pwXFR/BiAoWZiopDs9PgpCVMAUuhE+aYwk9YOnahbso1hXq2o63o1p9yLmf+33fJMiVls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d2gk/1TM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF394C4CEE9;
	Tue, 22 Apr 2025 10:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745318618;
	bh=qJxguF5XzFQ70DcwywAq3gNy1HdlL2Sn/ai5szCPS4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d2gk/1TM7i9nWnxFI+Wd68ccqdkJoF6IPmE6Q4P03mdpoje7zctYDWGh/ZOsMhaku
	 NC0lrB7tYkg2KQ5iJ98oUxAB82omDFBx7iuf7RXga84Bd7+YEdm+HZWo51pTnnpW+I
	 bOLWg6TZtcs5Eff4wq+LZzyxX9xkZbHizxm1+gm8=
Date: Tue, 22 Apr 2025 12:43:35 +0200
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
Message-ID: <2025042223-departed-aids-add9@gregkh>
References: <20250414162120.U-UFSLv8@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250414162120.U-UFSLv8@linutronix.de>

On Mon, Apr 14, 2025 at 06:21:20PM +0200, Sebastian Andrzej Siewior wrote:
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
> problem which is v4.14-rc1. The code is a bit different there but it
> seems to work similar.
> Affected kernels would be from v4.14 to v6.10.

Does not apply to any tree other than 6.6.y :(


