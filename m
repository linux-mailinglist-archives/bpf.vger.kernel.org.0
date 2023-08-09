Return-Path: <bpf+bounces-7402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3133C776A5C
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 22:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57BAF1C204F3
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 20:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E88C1D2E5;
	Wed,  9 Aug 2023 20:39:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518D32453D;
	Wed,  9 Aug 2023 20:39:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BE7C433C7;
	Wed,  9 Aug 2023 20:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691613550;
	bh=rq2wXj+gxl3x0uMei6ht6EQ2n0BWRHtFxM8peXs/z/I=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Vs4x4QY89JlD1nL5EF3yLn0Q1LJ5mdMJtIhUS7lrL3TNNKjy5PwEai8EI+CeLONwG
	 aR3guH1sa7h5/E1OOBOui2X3+vOsgF6YAbdpwT7Y66MigK8ZNPjNcvr4Cz6x+V/bgH
	 58IZA1ec/yeCj14Vkqa6zw6h5xNBOoI40iWTJ7xL7XuoV4NFq8lmjzJ24xhY09leUJ
	 RiEaBPgZRk/RdeCFNZI1r3uWR4ZwVTTxuPw0yPPBbcDFmuElh2czHQh3GkTN+Q2rHS
	 Lb4TJMERzXskltSC2wyubiFSFymhW63q8bMlTyr+bmXfGC23rfL9hM6nBBsU7cYjJD
	 el+98k03Sv87w==
Message-ID: <54dc8831-a001-c17d-7b7e-ab1337c7f75c@kernel.org>
Date: Wed, 9 Aug 2023 22:39:04 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org, kuba@kernel.org,
 toke@kernel.org, willemb@google.com, dsahern@kernel.org,
 magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com,
 hawk@kernel.org, netdev@vger.kernel.org, xdp-hints@xdp-project.net
Subject: Re: [xdp-hints] [PATCH bpf-next 9/9] xsk: document
 XDP_TX_METADATA_LEN layout
Content-Language: en-US
To: Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
References: <20230809165418.2831456-1-sdf@google.com>
 <20230809165418.2831456-10-sdf@google.com>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20230809165418.2831456-10-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 09/08/2023 18.54, Stanislav Fomichev wrote:
> +Example
> +=======
> +
> +See ``tools/testing/selftests/bpf/xdp_hw_metadata.c`` for an example
> +program that handles TX metadata. Also see https://github.com/fomichev/xskgen
> +for a more bare-bones example.

Will you consider maintaining this AF_XDP example here:
  https://github.com/xdp-project/bpf-examples

E..g. the kernels old samples/bpf/xdpsock program moved here:
  https://github.com/xdp-project/bpf-examples/tree/master/AF_XDP-example

--Jesper
p.s. Compile fail for fomichev/xskgen on my system

