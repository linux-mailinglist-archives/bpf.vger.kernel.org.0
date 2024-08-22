Return-Path: <bpf+bounces-37871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA6495BA8B
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 17:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09BC2B2859B
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 15:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D3A1CCEEE;
	Thu, 22 Aug 2024 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNeYBV3e"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ED21CBEBA;
	Thu, 22 Aug 2024 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724340577; cv=none; b=fSTGk2csP0RqSoCbqINdQWQVHJ7FQA4EK1I81GEKc2xW+H1WloVIGJuEir5gKs1iuuz2vJ6JFSc4S4382Vt6wnTlidg37FB9jBkubG0ABsxXY5bLQ4olHKd4A6n/OKKzutBe5QrC/WIezD30FrsfPBSLhSq9qAlXJJafwDo8q6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724340577; c=relaxed/simple;
	bh=1G8EZCcvSnYUgf3IUHlq7NfRw+iVcAnBmx5skak5kqI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tzIYuc4077CNMrvV8Hvnnym9Ik0eafvLGrn9hC57kSnNLci5b3PM5QX47V0SIF4BPKh6Ns19WOpg68ULxjXjtlqENvX+y1cgxIsaAuOg7sgoXjdjKqt0mDOHvHxKPvxBk4mY8fpnIh4sfu+pPhyxRtYbEmi2l6NaahbuWxsQ9H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNeYBV3e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0D0C32782;
	Thu, 22 Aug 2024 15:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724340577;
	bh=1G8EZCcvSnYUgf3IUHlq7NfRw+iVcAnBmx5skak5kqI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kNeYBV3eMO9oJwuNcxl6BFf6IO+m71NedoxSaFxpIMFyD8xzNWuelc9T4/fWInBMM
	 1WZSMz+s7V2mV+CZhKZEkjFDxwP7s8AanWCcDnSrGqsLJRnDhoE15sZf1reO6KkiwU
	 /E2AD6DKKBI76ak/OMD6oT8PTGIa2CfW7liqI9VNpI7AKGwkBPOtIf0EfUPN9vCbY6
	 N8HVYvCm/Jp/CAwh+hB117GzvgNLuAepquSvqUOcsgMB/wM44T2JZiM39F1VzaU075
	 6NPfl+p2NBD6dDR/iIyU4HWudr333C/6qy2dgyyJ4aXehaN6W8neG3is3XRmtA21ua
	 yLcXpjE6e+Mtg==
Date: Thu, 22 Aug 2024 08:29:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gang Yan <gang_yan@foxmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Gang Yan
 <yangang@kylinos.cn>, netdev@vger.kernel.org, bpf@vger.kernel.org, Geliang
 Tang <geliang@kernel.org>
Subject: Re: [PATCH bpf-next] bpf: Allow error injection for
 update_socket_protocol
Message-ID: <20240822082935.1ac2b305@kernel.org>
In-Reply-To: <tencent_1E619C9E44C8C4B2B713A0D6DD45B92BF70A@qq.com>
References: <tencent_1E619C9E44C8C4B2B713A0D6DD45B92BF70A@qq.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Aug 2024 14:08:57 +0800 Gang Yan wrote:
> diff --git a/net/socket.c b/net/socket.c
> index fcbdd5bc47ac..63ce1caf75eb 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -1695,6 +1695,7 @@ __weak noinline int update_socket_protocol(int family, int type, int protocol)
>  {
>  	return protocol;
>  }
> +ALLOW_ERROR_INJECTION(update_socket_protocol, ERRNO);

IDK if this falls under BPF or directly net, but could you explain
what test will use this? I'd prefer not to add test hooks into the
kernel unless they are exercised by in-tree tests.

