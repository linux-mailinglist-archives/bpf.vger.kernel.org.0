Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8446078A6
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 15:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiJUNjw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 09:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiJUNjv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 09:39:51 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4D93742A;
        Fri, 21 Oct 2022 06:39:47 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id bk15so4822623wrb.13;
        Fri, 21 Oct 2022 06:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:references:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wk3DFh2aXt0pn/EmnsKS4Q5onFCF2pDUj7gYrd6sEz8=;
        b=eZ3WncTtALXBUfa3mu+i/dmTh0pMCd9GmnAtULYRHlkBXppmIclk8MO242aYbIFUNn
         V7BZiUZFmxuzRsnqsczrNeTj1DTgdL0dvnKaKcXGTJDNPdr399D2K/YpU9I92ZoIBUHV
         ixmqoaZsLCl0+jITVCsdjOXX+VR20bQNzh/gae3Wp3N5bPB6u0lbvzW6C7YNZu4zC88x
         xqZSXfU7X2o1sHf+mJtmTcxh/hKjtnbldRQY9Jx9kwBGEKio1uyuElEBF2ld2N+f674o
         +v7UEhtk9uZeVuUclK8UCqC/bFrBBWHFhfu+5pcO3HoJ0+jjk3rqmsV796bcc6EbtS1e
         9lPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:references:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wk3DFh2aXt0pn/EmnsKS4Q5onFCF2pDUj7gYrd6sEz8=;
        b=hnhqLmGTqv3SX8pTv62SJToX39bSEeeKlAUVw4USrc2/HXKilRVkTE2SgoQ7fSNM0W
         2csDi2dSyaVuaZn+51ZkIxLXtgYF7F8o+DL/rbehR/UI5s15XvzWCelG3bA6OYH76rli
         ef7BhLsIMmz/qD5F9tq2pMBnyOngPtbvVQEexTasjuoHxiXytlvQnBlJDdv1ZP6QRjrw
         4b77G9PXMSyjJquZ0XupKV1bhGHNWwH31Y+LA76lKEdB+gpnX65umamV+WTYqXDHSzGO
         wh5M7DoOg+wwTD9B99R8xKuD+iGuAAfz+Xt5PR41ZXVsvRkTeTrirCpiRFEE8WdPYjIj
         MnLw==
X-Gm-Message-State: ACrzQf1+fdkHfSowCaJwFooSATv9EpQDcg7J+ogOMkXaR55AxvQ2eyhV
        g5+aOnuRKoThq0ZSXIv6EfXaWA9X51Q76g==
X-Google-Smtp-Source: AMsMyM6YR6yXeWJkNp489hmHbntM/G4gxSfif/6uF2QsH9qoG0KrKZ2A4NHQ39dul1Pi0C/ekyH2TQ==
X-Received: by 2002:a05:6000:1cf:b0:22e:3ef1:a268 with SMTP id t15-20020a05600001cf00b0022e3ef1a268mr12329492wrx.43.1666359584935;
        Fri, 21 Oct 2022 06:39:44 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:cc4f:5367:93c1:b0d5])
        by smtp.gmail.com with ESMTPSA id f18-20020a05600c155200b003b3365b38f9sm3104820wmg.10.2022.10.21.06.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 06:39:44 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     mtahhan@redhat.com
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/1] doc: DEVMAPs and XDP_REDIRECT
Date:   Fri, 21 Oct 2022 14:39:33 +0100
Message-ID: <m24jvxuwh6.fsf@gmail.com>
References: <20221017094753.1564273-1-mtahhan@redhat.com>
        <20221017094753.1564273-2-mtahhan@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (darwin)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

mtahhan@redhat.com writes:

> diff --git a/Documentation/bpf/redirect.rst b/Documentation/bpf/redirect.rst
> new file mode 100644
> index 000000000000..5a0377a67ff0
> --- /dev/null
> +++ b/Documentation/bpf/redirect.rst
> @@ -0,0 +1,46 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +.. Copyright (C) 2022 Red Hat, Inc.
> +
> +============
> +XDP_REDIRECT
> +============
> +
> +XDP_REDIRECT works by a three-step process, implemented as follows:
> +
> +1. The ``bpf_redirect()`` and ``bpf_redirect_map()`` helpers will lookup the
> +   target of the redirect and store it (along with some other metadata) in a
> +   per-CPU ``struct bpf_redirect_info``. This is where the maps above come into
> +   play.

Can you remove the last sentence above. Instead, maybe mention that the lookup
happens in the provided map which has to be one of the supported map types.

> +2. When the program returns the ``XDP_REDIRECT`` return code, the driver will
> +   call ``xdp_do_redirect()`` which will use the information in ``struct
> +   bpf_redirect_info`` to actually enqueue the frame into a map type-specific
> +   bulk queue structure.
> +
> +3. Before exiting its NAPI poll loop, the driver will call ``xdp_do_flush()``,
> +   which will flush all the different bulk queues, thus completing the
> +   redirect.
> +
> +Pointers to the map entries will be kept around for this whole sequence of
> +steps, protected by RCU. However, there is no top-level ``rcu_read_lock()`` in
> +the core code; instead, the RCU protection relies on everything happening
> +inside a single NAPI poll sequence.
> +
> +.. note::
> +    Not all drivers support transmitting frames after a redirect, and for
> +    those that do, not all of them support non-linear frames. Non-linear xdp
> +    bufs/frames are bufs/frames that contain more than one fragment.
> +
> +XDP_REDIRECT works with the following map types:
> +
> +- BPF_MAP_TYPE_DEVMAP
> +- BPF_MAP_TYPE_DEVMAP_HASH
> +- BPF_MAP_TYPE_CPUMAP
> +- BPF_MAP_TYPE_XSKMAP
> +
> +For more information on these maps, please see the specific map documentation.
> +
> +References
> +===========
> +
> +- https://elixir.bootlin.com/linux/latest/source/net/core/filter.c#L4106
