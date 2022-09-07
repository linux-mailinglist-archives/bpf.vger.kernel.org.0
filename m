Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243C95B0957
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 17:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiIGP6p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 11:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiIGP6n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 11:58:43 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B466BB02E
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 08:58:35 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id s11so7783979ilt.7
        for <bpf@vger.kernel.org>; Wed, 07 Sep 2022 08:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=k4KTklcG0JXYWiy3L/LW81UYNL/fw/f9zXp372npIYE=;
        b=LkmRxLTczIfp+ofNR3dd5CS5DnrJqSSj9dCBNKo6DZxsfjmie+Ybb1SQWMJpf673r/
         ZofWg3Q9c1Dr4ix6eF5DkugsGCGGHbQHcn/YNUxo4BbJiTpxoK/XGbQzAuZALLtZXFQV
         TfduGxGX6er+sOGsz0ttzWlaC8hoXrtW2Q26THPRI600QQwUhaiaCDXlvHjCL0Dyg1Tr
         q9UYhih9ijJT7t0LO+QF6lmismjmGk2SGqrV1zhYK76Y7AoheQMWIYfAobXgWGjTMSMi
         iDxeJoQShaDXxaCEWE+rgflEFZv/ClFAxgLDmb5j49Xed6LYuH6ITHmerwPWBxbkl7oI
         cEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=k4KTklcG0JXYWiy3L/LW81UYNL/fw/f9zXp372npIYE=;
        b=wnWjZQpC39fJIH5z+voB2b/c5jf2f/ITV6L+Hhk+aIeJQYhxbcMXvZyRPNswAFdvZW
         3aueDNZy24x5jM4YuW+ptV5xvnjqX0M2hSSJdHmFVXQZqN3iG/8HKUUtKkKK92FRTBGC
         X9J7+GCmdHtQaS1zOpZUYrG8q6ezgY8NF7M4n9w9gAS1wZtl0IRfsyPDvdv3Uk+X0sMo
         l3JkiF6kqRDes4i+8kbXpSmgEdjsOKpep3zCQNtxd6/+OTQZd6gSE8LICw5PFdppRE8g
         IYy9LlQKrz3XzHnqO5XCt7UbvCVXkkCuQRCI2WQbIlufmimyLzI1FK+rJPzG2qlja95d
         HbJg==
X-Gm-Message-State: ACgBeo37Qsr5aYcoavtMlKJhq8aP3+9KcIHZHrtITGrEMnZJGIi7MJbl
        T0m28fFxUHszYTf6F2LNOd10X4X2obGq8nre+NY=
X-Google-Smtp-Source: AA6agR6jTxGei1pUDj89UGDfib7xMAo+9WfPvKHbBBmCJBXDqj3TpUL2lUCs4XPZyewyYLOsRiZLXHh+DkqtvzLY4vM=
X-Received: by 2002:a05:6e02:170f:b0:2f1:6cdf:6f32 with SMTP id
 u15-20020a056e02170f00b002f16cdf6f32mr2240650ill.216.1662566314475; Wed, 07
 Sep 2022 08:58:34 -0700 (PDT)
MIME-Version: 1.0
References: <Yxi3pJaK6UDjVJSy@playground>
In-Reply-To: <Yxi3pJaK6UDjVJSy@playground>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Wed, 7 Sep 2022 17:57:58 +0200
Message-ID: <CAP01T77wGxv5aTf=Wwwn79jHMrTuv+Wr9Y8b8x1244tQUBxCyQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Fix resetting logic for unreferenced kptrs
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org, Elana.Copperman@mobileye.com
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

On Wed, 7 Sept 2022 at 17:24, Jules Irenge <jbi.octave@gmail.com> wrote:
>
> Sparse reported a warning at bpf_map_free_kptrs()
>
> "warning: Using plain integer as NULL pointer"
>
> During the process of fixing this warning,
> it was discovered that the current code
> erroneously writes to the pointer variable
> instead of deferencing and writing to the actual kptr.
> Hence, Sparse tool accidentally helped to uncover this problem.
>
> Fix this by doing WRITE_ONCE(*p, 0) instead of WRITE_ONCE(p, 0).
>
> Note that the effect of this bug is that
> unreferenced kptrs will not be cleared during check_and_free_fields.
> It is not a problem if the clearing is not done during map_free stage,
> as there is nothing to free for them.
>

You're still missing the fixes tag right before your Signed-off-By.

Instead of

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>

It must be

Fixes: 14a324f6a67e ("bpf: Wire up freeing of referenced kptr")
Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
