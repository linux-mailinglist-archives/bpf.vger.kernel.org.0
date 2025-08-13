Return-Path: <bpf+bounces-65482-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6455B23DD2
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 03:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C00F687D3F
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 01:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AEC1C8630;
	Wed, 13 Aug 2025 01:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+g8TX/4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6601BCA0E;
	Wed, 13 Aug 2025 01:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755049513; cv=none; b=OMXESeEg1tgysU2nW5HGVSvVRaR6UtQeTTnhkGCV1cDPf1xkXb7gg5i5aFuMxbj3Hi3QMV8haPYB88YDKvddz0Bs7scI+JvjX+9PHq/1Pf8+3HXc50ZCwutxGdnALpFiWzjt95U3mt4PyMeeE/rJggXBy+ZEryR7JiKv2U+UbfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755049513; c=relaxed/simple;
	bh=EyWXjko/7dgvRlT6ZxCiXfxg+QwMtBwoRb56YG5mCpE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ClL92lhTXt7AAjR8cGYCTTf3/N41oqGtzgx8HzZNOIrlKQbITjI+DvAS7ok8ZoHlEby8y5D+UrY6PZ2Eu/TqmAi4KzPcEc8fswGLJ/PsG3zWFob0YmqFaeWEKhbghWmPz7GBfGQRUQgb6hVJdJR8pwfy5+QOTYcS9BU80eVqiWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+g8TX/4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471B9C4CEF0;
	Wed, 13 Aug 2025 01:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755049513;
	bh=EyWXjko/7dgvRlT6ZxCiXfxg+QwMtBwoRb56YG5mCpE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k+g8TX/4WGD65cuMqpB8QWBiGY83Xv0oF5LQ/RCAxEoLBfkxC3HTw56YVLHh+AD0n
	 bhGmZubPOcl4qmUodAkPHA8sGxvnV+ajlJYqSVLVzvCFhsUwa3IGF9PpMv0tgu1HI6
	 +T81+S6AW8pIjW6zi4/sLo0NigFzhiQ0GjPmLZEXzy4T2bixZEBy057MudOwLwxJCa
	 brDHXhWBGUDWk/HEPV7LUsWs5YNQ3jP+gfyGUgLbssGmV3MpjvHMYXWIboCL+QeTgu
	 +y5KVv2K0dc9P5Yab45jOXukoMNEgA1Mg+307TT0mEN2mgvF0aQvpHhwpJ7kNV38Rw
	 YB7gCm8LRmrxg==
Date: Tue, 12 Aug 2025 18:45:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, Michal Kubiak
 <michal.kubiak@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Simon
 Horman <horms@kernel.org>, nxne.cnse.osdt.itp.upstreaming@intel.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-next v4 00/13] idpf: add XDP support
Message-ID: <20250812184511.0e49633c@kernel.org>
In-Reply-To: <20250811161044.32329-1-aleksander.lobakin@intel.com>
References: <20250811161044.32329-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Aug 2025 18:10:31 +0200 Alexander Lobakin wrote:
> From v3[0]:
> * 01/13: make the xdp_init_buff() micro-opt generic, include some
>          bloat-o-meter and perf diffs (Simon, Kees);
> * 08/13: don't include XDPSQs in Ethtool's 'other_count' (Ethtool
>          channels are interrupts!) (Jakub);
> * 11/13:
>   * finalize XDPSQs a bit earlier on Rx;
>   * show some bloat-o-meter and performance diffs for
>     __LIBETH_WORD_ACCESS (Jakub).

LGTM, thanks!

