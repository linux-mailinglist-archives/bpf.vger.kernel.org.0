Return-Path: <bpf+bounces-56474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 736BCA97C24
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 03:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4077F3B1907
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 01:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750032620E7;
	Wed, 23 Apr 2025 01:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcl4FLVY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E708328EC;
	Wed, 23 Apr 2025 01:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745372064; cv=none; b=cT+R6RK1WTzqgn7uO6cTyly1Nu8EIpLicz6WUPT5yiiDlx2xFbXwYGwZQmqZBEttERgTIW5FpBQ0bS6psZoBnwLKS38GFc+tqIxqR6FotU0GyeahwbSBlPjcxqmvchIQiSA/XU0Lrijznc1go66wItz9hLAOJ0QsCQ3FIo7iMyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745372064; c=relaxed/simple;
	bh=LywtgWlPszXKnD5m8mOBTSC8u07CmLsHSdCy6J5wfmE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A2kuDkQpHAstDG+xEAGuPKhbiXOFMnHXlNGZ216IplKVAp9AF+lqyIcp+FecYG4fLa2e1MpTX+9lbpzct2NegWIXDOLiKxZw9goJ4YB8dtNEFY/Qbdoo6h8EwuXFUnHyQZpJ6R6gLY36D2vwJV0ukuAF38dpa8xofmjIa2E0VOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tcl4FLVY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E09CC4CEE9;
	Wed, 23 Apr 2025 01:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745372063;
	bh=LywtgWlPszXKnD5m8mOBTSC8u07CmLsHSdCy6J5wfmE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tcl4FLVYc4Ja6bnvonpx/CPX3R3t1lznIeMVgLflySaqYtRWny4t6mmemrdz5kBJJ
	 6Ak7JCU/k7TG2MfkLtjYroiIaHS/sH+RN2Xh39p3wZ2Cif+wbM39hG16thsWd3oE21
	 dWV5syhgVnhOIDQmRhtniHBdhks/6Iq6BH62/D+OoOf09wtJpaYLvpsD01xk+Tk2Xd
	 BKXQRdVYUWRWZlawEWPT8z41NxFtmnxVWyJseN7O7kRfH5ofkWiQoFoW7932NELrmo
	 jeQkTVUdg+dzOvYnls7qZkLpGVaLk3Uwd5PckgpWbddiHPWmwu9Z7aIA0QgW0zSbcq
	 dZcpeQUD4b7iA==
Date: Tue, 22 Apr 2025 18:34:21 -0700
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
Subject: Re: [PATCH v4 3/4] selftests: net: add flag to force zerocopy mode
 in xdp_helper
Message-ID: <20250422183421.27fd9875@kernel.org>
In-Reply-To: <20250417072806.18660-4-minhquangbui99@gmail.com>
References: <20250417072806.18660-1-minhquangbui99@gmail.com>
	<20250417072806.18660-4-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Apr 2025 14:28:05 +0700 Bui Quang Minh wrote:
> +	if (argc == 4 && strcmp(argv[3], "-z")) {
> +		fprintf(stderr, "Usage: %s ifindex queue_id [-z]\n\n"
> +			"where:\n\t-z: force zerocopy mode\n", argv[0]);
> +		return 1;
> +	} else if (argc == 4) {
> +		sxdp.sxdp_flags = XDP_ZEROCOPY;
> +	}

I've applied the fix, the tests need a couple touch ups, so please
repost just the tests for net-next?

Here I think it'd be cleaner to write the change as:

static void print_usage(const char *bin)
{
	fprintf(stderr, "Usage: %s ifindex queue_id [-z]\n\n"
		"where:\n\t-z: force zerocopy mode\n", bin);	
}

[...]

	if (argc > 3) {
		if (!strcmp(argv[3], "-z")) {
			sxdp.sxdp_flags |= XDP_ZEROCOPY;
		} else {
			print_usage(argv[0]);
			return 1;
		}
	}

