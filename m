Return-Path: <bpf+bounces-21656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B607A84FF0C
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 22:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BF191F22296
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 21:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD571B7E9;
	Fri,  9 Feb 2024 21:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+2KEg6G"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7EF149DFA;
	Fri,  9 Feb 2024 21:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707514874; cv=none; b=R8rEgcOyxEbDRnHYcZeFcr2lLqODvGO3zs+rMQLzHjn3LjHhNAw+8pi1VpaNkf0jnMQlk+W+TnaSW6GVnBeS9Vbzj8+DyNgeHUwqTztlgXL01K+rwlTlYBSXCZqDrPdCrA7eEWAme1Eyl38U+7uiRtYn0gmZtX7exVFmf9SdzZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707514874; c=relaxed/simple;
	bh=tZosFHr8PqySTr1vT1GdQmj3Mjs87KTJSyGNLrRgLVk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NECZWS9HoBuaft07CVPD9AhcOFMVzkyxGX+WXWfxhFkS4gcIHT5ZW47U9pJVlV8vpfOmx7y4zNvhjJ7GZCtDOX/J2Z68ZGcKZr0i6J1RX4gW7Knzyn4oxs/NH+sKppaFlg6Pv4dDGAZdEWTBwoqI+sScvHWWe0JGLQ3BAHi+c0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+2KEg6G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A29ABC433C7;
	Fri,  9 Feb 2024 21:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707514874;
	bh=tZosFHr8PqySTr1vT1GdQmj3Mjs87KTJSyGNLrRgLVk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q+2KEg6Gv8Azh+UWCEMd0oRMkG+S1rsEZelQvAtkkhRzbqXTAhWJdfrPtGsHejdEx
	 8FK3BDV5d+am8zpHfjdQDByOrgsmZ3puXFK9/8UpoL2NLBkup3GHKyeq5Ak2YsBduF
	 VGBe5fDrkMbx3E/fF6tIBxR5MDrxMi83CpH+QMSYiNQ2OcRT7YUWEwLDeiePX6S6rF
	 vZ5SOAJ33G01z/d8qkEiE6jD7BXELoY4E2FCYFqUGfDcH2iam4Sk3KtgiFD8AaprXh
	 P+eAnthBzMVMrCltUvYZlVefEYmNmHKw0kwyi4O6gT43TRBcAgkUpK/6TaKAnDmilU
	 0sRs1CxmjSe8w==
Date: Fri, 9 Feb 2024 13:41:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org
 (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next v2] net/sched: actions report errors with
 extack
Message-ID: <20240209134112.4795eb19@kernel.org>
In-Reply-To: <20240209131119.6399c91b@hermes.local>
References: <20240205185537.216873-1-stephen@networkplumber.org>
	<20240208182731.682985dd@kernel.org>
	<20240209131119.6399c91b@hermes.local>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Feb 2024 13:11:19 -0800 Stephen Hemminger wrote:
> On Thu, 8 Feb 2024 18:27:31 -0800
> Jakub Kicinski <kuba@kernel.org> wrote:
> 
> > > -	if (!tb[TCA_ACT_BPF_PARMS])
> > > +	if (NL_REQ_ATTR_CHECK(extack, nla, tb, TCA_ACT_BPF_PARMS)) {
> > > +		NL_SET_ERR_MSG(extack, "Missing required attribute");    
> > 
> > Please fix the userspace to support missing attr parsing instead.  
> 
> I was just addressing the error handling. This keeps the same impact as
> before, i.e no userspace API change.

I mean that NL_REQ_ATTR_CHECK() should be more than enough by itself.
We have full TC specs in YAML now, we can hack up a script to generate
reverse parsing tables for iproute2 even if you don't want to go full
YNL.

