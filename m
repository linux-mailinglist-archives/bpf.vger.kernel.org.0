Return-Path: <bpf+bounces-43609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5F99B705D
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 00:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D0B71F21820
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 23:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614A5215034;
	Wed, 30 Oct 2024 23:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ow8GXlbH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90D21E378D
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 23:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730330093; cv=none; b=FvZGb4yAOAvHklSRtsEj19EtUUcnvTdFibZez4b8lwE1Pni626fVDotqhGPYN7FOaa7w8np1FNO8YMnbVBxMd4A6Pw78E3iJJoj7j27BAQnDnVBrjAbTn2uWmPWunzdtOxMAp4rlIgYQkdez7kGtm57Ymbp6Z2wysf15uzcUIc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730330093; c=relaxed/simple;
	bh=JDbX1Flj8wPZLpIhhFjNuGcJZ1lDvQaSiLchnKzAPb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQXrEAjdC/LXAwYoCd8gEYwueiJSfkanCp9BKuwH9wwq/skjZ/GvfYz3uteXYNm+9wvTXfZZzxTYRxXO4lplpzCV4D2t3KdIK77+nptmEq6mXTRsRwZxSwqna7WLIJwogW7n+C6/oi9uqPRhB6oOmdxrNtsT1kmMyYGYDmAceUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ow8GXlbH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91255C4CECF;
	Wed, 30 Oct 2024 23:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730330093;
	bh=JDbX1Flj8wPZLpIhhFjNuGcJZ1lDvQaSiLchnKzAPb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ow8GXlbHkLnHYqO1sEM5uYvqSr49dLqmBSgV7OJWHYrxZrQ9/luAoOPI1kQBqKJrw
	 zy88+JNnuTwz0nqI5D8CPS4dhFFOTLKXf++JAcMwFRkDPdA2XPwB/rOmDRyBZOla6M
	 12P7Rrs+caAVKyimkoMZtFipZ8PO2YoAmOxUiBp4Qcna9OHazR2NxmoqwwNzll1N3b
	 9RUz7I2bjB2gR+Np34Slq7teg9HIA0fQdpVNwPDDhLVP7cu59/RMC96HOmb9UEDfqM
	 cz+U1bwjc6PSPCb4XMI4UuiEDbBUwlPczolxa0uvpfdwWEWH8+Gpgb28pYhDf3ioqi
	 Wwg33HmEBl64g==
Date: Wed, 30 Oct 2024 13:14:52 -1000
From: Tejun Heo <tj@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v7 8/9] bpf: Support private stack for
 struct_ops progs
Message-ID: <ZyK97MokcVLgoFrQ@slm.duckdns.org>
References: <20241029221637.264348-1-yonghong.song@linux.dev>
 <20241029221718.268017-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029221718.268017-1-yonghong.song@linux.dev>

Hello,

On Tue, Oct 29, 2024 at 03:17:18PM -0700, Yonghong Song wrote:
> For struct_ops progs, whether a particular prog will use private stack
> or not (prog->aux->use_priv_stack) will be set before actual insn-level
> verification for that prog. One particular implementation is to
> piggyback on struct_ops->check_member(). The next patch will have an
> example for this. The struct_ops->check_member() will set
> prog->aux->use_priv_stack to be true which enables private stack
> usage with ignoring BPF_PRIV_STACK_MIN_SIZE limit.
> 
> If use_priv_stack is true for a particular struct_ops prog, bpf
> trampoline will need to do recursion checks (one level at this point)
> to avoid stack overwrite.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

From sched_ext usage POV:

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

