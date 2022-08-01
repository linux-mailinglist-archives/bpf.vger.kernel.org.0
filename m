Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE140586E80
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 18:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiHAQZQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 12:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbiHAQZO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 12:25:14 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EAEB9F;
        Mon,  1 Aug 2022 09:25:12 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id tk8so21313377ejc.7;
        Mon, 01 Aug 2022 09:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=wcy/rcdKHUsNf9tppWBLadn82oSwXUzbkvBCll0A8mA=;
        b=TLv1gSxXzDStTb6ykAHt11EaqHfK+pLXvcQHlAj3SlnO/ZMxskqKqEx79KFChNByi4
         nlN9ZzgoIA3qDwW3n2p0zP6YXyeb2XyI2oHdu7fqem/c9ulb1JK4yOUWGkUMG6t5jp+G
         nMoY/RFCK+cr+HQc+9CqJ1GSlKyNqSXXVzvYDM2KBzfGFVpbdHnAM8nTAFh10yYIYh4Y
         quD5rXmZO7lLZe6GuDWtmVxXu6vrKTjCXh5sAs5JajY/y2Y0Fje7JvE391oDfKscVDPV
         rnQfm01JZBNSxqdWqO9aBIQtJFh43fZITEfy3QiYiRFEK2fzKlenATobXJ1NXtDzSnKz
         47Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=wcy/rcdKHUsNf9tppWBLadn82oSwXUzbkvBCll0A8mA=;
        b=P1BuZLwzjEJnwFpSQ5hTnxoh5gIc5JQIDkkowbQPpV2fM2MKjhknqDbW390sfpzGT9
         CAdfczm6gl2QZ1WrmeYhlWxB2oGhBRSvChLpBJVnl0iweJvSshIYiGDyFm91DJs6Gl7Y
         DZ5vgPti2dIEBP/gy6rQrdSv5zdp+BXFsPWvdsPkAMQIeb5jIPdpCS2m3xSamUWRJwaH
         I1Fe46JEx7M7Rw887s6Foe/QccJnh0JRFCXpQJFD3XFlXrI2+UyqHLRddtjPDREM0AXP
         Sm6sT2egRuJzx+zyEhhs1DSy0P55nYHL5toyYeBEg26nF+r3ZI/LBhdYRJ022PbNCFLF
         p98w==
X-Gm-Message-State: AJIora/oh0EmY4woG4sn/7tGJi3unMylw3rPUOeOIMwHlfhqgf7qkk6m
        6RhRErH8kqckPmtWaa/rv78=
X-Google-Smtp-Source: AGRyM1sfslgwNE2GdO0SHlXU0tbK1hPkwQ+VSVUZaeLM+n3ccGrAYsitmIUAfEpBwO1L4oeN3Bo4aA==
X-Received: by 2002:a17:906:8501:b0:711:bf65:2a47 with SMTP id i1-20020a170906850100b00711bf652a47mr13389539ejx.150.1659371110880;
        Mon, 01 Aug 2022 09:25:10 -0700 (PDT)
Received: from krava ([83.240.62.89])
        by smtp.gmail.com with ESMTPSA id e15-20020a50fb8f000000b0043a6df72c11sm6918178edq.63.2022.08.01.09.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 09:25:10 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 1 Aug 2022 18:25:07 +0200
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libbpf: Initialize err in probe_map_create
Message-ID: <Yuf+Y7ocn1mgiaE3@krava>
References: <20220801025109.1206633-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801025109.1206633-1-f.fainelli@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jul 31, 2022 at 07:51:09PM -0700, Florian Fainelli wrote:
> GCC-11 warns about the possibly unitialized err variable in
> probe_map_create:
> 
> libbpf_probes.c: In function 'probe_map_create':
> libbpf_probes.c:361:38: error: 'err' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>   361 |                 return fd < 0 && err == exp_err ? 1 : 0;
>       |                                  ~~~~^~~~~~~~~~
> 
> Fixes: 878d8def0603 ("libbpf: Rework feature-probing APIs")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  tools/lib/bpf/libbpf_probes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
> index 97b06cede56f..6cf44e61815d 100644
> --- a/tools/lib/bpf/libbpf_probes.c
> +++ b/tools/lib/bpf/libbpf_probes.c
> @@ -247,7 +247,7 @@ static int probe_map_create(enum bpf_map_type map_type, __u32 ifindex)
>  	LIBBPF_OPTS(bpf_map_create_opts, opts);
>  	int key_size, value_size, max_entries;
>  	__u32 btf_key_type_id = 0, btf_value_type_id = 0;
> -	int fd = -1, btf_fd = -1, fd_inner = -1, exp_err = 0, err;
> +	int fd = -1, btf_fd = -1, fd_inner = -1, exp_err = 0, err = 0;
>  
>  	opts.map_ifindex = ifindex;
>  
> -- 
> 2.25.1
> 
