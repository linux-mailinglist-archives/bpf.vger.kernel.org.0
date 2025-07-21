Return-Path: <bpf+bounces-63929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D7EB0C899
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 18:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE9EA18954BF
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 16:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B222E0923;
	Mon, 21 Jul 2025 16:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkfzfnBs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7C32874E5;
	Mon, 21 Jul 2025 16:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753115044; cv=none; b=H2Hixna1hpGbuI++9zKXV7S+PTkEgyioHXjXt3PJBWi2QKIb5FRvsHX0d2rFkoWBDwe1z2cxoSJb986dpE4M+PDNATyXtCYocCArzu1BHZSW36lwGv3eNxuHkk4EbHtfrARsO/BnxHYZKEqM3gVI/hdh7Pvaflk5ipeU5JxTe30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753115044; c=relaxed/simple;
	bh=2ABCx+WSd+v3rHwLcSyVqwjm8XpTu9GXQQWjrFxrnRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IH45VMjZzT6h6rHVE9E38381NOZBmWse/F9IIp/8J4ZloDVRP/lT1rZHmeMv+AuR/hhu/55sWxW4dlyHYrncWBBj0zYW24/apbwyrw2ZA6lyfN0Sfp7cW7yWGuO/L2erHCtWkl+Pihl1xDOoV70dWFfWexEBq0/7Ahura2FjKyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkfzfnBs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945F8C4CEED;
	Mon, 21 Jul 2025 16:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753115042;
	bh=2ABCx+WSd+v3rHwLcSyVqwjm8XpTu9GXQQWjrFxrnRA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tkfzfnBsfOEbSXl1DVM+NkKg/YOkYcT95UJ99/aMXKkkGgXabsHvP6iElKHOX96b5
	 H6vKJBTwu0NgeagJ2zb+T7s7vY2ZxO7EIDVSzqsB0umrRZfRqCuJDb9obJh3rigw7u
	 1cndwxJBuMEFudL7s7wUYpDZTWpeSV/DUgjRSbIrhQnBtShUK6Tudepi/34xhYQE5t
	 b/7w3HrLIQA4HNTWmuo2ZeFDwDZY2CmuWwqFzsV5+qQDlEju3mDHhjbHjaSY6SATQ7
	 kDEYKQ4PAwfszMnYlco+KGVG8zBa4c2j4CvL9YBzTYMq9PDLIerX2luKUbsxI/Oj+v
	 A/WlfIGUMatNg==
Message-ID: <ab308d9e-a0dc-4b57-b498-93a0f56771c4@kernel.org>
Date: Mon, 21 Jul 2025 17:23:59 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/2] bpftool: Add bpftool-token manpage
To: Tao Chen <chen.dylane@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250720173310.1334483-1-chen.dylane@linux.dev>
 <20250720173310.1334483-2-chen.dylane@linux.dev>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250720173310.1334483-2-chen.dylane@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-07-21 01:33 UTC+0800 ~ Tao Chen <chen.dylane@linux.dev>
> Add bpftool-token manpage with information and examples of token-related
> commands.
> 
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  .../bpftool/Documentation/bpftool-token.rst   | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 tools/bpf/bpftool/Documentation/bpftool-token.rst
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-token.rst b/tools/bpf/bpftool/Documentation/bpftool-token.rst
> new file mode 100644
> index 00000000000..177f93c0bc7
> --- /dev/null
> +++ b/tools/bpf/bpftool/Documentation/bpftool-token.rst
> @@ -0,0 +1,68 @@
> +.. SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +
> +================
> +bpftool-token
> +================
> +-------------------------------------------------------------------------------
> +tool for inspection and simple manipulation of eBPF progs


Copy-pasted from bpftool-prog.rst, please update.


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
> +    List all the concrete allowed_types for cmds maps progs attachs
> +    and the bpffs mount_point used to set the token info.


This is not a summary, please let's use a more verbose description and
avoid abbreviations:

	List all the concrete allowed types for **bpf**\ () system call
	commands, maps, programs, and attach types, as well as the
	*bpffs* mount point used to set the token information.

What is a "concrete" allowed_type?


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
> +    token_info:
> +            /sys/fs/bpf/token
> +
> +    allowed_cmds:
> +            map_create          prog_load
> +
> +    allowed_maps:
> +
> +    allowed_progs:
> +            kprobe
> +
> +    allowed_attachs:
> +            xdp
> +


Please also update bpftool's bash completion file. I think it should be:

    diff --git i/tools/bpf/bpftool/bash-completion/bpftool w/tools/bpf/bpftool/bash-completion/bpftool
    index a759ba24471d..3f119d7eae96 100644
    --- i/tools/bpf/bpftool/bash-completion/bpftool
    +++ w/tools/bpf/bpftool/bash-completion/bpftool
    @@ -1215,6 +1215,17 @@ _bpftool()
                         ;;
                 esac
                 ;;
    +        token)
    +            case $command in
    +                show|list)
    +                    return 0
    +                    ;;
    +                *)
    +                    [[ $prev == $object ]] && \
    +                        COMPREPLY=( $( compgen -W 'help show list' -- "$cur" ) )
    +                    ;;
    +            esac
    +            ;;
         esac
     } &&
     complete -F _bpftool bpftool


