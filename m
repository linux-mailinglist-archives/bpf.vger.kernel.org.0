Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51B85BED4A
	for <lists+bpf@lfdr.de>; Tue, 20 Sep 2022 21:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiITTEG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Sep 2022 15:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiITTEF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Sep 2022 15:04:05 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83906744D
        for <bpf@vger.kernel.org>; Tue, 20 Sep 2022 12:04:04 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id 129so4178041vsi.10
        for <bpf@vger.kernel.org>; Tue, 20 Sep 2022 12:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=BFKDawvmjycDbdtHg5sCjZBfykTG9ryG3gRnZWFsv3I=;
        b=ahq9vEN203MRzxWgJMm3LXeMQ7BDFiALmzn6nQeNKWvJYJhBxvavf5BcPnb7YjYp9B
         rjQHKCH/pksLPXNRUe3uyf06v9A4nJBIywDaaJFefWsQm3tYJSEGHfstTzynPY7CS4PF
         ESyQ8Qw+fGy7hkT7vrkJxfCEfFm1xPO33aj3QgM20Ia6W+GOgiPQCQw6gmFUS8JYWzVg
         sy/HQVY/B/EN8LmR5bwGEf6L6Wy7MoslHsYe1kw0OjfpQsme2Db0lIzWwokPNVmsrjhd
         OSeNWkSkxGIbCf4q3Kt6151QBm6A/pF7X6mXn7A50lTz9gDE4KHsDKjJGd7VKfXLzBqO
         GRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=BFKDawvmjycDbdtHg5sCjZBfykTG9ryG3gRnZWFsv3I=;
        b=47xw0VSPkr7m6WGWHQlXJdzxPlo1kmkmqO2nWnBZ1nSBwUbqYl080YvTXdIIoUUCqd
         3tf9iRuITJj7oBbwnUI36QuW18ZOm3spvnDtuaNPtqEdVQ6wzNAhWGMFgM4xV17a1f0j
         o4QxYNNEE6aMy/CTdOEzBAxKMRzHBcCMK/9zZFNmA9hWN2U2tN1tYPAyWE8qe2ea00yF
         Nt2Ri577oBOX4p7INn12oZkuZzW49EmpaobHHxOGq8r+VUnMWYWahf/aHrf1lCezetxu
         olxTsfsSjNUjsjbxoHpFyHd+FUPzTMVnMnQU7P50zISzFFXHJgNGDE9Pq2m6g3xXc0lh
         qwYw==
X-Gm-Message-State: ACrzQf27sHLEicnI6gj74ks81OoCfXb6NLK/uQqj+tsDfTbDbUoeNVJ1
        Dcc20YL3+SRQ8qBWDBCFFJmOHPHrQXfEhGfGFfJoL9sLu84=
X-Google-Smtp-Source: AMsMyM7+goCZPLqtBCkFY+jNHXcbOMVf/3URa+ecxrFEag/bFnTNiT9m+PPXWhpH61bHxb01yD+6B/OtWx5yFkcTuWI=
X-Received: by 2002:a67:c01a:0:b0:398:1c0a:fe6a with SMTP id
 v26-20020a67c01a000000b003981c0afe6amr9118060vsi.32.1663700643781; Tue, 20
 Sep 2022 12:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAK3+h2ykSR=CXBDZs-_9JjBTim=2E4QHAzvkP=WR5Ke3EFd6Ow@mail.gmail.com>
 <737a8c08-5f2d-304a-adb8-f9f33d9e3ef3@fb.com> <953ceea8-16ed-5aa1-b170-c87b354e941c@fb.com>
In-Reply-To: <953ceea8-16ed-5aa1-b170-c87b354e941c@fb.com>
From:   Vincent Li <vincent.mc.li@gmail.com>
Date:   Tue, 20 Sep 2022 12:03:52 -0700
Message-ID: <CAK3+h2xZ=3-=wadzCM2t5PGoKF8wg0YCscQt=xtQ0gL0kAhFJA@mail.gmail.com>
Subject: Re: LLVM 15.00 github repo build panic to run test_core_reloc_kernel.c
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>
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

On Tue, Sep 20, 2022 at 9:50 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 9/20/22 9:42 AM, Yonghong Song wrote:
> >
> >
> > On 9/20/22 9:36 AM, Vincent Li wrote:
> >> Hi Yonghong,
> >>
> >> In case you missed the report :), I ran into LLVM Clang 15.00 panic
> >> when run bpf selftest, I reported in
> >> https://github.com/llvm/llvm-project/issues/57598
>
> I added some comments in the issue. In summary, your local llvm15
> is old. You need a newer llvm15 (the best is based on llvm15 release
> branch), which should fix your issue.
>
yes indeed pulling the llvm repo that is now 16.0.0 and recompiling
the llvm resolved the panic, thank you!

> >
> > sure. will take a look.
> >
> >>
> >> Thanks!
