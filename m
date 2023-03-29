Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980156CED14
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 17:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjC2Pgd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Mar 2023 11:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjC2Pga (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Mar 2023 11:36:30 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F0659FE
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 08:35:56 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id b20so65056484edd.1
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 08:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1680104150;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qgfm73gIETNl2zPIB+HRG6xi4vXnA98QP90kl6J3mWM=;
        b=aTWP0Aae6Of/VMbZvuC5nF+xa21oqeIpBUqvTswtT5wJWrf+oA/Q2xCk5McpObXCQ1
         kuovw/S1qKplGqYSOfL6dDfFUwN2o84rt8XLEM7s881rSEy8WuljUq39d5y+VXpKSo3/
         NNhiMyJHLK9xI5Zbog638fWBIA+eBFyny4CZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680104150;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qgfm73gIETNl2zPIB+HRG6xi4vXnA98QP90kl6J3mWM=;
        b=CaR3qQCDNob4v0txS0emtggpvOVrvuzUzp+UIWOl57Fvm1KPc+MPRS7eWDQtRmL//J
         ocugx9MTGKiIP2bGEN9Qsw9g0JFcgSdNXUV5N9PAocIyPcezitF/zI0+mNr/q9JDVm5V
         bpj+ykTyUm3ZqlCKnCPRqtErC3BDKI7Cu+b/ZzhIzwwf4s0tCzAucMMdy83YyCS2Zcl+
         OJTKmabu5jEI/Yw3+LyJi5TwCJhP+4d2aQfXFl7lAdCPhjhI+985XnvYJlY66MTS1x2k
         HlN1J6yIhjoxSkudmkC5DrwCz1dpEUIbkfjY77nOifbmiNIz9+4XvVc6GoI56Xr2MXHB
         E5Ew==
X-Gm-Message-State: AAQBX9frroqzeJpZtgjRN947VnPVu3duBeamG/dalCnL0k254oYT/sue
        29Lhpqr3d+xUJcuo8r9etxOrQS6jY/kBV6A/sAr96A==
X-Google-Smtp-Source: AKy350ZKfBNpNw+XrNHpCRVQVFXAlTzo3esOC/YoGW4ySaR30jIKluQgcwgqA332mASpevOJBFlCCZkOBlV6CMuiK3A=
X-Received: by 2002:a17:907:a49:b0:931:6f5b:d27d with SMTP id
 be9-20020a1709070a4900b009316f5bd27dmr10319862ejc.0.1680104150739; Wed, 29
 Mar 2023 08:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230319195656.326701-1-kal.conley@dectris.com>
 <20230319195656.326701-2-kal.conley@dectris.com> <ZBmLe27KrmXp7Qfc@boxer>
In-Reply-To: <ZBmLe27KrmXp7Qfc@boxer>
From:   Kal Cutter Conley <kal.conley@dectris.com>
Date:   Wed, 29 Mar 2023 17:40:25 +0200
Message-ID: <CAHApi-nt+B8wQTDbXYWW+DSi0-MN8smXNqkyCHGOCpwQ2BtFng@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] xsk: Support UMEM chunk_size > PAGE_SIZE
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
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
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> can you tell us a bit more about your environment setup - from what i can
> tell mlx4 does not support xdp multi-buffer, so you were testing this
> feature with XDP program attached in generic mode?

This card uses the mlx5 driver. These numbers were taken from a
slightly modified xdpsock example. XDP multi-buffer was not used.

>
> if you were using xdpsock -S or xdpsock -c? or maybe even something
> different?
>
> what was your MTU size on NIC?

I will update the table in the v2 patchset with more information.

Kal
