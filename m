Return-Path: <bpf+bounces-11932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3EB7C59C1
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 19:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21499282636
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 17:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA033D99E;
	Wed, 11 Oct 2023 17:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXWfAU//"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E403AC0F;
	Wed, 11 Oct 2023 17:00:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9553C433C9;
	Wed, 11 Oct 2023 17:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697043659;
	bh=4s0g9DhKUIbShu1m85ATDlurOXttotYpRt/DssOsaVE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aXWfAU//GdvE74uLj/NKNhvRtOS32PkKp/nzkTZQ5h1Z4U+zgafa+b5T9gsDJ11J/
	 FPRCtDaQRHX8siUPSmDyLk3jNLhMQdwFSWLN3clzYAF5tdCGNE/qFStoX3m8yOlpLA
	 y9k0c5lBIbfWkhSZNecCJKRKbK5we3r1aJrk7TeqpOB/4m1Jvkn6AsZLyq7/C6d7Y0
	 y6f/mnKb9w+r6tzH5dsb53GNOwS2+2NLeBFC8pQwZ7AOe9cN7FMv54zFYVLt/nxF8q
	 fbs7QVyD9bFaIJyd/EmG0vs7PqbnAbFlzzBSGE0MDToGaPz3gZ6hYmEdyBDA/FRZKp
	 Kp8kOmF5dVQiA==
Date: Wed, 11 Oct 2023 10:00:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH vhost 00/22] virtio-net: support AF_XDP zero copy
Message-ID: <20231011100057.535f3834@kernel.org>
In-Reply-To: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Oct 2023 17:27:06 +0800 Xuan Zhuo wrote:
> ## AF_XDP
> 
> XDP socket(AF_XDP) is an excellent bypass kernel network framework. The zero
> copy feature of xsk (XDP socket) needs to be supported by the driver. The
> performance of zero copy is very good. mlx5 and intel ixgbe already support
> this feature, This patch set allows virtio-net to support xsk's zerocopy xmit
> feature.

You're moving the driver and adding a major feature.
This really needs to go via net or bpf.
If you have dependencies in other trees please wait for
after the merge window.

