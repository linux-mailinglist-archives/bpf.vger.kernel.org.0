Return-Path: <bpf+bounces-72515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD6CC141BC
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 11:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81DC21983213
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 10:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCA220DD72;
	Tue, 28 Oct 2025 10:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIz761tk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A5A30595D;
	Tue, 28 Oct 2025 10:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761647414; cv=none; b=FPUkwduTwA+RzvoCWKUxcI4rAPpqTFg7O0cncIJZkypM8VNylO0cm7NO15rGCdgMMRDomWZ6fk0VErf74uxNsjzTuRL2hcN4Mp8p+Zlbqi2rtni9muxLkPuxX01+wEl1Y7IK25UCleUxKQQzDw2AkVGmxxF2GqMX+Dsv2CXImWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761647414; c=relaxed/simple;
	bh=i1oPG+ZRf9OGbhOOSsSjORFIrBtTLS/S2tOyv4Wk8Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1bBpUfaFBJIrB9vqUuhBZ59tj1Vz+gGcJsXqfB6i8PFGTVV9LqgvF7Qwb/Ljo/sKLBmMPZObjZtmmfMFVtMgO22MMwaQ/wAfI4bDBi7uOSZpRps0DCQ9MkPQk8AWl1ogRQerHAFcd1afAepGb8lw7+PtJlgF+VG3WR+Tzv0dcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIz761tk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3943BC4CEE7;
	Tue, 28 Oct 2025 10:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761647413;
	bh=i1oPG+ZRf9OGbhOOSsSjORFIrBtTLS/S2tOyv4Wk8Uo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aIz761tkfMijGB9dzdh0STq9BQJHU88Zo9UFP6+HR5Xd8nnP5rNt1c0YecS8UUc76
	 /vBdjapAWJbyYr+ekyE2DL1r43K0mC/5MspG+YVXW4LLo17/mr2qrahIEM6KgS2Zo6
	 kWGgBMeTlRsUFiqaEIaUkXxUvFcH8CVOC0m76yRFtNriBD0qIxda9ohFQqVRU9C5Uu
	 WqCISo1yRBGqCnft3OK+/XYzYNrGYqDgF+Rh0YwqkBCrbI6P2XbQDWc15IXmPbHlW4
	 ltqWOPcOWLIxBN/gxwRe+fYKVy0ofU1yoLWInHC3iFcsGoUBtvBQfs2xiq7H6Tp7k8
	 wLpzcIbGGY3jA==
Date: Tue, 28 Oct 2025 10:30:06 +0000
From: Simon Horman <horms@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>, Jann Horn <jannh@google.com>,
	Mike Yuan <me@yhndnzj.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Amir Goldstein <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	bpf@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 11/70] ns: add active reference count
Message-ID: <aQCbLrYf_KTdxZjU@horms.kernel.org>
References: <20251024-work-namespace-nstree-listns-v3-0-b6241981b72b@kernel.org>
 <20251024-work-namespace-nstree-listns-v3-11-b6241981b72b@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024-work-namespace-nstree-listns-v3-11-b6241981b72b@kernel.org>

On Fri, Oct 24, 2025 at 12:52:40PM +0200, Christian Brauner wrote:

...

> diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c

...

> +void get_cred_namespaces(struct task_struct *tsk)
> +{
> +	ns_ref_active_get(tsk->real_cred->user_ns);

Hi Christian,

real_cred is protected by RCU, but this code doesn't seem to take
that into account. Or, at least Sparse doesn't think so:

.../nsproxy.c:264:9: error: no generic selection for 'struct user_namespace *const [noderef] __rcu user_ns'
.../nsproxy.c:264:9: warning: dereference of noderef expression

> +}
> +
> +void exit_cred_namespaces(struct task_struct *tsk)
> +{
> +	ns_ref_active_put(tsk->real_cred->user_ns);

Likewise here.

> +}
> +
>  int exec_task_namespaces(void)
>  {
>  	struct task_struct *tsk = current;

...

