Return-Path: <bpf+bounces-31989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8B0905F2D
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 01:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4CDB1F24A6B
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 23:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D45612CDB1;
	Wed, 12 Jun 2024 23:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMpHDAwS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB1E84A36;
	Wed, 12 Jun 2024 23:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718234707; cv=none; b=W+DCF0RwSxD8d937XrWD2Df9TMqQRxoA4acTENKLILkkcJaW7f6MHkjg36Sn5B/I12BCEx3sW2aSgd5Bspxqz84OiHxyj3fO3UTUnyr4ukQCGUg9GiBCoewPyoywC+ZxnMnthAyyai5YndMLC0pDxAoTLN2ZJNEiZr5eMJmUGqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718234707; c=relaxed/simple;
	bh=KQQBwVY9dUE4v5HKz38PsHHh/YJZvL3OxMZwpYAw18U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oC7t63il0AbEau4/GKGOZOJo4mKMZ1BZO8uX9kIadX624eqTUidfHZWEBlH8WeAS4Iz/cnqksqbob5DgnBPLihqjiomsjlwAUbdk3A++8D3jFI+IbM7j4Z945DbGpTQS1zX+uZOZfn0L/Vre2Z9JYQh4P0bhoj4L5/1k0iNOQ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMpHDAwS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C13C116B1;
	Wed, 12 Jun 2024 23:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718234706;
	bh=KQQBwVY9dUE4v5HKz38PsHHh/YJZvL3OxMZwpYAw18U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WMpHDAwSFVWCfTcdxXsC4azq17TyHlNZ80ROrQrZwFuAahFMHNqN4tmThkape+NuY
	 +wxeUJQYKD6FmkJXc9CRB4j5mM0FOrFlSfAUAfisw0MowoGWCQPwuXgBFjDWF/kzz0
	 jJzMJilCxB3+yHJ6gLCVthfqB3uiPY/hrs+DNebyGd9U87H+YqD/Jh/g67OGLcr+u1
	 sKuubnNYrWGRLT1fuDXLYJbM78Pg0IP4LWxkmzlcfrZjpZ71j86C/SK/KR4b2qNwhy
	 SLsiCux6THwdA8JNazHdon4MuNkskRV+0YA9zt2U6nmEwqSJqnIg7fRyINK5gR5D78
	 02aRPYYHuE9Sw==
Date: Wed, 12 Jun 2024 16:25:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 bpf@vger.kernel.org
Subject: Re: [PATCH net-next v4 11/15] virtio_net: xsk: tx: support xmit xsk
 buffer
Message-ID: <20240612162505.2fa3e645@kernel.org>
In-Reply-To: <20240611114147.31320-12-xuanzhuo@linux.alibaba.com>
References: <20240611114147.31320-1-xuanzhuo@linux.alibaba.com>
	<20240611114147.31320-12-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Jun 2024 19:41:43 +0800 Xuan Zhuo wrote:
> @@ -534,10 +534,13 @@ enum virtnet_xmit_type {
>  	VIRTNET_XMIT_TYPE_SKB,
>  	VIRTNET_XMIT_TYPE_XDP,
>  	VIRTNET_XMIT_TYPE_DMA,
> +	VIRTNET_XMIT_TYPE_XSK,

Again, would be great to avoid the transient warning (if it can be done
cleanly):

drivers/net/virtio_net.c:5806:9: warning: enumeration value =E2=80=98VIRTNE=
T_XMIT_TYPE_XSK=E2=80=99 not handled in switch [-Wswitch]
 5806 |         switch (virtnet_xmit_ptr_strip(&buf)) {
      |         ^~~~~~

