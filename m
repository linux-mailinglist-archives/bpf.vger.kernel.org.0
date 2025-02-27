Return-Path: <bpf+bounces-52808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D39A48A8B
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 22:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C82A1188D1A8
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 21:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358A3271293;
	Thu, 27 Feb 2025 21:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MS1E0vi3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9D0270ED1;
	Thu, 27 Feb 2025 21:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740691959; cv=none; b=gvdYXKbizTuoOScGjiiqxFPBqygIRWjB6tGjGCVrcFxTVbBTgH87P9fiXDqQBN+31TQfJtNfTFOUUgGodePeYzygvXmh61no4avb4mNQUAEtETxtIp4M5LdLEMXbZvFEWLb8X64WHhYEEWw0NzOsT8R8p5NL69bz0uMLATwauJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740691959; c=relaxed/simple;
	bh=24dA6Z2ZK6UhZS4DruOECgGiZ8UxuXiS2+MwHPNxGB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPpTqtVElOQPjDoQIfISi8sVY55YwehCX5r4XMHPAMjUNVpzzu+K6o4wyr/WgwuzWkbbUXVjZNt0dsXSDmO39CDousDXLOOHxKHR3oBFFfoHvKRZMvzCng4r+AymNI2OW8m6c5TTmCYfit7hicVhqgdM4tSGsYL78L0cQCpl6Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MS1E0vi3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20DC7C4CEE5;
	Thu, 27 Feb 2025 21:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740691959;
	bh=24dA6Z2ZK6UhZS4DruOECgGiZ8UxuXiS2+MwHPNxGB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MS1E0vi3vYTLU2IYnbwqG44LtcXSoG2QJorBuZ54riv33Z5s7glAEoZdcbL3FNZux
	 mMQpvvgBZiSuCekNQA0wOwL5FQdFezjSykm71ILSblU1rWgljD1W6qEvpI1YLAtAmN
	 j7XnayG3ZTLVTpPbWmko9T2OWJ2awoBHhuNBws6Fe81pLyh4NqBZey2fsfW4i15u3P
	 oXHMIyrun4sJKPoYL3vwPRAx72F0jXvG0HlW0in1gOG2kd042P/nxswSrPU7P/sv7d
	 DFCLyyXauMrV0z0JLAecMw03SZyKk0Qmf/VLCFXiwbWPP0fLDOBQvVPVbgcAwUw8lR
	 mt9AD0e7qsZDQ==
Date: Thu, 27 Feb 2025 11:32:38 -1000
From: Tejun Heo <tj@kernel.org>
To: Juntong Deng <juntong.deng@outlook.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
	memxor@gmail.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.15 v3 3/5] sched_ext: Add
 scx_kfunc_ids_ops_context_sensitive for unified filtering of
 context-sensitive SCX kfuncs
Message-ID: <Z8DZ9pqlWim8EIwk@slm.duckdns.org>
References: <AM6PR03MB50806070E3D56208DDB8131699C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080648369E8A4508220133E99C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <Z8DKSgzZB5HZgYN8@slm.duckdns.org>
 <AM6PR03MB5080C1F0E0F10BCE67101F6F99CD2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR03MB5080C1F0E0F10BCE67101F6F99CD2@AM6PR03MB5080.eurprd03.prod.outlook.com>

Hello,

On Thu, Feb 27, 2025 at 09:23:20PM +0000, Juntong Deng wrote:
> > > +	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS &&
> > > +	    prog->aux->st_ops != &bpf_sched_ext_ops)
> > > +		return 0;
> > 
> > Why can't other struct_ops progs call scx_kfunc_ids_unlocked kfuncs?
> > 
> 
> Return 0 means allowed. So kfuncs in scx_kfunc_ids_unlocked can be
> called by other struct_ops programs.

Hmm... would that mean a non-sched_ext bpf prog would be able to call e.g.
scx_bpf_dsq_insert()?

> > > +	/* prog->type == BPF_PROG_TYPE_STRUCT_OPS && prog->aux->st_ops == &bpf_sched_ext_ops*/
> > > +
> > > +	moff = prog->aux->attach_st_ops_member_off;
> > > +	flags = scx_ops_context_flags[SCX_MOFF_IDX(moff)];
> > > +
> > > +	if ((flags & SCX_OPS_KF_UNLOCKED) &&
> > > +	    btf_id_set8_contains(&scx_kfunc_ids_unlocked, kfunc_id))
> > > +		return 0;
> > 
> > Wouldn't this disallow e.g. ops.dispatch() from calling scx_dsq_move()?
> > 
> 
> No, because
> 
> > > [SCX_OP_IDX(dispatch)] = SCX_OPS_KF_DISPATCH | SCX_OPS_KF_ENQUEUE,
> 
> Therefore, kfuncs (scx_bpf_dsq_move_*) in scx_kfunc_ids_dispatch can be
> called in the dispatch context.

I see, scx_dsq_move_*() are in both groups, so it should be fine. I'm not
fully sure the groupings are the actually implemented filtering are in sync.
They are intended to be but the grouping didn't really matter in the
previous implementation. So, they need to be carefully audited.

> > Have you tested that the before and after behaviors match?
> 
> I tested the programs in tools/testing/selftests/sched_ext and
> tools/sched_ext and all worked fine.
> 
> If there are other cases that are not covered, we may need to add new
> test cases.

Right, the coverage there isn't perfect. Testing all conditions would be too
much but it'd be nice to have a test case which at least confirms that all
allowed cases verify successfully.

Thanks.

-- 
tejun

