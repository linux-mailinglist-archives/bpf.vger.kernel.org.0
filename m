Return-Path: <bpf+bounces-16163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A80F27FDD9C
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 17:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63CB32828EF
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 16:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D443AC19;
	Wed, 29 Nov 2023 16:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StjyrXWy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D34249EE;
	Wed, 29 Nov 2023 16:49:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F708C433C7;
	Wed, 29 Nov 2023 16:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701276555;
	bh=aEv5kpjb2fy64cYuodJOoUVmTw2NUs12Hxb5UlfaW3E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=StjyrXWyiwn3V6abNqHXOwTYc6k6M1i/hxwztuIHvIl/d3UCAtPsusDnFs0vl5JaD
	 8iVIJGesZpMV+S0UzBiiRCA1CFb7o3EnWhLqIMnkyHHV8HkkV3ugo0pl8iopMWdFdC
	 4N0DAJDbJXFkTh8LaVJdHJSkeQQCMd6d6w2cNVjOoLE5wwFY2zVHW4fSm9AIF0HOnY
	 swHNNc7EZegQGlzygN+uTzGxR5er+Hs/WIY81IIANw5dD4Tpr9+xmGHEEnAwYtzmkR
	 mRhe7QKiG8moNJJDLLY9HC+J1DFz0J3yufG2J9vVyub3/h5nn4xCl9E9CEne7AHqWS
	 +nrluRMbiOjqg==
Date: Wed, 29 Nov 2023 08:49:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org,
 magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com,
 hawk@kernel.org, yoong.siang.song@intel.com, netdev@vger.kernel.org,
 xdp-hints@xdp-project.net
Subject: Re: [PATCH bpf-next v6 02/13] xsk: Add TX timestamp and TX checksum
 offload support
Message-ID: <20231129084913.01dc63c2@kernel.org>
In-Reply-To: <20231127190319.1190813-3-sdf@google.com>
References: <20231127190319.1190813-1-sdf@google.com>
	<20231127190319.1190813-3-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Nov 2023 11:03:08 -0800 Stanislav Fomichev wrote:
> This change actually defines the (initial) metadata layout
> that should be used by AF_XDP userspace (xsk_tx_metadata).
> The first field is flags which requests appropriate offloads,
> followed by the offload-specific fields. The supported per-device
> offloads are exported via netlink (new xsk-flags).
> 
> The offloads themselves are still implemented in a bit of a
> framework-y fashion that's left from my initial kfunc attempt.
> I'm introducing new xsk_tx_metadata_ops which drivers are
> supposed to implement. The drivers are also supposed
> to call xsk_tx_metadata_request/xsk_tx_metadata_complete in
> the right places. Since xsk_tx_metadata_{request,_complete}
> are static inline, we don't incur any extra overhead doing
> indirect calls.
> 
> The benefit of this scheme is as follows:
> - keeps all metadata layout parsing away from driver code
> - makes it easy to grep and see which drivers implement what
> - don't need any extra flags to maintain to keep track of what
>   offloads are implemented; if the callback is implemented - the offload
>   is supported (used by netlink reporting code)
> 
> Two offloads are defined right now:
> 1. XDP_TXMD_FLAGS_CHECKSUM: skb-style csum_start+csum_offset
> 2. XDP_TXMD_FLAGS_TIMESTAMP: writes TX timestamp back into metadata
>    area upon completion (tx_timestamp field)
> 
> XDP_TXMD_FLAGS_TIMESTAMP is also implemented for XDP_COPY mode: it writes
> SW timestamp from the skb destructor (note I'm reusing hwtstamps to pass
> metadata pointer).
> 
> The struct is forward-compatible and can be extended in the future
> by appending more fields.

Acked-by: Jakub Kicinski <kuba@kernel.org>

