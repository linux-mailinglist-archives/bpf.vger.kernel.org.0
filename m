Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A18F6B115A
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 19:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjCHSt7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 13:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjCHSto (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 13:49:44 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800ABCB676
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 10:49:40 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id da10so69714716edb.3
        for <bpf@vger.kernel.org>; Wed, 08 Mar 2023 10:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1678301380;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBpRHgewt5MiGF66U0DT4BDVvT3+VXwPETbuarc5Zwg=;
        b=Sjxfr/ej//kTgJGRMe/M3L/gLgNtBP4o/m5i6MqR7sxC1C3k+CpEpLKMBm6vz/BTxE
         Ma98xQ9Tkiuq5oXzb3TCN2xTyTe+WnKOtphoszKuh6qdD5+J5FJROE56DrRb59xM7t4A
         jdjArJr2ZhajSDNWba82B+X6o4tHgh/ndvsHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678301380;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZBpRHgewt5MiGF66U0DT4BDVvT3+VXwPETbuarc5Zwg=;
        b=v7T4+biBZfE0qGuSOFcbDZTeW0As/8A6HxJCsyeoWtHYMwOqlD+y9emuLGgr6AmhGz
         rm4u2X/rv5wNiXW5GW0+2QdDNQoTpjsjmM9T50iR1L4hg+w7wkKrR3lOs2gZewTx+Jgm
         IEB/tGm9JU4E463PytCCfimYQZ6mmrRyZZtOj0hoc+MhjFnCUYAUGMpqQAmnxu8Gufwe
         qXFDYtsTirlEmrqdJVGwWq+MWe7lJHzUvi+tyhW6EqAg9ymnQPWRq77Pbyfgcg0NJrwy
         pAQhsa+dN62RmkATG4BdyvsRdDLJe51g/4o6uOZ4JQeywPSYdLOx5AIziNX7N6zeeMQ4
         O7Dw==
X-Gm-Message-State: AO0yUKU4d3DA2TCADutcs5XJ1/oXTFLIIclsuNn6hCW6sF8xraPxUkax
        X/z4ZnYrZZwntFlHNKUvxpRBUjZ74JP/wniEEwvCAw==
X-Google-Smtp-Source: AK7set/qyO7vtNLdMRPF6aLaljYqHnMHV091vjuGk3W/YxMAjtRnUTvnqpz62SKCAK+Tbplr0yxdoqOETLcMoeEwBRU=
X-Received: by 2002:a50:d60d:0:b0:4bc:edde:14ff with SMTP id
 x13-20020a50d60d000000b004bcedde14ffmr10259842edi.0.1678301380094; Wed, 08
 Mar 2023 10:49:40 -0800 (PST)
MIME-Version: 1.0
References: <20230307172306.786657-1-kal.conley@dectris.com>
 <20230308105130.1113833-1-kal.conley@dectris.com> <4ddd3fe4-ed3c-495e-077c-1ac737488084@intel.com>
In-Reply-To: <4ddd3fe4-ed3c-495e-077c-1ac737488084@intel.com>
From:   Kal Cutter Conley <kal.conley@dectris.com>
Date:   Wed, 8 Mar 2023 19:49:29 +0100
Message-ID: <CAHApi-=C3ym23bBQ2h8BOyOfUtYXs9eZNG0Z8G2zfPeaEQWeRg@mail.gmail.com>
Subject: Re: [PATCH] xsk: Add missing overflow check in xdp_umem_reg
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> The code is fine to me.
> Please resubmit with the fixed subject and expanded commit message.
> I'd also prefer that you sent v3 as a separate mail, *not* as a reply to
> this thread.

Done. I used "bpf" in the subject as you suggested, however I am a bit
confused by this. Should changes under net/xdp generally use "bpf" in
the subject?

Thanks,
Kal
