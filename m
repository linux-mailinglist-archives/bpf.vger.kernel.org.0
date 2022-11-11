Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D4F6261CA
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 20:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbiKKTRz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 14:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiKKTRz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 14:17:55 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B9576F88
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:17:54 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id r9-20020a17090a2e8900b0021409b8020cso5927481pjd.0
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6LNVQVouc+OP1BK7X0ZPCCVP9t58isq5AJxGmdz60sI=;
        b=Zw1XnKVX9ymWCWmLkPXsRTLz5PUxcDLfkFWyMVQaG5P+v92bAzbIe7WvZpx3cXWg4B
         PWn+TCAWaQ9yDT3rgEG0GFMjDyaob+DkR3NK50DHOBAKDLLAFXO7Ul7WXwTb70ooGtFO
         EpPBTUxyAszBkJEFq25va/NBIekcdsaxbKX83AVi71zyjycSKo1Gfq0ws8tBm7IrbFI2
         fOloR4AaYdck0Er135C1fpvD0MmVOQkszST4xxqSJDHMsTKJen9zqApxhi+s8XNv6Vhf
         e6XkK/oMWsUGLpNggstozb2cyl2qxnMqruSnCuEZkJTAjBN/hnmpNnXIDwr2mtN5aGA/
         Y62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6LNVQVouc+OP1BK7X0ZPCCVP9t58isq5AJxGmdz60sI=;
        b=EwnMaYVYXyJuviEFwnOD9MvCdAAQHwCDKM3pi+7mhDLEi5WxlNpwzj4c1vvVAeYkB1
         vpvezd40M1jhILaXnPu3T4FSrb2sAS2dshUM0sMQd6LU6RvrFObtgHZnh7C5occ5mDAb
         hQjrAQ27xONJrpwAl6Ac3sA5XYR3WnxR/9jBwjMlYYd3COPML8lHwN1/vMARaJsnqXEW
         sYYue+UceBwVYLIgsqIOweB5WEpS1Esdt2Ecs6uwvDuBrZbvyOjQoTPrTwhzsvpwekCc
         v+xDng8mnL3HdWSfBrnreOBTO6ZuW8/39XYDEfWcENAkiraCIdPhfYjLBzvFRnqlab2t
         ljVw==
X-Gm-Message-State: ANoB5pn2H+FXOTb6Md91nn/up20UEVRadFoQz08Q2+mVTqI3Su9Xe0QS
        a+fNny96ow2lJhHnk+EzdXVwhNg=
X-Google-Smtp-Source: AA0mqf6POcOAvgrUkrl711vuXNSof/3BT8e1WMDxoCgSx4f+sjsFIENcRqWGW5PmNAqzXCoMF9TVomk=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:8a11:b0:213:1935:9744 with SMTP id
 w17-20020a17090a8a1100b0021319359744mr3409621pjn.207.1668194274187; Fri, 11
 Nov 2022 11:17:54 -0800 (PST)
Date:   Fri, 11 Nov 2022 11:17:52 -0800
In-Reply-To: <20221111125620.754855-1-xukuohai@huaweicloud.com>
Mime-Version: 1.0
References: <20221111125620.754855-1-xukuohai@huaweicloud.com>
Message-ID: <Y26f4H7buQXKqQFd@google.com>
Subject: Re: [PATCH bpf] bpf: Fix offset calculation error in __copy_map_value
 and zero_map_value
From:   sdf@google.com
To:     Xu Kuohai <xukuohai@huaweicloud.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/11, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>

> Function __copy_map_value and zero_map_value miscalculated copy offset,
> resulting in possible copy of unwanted data to user or kernel.

> Fix it.

> Fixes: cc48755808c6 ("bpf: Add zero_map_value to zero map value with  
> special fields")
> Fixes: 4d7d7f69f4b1 ("bpf: Adapt copy_map_value for multiple offset case")
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>   include/linux/bpf.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 74c6f449d81e..c1bd1bd10506 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -315,7 +315,7 @@ static inline void __copy_map_value(struct bpf_map  
> *map, void *dst, void *src, b
>   		u32 next_off = map->off_arr->field_off[i];

>   		memcpy(dst + curr_off, src + curr_off, next_off - curr_off);
> -		curr_off += map->off_arr->field_sz[i];
> +		curr_off = next_off + map->off_arr->field_sz[i];
>   	}
>   	memcpy(dst + curr_off, src + curr_off, map->value_size - curr_off);
>   }
> @@ -344,7 +344,7 @@ static inline void zero_map_value(struct bpf_map  
> *map, void *dst)
>   		u32 next_off = map->off_arr->field_off[i];

>   		memset(dst + curr_off, 0, next_off - curr_off);
> -		curr_off += map->off_arr->field_sz[i];
> +		curr_off = next_off + map->off_arr->field_sz[i];
>   	}
>   	memset(dst + curr_off, 0, map->value_size - curr_off);
>   }

Hmm, does it mean that it currently works only for the cases where
these special fields are first/last?

Also, what about bpf-next? The same problem seem to exist there?

Might be a good idea to have some selftest to exercise this?

> --
> 2.30.2

