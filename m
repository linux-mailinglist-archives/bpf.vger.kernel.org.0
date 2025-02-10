Return-Path: <bpf+bounces-51033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4EAA2F663
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 19:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536C7164ACD
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 18:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF5324FBFB;
	Mon, 10 Feb 2025 18:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nds5FPrS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816E724394C;
	Mon, 10 Feb 2025 18:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739210738; cv=none; b=giC+51fF1HyfJ1sliU4lppGCarkK9W3iMYgZkuaHCvOD0FF0Xn+7E+9We6UhfGHtiQu6robW3OeVt2LeNZt65Y8sKADiEc6Hc9WEA1rCdv4IWam5ShrQjmz0IXkmBKsOlLqTkASxu/0C/Mg13mbQF3RqIZQpNGgfghs8I6R0ml4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739210738; c=relaxed/simple;
	bh=gKqOI5mTr/+VKM2KvsJmNow4kvUk3+sqnmn0AVa5zOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jX1xWqqEubzjtr+sZLLvzk232FRgxW1FNtPuQSVSWMYkcVI6zaNISribFAQU4MlJhkC12TtzdZI7IxdpTpLpK9GGZJTMBOp6AReBLLO+0Zy+tk/xk3YMZD+u4HJBRqrpHM07vJRZbB4/BAK6/1ATfK0DGSiONXbheg5nAbQ2Bng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nds5FPrS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7CE2C4CED1;
	Mon, 10 Feb 2025 18:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739210738;
	bh=gKqOI5mTr/+VKM2KvsJmNow4kvUk3+sqnmn0AVa5zOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nds5FPrSvJhNoWa3lrkYM983ShEvvh5kiCdvQujcfYAHUjrBnhFXhrINtiNMdMiZI
	 R8GthZfqgjt4S686bKv0b3Ui+LnIW3o5sa2ZdLltobBlxQYjOQJGGg3HOi3bHr/UAa
	 FDua/kBszgHeqSp6BejHqEuWm4U4x0PKYOP9FHQafQTKPsVqCLEtkTInYO3SXnaqEe
	 GrCGAdHty84obkABKnlJ4AhtnJB7g9UKkMX3HgzKkXnk3fYhqOGFav60h9wZnlyVZV
	 lk+VPGlo/3Gqw65QYv2EOxCapIkSZfaU7zXJDoJbMdUYHjM7Mq6HFHedBsLH0365LD
	 wYSN/p/pbJ3IA==
Date: Mon, 10 Feb 2025 08:05:36 -1000
From: Tejun Heo <tj@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Juntong Deng <juntong.deng@outlook.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	changwoo@igalia.com, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH bpf-next 6/8] sched_ext: Add filter for
 scx_kfunc_ids_unlocked
Message-ID: <Z6o_8OD33jFoggIZ@slm.duckdns.org>
References: <AM6PR03MB5080261D024B49D26F3FFF0099F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080EDA5E2E2FDB96C98F72F99F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQJZnNj3KGcy-MKz_F2KEiKWGpXchxVx1zuGA-5g3SO=HQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJZnNj3KGcy-MKz_F2KEiKWGpXchxVx1zuGA-5g3SO=HQ@mail.gmail.com>

Hello,

On Fri, Feb 07, 2025 at 07:37:51PM -0800, Alexei Starovoitov wrote:
> Can they all be rolled into one id_set then
> the patches 2-6 will be collapsed into one patch and
> one filter callback that will describe allowed hook/kfunc combinations?

I thought the BPF side filtering may be declarative on the kfunc sets and
tried to group the sets by where they can be called from. As we're going
prodcedural, there's no point in separating out the sets and we can use
merged kfunc sets and do all the distinctions in the filter function.

Thanks.

-- 
tejun

