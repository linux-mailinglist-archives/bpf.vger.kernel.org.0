Return-Path: <bpf+bounces-56647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A43FA9BA6E
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 00:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E7C24C05A6
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 22:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772BE288C93;
	Thu, 24 Apr 2025 22:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiSoiycE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E599628136E;
	Thu, 24 Apr 2025 22:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745532434; cv=none; b=mlcvQQuaNam7UpfYx8OJbMv4k+gD46H2A7A4EPiKsB0z4JeOxTLMMjepEqsERHm2r1T+lNBle/yKkrwsGg9RCw9Bel2CBzblXJZcUxHPmuRl7PXFeZQrgYDxCW9+UIXx0JAv7MLUfqUI/12r4L0BvSuBMTXgn5nXqQ4xnOZKXgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745532434; c=relaxed/simple;
	bh=OvaJnaxhDspEpD+7HCoFKAG+qPMA3h/TjqBh8rM8svA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nh29cTtlX28wwTmZU18MQx0muDmM24OXMQaGVrw2+NQ+JaF5kAEHzbGnNPsJArmzRfeU53tKf46q5qxt0DkTt/9cKMwGW2uSxgIK3KWaIuQ0OrUzVL9KjVzSdQeYIEVXFH5n0PKrzKCQKsn4F2LGCYGH65I4UR+9Wg2636F5pmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiSoiycE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B82C4CEE3;
	Thu, 24 Apr 2025 22:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745532433;
	bh=OvaJnaxhDspEpD+7HCoFKAG+qPMA3h/TjqBh8rM8svA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CiSoiycEuquOYrsTDQSc0NBrVPmbGFqbi63SEuefY1Dz49mij2jCBU6iFF7g0achz
	 +o0rU+VpVQD5ZgUSMGjzfcp7djasMC5QDdBnqrOvxrTEF6RlCz8eLrG8maj+RDNERf
	 jSwqiF+ettBrVg+q0nrbJmTjNVH09LKsn5B/s3KXi4w7y+bSWjmecYR5mN6zXj34+a
	 wEdJEYtS4FIJdep3BSwsF5VGq529lL+d8FEej2rH5Q2CNJg8NNuU21tZSNZCjzSiGG
	 G59Gr1l9nvKoMb8TbClCB3j5m5Addd6SUcn8PwZhWTFr2SYb/Fft4jLQNSh+W03Azq
	 i7l0Cq7rA6vGQ==
Date: Thu, 24 Apr 2025 15:07:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v4 4/4] selftests: net: add a virtio_net deadlock
 selftest
Message-ID: <20250424150711.7a255935@kernel.org>
In-Reply-To: <619bc46d-4acf-4c54-bd47-6b482fb76878@gmail.com>
References: <20250417072806.18660-1-minhquangbui99@gmail.com>
	<20250417072806.18660-5-minhquangbui99@gmail.com>
	<20250422184151.2fb4fffe@kernel.org>
	<aac402b4-d04c-4d7e-91c8-ab6c20c9a74d@gmail.com>
	<20250423152333.68117196@kernel.org>
	<619bc46d-4acf-4c54-bd47-6b482fb76878@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Apr 2025 17:33:49 +0700 Bui Quang Minh wrote:
> Yes, the kernel returns EBUSY. Loop and retry sounds good to me but it's 
> not easy to get the return code when using bkg(). So for simplicity, 
> I'll retry with sleep(1) 3 times when the xdp_helper fails.

I meant retry _inside_ the xdp_helper :)
That should be pretty easy?

