Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD76E5289CD
	for <lists+bpf@lfdr.de>; Mon, 16 May 2022 18:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245716AbiEPQJq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 May 2022 12:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242024AbiEPQJo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 May 2022 12:09:44 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B169537BE6
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 09:09:36 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id h3so12430549qtn.4
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 09:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5A3fC3LG9xhFT5OmLJx0Vov2wbp1md3QmcKxPsHHehk=;
        b=RMtITERx0KHzjfeMFcYUQ5YwBoiNb9R11NyYH1Id6J8V+h+/L6hyhds+eA/ilaJS+b
         YRIZN7EhCvti69lMKpEWUDxLpweg6Ds6kamzkC77wiVrVWaGJvpn2aeXEVcWN3UQG9ns
         um5LjonHGlZeIggbpQJv+xT2HdGW7DL+bU7UlgPsbK8zmQAAjuIbeD/w3U/pAOi1IxAc
         YEZqd7r571DrtNXlOYKamX6Es3tWY2z2J0eqfPWdbgvDezCJOSShMAACxzuJWwdD4FUw
         ZNjtzSn5iJ/CA79eO6OKioVysDODsqOayoLGxCLwDaMT2AzhyHHWlG4JkZ9lWEfnlUEW
         mu6Q==
X-Gm-Message-State: AOAM533Eg8EXkBg+6Xtf2Bl8NNH3Ws+i7sEyuef7X4AF8n417OYzPWkT
        g9PSnUtVnvf0qyKOzw9XyqU=
X-Google-Smtp-Source: ABdhPJxaLYoSk22p+9ELkyOUmLJ2arHz6w3RoUHNqaL/xzMHVVyRQRoHCPV4tNU1ot7PnY88+ahosw==
X-Received: by 2002:ac8:57c8:0:b0:2f3:bdc8:ede5 with SMTP id w8-20020ac857c8000000b002f3bdc8ede5mr15624403qta.458.1652717375606;
        Mon, 16 May 2022 09:09:35 -0700 (PDT)
Received: from dev0025.ash9.facebook.com (fwdproxy-ash-015.fbsv.net. [2a03:2880:20ff:f::face:b00c])
        by smtp.gmail.com with ESMTPSA id 143-20020a370995000000b0069fc13ce207sm5895359qkj.56.2022.05.16.09.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 09:09:35 -0700 (PDT)
Date:   Mon, 16 May 2022 09:09:32 -0700
From:   David Vernet <void@manifault.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net
Subject: Re: [PATCH bpf-next v4 3/6] bpf: Dynptr support for ring buffers
Message-ID: <20220516160932.mttpfphr6rkm4ve7@dev0025.ash9.facebook.com>
References: <20220509224257.3222614-1-joannelkoong@gmail.com>
 <20220509224257.3222614-4-joannelkoong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220509224257.3222614-4-joannelkoong@gmail.com>
User-Agent: NeoMutt/20211029
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 09, 2022 at 03:42:54PM -0700, Joanne Koong wrote:
> Currently, our only way of writing dynamically-sized data into a ring
> buffer is through bpf_ringbuf_output but this incurs an extra memcpy
> cost. bpf_ringbuf_reserve + bpf_ringbuf_commit avoids this extra
> memcpy, but it can only safely support reservation sizes that are
> statically known since the verifier cannot guarantee that the bpf
> program won’t access memory outside the reserved space.
> 
> The bpf_dynptr abstraction allows for dynamically-sized ring buffer
> reservations without the extra memcpy.
> 
> There are 3 new APIs:
> 
> long bpf_ringbuf_reserve_dynptr(void *ringbuf, u32 size, u64 flags, struct bpf_dynptr *ptr);
> void bpf_ringbuf_submit_dynptr(struct bpf_dynptr *ptr, u64 flags);
> void bpf_ringbuf_discard_dynptr(struct bpf_dynptr *ptr, u64 flags);
> 
> These closely follow the functionalities of the original ringbuf APIs.
> For example, all ringbuffer dynptrs that have been reserved must be
> either submitted or discarded before the program exits.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Looks good!

Acked-by: David Vernet <void@manifault.com>
