Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D900652A81
	for <lists+bpf@lfdr.de>; Wed, 21 Dec 2022 01:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbiLUAe3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 19:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiLUAe3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 19:34:29 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CB11DF0C
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 16:34:28 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id a1so4902243edf.5
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 16:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uEywYSt0v4YoPVVUToY9m/lVOoGWK3m4lv4kKbrMSak=;
        b=QcaaaTaW6pt+zyMv7Iqj2DsMRR3s6U3qUYkDa56i0SbK48PvAw9zELQi6AkDpnF/8I
         hFYjBPpVlsguWLpp0qEqcUZKihObMB5lrmUAXEC+pGsCx03/zJfLNYwvQs3gDZx3OUqW
         vvL/2cDYHSuRhOBviGh0a0fSBtPJ7JZlsTm4xKRn1MZjtVQS2NY+M8tw0u3scg2qks8S
         27BYF5SfU1HUUwamxjrDazEc+pgww4/PNt1MPK345/NS9SFtA1+Re5HheITfbpLNmSY/
         F1+b+csSMqgBwhdRmXJflStXIPoCRJO/iSbujxNtp4waGvN5kO854tsiAVfJgrEeP5uM
         fqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uEywYSt0v4YoPVVUToY9m/lVOoGWK3m4lv4kKbrMSak=;
        b=EXwQn2zcUjPIsBF1uBtjvFHlCH+Kss2H9siBTHZ/0B+47HCVAZJcgolH87vIPdKDTN
         yj1Q6/1dc1nwkxDJ/wvh2yA22pSyF72bCDkPQKwmIsXouAiBW/6TpyBuMwuHdcegzubD
         sIVP1GHNOuTkFYATf+tQ3bU7qw4lpT3zcg4ZhOR8gwgproTjHrGzKYRkLqO0K9xLYZ0W
         mAFKMyEdW4uoMugLDxv+4uAQfS8ZN+FhwGM0ridub+ReOspkIsne8n5nPh+Ey/WW2k98
         ywSzcj2ncxfnHmSXWM1/6qQK+EhgDBMc6jo9uhYodi04xkQPHDxYYGCHfu9izUUL8DRb
         2Pvw==
X-Gm-Message-State: ANoB5plPxpUdiQi66ixioF5SirSNiHZcVU7DJYpxZv5ofhr2Zx/6KQGt
        Z8v7MxPnHLBXxWwF0GJbY7V3W8O6H7uoIoaN8AS08smRvQg=
X-Google-Smtp-Source: AA0mqf5vBDXrIxljfrBXMfnghcW7pC49xmbSUyKcOFBprN3lyGPEug5WZ9q7vj0d79e8P9qCgYgnS08/l7tDuP3rqLA=
X-Received: by 2002:aa7:c586:0:b0:46d:bf2f:7e35 with SMTP id
 g6-20020aa7c586000000b0046dbf2f7e35mr4187289edq.232.1671582866721; Tue, 20
 Dec 2022 16:34:26 -0800 (PST)
MIME-Version: 1.0
References: <CAEc2n-vmWk6+hG-fcqvMdeG-hSyuFoHv9R79U5MjnOU7nXQSpw@mail.gmail.com>
In-Reply-To: <CAEc2n-vmWk6+hG-fcqvMdeG-hSyuFoHv9R79U5MjnOU7nXQSpw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 20 Dec 2022 16:34:13 -0800
Message-ID: <CAEf4BzbQYUQu1RaVrqBNJzjPxRa=W7R-ezuZoXY4O=tUP22dTA@mail.gmail.com>
Subject: Re: Support for gcc
To:     SuHsueyu <anolasc13@gmail.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>
Cc:     bpf@vger.kernel.org
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

On Tue, Dec 20, 2022 at 3:56 AM SuHsueyu <anolasc13@gmail.com> wrote:
>
> Hello, I use gcc 12.1.0 to compile a source file:
> t.c
> struct t {
>   int a:2;
>   int b:3;
>   int c:2;
> } g;
> with gcc -c -gbtf t.c
> and try to use libbpf API btf__parse_split, bpf_object__open, and
> bpf_object__open to parse and load into the kernel, but it failed with
> "libbpf: elf: /path/to/t.o is not a valid eBPF object file".

if (ehdr->e_type != ET_REL || (ehdr->e_machine && ehdr->e_machine != EM_BPF))

This check is failing in libbpf. So check which of those two are not
set appropriately. cc Jose to point where to report GCC-BPF specific
issues.

>
> Is it wrong for me to do so? Due to some constraint, I cannot use
> clang but gcc. How to parse and load gcc compiled object file with
> libbpf?
