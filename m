Return-Path: <bpf+bounces-71978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A68C041A4
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 04:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC1344EB196
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 02:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394712248AE;
	Fri, 24 Oct 2025 02:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjWiqdbl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADABB72633;
	Fri, 24 Oct 2025 02:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761271975; cv=none; b=u9PLzH7oECGcCht+s5THyQY39TXiDzwVk3OZG9Wc6uTyQAQ5/mBIhYlkppKbvXBttuA9KL4uwguWEFWDLVZwT6hkLWN00MCP4PyICdDfgN55REbDwIhvfu1BPYjhqXNiAqPqYQDHF24rmaA3s75N04F05AV7TTL36krxYZ1worc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761271975; c=relaxed/simple;
	bh=ggXsDFQ2RFoQFZuAajTf2mCu67ies2IkThM/oE59p7I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fJdT50dwfhcUkKvJfnrfmGy/RkMFQcSlyu8O0NoIIp2+nou2CVIDXwWtfPCpxfOeY8poAaW0jDdMoX+nVCCg3LXKoeIvoH4+avWpYzY60OKSDKSFouu9tBLr7NjiTBarJu5CR21wLGnG/ltFwRE1DP++xsQmQrW/Y749xJQJ6dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjWiqdbl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D68C4CEE7;
	Fri, 24 Oct 2025 02:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761271975;
	bh=ggXsDFQ2RFoQFZuAajTf2mCu67ies2IkThM/oE59p7I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bjWiqdblgZL+4othJSRFh5fM1FWAqXkNynVuQtsG8ixNZsYws3cVgw9a16+9Fv7wz
	 pHRnP18cpkkiE1WEY39EjEUr8Ap8yRaxGDb4qk/4R3XelRI2yczxKyKJppQq1Ns1OO
	 Qcm9fu3D4DKwTuCERTzidX9ZYSQ63m6V3YVaU4KV7QCpP51K17SbTv7QR0hkG0jptB
	 RtjlLfkjK01mvdMYkeCcofyQNn8N+slGYP2krtin0ccorHnv6m0PjC1eQBHgLI1b8R
	 KGwCmJ67JJ/kPb+iEObbewlGCF4SnFg55JuZetCAnl6e4YBx76kkBr9qJM4V3TAPGJ
	 gUVngX0t7oa9A==
Date: Thu, 23 Oct 2025 19:12:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v3 01/15] net: Add bind-queue operation
Message-ID: <20251023191253.6b33b3f4@kernel.org>
In-Reply-To: <20251020162355.136118-2-daniel@iogearbox.net>
References: <20251020162355.136118-1-daniel@iogearbox.net>
	<20251020162355.136118-2-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Oct 2025 18:23:41 +0200 Daniel Borkmann wrote:
> +      name: bind-queue
> +      doc: |
> +        Bind a physical netdevice queue to a virtual one. The binding
> +        creates a queue pair, where a queue can reference its peer queue.
> +        This is useful for memory providers and AF_XDP operations which
> +        take an ifindex and queue id to allow auch applications to bind
> +        against virtual devices in containers.
> +      attribute-set: queue-pair

      flags: [admin-perm]

right?

