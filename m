Return-Path: <bpf+bounces-31586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F41900404
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2024 14:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0830F1F21781
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2024 12:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB74195FD5;
	Fri,  7 Jun 2024 12:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lElieZTM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF397195F00
	for <bpf@vger.kernel.org>; Fri,  7 Jun 2024 12:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717764375; cv=none; b=dqU+motTESaFmG9LW/l2Kw1eFuFOAABROYQczJ9MHENH7x54XGvXKS/7HIfnOF6JyskOWsYzqNKQomslIYO9OgPlStRnYhnQGSn9DL8fFvgjIer0MwBwCLiQkUBY1L9fwkgnV7EPY9hgJJxNoq8BGNyDoxgr4HceDVJKSFr2kbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717764375; c=relaxed/simple;
	bh=EPa4zlLpWkiXsdpe3X90GMrWIjiVJoCk/vGEU5xRMVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n4/ruPeLbLQwp1QE9uvqTEi+lNp2ZRKJBaezIshSHWMLNeHG6CsdiuYSwURs8L4dMazr96Sc8PA7x74aMahUXD67IA+txjZqdr1aAJW3x8mP/fItNhT7egacIRTzSfXmka7ZO66QyXXDKXl5CLOUNro0mxW8ZZ2HZZkr5LRbNpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lElieZTM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B8BC32782;
	Fri,  7 Jun 2024 12:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717764374;
	bh=EPa4zlLpWkiXsdpe3X90GMrWIjiVJoCk/vGEU5xRMVU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lElieZTMiUCECWxqH+xL5xGqUJQX0Xr4iJ6IAKxB4RkVdrTZVh5vU+oEmbOOF1Qy+
	 P4KkFFHF2lrGIwuDp6FGrTvXga3PqcmhH7zBc/xdf/fMUWoFmLfCpT18loQQHMGzf0
	 VCOMqsmCadGeD8kVG2Rf+JjkgxnrE85LdkaJLaLR+5szuw/GaLxVeJKOEreE9R/wcd
	 6ds1T6OwAlM32Fy/a9pyRuMZsNY5c5d6VBZGiVOzBd913vPiFqOd88RjElUcUbQGH8
	 15NVbKsptCbRMfVjtAtoJa5vt3k3/DnKpc79Ilpq+GlJdlFTDcCRNY438hGeJoM8kD
	 dnBfDkRpsOGmg==
Message-ID: <8a8dcaf9-78a1-47ac-9884-52bce69d5440@kernel.org>
Date: Fri, 7 Jun 2024 13:46:07 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] bpftool: Query only cgroup-related attach types
To: Kenta Tada <tadakentaso@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org
References: <20240607111704.6716-1-tadakentaso@gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20240607111704.6716-1-tadakentaso@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-06-07 12:17 UTC+0100 ~ Kenta Tada <tadakentaso@gmail.com>
> When CONFIG_NETKIT=y,
> bpftool-cgroup shows error even if the cgroup's path is correct:
> 
> $ bpftool cgroup tree /sys/fs/cgroup
> CgroupPath
> ID       AttachType      AttachFlags     Name
> Error: can't query bpf programs attached to /sys/fs/cgroup: No such device or address
> 
> From strace and kernel tracing, I found netkit returned ENXIO and this command failed.
> I think this AttachType(BPF_NETKIT_PRIMARY) is not relevant to cgroup.
> 
> bpftool-cgroup should query just only cgroup-related attach types.
> 
> v2->v3:
>   - removed an unnecessary check
> 
> v1->v2:
>   - used an array of cgroup attach types
> 
> Signed-off-by: Kenta Tada <tadakentaso@gmail.com>


Reviewed-by: Quentin Monnet <qmo@kernel.org>

Thanks!


