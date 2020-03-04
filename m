Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 635C5178F14
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 11:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387881AbgCDK7z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Mar 2020 05:59:55 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33822 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbgCDK7y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Mar 2020 05:59:54 -0500
Received: by mail-wm1-f66.google.com with SMTP id i10so4457178wmd.1
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2020 02:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NhkcJ06YUgDbIKXuna6EiEjxKmn3rzjLqh99l5vMXmQ=;
        b=cAw1TOSWK4PLfEQn63hvoUkRlYXvz99fWwUq5ahjCFaGONUCAZeKU5v1LhJ08hdeqs
         8Rjsy5hHplnnZcHPglYrKwCXHJDLNnAX/js3ZU6etH0zZ9ZIm4qE++7JL0Dxb+9Su1S5
         cNwAc735wyQxhG8+8w/WDQW+BBO65PBgkP8jY3tw1xn2Ml85ufnGnGWgCsWFvJLLk344
         Dcm0JPWctN6V26SuRWdkq4cXABADUVqAvgJzLVblwg0PTmd0Q+nYZkZdSILIiNWqDXip
         8mX1bwusAKsQHgXmu05bgxC0iPJwVfI/jw09Q1HnbrYT7DEmTKa8MSGndeCVN7eArSEg
         nUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NhkcJ06YUgDbIKXuna6EiEjxKmn3rzjLqh99l5vMXmQ=;
        b=fF0jQYSqv/s0NWYjRrciPpHL2wpMoL55tdYWuo7vbJWtS+Z9+EA19I+cOCBTIDecjr
         8OUiC44VYSASxrC8Wo/doUwGGXQ/aPYA/Ote96I0vC0BSyNfvWKLveSo9AOltG1tnVQw
         Dx8+VL7U5AAetrJ4VPKjgISKOeqHESKSdifBSfoYt1nHjx/DXoL71jMrQoX3CJXd3fzQ
         wnujuzMGzrWla1huACZb+BorVv02Aw2MNegcuW81iPLBy/h5Th70prQJq82VmzIJ9orX
         QoocGZ+HMFH9E8pNyxxT3UFIs2rrofwkaH3b3T0IgaN/sZStWaQEWzh+JyhC1qTYxboY
         dsrQ==
X-Gm-Message-State: ANhLgQ1Wxdf+iK+mt0PXp5KquAuwms1iH2j3fFqBxQssbePlwiIe7hH1
        pe7bXnrF4qEVdC4VNFI1dpj46Q==
X-Google-Smtp-Source: ADFU+vsCDpBeg5uFHX0ar3blIsq25aD89lA7gFuolLyDiWpauZDT5bp7IDyZrFk/Ie5MBHtmoFlqtg==
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr3277228wmj.117.1583319592012;
        Wed, 04 Mar 2020 02:59:52 -0800 (PST)
Received: from [192.168.1.10] ([194.35.118.106])
        by smtp.gmail.com with ESMTPSA id n3sm3858120wmc.27.2020.03.04.02.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 02:59:51 -0800 (PST)
Subject: Re: [PATCH v3 bpf-next 3/3] bpftool: bash completion for "bpftool
 prog profile"
To:     Song Liu <songliubraving@fb.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     kernel-team@fb.com, ast@kernel.org, daniel@iogearbox.net,
        arnaldo.melo@gmail.com, jolsa@kernel.org
References: <20200303195555.1309028-1-songliubraving@fb.com>
 <20200303195555.1309028-4-songliubraving@fb.com>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <786f67ba-0bc2-612f-ace3-dac0da037047@isovalent.com>
Date:   Wed, 4 Mar 2020 10:59:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200303195555.1309028-4-songliubraving@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2020-03-03 11:55 UTC-0800 ~ Song Liu <songliubraving@fb.com>
> Add bash completion for "bpftool prog profile" command.
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  tools/bpf/bpftool/bash-completion/bpftool | 45 ++++++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
> index f2838a658339..e54f36c0c973 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool
> @@ -337,6 +337,7 @@ _bpftool()
>  
>              local PROG_TYPE='id pinned tag name'
>              local MAP_TYPE='id pinned name'
> +            local METRIC_TYPE='cycles instructions l1d_loads llc_misses'
>              case $command in
>                  show|list)
>                      [[ $prev != "$command" ]] && return 0
> @@ -498,6 +499,48 @@ _bpftool()
>                  tracelog)
>                      return 0
>                      ;;
> +                profile)
> +                    case $cword in
> +                        3)
> +                            COMPREPLY=( $( compgen -W "$PROG_TYPE" -- "$cur" ) )
> +                            return 0
> +                            ;;
> +                        4)
> +			    case $prev in
> +                                id)
> +                                    _bpftool_get_prog_ids
> +                                    ;;
> +                                name)
> +                                    _bpftool_get_map_names

s/map/prog/

> +                                    ;;
> +                                pinned)
> +                                    _filedir
> +                                    ;;
> +			    esac
> +			    return 0
> +			    ;;
> +			5)
> +			    COMPREPLY=( $( compgen -W "$METRIC_TYPE duration" -- "$cur" ) )
> +			    return 0
> +			    ;;
> +                        6)
> +			    case $prev in
> +                                duration)
> +				    return 0
> +                                    ;;
> +                                *)
> +				    COMPREPLY=( $( compgen -W "$METRIC_TYPE" -- "$cur" ) )
> +				    return 0
> +                                    ;;
> +			    esac
> +			    return 0
> +			    ;;
> +                        *)
> +			    COMPREPLY=( $( compgen -W "$METRIC_TYPE" -- "$cur" ) )
> +			    return 0
> +			    ;;
> +		    esac
> +                    ;;

You have a mix of tabs and spaces for indent on this chunk, could you
please fix it?

Other than this and the map|prog thing above, completion looks good to
me, thanks a lot!

>                  run)
>                      if [[ ${#words[@]} -lt 5 ]]; then
>                          _filedir
> @@ -525,7 +568,7 @@ _bpftool()
>                  *)
>                      [[ $prev == $object ]] && \
>                          COMPREPLY=( $( compgen -W 'dump help pin attach detach \
> -                            load loadall show list tracelog run' -- "$cur" ) )
> +                            load loadall show list tracelog run profile' -- "$cur" ) )
>                      ;;
>              esac
>              ;;
> 

