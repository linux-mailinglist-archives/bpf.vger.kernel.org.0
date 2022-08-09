Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E9158DFA4
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 21:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243130AbiHITDb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 15:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345372AbiHITCx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 15:02:53 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5F127154
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 11:36:51 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id kb8so23753638ejc.4
        for <bpf@vger.kernel.org>; Tue, 09 Aug 2022 11:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r1udxiufLg2zQG7fcR9O3XIbCaneDTtc2a4z99MA4xU=;
        b=ircE61oswZtl8VM78NwlhZT9E0w9u5pquSdr3rN+04ShF7uk5rMdUIxDOQW3oqKbW7
         fTR4QVP42lBBv62UaQZAvczdSbgpJ6sbA4nBcUqabMV9bgVuz2T3hJatYpHQ/1BjvXT4
         QZQiPJWWbmZ4Ao1iklKGk3u5cMo7hs8YSGX2BRWvJ4WxR9iOLudXlmuG4r3OTmxnj6ha
         W+FUIUg7HXHhSaftLVxjwVRH4SLPzJpmC/Cujna3PgTqm4iV0O5JFJ884AtTIMyCF5s0
         8gZt5e2JDRfNSVB3WjXw//uxtxYZR5hH2vXc5DZ+/rPG7zprrHvy8OAK3TNB9j5tb/Qv
         QCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r1udxiufLg2zQG7fcR9O3XIbCaneDTtc2a4z99MA4xU=;
        b=ChvQnWEIXDHj47sYaXzfXtAtgGJjOqTfsMdwOikAMBLPKtM4n6KnJO/0OL4dnXE3av
         r0e1SHCProkgbIwl9Nm/gBfWM+Y6lOGwiB6O1KfdgqB/zSzpnh6zq8kKXjdtN9QBGAxU
         0Vk4WMc3smtvg+APidHqkqzdo5JrLR+X9QhJCIeocymHu3E0V5sg4k7OFizY0VScAbCm
         jM+jIV0U6JqXXAcylwbPhnFPTD3Q1p+xAwU006bDLYC5RyExNFMtygm5e5iXtcDiQNpD
         Jts/P+/u4oGRZPD/tG+imQGdsEyctlC5m4nZLpmfc0hRIFRBcy7gCgnbj2BjBmhhdxyM
         bQzA==
X-Gm-Message-State: ACgBeo1LR1gy/dn9DjQ30Nl8vLtL0uwdyAgM7qP2Qh6bx7fcmd7rtUEn
        SaZ3UsD0lEDNfRCz0tx2eruQ7B9Wci770FTAWtg=
X-Google-Smtp-Source: AA6agR7eaEO1lzqQO7BiTfJItG/ViwJdZ8RbgAraxxkQLKSxDdirgKeSxufgsJxbf3pEq6qqsqG31VbxtlJmPMuqD1Q=
X-Received: by 2002:a17:907:2896:b0:730:983c:4621 with SMTP id
 em22-20020a170907289600b00730983c4621mr18406108ejc.502.1660070209681; Tue, 09
 Aug 2022 11:36:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220809175208.2224443-1-joannelkoong@gmail.com>
In-Reply-To: <20220809175208.2224443-1-joannelkoong@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 9 Aug 2022 11:36:38 -0700
Message-ID: <CAADnVQJV3-q_kkqoz+_RtOhQ4+ckBTLfTvgSbgmUP47mzMLtZA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Fix ref_obj_id for dynptr data
 slices in verifier
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        David Vernet <void@manifault.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
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

On Tue, Aug 9, 2022 at 10:52 AM Joanne Koong <joannelkoong@gmail.com> wrote:
>
> When a data slice is obtained from a dynptr (through the bpf_dynptr_data API),
> the ref obj id of the dynptr must be found and then associated with the data
> slice.
>
> The ref obj id of the dynptr must be found *before* the caller saved regs are
> reset. Without this fix, the ref obj id tracking is not correct for
> dynptrs that are at an offset from the frame pointer.
>
> Please also note that the data slice's ref obj id must be assigned after the
> ret types are parsed, since RET_PTR_TO_ALLOC_MEM-type return regs get
> zero-marked.
>
> Fixes: 34d4ef5775f776ec4b0d53a02d588bf3195cada6 ("bpf: Add dynptr data slices");
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

merge conflict. pls respin.
