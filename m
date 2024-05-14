Return-Path: <bpf+bounces-29690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD1C8C4FC5
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 12:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 064BB1C20C6B
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 10:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C2E12FB06;
	Tue, 14 May 2024 10:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+GvShvW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534FA23767
	for <bpf@vger.kernel.org>; Tue, 14 May 2024 10:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715682452; cv=none; b=c4+qsUCBJI6prvCybBAL20qbF6UsLhYNtFwMjFmrFpvW4wATOy1WEMLNwZIOnHoTgnUIsDEDq380Vkrlxww98uExqXexCw3N9OAYM3lFORTyxF0wM8JNwf6ZTEPpXJMlcBDvLO9FYbAjb/wjgPHllhGKL+A5FCdKov8moK29T4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715682452; c=relaxed/simple;
	bh=+qTo8ZRv3L7WsCBgHLJv2y3BLW/zlNpByZPRqs407+o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jlQ3n3FELqXUpwZmn/JlESJPCUDSlYsk6x2z6lG4IodvPxQnZG0A+V0i9KINHO/mx9/IuctldSCqH1slJ28McwYRd546Ks8QdewrdQovTd8+/XvlxY86RqylXmZZ2yaAnBJBj4kBM7rJ1msMQpJjdGmmBeRcDIuhhc49Zm9UNfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+GvShvW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B1AC2BD10;
	Tue, 14 May 2024 10:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715682452;
	bh=+qTo8ZRv3L7WsCBgHLJv2y3BLW/zlNpByZPRqs407+o=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=K+GvShvWHqqvbIeU2c17AfQ7s9wptdfLVeLkGfvbp5Ka9IT3YIXut4Hc/vIuKDYS1
	 GBTsZdgb1IePTbsF5Ntyr9vcFiUwfy6kopxp2wB29ON/53Ratq6QY23zGz5KGT/CE7
	 iWMOdYkEiKREwYImeMKOJ8mgWz/9ypGY6qTHZ2ESbkb66TIRbJhtmKBTXICkJ1vSiG
	 IOhw9PCHhn2mypNYtLE9EERotvqPnxJk4qSIzPbfN97ac50988TeHQmCbjjs8dan0T
	 a+q1MSzot2mhtfD66+xCvUkT9ZK1ZlkaMCGpNamf+ODInPCnKExX3iH45dZ4LMNFuW
	 S3GUTzbSP1WQQ==
Message-ID: <91c91557-6fc7-4228-b003-32e09d52c1e4@kernel.org>
Date: Tue, 14 May 2024 11:27:25 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH v3 bpf-next] bpftool: introduce btf c dump sorting
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20240513192927.99189-1-yatsenko@meta.com>
Content-Language: en-GB
In-Reply-To: <20240513192927.99189-1-yatsenko@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-05-13 20:29 UTC+0100 ~ Mykyta Yatsenko mykyta.yatsenko5@gmail.com
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Sort bpftool c dump output; aiming to simplify vmlinux.h diffing and
> forcing more natural type definitions ordering.
> 
> Definitions are sorted first by their BTF kind ranks, then by their base
> type name and by their own name.
> 
> Type ranks
> 
> Assign ranks to btf kinds (defined in function btf_type_rank) to set
> next order:
> 1. Anonymous enums/enums64
> 2. Named enums/enums64
> 3. Trivial types typedefs (ints, then floats)
> 4. Structs/Unions
> 5. Function prototypes
> 6. Forward declarations
> 
> Type rank is set to maximum for unnamed reference types, structs and
> unions to avoid emitting those types early. They will be emitted as
> part of the type chain starting with named type.
> 
> Lexicographical ordering
> 
> Each type is assigned a sort_name and own_name.
> sort_name is the resolved name of the final base type for reference
> types (typedef, pointer, array etc). Sorting by sort_name allows to
> group typedefs of the same base type. sort_name for non-reference type
> is the same as own_name. own_name is a direct name of particular type,
> is used as final sorting step.
> 
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  .../bpf/bpftool/Documentation/bpftool-btf.rst |   5 +-
>  tools/bpf/bpftool/bash-completion/bpftool     |   3 +
>  tools/bpf/bpftool/btf.c                       | 138 +++++++++++++++++-
>  3 files changed, 139 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> index eaba24320fb2..65eeb3d905f0 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> @@ -28,7 +28,7 @@ BTF COMMANDS
>  | **bpftool** **btf help**
>  |
>  | *BTF_SRC* := { **id** *BTF_ID* | **prog** *PROG* | **map** *MAP* [{**key** | **value** | **kv** | **all**}] | **file** *FILE* }
> -| *FORMAT* := { **raw** | **c** }
> +| *FORMAT* := { **raw** | **c** [**unsorted**]}

Missing space at the end, "[**unsorted**] }"

>  | *MAP* := { **id** *MAP_ID* | **pinned** *FILE* }
>  | *PROG* := { **id** *PROG_ID* | **pinned** *FILE* | **tag** *PROG_TAG* | **name** *PROG_NAME* }
>  
> @@ -63,7 +63,8 @@ bpftool btf dump *BTF_SRC*
>      pahole.
>  
>      **format** option can be used to override default (raw) output format. Raw
> -    (**raw**) or C-syntax (**c**) output formats are supported.
> +    (**raw**) or C-syntax (**c**) output formats are supported. (**unsorted**)
> +    option can be used with (**c**) to avoid sorting the output.

The parenthesis are not part of the formatting here, they are used in
the previous sentence to mention the keyword related to the options
mentioned in the sentence. So here we could have:

"With C-style formatting, the output is sorted by default. Use the
**unsorted** option to avoid sorting the output."

>  
>  bpftool btf help
>      Print short help message.
> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
> index 04afe2ac2228..be99d49b8714 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool
> @@ -930,6 +930,9 @@ _bpftool()
>                          format)
>                              COMPREPLY=( $( compgen -W "c raw" -- "$cur" ) )
>                              ;;
> +                        c)
> +                            COMPREPLY=( $( compgen -W "unsorted" -- "$cur" ) )
> +                            ;;
>                          *)
>                              # emit extra options
>                              case ${words[3]} in
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 91fcb75babe3..7e7071d301df 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c

[...]

> @@ -1063,7 +1191,7 @@ static int do_help(int argc, char **argv)
>  		"       %1$s %2$s help\n"
>  		"\n"
>  		"       BTF_SRC := { id BTF_ID | prog PROG | map MAP [{key | value | kv | all}] | file FILE }\n"
> -		"       FORMAT  := { raw | c }\n"
> +		"       FORMAT  := { raw | c [unsorted]}\n"

Missing space as well: "[unsorted] }\n"

>  		"       " HELP_SPEC_MAP "\n"
>  		"       " HELP_SPEC_PROGRAM "\n"
>  		"       " HELP_SPEC_OPTIONS " |\n"

With the above addressed:

Reviewed-by: Quentin Monnet <qmo@kernel.org>

