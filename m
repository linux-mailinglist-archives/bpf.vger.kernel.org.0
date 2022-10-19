Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129E16051A1
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 22:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiJSUyb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 16:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbiJSUya (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 16:54:30 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2965F5B
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 13:54:28 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id s13-20020a170902ea0d00b00183243c7a0fso12448719plg.3
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 13:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S4ynRFpLFlxGT+Jd1X6xYZMiF+FFqxtqnzj3gqz2w9c=;
        b=inbhOLWlz5PqQsCFHw31NPPwVDYZwzCJaTAzjODLUB4et1j8QPFq915WbRiMLUjftO
         7BYEx50DD2t6KcDOIXgNAHoTjw/VyUdeOv7kVHLvoLscV4uqkB+vI7zP82Pl8xN5cgoY
         NGJ10jwZb5gBItZa12HZt1ooQRxngpw1xHBAf0TahxwQH9cqURxzQvOU5wzvGFkSuNzr
         odyEKonsd567yF0JH45t6CKz/0Iy66KYol1YCMXdG1Ep7UGF6WS4VoA0xunnqrm9mhuK
         y9mymrrY/GIMIsSf35ZUc/gNY45wuzAEbI76zqeLSkB8eXVTZKKi2AiZBh6Pr0vjGC+p
         1mvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S4ynRFpLFlxGT+Jd1X6xYZMiF+FFqxtqnzj3gqz2w9c=;
        b=DoCP+eGEo3PMW/DSM+9P5oaN5CLiZxH6a9kiH3DXPlUDlCJO4JlaoBg2sOKx2IdkHb
         uQMjVqhpcigSL0GcP//KgLQCm/9LRD2B8ezL0GwpVGDk/hptRZO1DF6tIXPzFyHO+/7w
         /79svD55iTrlMO4+ouK10D7e1N5D8sp6I6/x+AaFxOPpBYIh6FWrLTnpXvTa1N0DvTRZ
         wNHqjqDuirn6c1AKEit8lX3oFZ5g1EPVhbJJZyzbYVD/7s82lHxllVe3aGV0nPL6gxiP
         TmFTzSUfYlPF2ewA0xnTtUF6uNuxITqzjZdCoVhhwVMHQhUUllOmFmObxjc4uPXB+wve
         0Ewg==
X-Gm-Message-State: ACrzQf3KJUedpKvJ1FZ+l1Cb1z/Q3+M/v0dXK+AORBBY2F5MR6J0My+i
        OuTCRcvyWqoLud7yaX8qgkQpERc=
X-Google-Smtp-Source: AMsMyM44g0DDTycm9y4Is6geQZ/TkdA/zUrWT7wmOTc9qX4Wpai0FV6OU3cwKRmiSzQXljOf9LUMvTY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:7081:b0:178:6154:9d79 with SMTP id
 z1-20020a170902708100b0017861549d79mr10519061plk.79.1666212867688; Wed, 19
 Oct 2022 13:54:27 -0700 (PDT)
Date:   Wed, 19 Oct 2022 13:54:26 -0700
In-Reply-To: <20221019183845.905-4-dthaler1968@googlemail.com>
Mime-Version: 1.0
References: <20221019183845.905-1-dthaler1968@googlemail.com> <20221019183845.905-4-dthaler1968@googlemail.com>
Message-ID: <Y1BkAjUts2WQdeTm@google.com>
Subject: Re: [PATCH 4/4] bpf, docs: Explain helper functions
From:   sdf@google.com
To:     dthaler1968@googlemail.com
Cc:     bpf@vger.kernel.org, Dave Thaler <dthaler@microsoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/19, dthaler1968@googlemail.com wrote:
> From: Dave Thaler <dthaler@microsoft.com>

> Explain helper functions.

> Kernel functions and bpf to bpf calls are covered in
> a later commit in this set ("Add extended call instructions").

> Signed-off-by: Dave Thaler <dthaler@microsoft.com>
> ---
>   Documentation/bpf/instruction-set.rst | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)

> diff --git a/Documentation/bpf/instruction-set.rst  
> b/Documentation/bpf/instruction-set.rst
> index 29b599c70..f9e56d9d5 100644
> --- a/Documentation/bpf/instruction-set.rst
> +++ b/Documentation/bpf/instruction-set.rst
> @@ -242,7 +242,7 @@ BPF_JSET  0x40   PC += off if dst & src
>   BPF_JNE   0x50   PC += off if dst != src
>   BPF_JSGT  0x60   PC += off if dst > src     signed
>   BPF_JSGE  0x70   PC += off if dst >= src    signed
> -BPF_CALL  0x80   function call
> +BPF_CALL  0x80   function call              see `Helper functions`_
>   BPF_EXIT  0x90   function / program return  BPF_JMP only
>   BPF_JLT   0xa0   PC += off if dst < src     unsigned
>   BPF_JLE   0xb0   PC += off if dst <= src    unsigned
> @@ -253,6 +253,22 @@ BPF_JSLE  0xd0   PC += off if dst <= src    signed
>   The eBPF program needs to store the return value into register R0 before  
> doing a
>   BPF_EXIT.

> +Helper functions
> +~~~~~~~~~~~~~~~~
> +Helper functions are a concept whereby BPF programs can call into a
> +set of function calls exposed by the eBPF runtime.  Each helper

(the series looks good to me, but I'm assuming Alexei will take a look at
these anywey because he did for the previous submissions)

Not really related to the patch, but in general, quoting from the above:
"BPF programs can call ... by the eBPF runtime". I know we do it all the  
time
and use BPF/eBPF interchangeably, but should we try to be consistent at  
least
within the same page?

$ grep -r 'eBPF program' Documentation/bpf/ | wc -l
34
$ grep -r ' BPF program' Documentation/bpf/ | wc -l
97

> +function is identified by an integer used in a ``BPF_CALL`` instruction.
> +The available helper functions may differ for each eBPF program type.
> +
> +Conceptually, each helper function is implemented with a commonly shared  
> function
> +signature defined as:
> +
> +  u64 function(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5)
> +
> +In actuality, each helper function is defined as taking between 0 and 5  
> arguments,
> +with the remaining registers being ignored.  The definition of a helper  
> function
> +is responsible for specifying the type (e.g., integer, pointer, etc.) of  
> the value returned,
> +the number of arguments, and the type of each argument.

>   Load and store instructions
>   ===========================
> --
> 2.33.4

