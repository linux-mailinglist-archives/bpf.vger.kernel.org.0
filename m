Return-Path: <bpf+bounces-12885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD2D7D1A36
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 03:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04011282707
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 01:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04E67ED;
	Sat, 21 Oct 2023 01:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGBSMNgi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296EA641;
	Sat, 21 Oct 2023 01:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D95B4C433C8;
	Sat, 21 Oct 2023 01:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697850393;
	bh=XjI3Lhozaqfsso5ZmGvVzvC6vNc7SmAen5vviLq/WQ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KGBSMNgi/DMTLZQHM/jCmdgsonJJQyMUDtUhE1yTf0qknglnjzTgBbdtgwDdON6LR
	 ylUuNYhRpt/PFDjZIcqrDSej747Jfqv7C0jdxsVATP+WXs/eZVa31w80PLZZOVMNdB
	 3gmJK9m8o1FAe83yDR5+ZXR1INyecjQc0dwfu3z1G0Ca4fumWBuxgqCWrTisTN+b4r
	 UTx+IKDyFmmf1beTdUWy1i3jw94EB+J7b/DC+iJLrfQpxAKEj8Pyg6kMmpEVvXKrD6
	 o/v3WqK1wmiQP5dubXy82dm71ivl+JC7Q+Ee6nmDMnvfGidwW5rm0BCMkXDrwE0c91
	 BASTZWMgAvCZA==
Date: Fri, 20 Oct 2023 18:06:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org,
 magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com,
 hawk@kernel.org, yoong.siang.song@intel.com, netdev@vger.kernel.org,
 xdp-hints@xdp-project.net
Subject: Re: [PATCH bpf-next v4 03/11] tools: ynl: Print xsk-features from
 the sample
Message-ID: <20231020180631.0f7eaebb@kernel.org>
In-Reply-To: <20231019174944.3376335-4-sdf@google.com>
References: <20231019174944.3376335-1-sdf@google.com>
	<20231019174944.3376335-4-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Oct 2023 10:49:36 -0700 Stanislav Fomichev wrote:
> Regenerate the userspace specs and print xsk-features bitmask.

I'm afraid you regenerated in previous patch already :]
Perhaps we should add an easy-to-use flag to ynl-regen to skip tools/ ?

> diff --git a/tools/net/ynl/samples/netdev.c b/tools/net/ynl/samples/netdev.c
> index b828225daad0..da7c2848f773 100644
> --- a/tools/net/ynl/samples/netdev.c
> +++ b/tools/net/ynl/samples/netdev.c
> @@ -44,6 +44,12 @@ static void netdev_print_device(struct netdev_dev_get_rsp *d, unsigned int op)
>  			printf(" %s", netdev_xdp_rx_metadata_str(1 << i));
>  	}
>  
> +	printf(" xsk-features (%llx):", d->xsk_features);
> +	for (int i = 0; d->xsk_features > 1U << i; i++) {

Shouldn't this be >= ?

> +		if (d->xsk_features & (1U << i))
> +			printf(" %s", netdev_xsk_flags_str(1 << i));
> +	}

