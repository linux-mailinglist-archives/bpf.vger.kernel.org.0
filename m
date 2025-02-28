Return-Path: <bpf+bounces-52912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E009A4A4E2
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 22:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFCD33ACDA4
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 21:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212751D61B9;
	Fri, 28 Feb 2025 21:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWhDUuqo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF9A23F370;
	Fri, 28 Feb 2025 21:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740777635; cv=none; b=R3PfLcg51KH6aUnRBeqZqv/u6fvRX+FR4eHmao9UARvK83hH/lX5fVeZM8pbhuaqxUiR8vpz9vhwqquWozbMSTp09KaUGhhIxjy/otYZx/0tD4/rXAxOcX+nvuYdVNljkXPYgBWfFbzI41iHkGjM8/oHjhJEngkL6cde46MN+tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740777635; c=relaxed/simple;
	bh=P0ru37JNMe6dN4+s2qJbaK6K1dwKm7xiOyUPTBerSKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gu4+pmqXSnZXXZkh88a/Kio7+5kpn8OAbaR4LQuI7dgHXPMV1+5h//9roqpXB3Hl+cmguwA3E3e0Oc5jafaKyjAzfI0r5FbLMeD3pyyf+wYHk/xf+y9914Oj2YsskdV6mW8tWIrjVqHHlIIetDCB2R1mI0rLHxztoxKZfQkn+XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWhDUuqo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED0BC4CED6;
	Fri, 28 Feb 2025 21:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740777635;
	bh=P0ru37JNMe6dN4+s2qJbaK6K1dwKm7xiOyUPTBerSKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gWhDUuqoGfnoDBJKwRdfuGnHpGrRfINZSxzpD9oaeNwhpl0SJrSNMx/rakIEcC0K4
	 jr0jaMyOTcsaM6xGODYKWvT1iogMkZNhdFFcvKq2k64f0Dld7l8C4reHK5blgiXl50
	 iEsEqmipCD8VDVGEQKpDLTx7+wnu5+sBIEuuM3mN8r5ifE2IDR2AuxOeSxq3Ogxi9y
	 wmIzuNpMiYbpEToJjWRZ20ePwrN919FwcEkF5VeczVu6rK0GU7Dlncz3DpM8DAy3El
	 fNrtXwqAm62eFyji2cp8Y2tprWrqe0dxaM+rrHGXl+65WOwpI0PicoYRet5UKBEvSP
	 tc6zWh3KJw2PQ==
Date: Fri, 28 Feb 2025 11:20:33 -1000
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
Message-ID: <Z8Ioof577rvSJxrD@slm.duckdns.org>
References: <AM6PR03MB50806070E3D56208DDB8131699C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080648369E8A4508220133E99C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <Z8DKSgzZB5HZgYN8@slm.duckdns.org>
 <AM6PR03MB5080C1F0E0F10BCE67101F6F99CD2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <Z8DZ9pqlWim8EIwk@slm.duckdns.org>
 <AM6PR03MB50809C9EB32C9705DF6EA14299CC2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR03MB50809C9EB32C9705DF6EA14299CC2@AM6PR03MB5080.eurprd03.prod.outlook.com>

Hello,

On Fri, Feb 28, 2025 at 06:42:11PM +0000, Juntong Deng wrote:
> > > Return 0 means allowed. So kfuncs in scx_kfunc_ids_unlocked can be
> > > called by other struct_ops programs.
> > 
> > Hmm... would that mean a non-sched_ext bpf prog would be able to call e.g.
> > scx_bpf_dsq_insert()?
> 
> For other struct_ops programs, yes, in the current logic,
> when prog->aux->st_ops != &bpf_sched_ext_ops, all calls are allowed.
> 
> This may seem a bit weird, but the reason I did it is that in other
> struct_ops programs, the meaning of member_off changes, so the logic
> that follows makes no sense at all.
> 
> Of course, we can change this, and ideally there would be some groupings
> (kfunc id set) that declare which kfunc can be called by other
> struct_ops programs and which cannot.

Other than any and unlocked, I don't think other bpf struct ops should be
able to call SCX kfuncs. They all assume rq lock to be held which wouldn't
be true for other struct_ops after all.

...
> > I see, scx_dsq_move_*() are in both groups, so it should be fine. I'm not
> > fully sure the groupings are the actually implemented filtering are in sync.
> > They are intended to be but the grouping didn't really matter in the
> > previous implementation. So, they need to be carefully audited.
> 
> After you audit the current groupings of scx kfuncs, please tell me how
> you would like to change the current groupings.

Yeah, I'll go over them but after all, we need to ensure that the behavior
currently implemented by scx_kf_allowed*() matches what the new code does,
so I'd appreciate if you can go over with that in mind too. This is kinda
confusing so we can definitely use more eyes.

> > Right, the coverage there isn't perfect. Testing all conditions would be too
> > much but it'd be nice to have a test case which at least confirms that all
> > allowed cases verify successfully.
> 
> Yes, we can add a simple test case for each operation that is not
> SCX_OPS_KF_ANY.

That'd be great. Thanks.

-- 
tejun

