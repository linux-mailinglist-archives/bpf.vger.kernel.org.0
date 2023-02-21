Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DE569E05B
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 13:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbjBUM2c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 07:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbjBUM2b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 07:28:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF95E2684
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 04:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676982465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aH9Zs3Ynup8QEj3M7umA2rpBmSqMBswm4cOHxTio+fY=;
        b=Nc4LjX6jYgmLB4nABrBOgIYIMsKfDeba1nAqT64wn//8hBKnkLmMjgnO+pnCEZ1pQvGjtM
        L1MqF0kxxSzx/jN87eKQwQmSlWuGaRXpfdDh6BY5ZX4eiNcZtiMGnsR0Y/pOkn+VnAJ//F
        VrPSjOfYnvd7AcAlwhNZlyMkrL/Y5S4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-440-UQPLlyLXMk6ZyEpyqZ9EBQ-1; Tue, 21 Feb 2023 07:27:42 -0500
X-MC-Unique: UQPLlyLXMk6ZyEpyqZ9EBQ-1
Received: by mail-wm1-f69.google.com with SMTP id e22-20020a05600c219600b003e000facbb1so1897087wme.9
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 04:27:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676982461;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aH9Zs3Ynup8QEj3M7umA2rpBmSqMBswm4cOHxTio+fY=;
        b=2fEB57CNhnI7f868xGlfhbNd3Od+aQJFg4Sfg9ytg/2lA9BsBa2rUMN4bbtiZGrle3
         KtiKx3p43PBVbVCvU86mOzI0SXW7noHcfqNhbiR48a4AeQQGNmwl+kqCWRh/oBgwuDTk
         +MhlX39qskoB/KeBWqN8dvlMmyt1w71zNXdkuNz995H/2296oU6xRlVjqymQBWoVz2T+
         8bTszG0geQ953NOf97CFRsjiMcJ6q23i1Wgb8XE9pyaxJ9xrcOO89yhDhJCFUB/pRTqS
         /9aPoGitx/okS0VZnfjoFQdix75vCGiYQNKD7lekuWkEBLnTZy/KqDq/U4PuYY4Yt3ze
         IHFw==
X-Gm-Message-State: AO0yUKXYeoEJ/StqPfVSdGzUraC2TscQR9t7TWohHXK+u89wzMoqhIDW
        BKcTJ2HzuIWUozzmsjpvEmbMGvr8cxV6SNYUl3sEViqHt/L0K8GraiXeEg6or6+aoSdCUMKjklN
        CYUX6KuXNyYIZ
X-Received: by 2002:a5d:5956:0:b0:2c5:595a:1c92 with SMTP id e22-20020a5d5956000000b002c5595a1c92mr2875384wri.6.1676982461556;
        Tue, 21 Feb 2023 04:27:41 -0800 (PST)
X-Google-Smtp-Source: AK7set9a3kH8ia6rTQ7nRpyFWjsQn3JJlzvkPw+s98kN7nZ74eIb64/SpsJ2QhQdjDYzZAo5zrZSiA==
X-Received: by 2002:a5d:5956:0:b0:2c5:595a:1c92 with SMTP id e22-20020a5d5956000000b002c5595a1c92mr2875370wri.6.1676982461215;
        Tue, 21 Feb 2023 04:27:41 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-121-8.dyn.eolo.it. [146.241.121.8])
        by smtp.gmail.com with ESMTPSA id e16-20020adfe390000000b002c54c8e70b1sm4705292wrm.9.2023.02.21.04.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 04:27:40 -0800 (PST)
Message-ID: <48429c16fdaee59867df5ef487e73d4b1bf099af.camel@redhat.com>
Subject: Re: [PATCH net] udp: fix memory schedule error
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jason Xing <kerneljasonxing@gmail.com>,
        willemdebruijn.kernel@gmail.com, davem@davemloft.net,
        dsahern@kernel.org, edumazet@google.com, kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Date:   Tue, 21 Feb 2023 13:27:39 +0100
In-Reply-To: <20230221110344.82818-1-kerneljasonxing@gmail.com>
References: <20230221110344.82818-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2023-02-21 at 19:03 +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
>=20
> Quoting from the commit 7c80b038d23e ("net: fix sk_wmem_schedule()
> and sk_rmem_schedule() errors"):
>=20
> "If sk->sk_forward_alloc is 150000, and we need to schedule 150001 bytes,
> we want to allocate 1 byte more (rounded up to one page),
> instead of 150001"

I'm wondering if this would cause measurable (even small) performance
regression? Specifically under high packet rate, with BH and user-space
processing happening on different CPUs.

Could you please provide the relevant performance figures?

Thanks!

Paolo

