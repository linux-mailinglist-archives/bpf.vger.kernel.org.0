Return-Path: <bpf+bounces-58282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FAAAB824A
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 11:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AC0C1B61C00
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 09:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081BE29670A;
	Thu, 15 May 2025 09:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdzhbpG3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8098C1F09AD;
	Thu, 15 May 2025 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747300629; cv=none; b=MnzbQKc7HQ6S4HCUeSbHzkFp1JpIOa+9hLW9Um9Gqx9tM2zfeoYExXU9ZuBSbY3y2yjxsgVKg2SwDZsQ0sKifZFa9ytC5A0GILnn4cl9STzDoF3wULqQ0Hh2kbxdYFnMCvziqIXLj1b6ZNAm5eepo88epzINPtMlzZI66v2+9fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747300629; c=relaxed/simple;
	bh=QVKOlT5ufDwX7I65S3zH6n+hABL8lXqI6aFRrHvjK7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jZd2STN6IzOO0DuV2z5yc1hw5PKSWAdVC8s4cxuQcu1fdytOzzteZaxSjXrjV5YvICoE8RLhd+DzSK9Zk7K9OhrqBPsX47bszi7paYONv8eTBuEizdaVnGlkeb8V/yDMa+lXbKSFgT/lQgCnqOf1+6TNQxSsFWjpQcOn62bA6sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdzhbpG3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC5BC4CEE9;
	Thu, 15 May 2025 09:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747300629;
	bh=QVKOlT5ufDwX7I65S3zH6n+hABL8lXqI6aFRrHvjK7k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KdzhbpG3zkVRx5Lyuw4wjB54O3iU36v1AdIu5FCTbZ6GO90HOSOUaEOkbY0ENXYLK
	 u0YzV4pdXreYzzHNek1rZbTmse/RAJv9pRglfVY1+UPacLDTiW11ot5QH7he3810QV
	 HsSjiwGzJ9/h7lgTxsPOve0zeWqaOsBujQzeHEhhdazyh33zHJAcQX1J/I9Xp4dW3F
	 HMG3e96Y2uyZgUtlHhgUSH3FY5TaS91vq44gLDL4jSrTgHKnaIuLN9HsdfqlUA6xzG
	 /tt3ZLiUsjzycxVZ8UgU0Cb5FGY3vNqA2k75m/1v/uLoRV+QYrFtgVAizbP8DebhVO
	 mcuG4UKigfNSA==
Message-ID: <d4e30634-b64e-47c7-9089-a37d20e29d2f@kernel.org>
Date: Thu, 15 May 2025 10:17:05 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpftool: Add support for custom BTF path in
 prog load/loadall
To: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>,
 Mykyta Yatsenko <yatsenko@meta.com>, Tao Chen <chen.dylane@gmail.com>,
 linux-kernel@vger.kernel.org
References: <20250515065018.240188-1-jiayuan.chen@linux.dev>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250515065018.240188-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2025-05-15 14:50 UTC+0800 ~ Jiayuan Chen <jiayuan.chen@linux.dev>
> This patch exposes the btf_custom_path feature to bpftool, allowing users
> to specify a custom BTF file when loading BPF programs using prog load or
> prog loadall commands.
> 
> The argument 'btf_custom_path' in libbpf is used for those kernes that


Typo: "kernes"


