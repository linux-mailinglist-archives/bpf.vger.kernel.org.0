Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B52A587570
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 04:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbiHBCMQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 22:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiHBCMO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 22:12:14 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E107F3340E
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 19:12:12 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ss3so23484057ejc.11
        for <bpf@vger.kernel.org>; Mon, 01 Aug 2022 19:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZIRa7wZxKlD/pk7QEcJbtfWCBeZ3ZrBDgV7gVfyyan8=;
        b=CAVHluDJoVTdE0sg+lS469jF5F8dQiKGErpo0h+gcgg4Sy0LsYOUtX8xrJ0L3+Q/HB
         7Ltm2WYTMtU87GfLAV2X8tTAxhmkHI3GHf6CEFXs8sbkb6KBTCMtwDyQms3q2rFovbt6
         5rwfFOfRewEwA92zQksRBE7iHpTd6lOlclem9QJsiuNnii5IFAeXF9Jo2gXSFGVVLWXy
         Da9bvpE9DJbOa2S5OnP7rYuN4zKhNBvsXi7FYpVvgn9VU+hOFbEUpNiqz8mYhn9fslPq
         TzhK/VP86HyFm4kD0i1kCK+CVtZpk/kSi85pigG5un0SIVltJNnZUAupQJYYU3J0Zlav
         QxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZIRa7wZxKlD/pk7QEcJbtfWCBeZ3ZrBDgV7gVfyyan8=;
        b=mpcpezT09zOuWAyLRhlxIkYM6jzuA96g+B4UyWapWaWW9Wi0Oel1Rzc/mWUKkMXX7q
         cbRbKeFCCKMsS5DvycZsa/RWk/wCWKjHZ+/SEY0msKobdwj+Dd9nt9DAgC8sLVZgN8yk
         sB/NKinBWJ7RC4MNE1j4LJeO49qGCdnfuoy56ay/REUTLLFtlFHXA+kWwzY3UVtXCebO
         Y+YCAYMMCF6wPEXcE06T7No4h6bsTyFE9cmuOV/SQkDL57TGWkRKDxzbCLFPJNwVtfED
         hgPmqfLOIzFfTNQmq2ojeErfZZxiX3pwZe8iHTW/+M003O7WK8dxYZIlOReZk1eSn0wY
         5uqg==
X-Gm-Message-State: AJIora/qIg/yx4dLp4RiNsxw9F1vZJMSfk6KPJJJmGY07DdU8GlfpVAo
        SVgxbakNHyXn4EL2bO8XiIK7DfENnkHQ2GA3hJA=
X-Google-Smtp-Source: AGRyM1vnPErO7zjgx4P8hIXA/rxBRdeC6XxmhF9uy3GfDVcI7ETNj1UnPikTlLBJTG4J8+SL2Bn91Oz4L/6yqbcncgc=
X-Received: by 2002:a17:907:608f:b0:72b:7db9:4dc6 with SMTP id
 ht15-20020a170907608f00b0072b7db94dc6mr14062358ejc.463.1659406331375; Mon, 01
 Aug 2022 19:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220726184706.954822-1-joannelkoong@gmail.com>
 <20220726184706.954822-2-joannelkoong@gmail.com> <20220801163349.4a28d154@kernel.org>
In-Reply-To: <20220801163349.4a28d154@kernel.org>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Mon, 1 Aug 2022 19:12:00 -0700
Message-ID: <CAJnrk1bow8je9VkTAQHiOOPQLWGDg1uDqDRN+tr43bMYtTSGjw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Add skb dynptrs
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 1, 2022 at 4:33 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> (consider cross-posting network-related stuff to netdev@)

Great, I will start cc-ing netdev@

>
> On Tue, 26 Jul 2022 11:47:04 -0700 Joanne Koong wrote:
> > Add skb dynptrs, which are dynptrs whose underlying pointer points
> > to a skb. The dynptr acts on skb data. skb dynptrs have two main
> > benefits. One is that they allow operations on sizes that are not
> > statically known at compile-time (eg variable-sized accesses).
> > Another is that parsing the packet data through dynptrs (instead of
> > through direct access of skb->data and skb->data_end) can be more
> > ergonomic and less brittle (eg does not need manual if checking for
> > being within bounds of data_end).
>
> Is there really a need for dynptr_from_{skb,xdp} to be different
> function IDs? I was hoping this work would improve portability of
> networking BPF programs across the hooks.

Awesome, I like this idea of having just one generic API named
something like bpf_dynptr_from_packet. I'll add this for v2!

>
> > For bpf prog types that don't support writes on skb data, the dynptr is
> > read-only (writes and data slices are not permitted). For reads on the
> > dynptr, this includes reading into data in the non-linear paged buffers
> > but for writes and data slices, if the data is in a paged buffer, the
> > user must first call bpf_skb_pull_data to pull the data into the linear
> > portion.
> >
> > Additionally, any helper calls that change the underlying packet buffer
> > (eg bpf_skb_pull_data) invalidates any data slices of the associated
> > dynptr.
>
> Grepping the verifier did not help me find that, would you mind
> pointing me to the code?

The base reg type of a skb data slice will be PTR_TO_PACKET - this
gets set in this patch in check_helper_call() in verifier.c:

+ if (func_id == BPF_FUNC_dynptr_data &&
+    meta.type == BPF_DYNPTR_TYPE_SKB)
+ regs[BPF_REG_0].type = PTR_TO_PACKET | ret_flag;

Anytime there is a helper call that changes the underlying packet
buffer [0], the verifier iterates through the registers and marks all
PTR_TO_PACKET reg types as unknown, which invalidates them. The dynptr
data slice will be invalidated since its base reg type is
PTR_TO_PACKET

The stack trace is:
   check_helper_call() -> clear_all_pkt_pointers() ->
__clear_all_pkt_pointers() -> mark_reg_unknown()


I will add this explanation to the commit message for v2 since it is non-obvious


[0] https://elixir.bootlin.com/linux/latest/source/kernel/bpf/verifier.c#L7143

[1] https://elixir.bootlin.com/linux/latest/source/kernel/bpf/verifier.c#L6489


>
> > Right now, skb dynptrs can only be constructed from skbs that are
> > the bpf program context - as such, there does not need to be any
> > reference tracking or release on skb dynptrs.
