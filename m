Return-Path: <bpf+bounces-69211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D72EB9056B
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 13:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCF183BEE90
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 11:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8BD304BCD;
	Mon, 22 Sep 2025 11:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrnGRA4/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4EC25DB12;
	Mon, 22 Sep 2025 11:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758540266; cv=none; b=KpmWGgQIGubTTIKMs7MPSvdN5frjZUrNt+S8bvcP7k04GfLApKdHOnce8g50NxZR16dp3zMUkk8g0/Z7updWMieuYnaZDkAx7rt614BDXhtYM0ANcrrjvqt3sYQ3o1VJZYiapTV4aGu6APo5Eh5ZOHKinTuc8UYMpO/MUVVvDpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758540266; c=relaxed/simple;
	bh=MHCJxBHBeiXGvHrLS5WxOEFMMUqHB7NSgwFg3a5BCRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T5/oLv4xbmzxxq1k3n2/ayaPINwX+D4xL83AoKdQDGBvglyRGUwCX3IVtFa5RyWjU+ArF/lZIu2JAS5h7vKY6ziQ3RWBWQroq/oS9iH6IwXp5ZMb+eszhW9XU5EGYulmaGXtYeJ/U3NYJXtZ6wYLEQ3Q8tK9kJqE0/agLBAS8XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrnGRA4/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB157C4CEF0;
	Mon, 22 Sep 2025 11:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758540266;
	bh=MHCJxBHBeiXGvHrLS5WxOEFMMUqHB7NSgwFg3a5BCRg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TrnGRA4/dJX85Ar94qXDv0/Xajzz6ma6Pry1a5sRxhGXQ6w19NpFVVGkTvD3P8OTu
	 B0omiZlffwnV3E94UEuPPmWtESh7mlF4RFTuA3FZbaio/KyhNTXcAylHfNEOHLmhSb
	 F1RjV5VFa6mRcyVL301ltcDEaM0lG2rwonHnpbyJSHdX5fQ4p335uQQjoOhzoT/+On
	 F+RS/TSwC1n0XrXDqk0iM4OCPeK5EcUx/Vcrx2IfS+H3lxLTqRA1TgrvD0/zUbgt+w
	 2bapvh9si8mYEyIfX1HPGnDKIQ03SBuzD0DOcr1hEqsibCsrM9jn/6vE4IlgrtyZwL
	 TDybS3jmPhCUQ==
Message-ID: <ee292661-0ffb-413e-be9c-eb21f5379688@kernel.org>
Date: Mon, 22 Sep 2025 12:24:23 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 4/5] bpftool: Add support for signing BPF
 programs
To: KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org
Cc: bboscaccy@linux.microsoft.com, paul@paul-moore.com, kys@microsoft.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
References: <20250921160120.9711-1-kpsingh@kernel.org>
 <20250921160120.9711-5-kpsingh@kernel.org>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250921160120.9711-5-kpsingh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-09-21 18:01 UTC+0200 ~ KP Singh <kpsingh@kernel.org>
> Two modes of operation being added:
> 
> Add two modes of operation:
> 
> * For prog load, allow signing a program immediately before loading. This
>   is essential for command-line testing and administration.
> 
>       bpftool prog load -S -k <private_key> -i <identity_cert> fentry_test.bpf.o
> 
> * For gen skeleton, embed a pre-generated signature into the C skeleton
>   file. This supports the use of signed programs in compiled applications.
> 
>       bpftool gen skeleton -S -k <private_key> -i <identity_cert> fentry_test.bpf.o
> 
> Generation of the loader program and its metadata map is implemented in
> libbpf (bpf_obj__gen_loader). bpftool generates a skeleton that loads
> the program and automates the required steps: freezing the map, creating
> an exclusive map, loading, and running. Users can use standard libbpf
> APIs directly or integrate loader program generation into their own
> toolchains.
> 
> Signed-off-by: KP Singh <kpsingh@kernel.org>


Acked-by: Quentin Monnet <qmo@kernel.org>

Thanks a lot!


