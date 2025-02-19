Return-Path: <bpf+bounces-51889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A17CA3AF18
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 02:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 020801887FFB
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 01:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCEA81724;
	Wed, 19 Feb 2025 01:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3a3ls1x"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3841805A;
	Wed, 19 Feb 2025 01:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739929676; cv=none; b=XrvtC/UBUljFE+9hoWnbN7Xn54+Iv46naw7fJqMJE3LpOKBoUXD4jbRCQX04bEnNqfYsPaG596jZLxfUtBmev6gGCz+bRVfQ/YTChd+rXSnqOR1dbAJ9HKbFurLiz8D+1nu/14fip/+GT96kWTBxscFdW/rhTgKGcOnW27Rk6pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739929676; c=relaxed/simple;
	bh=ndCcrzrBiAjTDQApM4bqPTYtbDiMk7ZWYdoIjieVkIU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TMiTlHtA4MgxW9h+MR0T84xwh9Wc2OdiG/v5NRUY5XpVv+NUCgPfgDA2GDzuAwpgxl2+saCRO42LzUj3ybJ9P8kd+/cuql3SNKL+gd+sbS0P/bN+04dyRnxJR21rzli7OC6sYCdJdabmNNEqDz6lnjpVt7Cnpo0g156XMlRnemY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3a3ls1x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3317BC4CEE2;
	Wed, 19 Feb 2025 01:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739929675;
	bh=ndCcrzrBiAjTDQApM4bqPTYtbDiMk7ZWYdoIjieVkIU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P3a3ls1xraBcKvsaiSYPBq8cfj5OvqksjZ/IdbP4Xe31zCV4UqmxXfZsN9n0e34xh
	 yE/CLA8apX7EtS0uL9ZOhwkV/vnJuYT+Dgjtn5QFM3B94PXLrABmaYjV/nKEgAezOQ
	 PQqUTBd7B4TPVt7UsRc/QX+40dnhVm5REqBqL+zAfuH3es23GjRG0H91DO0tB1Jcvk
	 lA4zgt/iGS+gGqcH8xTftcrlvdEALIsVuxO6e/b3MRZjoHVhJ843agxh409X91z60L
	 JWiVKV7oQL4gypCi/njNT6InR2m4DTREirw192NFllga+OSKxSln7DDOu9TO46bjVR
	 Vb4EhvfjXTYPQ==
Date: Tue, 18 Feb 2025 17:47:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org,
 kuniyu@amazon.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/3] tcp: add TCP_RTO_MAX_MIN_SEC definition
Message-ID: <20250218174754.150c82c3@kernel.org>
In-Reply-To: <4dc10429-29dd-47bb-bd5f-6a8654ed2fec@linux.dev>
References: <20250217034245.11063-1-kerneljasonxing@gmail.com>
	<20250217034245.11063-2-kerneljasonxing@gmail.com>
	<4dc10429-29dd-47bb-bd5f-6a8654ed2fec@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 15:38:17 -0800 Martin KaFai Lau wrote:
> On 2/16/25 7:42 PM, Jason Xing wrote:
> > Add minimum value definition as the lower bound of RTO MAX
> > set by users. No functional changes here.  
> 
> If it is no-op, why it is needed? The commit message didn't explain it either.
> I also cannot guess how patch 2 depends on patch 1.

FWIW this patch also gave me pause when looking at v1.
I don't think this define makes the code any easier to follow.

