Return-Path: <bpf+bounces-73937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E12C3E6FC
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 05:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE66A3AA54A
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 04:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FB92ED871;
	Fri,  7 Nov 2025 04:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZAgV4NP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120CA2877D7;
	Fri,  7 Nov 2025 04:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762489021; cv=none; b=OZqBP7NqEwWIAnSX3NSiRq550Ve1IrRqm/PfPrZ6PGs+o8TVlloMQ6BhztMj+DuYgRXIpeZKN9lnEvggav1ICuab+rodSgZsryg+oaHT405mnV2eaymEK9uTc5pR6Ja2k08270uMrp1a1Ot98a/XW8eS13F1CRhNrZnR0/NEMHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762489021; c=relaxed/simple;
	bh=M+OpW1tlcwU9xR2sQ77krJq0ImruRdWMpmRi1kwjCzg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Wmamz+KhAUDfj6H1rdb06fo/gNKDXfbJTezbh0b4tLLNFZYIh4ilsHDVoJGgqah/ICUnrKPYzEm8L1vNkJJ6WakmH+JAPFzTqAcmcEGpxiLbQk4Bao772l1vDN4s3GYNFisv1VKQxlb4nwimkyxAzy624+wAZeakHXQuHL7p4Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZAgV4NP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01239C4CEF5;
	Fri,  7 Nov 2025 04:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762489020;
	bh=M+OpW1tlcwU9xR2sQ77krJq0ImruRdWMpmRi1kwjCzg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=WZAgV4NPFp11KyB/0jIpKkhEDfICAFKacbZRWkRQ/Il9AGcyG+WXK7wmraAIthMQ8
	 kEFN53FpvqfCsiUuvtJcmszuZIGk+m/6qvX1kjLCCeYoXBfK4a3nTGAcAWZeX8hDnq
	 tRUu1T3n6nhZukqXG8NmyyGTQX4WvP9/hL60C/9sHZBA/fx9Y7HWY5dNXAr9kNpiPb
	 AN6oKqQQUjcCzLi2BDtl0RwGx46tqVnnp3+b4JTcl+K33qTrIrV5PULsZpypw8h1/L
	 r2E8OfvpJ6x+QrLyly0zA/90E2M27LQI3efFZyjJl1fgN3hcmIfQO08E2YCPSKe4i1
	 F+9gAlEwQAEfg==
Content-Type: multipart/mixed; boundary="===============1508624635170502900=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <85f7a32e705dc34a7e76e4f41727076593fa4ad52ce918549103885c9719821a@mail.kernel.org>
In-Reply-To: <20251107035632.115950-4-alibuda@linux.alibaba.com>
References: <20251107035632.115950-4-alibuda@linux.alibaba.com>
Subject: Re: [PATCH bpf-next v5 3/3] bpf/selftests: add selftest for bpf_smc_hs_ctrl
From: bot+bpf-ci@kernel.org
To: alibuda@linux.alibaba.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,pabeni@redhat.com,song@kernel.org,sdf@google.com,haoluo@google.com,yhs@fb.com,edumazet@google.com,john.fastabend@gmail.com,kpsingh@kernel.org,jolsa@kernel.org,mjambigi@linux.ibm.com,wenjia@linux.ibm.com,wintera@linux.ibm.com,dust.li@linux.alibaba.com,tonylu@linux.alibaba.com,guwen@linux.alibaba.com
Cc: bpf@vger.kernel.org,davem@davemloft.net,kuba@kernel.org,netdev@vger.kernel.org,sidraya@linux.ibm.com,jaka@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  7 Nov 2025 04:16:59 +0000 (UTC)

--===============1508624635170502900==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
> index 70b28c1e6..fcd2f9bf7 100644
> --- a/tools/testing/selftests/bpf/config
> +++ b/tools/testing/selftests/bpf/config
> @@ -123,3 +123,8 @@ CONFIG_XDP_SOCKETS=y
>  CONFIG_XFRM_INTERFACE=y
>  CONFIG_TCP_CONG_DCTCP=y
>  CONFIG_TCP_CONG_BBR=y
> +CONFIG_INFINIBAND=y
> +CONFIG_SMC=y
> +CONFIG_SMC_HS_CTRL_BPF=y
> +CONFIG_DIBS=y
> +CONFIG_DIBS_LO=y
\ No newline at end of file

The config file is missing a newline at the end. While not a functional
issue, this violates POSIX text file conventions and git warns about it.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19157812097

--===============1508624635170502900==--

