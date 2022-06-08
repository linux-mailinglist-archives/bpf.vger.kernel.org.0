Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE23542BB0
	for <lists+bpf@lfdr.de>; Wed,  8 Jun 2022 11:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbiFHJjR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Jun 2022 05:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbiFHJif (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Jun 2022 05:38:35 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3BA194246
        for <bpf@vger.kernel.org>; Wed,  8 Jun 2022 02:06:53 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h19so26214171edj.0
        for <bpf@vger.kernel.org>; Wed, 08 Jun 2022 02:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=iJnORuRLN0xRXpCZ8w8em/W2iMONPbwIC+CvQgO2A0I=;
        b=UToRZSO/tN0dJ8qwxtwgWX/l1tc+J1n3Xoq+P2JT8x1AUncVojcZA4k7ueS7gNi/DS
         k9msMQ4/6iNezPx1qURXhbqTijNdjxpARyUUiek4laMy12eYo8p/tIeu51MfNmLD3XCN
         TXNg7zbvXknd04bymXKcuzHKntpDmAn5v7GExEUPeqQ1T5sgRlo8FzcFU5kVIpL5OUD7
         6aCR2Ky6m7g39zO7GJ6iUt3+w/mlBtbE2Iem2MRE3YobdwnuG0hBxJaUGTdaa0lblp8r
         7n8QzJk3rR4mo5rBjJVJipYVAIiraS19FSDsSYuLh5GQvNKyy1OZYoDvnEzUmN+F2gXi
         Lsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=iJnORuRLN0xRXpCZ8w8em/W2iMONPbwIC+CvQgO2A0I=;
        b=2mHN6OZbogf+lgwou4QjpmpiWhCzvdIb0oRzkkY1M7GR0Uw0BylzYeJ56+rp4F/gby
         JqniuIwG8Up6GfQjtHOoPwvFXbXJ1q4Jeizsa+3Kxvs/v37mPtD2HMIZFJB+PGk8bSQP
         3W0i7LzIQyB3pipKSxy3RcD/pcPX5nUZ5nilgiz5oRfmkQPY13h9ooJdjpCh2/LXvx1k
         tUW5DmvBPECt06c6GTo2r/WVM0w5EtLcxyG4GlEjtsBOzq6VKkqRhbfAo8fawU27Evf7
         wRUPOQCTIH0qejcKxti2Q1jgzmQfLwyv+dC7M1qNMfnPjDfQ7KfFDWqTN0UsZL5evGQp
         QHRA==
X-Gm-Message-State: AOAM533LdjcTldija4PNbHnJd5VUaiJd+JvCk2H2ABCsB8LlO8BK7PzZ
        rA28I8We+BBVcIUcZZub/Yc=
X-Google-Smtp-Source: ABdhPJw6sdQ0sdTjHQD6DwITfkFCrw0Fabm41+bIwtRR1j+7tP1GHghqlTIY+F1kaiwGj+3sGhE+Sg==
X-Received: by 2002:aa7:d303:0:b0:42d:d192:4c41 with SMTP id p3-20020aa7d303000000b0042dd1924c41mr38601133edq.178.1654679212137;
        Wed, 08 Jun 2022 02:06:52 -0700 (PDT)
Received: from pluto (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id lj2-20020a170906f9c200b0070d9aad64a1sm6929059ejb.208.2022.06.08.02.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 02:06:51 -0700 (PDT)
Message-ID: <70fe617a25138f5f343298e08c8b89420913e82d.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 3/5] bpf: Inline calls to bpf_loop when
 callback is known
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        song@kernel.org
Date:   Wed, 08 Jun 2022 12:06:49 +0300
In-Reply-To: <CAJnrk1bSXoObt+b2YH+x5oyMSJYPE89pBUW7nJm2Upnumvs8ow@mail.gmail.com>
References: <20220603141047.2163170-1-eddyz87@gmail.com>
         <20220603141047.2163170-4-eddyz87@gmail.com>
         <CAJnrk1YZB_9WNtUv1yU4VacDuMUSA_iB6=Nc14fR7sw9RadZ2Q@mail.gmail.com>
         <b6aa2c2c048cab8687bc22eb5ee14820cf6311f9.camel@gmail.com>
         <CAJnrk1bSXoObt+b2YH+x5oyMSJYPE89pBUW7nJm2Upnumvs8ow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Joanne,

> Looking at arch/arm64/net/bpf_jit_comp.c, I see this diagram
> 
>         /*
>          * BPF prog stack layout
>          *
>          *                         high
>          * original A64_SP =>   0:+-----+ BPF prologue
>          *                        |FP/LR|
>          * current A64_FP =>  -16:+-----+
>          *                        | ... | callee saved registers
>          * BPF fp register => -64:+-----+ <= (BPF_FP)
>          *                        |     |
>          *                        | ... | BPF prog stack
>          *                        |     |
>          *                        +-----+ <= (BPF_FP - prog->aux->stack_depth)
>          *                        |RSVD | padding
>          * current A64_SP =>      +-----+ <= (BPF_FP - ctx->stack_size)
>          *                        |     |
>          *                        | ... | Function call stack
>          *                        |     |
>          *                        +-----+
>          *                          low
>          *
>          */
> It looks like prog->aux->stack_depth is used for the "BPF prog stack",
> which is the stack for the main bpf program (subprog 0)

Thanks for looking into this. Also note the verifier.c:jit_subprogs
function which essentially "promotes" every sub-program to sub-program #0
before calling bpf_jit_comp.c:bpf_int_jit_compile for that sub-program.

> I'm not sure either whether MAX_BPF_STACK is a hard limit or a soft
> limit. I'm curious to know as well.

Alexei had commented in a sibling thread that MAX_BPF_STACK should be
considered a soft limit.

Thanks,
Eduard

