Return-Path: <bpf+bounces-72171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B062C0855A
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 01:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 492343AA66B
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 23:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574FA30E82D;
	Fri, 24 Oct 2025 23:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TydFgV/g"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CE42EF677;
	Fri, 24 Oct 2025 23:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761349262; cv=none; b=PUVnbDThQZkJJBZKyoYSm1xntstq4xNB5KCI1oKzRwcn9jsNh+Fjpa3Thl+KzHaU038tY4AqsC+jz0i95pGZywjHjz48XeQDpg4/k49bfz5gQdXgPTtl8MRfBzovFCSX2f5OeZlzsgOS7Hc2BwPPFkzsiiqGcJEwOEqMGQQf5Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761349262; c=relaxed/simple;
	bh=KlxQwxQiOyaOmfqlFrMqSOenDkOWYeInFu7SxGIC7qI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=X85AuDugdg+iziF+31SGsuoAY1xMb2pGlP5py0zrc2Q2Sy3EDYzJYbUSv1sU9arR1HkKoyg2ypihTHYSK8ST44AOqNoejg0Fy2K3x14sh4zb/xRZ5wdaYYNZyuNEI5u/te168Z3xR44bDyv30HFrjbdw+fcudFxWfPGrQgoIcsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TydFgV/g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38138C4CEF1;
	Fri, 24 Oct 2025 23:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761349262;
	bh=KlxQwxQiOyaOmfqlFrMqSOenDkOWYeInFu7SxGIC7qI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TydFgV/gIII94z/FdptMJSYONC4cW8imOoIfN7CaxVm6YLRgNhwJFcHWrNNZzsDPw
	 5AKQYdxai0u9wNhiCrGLWxgb3be6FdE9H7nxpJdXBWFTzuxUCp8M8fMuHgX6qqI1F4
	 w75YrKgNI6nr50pwXPliKf5dVtfueatD1J6fZsUEzBZnaphbvBbgr9qVOLqOR/7Pit
	 OB3Ta+O0oKXgdJalbhf36vXe4H4Hw1+Q6r//AM6bzaTg+maDBOTgpjn5WmrpkuwthQ
	 Ac2m7Gd6Qg43/DwedMeNMeRYz5nfR3rxTEgS4bezD95Ggv55ogoyhdgsFnfuzKD+eh
	 Sl4v1KQKyC/ew==
Date: Fri, 24 Oct 2025 13:41:01 -1000
Message-ID: <d2bc20b71d883574ca2a6a5fa4960548@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH sched_ext/for-6.19] sched_ext: Add ___compat suffix to scx_bpf_dsq_insert___v2 in compat.bpf.h
In-Reply-To: <6c9852055cae7d54ce33df77c5c7a1dc@kernel.org>
References: <6c9852055cae7d54ce33df77c5c7a1dc@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Applied to sched_ext/for-6.19.

Thanks.
--
tejun

