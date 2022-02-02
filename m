Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1BD4A7706
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 18:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240087AbiBBRn1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Feb 2022 12:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239840AbiBBRn1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Feb 2022 12:43:27 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF96BC06173B
        for <bpf@vger.kernel.org>; Wed,  2 Feb 2022 09:43:26 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id r65so800351ybc.11
        for <bpf@vger.kernel.org>; Wed, 02 Feb 2022 09:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1AqVNZJXvx/IAB9s8Flw5OyXSEScpBI+6YcWS+D12W8=;
        b=BxzvQAtHR5KBhP3P0dnnBFp5m8j1q7I0zoJaEfXnEuYXsE0wlQA5f0Qap/G6ua7jvw
         kPZI+TYhPbgERJ4shMsYok/nwiwuO/uuUl7YA0NxQQis2CVfYIV/ZtBeoYlSCqGmPXGz
         mMv75LtqzzeNfGJgVqsBlWB4SBpoTKhOGT/vZAEnE8zSQLfJk1iWAlxXNt7a10sP3tbp
         uHSI9+Nij+HV3jwZph0/KLOW0Ll/QiYxQn/sodp6Oytufo9JZ+TOhXp9TVDaS3mLVU+N
         zgWskg1Q7zYLcV6SiXsa8IL1c4o6fY5/v1PJpGMBtQAVYjkFsf01Mst3wt1vDl2a5UPv
         rrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1AqVNZJXvx/IAB9s8Flw5OyXSEScpBI+6YcWS+D12W8=;
        b=CoyX5fgw5mXAF/dspCSrg69VFUIKnHC7y7AQTya60RZxBXO8nSEkAO5LMdqXp4iv7l
         c7aTcIdbchyI0ZTK+dB9w6YPZwUfSlDqKC2FZ4Y7lGAMXxCbhSXGwneetaN4F/mj8n0W
         xSx9nu12glwMg1W++U87TvmVhIfPIIjgI74SBIpJyOtLh4iZTDj1qBcpyKuuKwZ0I86D
         a25yrCF7Rql6iGo9TR17GqokA8SBF89gl8nRR2u+La0ZNNlNTraJ0WosNh6B1mw87mkz
         KOodYYgEHSNhHraskL3F+u9K8b2yiFRo8kfT0xa4LGom5hN5Ub+NJJbuKGTdouHURY1K
         LqEQ==
X-Gm-Message-State: AOAM5304lv3HT8/QDL/s4ztGiUUSEBjMaHRcnrXK5mJQt4LJmd2q1M3b
        PKBtu3S3ulaa1P3iECU3VHB+jKy/FeSGkW6YnDtj1Q==
X-Google-Smtp-Source: ABdhPJwjEnuydmFUL15SM8J+7XZs6gDo5w9dIfFMKog+IlC78B8KY/P8Y4tbajVuXQnvS8z08UwjE8w8ilm/eXuv0QY=
X-Received: by 2002:a81:9808:: with SMTP id p8mr1660099ywg.531.1643823805765;
 Wed, 02 Feb 2022 09:43:25 -0800 (PST)
MIME-Version: 1.0
References: <20220202122848.647635-1-bigeasy@linutronix.de> <20220202122848.647635-4-bigeasy@linutronix.de>
In-Reply-To: <20220202122848.647635-4-bigeasy@linutronix.de>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 2 Feb 2022 09:43:14 -0800
Message-ID: <CANn89iLVPnhybrdjRh6ccv6UZHW-_W0ZHRO5c7dnWU44FUgd_g@mail.gmail.com>
Subject: Re: [PATCH net-next 3/4] net: dev: Makes sure netif_rx() can be
 invoked in any context.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     bpf <bpf@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 2, 2022 at 4:28 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> Dave suggested a while ago (eleven years by now) "Let's make netif_rx()
> work in all contexts and get rid of netif_rx_ni()". Eric agreed and
> pointed out that modern devices should use netif_receive_skb() to avoid
> the overhead.
> In the meantime someone added another variant, netif_rx_any_context(),
> which behaves as suggested.
>
> netif_rx() must be invoked with disabled bottom halves to ensure that
> pending softirqs, which were raised within the function, are handled.
> netif_rx_ni() can be invoked only from process context (bottom halves
> must be enabled) because the function handles pending softirqs without
> checking if bottom halves were disabled or not.
> netif_rx_any_context() invokes on the former functions by checking
> in_interrupts().
>
> netif_rx() could be taught to handle both cases (disabled and enabled
> bottom halves) by simply disabling bottom halves while invoking
> netif_rx_internal(). The local_bh_enable() invocation will then invoke
> pending softirqs only if the BH-disable counter drops to zero.
>
> Add a local_bh_disable() section in netif_rx() to ensure softirqs are
> handled if needed. Make netif_rx_ni() and netif_rx_any_context() invoke
> netif_rx() so they can be removed once they are no more users left.
>
> Link: https://lkml.kernel.org/r/20100415.020246.218622820.davem@davemloft.net
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Maybe worth mentioning this commit will show a negative impact, for
network traffic
over loopback interface.

My measure of the cost of local_bh_disable()/local_bh_enable() is ~6
nsec on one of my lab x86 hosts.

Perhaps we could have a generic netif_rx(), and a __netif_rx() for the
virtual drivers (lo and maybe tunnels).

void __netif_rx(struct sk_buff *skb);

static inline int netif_rx(struct sk_buff *skb)
{
   int res;
    local_bh_disable();
    res = __netif_rx(skb);
  local_bh_enable();
  return res;
}
