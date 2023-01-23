Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB5C678562
	for <lists+bpf@lfdr.de>; Mon, 23 Jan 2023 19:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjAWS4G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 13:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjAWS4F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 13:56:05 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D01E3A5
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 10:56:04 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 7so9717550pga.1
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 10:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M1y2OVHARQCaTqCOpWZU/C4m9hlMIWAKFwJ3hNXzKA8=;
        b=r6lfxV6Uf75FXpN/wKXCksxkAJtz8GBjNaxbQ7/mbyLTe429IpDtdUayJe+79hYI3l
         lC097QGCBT4F5CShq04QyBM6588Ng0HdOlgOYmiOaXXBHxJv0Pgo9QrYOvz8uONiizoB
         qRCGoz0Nc0FdFRYW2kuGHPPCWp9MokzcZyFghLWDZU9/HW+lpIDyHESspqS8ZHPPNlhN
         1iegqNSGsN5//4E5BL8F47cV/8hnQlhobaYAB9mkDqHjKgFqjEf2K/T7cbLrrmBEd+Jb
         xAij54QcuNPvQJjRinUSPwTPFAJcr64HM8w7QopRkZQ68P2X1HP7ov9/fAxQ3x+Od9vv
         M6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M1y2OVHARQCaTqCOpWZU/C4m9hlMIWAKFwJ3hNXzKA8=;
        b=h1KaKgz73LdkVT1rNLhFiRiqlcGke+gl2VZjVyaWCBHdNbYLe71aBmo7sagMmnb3e3
         KOVIpxI+gayMHgsRVABO+SBRCOJtSgyrGt53u2JAemzSH3BApGXO5mLvXdKSOqUSACCH
         Qxw/F3EQeJooWgbxNue9m5XdF5W3OYKib1Kj3t+mj7moCYGVejjdPN3RzPJ7L87YAqED
         pgBjVqSY0joZD+VTKmvC6mvp4bow2BzOZPs6EldIQjOeUfXieHWfMFVLiOaSOfgem8eU
         KHeFjMFDRPTtlhL1CprN/c6C3mGri2xVwYcItaSE/S0bvblm8UPtaIUP5AM1dv6ORJ41
         HCvg==
X-Gm-Message-State: AFqh2kok20p4ASNufbpgBZm0CVv0/oDLZLlRI0ocVvVIlOEvff+gUrQn
        Ap/aBtbJispv8zwqn+qYmdMpzAjibLiTvSR9OWsQUQ==
X-Google-Smtp-Source: AMrXdXuKPKURk4IyVwVpXhecitHzba9hblaC4FmOoq7Rl5wHtBgQA7X7iD71roc02Gf2njz4wKUwbb0VmU8+H9zPDp0=
X-Received: by 2002:a63:5615:0:b0:49f:4740:291a with SMTP id
 k21-20020a635615000000b0049f4740291amr2015708pgb.197.1674500163652; Mon, 23
 Jan 2023 10:56:03 -0800 (PST)
MIME-Version: 1.0
References: <20230119221536.3349901-1-sdf@google.com> <901e1a7a-bb86-8d62-4bd7-512a1257d3b0@linux.dev>
In-Reply-To: <901e1a7a-bb86-8d62-4bd7-512a1257d3b0@linux.dev>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Mon, 23 Jan 2023 10:55:52 -0800
Message-ID: <CAKH8qBs=1NgpJBNwJg7dZQnSAAGpH4vJj0+=LNWuQamGFerfZw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 00/17] xdp: hints via kfuncs
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org
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

On Mon, Jan 23, 2023 at 10:53 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> On 1/19/23 2:15 PM, Stanislav Fomichev wrote:
> > Please see the first patch in the series for the overall
> > design and use-cases.
> >
> > See the following email from Toke for the per-packet metadata overhead:
> > https://lore.kernel.org/bpf/20221206024554.3826186-1-sdf@google.com/T/#m49d48ea08d525ec88360c7d14c4d34fb0e45e798
> >
> > Recent changes:
> > - Keep new functions in en/xdp.c, do 'extern mlx5_xdp_metadata_ops' (Tariq)
> >
> > - Remove mxbuf pointer and use xsk_buff_to_mxbuf (Tariq)
> >
> > - Clarify xdp_buff vs 'XDP frame' (Jesper)
> >
> > - Explicitly mention that AF_XDP RX descriptor lacks metadata size (Jesper)
> >
> > - Drop libbpf_flags/xdp_flags from selftests and use ifindex instead
> >    of ifname (due to recent xsk.h refactoring)
>
> Applied with the minor changes in the selftests discussed in patch 11 and 17.
> Thanks!

Awesome, thanks! I was gonna resend around Wed, but thank you for
taking care of that!
