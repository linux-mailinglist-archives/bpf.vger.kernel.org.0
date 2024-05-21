Return-Path: <bpf+bounces-30133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 596828CB248
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 18:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14005282C20
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 16:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F151448CD;
	Tue, 21 May 2024 16:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSnDxMBv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EB317556;
	Tue, 21 May 2024 16:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716309343; cv=none; b=WturC9cT0KHHwLtlK3h311sv13E4PLUxXpaYQtwF2lXl5wxydbYxaD00d5bL3EUnXM5jUwVxNdQv8YK9nV+m3mCVCHNwSuyv9i35Ptfs3JDiHMhhKcF5Ps7bNxh/zjZknHKlyToPjeMcATE6qxR7mbxxuqzZvDk2lxEBrMklcIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716309343; c=relaxed/simple;
	bh=flYhV7d20dQSVWKKG9xe6WN4b57IFP0PEYtYsZvhEgI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TdeJ6eJqRIG2wKSZWLJctcfPWASXSr3cO29sHfWic51GwnWOJ6OCN6WM/7qHfVnnvfoEilLoxjYLX3GnPzIE9CN2tk3YKrKtkdXMD2gw8OgJTpUcvaEDMYRSvPckYAE3EfznH5cVPdFGn9+OtnBIBUP7VJc6grXG2IrWs/lXyNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSnDxMBv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA2AC2BD11;
	Tue, 21 May 2024 16:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716309342;
	bh=flYhV7d20dQSVWKKG9xe6WN4b57IFP0PEYtYsZvhEgI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=OSnDxMBvwuZmzw1tj9S4tW3PKxmd2QDDX5Hs9M+GREWOOeCuYO8A2o5lxdeMgcrBP
	 HgpjrRpH2Fv2a9TgqbPZcKVK4ubavEPLcA2O0fHaLwzzIt6FohK6rbPtUmFiHRzZQ+
	 usIGPMVbj6Qg/P/fxj5GiHm/xqj0oa1XGLBu6bxhuTELspa5Cg+ZXtgLVzXogmv2el
	 5ohMQn2jiBrQTrk3P3s+/iX30+ZHyw+rFS3LLuM17nzzD+reEO+uUyW9rI6Mps3R/r
	 nqtw9VqHOkG5XbMGosKQIYPtq3aKMxk4wwsKQwQxE7YyNLyD2lvSD+2MlDm6L+yrVk
	 O4wvpONO9IlYw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Xiao Wang <xiao.w.wang@intel.com>, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, luke.r.nels@gmail.com,
 xi.wang@gmail.com
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, pulehui@huawei.com, haicheng.li@intel.com, Xiao Wang
 <xiao.w.wang@intel.com>
Subject: Re: [PATCH] riscv, bpf: try RVC for reg move within BPF_CMPXCHG JIT
In-Reply-To: <20240519050507.2217791-1-xiao.w.wang@intel.com>
References: <20240519050507.2217791-1-xiao.w.wang@intel.com>
Date: Tue, 21 May 2024 18:35:39 +0200
Message-ID: <87a5kjdsx0.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Xiao Wang <xiao.w.wang@intel.com> writes:

> We could try to emit compressed insn for reg move operation during CMPXCHG
> JIT, the instruction compression has no impact on the jump offsets of
> following forward and backward jump instructions.

...and at some point we should start supporting Zacas and friends,
instead of lr/sc.

> Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

