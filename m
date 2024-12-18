Return-Path: <bpf+bounces-47165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A1E9F5C60
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 02:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57D9716DE56
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 01:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D151845979;
	Wed, 18 Dec 2024 01:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJ7SxBjE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8E435943;
	Wed, 18 Dec 2024 01:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734486290; cv=none; b=CFsNoL0Gp/LRmirY3nc7ccL0sQviCAnwP+6nc8gLFaajo0MUXUw9uFJdzi29bFfaSKlEt9G6P5ZJrcPN8Ra37QpZSU9FjmFJih6iRaj2uIxmaupcwqSaAc+aleTK9RlDXSbLeqv/GIXfiU5+AFhH9PMGluo4zv5bHr7iFp/GAdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734486290; c=relaxed/simple;
	bh=YLJCOwxf+thC0c2kUfHqT3UzjSUG+VFoLElmsyhFHlM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=awC8gAOy3LW1DkelvHItLmd1bSxgdn3aTase4DSJgBAJJ9gszr7VSke6jFF53TR51+mWf7Iw3K8UkrB64u7j1VEPXU2NfVZG2g1qlY3tYeIQUmvhLnKgKPyAcCfZafVIPYybKZnFJqnfaNnd9hsBF5zW1Nr0pM9/+zEamvgzs3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJ7SxBjE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1578BC4CED3;
	Wed, 18 Dec 2024 01:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734486289;
	bh=YLJCOwxf+thC0c2kUfHqT3UzjSUG+VFoLElmsyhFHlM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tJ7SxBjEM5PBleAB6NF1pNiAaKiWdewdL6b0EWPDkn5dgfhUG0YmQwqToHpULoUvR
	 v3duuv0JQshJprnE+JzAW/JdnGvlCJ4IWT8wnD+ZviB5q+1jkXLvU8hlbH4gOFsBy+
	 bfAoK+YEnDpvx88yprZHzInApnQ/2E9UcfBr2lrLxPkYwYBKYB1a/cB2sdD30T1BiH
	 X/un85/d1aGoQUwMtkK4212mRzOdmWzc9AwOaZ30bO1dKx9OETgK8pZ+wDP4UXAw0r
	 yPoNcHJ52N/R1SP3mHE7VFq5XcyaRlGusmIviSAXccYZ6+HdSdWNZ5WSfwYdabQuHm
	 YmA7nTAcHPx5g==
Date: Tue, 17 Dec 2024 17:44:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Amery Hung <amery.hung@bytedance.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 alexei.starovoitov@gmail.com, martin.lau@kernel.org, sinquersw@gmail.com,
 toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, stfomichev@gmail.com,
 ekarani.silvestre@ccc.ufcg.edu.br, yangpeihao@sjtu.edu.cn,
 xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com, ameryhung@gmail.com
Subject: Re: [PATCH bpf-next v1 01/13] bpf: Support getting referenced kptr
 from struct_ops argument
Message-ID: <20241217174447.2ce50fb6@kernel.org>
In-Reply-To: <65399ffd-da8a-436a-81fd-b5bd3e4b8a54@linux.dev>
References: <20241213232958.2388301-1-amery.hung@bytedance.com>
	<20241213232958.2388301-2-amery.hung@bytedance.com>
	<65399ffd-da8a-436a-81fd-b5bd3e4b8a54@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Dec 2024 16:58:11 -0800 Martin KaFai Lau wrote:
> There is a conflict in the bpf-next/master. acquire_reference_state has been 
> refactored in commit 769b0f1c8214. From looking at the net/sched/sch_*.c 
> changes, they should not have conflict with the net-next/main. I would suggest 
> to rebase this set on bpf-next/master.

Let's worry about merging once it's ready. Previous version was 
5 months ago, the one before that 2 months earlier..

