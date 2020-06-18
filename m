Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB131FDA2F
	for <lists+bpf@lfdr.de>; Thu, 18 Jun 2020 02:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgFRAZR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Jun 2020 20:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbgFRAZR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Jun 2020 20:25:17 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42692C061755
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2020 17:25:16 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l11so4229393wru.0
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2020 17:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y3zER1zwQ0B5dudY00wi+NNB9pPCdAVkeE51mwEiFRg=;
        b=hpNYpfWi/Vgq4BiZy5E8W3+lQH09yTouLzZjsSMEiSzDa+UVNKsIL6xdRQOmEN58F8
         C2qzXrjX8Z56Vr0GA+3MCjRTNrGBZnnMoJrY7YCkNZ4Id0RoKZSApD52TLwpFStLTP7k
         c/4LLYd9CQDINWXw5+HJYiDfdZAGvpu570fJNe53+fZ6cwdgdUgZ3A/g1tX6pUzhKBb7
         Zoj4gmJkzG42BzRZVvl1Zl53DFDYDLIpW8FV9+8CTZtedhl5In9c7RTNWovtydFBzSF3
         ietHgdN0w7R0tQH5DZIuDco0zKGOVgnFIH06eSNwH1HqymlZqFSUn6uLlfXfM9RUZqEz
         Wq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y3zER1zwQ0B5dudY00wi+NNB9pPCdAVkeE51mwEiFRg=;
        b=LaNmm2GOPxB2VJLUr9Js5UthCYbHTvKVn+CaSUmBbGWTGjHI2BwryPvDdpKR3N+Tq3
         ywKeEDaIBxVULbHhrv7s3BuB2PGyUtNm3002v20enAMz4nviflF+2tdMDcdqeqkJn5dX
         rWEI4GleW8Izug1QIzdy/9FV8M1KslO/EzOz/yP7vHYThC7PcU0j0WawRUrQb2YSGydI
         JFV+tA3CM2i1eO4uY0JuDZREmZyPTpwlo2xDQli4diEkSbWG7pBSkGC9A3b4u2DK5aDP
         i05ihpw8hdYxz9yI/QcXf4y9oURClykPC1S9L0GQnxglVgUfLn4T+bfmM/MJol/6/f0m
         1zBw==
X-Gm-Message-State: AOAM531CqtgfO5g0b8l/JJTPDP6F5LT2wuq+3JKU7sPkiWOQmzCnGsZL
        ogKX7ZPxCJXzhhGUIa1RVmbEPA==
X-Google-Smtp-Source: ABdhPJzv026NbSqgzK/uBjdwofGmUZcraEYU8lRPja80ZCkCVYw/Ec5aCaG4lduPsHUaCNK/FnPGsA==
X-Received: by 2002:a5d:664e:: with SMTP id f14mr1808260wrw.6.1592439914914;
        Wed, 17 Jun 2020 17:25:14 -0700 (PDT)
Received: from [192.168.1.10] ([194.53.184.244])
        by smtp.gmail.com with ESMTPSA id a124sm1394752wmh.4.2020.06.17.17.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 17:25:14 -0700 (PDT)
Subject: Re: [PATCH bpf-next 9/9] tools/bpftool: add documentation and sample
 output for process info
To:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@fb.com, daniel@iogearbox.net
Cc:     andrii.nakryiko@gmail.com, kernel-team@fb.com,
        Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Song Liu <songliubraving@fb.com>
References: <20200617161832.1438371-1-andriin@fb.com>
 <20200617161832.1438371-10-andriin@fb.com>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <e22ae69f-c174-1cc8-d3b3-68fdda8934ae@isovalent.com>
Date:   Thu, 18 Jun 2020 01:25:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200617161832.1438371-10-andriin@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2020-06-17 09:18 UTC-0700 ~ Andrii Nakryiko <andriin@fb.com>
> Add statements about bpftool being able to discover process info, holding
> reference to BPF map, prog, link, or BTF. Show example output as well.
> 
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---
>  tools/bpf/bpftool/Documentation/bpftool-btf.rst  |  5 +++++
>  tools/bpf/bpftool/Documentation/bpftool-link.rst | 13 ++++++++++++-
>  tools/bpf/bpftool/Documentation/bpftool-map.rst  |  8 +++++++-
>  tools/bpf/bpftool/Documentation/bpftool-prog.rst | 11 +++++++++++
>  4 files changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> index ce3a724f50c1..85f7c82ebb28 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> @@ -36,6 +36,11 @@ DESCRIPTION
>  		  otherwise list all BTF objects currently loaded on the
>  		  system.
>  
> +		  Since Linux 5.8 bpftool is able to discover information about
> +		  processes that hold open file descriptors (FDs) against BPF
> +		  links. On such kernels bpftool will automatically emit this

Copy-paste error: s/BPF links/BTF objects/

> +		  information as well.
> +
>  	**bpftool btf dump** *BTF_SRC*
>  		  Dump BTF entries from a given *BTF_SRC*.
>  
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-link.rst b/tools/bpf/bpftool/Documentation/bpftool-link.rst
> index 0e43d7b06c11..1da7ef65b514 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-link.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-link.rst
> @@ -37,6 +37,11 @@ DESCRIPTION
>  		  zero or more named attributes, some of which depend on type
>  		  of link.
>  
> +		  Since Linux 5.8 bpftool is able to discover information about
> +		  processes that hold open file descriptors (FDs) against BPF
> +		  links. On such kernels bpftool will automatically emit this
> +		  information as well.
> +
>  	**bpftool link pin** *LINK* *FILE*
>  		  Pin link *LINK* as *FILE*.
>  
> @@ -82,6 +87,7 @@ EXAMPLES
>  
>      10: cgroup  prog 25
>              cgroup_id 614  attach_type egress
> +            pids test_progs(2238417)

(That's a big PID. Maybe something below the default max pid (32768)
might be less confusing for users, but also maybe that's just me
nitpicking too much.)

>  
>  **# bpftool --json --pretty link show**
>  
> @@ -91,7 +97,12 @@ EXAMPLES
>              "type": "cgroup",
>              "prog_id": 25,
>              "cgroup_id": 614,
> -            "attach_type": "egress"
> +            "attach_type": "egress",
> +            "pids": [{
> +                    "pid": 2238417,
> +                    "comm": "test_progs"
> +                }
> +            ]
>          }
>      ]
>  
