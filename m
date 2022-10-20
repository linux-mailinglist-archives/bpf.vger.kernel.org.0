Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC61606751
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 19:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJTRwP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 13:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiJTRwO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 13:52:14 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C36A1989B9
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 10:52:13 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id a17so337264ilq.1
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 10:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xFC8eBdRKA2i5KUJ4BGX8YJucq4rHfeFDCAXrWtdnmw=;
        b=VlkvFlg1N9P+Q93DFX8a051rYvTScwWDP2J1ug748qEx0u+x0hZy7QMM1kuX/e4zb2
         NY1XgziAiAbfxAsAegCqWyCeiBDr6A6xUecR5WnOjM8mRhwwav9c532PZ76hFcLC0KRP
         lgtmhrkkvHFEqm12KSQnh2cr0D3cDDql4j7xTSWfyyJeZGPZplJ3wHpyMSOqSIxNm+Pb
         BHDHsIdqSrrq0xSwB73xyVnU6bM3CS96lvkz0TUc//KWsQxgQS+8jBFnCMEz/m4KS71m
         kcZ6LRJmmxYSa1J076y9+c+XzRCtH9ohjV7pj0cJQV/VZVIEDyAiYMZZvMNNc4xbiq7j
         j6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xFC8eBdRKA2i5KUJ4BGX8YJucq4rHfeFDCAXrWtdnmw=;
        b=8FfEDNf2jrmS0byAQ8I79tEOixcycchXND8iqfLus3IX5JUzpgklf2JRGjAql/ojdI
         sWfszX0qAMWMP9/OTJ06LOX46+bswdUS0QLuNiwKchYXQ2C8z/nryT5rScjygCLOGaly
         xp/YWKk8XLJNUF9QXk1ZYNWbDAozCYw1VlAip6K83yxofi6+XnOcLKlBdltwxoGBKK58
         1zpzTgA7vKCiTMSUmwKBPnzyQW4w+q/u0kX6yUqzfm0NMaLvbBZx//cA1QAqRL8q3WTD
         /Mg0XFRXFr7/8/8VUPrVV7N4hJ//qTL1McZ90u3lD0lFGj+NdZPKjDDu3g/8FTUq9T9w
         wU/w==
X-Gm-Message-State: ACrzQf0yKjNDFZYsDvXbNw0cTgRdoOSJvhfkBZQnO8AtKoDml0/+vGu7
        kzv3NfT53Uqln6VJ/DkawCo+IJL8008ljXwU9XMtVA==
X-Google-Smtp-Source: AMsMyM4XtIdUus2Ta+WdS1nYuusrCle4eod+zzAE/tJ40UoUzwZAbpaRlL2+Sv5+ivn52Cc8abOHFNmdiNuUSS1YTKc=
X-Received: by 2002:a05:6e02:17cb:b0:2f9:1fb4:ba3b with SMTP id
 z11-20020a056e0217cb00b002f91fb4ba3bmr10524527ilu.257.1666288332686; Thu, 20
 Oct 2022 10:52:12 -0700 (PDT)
MIME-Version: 1.0
References: <20221019115539.983394-1-houtao@huaweicloud.com>
 <20221019115539.983394-3-houtao@huaweicloud.com> <Y1BJXRgchDcxwKIJ@google.com>
 <2f968cf9-d90c-3b8c-2dcf-21719ab46e69@huaweicloud.com>
In-Reply-To: <2f968cf9-d90c-3b8c-2dcf-21719ab46e69@huaweicloud.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 20 Oct 2022 10:52:01 -0700
Message-ID: <CAKH8qBtpWKbJy-B9es3SFGsB5C_2OQCEGorpx2Jt4z4EhdivBQ@mail.gmail.com>
Subject: Re: [PATCH bpf 2/2] bpf: Use __llist_del_all() whenever possbile
 during memory draining
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 19, 2022 at 6:18 PM Hou Tao <houtao@huaweicloud.com> wrote:
>
> Hi,
>
> On 10/20/2022 3:00 AM, sdf@google.com wrote:
> > On 10/19, Hou Tao wrote:
> >> From: Hou Tao <houtao1@huawei.com>
> >
> >> Except for waiting_for_gp list, there are no concurrent operations on
> >> free_by_rcu, free_llist and free_llist_extra lists, so use
> >> __llist_del_all() instead of llist_del_all(). waiting_for_gp list can be
> >> deleted by RCU callback concurrently, so still use llist_del_all().
> >
> >> Signed-off-by: Hou Tao <houtao1@huawei.com>
> >> ---
> >>   kernel/bpf/memalloc.c | 7 +++++--
> >>   1 file changed, 5 insertions(+), 2 deletions(-)
> >
> >> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> >> index 48e606aaacf0..7f45744a09f7 100644
> >> --- a/kernel/bpf/memalloc.c
> >> +++ b/kernel/bpf/memalloc.c
> >> @@ -422,14 +422,17 @@ static void drain_mem_cache(struct bpf_mem_cache *c)
> >>       /* No progs are using this bpf_mem_cache, but htab_map_free() called
> >>        * bpf_mem_cache_free() for all remaining elements and they can be in
> >>        * free_by_rcu or in waiting_for_gp lists, so drain those lists now.
> >> +     *
> >> +     * Except for waiting_for_gp list, there are no concurrent operations
> >> +     * on these lists, so it is safe to use __llist_del_all().
> >>        */
> >>       llist_for_each_safe(llnode, t, __llist_del_all(&c->free_by_rcu))
> >>           free_one(c, llnode);
> >>       llist_for_each_safe(llnode, t, llist_del_all(&c->waiting_for_gp))
> >>           free_one(c, llnode);
> >> -    llist_for_each_safe(llnode, t, llist_del_all(&c->free_llist))
> >> +    llist_for_each_safe(llnode, t, __llist_del_all(&c->free_llist))
> >>           free_one(c, llnode);
> >> -    llist_for_each_safe(llnode, t, llist_del_all(&c->free_llist_extra))
> >> +    llist_for_each_safe(llnode, t, __llist_del_all(&c->free_llist_extra))
> >>           free_one(c, llnode);
> >
> > Acked-by: Stanislav Fomichev <sdf@google.com>
> Thanks for the Acked-by.
> >
> > Seems safe even without the previous patch? OTOH, do we really care
> > about __lllist vs llist in the cleanup path? Might be safer to always
> > do llist_del_all everywhere?
> No. free_llist is manipulated by both irq work and memory draining concurrently
> before patch #1. Using llist_del_all(&c->free_llist) also doesn't help because
> irq work uses __llist_add/__llist_del helpers. Basically there is no difference
> between __llist and list helper for cleanup patch, but I think it is better to
> clarity the possible concurrent accesses and codify these assumption.

But this is still mostly relevant only for the preemt_rt/has_interrupt
case, right?
For non-preempt, irq should've finished long before we got to drain_mem_cache.
