Return-Path: <bpf+bounces-58396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 991BCAB99F6
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 12:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF2F89E6454
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 10:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C8A227E83;
	Fri, 16 May 2025 10:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3mXICJJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D685D381C4;
	Fri, 16 May 2025 10:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747390718; cv=none; b=KCVWBRXdTVsaW19GKs9MZyFgX1KFu93UdTomVlIM3+skswrhDKy0qKH7VRvUmZMeNFYiay/SX4mNr94QOA/tC+oMc+CBUs4Mqg8e+NGFRV8OY2E+wyY3OhPNVbP8DqANkyBuomCKnTRXI5mB5PEAXSxTuTgvN9Wxap+nlXORry8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747390718; c=relaxed/simple;
	bh=i131/A59sXtp21nNvGxoWEaQce+rFrKSV6S4e1Sr2+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nCrOWK0cgnxihnMn4fxyJ8U4i422S1fK02h4X3fSPvey6kccoM4KvteBPQe7GyYvqIx3ivqurvyweSt7V3V8Z+DoCLgSbM8XhFEr2YlDzm6ZR+8Puhvr/oSIEuFRbzPf0itlcDN/Vrd7mXHrvYQ6VD4mJm6oNqFmUo+QEtpY27w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3mXICJJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88CFBC4CEE4;
	Fri, 16 May 2025 10:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747390718;
	bh=i131/A59sXtp21nNvGxoWEaQce+rFrKSV6S4e1Sr2+Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P3mXICJJOZyaSegUEy8iLHArWfw9yPvdifaiN1NlDBGTwuJmKoDk3Q95uN5G31+p5
	 YcKdUcMIJHWOoPSZ2frtZHJEQOaiwbiv4BaetfttzVn1qpQcN57ZQlSzVeni+2kg80
	 pj2I3iLnVyx51Agwp1wT2T27+KPXP9ecfPF/+p//ZeuvUhJGyiYycjseIKeyCXQ7gj
	 OPNZzzb7Mk7ZQ+P6sCGPaIrAv/vA2/b36jBzQsw/bupl6KN0uBfq0hlr/XttkLVU0b
	 zm1UBdDOAYmSOd4o0gBYy4+3ym6l53mcGhqaYsjCfQuat0/YRXgvKB+XpYzQGBPShA
	 ta8WdvGXcI96A==
Message-ID: <9909038f-a005-440a-82f2-ebe2f2da0767@kernel.org>
Date: Fri, 16 May 2025 11:18:33 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3] bpftool: Add support for custom BTF path in
 prog load/loadall
To: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykyta Yatsenko <yatsenko@meta.com>,
 Daniel Xu <dxu@dxuuu.xyz>, Tao Chen <chen.dylane@gmail.com>,
 linux-kernel@vger.kernel.org
References: <20250516032312.275261-1-jiayuan.chen@linux.dev>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250516032312.275261-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-05-16 11:23 UTC+0800 ~ Jiayuan Chen <jiayuan.chen@linux.dev>
> This patch exposes the btf_custom_path feature to bpftool, allowing users
> to specify a custom BTF file when loading BPF programs using prog load or
> prog loadall commands.
> 
> The argument 'btf_custom_path' in libbpf is used for those kernels that
> don't have CONFIG_DEBUG_INFO_BTF enabled but still want to perform CO-RE
> relocations.
> 
> Suggested-by: Quentin Monnet <qmo@kernel.org>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> 
> ---
> V2 -> V3: Optimized document grammar and some prompts
> https://lore.kernel.org/bpf/20250515065018.240188-1-jiayuan.chen@linux.dev/
> V1 -> V2: Added bash completion and documentation
> https://lore.kernel.org/bpf/20250513035853.75820-1-jiayuan.chen@linux.dev/
> ---
>  tools/bpf/bpftool/Documentation/bpftool-prog.rst |  8 +++++++-
>  tools/bpf/bpftool/bash-completion/bpftool        |  4 ++--
>  tools/bpf/bpftool/prog.c                         | 12 +++++++++++-
>  3 files changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> index d6304e01afe0..4dce43e8e8a3 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> @@ -127,7 +127,7 @@ bpftool prog pin *PROG* *FILE*
>      Note: *FILE* must be located in *bpffs* mount. It must not contain a dot
>      character ('.'), which is reserved for future extensions of *bpffs*.
>  
> -bpftool prog { load | loadall } *OBJ* *PATH* [type *TYPE*] [map { idx *IDX* | name *NAME* } *MAP*] [{ offload_dev | xdpmeta_dev } *NAME*] [pinmaps *MAP_DIR*] [autoattach]
> +bpftool prog { load | loadall } *OBJ* *PATH* [type *TYPE*] [map { idx *IDX* | name *NAME* } *MAP*] [{ offload_dev | xdpmeta_dev } *NAME*] [pinmaps *MAP_DIR*] [autoattach] [kernel_btf *BTF_FILE*]

Woops, I just realised we also need to add kernel_btf to the command
summary at the top of the document (line 34), sorry for missing it
during the previous pass. Please add it, and mark v4 as:

    Reviewed-by: Quentin Monnet <qmo@kernel.org>

Thanks!

