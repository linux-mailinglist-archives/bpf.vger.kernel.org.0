Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764755873C7
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 00:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbiHAWLv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 18:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbiHAWLu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 18:11:50 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9DC1CB
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 15:11:49 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id m8so15439248edd.9
        for <bpf@vger.kernel.org>; Mon, 01 Aug 2022 15:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=UHsbDfCilGs4Wr28fYfVMYAzIZZsm5fdc9QkNBdnGuw=;
        b=JhBhtBGKaDcZ2ywR5C2u7NGlCcH7JfprQp6E9V9de0TadA5RWYPh6Az6RQhCFPK9tA
         Lz3pX1EWUdRYXo36hHqsthsxOy/XrFBiLCMJzqqjpVki8N6g2IWycQzLBW5C5zgH8WGS
         Z1PV0+sLETk+DAkNwvk+g2u12DQq9g3KdQK9Z9fF3BjdYn0F5ambu7qskBXG5hLgwjic
         DU1lmEVX0ZY7pA5Nj7GTcecja8AxIYeNgxZta7/MhzRVGPe4nSUnayTGdaFb5Q4JskYf
         1HmFDr7w5IdvCtNI8KQcaRlrFgKv1ZYQzeOCxHPVjMNkGzolRi3dFSZsRMpG8dzrvFJU
         dy7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=UHsbDfCilGs4Wr28fYfVMYAzIZZsm5fdc9QkNBdnGuw=;
        b=JvdPZggdLQQBO++jyiBM4ShotuUS9OrdVlkjV0mbzaO3K43bIwxSaGesT/YflPcCWI
         Eq5v3VYb2P635AISqE3a8UZWo3LIkUnDAtFREZZ5drUWs+ahUvEy7Fy7y8q1qIMptwVD
         s1G9ScrE4ZOGIN/QlN+w3gEJNXzkZRqc1b6Z68RXZSNGD91XnSBi72GZlUDvoz6D2if6
         BC2keitClv1ym+7iITLgKBkyQDD4+6t812LwWeA4kRpBeeJiygKwZ6xJ0EH/7CT/MDIR
         G6Z78H2iGJT3RyRoT4K7UNEWtcmlvkwuZ/xq0a9TuA81JaJxdyaiWJENnqtaV240vfSy
         mEKA==
X-Gm-Message-State: AJIora9+hL2WPf28doRpICqLXjV9p7DXn8fPdrwF1yuEgjrPPHMMbHo2
        RKHzAM64pi5v189SapfMjrMMqGkpi5lQWLEN4hE=
X-Google-Smtp-Source: AGRyM1vDe1LignwMTERDVwstXt4BV9FwlrqQqP7Mw5zvPrzfWDZXC6zNAKQi0WkfIeHSuTum0Zi9+WixnR15vM6FaFo=
X-Received: by 2002:a05:6402:28cb:b0:43b:c6d7:ef92 with SMTP id
 ef11-20020a05640228cb00b0043bc6d7ef92mr17921600edb.333.1659391908264; Mon, 01
 Aug 2022 15:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220726184706.954822-1-joannelkoong@gmail.com> <20220726184706.954822-2-joannelkoong@gmail.com>
In-Reply-To: <20220726184706.954822-2-joannelkoong@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 1 Aug 2022 15:11:36 -0700
Message-ID: <CAEf4BzbDbve0ouE3FVFf+uoYH6b84FrWGHF1xmjmwsmzLAjPaQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Add skb dynptrs
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        ast@kernel.org
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

