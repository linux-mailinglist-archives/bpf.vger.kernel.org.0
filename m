Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D9F4CB40D
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 02:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiCCAh1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 19:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiCCAh0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 19:37:26 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F00DCA0F7
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 16:36:40 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id t7so3404749ybi.8
        for <bpf@vger.kernel.org>; Wed, 02 Mar 2022 16:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rYpc8OdpiDyhS7cAK/Cj+v+hA3m1UOUbP84FLYfv7jA=;
        b=ItSFvhBH5/lD6xqAF8pwNl84z/sm8XsGp0ZhGIvoRbMohhwm361z3xWhFWVNCqzKnl
         XWd79sSuZWQmOO92MHnwh3ifSejoDiu5SjtRLwBkAKZ9JdIhuhpkF4O/SuMJRto4Br+4
         BxsaLbIfzin+H+iJKTj1dqfh5IS9HezaF9/WdYhXBNCyXiAwzMFWmRp3F4w0XkdWASLC
         nf/b+rP16MPRZTn5dyuxG7biqsawlqiZKXOwy6NLkwEz6IsMff/eoP3ib6Ox9tc5zYJz
         /MEDTeaR7PSV0Mxob2MK5mwHkMVJI9Bd7RIUfSSH/gV3D7GyfTaUdy371PW3rHAg5ged
         88xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rYpc8OdpiDyhS7cAK/Cj+v+hA3m1UOUbP84FLYfv7jA=;
        b=UU4mKoudt29YQxK1R7pddfDWcydNT9gcoxgLlbK7H4NvQPWWmYuURstRcoLGH1+iBj
         Ey1rxyCk8GmDSPrYUntRt/NLcFveOTRy4RqvHhFPMPBnA21sjZAQM0H9Bho484fr0UJ/
         Gq6N91dyD820oTAFC+17BR3JMqtJ/ak8ngLtBq1F6SZKZGPqElzlqb8sKlRtp03BZ9cO
         a4BRu+yUJnfFmtWJOWv/1Z+NH9dInvUTLPWLXLsHeemQPm+1oV3cTUhiJAFlTLp2o69i
         uHOVi1Gm0Wilk9wg+fUsYu7dU55F4+hl/e5KN9RAphxHWOi89jeK0Ox5rKjL/lPSEaz6
         wJXQ==
X-Gm-Message-State: AOAM5324NQyuFO5Xau/dHPK1b5CvIYzxW7HcCADW9BmR/yJyo5s8kLrA
        r8Vrk3xIdzbpUcCaERo6Zt+TZZZhDkfxTpsXW/KvYA==
X-Google-Smtp-Source: ABdhPJzEqzamXbJ9LAWN805a5p9Niqcj4YHwX+QMeOIj6aBYlZPOf+ZPb6S976BkU57CB3L8gT9jZfIM22ctEYTaFgE=
X-Received: by 2002:a25:8c86:0:b0:628:a042:9529 with SMTP id
 m6-20020a258c86000000b00628a0429529mr5078055ybl.231.1646267799249; Wed, 02
 Mar 2022 16:36:39 -0800 (PST)
MIME-Version: 1.0
References: <20220302195519.3479274-1-kafai@fb.com>
In-Reply-To: <20220302195519.3479274-1-kafai@fb.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 2 Mar 2022 16:36:28 -0800
Message-ID: <CANn89iLMi8FbT89BvyUCEAHscbqskXAt9tmeeqXZSeDcu8bN=g@mail.gmail.com>
Subject: Re: [PATCH v6 net-next 0/13] Preserve mono delivery time (EDT) in skb->tstamp
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 2, 2022 at 11:55 AM Martin KaFai Lau <kafai@fb.com> wrote:
>
> skb->tstamp was first used as the (rcv) timestamp.
> The major usage is to report it to the user (e.g. SO_TIMESTAMP).
>
> Later, skb->tstamp is also set as the (future) delivery_time (e.g. EDT in TCP)
> during egress and used by the qdisc (e.g. sch_fq) to make decision on when
> the skb can be passed to the dev.
>
> Currently, there is no way to tell skb->tstamp having the (rcv) timestamp
> or the delivery_time, so it is always reset to 0 whenever forwarded
> between egress and ingress.
>
> While it makes sense to always clear the (rcv) timestamp in skb->tstamp
> to avoid confusing sch_fq that expects the delivery_time, it is a
> performance issue [0] to clear the delivery_time if the skb finally
> egress to a fq@phy-dev.
>
> This set is to keep the mono delivery time and make it available to
> the final egress interface.  Please see individual patch for
> the details.
>
> [0] (slide 22): https://linuxplumbersconf.org/event/11/contributions/953/attachments/867/1658/LPC_2021_BPF_Datapath_Extensions.pdf
>

For the whole series

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !
