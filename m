Return-Path: <bpf+bounces-60245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8E6AD45C2
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 00:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40F437AB952
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 22:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967BA289E3A;
	Tue, 10 Jun 2025 22:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="siNg3Sw7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B50028A73E
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 22:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749593723; cv=none; b=l28Tk+qpA8WTT+veadNAxGrOHnZse024PPSa10+GCpiyW0bXoQN6dyV8GamIoLpbnijQ0Ao8jMCuGh54stlQXAcuv5MHogrUNTYLusrpCcDtyJXqUbOdgGQ0APJG9kg7tR4q+Bw/JVDZDAgSY/bIfibnARng5otHZ5eeollBr6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749593723; c=relaxed/simple;
	bh=uQtuxYYG3U7/bCNkJyP3taMW9DM0EZCBzLmLhATLs3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbwTsGIkVnD9qvmE7D3/tQNtBbQOokmjFvD2LuADwdm4PEdJREwOasMb6dh7AWOD9JkJHShorzmtA1j2bku5mjDq6EfbtKEh1TFYKxwuX/yfSHbWQRQBG66dRwuWn7PtazGgSeIkDABK3e9IW49C2uHdvRqZ3wrKznp2N05o4vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=siNg3Sw7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892A2C4CEED;
	Tue, 10 Jun 2025 22:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749593722;
	bh=uQtuxYYG3U7/bCNkJyP3taMW9DM0EZCBzLmLhATLs3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=siNg3Sw705A6va1nmeX3/MYr2Fie/N7nyvjq6H+nqAnLfK0R3P7OFXhgHAX6S8lnU
	 mypRYaK1qOCnhGRXtiG2LaOfrMJSmwmIyCyJZErQmaaxce1EJuehWhQKox0TnytbED
	 vgqCG5l7OF4nCh8IkJj1K0KgGDKS/N3fTGSFJto1zYR80gBVqa3c50evlsfQuTdPqo
	 f90FPW7mrBEM9uy/eHwVbNUPpXp+gACMaq1nMFLt1D7Dul8y6Jqh0Vn0q+2Nn4h53m
	 NjXNqf+yfJk86vON1OaRQXbbSVQ2UjtQkA+A1ClnybhctVZccrlmqM1uzbKU8Ar8yk
	 ba+FzuLwqIdRA==
Date: Tue, 10 Jun 2025 12:15:20 -1000
From: Tejun Heo <tj@kernel.org>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v1 1/4] bpf: Save struct_ops instance pointer in
 bpf_prog_aux
Message-ID: <aEiueLr7IR6wlUE0@slm.duckdns.org>
References: <20250609232746.1030044-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609232746.1030044-1-ameryhung@gmail.com>

On Mon, Jun 09, 2025 at 04:27:43PM -0700, Amery Hung wrote:
> Allows struct_ops implementors to infer the calling struct_ops instance
> inside a kfunc through prog->aux->this_st_ops. A new field, flags, is
> added to bpf_struct_ops. If BPF_STRUCT_OPS_F_THIS_PTR is set in flags,
> a pointer to the struct_ops structure registered to the kernel (i.e.,
> kvalue->data) will be saved to prog->aux->this_st_ops. To access it in
> a kfunc, use BPF_STRUCT_OPS_F_THIS_PTR with __prog argument [0]. The
> verifier will fixup the argument with a pointer to prog->aux. this_st_ops
> is protected by rcu and is valid until a struct_ops map is unregistered
> updated.
> 
> For a struct_ops map with BPF_STRUCT_OPS_F_THIS_PTR, to make sure all
> programs in it have the same this_st_ops, cmpxchg is used. Only if a
> program is not already used in another struct_ops map also with
> BPF_STRUCT_OPS_F_THIS_PTR can it be assigned to the current struct_ops
> map.
> 
> [0]
> commit bc049387b41f ("bpf: Add support for __prog argument suffix to
> pass in prog->aux")
> https://lore.kernel.org/r/20250513142812.1021591-1-memxor@gmail.com
> 
> Signed-off-by: Amery Hung <ameryhung@gmail.com>

FWIW, this looks great from sched_ext POV.

Thanks.

-- 
tejun

