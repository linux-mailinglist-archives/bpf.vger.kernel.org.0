Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000D1584531
	for <lists+bpf@lfdr.de>; Thu, 28 Jul 2022 19:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbiG1Rpq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jul 2022 13:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbiG1Rpp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jul 2022 13:45:45 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5917C747A0
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 10:45:44 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id i4so1912709qvv.7
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 10:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4YySPFG5yKinyJPkDE2/KbW+qtEPhhbeRNXS+rrBbeM=;
        b=cA4CFpe47ya3kt7jjywM3AexJbRZMmFGJmc1vc0UPw1wsOuurm6zvZ+lFfkWLO2jeC
         57+7y0pZSCfqNAsN+pRmPDglLJ+qAkwLw05O0TNB7DpVJKgavtFLuQF4kLPaQFwHZ82s
         cB5ui4oKUVmADvRwxaRmzyf+NMjSMNZHTT5zxLNxM/8UJR+2Mm+IwpxTO2gJzMNuMDdU
         vyof7WMPGKB6NDTqBszJ9jGs1zyeNFrj3KJQx2rmARtDR+macTux+W7eYtLxIE5L+4rR
         swVZdgcjL1zFyb4O2r7QNzp/NgVIAIFbd6E9qRA+Z4sdfxiMBWg93ZtklKabrfjz3hDK
         QyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4YySPFG5yKinyJPkDE2/KbW+qtEPhhbeRNXS+rrBbeM=;
        b=cKbTwrh3YuXUWEWPKMhOBkeWAsIIKslK+cSwRmprViNue+JeYw5I1+lFdj8DArI4SK
         zELFpims2F0zzOaai4z/WxBRW0zG4281v+N2GP013Ci1fjzS4QQlbDMgJagpnB7/KzIK
         M3DK72I1H8R7lVeHVAA0aE9I0V2R6z/f9Y5IJwKtrE0jKkTocEBvtRLdYRYU1jB/5UOk
         e7pONDo01JBDOt9Tg7V/yG7ObRgLXGo/+bnfRpECs3xHphLruSiyRE6L76BU3Vnb0rch
         9S58K1GGdHtngMVaT2UVozs1ikJ1T6f5aw7kUN8zucpZaEW7aJdNsGErMKgNoZC0M+lB
         prkA==
X-Gm-Message-State: AJIora9/t+BW1897YvanVTRgxy/1OGjLuRB7v/Ike8ddccjmvTZyGWp1
        lhkv3vbonNDlHJB0QkvuO8puCBqzBy2JJIMBGx2sYQ==
X-Google-Smtp-Source: AGRyM1tfpD8FVNGOZoLnBT0h/yDQsPFQwzMWDlKG8AmyQnVeaV5qoCzdxmdIIka7hltIVG6N0xf8tP15qg5OAjMdXUQ=
X-Received: by 2002:a05:6214:20a5:b0:474:6a76:1ccd with SMTP id
 5-20020a05621420a500b004746a761ccdmr12494776qvd.44.1659030343305; Thu, 28 Jul
 2022 10:45:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220726184706.954822-1-joannelkoong@gmail.com> <20220726184706.954822-2-joannelkoong@gmail.com>
In-Reply-To: <20220726184706.954822-2-joannelkoong@gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 28 Jul 2022 10:45:32 -0700
Message-ID: <CA+khW7jBsY+N798Rgu5KoHW49zC_MN66LQE++mqn12HJ2hfHqQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Add skb dynptrs
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Joanne,

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
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 20c26aed7896..7fbd4324c848 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -407,11 +407,14 @@ enum bpf_type_flag {
>         /* Size is known at compile time. */
>         MEM_FIXED_SIZE          = BIT(10 + BPF_BASE_TYPE_BITS),
>
> +       /* DYNPTR points to sk_buff */
> +       DYNPTR_TYPE_SKB         = BIT(11 + BPF_BASE_TYPE_BITS),
> +
>         __BPF_TYPE_FLAG_MAX,
>         __BPF_TYPE_LAST_FLAG    = __BPF_TYPE_FLAG_MAX - 1,
>  };
>
> -#define DYNPTR_TYPE_FLAG_MASK  (DYNPTR_TYPE_LOCAL | DYNPTR_TYPE_RINGBUF)
> +#define DYNPTR_TYPE_FLAG_MASK  (DYNPTR_TYPE_LOCAL | DYNPTR_TYPE_RINGBUF | DYNPTR_TYPE_SKB)
>

I wonder if we could maximize the use of these flags by combining them
with other base types, not just DYNPTR. For example, does TYPE_LOCAL
indicate memory is on stack? If so, can we apply LOCAL on PTR_TO_MEM?
If we have PTR_TO_MEM + LOCAL, can it be used to replace PTR_TO_STACK
in some scenarios?

WDYT?

>  /* Max number of base types. */
>  #define BPF_BASE_TYPE_LIMIT    (1UL << BPF_BASE_TYPE_BITS)
> @@ -2556,12 +2559,15 @@ enum bpf_dynptr_type {
>         BPF_DYNPTR_TYPE_LOCAL,
>         /* Underlying data is a ringbuf record */
>         BPF_DYNPTR_TYPE_RINGBUF,
> +       /* Underlying data is a sk_buff */
> +       BPF_DYNPTR_TYPE_SKB,
>  };
>
<...>
>
>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> --
> 2.30.2
>
