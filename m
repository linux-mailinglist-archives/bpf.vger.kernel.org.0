Return-Path: <bpf+bounces-16023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8E47FB05A
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 04:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE3821C20DC8
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 03:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DCE6FC0;
	Tue, 28 Nov 2023 03:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpOMdNtR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AAB746F;
	Tue, 28 Nov 2023 03:09:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FD8C433C7;
	Tue, 28 Nov 2023 03:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701140980;
	bh=PxGteF7iO02cA2HMwpt9WIBm9CHhptr+zLzAIBnCTqc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VpOMdNtR7egI3mQ7P6K0P7LlWmbkEtwBR4l9E8yklT4Kznw9qsNb+OTrxC5WbSs03
	 Rq6GAFSQ4iMNl/KVRA+ngtyqiQ2Op1lqPcnnWNrNE4Wnd/6iCVhESVR2l1sJ5GWFZZ
	 dlbbC/NIaz7Oo8PM2e3TGEgTz64Uas1N+DprHC9LuD4HT2u3IV1VZt3b7k+bQOUuzv
	 Ol0BtXIVNBt1T22tqTKPBujAEjnYL/10c7x6MKRvUTxhmLSe5u1s+UPprXMAOKpI0w
	 YKkPBGfHOl1Zmbb3QMYKH/Z40gKIqpql6SwhwFiy+LgbOWoehqOyw4TwlHh4CRuXKv
	 hl3Tjmpreti2w==
Date: Mon, 27 Nov 2023 19:09:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org,
 magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com,
 hawk@kernel.org, yoong.siang.song@intel.com, netdev@vger.kernel.org,
 xdp-hints@xdp-project.net
Subject: Re: [PATCH bpf-next v6 01/13] xsk: Support tx_metadata_len
Message-ID: <20231127190938.01005780@kernel.org>
In-Reply-To: <20231127190319.1190813-2-sdf@google.com>
References: <20231127190319.1190813-1-sdf@google.com>
	<20231127190319.1190813-2-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Nov 2023 11:03:07 -0800 Stanislav Fomichev wrote:
> For zerocopy mode, tx_desc->addr can point to an arbitrary offset
> and carry some TX metadata in the headroom. For copy mode, there
> is no way currently to populate skb metadata.
> 
> Introduce new tx_metadata_len umem config option that indicates how many
> bytes to treat as metadata. Metadata bytes come prior to tx_desc address
> (same as in RX case).
> 
> The size of the metadata has mostly the same constraints as XDP:
> - less than 256 bytes
> - 8-byte aligned (compared to 4-byte alignment on xdp, due to 8-byte
>   timestamp in the completion)
> - non-zero
> 
> This data is not interpreted in any way right now.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

