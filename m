Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2881854F286
	for <lists+bpf@lfdr.de>; Fri, 17 Jun 2022 10:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380252AbiFQIKw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jun 2022 04:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379873AbiFQIKv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Jun 2022 04:10:51 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B87267D3E
        for <bpf@vger.kernel.org>; Fri, 17 Jun 2022 01:10:51 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-3177f4ce3e2so11892797b3.5
        for <bpf@vger.kernel.org>; Fri, 17 Jun 2022 01:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bLJ+ygnznigsHy4mG/EJkipb+OAZRFLUtzF0yM0ZkzU=;
        b=Hql5RmhMdx13Ic5swUkBRLjJ4Zg9+D8bcx4pUUz/6izcMOPF1DctF2M+FvHj1KukQ4
         4pj1Rz1s+2ZnGPJHZZOpO9f4+ut7XwGQ+25WQyZ7GNJNLE1azn/5RzLntmEQqr+yepkf
         dzBEi5gQ1AHrCaMWVPy+XTHsUcLjm1kLGgWPEHjkXM0fy2pzVxSMSDMcjrzA5zQU4jZ1
         AlpZUA8m0PRYfI0FBfl8zNolOJ3LF+nvl7VSMW3tPUF/v7Q05QF5PLuCvZAkSr2gZ3hz
         C7KyuwWFqLfJwVBjNofA7EEY+gzrhqdebUHkvq3UPT59aSzWmSVfSeTP9jpgrEkI08ZP
         4UAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bLJ+ygnznigsHy4mG/EJkipb+OAZRFLUtzF0yM0ZkzU=;
        b=pP3BD7QfSFxASMuDgNMt2A6BtrM0vHKHAQSf5ONF2/tut3nS0t5+PVsqkz0gHVEh6T
         xeEntZja++kECJH+LexnzNs7QQaq49T9kBdhmtWUiUOjyYylExLgYrEOr5M4orLP29oE
         kz4p3eKIbvC54C2reNM7BFkpQ43v/fAN0cL1sDn6YI5enj0WJWXmg/agJ2ZTdKg80CBd
         xvULeVg3Rna0FYpNplbESlZLRxhMML33mG9zN2hCSIJgAqX8zwQ0NASqk+CXSSGSoYaR
         v8SpVgaa0pUPmjoDB+7y2PQKDiWhp5JjhMfa3XwNIh/5ofJ/srbD+U49CMdrCPmQbC/V
         aFLw==
X-Gm-Message-State: AJIora9lzrtQjEEPdFc7fIyMINKAk9Ga/B1Hxk13tXHcg9igrkbmDVfB
        kdTcmsByEYJvKJUD2a8NN8KBtMPmpfsVrMT/3/Qmeg==
X-Google-Smtp-Source: AGRyM1taQ1b1FfHdvnpgwkGh3gQGrCUHVj/UsjiG20eYFtTvkHB9JCzKJf4qoyYF4f0ylXNd+ekIEzNp4zmlsQcsj18=
X-Received: by 2002:a0d:d997:0:b0:30c:962e:7aa6 with SMTP id
 b145-20020a0dd997000000b0030c962e7aa6mr10090099ywe.278.1655453449785; Fri, 17
 Jun 2022 01:10:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220617071855.2482-1-zhudi2@huawei.com>
In-Reply-To: <20220617071855.2482-1-zhudi2@huawei.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 17 Jun 2022 10:10:38 +0200
Message-ID: <CANn89iK2JH5q3WUH9G58-WVhkaxpCvLbWrgKe17nKyethTr9bw@mail.gmail.com>
Subject: Re: [PATCH] bpf: Don't redirect packets with pkt_len 0
To:     Di Zhu <zhudi2@huawei.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        rose.chen@huawei.com,
        syzbot+7a12909485b94426aceb@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 17, 2022 at 9:19 AM Di Zhu <zhudi2@huawei.com> wrote:
>
> Syzbot found an issue [1]: fq_codel_drop() try to drop a flow whitout any
> skbs, that is, the flow->head is null.
> The root cause, as the [2] says, is because that bpf_prog_test_run_skb()
> run a bpf prog which redirects empty skbs.
> So we should determine whether the length of the packet modified by bpf
> prog or others like bpf_prog_test is 0 before forwarding it directly.
>
> LINK: [1] https://syzkaller.appspot.com/bug?id=0b84da80c2917757915afa89f7738a9d16ec96c5
> LINK: [2] https://www.spinics.net/lists/netdev/msg777503.html
>
> Reported-by: syzbot+7a12909485b94426aceb@syzkaller.appspotmail.com
> Signed-off-by: Di Zhu <zhudi2@huawei.com>
> ---
>  net/core/filter.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 5af58eb48587..c7fbfa90898a 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2156,6 +2156,9 @@ static int __bpf_redirect_common(struct sk_buff *skb, struct net_device *dev,
>  static int __bpf_redirect(struct sk_buff *skb, struct net_device *dev,
>                           u32 flags)
>  {
> +       if (unlikely(skb->len == 0))
> +               return -EINVAL;
> +

You focus again on fq_codel, but we have a more generic issue at hand.

I said that most drivers will assume packets are Ethernet ones, having
at least an Ethernet header in them.

Also returning -EINVAL will leak the skb :/

I think a better fix would be to make sure the skb carries an expected
packet length,
and this probably differs in __bpf_redirect_common() and
__bpf_redirect_no_mac() ?

Current test in __bpf_redirect_common() seems not good enough.

+       /* Verify that a link layer header is carried */
+       if (unlikely(skb->mac_header >= skb->network_header)) {
+               kfree_skb(skb);
+               return -ERANGE;
+       }
+

It should check that the link layer header size is >= dev->min_header_len


>         if (dev_is_mac_header_xmit(dev))
>                 return __bpf_redirect_common(skb, dev, flags);
>         else
> --
> 2.27.0
>
