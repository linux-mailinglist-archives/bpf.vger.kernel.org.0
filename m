Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5784452A494
	for <lists+bpf@lfdr.de>; Tue, 17 May 2022 16:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347774AbiEQOSa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 May 2022 10:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236741AbiEQOS3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 May 2022 10:18:29 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEAD3525B
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 07:18:26 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h14so5327365wrc.6
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 07:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=XBVs8fikzU3Mb5xDa8B0h88bBC564LJpeHGNTfHHMW8=;
        b=NFNnDU/9JmrX938+1paa7//KBjcP0O5FF9xRk7x1SFFeAbf29ixZXcpOFhqbKewwFF
         we8YWFnE4PTJwR4p9JbnYUvSutN8gfKjyEC/+nIKTUk8NgWo0VNoDTmDAsL8f5SwDB3n
         0j4eWJRVqOJDkX2ed9J3kviVCPScmtiEi5oI+5FPLc0DC0su8uozhUNlXjPa6OX+fbDN
         E3kN/vqlMMtIHwDApS97Mq4eJjXrDE3JdUFpG9S14Ssqzwwi0ACHFsH0VEa7j0q6Af6m
         xTIcJQ2qcxE+Xp8LsvFvEy9ZJHdwDB2n8zOZZWOarG6SVseznr02RiGnPx7NVHmsW0yu
         NFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XBVs8fikzU3Mb5xDa8B0h88bBC564LJpeHGNTfHHMW8=;
        b=P2x4N4W0kVOlWsAJESz/0VieoK0xLzmBtj120Nf0qy055tfJNholcwz5pyXOeOSEvz
         mW6G+yvHz7dZRVx9/yNva8VpjH0YFgHiT3erfzdDQnbM7juzN1szhvlHSTO23rKxldmm
         S/1q+kyF5J85tqW9HXXEZl63QqAJdnn5ubvuOaRVwLuH8yJId84uCbwH/YjqB7aBnx+f
         R1WQPf0EWXUYGNRY9ACeiXYLo8WiyMfornzjgXg0+hjC5dCofjAaWiDPhL2wTzFjSfDN
         pA8b1wijh3LQnSP/1fu4ZjOWsuR8WgSX68XtYMIubHzdoLnv8R4tOIxdjC8YP8aTtPkA
         aidQ==
X-Gm-Message-State: AOAM530w1uhwU+acS7qCofB/DXLaJa2EsxXsgqFfZ2Xl2GWNcd0Opwnc
        QZuWbpyfsdwPjCgywOcao6H5Ug==
X-Google-Smtp-Source: ABdhPJxdhfeeqCdS80IZ1Uj9dJ7kTH7Bett5qAnfDE29V3UzyKt6plxNJmc0UB6uNk48kOXf3kXI0A==
X-Received: by 2002:a05:6000:2ae:b0:20c:57b6:32e1 with SMTP id l14-20020a05600002ae00b0020c57b632e1mr19094741wry.285.1652797105503;
        Tue, 17 May 2022 07:18:25 -0700 (PDT)
Received: from [192.168.178.21] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id d19-20020adf9b93000000b0020d03b5c33dsm7839664wrc.46.2022.05.17.07.18.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 07:18:25 -0700 (PDT)
Message-ID: <fce7ec43-4fae-ead8-df79-3f76fe9f173b@isovalent.com>
Date:   Tue, 17 May 2022 15:18:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next 03/12] bpftool: Use libbpf_bpf_prog_type_str
Content-Language: en-GB
To:     =?UTF-8?Q?Daniel_M=c3=bcller?= <deso@posteo.net>,
        bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
References: <20220516173540.3520665-1-deso@posteo.net>
 <20220516173540.3520665-4-deso@posteo.net>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220516173540.3520665-4-deso@posteo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-05-16 17:35 UTC+0000 ~ Daniel Müller <deso@posteo.net>
> This change switches bpftool over to using the recently introduced
> libbpf_bpf_prog_type_str function instead of maintaining its own string
> representation for the bpf_prog_type enum.
> 
> Signed-off-by: Daniel Müller <deso@posteo.net>
> ---
>  tools/bpf/bpftool/feature.c | 57 +++++++++++++++++++++++--------------
>  tools/bpf/bpftool/link.c    | 19 +++++++------
>  tools/bpf/bpftool/main.h    |  3 --
>  tools/bpf/bpftool/map.c     | 13 +++++----
>  tools/bpf/bpftool/prog.c    | 51 ++++++---------------------------
>  5 files changed, 64 insertions(+), 79 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
> index d12f460..a093e1 100644
> --- a/tools/bpf/bpftool/feature.c
> +++ b/tools/bpf/bpftool/feature.c

> @@ -728,10 +724,10 @@ probe_helper_for_progtype(enum bpf_prog_type prog_type, bool supported_type,
>  }
>  
>  static void
> -probe_helpers_for_progtype(enum bpf_prog_type prog_type, bool supported_type,
> +probe_helpers_for_progtype(enum bpf_prog_type prog_type,
> +			   char const *prog_type_str, bool supported_type,

Nit: "const char*" for consistency?

>  			   const char *define_prefix, __u32 ifindex)
>  {
