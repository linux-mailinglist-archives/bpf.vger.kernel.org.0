Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B2D674875
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 02:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjATBBf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 20:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjATBB3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 20:01:29 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4947A5018
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 17:01:26 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id ss4so10185821ejb.11
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 17:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5Q72jqD8VmQV4cA82WZag5tNpkilPchJxhcGY7aO1BY=;
        b=J/XhVUE82rHsYQ3MOnA5vKkZHl9+qmxuscJbpC8Y4EVjOygGME3Jgdatpy7ZXvKi2c
         +QH6+jfN+/x83RkUO2ZZAhD4WongafoRdIZ8RIb2wCqbCBeNrOUh8rSyr0R2DHKLcVoP
         kDDDLmD61zN8j8m00NvmWbOv34ohzT91YuUKO6lmqae7d2xRSrIKFOxEBzMHJw7RFB08
         C0kPs/Alx58QSW4i3qosVCxJfR9KeCtgdiffnwvgRwofgmdQ2ODJ4hoFWvGmtCzAQ1Fe
         hVhS0m0fExFdzbAzh/Tvp5ZhXUr10qQkOoF4FwPOSfXIS82IPBeXoC/4wY0kyLTnD6PP
         Axww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Q72jqD8VmQV4cA82WZag5tNpkilPchJxhcGY7aO1BY=;
        b=zLx/hvmXQk7vQPdZH9/g7EGgog9BozJ2SGYtg6ipZmjddUARzdye8tKj3fhm0UM3g0
         CyfF9KLC4NfWxmpS4yhkoMk2wpqGvME9Cd5h7v/8SDbBaYgMwrP9Vd7SCVBylbTEfnd8
         rmni9V3J4dzAogHb884kfBWZHvFS0djLK0v17zty86Mh9vQD46FBBrDO35JRqkSz/9LK
         S4tKyZiosHjsilIyykoH3Wq/S3tFp0W8zgQJCWQDO4EdrPSx5dbctdoN6oaRBbDPOGCT
         fhD6rhJs/Bg/zETkLcpSr+h7Kkg/mVXAj+JiXLqQ0CwtLVoARJ+xvxyGVga5dCbGseFv
         qBbA==
X-Gm-Message-State: AFqh2kpc4BrZilED3SCJ99QeDqkL8gezW2EqIPW1kZ2964GRv0uhxlBb
        ApiDjpYPtHQZb4LafYlemVOZN0YD1Rn3CX2QKb8=
X-Google-Smtp-Source: AMrXdXu94IlHafn1j/mMJg7EvNZAjYkg3z/nPrxY1pw8cgmLksRR/nKaB1PlA8DttPJkw2PCxqIgUgaKCUM2EgVyoVs=
X-Received: by 2002:a17:906:9417:b0:85f:f115:65d2 with SMTP id
 q23-20020a170906941700b0085ff11565d2mr952344ejx.555.1674176485216; Thu, 19
 Jan 2023 17:01:25 -0800 (PST)
MIME-Version: 1.0
References: <20230118152329.877-1-dthaler1968@googlemail.com> <20230119220445.875-1-dthaler1968@googlemail.com>
In-Reply-To: <20230119220445.875-1-dthaler1968@googlemail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 19 Jan 2023 17:01:13 -0800
Message-ID: <CAADnVQLZd1u_wJUC2ViRcEPveRcGaAnOsjbPiZ8bPZcwV1p=gw@mail.gmail.com>
Subject: Re: [PATCH] bpf, docs: Fix modulo zero, division by zero, overflow,
 and underflow
To:     dthaler1968@googlemail.com
Cc:     bpf <bpf@vger.kernel.org>, Dave Thaler <dthaler@microsoft.com>
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

On Thu, Jan 19, 2023 at 2:25 PM <dthaler1968@googlemail.com> wrote:
> -BPF_MOD   0x90   dst %= src
> +BPF_MOD   0x90   dst = (src != 0) ? (dst % src) : dst

...

> +If execution would result in modulo by zero,
> +the destination register is instead set to the source register
> +as ``BPF_MOV`` would do, meaning that for ``BPF_ALU64`` the value
> +is unchanged whereas for ``BPF_ALU`` the value is truncated to 32 bits.

These two don't match.
Probably should say that for ALU64 dst doesn't change
and for alu32 it's upper 32-bits are zeroed.
