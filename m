Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE02B60820C
	for <lists+bpf@lfdr.de>; Sat, 22 Oct 2022 01:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJUX2B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 19:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJUX2A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 19:28:00 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1CD2A2EBF
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 16:27:59 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id q19so11310489edd.10
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 16:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M+2D2T3q7d26g3ep3B3VQRceoRcfQJcAid5n3RJg91A=;
        b=i0DF/SwBR0FDxMW2RJ3VLIZZHt0XIq45k6j+5eH3rznkT8VNMfAOMbLU96a04qIp+U
         TXkRZnJFlK2ocBfon30/DRTUF4VOZnWraci34q+oAoch4j9hXnFIjH+zMyUJAqlNDGIE
         xeZgLiLE87hH3EHZjCvKvCpz+0WlCq86H3wjcw/E0UmZqo7A+nnz6+cWfiLzXeJgIe62
         LFHxNxm3T+i78UaaDK17pObq6VMaVKpiwrB7kzXjM9o5Wg6nQxLytFSOcZiFPICBEDxU
         tzbytV8uuyE+6qwjcJkjwLz+wGpphneOz4O2nu2icB0xekQ02QnhtvUrQYrnQtWFcZB/
         pleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M+2D2T3q7d26g3ep3B3VQRceoRcfQJcAid5n3RJg91A=;
        b=eWlRH92WWOIHo7IegGphh2UKzdKoAKrQV3xOPDwVJmfv0ARooDM/aO8Co/c0wqpX+q
         C5MinXLckZY6XjpxdW7yuS0LVBkdFn+j9cUELWbWJydTrVIdfm00V0QGr4XIyPlqL02w
         +ZZZL7WSerbcArA+jecrG4+dhWX1KrKuOgiy99qeENlP2Z2QHgkJM9yw2gQy8oMeP5oK
         bNYHU6sviwXQriJ1RbeQBfWBwZm8ivEHhlBleN4Y7xl0o7en9/JTlP9C1mVEOIBodZol
         06waGkToRzppzqq2pZDr7uUEiK0rpKvCfRte8zRyu/QXiwya/HVTlpWTkDTpZzLWU6q8
         y3eQ==
X-Gm-Message-State: ACrzQf318zyv89RPOr6gkv87VEkJvE1vhUO8aCJp3Ao5nhfGt8rEacKa
        4c12K0gxPFPgW7LXY2LMhB/i32tN53es87II9Pg=
X-Google-Smtp-Source: AMsMyM5YtlWfgI1IPqsi/Td07RvZMWd7cBX70wf75tnNITz/zYY1k6U52GYMD7lsnJ1IlpAAFhLtkb2N9QdKOPLWa5I=
X-Received: by 2002:a17:907:2cca:b0:78d:ec48:ac29 with SMTP id
 hg10-20020a1709072cca00b0078dec48ac29mr17582336ejc.114.1666394877582; Fri, 21
 Oct 2022 16:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <20221021210701.728135-1-chantr4@gmail.com> <20221021210701.728135-5-chantr4@gmail.com>
In-Reply-To: <20221021210701.728135-5-chantr4@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 21 Oct 2022 16:27:44 -0700
Message-ID: <CAEf4BzZ3wJr7cEQkN+dvxe+Ph5byEWrhiJoSUwF_qZ6nbBpb3w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: Initial DENYLIST for aarch64
To:     Manu Bretelle <chantr4@gmail.com>,
        David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, mykolal@fb.com,
        daniel@iogearbox.net, martin.lau@linux.dev, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 21, 2022 at 2:07 PM Manu Bretelle <chantr4@gmail.com> wrote:
>
> Those tests are currently failing on aarch64, ignore them until they are
> individually addressed.
>
> Using this deny list, vmtest.sh ran successfully using
>
> LLVM_STRIP=llvm-strip-16 CLANG=clang-16 \
>     tools/testing/selftests/bpf/vmtest.sh  -- \
>         ./test_progs -d \
>             \"$(cat tools/testing/selftests/bpf/DENYLIST{,.aarch64} \
>                 | cut -d'#' -f1 \
>                 | sed -e 's/^[[:space:]]*//' \
>                       -e 's/[[:space:]]*$//' \
>                 | tr -s '\n' ','\
>             )\"
>

Ugh :) As a follow up, let's:

1) teach test_progs to accept a denylists as:

sudo ./test_progs -d @DENYLIST -d @DENYLIST.aarch64

2) we can also teach test_progs to load any DENYLIST{,<arch>} if it's
present in CWD

Though we'd need some way to disable this (maybe allowing just empty
-d to mean "no denylist"?), of course.


> Signed-off-by: Manu Bretelle <chantr4@gmail.com>
> ---
>  tools/testing/selftests/bpf/DENYLIST.aarch64 | 81 ++++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/DENYLIST.aarch64
>

[...]
