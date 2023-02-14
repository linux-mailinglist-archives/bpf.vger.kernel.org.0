Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA20696EC0
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 21:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjBNU5k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 15:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjBNU5j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 15:57:39 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB252B636
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 12:57:38 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id lf10so11339071ejc.5
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 12:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=apSwcHBNbsjMzWMwAM8wLfBeeqE78HEez52v75M+bGE=;
        b=cNpq8+hgZXHGe0pPDvGpNBpt/yXRChPhjD2Ne9I8XM7Zyf4NkBmVCHE+PQHkihDkow
         gEMxXnlYZM9AQkvhW+IBII40ru112DvhuPnxc6vrwckNE5IduSNBGZ+FnLQ8eNU7dBz6
         oJgrSwNJ1LbTzvAnKN9SVoeOuCAMGawHDMu6zDOKIGJ2JWHQedg82D3mvtIkak+zawHA
         awrYmmHeMhrGI4Lb+mwTZ/nLUCTs0YQYTt9Gr8AYHFQ1ngPgZd8njUjRfEXtLIiti7b+
         CxS+Nq1ucQ4ZRrB1LDSNCU3gWdzCQHzcihH/NvzWPEOajdx0UlZidKoe2WPxnAzWf197
         70Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=apSwcHBNbsjMzWMwAM8wLfBeeqE78HEez52v75M+bGE=;
        b=lgfd0sDFIF6al43H8GER1LlmHbgwmvTkN4lKnLC219+CtmaGFo4UmCMZphG/Nu5l0s
         W39IfmrNejY1o2sA7Q+OtLPVfv1eTE8RWz+pAFtsPtlgCRaU0FUlvMQusuwPBQ2eE5lS
         t/0x4pPqnsdQebV69QSPKxfY1Y07n6SIqPqsgTD/pKlTeTn2qdCM4oo7LWtk5DMg0O/n
         5TxMk93VR5YlH6iUaKsHGBeP6P968WuO+B7nx/B0MdRiB1VLEdEwjrYAz9JrhYyCeDta
         ku10yzyk1LZl2Ivct7vwcha9ds0B8aXTBng+KMp0+naUPD4ibY9c6zcobhPnRkXU4kqy
         zOdg==
X-Gm-Message-State: AO0yUKXw3p9Pikau/6ha1lvbGxZ5PZOrp0iLEbg0tn+C6gFo6P/fFgxs
        qNot61zp2fagOO9CI+d0Vx2UdW7b09Pzst4GeVFA0D0dFws=
X-Google-Smtp-Source: AK7set+DRqXZHRtcvQXEsX4Vhod/GSQm+BipVh2Ta7T3xnLW1hNcRRL6o9KILwZTPAtXIRd8qfH9qKl440Rhp3RWwxs=
X-Received: by 2002:a17:907:984a:b0:87b:dce7:c245 with SMTP id
 jj10-20020a170907984a00b0087bdce7c245mr1978672ejc.3.1676408256709; Tue, 14
 Feb 2023 12:57:36 -0800 (PST)
MIME-Version: 1.0
References: <20230214043350.3497406-1-joannelkoong@gmail.com>
In-Reply-To: <20230214043350.3497406-1-joannelkoong@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 14 Feb 2023 12:57:25 -0800
Message-ID: <CAADnVQJsrjo7-mbEa1MWG4E53=0QUN8iWzjEjkahzgfzmwP_Cw@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next] bpf: Update kfunc __sz documentation
To:     Joanne Koong <joannelkoong@gmail.com>, Eddy Z <eddyz87@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Kernel Team <kernel-team@fb.com>
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

On Mon, Feb 13, 2023 at 8:35 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>
> A bpf program calling a kfunc with a __sz-annotated arg must explicitly
> initialize the stack themselves if the pointer to the memory region is
> a pointer to the stack. This is because in the verifier, we do not
> explicitly initialize the stack space for reg type PTR_TO_STACK
> kfunc args. Thus, the verifier will reject the program with:
>
> invalid indirect read from stack
> arg#0 arg#1 memory, len pair leads to invalid memory access
>
> Alternatively, the verifier could support initializing the stack
> space on behalf of the program for KF_ARG_PTR_TO_MEM_SIZE args,
> but this has some drawbacks. For example this would not allow the
> verifier to reject a program for passing in an uninitialized
> PTR_TO_STACK for an arg that should have valid data. Another example is
> that since there's no current way in a kfunc to differentiate between
> whether the arg should be treated as uninitialized or not, additional
> check_mem_access calls would need to be called even on PTR_TO_STACKs
> that have been initialized, which is inefficient. Please note
> that non-kfuncs don't have this problem because of the MEM_UNINIT tag;
> only if the arg is tagged as MEM_UNINIT, then do we call
> check_mem_access byte-by-byte for the size of the buffer.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  Documentation/bpf/kfuncs.rst | 35 +++++++++++++++++++++++++++++++----
>  1 file changed, 31 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index ca96ef3f6896..97497a7879d6 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -71,10 +71,37 @@ An example is given below::
>          ...
>          }
>
> -Here, the verifier will treat first argument as a PTR_TO_MEM, and second
> -argument as its size. By default, without __sz annotation, the size of the type
> -of the pointer is used. Without __sz annotation, a kfunc cannot accept a void
> -pointer.
> +Here, the verifier will treat first argument (KF_ARG_PTR_TO_MEM_SIZE) as a
> +pointer to the memory region and second argument as its size. By default,
> +without __sz annotation, the size of the type of the pointer is used. Without
> +__sz annotation, a kfunc cannot accept a void pointer.
> +
> +Please note that if the memory is on the stack, the stack space must be
> +explicitly initialized by the program. For example:
> +
> +.. code-block:: c
> +
> +       SEC("tc")
> +       int prog(struct __sk_buff *skb)
> +       {
> +               char buf[8];
> +
> +               bpf_memzero(buf, sizeof(buf));
> +       ...
> +       }
> +
> +should be
> +
> +.. code-block:: c
> +
> +       SEC("tc")
> +       int prog(struct __sk_buff *skb)
> +       {
> +               char buf[8] = {};
> +
> +               bpf_memzero(buf, sizeof(buf));

Actually we might go the other way.
Instead of asking users to explicitly init things
we will allow uninit memory.
See this discussion:
https://lore.kernel.org/bpf/082fd8451321a832f334882a1872b5cee240d811.camel@gmail.com/

Eduard, is about to send those verifier patches.

In parallel we can relax __sz to accept uninit under allow_uninit_stack.
