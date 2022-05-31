Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3878F539A3E
	for <lists+bpf@lfdr.de>; Wed,  1 Jun 2022 01:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348661AbiEaX70 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 May 2022 19:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234487AbiEaX7Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 May 2022 19:59:25 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910EB6B095
        for <bpf@vger.kernel.org>; Tue, 31 May 2022 16:59:24 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id 63so77875vsx.5
        for <bpf@vger.kernel.org>; Tue, 31 May 2022 16:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4b2lLfZSaBsCv4JaUe7TZlYI31NBuZ+192kJEndF3Ik=;
        b=VievTKIPJvNSekPDSnIJNTqU5PAnza13jbDik/B7LWCKcfde87XxKaJha8feX/miHt
         HVHWnt2DfCs8HJcoNr6P9aaDQJsG4rf1ZiKCkV26BqG5qwqa7xB1v/5NHuuAZgQkkVyw
         MKfnCcD4moRz7aF/wi62cfac3Ne/US/6VezDJ0qj1QW+ROnQeO4ZR9hXxfIWVREHW6GF
         D2gvDPPo83XZIOcI8DVzUIZg41rKfvI8ewBxpG9xloc5thfzsQGrbaQMkrYxaV9y9tR0
         n63KBKjCe6ch3FBiq7aZxXuKTEsmZtW1UzD776uKpfG27T0CbJmqINxUJhyDg+QI2sQf
         CebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4b2lLfZSaBsCv4JaUe7TZlYI31NBuZ+192kJEndF3Ik=;
        b=l7h6L/lIiYeDKczZQ0DFLs7IF/vDBn2MkSO/7a9ZvUf/vhG58Q5FO+BTY+NnOR7fpi
         nanp4i44d64oi4avcTstdULdjIVH1ZtUg3HzLGlHjzlxjb9ugYcKTnTtutYoX0M8nqfB
         nhjvyi48Hy5iP0tqaDox2+vgRnTAIzTR48oi/mWR4Q2LepbWJhm3bAE434QTwzjzDlxc
         zcrirjDMQCLPZnaTmxEJDgmF87JSJhKaqvHAPYIcE2taj6eS5FcDtRGbPrfWYmS1z5sz
         XKBED5z3ppBFJZJMxPIB0PuBqVpTCZSImlGzLIziaQ3QS9BdLFWMGQajAexAZ03UCBG9
         KB6w==
X-Gm-Message-State: AOAM5313RYAwzM13OTHfqy85aRSIEExVVHR9XRE3EdyhQZ3FyG+MZyZY
        AInoqaa3WCiGcCeWU3adzacq7BB2VpSgIqCHlXM=
X-Google-Smtp-Source: ABdhPJzQVza3MEohjobMRywVYezeq+CekTSDTzdQWM+V6q0M3IQCCHiZN9eC6qwtVk4IULaySitXAy7NfNOivDHBd4k=
X-Received: by 2002:a67:e00c:0:b0:337:d9c5:af6d with SMTP id
 c12-20020a67e00c000000b00337d9c5af6dmr15603864vsl.1.1654041563720; Tue, 31
 May 2022 16:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220526185432.2545879-1-yhs@fb.com> <20220526185514.2549806-1-yhs@fb.com>
In-Reply-To: <20220526185514.2549806-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 31 May 2022 16:59:12 -0700
Message-ID: <CAEf4BzaNp67t1EPgDCqL9JELcEYT+=164At9JZukriBTWUHz=g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 08/18] libbpf: Add enum64 sanitization
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
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

On Thu, May 26, 2022 at 11:55 AM Yonghong Song <yhs@fb.com> wrote:
>
> When old kernel does not support enum64 but user space btf
> contains non-zero enum kflag or enum64, libbpf needs to
> do proper sanitization so modified btf can be accepted
> by the kernel.
>
> Sanitization for enum kflag can be achieved by clearing
> the kflag bit. For enum64, the type is replaced with an
> union of integer member types and the integer member size
> must be smaller than enum64 size. If such an integer
> type cannot be found, a new type is created and used
> for union members.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

LGTM!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/lib/bpf/btf.h             |  3 +-
>  tools/lib/bpf/libbpf.c          | 56 ++++++++++++++++++++++++++++++---
>  tools/lib/bpf/libbpf_internal.h |  2 ++
>  3 files changed, 56 insertions(+), 5 deletions(-)
>

[...]