> don't have CONFIG_DEBUG_INFO_BTF enabled but still want to perform CO-RE
> relocations.
> 
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  tools/bpf/bpftool/Documentation/bpftool-prog.rst |  7 ++++++-
>  tools/bpf/bpftool/bash-completion/bpftool        |  2 +-
>  tools/bpf/bpftool/prog.c                         | 12 +++++++++++-
>  3 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> index d6304e01afe0..e60a829ab8d0 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> @@ -127,7 +127,7 @@ bpftool prog pin *PROG* *FILE*
>      Note: *FILE* must be located in *bpffs* mount. It must not contain a dot
>      character ('.'), which is reserved for future extensions of *bpffs*.
>  
> -bpftool prog { load | loadall } *OBJ* *PATH* [type *TYPE*] [map { idx *IDX* | name *NAME* } *MAP*] [{ offload_dev | xdpmeta_dev } *NAME*] [pinmaps *MAP_DIR*] [autoattach]
> +bpftool prog { load | loadall } *OBJ* *PATH* [type *TYPE*] [map { idx *IDX* | name *NAME* } *MAP*] [{ offload_dev | xdpmeta_dev } *NAME*] [pinmaps *MAP_DIR*] [autoattach] [kernel_btf *BTF_DIR*]
>      Load bpf program(s) from binary *OBJ* and pin as *PATH*. **bpftool prog
>      load** pins only the first program from the *OBJ* as *PATH*. **bpftool prog
>      loadall** pins all programs from the *OBJ* under *PATH* directory. **type**
> @@ -153,6 +153,11 @@ bpftool prog { load | loadall } *OBJ* *PATH* [type *TYPE*] [map { idx *IDX* | na
>      program does not support autoattach, bpftool falls back to regular pinning
>      for that program instead.
>  
> +    The **kernel_btf** option allows specifying an external BTF file to replace
> +    the system's own vmlinux BTF file for CO-RE relocations. NOTE that any
> +    other feature (e.g., fentry/fexit programs, struct_ops, etc) will require


Nit: No need for both "e.g." and "etc", they're redundant.


> +    actual kernel BTF like /sys/kernel/btf/vmlinux.
> +


Can we rephrase the second part of the paragraph a little bit please?
“Any other feature” could be clearer, how about:

	Note that any other feature relying on BTF (such as fentry/fexit
	programs, struct_ops) requires the BTF file for the actual
	kernel running on the host, often exposed at
	/sys/kernel/btf/vmlinux.


>      Note: *PATH* must be located in *bpffs* mount. It must not contain a dot
>      character ('.'), which is reserved for future extensions of *bpffs*.
>  
> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
> index 1ce409a6cbd9..609938c287b7 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool
> @@ -511,7 +511,7 @@ _bpftool()
>                              ;;
>                          *)
>                              COMPREPLY=( $( compgen -W "map" -- "$cur" ) )
> -                            _bpftool_once_attr 'type pinmaps autoattach'
> +                            _bpftool_once_attr 'type pinmaps autoattach kernel_btf'
>                              _bpftool_one_of_list 'offload_dev xdpmeta_dev'
>                              return 0
>                              ;;


Correct, but right before this could you also add the following, please:

	@@ -505,13 +505,13 @@ _bpftool()
	                             _bpftool_get_map_names
	                             return 0
	                             ;;
	-                        pinned|pinmaps)
	+                        pinned|pinmaps|kernel_btf)
	                             _filedir
	                             return 0
	                             ;;
	                         *)

This will make the completion offer file names after the user has typed
"kernel_btf".


> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index f010295350be..3b6a361dd0f8 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -1681,8 +1681,17 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
>  		} else if (is_prefix(*argv, "autoattach")) {
>  			auto_attach = true;
>  			NEXT_ARG();
> +		} else if (is_prefix(*argv, "kernel_btf")) {
> +			NEXT_ARG();
> +
> +			if (!REQ_ARGS(1))
> +				goto err_free_reuse_maps;
> +
> +			open_opts.btf_custom_path = GET_ARG();
>  		} else {
> -			p_err("expected no more arguments, 'type', 'map' or 'dev', got: '%s'?",
> +			p_err("expected no more arguments, "
> +			      "'type', 'map', 'dev', 'offload_dev', 'xdpmeta_dev', 'pinmaps', "
> +			      "'autoattach', or 'kernel_btf', got: '%s'?",


Some of them were missing, thanks for this! Can you remove "dev" from
the list, please? It's been deprecated in favour of "offload_dev", to
avoid confusion with "xdpmeta_dev".

pw-bot: cr


>  			      *argv);
>  			goto err_free_reuse_maps;
>  		}
> @@ -2474,6 +2483,7 @@ static int do_help(int argc, char **argv)
>  		"                         [map { idx IDX | name NAME } MAP]\\\n"
>  		"                         [pinmaps MAP_DIR]\n"
>  		"                         [autoattach]\n"
> +		"                         [kernel_btf BTF_DIR]\n"
>  		"       %1$s %2$s attach PROG ATTACH_TYPE [MAP]\n"
>  		"       %1$s %2$s detach PROG ATTACH_TYPE [MAP]\n"
>  		"       %1$s %2$s run PROG \\\n"


Thanks,
Quentin

