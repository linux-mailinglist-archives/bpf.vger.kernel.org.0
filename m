Return-Path: <bpf+bounces-44289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2219C0ECD
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 20:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32393282520
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 19:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39364197A9E;
	Thu,  7 Nov 2024 19:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sxw0XQU2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63A1192D83
	for <bpf@vger.kernel.org>; Thu,  7 Nov 2024 19:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731007256; cv=none; b=KuhD/BN169KRZ1qQ7ZpvLKQuoq2DRdVgGSUFDRXjT/2Tga43xrcBMGm/YOX8/ZMGiYaFgUwzr3YqtdRgALs26X1+S80at9Z3xoQfELdsVELB6KGRFnXtqsM3tmuCfDuIxCQpGPa5tEwIpTFi/qpQ6jHoIR5yaP7RbnNMEqc8onM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731007256; c=relaxed/simple;
	bh=j8+sbisBN+m77v0ou8WPmDnssUUZa5nx0D5ZqVAncVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBq7XEr1FOSivqbscQcUxTCz5cx7I5wVCANc2S4ZGuy7oI5ghcJ5W0adnz95V2anx+Qj7emMbzorpe7tulhuwigcKw5CUDfhQ11kO1uuzcalrMb3VsubHBBs8hiOBj6Vs07M0orQVv0jmCChLAYG7CvmAhob6H3EaD3Cxyirhr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sxw0XQU2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297F1C4CECC;
	Thu,  7 Nov 2024 19:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731007256;
	bh=j8+sbisBN+m77v0ou8WPmDnssUUZa5nx0D5ZqVAncVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sxw0XQU2OHoz75yKpOLGlditbHFVt0q/DSggroqmGiqncwrNvL9Cj+PMTKjmV/itv
	 pScdDu0R4vIarXuuNIdtv/LOESJbJ509xgw+kcwK84UB/ztKwhnl4fFaHWvM9q+qOd
	 UxeJ/8NGES2khCplgLZQzj54xNCtfuUTGKlm9Huq/o59kDLcDaViGH3Gh0gtyp6lMK
	 sIBg20QvKKdcP9v9bSybtKRdYI0MQjXnaPWQ6ldVRTbr8spizJi+vcEyVfB6X1s/rc
	 CQZMUYaRAWeU2pJzKcbG5SaAyBxNg6EfdVaSueyhoA6HrFU/i+94csE+zCwslaMbcl
	 qzOjTHaOIH6fQ==
Date: Thu, 7 Nov 2024 09:20:55 -1000
From: Tejun Heo <tj@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v10 6/7] bpf: Support private stack for
 struct_ops progs
Message-ID: <Zy0TF132HobbRZ4Z@slm.duckdns.org>
References: <20241107024138.3355687-1-yonghong.song@linux.dev>
 <20241107024209.3357227-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107024209.3357227-1-yonghong.song@linux.dev>

On Wed, Nov 06, 2024 at 06:42:09PM -0800, Yonghong Song wrote:
> For struct_ops progs, whether a particular prog uses private stack
> depends on prog->aux->priv_stack_requested setting before actual
> insn-level verification for that prog. One particular implementation
> is to piggyback on struct_ops->check_member(). The next patch has
> an example for this. The struct_ops->check_member() sets
> prog->aux->priv_stack_requested to be true which enables private stack
> usage.
> 
> The struct_ops prog follows the same rule as kprobe/tracing progs after
> function bpf_enable_priv_stack(). For example, even a struct_ops prog
> requests private stack, it could still use normal kernel stack if
> the stack size is small (< 64 bytes).
> 
> The prog->aux->priv_stack_requested is also used for recursion checking
> for struct_ops progs. Similar to tracing progs, nested same cpu same
> prog run will be skipped. A field (recursion_detected()) is added to
> bpf_prog_aux structure. If bpf_prog->aux->recursion_detected
> is implemented by the struct_ops subsystem and nested same cpu/prog
> happens, the function will be triggered to report an error, collect
> related info, etc.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

From user's POV, this looks great:

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

