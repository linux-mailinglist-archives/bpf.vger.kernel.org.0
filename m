Return-Path: <bpf+bounces-74841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 39682C66D7E
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 02:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 23D4B4E1C91
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 01:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F5C30BF60;
	Tue, 18 Nov 2025 01:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwf//n6i"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3142F99BC;
	Tue, 18 Nov 2025 01:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763429710; cv=none; b=s2VGItO4UFZfAlFviTeukyopEGXrlGHCdamPXgtXLeOZ0z4JDLqbYRLGmHuoHbW5rmbdu+JuDyVzjtI+G7nJHptsb85zK5n3QK1TGKERXHOllykScGGPGpYS58EqbnXyEZUGObi0pKxNmgCzJZW1fxh86ckJ/iDmaXy+VdKS53M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763429710; c=relaxed/simple;
	bh=JEldkYSYqKrhysB+OxSUUdm8FS63jp4ava4/O4/bmU4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qQ2tmIJFnBnIIf/zhaWLeIDoHbs7a9gw+s1tUX7mbhsB6WmuvPZurnglLZ+Rg9kN3jPPpIZytsQBnDH2yAjgngcI2O8oDrYtXlqhbeFijVarHSkcRkGxCVuCxHoAZkMGzGRmbj9Kv/NzP38gd0TADVgDHGMnl11xIMJSYbXfir4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwf//n6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FD3C4AF0E;
	Tue, 18 Nov 2025 01:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763429706;
	bh=JEldkYSYqKrhysB+OxSUUdm8FS63jp4ava4/O4/bmU4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iwf//n6iKHpX5+o6LWDkVl+rzwkPYEyAvpVcp9IhYXejF0HoVKkJ9f74rxO7+217y
	 Y6Ee9vakQrToNrlcDx9v5S4dDX2NZpFH2BA1cM8iY8wtN8FXST0jVojioknx9MCEww
	 SIpmBJZbGSWDhb6HMgoNPuEG/WKGKSI7xeYD5gtc6Aqc3tdFlRhQylOS7KBoays0vL
	 qqTaz8IGO+msjsttIQRcIAXJSWtohH4/IHKvM5fWkIZ9SS9uxRcvBVtYRdOr/5x0gB
	 Nw0/gki6NIEb03ZPDXI15ud0hBvY+B9S4A1/ed3BVhLxvAoNf53olrMP+rBJu9lPAC
	 /qvMyFrz0cX2A==
Date: Mon, 17 Nov 2025 17:35:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 <bpf@vger.kernel.org>, Nimrod Oren <noren@nvidia.com>
Subject: Re: [PATCH net-next 1/3] tools: ynl: cli: Add --list-attrs option
 to show operation attributes
Message-ID: <20251117173503.3774c532@kernel.org>
In-Reply-To: <20251116192845.1693119-2-gal@nvidia.com>
References: <20251116192845.1693119-1-gal@nvidia.com>
	<20251116192845.1693119-2-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Nov 2025 21:28:43 +0200 Gal Pressman wrote:
> Add a --list-attrs option to the YNL CLI that displays information about
> netlink operations, including request and reply attributes.
> This eliminates the need to manually inspect YAML spec files to
> determine the JSON structure required for operations, or understand the
> structure of the reply.
> 
> Example usage:
>   # ./cli.py --family netdev --list-attrs dev-get
>   Operation: dev-get
> 
>   Do request attributes:
>     - ifindex: u32
>       netdev ifindex
> 
>   Do reply attributes:
>     - ifindex: u32
>       netdev ifindex
>     - xdp-features: u64 (enum: xdp-act)
>       Bitmask of enabled xdp-features.
>     - xdp-zc-max-segs: u32
>       max fragment count supported by ZC driver
>     - xdp-rx-metadata-features: u64 (enum: xdp-rx-metadata)
>       Bitmask of supported XDP receive metadata features. See Documentation/networking/xdp-rx-metadata.rst for more details.
>     - xsk-features: u64 (enum: xsk-flags)
>       Bitmask of enabled AF_XDP features.
> 
>   Dump reply attributes:
>     - ifindex: u32
>       netdev ifindex
>     - xdp-features: u64 (enum: xdp-act)
>       Bitmask of enabled xdp-features.
>     - xdp-zc-max-segs: u32
>       max fragment count supported by ZC driver
>     - xdp-rx-metadata-features: u64 (enum: xdp-rx-metadata)
>       Bitmask of supported XDP receive metadata features. See Documentation/networking/xdp-rx-metadata.rst for more details.
>     - xsk-features: u64 (enum: xsk-flags)
>       Bitmask of enabled AF_XDP features.

Could you try to detect that do and dump replies are identical 
and combine them? They are the same more often than not so 
I think it'd be nice to avoid printing the same info twice.

> Reviewed-by: Nimrod Oren <noren@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> ---
>  tools/net/ynl/pyynl/cli.py | 55 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/tools/net/ynl/pyynl/cli.py b/tools/net/ynl/pyynl/cli.py
> index 8c192e900bd3..7ac3b4627f1b 100755
> --- a/tools/net/ynl/pyynl/cli.py
> +++ b/tools/net/ynl/pyynl/cli.py
> @@ -7,6 +7,7 @@ import os
>  import pathlib
>  import pprint
>  import sys
> +import textwrap
>  
>  sys.path.append(pathlib.Path(__file__).resolve().parent.as_posix())
>  from lib import YnlFamily, Netlink, NlError
> @@ -70,6 +71,8 @@ def main():
>      group.add_argument('--dump', dest='dump', metavar='DUMP-OPERATION', type=str)
>      group.add_argument('--list-ops', action='store_true')
>      group.add_argument('--list-msgs', action='store_true')
> +    group.add_argument('--list-attrs', dest='list_attrs', metavar='OPERATION', type=str,
> +                       help='List attributes for an operation')
>  
>      parser.add_argument('--duration', dest='duration', type=int,
>                          help='when subscribed, watch for DURATION seconds')
> @@ -128,6 +131,40 @@ def main():
>      if args.ntf:
>          ynl.ntf_subscribe(args.ntf)
>  
> +    def print_attr_list(attr_names, attr_set):

It nesting functions inside main() a common pattern for Python?
Having a function declared in the middle of another function,
does not seem optimal to me, but for some reason Claude loves
to do that.

> +        """Print a list of attributes with their types and documentation."""
> +        for attr_name in attr_names:
> +            if attr_name in attr_set.attrs:
> +                attr = attr_set.attrs[attr_name]
> +                attr_info = f'  - {attr_name}: {attr.type}'
> +                if 'enum' in attr.yaml:
> +                    attr_info += f" (enum: {attr.yaml['enum']})"
> +                if attr.yaml.get('doc'):
> +                    doc_text = textwrap.indent(attr.yaml['doc'], '    ')
> +                    attr_info += f"\n{doc_text}"
> +                print(attr_info)
> +            else:
> +                print(f'  - {attr_name}')
> +

