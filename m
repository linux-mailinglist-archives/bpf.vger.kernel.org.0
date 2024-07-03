Return-Path: <bpf+bounces-33801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD109268C6
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 21:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F82E1C20EEC
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 19:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9E71891A0;
	Wed,  3 Jul 2024 19:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+rzUkWq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B222E41A81;
	Wed,  3 Jul 2024 19:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720033305; cv=none; b=CUv08gIXaX3+XO6iKriN+o/+6i4UtXJcof0fwYKfHFAsUb9+v2KdIOfFjQ6gRltjZBJek3gmesvHma7jVppBP+qXVVWSDlRPCW/Q6J1P9D3TdAVlz+pVpJ7Ox4TUIpv+YjhPd99MgACwaQLx7gKgHEoxFw/Df2UXQNraO3YA0bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720033305; c=relaxed/simple;
	bh=CiBfnjOODz9WdgKnFn9W67Hb3I6KjlLRqA0gcZAc/Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V9BCNXEsU1eDaev/2RrckHNvvA7R1ZgtmHsAYM6z/hxjMQQdz7Nv5nt2miBWT5m2uau/J16yJ240p3bPHlD71BVvEfF0qaGlThbe0wknud2v9r4F3zA20unr5+IYOti83t2VpXFnOXEj2UjDh5NrGkuxtdSN9n2uThl67i9C/vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+rzUkWq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB6FC2BD10;
	Wed,  3 Jul 2024 19:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720033305;
	bh=CiBfnjOODz9WdgKnFn9W67Hb3I6KjlLRqA0gcZAc/Ac=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M+rzUkWqjXIOxfZWdAasTZQJbYKu6cBo89U+pWBDMRVnO/axqW39izLx2uUamebAS
	 mkl05mZ4kbyR515qzZHihFBJ5zj81F7U5KyrqECGn1QQ1VlQ4CP3+Xr02RscafMIPn
	 NT2PRNXurhL27/V08eAP/hdc7BFdf9tode2UPry4wYQdIQ9KsItmzxAzLIgLxhSGpK
	 zQkVfi/ky/0R+Vc7/P8eg/czXRvv7OyR3eDk2TMWAZ2s8kxzLwyp9SxIxZ3qTDSAi2
	 46NwoRyclNvz8g+AuQ/UJoJJQhTYyu7V6bY2kKIcfir2lysdOd2/WjA8OWG8c30ao2
	 vEi/jR87EDuLA==
Date: Wed, 3 Jul 2024 12:01:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: syzbot <syzbot+08811615f0e17bc6708b@syzkaller.appspotmail.com>,
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com,
 haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, netdev@vger.kernel.org, sdf@fomichev.me,
 song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Subject: Re: [PATCH net-net] tun: Assign missing bpf_net_context.
Message-ID: <20240703120143.43cc1770@kernel.org>
In-Reply-To: <20240703122758.i6lt_jii@linutronix.de>
References: <000000000000adb970061c354f06@google.com>
	<20240702114026.1e1f72b7@kernel.org>
	<20240703122758.i6lt_jii@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jul 2024 14:27:58 +0200 Sebastian Andrzej Siewior wrote:
> During the introduction of struct bpf_net_context handling for
> XDP-redirect, the tun driver has been missed.
> 
> Set the bpf_net_context before invoking BPF XDP program within the TUN
> driver.

Sorry if I'm missing the point but I think this is insufficient.
You've covered the NAPI-like entry point to the Rx stack in your
initial work, but there's also netif_receive_skb() which drivers 
may call outside of NAPI, simply disabling BH before the call.

The only concern in that case is that we end up in do_xdp_generic(),
and there's no bpf_net_set_ctx() anywhere on the way. So my intuition
would be to add the bpf_net_set_ctx() inside the if(xdp_prog) in
do_xdp_generic(). "XDP generic" has less stringent (more TC-like) 
perf requirements, so setting context once per packet should be fine.
And it will also cover drivers like TUN which use both
netif_receive_skb() and call do_xdp_generic(), in a single place.

