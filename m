Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E02605010
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 21:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiJSTAw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 15:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiJSTAv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 15:00:51 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931E21C25D9
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 12:00:48 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id p29-20020a056a0026dd00b00562f01c165cso10011254pfw.20
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 12:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GXRTMqQCOsJDk+Go1o3sPIhNcaW/mFoY7ff2QUkqX4c=;
        b=sGdoDNhN6ZwvR9kD4ZdM6j9x6MuZUR+cYHS7AcnT8qw77Yq148JFReZkr1q+vEPqKG
         hmP/0pp+TJ9J6kgmdLNLVFuHJ6uv5n8EvLVKVo96OdVF71ZcsKbxsIXjyDCZWI4dowbD
         kJwIVxwS1QexeH3TJWq8+nkvHh0aSEG68tT3HfNHihp+fc06DKp/q8DdVQmfk7UbwkHf
         TP1xE6NsZiS/5yB3pmNfLH1v0CkihwerSCgbTBm3QBWI0g1mIMEO0saxzflVSI0zwKlo
         60PtAEI/7qi4lz1VdnmArDsJPzgZQs+iS46hHZHLbDJ4AqQqFpzjY2mKhz7TKtKpDfE4
         6vvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GXRTMqQCOsJDk+Go1o3sPIhNcaW/mFoY7ff2QUkqX4c=;
        b=bhJfSAlBwoJ71itn5Y4xdwPm1shxziHg8hP/oSb6M2lzPoabTiGqE/XjP8umEyXKnG
         WYsHEd7q/1CXTdcR1K8peMuwJpzbmV8QJjf2q6JYA/v1ylOtBvCkKOJTA44cLloUUu3S
         9WQXxrnCLUgzehQF/lZmVMNi2nou48nBAeJUvGUDLPfeyDEReOIC6H0fOTD792Vmm7wv
         M5GpxetPsBLeJEM16ddg8EN//B5Wax1y8zL7rGA9bVX8zZYm8gE7Syol5QnSg642b/eI
         bV94ErtUM6JhoTK3f2jYwgqVDo3C3eUWMTgMSlwAR4hXnoOkl+amkfXDyVz7Uq8smXtC
         Br+g==
X-Gm-Message-State: ACrzQf1HiTKPCEfuZuaVqbsNRAqMI+cdIqu/AG5lASlv4mPfuChQ6Knt
        6rDaqAnuuX9Dgi0cG0mjYShxJmI=
X-Google-Smtp-Source: AMsMyM5PA2hgAjyELgatQ87OX0+OghkBw9XdHH3bnXTmGyCmX/XjaCg8/stQGvI1rJ3B8oiLRiJyJb8=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:c986:b0:205:f08c:a82b with SMTP id
 w6-20020a17090ac98600b00205f08ca82bmr2848016pjt.1.1666206047140; Wed, 19 Oct
 2022 12:00:47 -0700 (PDT)
Date:   Wed, 19 Oct 2022 12:00:45 -0700
In-Reply-To: <20221019115539.983394-3-houtao@huaweicloud.com>
Mime-Version: 1.0
References: <20221019115539.983394-1-houtao@huaweicloud.com> <20221019115539.983394-3-houtao@huaweicloud.com>
Message-ID: <Y1BJXRgchDcxwKIJ@google.com>
Subject: Re: [PATCH bpf 2/2] bpf: Use __llist_del_all() whenever possbile
 during memory draining
From:   sdf@google.com
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
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

On 10/19, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>

> Except for waiting_for_gp list, there are no concurrent operations on
> free_by_rcu, free_llist and free_llist_extra lists, so use
> __llist_del_all() instead of llist_del_all(). waiting_for_gp list can be
> deleted by RCU callback concurrently, so still use llist_del_all().

> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>   kernel/bpf/memalloc.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)

> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index 48e606aaacf0..7f45744a09f7 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -422,14 +422,17 @@ static void drain_mem_cache(struct bpf_mem_cache *c)
>   	/* No progs are using this bpf_mem_cache, but htab_map_free() called
>   	 * bpf_mem_cache_free() for all remaining elements and they can be in
>   	 * free_by_rcu or in waiting_for_gp lists, so drain those lists now.
> +	 *
> +	 * Except for waiting_for_gp list, there are no concurrent operations
> +	 * on these lists, so it is safe to use __llist_del_all().
>   	 */
>   	llist_for_each_safe(llnode, t, __llist_del_all(&c->free_by_rcu))
>   		free_one(c, llnode);
>   	llist_for_each_safe(llnode, t, llist_del_all(&c->waiting_for_gp))
>   		free_one(c, llnode);
> -	llist_for_each_safe(llnode, t, llist_del_all(&c->free_llist))
> +	llist_for_each_safe(llnode, t, __llist_del_all(&c->free_llist))
>   		free_one(c, llnode);
> -	llist_for_each_safe(llnode, t, llist_del_all(&c->free_llist_extra))
> +	llist_for_each_safe(llnode, t, __llist_del_all(&c->free_llist_extra))
>   		free_one(c, llnode);

Acked-by: Stanislav Fomichev <sdf@google.com>

Seems safe even without the previous patch? OTOH, do we really care
about __lllist vs llist in the cleanup path? Might be safer to always
do llist_del_all everywhere?

>   }

> --
> 2.29.2

