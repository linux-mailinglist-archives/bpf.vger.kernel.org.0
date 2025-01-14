Return-Path: <bpf+bounces-48720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B872A0C829
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 01:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B64C2169AA3
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 00:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED9317BCE;
	Tue, 14 Jan 2025 00:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMj+0CLv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ED9DDD3;
	Tue, 14 Jan 2025 00:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736813047; cv=none; b=rUB96TvB/4Yw2ug7ByKdzHkXtUCmgxSjWH1m5T2aV//CZpMUIcQ1dksZbFJn/j0XqfsUPKZGlrYnGFLt2bGr3wVZ0blshw5QHzFeavUCi0f25WGzFlap7w+mTmBapzLgUsZr97rDeO2O3yW1qc9U8De5OfJ547E/Z5k5yGNLGe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736813047; c=relaxed/simple;
	bh=VoOJcc1HZDuwcf8mRa5xWiojn24Z5Y0pshn+HiQpUtE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UfsSUoHemGXTWbLO6aism7v+liPMeQxMOhfC4vwZeGiGlPEtBehVo8RWNnmr1AEIszEPaxjvovsonYnkOWd+jxJlYaLriCtcD20sBMQ8mFL0hiY/nG5OB983BJDqmjXrVwO3P5WzWyVv4FOF+doqJrjWSKZa1TIsrd9CukRrt3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMj+0CLv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07F7C4CED6;
	Tue, 14 Jan 2025 00:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736813045;
	bh=VoOJcc1HZDuwcf8mRa5xWiojn24Z5Y0pshn+HiQpUtE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eMj+0CLvXLvJcju6aw5RBAa7GKeDYeK2WTJ1PIqirXbPfdcXAt9ogVHmxhR6nUTTX
	 rs/xJtEGCj/e7xYB0KTTqI51GRaJ94itJSi2fSUWNSkXJ4DscyXhvZ4Vv6MiaKDfh8
	 K7eSJ4uyVhHkuqF4cD6SjWYpc3/HcK1QGVjnqTvpB9qB6yeEv2fYAU8qThYRedxlrj
	 P8Mf0G8LDo0F5+bQn7SepmFNk98LECm3a5tjmNbmPmaOn1ct7lus9QVTiyUV7GOY3H
	 tJccOkFo7w8RoP7vneG1HawIDHlVWgTbEzWuWtcrsATJ2tOpdFGqCInGkD5kfmJGVT
	 RFt87kIxL275w==
Date: Mon, 13 Jan 2025 16:04:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiayuan Chen <mrpre@163.com>
Cc: bpf@vger.kernel.org, jakub@cloudflare.com, john.fastabend@gmail.com,
 netdev@vger.kernel.org, martin.lau@linux.dev, ast@kernel.org,
 edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org, song@kernel.org,
 andrii@kernel.org, mhal@rbox.co, yonghong.song@linux.dev,
 daniel@iogearbox.net, xiyou.wangcong@gmail.com, horms@kernel.org,
 corbet@lwn.net, eddyz87@gmail.com, cong.wang@bytedance.com,
 shuah@kernel.org, mykolal@fb.com, jolsa@kernel.org, haoluo@google.com,
 sdf@fomichev.me, kpsingh@kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf v5 1/3] bpf: fix wrong copied_seq calculation
Message-ID: <20250113160404.7ab0927d@kernel.org>
In-Reply-To: <20250109094402.50838-2-mrpre@163.com>
References: <20250109094402.50838-1-mrpre@163.com>
	<20250109094402.50838-2-mrpre@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  9 Jan 2025 17:43:59 +0800 Jiayuan Chen wrote:
> However, for programs where both stream_parser and stream_verdict are
> active(strparser purpose), tcp_read_sock() was used instead of
> tcp_read_skb() (sk_data_ready->strp_data_ready->tcp_read_sock)
> tcp_read_sock() now still update 'sk->copied_seq', leading to duplicated
> updates.

To state the obvious feels like the abstraction between TCP and psock
has broken down pretty severely at this stage. You're modifying TCP
and straight up calling TCP functions from skmsg.c :(

> +int tcp_read_sock_noack(struct sock *sk, read_descriptor_t *desc,
> +			sk_read_actor_t recv_actor, u32 noack,
> +			u32 *copied_seq)
> +{
> +	return __tcp_read_sock(sk, desc, recv_actor,
> +			       noack, copied_seq);
> +}
> +EXPORT_SYMBOL(tcp_read_sock_noack);

Pretty sure you don't have to export this. skmsg can't be a module.

