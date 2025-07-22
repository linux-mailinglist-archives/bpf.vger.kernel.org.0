Return-Path: <bpf+bounces-64062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9521BB0DFF9
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 17:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 767291C803CC
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 15:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0292ED15E;
	Tue, 22 Jul 2025 15:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orDsfNxZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED1B2BF010;
	Tue, 22 Jul 2025 15:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196497; cv=none; b=On0iKXmHWR1nYHQSgN7+csQTElLiMNvC0olRP79tp+HIxu6Qd6DNl1ngF+tfNP4AIrs1N00YMO6OJ1jhlt7VN/6Gs89HnY746c6hbKS/JT1CEvPdACMBnPimxAaw5BaRu9J/EpDbmhfnaow8IeILjsjO8vorq1HFY4ASv/ti+Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196497; c=relaxed/simple;
	bh=y8xwXglfL5yOkr3XOPuaZfoiI2Gx0zJq1Z20AiQpwIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G80wo/l/ybZW62UsPk7S/lpLSJH5Hx2qL843Lw3anYSJnEN9hz2Mki/psObs3Et+EJZm05g/Fyat32f0oDTFXeZQIzSiZ8vU6hgUdEowta8jgo6kVT33tvztLMsBCdwE0QwQB916w/vXjhchg/iRVtpEvbaXjfmgWm+MlWNTToc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orDsfNxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5F1C4CEF6;
	Tue, 22 Jul 2025 15:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753196495;
	bh=y8xwXglfL5yOkr3XOPuaZfoiI2Gx0zJq1Z20AiQpwIE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=orDsfNxZ36MNMlYJHvOeoM0oghYBdnUbjPMh84VBKDxx3dM+zNm5oTdv5QBGe+XdA
	 JHBR/mupXS+iQpZhta9gzSj1tOxALA0BfGOtHcRsD6BD3kYo5X2SzbRU+fJxzoDmK9
	 toe+ZrhVPxloop9HSJ5GFsttx2nv1XYHxX892PFEpho9xgzlYXb7uLbqY/P+5ZP4Ir
	 M57C+uqIErRPL3V8lvyeGFbVKZoYBUtngO5gmWik+35cpvHx0kw1R4RuJPu3tSdtSh
	 7DK2u72ErIUfDe/l2zJUz7JrveAh5wcOuAZ053Bg9KK4HRd+AklvmX+XN0iwyEGsFn
	 xNa50vV20GyAA==
Message-ID: <2e3a00c0-dc18-40d4-af2a-ce8df4e54021@kernel.org>
Date: Tue, 22 Jul 2025 16:01:31 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/3] bpftool: Add bpftool-token manpage
To: Tao Chen <chen.dylane@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250722120912.1391604-1-chen.dylane@linux.dev>
 <20250722120912.1391604-2-chen.dylane@linux.dev>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250722120912.1391604-2-chen.dylane@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-07-22 20:09 UTC+0800 ~ Tao Chen <chen.dylane@linux.dev>
> Add bpftool-token manpage with information and examples of token-related
> commands.
> 
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  .../bpftool/Documentation/bpftool-token.rst   | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 tools/bpf/bpftool/Documentation/bpftool-token.rst
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-token.rst b/tools/bpf/bpftool/Documentation/bpftool-token.rst
> new file mode 100644
> index 00000000000..c5fe9292258
> --- /dev/null
> +++ b/tools/bpf/bpftool/Documentation/bpftool-token.rst
> @@ -0,0 +1,63 @@
> +.. SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +
> +================
> +bpftool-token
> +================
> +-------------------------------------------------------------------------------
> +tool for inspection and simple manipulation of eBPF tokens
> +-------------------------------------------------------------------------------
> +
> +:Manual section: 8
> +
> +.. include:: substitutions.rst
> +
> +SYNOPSIS
> +========
> +
> +**bpftool** [*OPTIONS*] **token** *COMMAND*
> +
> +*OPTIONS* := { |COMMON_OPTIONS| }
> +
> +*COMMANDS* := { **show** | **list** | **help** }
> +
> +TOKEN COMMANDS
> +===============
> +
> +| **bpftool** **token** { **show** | **list** }
> +| **bpftool** **token help**
> +|
> +
> +DESCRIPTION
> +===========
> +bpftool token { show | list }
> +    List all the speciafic allowed types for **bpf**\ () system call


Typo: "speciafic". 


> +    commands, maps, programs, and attach types, as well as the
> +    *bpffs* mount point used to set the token information.


This sentence needs to be adjusted now that you can print info for
several mountpoints.

How about:

    List BPF token information for each *bpffs* mount point containing token
    information on the system. Information include mount point path, allowed
    **bpf**\ () system call commands, maps, programs, and attach types for the
    token.


> +
> +bpftool prog help
> +    Print short help message.
> +
> +OPTIONS
> +========
> +.. include:: common_options.rst
> +
> +EXAMPLES
> +========
> +|
> +| **# mkdir -p /sys/fs/bpf/token**
> +| **# mount -t bpf bpffs /sys/fs/bpf/token** \
> +|         **-o delegate_cmds=prog_load:map_create** \
> +|         **-o delegate_progs=kprobe** \
> +|         **-o delegate_attachs=xdp**
> +| **# bpftool token list**
> +
> +::
> +
> +    token_info  /sys/fs/bpf/token
> +            allowed_cmds:
> +              map_create          prog_load
> +            allowed_maps:
> +            allowed_progs:
> +              kprobe
> +            allowed_attachs:
> +              xdp


