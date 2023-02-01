Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295846864E0
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 12:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjBALAc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 06:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjBALAb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 06:00:31 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60491BC
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 03:00:29 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id hn2-20020a05600ca38200b003dc5cb96d46so1046085wmb.4
        for <bpf@vger.kernel.org>; Wed, 01 Feb 2023 03:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LK6L7bgthJcohzAKJ0K8jtPaFBCQcT2D843+02dNJI=;
        b=ZHOedjW7nCy89zBnsnXTiwkhrkX3unYSHFRiM1rnr1n+xenI7F9QVp0zP17QmVKb4I
         B+LrKj/esi9VT5rkmrcAL0zAizCyqgUDnWwQyKF1xgpVR0T3jqwaR1McdzHGyWQqLZwH
         cQRE81RCLy2ufgq89k0oeASEimKebW/hMzzRHKRwg/3C6/hgBsyFWYfhYTKO8CD5MMmp
         T8zXdW1axLS68iuzwQCNo+5iwKVxPbpadZkfNlJcBlA/Z6Q7SHdbdXCgJKnLf1t7lnOd
         /CTYHDHtNaQ0NLlts89LmK40sOMVEZZcmYF5K7jAwmBE4r/IIDjHA6+xyCyCy66MtEA4
         aOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3LK6L7bgthJcohzAKJ0K8jtPaFBCQcT2D843+02dNJI=;
        b=2mQe9wgB+O2UtgJydl6aslW/GldGSFCuhWLnrrghcJm7L3AexR7/Kv7X3Y9vhuQq5W
         M8ypWOobn1bqp2bdNNKz9RtQTtTBzrnD31kcrs/ZO0E7eLsFGql1OoGi3SFgeKk3Z35v
         4+NnoOYeGa6S6t6lNv8RXv9ZNdmIomFG0IWnylAdCC4MLbD/DyZTNflOxIVMwnyb5UDt
         GxFqfuYKcL+n0B9qoMbbtstcGKO57HB3GJph+ZXQ62tWLEAYIT3f9YEX9QQoGoNSmOn8
         lMnohbSwKjFUhHeW/f7q7vP1uJnVq3NNZqmQb8klyh+a2WwsuNWL8mL/FcIXnJaDV6ka
         f6jw==
X-Gm-Message-State: AO0yUKX+xgSPwE35VT+HkUS9qrsiodVt4Dy8tr+8Pn0ZRKb+9DR6DOn8
        aJhM/ewR/CykeeqbxnSAb44=
X-Google-Smtp-Source: AK7set/zsCHdHg3xrmjQLVqrUHvMMG0kFD8kN7yfHQrtPua39MQFValMdAmP3NSunEg06nn/55DbGw==
X-Received: by 2002:a05:600c:54c5:b0:3dc:9ecc:22a with SMTP id iw5-20020a05600c54c500b003dc9ecc022amr1731560wmb.8.1675249228357;
        Wed, 01 Feb 2023 03:00:28 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id r17-20020a05600c459100b003dee8c5d814sm1043203wmo.24.2023.02.01.03.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 03:00:27 -0800 (PST)
Subject: Re: [PATCH bpf-next v3 1/1] docs/bpf: Add description of register
 liveness tracking algorithm
To:     Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com
References: <20230131181118.733845-1-eddyz87@gmail.com>
 <20230131181118.733845-2-eddyz87@gmail.com>
From:   Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <99a2eaa9-aebb-f0c8-1d13-62e1533631e7@gmail.com>
Date:   Wed, 1 Feb 2023 11:00:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20230131181118.733845-2-eddyz87@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 31/01/2023 18:11, Eduard Zingerman wrote:
> This is a followup for [1], adds an overview for the register liveness
> tracking, covers the following points:
> - why register liveness tracking is useful;
> - how register parentage chains are constructed;
> - how liveness marks are applied using the parentage chains.
> 
> [1] https://lore.kernel.org/bpf/CAADnVQKs2i1iuZ5SUGuJtxWVfGYR9kDgYKhq3rNV+kBLQCu7rA@mail.gmail.com/
> 
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  Documentation/bpf/verifier.rst | 280 +++++++++++++++++++++++++++++++++
>  1 file changed, 280 insertions(+)
...
> +  Current    +-------------------------------+
> +  state      | r0 | r1-r5 | r6-r9 | fp-8 ... |
> +             +-------------------------------+
> +                             \
> +                               r6 read mark is propagated via
> +                               these links all the way up to
> +                               checkpoint #1.
Perhaps explicitly mention here that the reason it doesn't
 propagate to checkpoint #0 (despite the arrow) is that there's
 a write mark on c1[r6].

Also worth mentioning somewhere that write marks are really a
 property of the arrow, not the state — a write mark in c#1 tells
 us that the straight-line code from c#0 to c#1 contains a write
 (thus 'breaking' that arrow for read mark propagation); it lives
 in c#1's data structures because it's c#1 that needs to 'know'
 about it, whereas c#0 (and its parents) need to 'know' about any
 *reads* in the straight-line code from c#0 to c#1 (but these are
 of no interest to c#1).
I sometimes summarise this with the phrase "read up, write down",
 though idk how useful that is to anyone outside of my head ;)

> +Liveness marks tracking
> +=======================
> +
> +For each processed instruction, the verifier propagates information about reads
> +up the parentage chain and saves information about writes in the current state.
> +The information about reads is propagated by function ``mark_reg_read()`` which
> +could be summarized as follows::
> +
> +  mark_reg_read(struct bpf_reg_state *state):
> +      parent = state->parent
> +      while parent:
> +          if parent->live & REG_LIVE_WRITTEN:
> +              break
This isn't correct; we look at `state->live` here, because if in
 the straight-line code since the last checkpoint (parent)
 there's a write to this register, then reads should not
 propagate to `parent`.
Then there's the complication of the `writes` variable in
 mark_reg_read(); that's explained by the comment on
 propagate_liveness(), which AFAICT you don't cover in your
 doc section about that.  (And note that `writes` is only ever
 false for the first iteration through the mark_reg_read() loop).

> +          if parent->live & REG_LIVE_READ64:
> +              break
> +          parent->live |= REG_LIVE_READ64
> +          state = parent
> +          parent = state->parent
> +
> +Note: details about REG_LIVE_READ32 are omitted.
> +
> +Also note: the read marks are applied to the **parent** state while write marks
> +are applied to the **current** state.
May be worth stating that the principle of the algorithm is that
 read marks propagate back along the chain until they hit a write
 mark, which 'screens off' earlier states from the read.
Your doc implies this but afaict never states it explicitly, and
 I think it makes the algo easier to understand for someone who
 doesn't already know what it's all about.

Apart from that, this is great.  I particularly like your diagram
 of the parentage chains.

-ed
