Return-Path: <bpf+bounces-52084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E66A3DD96
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 16:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE45217B737
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 15:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8531D61A3;
	Thu, 20 Feb 2025 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="G1mAi/io"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF1341C7F;
	Thu, 20 Feb 2025 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063619; cv=none; b=LJGLcCtaG0EtLQr90h7zHWFbsrEdV8ocVgjAyhUyRsmDTvbFxdlMdtSvw1OjmuJ7Vg7gOUKHfVFMBqU1BYNGld3S/C6+utOIusHr3OxlJSZ0CPm2YWdiLSygcH+UWR+JyDthjlDQlV5pj88pCMiUhHv58fmpxU/+xA5j5Q8ubYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063619; c=relaxed/simple;
	bh=5Rg9aQx5SAJd2GvpGKDyvHWzOMlS7BIa+3iz31itNHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Paw1XYfNJ+zAzrabwLIjt4fD1ubsS3L8u0Zh0XcLzuRttMEcedEqtZU3aMBijjHtkmfhp9nPDHq9pX25CQrw75nbD8/xJcs+VnoDSWCak1kPtO6FyvM4CGFJYgLwEfK0YXMEk5r6mhY0Pi/Em8vSItNLPJGZHfI+stcX3fiSRd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=G1mAi/io; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4YzGdd6FJpz9t1r;
	Thu, 20 Feb 2025 16:00:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1740063606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zQv/p8LzF7Z9WyGzYQQMo/D3FUK2j9qiT5sUMHm7YZU=;
	b=G1mAi/ionHBKxJX7ekixjsAsofzCvn3p0Nfl+JbuPgR3H66Th6LXg+ivpObjFjwHsxBcJT
	HUD26KNGF94RkYHLiYIEwlBCtJHyLGPBnWKHbpbnoDujeA5vwgw+xiJ+hLLpFpzYvoB735
	rD3NjcBTDik9fwxceaANulCABOwqKROw3qGjx4aTwaas1/+5bs1TCERYYWeHqv45X9SOkX
	EUI6j9hleGCU5i+xZjMZeL7FKelO/XBeS8Hq07mOm71f50C2+Y9Zx5ANAtqopHXrB2pKsU
	46buYpi1QXe9ad/iT19m8TK87yi69M/kmf/ZcKZVGZ9j7lsfV4XZXW3QqEGitA==
Date: Thu, 20 Feb 2025 10:00:00 -0500
From: Ethan Carter Edwards <ethan@ethancedwards.com>
To: Pu Lehui <pulehui@huawei.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] btf: move kern_type_id to goto cand_cache_unlock
Message-ID: <nw73mlf4p4qpjeoc6jie76xxmvl2iuj2f6p44sq2p5x2dzdrcv@iekulfikhdc4>
References: <20250220-bpf-uninit-v1-1-af07a5a57e5b@ethancedwards.com>
 <c6a25b61-6545-4a03-b2f1-a38c07037d29@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6a25b61-6545-4a03-b2f1-a38c07037d29@huawei.com>

On 25/02/20 08:24PM, Pu Lehui wrote:
> On 2025/2/20 13:50, Ethan Carter Edwards wrote:
> > In most code paths variable move_kern_type_id remains uninitialized upon
> > return. By moving it to the goto, it is initialized in these code paths.
> > As well as others. Caught by Coverity.
> > 
> > Closes: https://scan5.scan.coverity.com/#/project-view/63874/10063?selectedIssue=1595567
> > Fixes: e2b3c4ff5d183d ("bpf: add __arg_trusted global func arg tag")
> > Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
> > ---
> >   kernel/bpf/btf.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 9de6acddd479b4f5e32a5e6ba43cf369de4cee29..8c82ced7da299ad1ad769024fe097898c269013b 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -7496,9 +7496,9 @@ static int btf_get_ptr_to_btf_id(struct bpf_verifier_log *log, int arg_idx,
> >   		err = -EOPNOTSUPP;
> >   		goto cand_cache_unlock;
> >   	}
> > -	kern_type_id = cc->cands[0].id;
> >   cand_cache_unlock:
> > +	kern_type_id = cc->cands[0].id;
> 
> Hi, for goto's branches, it will always `return err`, no need to make this
> move.

You are right. My apologies. I should probably do less coding at 2AM.

Thanks,
Ethan

