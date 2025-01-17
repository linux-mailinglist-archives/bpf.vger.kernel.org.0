Return-Path: <bpf+bounces-49210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C13B0A15517
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 17:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F4893A3E7A
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 16:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D6C19F438;
	Fri, 17 Jan 2025 16:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKDVEkW+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A71166F29;
	Fri, 17 Jan 2025 16:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737133115; cv=none; b=S/Xf8moXquah2ORAjh5YTTo/iS5ioLhjzxqQAtPMKDD5bDnXc4wQbFrF8ATtF9iH6SYNG0RfbMHG2FMJ4Y4lrVh2DB3fpgPDk7cY3OoWjUWz70XDaycXvjwHyEzHfylIpJW05BBf0SGjG8Ab2HwdiOixZtO74nN+XScG1oKdpxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737133115; c=relaxed/simple;
	bh=E6RLSQiOcLtTwpGCumG8db8wYaPfC7fYZNgk3j3NeW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=peX8Apy8YOHsoEZXkmWSXJmjes/zBszAYAlL1rvb81RGdgwxQ2mh6fQP72j88p8Uf2o0lEomspFmQsVtEZ7xefSSobx67f0ns7IgF6XILjmulgjr5T0MOou3VtGTUQ0iyeEv1Ay60sfvrcHnaQX+1JG9uHR9uMytUdPq+5QlSuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKDVEkW+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BD6C4CEDD;
	Fri, 17 Jan 2025 16:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737133114;
	bh=E6RLSQiOcLtTwpGCumG8db8wYaPfC7fYZNgk3j3NeW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JKDVEkW+AM7a3VJP7XDwmaCJcaOjDkEJ+7OciRqOigKYMVThoqNv73Te2J1sQ0EHD
	 z0EEuJe6BdFszoLs7PjdJ0zOovfoW+IWGOjvxN2xs5O5Rde/MnOIWDL3KOjdNznO5m
	 2aRGwvMVqUtRHD+KoGJgZ44aZzbbjZGp2X3Z6VO3znd1DJeiBRzACyVyINzcBbSiLt
	 KZZPd9xKQpEe4D6RWbVAAHO+Q9rZSi/qEOE/sssUGNjZ+Zh0VYMWYMYAGImrfshVNY
	 YiJMuQ3kte/AUbS+D3iDOBrvMf93qPc2wr8uafvI+3c664xCQdxikzDLZAG67iwp4u
	 df4lfn9rynOeg==
Date: Fri, 17 Jan 2025 06:58:33 -1000
From: Tejun Heo <tj@kernel.org>
To: Juntong Deng <juntong.deng@outlook.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
	memxor@gmail.com, void@manifault.com, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 6/7] sched_ext: Make SCX use BPF capabilities
Message-ID: <Z4qMOUq1KXTX-5cD@slm.duckdns.org>
References: <AM6PR03MB5080C05323552276324C4B4C991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB50802A825536C00D2B53333C991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR03MB50802A825536C00D2B53333C991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>

Hello,

On Thu, Jan 16, 2025 at 07:41:11PM +0000, Juntong Deng wrote:
...
> +static int bpf_scx_bpf_capabilities_adjust(unsigned long *bpf_capabilities,
> +					   u32 context_info, bool enter)
> +{
> +	if (enter) {
> +		switch (context_info) {
> +		case offsetof(struct sched_ext_ops, select_cpu):
> +			ENABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_SCX_KF_SELECT_CPU);
> +			ENABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_SCX_KF_ENQUEUE);
> +			break;
...
> +		}
> +	} else {
> +		switch (context_info) {
> +		case offsetof(struct sched_ext_ops, select_cpu):
> +			DISABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_SCX_KF_SELECT_CPU);
> +			DISABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_SCX_KF_ENQUEUE);
> +			break;
...
> +	}
> +	return 0;
> +}

From sched_ext's POV, this, or whatever works is fine but I have some basic
comments:

- The caps are u32. If all kfuncs use this facility for access control, it's
  plausible or even likely that 32 is not going to be enough. I suppose it
  can be turned into u64 and then a proper bitmap later? Maybe good idea to
  start out with a proper bitmap in the first place?

- There are benefits to centralizing all the caps in a single place but it
  can also be kinda cumbersome.

- Even with global defs, the cap adjustments are procedural, not
  declarative. If it needs to be procedural anyway, I wonder whether the
  global defs are necessary in the first place. What prevents implementing
  it the other way around - pass in the calling context and provide helpers
  and macros to respond yay or nay procedurally.

Thanks.

-- 
tejun

