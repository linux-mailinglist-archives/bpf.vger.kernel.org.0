Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A816E4FE0
	for <lists+bpf@lfdr.de>; Mon, 17 Apr 2023 20:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjDQSIr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 14:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDQSIr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 14:08:47 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D97310D
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 11:08:46 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id z132so843207iof.3
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 11:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681754925; x=1684346925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFRye2b8enKh4h81efhVYyeqGgzP7Su4Fye7jw42xwg=;
        b=wZl45TbqL6ecocXZBvu0xhtj0IexNHPSwZby/tAHhJkJ41Hx9HHBE3C3WykLMGo7y5
         W7B0CqASqsQi+7xTzkbMm+W5pXi7xyoDG1mohHjMxXHZCFWk/97Vqq45sEz3EiadSuY+
         G8I2xTIP06pY7c5OM1gKgbTypkfBPVDT4UsMhydQBVJ4ru65C0DFJ5FYZBM9xP9yelq1
         IcDMYUMwBZRkIvz9YZ3QByTTutmJzQjWoKaJ/CyXIgXInHt/dCfq0u0dcHapBMVOuLY1
         9mG9t6nY+mYs1y/L+Wmt0R1Jq5fpYmqvIFqaq0vRsKdLSnNdGR3LcDBfm+5+SDRU6CHA
         alJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681754925; x=1684346925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FFRye2b8enKh4h81efhVYyeqGgzP7Su4Fye7jw42xwg=;
        b=ggpPDKCyHtyNJ3KKDYukd7+XwimojBi6o3myugpLFmhKbu04c2QKk8HC6clxGbMjcb
         mOcftSdtrl5FYfCQPKkHWSOMSTjbHh8DihYrPxe/t02m4g6g/vslGQ0qo3Z88L+d6TxH
         AICBd7dzdzapB5vZHEifGaRZ3tsSDTgLXmdikzM3p+TaODnqw9UKrEamS5FFcOV1PrKh
         3EUUmPdfmlMgNTr3H4rGAetxxedoVOSuqcZcjQvCVIauMo4t0c9dA7mq/HrGwwLaATx5
         WHZO3EHJ9w8esdEpxdmgNBG44isNKFWzqQz39MiNOp8d5lr32SGLyP5CoBNvechJ3wUV
         42eg==
X-Gm-Message-State: AAQBX9cpYfoiSPYcP1tajFJJJmQGxvrkebv/0mFrul8OQurh21nvffBo
        mxQmKAJcylMzEojhY8D19uMCOpX18qLqU+FHu85/Xw==
X-Google-Smtp-Source: AKy350ZIPgWkFjEHcpwEMfuwRPw4uUlziBkLPr1Yaj5TwHYjLAwWfkf6t1jQrASFhz7UNUKAOOzi2qdJG2a7B1ERKfE=
X-Received: by 2002:a02:a19e:0:b0:40f:9859:1fa5 with SMTP id
 n30-20020a02a19e000000b0040f98591fa5mr3133759jah.2.1681754925382; Mon, 17 Apr
 2023 11:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <ZD2HjZZSOjtsnQaf@lore-desk>
In-Reply-To: <ZD2HjZZSOjtsnQaf@lore-desk>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 17 Apr 2023 20:08:33 +0200
Message-ID: <CANn89iK7P2aONo0EB9o+YiRG+9VfqqVVra4cd14m_Vo4hcGVnQ@mail.gmail.com>
Subject: Re: issue with inflight pages from page_pool
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     netdev@vger.kernel.org, hawk@kernel.org,
        ilias.apalodimas@linaro.org, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, bpf@vger.kernel.org,
        lorenzo.bianconi@redhat.com, nbd@nbd.name
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 17, 2023 at 7:53=E2=80=AFPM Lorenzo Bianconi <lorenzo@kernel.or=
g> wrote:
>
> Hi all,
>
> I am triggering an issue with a device running the page_pool allocator.
> In particular, the device is running an iperf tcp server receiving traffi=
c
> from a remote client. On the driver I loaded a simple xdp program returni=
ng
> xdp_pass. When I remove the ebpf program and destroy the pool, page_pool
> allocator starts complaining in page_pool_release_retry() that not all th=
e pages
> have been returned to the allocator. In fact, the pool is not really dest=
royed
> in this case.
> Debugging the code it seems the pages are stuck softnet_data defer_list a=
nd
> they are never freed in skb_defer_free_flush() since I do not have any mo=
re tcp
> traffic. To prove it, I tried to set sysctl_skb_defer_max to 0 and the is=
sue
> does not occur.
> I developed the poc patch below and the issue seems to be fixed:

I do not see why this would be different than having buffers sitting
in some tcp receive
(or out or order) queues for a few minutes ?

Or buffers transferred to another socket or pipe (splice() and friends)
