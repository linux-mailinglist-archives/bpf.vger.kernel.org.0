Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E425B1295
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 04:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiIHClI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 22:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiIHClH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 22:41:07 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314F8B56EA
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 19:41:07 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id k2so16864251vsk.8
        for <bpf@vger.kernel.org>; Wed, 07 Sep 2022 19:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date;
        bh=CGV8Zo5Ie3Dll/fjhNV+4sDflQjW6O8bXhbwbuPb+Eg=;
        b=RG1uWvXc/RoBP1W0rOMNX4MCxTLCCdN1S2YuRH8GGmBiE6kr6jITBwhaDonbodrqoG
         rKbPN//0+pYQK1BKnwMhxQR73IlpO+o9lCSx19FLR676+RyzzhVcCLEOferneOZtWljq
         moMyK4sZgAE1WpA9/y1piKcGBudCWjuoqPLPo108WdrvO7VEG14BVMTU/M68gTPEcIvA
         /e5rDGMZCVcwioxWci8RgR7hgsgtPoy88ALHcTUdN53K+0Tpuv3xl+WJN0BQHKX2PKot
         HgTNlNFOvhYvhNxrDWiCBsbCjtvFlsjSJ5Ip47HDgclYrBf/Wkux4Smr8CxxGLB/lX6P
         t6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=CGV8Zo5Ie3Dll/fjhNV+4sDflQjW6O8bXhbwbuPb+Eg=;
        b=jIAJB3BtXp07qHKAFpkPcPri7uqHveJCRzSOlUiWCVK+qx+TJJ5X8DudBFepjuV1X3
         +kRJiBtiUw15Z8C3o1T8/Mg2i2EAE+jVYN/FoeNP9HjItzCfvYpbBE7dTael7wGZQd+O
         aLdMOrkx0FLcUjePcutx2Afu1xRGYv65uPskJKFdyE6UWqiEkso6izxZvs5uWgnHHY/c
         J8LjLwCI/xcT/mrgOMmWkD66FLXIiCAXgIx2fSFqeHoe+eI6GJolwj6snUZrcZuYTJ1c
         gWqRxT5UI/KDpSe3sAgorCiQ5y9waTOiInwLRZl+pbLjIx2obvtpqas33HdwGQjCXfJf
         wZmw==
X-Gm-Message-State: ACgBeo1DR8ewIRKIdd/2LbgnEfE/1TXsb+QcMM2EoEB1Mi/oQ3WHZc5J
        u1RPzDVecvQEUICcRqn5nPFnkKjrBAP2rmn+FnzL2XTWWAo=
X-Google-Smtp-Source: AA6agR6PDm7OPU3lMbWc6uDLTFTad7RPT9xLWPbvKvw+pdCSoLhzmlbqHsgsfwLaQV+TKv+tJRrgcLpSbD/MjQIDVR8=
X-Received: by 2002:a05:6102:4413:b0:394:7850:c78f with SMTP id
 df19-20020a056102441300b003947850c78fmr2150875vsb.65.1662604866183; Wed, 07
 Sep 2022 19:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAK3+h2zZQ4zEB55Bn565Xf0okf+Jotmo6qHYmzpoJPBcFWPP0A@mail.gmail.com>
In-Reply-To: <CAK3+h2zZQ4zEB55Bn565Xf0okf+Jotmo6qHYmzpoJPBcFWPP0A@mail.gmail.com>
From:   Vincent Li <vincent.mc.li@gmail.com>
Date:   Wed, 7 Sep 2022 19:40:55 -0700
Message-ID: <CAK3+h2y4isKQQWFY9dnEq86a4BRG1zr5nEveyKqFyVvYaRrPpw@mail.gmail.com>
Subject: Re: differentiate the verifier invalid mem access message error?
To:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 7, 2022 at 7:35 PM Vincent Li <vincent.mc.li@gmail.com> wrote:
>
> Hi,
>
> I see some verifier log examples with error like:
>
> R4 invalid mem access 'inv'
>
> It looks like invalid mem access errors occur in two places below,
> does it make sense to make the error message slightly different so for
> new eBPF programmers like me to tell the first invalid mem access is
> maybe the memory is NULL? and the second invalid mem access is because
> the register type does not match any valid memory pointer? or this
> won't help identifying problems and don't bother ?
>
>  4772         } else if (base_type(reg->type) == PTR_TO_MEM) {
>
>  4773                 bool rdonly_mem = type_is_rdonly_mem(reg->type);
>
>  4774
>
>  4775                 if (type_may_be_null(reg->type)) {
>
>  4776                         verbose(env, "R%d invalid mem access
> '%s'\n", regno,
>
>  4777                                 reg_type_str(env, reg->type));
>
>  4778                         return -EACCES;
>
>  4779                 }
>
> and
>
>  4924         } else {
>
>  4925                 verbose(env, "R%d invalid mem access '%s'\n", regno,
>
>  4926                         reg_type_str(env, reg->type));
>
>  4927                 return -EACCES;
>
>  4928         }

sorry I should read the code more carefully, I guess the "inv" already
says it is invalid memory access, not NULL, right?
