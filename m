Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A170F5A18B1
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 20:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242108AbiHYSUv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 14:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242794AbiHYSUq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 14:20:46 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC5713D47
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 11:20:43 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id d21so21812958eje.3
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 11:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=UUHClXdut6PUeLYHtEq5sGhrLcmtjvbUSatE5PjSGO4=;
        b=k49/DAZZqNuuLFykdCdc9VCBkxooNiWbu96z3K7N5Zfp070UYFUDWAXqB0qfL7leNR
         Ftnv7Hl8SQFvp6FyDvH1tzQho9YlvskNCJGVPgrawc1031c+Jmiqwrp9QBPP08+sAu+K
         HR1nvNJBRnMGpRmoKGNrRq4CND+GvYS7AZ75Jrhd7d8ConZtmmHnOuZAw3B5mttH9X3W
         hMZLtOBsSDAtjOn8MJ15jWb/N2jOjrn9rid3BSDNSXSD7B0xCVMAjhPh94pYQ3ONlJC7
         AXlnVDe9epT4Zwht46oZ722LUTp1VEjcvALsmhskiNGx6C4A5fT4POq/+/dZbElrj4ga
         2zAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=UUHClXdut6PUeLYHtEq5sGhrLcmtjvbUSatE5PjSGO4=;
        b=Q8SGIWVrZ8nTT4A2xoWktl4MOhGMdhH9P5Vg61f/c+IK5yig3llyDSWp8DJqPgCEJN
         /QxZNeR0VcuDDrED1/HIHsvLq1yhELJF35dIoCNFhx+GVe1L5DSR/kN0QUPqu13DEVek
         FZJwNPbVJr2VApu7je3n0aPJMqMP62a7HypGFI5HXCvjKrBISysLRkT2eOWpMboBOPPj
         MvMit1UIXLXu7Wt5lISdt1DO0XDrgfbTefv3DVWBK81tA/bDm/Z/3opHVKlgV21DFcU6
         rAhhkrAy6qe682iLDv15SkZtEKnQ966KH0XuEPEFAU2Bbwsjr+ETb4McS9w/bzvOD73O
         56Gw==
X-Gm-Message-State: ACgBeo3D7c4nGYI4w6AZ/GXKo8mj/6PVZoyRJTei0wflgqUe7taXX7Iw
        8YXmrbPnxUiEJL/LMA30sV8m9is+krrPuZw5/pw=
X-Google-Smtp-Source: AA6agR5Lk0buamG+gVGzCN2OjGWvzfKB3Ys44RIRNC5WeNQPn3K86KjrNk/4G0aIriez3TTJj0EkWuRBrZyIkI2X2ME=
X-Received: by 2002:a17:907:2bdb:b0:73d:d7af:c133 with SMTP id
 gv27-20020a1709072bdb00b0073dd7afc133mr2013527ejc.545.1661451642344; Thu, 25
 Aug 2022 11:20:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220824044117.137658-1-shmulik.ladkani@gmail.com> <20220824044117.137658-3-shmulik.ladkani@gmail.com>
In-Reply-To: <20220824044117.137658-3-shmulik.ladkani@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 25 Aug 2022 11:20:31 -0700
Message-ID: <CAEf4BzZKts8NckT7L-FWBRWJxAgkHEZoR=wjaKBxYpTD_jjyAg@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 2/4] bpf: Support setting variable-length
 tunnel options
To:     Shmulik Ladkani <shmulik@metanetworks.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
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

On Tue, Aug 23, 2022 at 9:41 PM Shmulik Ladkani
<shmulik@metanetworks.com> wrote:
>
> Existing 'bpf_skb_set_tunnel_opt' allows setting tunnel options given
> an option buffer (ARG_PTR_TO_MEM) and the compile-time fixed buffer
> size (ARG_CONST_SIZE).
>
> However, in certain cases we wish to set tunnel options of dynamic
> length.
>
> For example, we have an ebpf program that gets geneve options on
> incoming packets, stores them into a map (using a key representing
> the incoming flow), and later needs to assign *same* options to
> reply packets (belonging to same flow).
>
> This is currently imposssible without knowing sender's exact geneve
> options length, which unfortunately is dymamic.
>
> Introduce 'bpf_skb_set_tunnel_opt_dynptr'.
>
> This is a variant of 'bpf_skb_set_tunnel_opt' which gets a bpf dynamic
> pointer (ARG_PTR_TO_DYNPTR) parameter 'ptr' whose data points to the
> options buffer, and 'len', the byte length of options data caller wishes
> to copy into ip_tunnnel_info.
> 'len' must never exceed the dynptr's internal size, o/w EINVAL is
> returned.
>
> Signed-off-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
> ---
> v3: Avoid 'inline' for the __bpf_skb_set_tunopt helper function
> v4: change API to be based on bpf_dynptr, suggested by John Fastabend <john.fastabend@gmail.com>
> ---
>  include/uapi/linux/bpf.h       | 12 ++++++++++++
>  net/core/filter.c              | 36 ++++++++++++++++++++++++++++++++--
>  tools/include/uapi/linux/bpf.h | 12 ++++++++++++
>  3 files changed, 58 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 644600dbb114..c7b313e30635 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5367,6 +5367,17 @@ union bpf_attr {
>   *     Return
>   *             Current *ktime*.
>   *
> + * long bpf_skb_set_tunnel_opt_dynptr(struct sk_buff *skb, struct bpf_dynptr *opt, u32 len)

why can't we rely on dynptr's len instead of specifying extra one
here? dynptr is a range of memory, so just specify that you take that
entire range?

And then we'll have (or partially already have) generic dynptr helpers
to adjust internal dynptr offset and len.

> + *     Description
> + *             Set tunnel options metadata for the packet associated to *skb*
> + *             to the variable length *len* bytes of option data pointed to
> + *             by the *opt* dynptr.
> + *
> + *             See also the description of the **bpf_skb_get_tunnel_opt**\ ()
> + *             helper for additional information.
> + *     Return
> + *             0 on success, or a negative error in case of failure.
> + *
>   */

[...]
