Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B97575E55
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 11:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiGOJSN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 05:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiGOJSM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 05:18:12 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5107F2AE8
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 02:18:11 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-31c89653790so41187517b3.13
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 02:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k3C0wIojyulqJOc3gqPPTvNhV+eA7FObSuZqLBbdRPM=;
        b=pOogBYE+C6kqGGUAfEUij9yax6uLLM1R/aVT53WeTPmxIYZFWu6IWa2WPjga4I/MNH
         P4HlXB3K/l4UpcvdlOrtecwmGdwA2MUh+2OePYYn/Y4ea/EqxDJTYaOotoyfIrPOLdc/
         oWWQkFZjgD51+iObnDFwo/7bUIIxqTYnXHAaj7DZCOvVXkBaTSsH0VdaSwZs/hlpXC4K
         7lBmLHoy1pLi9k98lUEObNmpfiFwWxKnovSOb+FuADITS42NiyabI8TSYOyGDR+tW7bA
         68YbPJQAYaPmkx1mQmtYnngXnbMQL2FG7jqtw239GNfsJLCBbIsYP4Jsd8SAnBbFR4Am
         YHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k3C0wIojyulqJOc3gqPPTvNhV+eA7FObSuZqLBbdRPM=;
        b=2FjEM59For1BRzqaDmqcO9NZDMqrZBB4pOlYNka5hgOc7WUJMyKMMw274bV3a+r2rm
         n3+D3J3DiM4yUdSqknp1rhyCH4j4PFFsyOKauMyalhccjcnX0ep9tbSc8yVgp/Ou6HRE
         kIRpTmjh6WJRT0H0GFtrkyzSoqdOslKDDzEti9Ns4i9J+KO2m/loMchCisXwl7I1cs+/
         iTtjQU6koOPKxyzwymKgfo5LyY8gI98Fo7h2AWzgBcOeyCO/bg2g0FP511JgsDFfTz1y
         7hg8foRjTM5omO9zKFgN8Kv/T4ujbxq572xlYAeP1b67KRaR67E4eLabYDOD29gZxAwd
         gsJw==
X-Gm-Message-State: AJIora//mLIMFa36DxNCuGgtTpYImSYasb63wFJsGa7jeKfdoCJeY0ML
        v2g1EABYiw3/tAACncWZWVUjRoCmyhn7DRvwGGMNfg==
X-Google-Smtp-Source: AGRyM1vG8/RlhJDU4+yZQLBM+ZndwV5DjU4EYfGa6tSpfbbGXItXheAJxeNNY805A4KiKuOF3zqWH6FVEA50bsNrh9Y=
X-Received: by 2002:a81:5045:0:b0:31c:9f67:a611 with SMTP id
 e66-20020a815045000000b0031c9f67a611mr15041103ywb.55.1657876690309; Fri, 15
 Jul 2022 02:18:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220715032233.230507-1-shaozhengchao@huawei.com> <20220714213025.448faf8c@kernel.org>
In-Reply-To: <20220714213025.448faf8c@kernel.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 15 Jul 2022 11:17:59 +0200
Message-ID: <CANn89iLS6rhm_N6g-x0JQC8s2Kx2yVO7+r89BdBZNrzr9473WQ@mail.gmail.com>
Subject: Re: [PATCH v3,bpf-next] bpf: Don't redirect packets with invalid pkt_len
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Zhengchao Shao <shaozhengchao@huawei.com>,
        bpf <bpf@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, martin.lau@linux.dev,
        song@kernel.org, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Menglong Dong <imagedong@tencent.com>,
        Petr Machata <petrm@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
        David Ahern <dsahern@kernel.org>,
        Talal Ahmad <talalahmad@google.com>,
        Kees Cook <keescook@chromium.org>, Hao Luo <haoluo@google.com>,
        jolsa@kernel.org, weiyongjun1@huawei.com,
        YueHaibing <yuehaibing@huawei.com>
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

On Fri, Jul 15, 2022 at 6:30 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Fri, 15 Jul 2022 11:22:33 +0800 Zhengchao Shao wrote:
> > +#ifdef CONFIG_DEBUG_NET
> > +     if (unlikely(!skb->len)) {
> > +             pr_err("%s\n", __func__);
> > +             skb_dump(KERN_ERR, skb, false);
> > +             WARN_ON_ONCE(1);
> > +     }
>
> Is there a reason to open code WARN_ONCE() like that?
>
> #ifdef CONFIG_DEBUG_NET
>         if (WARN_ONCE(!skb->len, "%s\n", __func__))
>                 skb_dump(KERN_ERR, skb, false);
>
> or
>
>         if (IS_ENABLED(CONFIG_DEBUG_NET) &&
>             WARN_ONCE(!skb->len, "%s\n", __func__))
>                 skb_dump(KERN_ERR, skb, false);


Also the skb_dump() needs to be done once.

DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);
