Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D667961DD20
	for <lists+bpf@lfdr.de>; Sat,  5 Nov 2022 19:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiKESQR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 5 Nov 2022 14:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiKESQQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 5 Nov 2022 14:16:16 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D302DDEED
        for <bpf@vger.kernel.org>; Sat,  5 Nov 2022 11:16:15 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id 13so20841222ejn.3
        for <bpf@vger.kernel.org>; Sat, 05 Nov 2022 11:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OrAhEo8k47oe3cpcGfkIxGEi16aTTzYY4ICC0og8xDU=;
        b=CaQpM895LX/CyiZEz8fYQa8ZcFQOCcv6uOVroKDEpkN4B9HC8GiRuM7snX0l1l4JL5
         0iy4ibZ5MjaelPIHQ/XvBNcNn4ldQzTeYq9sDg/HjKNAWmOj0qi2PxjX0z3tyZI0edyj
         9REzReYLmsOyoxYMmqN7vUygUF/KFvbfPDJ7bsJSxVaFBdCraPElftR/MecJZR2pg8fu
         37HFBZCXTaVq3RCXAmukIUa2T2N5o/iti1A3UGvqlfHIKZcA1t//9zFvwgnhAkpk+s3y
         sBk/NERPLlfKVSjNALV58z7Aq56TxSi4h6Mw788rHvHnC0rZpFGxXWHTCLv8S2uarBBd
         rCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OrAhEo8k47oe3cpcGfkIxGEi16aTTzYY4ICC0og8xDU=;
        b=312LeCHB5+f7xf5XPxdJaZp82aBofn4TdGFbqO9td/e34yZ99NfZwUMDThCElaVwV2
         lH01LJfokbytEqm/o2Y2DoBEQI2iuIQX7XQnj0nq/m6QO7KQzNo7qrUD67OPEnK9hFOm
         QyiLPYS8y8HhYYqVzgcFdaen93W2MBTLdbcKQb/ZDfVJERv3HIcRiB1DCszKoy1TpN3z
         CkuHGwarP+bnevGeFGMRDNdUzssb2DcOz+SBA3JRtYoLVl5svvAfZ40BrWkVGkKvwGlM
         n/HIxlOpjiyTwwef7rBdQN3blUGCEr8mfUUtvSx1EqEgtutLJ6+vU/nuZ1pq8AmGJnHS
         1biA==
X-Gm-Message-State: ACrzQf21XZ7HCt76xDjF8+m5dMdJEIC0g8CQonOZa2N+DY3yeZdkTItz
        vtfBx68TEPaJdxqHzgJGlV+Zojvzkt6dBbFbYwf9x99s
X-Google-Smtp-Source: AMsMyM4yjKD4tL6e1ArJF2OZOienz3GlIkh/wC+k95q2kA2ZW1fxwWCLoj4+FoC6lTJMyhiKxT3LVeU1JOnkuXGij/8=
X-Received: by 2002:a17:906:fe45:b0:788:15a5:7495 with SMTP id
 wz5-20020a170906fe4500b0078815a57495mr40583964ejb.633.1667672174191; Sat, 05
 Nov 2022 11:16:14 -0700 (PDT)
MIME-Version: 1.0
References: <20221103191013.1236066-1-memxor@gmail.com> <20221103191013.1236066-23-memxor@gmail.com>
 <d3765c8e-3b1b-3ea4-8612-34b8580bc892@meta.com> <20221104074248.olfotqiujxz75hzd@apollo>
 <65edb881-f877-2d90-2d5c-46fad3a41251@meta.com>
In-Reply-To: <65edb881-f877-2d90-2d5c-46fad3a41251@meta.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 5 Nov 2022 11:16:02 -0700
Message-ID: <CAADnVQJbMzkYAPC8vzRHjO1jMjx=MXPMTuwfV8tYdL0vfYSSoA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 22/24] bpf: Introduce single ownership BPF
 linked list API
To:     Dave Marchevsky <davemarchevsky@meta.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Delyan Kratunov <delyank@meta.com>
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

On Fri, Nov 4, 2022 at 7:15 PM Dave Marchevsky <davemarchevsky@meta.com> wrote:
>
> > I was contemplating whether to simply drop this whole set_release_on_unlock
> > logic entirely. Not sure it's worth the added complexity, atleast for now. Once
> > you push you simply lose ownership of the object and any registers are
> > immediately killed.
>
> I think that being able to read / modify the datastructure node after it's been
> added is pretty critical, at least from a UX perspective.
>
> Totally fine with it being dropped from the series and experimented with
> later, though.

Kumar,
please split release_on_unlock logic into separate patch.
afaics it doesn't have to be introduced together with these kfuncs.
