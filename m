Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C743C576AB8
	for <lists+bpf@lfdr.de>; Sat, 16 Jul 2022 01:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbiGOXbJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 19:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbiGOXbJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 19:31:09 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F24745068
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 16:31:08 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id l124so5852853pfl.8
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 16:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mFhNjwAZwgCoPX/p4vU8fztm+8bs1htpBpCTi8mrfrg=;
        b=PsgVxPieDaLMj9SqjoAVctwayDpsvX8oV4o8qNNb3l3gWanlGF8VFFzDVVzl2emFNo
         hYGce79dhXC3K2O/Eie4RS9SZ9YLmBPYmW6ZODI+Hy9ToAbdkjNxo3LjYH/eMsJyjTHn
         Lgoy5/ZJoMipQYkT+U1uQ1gjbKStBLcJmO+BONLLQT7s5AOZIHAdG7/DFgBr41yIH+1y
         jF3QEpS7SUx2EJ2WUZz4epjIf8acMlYoQVMQ/oo1QdeaLT51TUu05uxtPDpSMXgo92BV
         d+sZmMRgJG4OTWAHsyMLw8ynHmDNvnsZPR7HhDcUYLDceYWAxzfACJzPKpYxL2XJVOET
         gk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mFhNjwAZwgCoPX/p4vU8fztm+8bs1htpBpCTi8mrfrg=;
        b=uTBSl/wpr88cHEHkfeK5swzbMS0JI+2rCiX9HxlR6kgZkJBgEsuXW/gk6PmPnJ/ozd
         /Cg2PzZZ6C3+cKNnxOairxw094rPPFHtFJ3UOWw9gB5l305PK6Wq+rOW4kAldFA9BoRZ
         afuE2hBHg8gXd+wtomMxh+bmGvnXIV9BYsltouBJwleY/npKARRxYX/zXtZbTIWmjnkV
         qjsYJVUUWAj5aMm0uB+EEueFGGL5W98jql/pejJueoIS3vRlPrJ5JuiawR/NBjHcVmwT
         qyMQ7K89w4UgyKtBwRbJrKNt9rtE3gvmPdJ8AJ9NMX//x3ClStmwx1Q9/vBa6W+C/BoE
         9ULA==
X-Gm-Message-State: AJIora+s+klE/VthFs3Jn85wsG3xD6XdCUhldiqjCnz9nw8lvL/QWHJ9
        io8LY7kJSxZIA4DKVrmS+ekeZXJenesQxGN6jkI9rg==
X-Google-Smtp-Source: AGRyM1vuZFX+hhimr0i3qo3XMk2nyCArPmkQwSwf9mwIUjHEVa021s/nYBIwTNN1ey1OGMOBdGD7pz6zUlMtH+DZJHw=
X-Received: by 2002:a65:4c0b:0:b0:415:d3a4:44d1 with SMTP id
 u11-20020a654c0b000000b00415d3a444d1mr14529298pgq.191.1657927867645; Fri, 15
 Jul 2022 16:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220715115559.139691-1-shaozhengchao@huawei.com>
In-Reply-To: <20220715115559.139691-1-shaozhengchao@huawei.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 15 Jul 2022 16:30:56 -0700
Message-ID: <CAKH8qBtOiRNgZUf5QRZOwv=2uwTeUPY-CCkdJ-7WgEbPjce5OQ@mail.gmail.com>
Subject: Re: [PATCH v4,bpf-next] bpf: Don't redirect packets with invalid pkt_len
To:     Zhengchao Shao <shaozhengchao@huawei.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        hawk@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        bigeasy@linutronix.de, imagedong@tencent.com, petrm@nvidia.com,
        arnd@arndb.de, dsahern@kernel.org, talalahmad@google.com,
        keescook@chromium.org, haoluo@google.com, jolsa@kernel.org,
        weiyongjun1@huawei.com, yuehaibing@huawei.com
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

On Fri, Jul 15, 2022 at 4:51 AM Zhengchao Shao <shaozhengchao@huawei.com> wrote:
>
> Syzbot found an issue [1]: fq_codel_drop() try to drop a flow whitout any
> skbs, that is, the flow->head is null.
> The root cause, as the [2] says, is because that bpf_prog_test_run_skb()
> run a bpf prog which redirects empty skbs.
> So we should determine whether the length of the packet modified by bpf
> prog or others like bpf_prog_test is valid before forwarding it directly.
>
> LINK: [1] https://syzkaller.appspot.com/bug?id=0b84da80c2917757915afa89f7738a9d16ec96c5
> LINK: [2] https://www.spinics.net/lists/netdev/msg777503.html
>
> Reported-by: syzbot+7a12909485b94426aceb@syzkaller.appspotmail.com
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>

Reviewed-by: Stanislav Fomichev <sdf@google.com>

Looks like it addresses everything?

> ---
> v3: modify debug print
> v2: need move checking to convert___skb_to_skb and add debug info
> v1: should not check len in fast path
>
>  include/linux/skbuff.h | 8 ++++++++
>  net/bpf/test_run.c     | 3 +++
>  net/core/dev.c         | 1 +
>  3 files changed, 12 insertions(+)
>
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index f6a27ab19202..82e8368ba6e6 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -2459,6 +2459,14 @@ static inline void skb_set_tail_pointer(struct sk_buff *skb, const int offset)
>
>  #endif /* NET_SKBUFF_DATA_USES_OFFSET */
>
> +static inline void skb_assert_len(struct sk_buff *skb)
> +{
> +#ifdef CONFIG_DEBUG_NET
> +       if (WARN_ONCE(!skb->len, "%s\n", __func__))
> +               DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);
> +#endif /* CONFIG_DEBUG_NET */
> +}
> +
>  /*
>   *     Add data to an sk_buff
>   */
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 2ca96acbc50a..dc9dc0bedca0 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -955,6 +955,9 @@ static int convert___skb_to_skb(struct sk_buff *skb, struct __sk_buff *__skb)
>  {
>         struct qdisc_skb_cb *cb = (struct qdisc_skb_cb *)skb->cb;
>
> +       if (!skb->len)
> +               return -EINVAL;
> +
>         if (!__skb)
>                 return 0;
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index d588fd0a54ce..716df64fcfa5 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4168,6 +4168,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
>         bool again = false;
>
>         skb_reset_mac_header(skb);
> +       skb_assert_len(skb);
>
>         if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_SCHED_TSTAMP))
>                 __skb_tstamp_tx(skb, NULL, NULL, skb->sk, SCM_TSTAMP_SCHED);
> --
> 2.17.1
>