> ---
>  .../bpf/bpftool/Documentation/bpftool-gen.rst |  13 +-
>  .../bpftool/Documentation/bpftool-prog.rst    |  14 +-
>  tools/bpf/bpftool/Makefile                    |   6 +-
>  tools/bpf/bpftool/cgroup.c                    |   4 +
>  tools/bpf/bpftool/gen.c                       |  68 +++++-
>  tools/bpf/bpftool/main.c                      |  26 ++-
>  tools/bpf/bpftool/main.h                      |  11 +
>  tools/bpf/bpftool/prog.c                      |  29 ++-
>  tools/bpf/bpftool/sign.c                      | 212 ++++++++++++++++++
>  9 files changed, 372 insertions(+), 11 deletions(-)
>  create mode 100644 tools/bpf/bpftool/sign.c
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-gen.rst b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> index ca860fd97d8d..d0a36f442db7 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> @@ -16,7 +16,7 @@ SYNOPSIS
>  
>  **bpftool** [*OPTIONS*] **gen** *COMMAND*
>  
> -*OPTIONS* := { |COMMON_OPTIONS| | { **-L** | **--use-loader** } }
> +*OPTIONS* := { |COMMON_OPTIONS| | { **-L** | **--use-loader** } | [ { **-S** | **--sign** } {**-k** <private_key.pem>} **-i** <certificate.x509> ] }
>  
>  *COMMAND* := { **object** | **skeleton** | **help** }
>  
> @@ -186,6 +186,17 @@ OPTIONS
>      skeleton). A light skeleton contains a loader eBPF program. It does not use
>      the majority of the libbpf infrastructure, and does not need libelf.
>  
> +-S, --sign
> +    For skeletons, generate a signed skeleton. This option must be used with
> +    **-k** and **-i**. Using this flag implicitly enables **--use-loader**.
> +
> +-k <private_key.pem>
> +    Path to the private key file in PEM format, required for signing.
> +
> +-i <certificate.x509>
> +    Path to the X.509 certificate file in PEM or DER format, required for
> +    signing.
> +
>  EXAMPLES
>  ========
>  **$ cat example1.bpf.c**
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> index f69fd92df8d8..009633294b09 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> @@ -18,7 +18,7 @@ SYNOPSIS
>  
>  *OPTIONS* := { |COMMON_OPTIONS| |
>  { **-f** | **--bpffs** } | { **-m** | **--mapcompat** } | { **-n** | **--nomount** } |
> -{ **-L** | **--use-loader** } }
> +{ **-L** | **--use-loader** } | [ { **-S** | **--sign** } **-k** <private_key.pem> **-i** <certificate.x509> ] }


Perfect, thank you!


>  
>  *COMMANDS* :=
>  { **show** | **list** | **dump xlated** | **dump jited** | **pin** | **load** |
> @@ -248,6 +248,18 @@ OPTIONS
>      creating the maps, and loading the programs (see **bpftool prog tracelog**
>      as a way to dump those messages).
>  
> +-S, --sign
> +    Enable signing of the BPF program before loading. This option must be
> +    used with **-k** and **-i**. Using this flag implicitly enables
> +    **--use-loader**.
> +
> +-k <private_key.pem>
> +    Path to the private key file in PEM format, required when signing.
> +
> +-i <certificate.x509>
> +    Path to the X.509 certificate file in PEM or DER format, required when
> +    signing.
> +
>  EXAMPLES
>  ========
>  **# bpftool prog show**
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index 9e9a5f006cd2..586d1b2595d1 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -130,8 +130,8 @@ include $(FEATURES_DUMP)
>  endif
>  endif
>  
> -LIBS = $(LIBBPF) -lelf -lz
> -LIBS_BOOTSTRAP = $(LIBBPF_BOOTSTRAP) -lelf -lz
> +LIBS = $(LIBBPF) -lelf -lz -lcrypto
> +LIBS_BOOTSTRAP = $(LIBBPF_BOOTSTRAP) -lelf -lz -lcrypto
>  
>  ifeq ($(feature-libelf-zstd),1)
>  LIBS += -lzstd
> @@ -194,7 +194,7 @@ endif
>  
>  BPFTOOL_BOOTSTRAP := $(BOOTSTRAP_OUTPUT)bpftool
>  
> -BOOTSTRAP_OBJS = $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o json_writer.o gen.o btf.o)
> +BOOTSTRAP_OBJS = $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o json_writer.o gen.o btf.o sign.o)
>  $(BOOTSTRAP_OBJS): $(LIBBPF_BOOTSTRAP)
>  
>  OBJS = $(patsubst %.c,$(OUTPUT)%.o,$(SRCS)) $(OUTPUT)disasm.o
> diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
> index 944ebe21a216..ec356deb27c9 100644
> --- a/tools/bpf/bpftool/cgroup.c
> +++ b/tools/bpf/bpftool/cgroup.c
> @@ -2,6 +2,10 @@
>  // Copyright (C) 2017 Facebook
>  // Author: Roman Gushchin <guro@fb.com>
>  
> +#undef GCC_VERSION
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif
>  #define _XOPEN_SOURCE 500
>  #include <errno.h>
>  #include <fcntl.h>
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index 67a60114368f..993c7d9484a4 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c

