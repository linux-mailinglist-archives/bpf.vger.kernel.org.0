Return-Path: <bpf+bounces-7348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0ECD775E51
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 13:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DD6A1C211CF
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 11:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F15A18011;
	Wed,  9 Aug 2023 11:59:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F7811C98;
	Wed,  9 Aug 2023 11:59:36 +0000 (UTC)
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E967F1729;
	Wed,  9 Aug 2023 04:59:35 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id 006d021491bc7-56c711a88e8so4570653eaf.2;
        Wed, 09 Aug 2023 04:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691582375; x=1692187175;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4jcNuI0RwG4Oe2k8CS0Amzmn54vlJQH2irgVBpw5cvQ=;
        b=rlrCYjW0lciQ7bUPICkiTmi6YRlotO03Drrkm96ynbFst6Jl1rqX3gl+hwmslyiGgQ
         +7FtoVS+Vps2vOUveYgO6zjwy4/hmwv1HjDGiegO9KHCW6L0NrOVMC4feXPpypW88/Uc
         uaQA+MnU5fPoiRg4AceXfuPvmIWKnxD5qmizNNJcBbVytuu23kShNLRVLu2ieiMlhHkF
         cTG0PHTtIq70dQweFGOz2MqfSqw7Kiw826tDP5EyW66QvfJ2w+6SugZgxfYNF0r55DMm
         0GDIyby8Nk6aklBtqY4Jy03wwTDXghj346L9V9e43lmo0hRolW1lCYdClzOi0dmSsBQ/
         r46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691582375; x=1692187175;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4jcNuI0RwG4Oe2k8CS0Amzmn54vlJQH2irgVBpw5cvQ=;
        b=bfPeXEZTD3+tJUU0owBsI7WHpSo5KsLEkqnjZg53dgHmHqLovQRcJa9xJXiuPHACsM
         bvpWfvS6WnFHi1+uYZIOM3TsphkRKKTQUedAOHUR81VHW5AsT5u/Kg3kiOPUdOJIEYD2
         +HaMTxh0FV4J8MsyWIv/A8UNxqzMdoV6L56oTeZkXUcBYGphxgXr05BAjoVlExOh7V9x
         Y81O5cooQwJtSBiCBFfYM1HQSjE9ZErrt21MrqXvns8rJisAwPkcjJ8ZuDHk/FvNXfaA
         qQUwkInqXWOFP3S6b1MC4McLdnBjXe5mhBxb6xOOXXas+ycRPdzi0pCzKX7gFwV7pqTu
         s1QQ==
X-Gm-Message-State: AOJu0YzARtv74NFXCB2tgNPQgQGZkorLjn0JvR1mYRuwSec4x4/3Ye3o
	bMv2Xl5zcrC2Nr0CRyCArTNYfTzUHEuaJJmv6aU=
X-Google-Smtp-Source: AGHT+IE9bbZrZ0Q2Uem5+a9vsYtvTn16PS27QsVfCx4uF0e1WzbCijxQ7LLjK6SVHFdD329PnZp3Q1SlmeJWzCp0HR8=
X-Received: by 2002:a05:6808:2105:b0:3a7:3ab9:e590 with SMTP id
 r5-20020a056808210500b003a73ab9e590mr3389626oiw.9.1691582375168; Wed, 09 Aug
 2023 04:59:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230809-bpf-next-v1-1-c1b80712e83b@isovalent.com>
In-Reply-To: <20230809-bpf-next-v1-1-c1b80712e83b@isovalent.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 9 Aug 2023 17:28:57 +0530
Message-ID: <CAP01T74YAkdqNirpc4sCCnK_nwWpYJNcuM94xWDnbHY_Be6o=A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] net: Fix slab-out-of-bounds in inet[6]_steal_sock
To: Lorenz Bauer <lmb@isovalent.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 9 Aug 2023 at 14:04, Lorenz Bauer <lmb@isovalent.com> wrote:
>
> Kumar reported a KASAN splat in tcp_v6_rcv:
>
>   bash-5.2# ./test_progs -t btf_skc_cls_ingress
>   ...
>   [   51.810085] BUG: KASAN: slab-out-of-bounds in tcp_v6_rcv+0x2d7d/0x3440
>   [   51.810458] Read of size 2 at addr ffff8881053f038c by task test_progs/226
>
> The problem is that inet[6]_steal_sock accesses sk->sk_protocol without
> accounting for request sockets. I added the check to ensure that we only
> every try to perform a reuseport lookup on a supported socket.
>
> It turns out that this isn't necessary at all. struct sock_common contains
> a skc_reuseport flag which indicates whether a socket is part of a
> reuseport group. inet[6]_lookup_reuseport already check this flag,
> so we can't execute an erroneous reuseport lookup by definition.
>
> Remove the unnecessary assertions to fix the out of bounds access.
>
> Fixes: 9c02bec95954 ("bpf, net: Support SO_REUSEPORT sockets with bpf_sk_assign")
> Reported-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
> ---

Thanks for the fix!
Tested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

