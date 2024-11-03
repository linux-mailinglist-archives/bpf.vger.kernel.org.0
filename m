Return-Path: <bpf+bounces-43849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BAA9BA7DA
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 21:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34FDA1F21A5C
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 20:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FAE18B486;
	Sun,  3 Nov 2024 20:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JowD/RBV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199BA60B8A;
	Sun,  3 Nov 2024 20:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730664949; cv=none; b=A8VTnWopkZT5IclJoDPW5IKb9gwN6S4uC3H/P5wt+nQD2VQvxUzCHEoa3xccV0F6cqAMGMnkNKTVwl66TUzvh00zSHlStH/542/ROon51xg6Mcr45Cke9oSc8q9COJOlMozJQY+RJ3QOAKdony9CxpadNE76ZFs9Yu2kDXR7TwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730664949; c=relaxed/simple;
	bh=JYx0++DsQhkaj0R7/VrTnd8TLChmbWYEn5/kLjsSFkM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oLwuxUZAiO6niaIfp2Ibt7EODJ6Zo1ZgR8Gour/HKJdhNJk8ko2mXrFNETgb0zNB3Et8ZV/MyCZ7HyNYzDYLtXBEnPPs1QxQqcbTDywBrhLtP+dJQN+hnhNvz3WQbxHAPz27SYat86ILObXc7Xy3bPRbbKQ/Fh4kMJtlYulNTKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JowD/RBV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21BAC4CECD;
	Sun,  3 Nov 2024 20:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730664948;
	bh=JYx0++DsQhkaj0R7/VrTnd8TLChmbWYEn5/kLjsSFkM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JowD/RBVPwi+lfNRustCYC2XWJXbH3lOUvg/N4l04sQENJZV0EhdWIHOcdDpwNSwF
	 4/WUt9/US1So/cF18yZX59P+AWLJqIRmd2aQSvAiXWWEeJvhOrRpA4w7j3yTWI7Udw
	 9uDvvDek3045ped5fTuEmOYaE6RGhTDk+Ogo0hx98DnSLqO3v8PLqu8bTxnMfE2AB0
	 0+v27gZo4Z09tEzXQvePTW9gv+vK2zjugv5RPuFmhLS3zxmgOIUZp1X8xWPWgJR712
	 AaeVUtsT/4f3IyueA1z+NPaXRJneMiWDGoOWvEQuyDmkFB/pL4yD8N5epJF3dz6O6U
	 Kzya8falpmHyw==
Date: Sun, 3 Nov 2024 12:15:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: zijianzhang@bytedance.com
Cc: bpf@vger.kernel.org, borisp@nvidia.com, john.fastabend@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, daniel@iogearbox.net, ast@kernel.org,
 stfomichev@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH v2 bpf] bpf: Add sk_is_inet and IS_ICSK check in
 tls_sw_has_ctx_tx/rx
Message-ID: <20241103121546.4b9558aa@kernel.org>
In-Reply-To: <20241030161855.149784-1-zijianzhang@bytedance.com>
References: <20241030161855.149784-1-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Oct 2024 16:18:55 +0000 zijianzhang@bytedance.com wrote:
> As the introduction of the support for vsock and unix sockets in sockmap,
> tls_sw_has_ctx_tx/rx cannot presume the socket passed in must be IS_ICSK.
> vsock and af_unix sockets have vsock_sock and unix_sock instead of
> inet_connection_sock. For these sockets, tls_get_ctx may return an invalid
> pointer and cause page fault in function tls_sw_ctx_rx.

Since it's touching TLS code:

Acked-by: Jakub Kicinski <kuba@kernel.org>

I wonder if we should move these helpers to skmsg or such, since only
bpf uses them.


