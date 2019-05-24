Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0190F29452
	for <lists+bpf@lfdr.de>; Fri, 24 May 2019 11:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389777AbfEXJPN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 May 2019 05:15:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55785 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389788AbfEXJPN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 May 2019 05:15:13 -0400
Received: by mail-wm1-f65.google.com with SMTP id x64so8550778wmb.5
        for <bpf@vger.kernel.org>; Fri, 24 May 2019 02:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=PGHGPnh+1OmUZqLUwj+s6O0ew8vzhvtPfDYdbDHoLJE=;
        b=AdHbBRBKZQSTWHN2t04DDlKIiTgdS0uEgU/SsAn80FAM6YEuzuc4uA/BfprN35lUz0
         Pb6Ca36F4LjTFum3NIxMZBbxv/IKlzx/JuYC+mjvG9mZsqp+t2ehMQJM7bPSJrqPvM6K
         IhkfXdtvUpjb12iVLxyu+qNl+C2T1a3Hv8h0FnGh75SFJsZ1W0hIYougjKV2WfFhgN+S
         O9rJHuP8ia0hFgqHP+Z8mIt00OHAbOZ5WmslgCGLz51UwNyi7kBtvFoj8XgwEkKoSRoR
         P52TCUa7h+aaqoFUw58aszq1OAGYKQl7AW6gp01VDhb/17RlJSJ11BvZ1Iz3swPVrXY9
         tEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PGHGPnh+1OmUZqLUwj+s6O0ew8vzhvtPfDYdbDHoLJE=;
        b=HVSDJQTOUmM9ryu6o9IAk10mTLrBLOhkTUT8mhhvOJQtPjJMydsluYU4YP0vmsR+7T
         E9gOC3jPAVTATYPe7kXpxm2l9bdoGz55VRrIGhA6KYsNS2dwxl7yRNno3QNX7JbsYsoC
         anUhVy/TvIwzNbyxDxe5noVje98X8jVbNPNibzvYz5HTmXCn+Rgn7KlSbz5YMm1BFyQW
         sFIDNUmVzGW7MkDmE2TmH7YQ8n5wFvKvH17CBNHMKFTRo0eVoDpZje1b+RKKS38eE2HS
         rQXg3yKWYnGTxTVqo9JVZtDVjqGZg9FYfR1lUqxmH3SCc8TwDOQ1sLhjuL5tpfGPeyV+
         FIog==
X-Gm-Message-State: APjAAAXL47ezNWTVPI3m0RWJIzY/cABfqBf3FfkvVvSI3E4DrF6dyAdb
        wSZPqbufDSdXatcGQeVds/ATwWdUyYQ=
X-Google-Smtp-Source: APXvYqyDoyB7pReOQYpsBZXDgSSu2MQXLR9asCh5AiJkLktW0Xk/UO95ro5QNg6NKJKtfQ0rn6lQNQ==
X-Received: by 2002:a1c:7511:: with SMTP id o17mr14359773wmc.39.1558689310666;
        Fri, 24 May 2019 02:15:10 -0700 (PDT)
Received: from [192.168.1.2] ([194.53.186.20])
        by smtp.gmail.com with ESMTPSA id g17sm1453014wrr.65.2019.05.24.02.15.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 02:15:09 -0700 (PDT)
Subject: Re: [PATCH v2 bpf-next 12/12] bpftool: update bash-completion w/ new
 c option for btf dump
To:     Andrii Nakryiko <andriin@fb.com>, andrii.nakryiko@gmail.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org, ast@fb.com,
        daniel@iogearbox.net, kernel-team@fb.com
References: <20190523204222.3998365-1-andriin@fb.com>
 <20190523204222.3998365-13-andriin@fb.com>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Message-ID: <bf418594-0442-fe89-c86b-11d7e5269047@netronome.com>
Date:   Fri, 24 May 2019 10:15:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523204222.3998365-13-andriin@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2019-05-23 13:42 UTC-0700 ~ Andrii Nakryiko <andriin@fb.com>
> Add bash completion for new C btf dump option.
> 
> Cc: Quentin Monnet <quentin.monnet@netronome.com>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---
>  tools/bpf/bpftool/bash-completion/bpftool | 25 +++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
> index 50e402a5a9c8..5b65e0309d2a 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool
> @@ -638,11 +638,28 @@ _bpftool()
>                              esac
>                              return 0
>                              ;;
> +                        format)
> +                            COMPREPLY=( $( compgen -W "c raw" -- "$cur" ) )
> +                            ;;
>                          *)
> -                            if [[ $cword == 6 ]] && [[ ${words[3]} == "map" ]]; then
> -                                 COMPREPLY+=( $( compgen -W 'key value kv all' -- \
> -                                     "$cur" ) )
> -                            fi
> +                            # emit extra options
> +                            case ${words[3]} in
> +                                id|file)
> +                                    if [[ $cword > 4 ]]; then

Not sure if this "if" is necessary. It seems to me that if $cword is 4
then we are just after "id" or "file" in the command line, in which case
we hit previous cases and never reach this point?

Also, reading the completion code I wonder, do we have completion for
BTF ids? It seems to me that we have nothing proposed to complete
"bpftool btf dump id <tab>". Any chance to get that in a follow-up patch?

> +                                        _bpftool_once_attr 'format'
> +                                    fi
> +                                    ;;
> +                                map|prog)
> +                                    if [[ ${words[3]} == "map" ]] && [[ $cword == 6 ]]; then
> +                                        COMPREPLY+=( $( compgen -W "key value kv all" -- "$cur" ) )
> +                                    fi
> +                                    if [[ $cword > 5 ]]; then

Same remark on the "if", I do not believe it is necessary?

> +                                        _bpftool_once_attr 'format'
> +                                    fi
> +                                    ;;
> +                                *)
> +                                    ;;
> +                            esac
>                              return 0
>                              ;;
>                      esac
> 

