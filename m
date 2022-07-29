Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB405856D8
	for <lists+bpf@lfdr.de>; Sat, 30 Jul 2022 00:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239120AbiG2W10 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 18:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiG2W1Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 18:27:25 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4758AB2B;
        Fri, 29 Jul 2022 15:27:24 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id e15so7384298edj.2;
        Fri, 29 Jul 2022 15:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=iVLkBvqvxxQmzM1anS4jAEK5JqYhmqqjCIgQmNoi7rg=;
        b=Q2Fr4ogA0UKbX/4KTDe6Ln4UfSgAt+oVpF7n1I4/L9l6vxMdaPpFof+vfnPSCX77jo
         pY89Eg+oEc+jW9Oz+tm4taoCb1r8OwFyaCffG/1ouprQG3PAugTMXWVv8ppnDun0rKAh
         AVC8JliqTTM8Idxu3kERXCVwa6VJj3AHoQy1SKDH23XQcZV5xCk2nvE6MAhe8XNVrOAC
         ScedkdWaxejc7w/3QxsLs6X84+nwWWMJbxGxZWFE5XkvZNuk262hMRUyhGxknqm1+enL
         DCJ23fXGUMZ+HNFvnBgEjA2gjWip5P2Fw8M/sFAsL4ZfiSbrlcpzhlnj8sVPt3Llxriy
         rw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=iVLkBvqvxxQmzM1anS4jAEK5JqYhmqqjCIgQmNoi7rg=;
        b=xBCDDpgSxxMqsd+i7C0D2/RsGljI379QiNbdpYgs8vDdBnERvcx1XQQehcDH6gwc/h
         5mxAbCSH0U8Yuv6Vi9SRJUGJyUaEVk5b2B8besHhSK1KPl+S+SIZqe4JuBKQmrrk+zJD
         79Jibjq5KwHt1Wu3/m5TovYHtvr16zNm5tUTwt7KyH8TWFiN9ehVqeURmnriEricHtQX
         DdFfhH7uqTjfXg9VfFbHriveOrPjZQYMYkhecEwHr7oYL98/8cJqYYbpijKsXLSEElMk
         uRee9ohYiCrrfkGZZ7e6ioVwmBQmxlVQqre+WMXN0XrBOfvdD+7xrx1/CGjmM9O67uPZ
         FI6w==
X-Gm-Message-State: AJIora/jsIJn+mEMlRv17U+D1LVHTMJFjkjUvkh+mLbbybino6u3VVAx
        S+Sr5hLxpV98yxXLVKIoRSDQtQSmAd5JZ6/PRaRmM6Qedfw=
X-Google-Smtp-Source: AGRyM1tsKByFdoTIvffANQ2Z6isozBuT+TmFj3YqaWCB5qS89G1yoG/RrpMYffg2MydThKPycJF08fv7GCBV1hzvwak=
X-Received: by 2002:a05:6402:1945:b0:43b:d456:daf8 with SMTP id
 f5-20020a056402194500b0043bd456daf8mr5338515edz.81.1659133642700; Fri, 29 Jul
 2022 15:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <2c105a1ff3071796189093c536218e44ea3b1aa0.1659122785.git.dxu@dxuuu.xyz>
In-Reply-To: <2c105a1ff3071796189093c536218e44ea3b1aa0.1659122785.git.dxu@dxuuu.xyz>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 29 Jul 2022 15:27:11 -0700
Message-ID: <CAEf4BzbnQJ0cTU6NsaLSTVs6CB-JTmoXpR_aWRVO-V1GppNPKg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix oudated __bpf_skc_lookup() comment
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Fri, Jul 29, 2022 at 12:47 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> The function returns a pointer now.
>
> Fixes: edbf8c01de5a ("bpf: add skc_lookup_tcp helper")
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---

This was already done in [0] in bpf-next.

  [0] f5be22c64bd6 ("bpf: Fix bpf_skc_lookup comment wrt. return type")


>  net/core/filter.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 5d16d66727fc..866ca05f95e0 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -6463,8 +6463,6 @@ static struct sock *sk_lookup(struct net *net, struct bpf_sock_tuple *tuple,
>
>  /* bpf_skc_lookup performs the core lookup for different types of sockets,
>   * taking a reference on the socket if it doesn't have the flag SOCK_RCU_FREE.
> - * Returns the socket as an 'unsigned long' to simplify the casting in the
> - * callers to satisfy BPF_CALL declarations.
>   */
>  static struct sock *
>  __bpf_skc_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
> --
> 2.37.1
>
