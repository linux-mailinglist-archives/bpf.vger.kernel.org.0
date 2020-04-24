Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D950A1B720F
	for <lists+bpf@lfdr.de>; Fri, 24 Apr 2020 12:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgDXKdO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Apr 2020 06:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgDXKdN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Apr 2020 06:33:13 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831AAC09B045
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2020 03:33:13 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u16so10115141wmc.5
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2020 03:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5cqMjK8uSMCk5GuzsTeQNmcP/DVVKtgpJVoR2r1sih4=;
        b=df0ug37Wt+Mjyy0tmiRENhVNqronu2yLaWsLECjc8Lg5gp0nUlCXeRWrSn76+PiKqY
         6aSrIQcTbSt/bEfuzjArtmUe5LWhQdAaUfDnnOwhdxY6XEe4JEvUw+thAOVROnWs0cPe
         pGslNlReFAfbgYR4LYRvyCOAiMmLRL88PYzwKwyxhwy8/vXSBH0UqWVgmF+z5OR1/2BY
         geL63XdEDrAZ8Syl1nE+DbBDKvfa/otTZ+4LfRNptdzXQVWtYsEZatWEpDEDlTPqjoU9
         e9YWBWBDHFsDxhUM5afTD6HpHCc+MiOT0Wde6h96kwRuTreIJJuiDDHP2w6IYX4rhNYZ
         kLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5cqMjK8uSMCk5GuzsTeQNmcP/DVVKtgpJVoR2r1sih4=;
        b=rLglsFGBIRdSAl+ArjJqdu09seQVQDulTRMB+wMB3h2HArqIt3DL4ESfjqJX7g2G+o
         CmSZf4ymPzTwhtA1ryhRhSEgMjc3EKyhT7j5SBQjFt6GRvy2uxC2OQefsMr8XN7lmibX
         9IGbierPR3kDPDKQYwD7CaIL5749PckwI4D+CGoXIv4NezSEYYLElGEL2apsZixc1bZT
         RmMVNFu4+SY0zqZHiVQNn1Vnv64sBz/wSSRlb6OzDgDHV2SEOexLjjITTY3fNdbwJEMk
         rMIK3qXS3LcnU0m/j41NZwHrAUAvQfgwIZCfZ6e9IjpxJyuGU+TEkfrcSzuPtn87rlBR
         hxPg==
X-Gm-Message-State: AGi0PuZ6+ZOeveVjnqBPsa9VrtCtZax66MGei22iFa6iLZ1u0pXgyZIe
        iZKWLE1bLebsPWXODojg5hZCBg==
X-Google-Smtp-Source: APiQypJFxh3bFfN3BO69qDFwbwjz83wR35geF+WyADWhGNWR2+qD6UlPzn41qhifDXuJ/9RzzykWpw==
X-Received: by 2002:a7b:cf25:: with SMTP id m5mr9981268wmg.65.1587724392246;
        Fri, 24 Apr 2020 03:33:12 -0700 (PDT)
Received: from [192.168.1.10] ([194.53.185.129])
        by smtp.gmail.com with ESMTPSA id g15sm7787335wrp.96.2020.04.24.03.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 03:33:11 -0700 (PDT)
Subject: Re: [PATCH bpf-next 09/10] bpftool: add bpftool-link manpage
To:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@fb.com, daniel@iogearbox.net
Cc:     andrii.nakryiko@gmail.com, kernel-team@fb.com
References: <20200424053505.4111226-1-andriin@fb.com>
 <20200424053505.4111226-10-andriin@fb.com>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <43a50d28-4d23-fa23-6929-4f8a082de2a9@isovalent.com>
Date:   Fri, 24 Apr 2020 11:33:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424053505.4111226-10-andriin@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2020-04-23 22:35 UTC-0700 ~ Andrii Nakryiko <andriin@fb.com>
> Add bpftool-link manpage with information and examples of link-related
> commands.
> 
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---
>  .../bpftool/Documentation/bpftool-link.rst    | 119 ++++++++++++++++++
>  1 file changed, 119 insertions(+)
>  create mode 100644 tools/bpf/bpftool/Documentation/bpftool-link.rst
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-link.rst b/tools/bpf/bpftool/Documentation/bpftool-link.rst
> new file mode 100644
> index 000000000000..2866128cd6b2
> --- /dev/null
> +++ b/tools/bpf/bpftool/Documentation/bpftool-link.rst
> @@ -0,0 +1,119 @@
> +================
> +bpftool-link
> +================
> +-------------------------------------------------------------------------------
> +tool for inspection and simple manipulation of eBPF links
> +-------------------------------------------------------------------------------
> +
> +:Manual section: 8
> +
> +SYNOPSIS
> +========
> +
> +	**bpftool** [*OPTIONS*] **link *COMMAND*

