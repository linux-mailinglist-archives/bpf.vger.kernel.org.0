Return-Path: <bpf+bounces-65371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBF9B213B6
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 19:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1593A4788
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 17:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9785C2D4B40;
	Mon, 11 Aug 2025 17:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adziF4GV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2722D47EF
	for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 17:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754934765; cv=none; b=HzcZjKWW933272Lu/dm5nGBAeVTM243eC0dzid6+rglDlx1l6Dp4CQ21b8ao1SNDUOh0MnnGuYrw0lu0I5OVFmq0EsUicxngII/h154UqOg9uZLs9DsMIDB+VliMkL5pQVvg6mLRlWRg6zY0rxR6Ju1cF81gjgGAF8XqFK0ZFz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754934765; c=relaxed/simple;
	bh=yBLBMLW6+l27DOoMFsKKpjIE/tDJSobklk7EOGKkgsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1ndzuiOgg/34i7ig0iU2r0zynmV/SYSKUrxw+iamOVJRYsuXKKY3idUqitCpOBiUz6C00J9eRXCfxp4n4DxV3PJnevcSXkqE+ggGpOXMywWLEdLXIh07IgvlAebuNR6Ffv3aJImWKi7nqSNy27n3oq9yP6hJsdhmSqQL96cGkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adziF4GV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164A3C4CEED;
	Mon, 11 Aug 2025 17:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754934765;
	bh=yBLBMLW6+l27DOoMFsKKpjIE/tDJSobklk7EOGKkgsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=adziF4GV0bTcVueq8pDGX1TnqpWhK9fHuq2WXGVvEq6KhoAgPtlVjMgeJ1zRgmV4d
	 N8k44YTsucPuCNtg6sQbHll2+5Cl7yg4CLDcH+95Kr8CVVdSS1pnUq697GsJjeIHxb
	 lxHtyOsJJtmsidWFhTKZYXIZIZEOGya1FbwWyP5da+qMfXFcA1iev3k5nztTi3WjCp
	 Yk+fjY0eoLYNe6bkEE0/NGkeg88ptYcQ/9Vvz9PDFpVBCRR5uylVsWwy487vS+3s+p
	 q5gWU/HI08C7KonemJ+o6w814oO7Ka5JQZ8i6Qse8k8fE4n5wzBiR5gI8xsWgfzMWM
	 KCFvD0nA6KpTQ==
Date: Mon, 11 Aug 2025 07:52:44 -1000
From: Tejun Heo <tj@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Dan Schatzberg <dschatzberg@meta.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Do not limit bpf_cgroup_from_id to
 current's namespace
Message-ID: <aJot7CDxQvULurvK@slm.duckdns.org>
References: <20250811175045.1055202-1-memxor@gmail.com>
 <20250811175045.1055202-2-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811175045.1055202-2-memxor@gmail.com>

On Mon, Aug 11, 2025 at 10:50:44AM -0700, Kumar Kartikeya Dwivedi wrote:
> The bpf_cgroup_from_id kfunc relies on cgroup_get_from_id to obtain the
> cgroup corresponding to a given cgroup ID. This helper can be called in
> a lot of contexts where the current thread can be random. A recent
> example was its use in sched_ext's ops.tick(), to obtain the root cgroup
> pointer. Since the current task can be whatever random user space task
> preempted by the timer tick, this makes the behavior of the helper
> unreliable.
> 
> Resolve this by refactoring cgroup_get_from_id to take a parameter to
> elide the cgroup_is_descendant check when root_cgns parameter is set to
> true.
> 
> There is no compatibility breakage here, since changing the namespace
> against which the lookup is being done to the root cgroup namespace only
> permits a wider set of lookups to succeed now. The cgroup IDs across
> namespaces are globally unique, and thus don't need to be retranslated.
> 
> Reported-by: Dan Schatzberg <dschatzberg@meta.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

