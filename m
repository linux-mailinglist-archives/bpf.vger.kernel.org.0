Return-Path: <bpf+bounces-15959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D4E7FA8E5
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 19:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C8E2B21194
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 18:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5429C3DB8D;
	Mon, 27 Nov 2023 18:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhTY8Lzg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C405E2F87F;
	Mon, 27 Nov 2023 18:22:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133DEC433C7;
	Mon, 27 Nov 2023 18:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701109345;
	bh=V74V6yG2rrIdo6mJYs6RzZ30/ruHiWwAqS1sd8r4O6E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nhTY8LzgpXtpr41bMNZiKYrXjU0dt+lmyfyfhbGj8awsFNFeEn1J8BktPQ4kzuyoe
	 8j8vW6Rr/sLcMI5M7mJ7tGGha+kAqseZ6MS/xFgu81iEaCIPQS5ubrk1Nf8A+2OwZ9
	 GifSiSpOEpjZ3EIhaXwgUglIoYL3v7mELY22kgIX34FpKgSLnIcWrtAaHt4Tk31aXn
	 N3T4sGjwBtjonrUf/pVLcVpgCXM9iCUM7u6ESOY9zbBwgecI4buXLrbiw9FOIG/kNo
	 8D+NrYuKzbQxK9gDwq0B1uzaZsGHJHPwRH6Y5lvRjgRi3V4aMpU7718UuXgdZCkDTi
	 ELLabZFm3Wwdg==
Date: Mon, 27 Nov 2023 10:22:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: martin.lau@linux.dev, razor@blackwall.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH bpf] netkit: Reject IFLA_NETKIT_PEER_INFO in
 netkit_change_link
Message-ID: <20231127102224.2b43b14f@kernel.org>
In-Reply-To: <20231127134311.30345-1-daniel@iogearbox.net>
References: <20231127134311.30345-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Nov 2023 14:43:11 +0100 Daniel Borkmann wrote:
> +	if (data[IFLA_NETKIT_PEER_INFO]) {
> +		NL_SET_ERR_MSG_ATTR(extack, data[IFLA_NETKIT_PEER_INFO],
> +				    "netkit peer info cannot be changed after device creation");
> +		return -EACCES;
> +	}

Why EACCES? It doesn't have much to do with permissions and all netlink
validation errors use EINVAL. IMO this is a basic case of "attribute
not defined in the policy", NLA_REJECT, so EINVAL..

