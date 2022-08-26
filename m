Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEC55A25DF
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 12:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbiHZKbO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 06:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiHZKbN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 06:31:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B77580035
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 03:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661509871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0/O7trgoZRDPbEO3etCLZJe6XGXcnvf3OvK8RSJ96rY=;
        b=FFpvxitEKpZLVJ4k1IKRlxxFDC+xKICV2o41HZmlfxqm3lYN2gjaHE/s8RDX80YNihvjcV
        sBkKJQXahjZj2u2Gs1hh68MmCpecnyuDlR3svYLKnb9SY9g09YLzo0P0ObfOXwn/pBvbz8
        adY1RzMofnyl8/r08fBuFG1hlWS9/DI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-630-iuCnYzpcO0uClekt4xbzdQ-1; Fri, 26 Aug 2022 06:31:10 -0400
X-MC-Unique: iuCnYzpcO0uClekt4xbzdQ-1
Received: by mail-ej1-f70.google.com with SMTP id qf15-20020a1709077f0f00b0073d6dfb7556so454493ejc.12
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 03:31:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc;
        bh=0/O7trgoZRDPbEO3etCLZJe6XGXcnvf3OvK8RSJ96rY=;
        b=iuYhsmckWuJK8gjVJ6yWroJbqTbk6E6hdP9ljAOvmAo7qHq+x1l9FbdA4yV4HYz92o
         KBkH23OORYBcwMNBffYs80h/08AKKPZfmpe5a2vSiqSIx5uAINC2Uh24L5Ar/bmiEubG
         yyRC5wOzUhalTp0Ad9Jvtt4vr0zynGUQVt/GviuEJsLWu/ZBJrxjUEfZX1rlRb8jujYj
         X/MjGZEr+0Cg/3VMA6lrc5KRhkZuLc8yqF9qLwVU+X6vSgKxi5TJ6g2ry/jyZo150r29
         24IPvee6XnmWvKhxkv3MdGWi4z0ietHWpgWKQ8WSwGMJR96Leeul+xU+ENzzPAAuFdVr
         zsXg==
X-Gm-Message-State: ACgBeo12pY0HVlzBQUeTpIr/Cp69lIhI3NR7xuzYpckcux5/P1Vfw6GU
        zS+Cg9Hk4ghEmYyiYPir7lz5s6x4T8yntFbEKACntSMzIE2GurS5xin/5r9FQftY50QV3JTRGr1
        vVaW2P9tmr676
X-Received: by 2002:a05:6402:28cb:b0:43b:c6d7:ef92 with SMTP id ef11-20020a05640228cb00b0043bc6d7ef92mr6321109edb.333.1661509869068;
        Fri, 26 Aug 2022 03:31:09 -0700 (PDT)
X-Google-Smtp-Source: AA6agR75gCjVHzAUaV7c1Ytu89JQk8ool9ewv02oOoBEY/IlFPG4UWrWvjJSp7wvEgrW88TflSRUxw==
X-Received: by 2002:a05:6402:28cb:b0:43b:c6d7:ef92 with SMTP id ef11-20020a05640228cb00b0043bc6d7ef92mr6321095edb.333.1661509868882;
        Fri, 26 Aug 2022 03:31:08 -0700 (PDT)
Received: from [192.168.41.81] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id z22-20020a50cd16000000b00445f9faf13csm1088791edi.72.2022.08.26.03.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 03:31:08 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <6fd7a7ef-00a4-a599-5857-8bb1c0dc0f71@redhat.com>
Date:   Fri, 26 Aug 2022 12:31:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Cc:     brouer@redhat.com, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, Alejandro Colomar <alx.manpages@gmail.com>,
        Jakub Wilk <jwilk@jwilk.net>, linux-man@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: Fix a few typos in BPF helpers
 documentation
Content-Language: en-US
To:     Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
References: <20220825092631.11605-1-quentin@isovalent.com>
In-Reply-To: <20220825092631.11605-1-quentin@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 25/08/2022 11.26, Quentin Monnet wrote:
> Address a few typos in the documentation for the BPF helper functions.
> They were reported by Jakub [0], who ran spell checkers on the generated
> man page [1].
> 
> Sync-up the UAPI header with its version in tools/.
> 
> [0]https://lore.kernel.org/linux-man/d22dcd47-023c-8f52-d369-7b5308e6c842@gmail.com/T/#mb02e7d4b7fb61d98fa914c77b581184e9a9537af
> [1]https://lore.kernel.org/linux-man/eb6a1e41-c48e-ac45-5154-ac57a2c76108@gmail.com/T/#m4a8d1b003616928013ffcd1450437309ab652f9f
> 
> Cc: Alejandro Colomar<alx.manpages@gmail.com>
> Cc: Jakub Wilk<jwilk@jwilk.net>
> Cc: Jesper Dangaard Brouer<brouer@redhat.com>
> Cc:linux-man@vger.kernel.org
> Reported-by: Jakub Wilk<jwilk@jwilk.net>
> Signed-off-by: Quentin Monnet<quentin@isovalent.com>
> ---
>   include/uapi/linux/bpf.h       | 16 ++++++++--------
>   tools/include/uapi/linux/bpf.h | 18 +++++++++---------
>   2 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 644600dbb114..e4d3810990be 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -4728,12 +4728,12 @@ union bpf_attr {
>    *
>    *		The argument*len_diff*  can be used for querying with a planned
>    *		size change. This allows to check MTU prior to changing packet
> - *		ctx. Providing an*len_diff*  adjustment that is larger than the
> + *		ctx. Providing a*len_diff*  adjustment that is larger than the
>    *		actual packet size (resulting in negative packet size) will in
> - *		principle not exceed the MTU, why it is not considered a
> - *		failure.  Other BPF-helpers are needed for performing the
> - *		planned size change, why the responsability for catch a negative
> - *		packet size belong in those helpers.
> + *		principle not exceed the MTU, which is why it is not considered
> + *		a failure.  Other BPF helpers are needed for performing the
> + *		planned size change, therefore the responsibility for catching
> + *		a negative packet size belongs in those helpers.
>    *
>    *		Specifying*ifindex*  zero means the MTU check is performed
>    *		against the current net device.  This is practical if this isn't

Thanks for improving these formulations.

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

