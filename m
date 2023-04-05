Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283516D871F
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 21:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjDEToI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 15:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjDEToG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 15:44:06 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE6DEC
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 12:44:05 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-947cd8b2de3so85741766b.0
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 12:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1680723844;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GlttmAhfT5tfz8lSYZXT2wZbb4L2id7GE8MRRXSka3I=;
        b=kox1NmeppAO+btjdlcJRvX4LHERbmW9X6UNWU2fGJfXgDKwvYrXLaAtDKKOi9/ZHmG
         FaQUiR0OxXA3TwoYJDfOc0qxo+meoNoTW6q224GBmZuV0Tt/s/wm3YC7uj1TNdOGtvpY
         GOkt9UZsSRQ51GE6GE6MwqI5r33C3BpQ+C7BE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680723844;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GlttmAhfT5tfz8lSYZXT2wZbb4L2id7GE8MRRXSka3I=;
        b=tKl1vMgmKX4i1YOp6eGecIrGO9q6vwGfyUnsfJN9WAp5F4JQyY96D7g3cx6rrCJ37Q
         ZLiDepQeA2zzvIBKjVL9hrbPPArKiGRLuxZTrNnEIpbcAYjVestDB7FCScpvKs5yUj5C
         Jorncx7uc3tXqrVUpfdcLUhMaAQx/nNBid6plIPTihLiVYyZJKOr7h9dkO4lGTEkmfgV
         w1hvt8jjOU+S7kytjTm2ggFUhFhgr8TKyMOhcgMOL30KLSuWqjinCl21LRwEFLM0row7
         Oo2GTrQXYZohj6pUvNHQj09f0KMSBrwiw2JiEeZ+BDWzNoXfOIpm0mHwaGIIMhsBfR88
         TJqA==
X-Gm-Message-State: AAQBX9fd/KPpcItEh/NAHjhIsaymFigOwZY4oBUvNRCLuTq7TliUWrCm
        0+42QbvTBiXD36cuLhbGk/ctgqebHoG/2aic4+Nq5w==
X-Google-Smtp-Source: AKy350YvVUUbriDswTxaE8pZKoKOQAtkJat3YNNaD6oYPXNTWkSmq9GFochAcswbb1rGrRQF8fxEKjZzfjR/m5YE4xc=
X-Received: by 2002:a50:d781:0:b0:500:547b:4e1b with SMTP id
 w1-20020a50d781000000b00500547b4e1bmr1853965edi.6.1680723843878; Wed, 05 Apr
 2023 12:44:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230403143601.32168-1-kal.conley@dectris.com>
 <CAJ8uoz1BKJ1_jq6Sum-OkZQTR_ftmr5Enj+Cmn4Qsi15_jOpbQ@mail.gmail.com> <c0596a62-0873-5638-920b-235c55ff33a2@linux.dev>
In-Reply-To: <c0596a62-0873-5638-920b-235c55ff33a2@linux.dev>
From:   Kal Cutter Conley <kal.conley@dectris.com>
Date:   Wed, 5 Apr 2023 21:48:43 +0200
Message-ID: <CAHApi-mzLH7yVOT0cM03yafzTJJqfGwOBTa3q5U6jBdWnAx3VQ@mail.gmail.com>
Subject: Re: [PATCH bpf] xsk: Fix unaligned descriptor validation
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Magnus Karlsson <magnus.karlsson@gmail.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
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
        Maxim Mikityanskiy <maximmi@mellanox.com>,
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

> Is this case covered by an existing test?
>

No. I submitted a test but I was asked to make minor changes to it. I
plan to submit the test once this gets picked up on bpf-next.
