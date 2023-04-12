Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6A16DF552
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 14:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjDLMeN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 08:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjDLMeM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 08:34:12 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A6F2680
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 05:34:11 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id ud9so28210185ejc.7
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 05:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1681302850; x=1683894850;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r2cn52JN3eRMerScMtCLlq4G/DaFFVVSR4HFPD0rXaU=;
        b=V2tdHLT8z0rzP1cIETJ1rUDrJ+pVt8os5+RVxclF2NIA9QFHWIVsDJVIcl7e5aSMmV
         7rc93+5f8U9MHcxd+3QFFi/A20o/2Ktmv063Xw/X3f005opiPA/44UGQT9eucY/3Xpr0
         Y0f7EWuVtSIDH1gqkJWKBOre8PKGyeg1GnJ2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681302850; x=1683894850;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r2cn52JN3eRMerScMtCLlq4G/DaFFVVSR4HFPD0rXaU=;
        b=e7/TS7nlxGIbGjNUB0Xb2zwmMOf9Qrf+5xU9VmdtWVPXh8zQqPikuc8vd8brNq1IUS
         bml3XnNgh/DWJvKbjTD3S+EzQwxbfP0BkBYtNAvX+1k/Xa9RyjHV78x6OkmP5m7xj94i
         mFgXk1wDKxknAhpTD5WNNQFqi3zgRug7nXY1FAGWlDXtSbIkaGIFZ47km2ictpWqj/wU
         QOaP0iPMtUiKo0fRWYsn9zQRBj8CJg/augxOtGqYXuaQXRsEsB2+jJIQjHEoztFpmu1q
         vknf5si31Su6uqNUJ2PzgEmBMHIkQMAh0uYTnEkqnsH4CiS5JxunohW9SmXC3gfJw94X
         izIw==
X-Gm-Message-State: AAQBX9e/cqugTUouD3gUJNLZ5sm1DAs+G/CxT//W1FPpaNgiophtBoA2
        WbZzsTP26ZKQhDsVMtonEI2WCsb6Zbg1GNBilq+qIA==
X-Google-Smtp-Source: AKy350aPE23MhQg8qWazNdMKTEkcF1JPMzvLnz5WOiZUlgpc8Ua3OiDxBIJMV1kWwPXkUpnZFLhl3Z/MKekHvmIgyHU=
X-Received: by 2002:a17:906:ed1:b0:8f1:4c6a:e72 with SMTP id
 u17-20020a1709060ed100b008f14c6a0e72mr6150913eji.0.1681302849823; Wed, 12 Apr
 2023 05:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230411130025.19704-1-kal.conley@dectris.com> <CAJ8uoz3W8uHQANJ2hxVydCbz7-d=kO9KKn_iBLX3wsWy-OGUvQ@mail.gmail.com>
In-Reply-To: <CAJ8uoz3W8uHQANJ2hxVydCbz7-d=kO9KKn_iBLX3wsWy-OGUvQ@mail.gmail.com>
From:   Kal Cutter Conley <kal.conley@dectris.com>
Date:   Wed, 12 Apr 2023 14:38:54 +0200
Message-ID: <CAHApi-nXHzwmGmQUkbH=6aP1Dob=s2SSB91zjGScHNcRjMy8kA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] xsk: Elide base_addr comparison in xp_unaligned_validate_desc
To:     Magnus Karlsson <magnus.karlsson@gmail.com>
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

> Thanks Kal! Just checking again that you ran the xsk selftests on your
> change and that it passed? If so, here is my ack.
>
> Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
>

yep, I ran the tests and they PASSED.
