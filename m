Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F966622064
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 00:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiKHXiA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 18:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiKHXh6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 18:37:58 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AB8528B1
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 15:37:57 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id s12so15242724edd.5
        for <bpf@vger.kernel.org>; Tue, 08 Nov 2022 15:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4CPutKSfsOlDMCf1dcNQsShFxDZrqyMNUhM3YyMjCRY=;
        b=CpgxHi4upLWbGGwJO8XB7FNP9oryynH/picJLtowGiOiZVKc2Ab+jRl9owkiM4UKPu
         3lkEqjvLZ1TNntylj6syQutwzq5zObLrtnLZPbNS0FVPZuZ0QlJY0e5gUmqC7X4v3wCj
         31Z/PLcLvS+ZPymtqUAeHTGWNH8sFKmF5wKnkZ8q7T+wWOvRJB9h7Ig9mXpKcgpP817J
         3dM4j3E9PCVv747L94jCHp5q81IkmWJOoz75Ph8GijP4qmvtd48b38e8OlH25FmZAcJr
         5vdhzZHUi/0iACTcjQg7zYUqYju33xeAdlN6sfLbtyDUgn++C6E7MGAJUwbo8nardgqY
         x5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4CPutKSfsOlDMCf1dcNQsShFxDZrqyMNUhM3YyMjCRY=;
        b=j7L3cHU7WSqPnc9XZE8o9yZHCSGz4nJWrkjLJOphvhXFWbWk7RMPftyvDxidzjbjSB
         bUgkVWHnFU+BD4XPqipRakBAW8uYBqJYuAo36Cr3KLoYBvghL07aJZlih1fy1VX3ftaq
         7RKxG5BY/H7KB4mqALBqVfgqt6KZ9ngtrgK7nNYj41ZCTyKZ1xzTsHqYCvAEsLMP9smX
         9itr4cnWKqR18ED7DsD3BRYP08m/1OMsxnq2gIID9woFvY3p80S9axGP9z+ujUm6cwnC
         jUrqzgBn03eWaN3Qc5kcrt3KEgEi61lj5YzF41TsCo9pUabnAoMTq7b3v1y8A5O+a/7I
         DljA==
X-Gm-Message-State: ACrzQf3meBRcEV4JsI+2yascVdpKGnRPC2mZNFcAcnxqTfHZVCHjgaMf
        DDok7NN4iqE5uGeNVst8w1I61JVG48K598HJP2Y=
X-Google-Smtp-Source: AMsMyM7MPGe0oXlvbAQPGIfPajG7OpHBKXHKKxWHFc2TZRGXNuvhbS4wmHs3V9L2gmnL67Fn/qlAWojPRftTaDCYLOA=
X-Received: by 2002:aa7:c2ca:0:b0:461:89a6:2281 with SMTP id
 m10-20020aa7c2ca000000b0046189a62281mr59948475edp.260.1667950676561; Tue, 08
 Nov 2022 15:37:56 -0800 (PST)
MIME-Version: 1.0
References: <20221107230950.7117-1-memxor@gmail.com> <20221107230950.7117-11-memxor@gmail.com>
In-Reply-To: <20221107230950.7117-11-memxor@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 8 Nov 2022 15:37:44 -0800
Message-ID: <CAEf4BzaSLudM-uii61Xe3CVYhG+RXB_BiYDDZtAe5Or5ipoo9Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 10/25] bpf: Allow locking bpf_spin_lock global variables
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
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

On Mon, Nov 7, 2022 at 3:10 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> Global variables reside in maps accessible using direct_value_addr
> callbacks, so giving each load instruction's rewrite a unique reg->id
> disallows us from holding locks which are global.
>
> The reason for preserving reg->id as a unique value for registers that
> may point to spin lock is that two separate lookups are treated as two
> separate memory regions, and any possible aliasing is ignored for the
> purposes of spin lock correctness.
>
> This is not great especially for the global variable case, which are
> served from maps that have max_entries == 1, i.e. they always lead to
> map values pointing into the same map value.
>
> So refactor the active_spin_lock into a 'active_lock' structure which
> represents the lock identity, and instead of the reg->id, remember two
> fields, a pointer and the reg->id. The pointer will store reg->map_ptr
> or reg->btf. It's only necessary to distinguish for the id == 0 case of
> global variables, but always setting the pointer to a non-NULL value and
> using the pointer to check whether the lock is held simplifies code in
> the verifier.
>
> This is generic enough to allow it for global variables, map lookups,
> and local kptr registers at the same time.
>
> Note that while whether a lock is held can be answered by just comparing
> active_lock.ptr to NULL, to determine whether the register is pointing
> to the same held lock requires comparing _both_ ptr and id.
>
> Finally, as a result of this refactoring, pseudo load instructions are
> not given a unique reg->id, as they are doing lookup for the same map
> value (max_entries is never greater than 1).
>
> Essentially, we consider that the tuple of (ptr, id) will always be
> unique for any kind of argument to bpf_spin_{lock,unlock}.
>
> Note that this can be extended in the future to also remember offset
> used for locking, so that we can introduce multiple bpf_spin_lock fields
> in the same allocation.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf_verifier.h |  5 ++++-
>  kernel/bpf/verifier.c        | 41 ++++++++++++++++++++++++------------
>  2 files changed, 32 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 1a32baa78ce2..70cccac62a15 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -323,7 +323,10 @@ struct bpf_verifier_state {
>         u32 branches;
>         u32 insn_idx;
>         u32 curframe;
> -       u32 active_spin_lock;
> +       struct {
> +               void *ptr;

document that this could be either struct bpf_map or struct btf
pointer, at least?

> +               u32 id;
> +       } active_lock;
>         bool speculative;
>
>         /* first and last insn idx of this verifier state */

[...]