> @@ -1930,7 +1990,7 @@ static int do_help(int argc, char **argv)
>  		"       %1$s %2$s help\n"
>  		"\n"
>  		"       " HELP_SPEC_OPTIONS " |\n"
> -		"                    {-L|--use-loader} }\n"
> +		"                    {-L|--use-loader} | [ {-S|--sign } {-k} <private_key.pem> {-i} <certificate.x509> ]}\n"


With regards to our discussion on v4 - Sorry, I had not realised
removing the braces would make the sync test fail. ACK for keeping them
until this is resolved in the test.

As for the bash completion, I agree this should not block this series.
Please make sure to follow-up with it. I think it should be as follows:

------

diff --git i/tools/bpf/bpftool/bash-completion/bpftool w/tools/bpf/bpftool/bash-completion/bpftool
index 527bb47ac462..53bcfeb1a76e 100644
--- i/tools/bpf/bpftool/bash-completion/bpftool
+++ w/tools/bpf/bpftool/bash-completion/bpftool
@@ -262,7 +262,7 @@ _bpftool()
     # Deal with options
     if [[ ${words[cword]} == -* ]]; then
         local c='--version --json --pretty --bpffs --mapcompat --debug \
-            --use-loader --base-btf'
+            --use-loader --base-btf --sign -i -k'
         COMPREPLY=( $( compgen -W "$c" -- "$cur" ) )
         return 0
     fi
@@ -283,7 +283,7 @@ _bpftool()
             _sysfs_get_netdevs
             return 0
             ;;
-        file|pinned|-B|--base-btf)
+        file|pinned|-B|--base-btf|-i|-k)
             _filedir
             return 0
             ;;
@@ -296,13 +296,21 @@ _bpftool()
     # Remove all options so completions don't have to deal with them.
     local i pprev
     for (( i=1; i < ${#words[@]}; )); do
-        if [[ ${words[i]::1} == - ]] &&
-            [[ ${words[i]} != "-B" ]] && [[ ${words[i]} != "--base-btf" ]]; then
-            words=( "${words[@]:0:i}" "${words[@]:i+1}" )
-            [[ $i -le $cword ]] && cword=$(( cword - 1 ))
-        else
-            i=$(( ++i ))
-        fi
+        case ${words[i]} in
+            # Remove option and its argument
+            -B|--base-btf|-i|-k)
+                words=( "${words[@]:0:i}" "${words[@]:i+2}" )
+                [[ $i -le $(($cword + 1)) ]] && cword=$(( cword - 2 ))
+                ;;
+            # No argument, remove option only
+            -*)
+                words=( "${words[@]:0:i}" "${words[@]:i+1}" )
+                [[ $i -le $cword ]] && cword=$(( cword - 1 ))
+                ;;
+            *)
+                i=$(( ++i ))
+                ;;
+        esac
     done
     cur=${words[cword]}
     prev=${words[cword - 1]}


