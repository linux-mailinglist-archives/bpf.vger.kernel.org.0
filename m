Return-Path: <bpf+bounces-69941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9909CBA89E7
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 11:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C2193AF7FE
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 09:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A7B2C3263;
	Mon, 29 Sep 2025 09:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rkvlYptS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328A928466A;
	Mon, 29 Sep 2025 09:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137958; cv=none; b=ZNBcjPUgJ0TVQqA28h+o0w3AnASWKBj+bs5SgBxiiawAIZ3QjyTuTA5wvbm8Z7sjpgLLajHwf0+bBkq7K/uOo47apLOiX7df48P1gXGSwvmfqIjk1S7hkTfIBRMMv2qHgi0IADro7oHhajX8V5u5hYv78lE5FT6gNtzZvGwAVE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137958; c=relaxed/simple;
	bh=5NSXHwAmHTN2RIz7pn4i8jJ6CQKzoJ5MskXvfH6ROts=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DUZMBLyeYEz0eRZS50ZBnl9GYNkOA0xjrbK+ndbdyqeDq78D3j+xAWI8fbLumP2ZPbGliGceY4mtNku4jFL+DCmIPUksaIuuxvaj5crrpB/2mdsfeMirZy9cAsOnLS9j0sNyRl0PMHemFtsDWkr8aSfMQCuCZdPWFn+iIQJC19g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rkvlYptS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218C8C4CEF4;
	Mon, 29 Sep 2025 09:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759137957;
	bh=5NSXHwAmHTN2RIz7pn4i8jJ6CQKzoJ5MskXvfH6ROts=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=rkvlYptSIM7qq4/NP3QajaglGReKJujuT+HH+d7y30N/hv2ZuAApCEsolRmcMYSvc
	 z7jOQnfJ7002h33xDqNZ0Y6NKzDvcxNn7F4y6TYAFSG+2CD4bxGrTtM2KpI2F7TOTT
	 IDR8WiIjY+G+1pgW6Qsk3drGhUQdrNfHPVTSVZ9VGuqH0lMFOIfivk8mJbF2Z0vl+o
	 241tDwPr0nvxy1qmfN0Hu7dDxL0O1T3vuDFDnhznmfSg/I6RY0WvITD9DPTTYK5PzR
	 Ts/IjLMUQu38wa8K1DyG5m39SaFrIBEVtqJ633lE2si8cz2vwMuhsdebKT/8mivhvc
	 3Fjcu2x+gtj5w==
Message-ID: <ab14f430-f4a7-4d5f-8062-8d2113cf8e0d@kernel.org>
Date: Mon, 29 Sep 2025 10:25:54 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpf: Add hash chain signature support for
 arbitrary maps
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org, kpsingh@kernel.org,
 paul@paul-moore.com, kys@microsoft.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org,
 James.Bottomley@hansenpartnership.com, wufan@linux.microsoft.com
References: <20250926203111.1305999-1-bboscaccy@linux.microsoft.com>
 <20250926203111.1305999-2-bboscaccy@linux.microsoft.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250926203111.1305999-2-bboscaccy@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-09-26 13:30 UTC-0700 ~ Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> This patch introduces hash chain support for signature verification of
> arbitrary bpf map objects which was described here:
> https://lore.kernel.org/linux-security-module/20250721211958.1881379-1-kpsingh@kernel.org/
> 
> The UAPI is extended to allow for in-kernel checking of maps passed in
> via the fd_array. A hash chain is constructed from the maps, in order
> specified by the signature_maps field. The hash chain is terminated
> with the hash of the program itself.
> 
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> ---
>  include/uapi/linux/bpf.h                      |  6 ++
>  kernel/bpf/syscall.c                          | 73 ++++++++++++++++++-
>  .../bpf/bpftool/Documentation/bpftool-gen.rst |  7 +-
>  tools/bpf/bpftool/gen.c                       | 27 ++++++-
>  tools/bpf/bpftool/main.c                      |  9 ++-
>  tools/bpf/bpftool/main.h                      |  1 +
>  tools/bpf/bpftool/sign.c                      | 17 ++++-
>  tools/include/uapi/linux/bpf.h                |  6 ++
>  tools/lib/bpf/libbpf.h                        |  3 +-
>  tools/lib/bpf/skel_internal.h                 |  6 +-
>  10 files changed, 143 insertions(+), 12 deletions(-)
> 

[...]

> diff --git a/tools/bpf/bpftool/Documentation/bpftool-gen.rst b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> index d0a36f442db72..b632ab87adf20 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> @@ -16,7 +16,7 @@ SYNOPSIS
>  
>  **bpftool** [*OPTIONS*] **gen** *COMMAND*
>  
> -*OPTIONS* := { |COMMON_OPTIONS| | { **-L** | **--use-loader** } | [ { **-S** | **--sign** } {**-k** <private_key.pem>} **-i** <certificate.x509> ] }
> +*OPTIONS* := { |COMMON_OPTIONS| | { **-L** | **--use-loader** } | [ { **-S** | **--sign** } { **-M** | **--sign-maps** } {**-k** <private_key.pem>} **-i** <certificate.x509> ] }
>  
>  *COMMAND* := { **object** | **skeleton** | **help** }
>  
> @@ -190,6 +190,11 @@ OPTIONS
>      For skeletons, generate a signed skeleton. This option must be used with
>      **-k** and **-i**. Using this flag implicitly enables **--use-loader**.
>  
> +-M --sign-maps
> +    For skeletons, generate a signed skeleton that includes a hash chain for the
> +    skeletons maps. This option must be used with **-k** and **-i**. Using this
> +    flag implicitly enables **--use-loader** and **--sign**.
> +


Hi! Pardon my ignorance, I haven't followed all the details of the
discussions around signing. Is there a use case for signing the programs
only (using -S) without signing the maps (using -M)? Or should we
consider collapsing maps signing under the existing -S option?

If you do keep the new option, would you mind updating the bash
completion file, please? Simply adding the long form like this:

------

diff --git i/tools/bpf/bpftool/bash-completion/bpftool w/tools/bpf/bpftool/bash-completion/bpftool
index 53bcfeb1a76e..f8c217f09989 100644
--- i/tools/bpf/bpftool/bash-completion/bpftool
+++ w/tools/bpf/bpftool/bash-completion/bpftool
@@ -262,7 +262,7 @@ _bpftool()
     # Deal with options
     if [[ ${words[cword]} == -* ]]; then
         local c='--version --json --pretty --bpffs --mapcompat --debug \
-            --use-loader --base-btf --sign -i -k'
+            --use-loader --base-btf --sign --sign-maps -i -k'
         COMPREPLY=( $( compgen -W "$c" -- "$cur" ) )
         return 0
     fi

------

Other than that, the changes for bpftool look OK from my side. I'd
probably split the patch further into kernel/libbpf/bpftool changes, but
that's your call.

Thanks,
Quentin

