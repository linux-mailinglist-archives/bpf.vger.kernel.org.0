Return-Path: <bpf+bounces-52798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2D9A488DE
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 20:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC58D7A5ECF
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 19:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF3826E656;
	Thu, 27 Feb 2025 19:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mF4Qv21A"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE981E521C;
	Thu, 27 Feb 2025 19:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740683948; cv=none; b=DEy0XzFIT+VAvcgIy4H7oQPY2QWefa8uG9bb7mG16maVmnOKM8DNtk2QerPgI+U+INFQBb83addEKuPWgAdYMMBK6cCiLWKUlzWRDxYOhpQhvLPiVZhCVcg3FKdUi/J4bmoEERIEiQ3AshRHyY91A9+0pozXB7hrtIb2+L79yz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740683948; c=relaxed/simple;
	bh=2X2qLNZH7uboiUyrahk+iO4ZuN93T5ESjCur/GZji1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZ+aSb0WrX2xe5l8wMG5SMb9CCRNWMv6VMEvJg8jdC+qcJRNgWxedd8JAzi3rp9aL22UEgUYa2u9C/VeVABM5PjrzPqfj/Z32ZcTrnpufyjlkHEu+IFhvFilmI9aJiqI/nOquK3piqR9dBNjIbwrWKZano3kWjiD167QiRzCYqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mF4Qv21A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F001C4CEDD;
	Thu, 27 Feb 2025 19:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740683948;
	bh=2X2qLNZH7uboiUyrahk+iO4ZuN93T5ESjCur/GZji1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mF4Qv21A9W/b3XEN2Y/n3BWwLDomwlfBqr/wmlWcLYIGmbDesbQyrR4vXDIm9qSuy
	 1OUGVYbVOeABfF9fyCvn7viQ7Dx5Fwd7yUjzpoNVvI/yCgS4PGIP4Itg8dcz/xCQeW
	 ldstY028QqjeBy6Jt3GGKnEC/KTxqUp7tnZ/+2yeNiSw2uFA1NR0TlYEAnDNQgxgl0
	 MEqNvueaTN4u6CQVZ4rPA7qBh9zsLfWY9s4cVR6PTSMXwTD+4csw/n1GF3U/Oa6UQk
	 DqaPET2/nmM2qtVymUArC4PDfdqfLr6xTqzdY5uefJG/5hMPWf1AsO+SAHIBFaDe3k
	 PVA5wpYbhMBAw==
Date: Thu, 27 Feb 2025 09:19:07 -1000
From: Tejun Heo <tj@kernel.org>
To: Juntong Deng <juntong.deng@outlook.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
	memxor@gmail.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.15 v3 2/5] sched_ext: Declare
 context-sensitive kfunc groups that can be used by different SCX operations
Message-ID: <Z8C6q2VxuclLiR4p@slm.duckdns.org>
References: <AM6PR03MB50806070E3D56208DDB8131699C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB508018ABBD34FBAA089DD9F799C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR03MB508018ABBD34FBAA089DD9F799C22@AM6PR03MB5080.eurprd03.prod.outlook.com>

On Wed, Feb 26, 2025 at 07:28:17PM +0000, Juntong Deng wrote:
> This patch declare context-sensitive kfunc groups that can be used by
             ^
             declares

> different SCX operations.
...
> +/* Each flag corresponds to a btf kfunc id set */
> +enum scx_ops_kf_flags {
> +	SCX_OPS_KF_ANY			= 0,
> +	SCX_OPS_KF_UNLOCKED		= 1 << 1,

nit: Any specific reason to skip bit 0?

> +	SCX_OPS_KF_CPU_RELEASE		= 1 << 2,
> +	SCX_OPS_KF_DISPATCH		= 1 << 3,
> +	SCX_OPS_KF_ENQUEUE		= 1 << 4,
> +	SCX_OPS_KF_SELECT_CPU		= 1 << 5,
> +};
> +
> +static const u32 scx_ops_context_flags[] = {
> +	[SCX_OP_IDX(select_cpu)]		= SCX_OPS_KF_SELECT_CPU | SCX_OPS_KF_ENQUEUE,
> +	[SCX_OP_IDX(enqueue)]			= SCX_OPS_KF_ENQUEUE,
> +	[SCX_OP_IDX(dequeue)]			= SCX_OPS_KF_ANY,
> +	[SCX_OP_IDX(dispatch)]			= SCX_OPS_KF_DISPATCH | SCX_OPS_KF_ENQUEUE,
> +	[SCX_OP_IDX(tick)]			= SCX_OPS_KF_ANY,
> +	[SCX_OP_IDX(runnable)]			= SCX_OPS_KF_ANY,
> +	[SCX_OP_IDX(running)]			= SCX_OPS_KF_ANY,
> +	[SCX_OP_IDX(stopping)]			= SCX_OPS_KF_ANY,
> +	[SCX_OP_IDX(quiescent)]			= SCX_OPS_KF_ANY,
> +	[SCX_OP_IDX(yield)]			= SCX_OPS_KF_ANY,
> +	[SCX_OP_IDX(core_sched_before)]		= SCX_OPS_KF_ANY,
> +	[SCX_OP_IDX(set_weight)]		= SCX_OPS_KF_ANY,
> +	[SCX_OP_IDX(set_cpumask)]		= SCX_OPS_KF_ANY,
> +	[SCX_OP_IDX(update_idle)]		= SCX_OPS_KF_ANY,
> +	[SCX_OP_IDX(cpu_acquire)]		= SCX_OPS_KF_ANY,
> +	[SCX_OP_IDX(cpu_release)]		= SCX_OPS_KF_CPU_RELEASE,
> +	[SCX_OP_IDX(init_task)]			= SCX_OPS_KF_UNLOCKED,
> +	[SCX_OP_IDX(exit_task)]			= SCX_OPS_KF_ANY,
> +	[SCX_OP_IDX(enable)]			= SCX_OPS_KF_ANY,
> +	[SCX_OP_IDX(disable)]			= SCX_OPS_KF_ANY,
> +	[SCX_OP_IDX(dump)]			= SCX_OPS_KF_DISPATCH,

Shouldn't this be SCX_OPS_KF_UNLOCKED?

Thanks.

-- 
tejun

