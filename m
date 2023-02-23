Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6006A13B3
	for <lists+bpf@lfdr.de>; Fri, 24 Feb 2023 00:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjBWXWw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 18:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBWXWv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 18:22:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3FC10CB
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 15:22:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E3EBB81B5E
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 23:22:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0138C433EF;
        Thu, 23 Feb 2023 23:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677194566;
        bh=IbIA5HWtGD7/b/h0ZJ/9yRHE1uGNSFe/3jE0Wifd4Ao=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=oytMti6jTqj8aiXcyUdVtR7y+LZt/XCcu+zJccR2j7iYGplVbCYiZ3hDYWgmrkdKF
         w7TYUijEbA5SuwEs1ibrBbrYtSdtzluXmix6CJvIcjG2D6cflhMaFApsfrezxQeBaj
         vhggZPsT00OtstQtDmdsh5DuJ84Mz7k/uka1zE39N5rOfodr814ZrUjEIcafHjgbKJ
         9X0IUm+T7+Yds+qemb+0GoQ/Acm/2EjNDZC8P7HMljYbh5wzWgAXzokH4y8ix31cFH
         FmK1qRxocBA3elcmfCyV5qWKIi88Zu8T44PhAok8iVEHAJNCJoWXpVntcm33FJ2sSZ
         83kPMjaSQh5Vg==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 14A62975513; Fri, 24 Feb 2023 00:22:44 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Stanislav Fomichev <sdf@google.com>,
        lsf-pc@lists.linux-foundation.org
Cc:     bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] XDP metadata for TX
In-Reply-To: <Y/fnZkXQdc8lkP7q@google.com>
References: <Y/fnZkXQdc8lkP7q@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 24 Feb 2023 00:22:44 +0100
Message-ID: <874jrcklvf.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Stanislav Fomichev <sdf@google.com> writes:

> I'd like to discuss a potential follow up for the previous "XDP RX
> metadata" series [0].
>
> Now that we can access (a subset of) packet metadata at RX, I'd like to
> explore the options where we can export some of that metadata on TX. And
> also whether it might be possible to access some of the TX completion
> metadata (things like TX timestamp).
>
> I'm currently trying to understand whether the same approach I've used
> on RX could work at TX. By May I plan to have a bunch of options laid
> out (currently considering XSK tx/compl programs and XDP tx/compl
> programs) so we have something to discuss.

I've been looking at ways of getting a TX-completion hook for the XDP
queueing stuff as well. For that, I think it could work to just hook
into xdp_return_frame(), but if you want to access hardware metadata
it'll obviously have to be in the driver. A hook in the driver could
certainly be used for the queueing return as well, though, which may
help making it worth the trouble :)

> I'd like to some more input on whether applying the same idea on TX
> makes sense or not and whether there are any sensible alternatives.
> (IIRC, there was an attempt to do XDP on egress that went nowhere).

I believe that stranded because it was deemed not feasible to cover the
SKB TX path as well, which means it can't be symmetrical to the RX hook.
So we ended up with the in-devmap hook instead. I'm not sure if that's
made easier by multi-buf XDP, so that may be worth revisiting.

For the TX metadata you don't really have to care about the skb path, I
suppose, so that may not matter too much either. However, at least for
the in-kernel xdp_frame the TX path is pushed from the stack anyway, so
I'm not sure if it's worth having a separate hook in the driver (with
all the added complexity and overhead that entails) just to set
metadata? That could just as well be done on push from higher up the
stack; per-driver kfuncs could still be useful for this, though.

And of course something would be needed so that that BPF programs can
process AF_XDP frames in the kernel before they hit the driver, but
again I'm not sure that needs to be a hook in the driver.

In any case, the above is just my immediate brain dump (I've been
mulling these things over for a while in relation to the queueing
stuff), and I'd certainly welcome more discussion on the subject! :)

-Toke
