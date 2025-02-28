Return-Path: <bpf+bounces-52916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CF2A4A57A
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 22:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 696223B072C
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 21:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E738E1DE2BD;
	Fri, 28 Feb 2025 21:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Djk+M3Ax"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9111C5485;
	Fri, 28 Feb 2025 21:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740779845; cv=none; b=DLnypTcHR8Ork1qmc9uDtG4CnAP8nmYRoedbpYAOVkURFkdfajp5aouvT/JxMg8pJ8QhHj0aIqMPa0yBnelg1zNOrIlm4UHLM/fI/byRzh1VnRNEhTyOxdo+CANTUrEoVs/5S/gPIej0mOq28LBCFgE5L6dSaZvJUgJ1eq/xktg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740779845; c=relaxed/simple;
	bh=vVTbgz3sU0uIuIpCnKhBNOSk9EPccYqcn8OQZhiUA20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZfZ3UfQcua17vQ1lGRuZ3rnuz6KByRmXnT2CsS0e746ueyNqaYnUWrsWn1b/f2ERpLUdulrKJFRgK2JIHW/IWf5TodrZMtUlh50V0UPfz49gNAKqBmZkFnn7+VzrflnH9pWRf8/j96lYnpOV2ZH31MVxLeL8RIli/YlZuEYtYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Djk+M3Ax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8829C4CED6;
	Fri, 28 Feb 2025 21:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740779844;
	bh=vVTbgz3sU0uIuIpCnKhBNOSk9EPccYqcn8OQZhiUA20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Djk+M3Ax1/3J9Mudq+jFGt1id79yWLLZacAKvd4Ur45/XjyR0DZOycPS9TYO/UBOq
	 2oed7ejTLDMsXyrmjgOxME+lJJQXEvfaEzGKfbXcrttLvYOLF0LCVDnNai4E3wIGZt
	 VosXOX5Ux8iqxPCw4bwzqR6vSORRuqZ132b2T/hb0rwLFPQTzaBGHntn1qt0varbnC
	 Wwv4YI9mcVwSV+Iu4D19cJfo/Fd/WmyIJUAWJi9ae4dbkylmPOIX6Q5cXCTQYTfPc+
	 6yzB6E+QFS0CR58g7xPbeJfgNPrVanJkIlmeki446mqmJSwIqLvbiK8cASax7B+Si4
	 CckWsKDMsIKiA==
Date: Fri, 28 Feb 2025 11:57:23 -1000
From: Tejun Heo <tj@kernel.org>
To: Juntong Deng <juntong.deng@outlook.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
	memxor@gmail.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.15 v3 2/5] sched_ext: Declare
 context-sensitive kfunc groups that can be used by different SCX operations
Message-ID: <Z8IxQy9bvanaiFq6@slm.duckdns.org>
References: <AM6PR03MB50806070E3D56208DDB8131699C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB508018ABBD34FBAA089DD9F799C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR03MB508018ABBD34FBAA089DD9F799C22@AM6PR03MB5080.eurprd03.prod.outlook.com>

On Wed, Feb 26, 2025 at 07:28:17PM +0000, Juntong Deng wrote:
> This patch declare context-sensitive kfunc groups that can be used by
> different SCX operations.
> 
> In SCX, some kfuncs are context-sensitive and can only be used in
> specific SCX operations.
> 
> Currently context-sensitive kfuncs can be grouped into UNLOCKED,
> CPU_RELEASE, DISPATCH, ENQUEUE, SELECT_CPU.
> 
> In this patch enum scx_ops_kf_flags was added to represent these groups,
> which is based on scx_kf_mask.
> 
> SCX_OPS_KF_ANY is a special value that indicates kfuncs can be used in
> any context.
> 
> scx_ops_context_flags is used to declare the groups of kfuncs that can
> be used by each SCX operation. An SCX operation can use multiple groups
> of kfuncs.
> 

Can you merge this into the next patch? I don't think separating this out
helps with reviewing.

Thanks.

-- 
tejun