Missing the ending "**" after "**link", please fix.

> +
> +	*OPTIONS* := { { **-j** | **--json** } [{ **-p** | **--pretty** }] | { **-f** | **--bpffs** } }
> +
> +	*COMMANDS* := { **show** | **list** | **pin** | **help** }
> +
> +LINK COMMANDS
> +=============
> +
> +|	**bpftool** **link { show | list }** [*LINK*]
> +|	**bpftool** **link pin** *LINK* *FILE*
> +|	**bpftool** **link help**
> +|
> +|	*LINK* := { **id** *LINK_ID* | **pinned** *FILE* }
> +
> +
> +DESCRIPTION
> +===========
> +	**bpftool link { show | list }** [*LINK*]
> +		  Show information about active links. If *LINK* is
> +		  specified show information only about given link,
> +		  otherwise list all links currently active on the system.
> +
> +		  Output will start with link ID followed by link type and
> +		  zero or more named attributes, some of which depend on type
> +                  of link.

Nit: indent issue on the line above.

> +
> +	**bpftool link pin** *LINK* *FILE*
> +		  Pin link *LINK* as *FILE*.
> +
> +		  Note: *FILE* must be located in *bpffs* mount. It must not
> +		  contain a dot character ('.'), which is reserved for future
> +		  extensions of *bpffs*.
> +
> +	**bpftool link help**
> +		  Print short help message.
> +
> +OPTIONS
> +=======
> +	-h, --help
> +		  Print short generic help message (similar to **bpftool help**).
> +
> +	-V, --version
> +		  Print version number (similar to **bpftool version**).
> +
> +	-j, --json
> +		  Generate JSON output. For commands that cannot produce JSON, this
> +		  option has no effect.
> +
> +	-p, --pretty
> +		  Generate human-readable JSON output. Implies **-j**.
> +
> +	-f, --bpffs
> +		  When showing BPF links, show file names of pinned
> +		  links.
> +
> +	-n, --nomount
> +		  Do not automatically attempt to mount any virtual file system
> +		  (such as tracefs or BPF virtual file system) when necessary.
> +
> +	-d, --debug
> +		  Print all logs available, even debug-level information. This
> +		  includes logs from libbpf.
> +
> +EXAMPLES
> +========
> +**# bpftool link show**
> +
> +::
> +
> +    10: cgroup  prog 25
> +            cgroup_id 614  attach_type egress
> +
> +**# bpftool --json --pretty link show**
> +
> +::
> +
> +    [{
> +            "type": "cgroup",
> +            "prog_id": 25,
> +            "cgroup_id": 614,
> +            "attach_type": "egress"
> +        }
> +    ]
> +
> +|
> +| **# mount -t bpf none /sys/fs/bpf/**

[ Mounting should not be required, as you call
do_pin_any()->do_pin_fd()->mount_bpffs_for_pin().

Although on second thought I'm fine with keeping it, just in case users
call bpftool --nomount. ]

> +| **# bpftool link pin id 10 /sys/fs/bpf/link**
> +| **# ls -l /sys/fs/bpf/**
> +
> +::
> +
> +    -rw------- 1 root root 0 Apr 23 21:39 link
> +
> +
> +SEE ALSO
> +========
> +	**bpf**\ (2),
> +	**bpf-helpers**\ (7),
> +	**bpftool**\ (8),
> +	**bpftool-prog\ (8),
> +	**bpftool-map**\ (8),
> +	**bpftool-cgroup**\ (8),
> +	**bpftool-feature**\ (8),
> +	**bpftool-net**\ (8),
> +	**bpftool-perf**\ (8),
> +	**bpftool-btf**\ (8)
> 

