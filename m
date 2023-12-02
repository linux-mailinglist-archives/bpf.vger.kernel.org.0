Return-Path: <bpf+bounces-16501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCBA801DEA
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 18:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA06C1F2117F
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 17:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5661C6B1;
	Sat,  2 Dec 2023 17:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSaF0O2v"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95E218B11;
	Sat,  2 Dec 2023 17:09:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060B0C433C7;
	Sat,  2 Dec 2023 17:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701536999;
	bh=tUTQ+O04DUoL60hnD6X577YIlDHEoUJR6qm+9eDRlNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SSaF0O2vdB8RDPafXTH0UiEjGZWYE6T3cGHid+UF5LSaw17x/xQG5nviHGv8GOzqA
	 E86Eu9+yC4yi7xb6T2Shhw/q6zw6NqGJe9HqOmtZOeN8aZAagGzw2+aQXGzM5I73d/
	 z3h20ixfQuUKTfCCWRJkXtSbdMtbBCQ02g8h2hDiAP1J1IAztUsFK52QVA5A90JR9Q
	 Zdxi7hcCTK4gvDN44ymXjVO8RpY8Ef7mqXc6pKVqy3uWL3zMX/SbCO4mBPB9atnSZn
	 4feZxZ7VPs///RjGwhbUp0xk4uQTje8Zm7Qt6/WxULKUz4PqT7vxBKWmH0Anj4Fl8s
	 g4CcgNcgE+RZA==
Date: Sat, 2 Dec 2023 17:09:52 +0000
From: Simon Horman <horms@kernel.org>
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
	haoluo@google.com, jolsa@kernel.org, kuba@kernel.org,
	toke@kernel.org, willemb@google.com, dsahern@kernel.org,
	magnus.karlsson@intel.com, bjorn@kernel.org,
	maciej.fijalkowski@intel.com, hawk@kernel.org,
	yoong.siang.song@intel.com, netdev@vger.kernel.org,
	xdp-hints@xdp-project.net
Subject: Re: [PATCH bpf-next v6 06/13] xsk: Document tx_metadata_len layout
Message-ID: <20231202170952.GB50400@kernel.org>
References: <20231127190319.1190813-1-sdf@google.com>
 <20231127190319.1190813-7-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127190319.1190813-7-sdf@google.com>

On Mon, Nov 27, 2023 at 11:03:12AM -0800, Stanislav Fomichev wrote:
> - how to use
> - how to query features
> - pointers to the examples
> 
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

...

> diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
> index 205696780b78..e3e9420fd817 100644
> --- a/Documentation/networking/xdp-rx-metadata.rst
> +++ b/Documentation/networking/xdp-rx-metadata.rst
> @@ -1,3 +1,5 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
>  ===============
>  XDP RX Metadata
>  ===============
> diff --git a/Documentation/networking/xsk-tx-metadata.rst b/Documentation/networking/xsk-tx-metadata.rst
> new file mode 100644
> index 000000000000..4f376560b23f
> --- /dev/null
> +++ b/Documentation/networking/xsk-tx-metadata.rst

Hi Stan,

could you send a follow-up patch to add an SPDX identifier here?

> @@ -0,0 +1,70 @@
> +==================
> +AF_XDP TX Metadata
> +==================

...

