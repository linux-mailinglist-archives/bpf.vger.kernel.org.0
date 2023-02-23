Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8306A13FD
	for <lists+bpf@lfdr.de>; Fri, 24 Feb 2023 00:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjBWXvm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 18:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBWXvm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 18:51:42 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95895BBA5
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 15:51:40 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id z2so15084494plf.12
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 15:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tVvWUv0BGIe7/3VBYuUsO5y1TqtFhiYq+3GQbQ97c8=;
        b=hW6SpNgwtKfFKOrPeFMSQLz32mq1Sccye0rlTEdPEpFZj0QXXmrBs5NLMTu1ToNIW9
         ucMNLaZjhRtsdyjD5KeDoNsS6QNBK+L9Ojfs55ezQ4Bw/efbP+FEA35X48Cz7jtSYSaX
         LNetvqVlN6frogqAT5wdC992jUqq/BfYqs6GL6srorSZeaWIigl+0uYONt4S/+/zAJuJ
         39Q3Qs+2ZcryrIpxO7dUEgxDFQupS65gcYrImso0Qglnv0lQxIgEF7E6sCAXa80CMSWm
         j3Gp9QDodqygJXwVDA4a1iza42a9FnbZs8NoL36T+wfLr6UNrcdsNTEMJ06Ijy7gaZEn
         eilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1tVvWUv0BGIe7/3VBYuUsO5y1TqtFhiYq+3GQbQ97c8=;
        b=UADexoOVa1TpmHZRIfM6yknyrtSrmMueub8nzpPiBEttJLd0FeOXTMZyJySi5GFv77
         8sxAMXZHAJiX8WBGQEbCpk6jxGgHNZZirZTay6X4IYKFdwh6eW7wFcMsY0N/R8Qxf2bg
         FN/0vvIy3Dxyt6CgLCZjkdRNdi51Yu7rL1bW+ZfZm8sIxXIbGRzOVmSfQyrYHvLwxTcP
         uxX6z3rd7SG4Ku+fMeEdq9arblECYlIJY1qITyNsINjVfmHwwx1p2e4PPROlQuy2+GjB
         2VUAdAdUtgDncOesmXVxoJUEM32iWridiI2DcdLk6Vod7C+gdvrVi+gVpHTLDiIzyQxn
         BTkQ==
X-Gm-Message-State: AO0yUKWp20khMBmK8tVAjkz6goyBNeUxfOaPJ2jlru7pz1l+5Dxvu7HE
        Q4dQi/iuN6eKZZ9erlOJfcGoW/l+jkFjDH0OK9Hk45OVL577WU6SmJo=
X-Google-Smtp-Source: AK7set/9wFX0m1nJRtXqRvJTrJu6bkQmTJPeqKk2RHSScwyZDPiig8UVw3v1eUzG5r32htvw1iwT/Q+noQKxOLlrS8A=
X-Received: by 2002:a17:90b:a49:b0:234:258f:e2a8 with SMTP id
 gw9-20020a17090b0a4900b00234258fe2a8mr993471pjb.6.1677196299908; Thu, 23 Feb
 2023 15:51:39 -0800 (PST)
MIME-Version: 1.0
References: <Y/fnZkXQdc8lkP7q@google.com> <874jrcklvf.fsf@toke.dk>
In-Reply-To: <874jrcklvf.fsf@toke.dk>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 23 Feb 2023 15:51:28 -0800
Message-ID: <CAKH8qBsoTiVja8=EXTcfJNYpF7JjgPoD=Wi4JBX5PGbggn=S4g@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] XDP metadata for TX
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>
Cc:     lsf-pc@lists.linux-foundation.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Feb 23, 2023 at 3:22 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@kern=
el.org> wrote:
>
> Stanislav Fomichev <sdf@google.com> writes:
>
> > I'd like to discuss a potential follow up for the previous "XDP RX
> > metadata" series [0].
> >
> > Now that we can access (a subset of) packet metadata at RX, I'd like to
> > explore the options where we can export some of that metadata on TX. An=
d
> > also whether it might be possible to access some of the TX completion
> > metadata (things like TX timestamp).
> >
> > I'm currently trying to understand whether the same approach I've used
> > on RX could work at TX. By May I plan to have a bunch of options laid
> > out (currently considering XSK tx/compl programs and XDP tx/compl
> > programs) so we have something to discuss.
>
> I've been looking at ways of getting a TX-completion hook for the XDP
> queueing stuff as well. For that, I think it could work to just hook
> into xdp_return_frame(), but if you want to access hardware metadata
> it'll obviously have to be in the driver. A hook in the driver could
> certainly be used for the queueing return as well, though, which may
> help making it worth the trouble :)

Yeah, I'd like to get to completion descriptors ideally; so nothing
better than a driver hook comes to mind so far :-(
(I'm eye-balling mlx5's mlx5e_free_xdpsq_desc AF_XDP path mostly so far).

> > I'd like to some more input on whether applying the same idea on TX
> > makes sense or not and whether there are any sensible alternatives.
> > (IIRC, there was an attempt to do XDP on egress that went nowhere).
>
> I believe that stranded because it was deemed not feasible to cover the
> SKB TX path as well, which means it can't be symmetrical to the RX hook.
> So we ended up with the in-devmap hook instead. I'm not sure if that's
> made easier by multi-buf XDP, so that may be worth revisiting.
>
> For the TX metadata you don't really have to care about the skb path, I
> suppose, so that may not matter too much either. However, at least for
> the in-kernel xdp_frame the TX path is pushed from the stack anyway, so
> I'm not sure if it's worth having a separate hook in the driver (with
> all the added complexity and overhead that entails) just to set
> metadata? That could just as well be done on push from higher up the
> stack; per-driver kfuncs could still be useful for this, though.
>
> And of course something would be needed so that that BPF programs can
> process AF_XDP frames in the kernel before they hit the driver, but
> again I'm not sure that needs to be a hook in the driver.

Care to elaborate more on "push from higher up the stack"?

I've been thinking about mostly two cases:
- XDP_TX - I think this one technically doesn't need an extra hook;
all metadata manipulations can be done at xdp_rx? (however, not sure
how real that is, since the descriptors are probably not exposed over
there?)
- AF_XDP TX - this one needs something deep in the driver (due to tx
zc) to populate the descriptors?
- anything else?

> In any case, the above is just my immediate brain dump (I've been
> mulling these things over for a while in relation to the queueing
> stuff), and I'd certainly welcome more discussion on the subject! :)

Awesome, thanks for the dump! Will try to keep you in the loop!

> -Toke