On Tue, Jul 26, 2022 at 11:48 AM Joanne Koong <joannelkoong@gmail.com> wrote:
>
> Add skb dynptrs, which are dynptrs whose underlying pointer points
> to a skb. The dynptr acts on skb data. skb dynptrs have two main
> benefits. One is that they allow operations on sizes that are not
> statically known at compile-time (eg variable-sized accesses).
> Another is that parsing the packet data through dynptrs (instead of
> through direct access of skb->data and skb->data_end) can be more
> ergonomic and less brittle (eg does not need manual if checking for
> being within bounds of data_end).
>
> For bpf prog types that don't support writes on skb data, the dynptr is
> read-only (writes and data slices are not permitted). For reads on the
> dynptr, this includes reading into data in the non-linear paged buffers
> but for writes and data slices, if the data is in a paged buffer, the
> user must first call bpf_skb_pull_data to pull the data into the linear
> portion.
>
> Additionally, any helper calls that change the underlying packet buffer
> (eg bpf_skb_pull_data) invalidates any data slices of the associated
> dynptr.
>
> Right now, skb dynptrs can only be constructed from skbs that are
> the bpf program context - as such, there does not need to be any
> reference tracking or release on skb dynptrs.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  include/linux/bpf.h            |  8 ++++-
>  include/linux/filter.h         |  4 +++
>  include/uapi/linux/bpf.h       | 42 ++++++++++++++++++++++++--
>  kernel/bpf/helpers.c           | 54 +++++++++++++++++++++++++++++++++-
>  kernel/bpf/verifier.c          | 43 +++++++++++++++++++++++----
>  net/core/filter.c              | 53 ++++++++++++++++++++++++++++++---
>  tools/include/uapi/linux/bpf.h | 42 ++++++++++++++++++++++++--
>  7 files changed, 229 insertions(+), 17 deletions(-)
>

[...]

> +       type = bpf_dynptr_get_type(dst);
> +
> +       if (flags) {
> +               if (type == BPF_DYNPTR_TYPE_SKB) {
> +                       if (flags & ~(BPF_F_RECOMPUTE_CSUM | BPF_F_INVALIDATE_HASH))
> +                               return -EINVAL;
> +               } else {
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       if (type == BPF_DYNPTR_TYPE_SKB) {
> +               struct sk_buff *skb = dst->data;
> +
> +               /* if the data is paged, the caller needs to pull it first */
> +               if (dst->offset + offset + len > skb->len - skb->data_len)
> +                       return -EAGAIN;
> +
> +               return __bpf_skb_store_bytes(skb, dst->offset + offset, src, len,
> +                                            flags);
> +       }

It seems like it would be cleaner to have a switch per dynptr type and
each case doing its extra error checking (like CSUM and HASH flags for
TYPE_SKB) and then performing write operation.


memcpy can be either a catch-all default case, or perhaps it's safer
to explicitly list TYPE_LOCAL and TYPE_RINGBUF to do memcpy, and then
default should WARN() and return error?

> +
>         memcpy(dst->data + dst->offset + offset, src, len);
>
>         return 0;
> @@ -1555,6 +1594,7 @@ static const struct bpf_func_proto bpf_dynptr_write_proto = {
>
>  BPF_CALL_3(bpf_dynptr_data, struct bpf_dynptr_kern *, ptr, u32, offset, u32, len)
>  {
> +       enum bpf_dynptr_type type;
>         int err;
>
>         if (!ptr->data)
> @@ -1567,6 +1607,18 @@ BPF_CALL_3(bpf_dynptr_data, struct bpf_dynptr_kern *, ptr, u32, offset, u32, len
>         if (bpf_dynptr_is_rdonly(ptr))
>                 return 0;
>
> +       type = bpf_dynptr_get_type(ptr);
> +
> +       if (type == BPF_DYNPTR_TYPE_SKB) {
> +               struct sk_buff *skb = ptr->data;
> +
> +               /* if the data is paged, the caller needs to pull it first */
> +               if (ptr->offset + offset + len > skb->len - skb->data_len)
> +                       return 0;
> +
> +               return (unsigned long)(skb->data + ptr->offset + offset);
> +       }
> +
>         return (unsigned long)(ptr->data + ptr->offset + offset);

Similarly, all these dynptr helpers effectively dispatch different
implementations based on dynptr type. I think switch is most
appropriate for this.

>  }
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0d523741a543..0838653eeb4e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -263,6 +263,7 @@ struct bpf_call_arg_meta {
>         u32 subprogno;
>         struct bpf_map_value_off_desc *kptr_off_desc;
>         u8 uninit_dynptr_regno;
> +       enum bpf_dynptr_type type;
>  };
>

[...]
