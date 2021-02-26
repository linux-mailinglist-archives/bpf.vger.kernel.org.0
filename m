Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE721326766
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 20:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbhBZTXo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 14:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhBZTXn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Feb 2021 14:23:43 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F5EC061574
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 11:23:03 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id m9so9972528ybk.8
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 11:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2eI5OE8+643Ou4khkNqGjU08a+DB9+G2JPSwNYxRqWY=;
        b=hUFMcJGDasIkbEh42/DaBbtz4qqKwgvD4ptR3U5F+MGiCPuZ2d+uBTmqzMp024HNRk
         EU6roxfNcUwhs1YU41Hde0hl6eCIxn+HREwDTc4cD9jNXE1uxhSaYwLOZiSyPsG70Pu1
         2Y7TLD8C4bu0zWs48raGFawFUIssdVtpm7OXDLKCneh3DLXsuytHEjgEZUm6CCoaJOTe
         VcWdppZYJPoYG04vpUsbr8kEnCFS7TTMqq2MRiH0iZNs+r4w9gabmdIAze72SRT7R7vn
         bPWHFmx9Iqy1IQo/JxfsgE3cwh1yxRSwaEntr5ia5jsEb1tS1Kk50w9T81x+0qcZQkyy
         Fosg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2eI5OE8+643Ou4khkNqGjU08a+DB9+G2JPSwNYxRqWY=;
        b=pGy+FmetlJu4W3e8ypkD3mkjfmmOjn4DtpDdfDsLlDMLaDZLv72nwkUUScTCkD9wfc
         N4c35YCbvaj7vM2j52q+zbckuDL2T6fleceWmu0Q7+vko1C+NuQFDgGNuwNILWDYOFhW
         xGcBfkEoapN9Sk101ST+c5GJubbPzyLRKXk7plBYza1gDJaMcb0adNspmTsUdX797nmI
         LykksBRvLQ+Efd2IUpCXX3pmlxxEP8lgNEDASdD5OIFq4AVRXRSXq7gLyu//Tp91DJgW
         7opuj56Vp98IxFapqfU7SShS+2afwHympKYTEbhu5A1Ksn5OtIwa5+wcYmfkna+4833z
         5+3Q==
X-Gm-Message-State: AOAM530spF6UNkOaONZ0m2otBHnfaBGXSIDFhGSba/AXHuV02aMFtCsj
        vn1pV61QSiinncQPej2P/xqTyBhM8+2K0153O8M=
X-Google-Smtp-Source: ABdhPJwmhkaCYkhjsM0eKsp6Zuj40ahzZAy8fQ+JQ7SCztTyBU0rIj/OXzn1f3VJj98Ycm1j6WQcr/RGJdl51Kg3U/Q=
X-Received: by 2002:a25:3d46:: with SMTP id k67mr6410731yba.510.1614367382464;
 Fri, 26 Feb 2021 11:23:02 -0800 (PST)
MIME-Version: 1.0
References: <20210226051305.3428235-1-yhs@fb.com> <20210226051310.3428705-1-yhs@fb.com>
In-Reply-To: <20210226051310.3428705-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 26 Feb 2021 11:22:51 -0800
Message-ID: <CAEf4Bza-EJ=AB0eMQLGomdmQNnN_PccaeoMk9HBmWaGfkh7enA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 05/12] bpf: add bpf_for_each_map_elem() helper
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 25, 2021 at 9:13 PM Yonghong Song <yhs@fb.com> wrote:
>
> The bpf_for_each_map_elem() helper is introduced which
> iterates all map elements with a callback function. The
> helper signature looks like
>   long bpf_for_each_map_elem(map, callback_fn, callback_ctx, flags)
> and for each map element, the callback_fn will be called. For example,
> like hashmap, the callback signature may look like
>   long callback_fn(map, key, val, callback_ctx)
>
> There are two known use cases for this. One is from upstream ([1]) where
> a for_each_map_elem helper may help implement a timeout mechanism
> in a more generic way. Another is from our internal discussion
> for a firewall use case where a map contains all the rules. The packet
> data can be compared to all these rules to decide allow or deny
> the packet.
>
> For array maps, users can already use a bounded loop to traverse
> elements. Using this helper can avoid using bounded loop. For other
> type of maps (e.g., hash maps) where bounded loop is hard or
> impossible to use, this helper provides a convenient way to
> operate on all elements.
>
> For callback_fn, besides map and map element, a callback_ctx,
> allocated on caller stack, is also passed to the callback
> function. This callback_ctx argument can provide additional
> input and allow to write to caller stack for output.
>
> If the callback_fn returns 0, the helper will iterate through next
> element if available. If the callback_fn returns 1, the helper
> will stop iterating and returns to the bpf program. Other return
> values are not used for now.
>
> Currently, this helper is only available with jit. It is possible
> to make it work with interpreter with so effort but I leave it
> as the future work.
>
> [1]: https://lore.kernel.org/bpf/20210122205415.113822-1-xiyou.wangcong@gmail.com/
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  include/linux/bpf.h            |  13 +++
>  include/linux/bpf_verifier.h   |   3 +
>  include/uapi/linux/bpf.h       |  39 ++++++-
>  kernel/bpf/bpf_iter.c          |  16 +++
>  kernel/bpf/helpers.c           |   2 +
>  kernel/bpf/verifier.c          | 208 ++++++++++++++++++++++++++++++---
>  kernel/trace/bpf_trace.c       |   2 +
>  tools/include/uapi/linux/bpf.h |  39 ++++++-
>  8 files changed, 307 insertions(+), 15 deletions(-)
>

[...]

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 4c24daa43bac..354aaaee8bd9 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -393,6 +393,15 @@ enum bpf_link_type {
>   *                   is struct/union.
>   */
>  #define BPF_PSEUDO_BTF_ID      3
> +/* insn[0].src_reg:  BPF_PSEUDO_FUNC
> + * insn[0].imm:      insn offset to the func
> + * insn[1].imm:      0
> + * insn[0].off:      0
> + * insn[1].off:      0
> + * ldimm64 rewrite:  address of the function
> + * verifier type:    PTR_TO_FUNC.
> + */
> +#define BPF_PSEUDO_FUNC                4
>
>  /* when bpf_call->src_reg == BPF_PSEUDO_CALL, bpf_call->imm == pc-relative
>   * offset to another bpf function
> @@ -3850,7 +3859,6 @@ union bpf_attr {
>   *
>   * long bpf_check_mtu(void *ctx, u32 ifindex, u32 *mtu_len, s32 len_diff, u64 flags)
>   *     Description
> -

BTW, this was fixed in a7c9c25a99bb ("bpf: Remove blank line in bpf
helper description comment") and applied to the bpf tree. Not sure if
it will cause a merge conflict later. Maybe Alexei or Daniel can just
add this line back while applying?

>   *             Check ctx packet size against exceeding MTU of net device (based
>   *             on *ifindex*).  This helper will likely be used in combination
>   *             with helpers that adjust/change the packet size.
> @@ -3910,6 +3918,34 @@ union bpf_attr {
>   *             * **BPF_MTU_CHK_RET_FRAG_NEEDED**
>   *             * **BPF_MTU_CHK_RET_SEGS_TOOBIG**
>   *

[...]
