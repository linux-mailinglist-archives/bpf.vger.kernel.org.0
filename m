Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64A24CB414
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 02:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiCCAsO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 19:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiCCAsO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 19:48:14 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C484475D
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 16:47:30 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2dc348dab52so4439557b3.6
        for <bpf@vger.kernel.org>; Wed, 02 Mar 2022 16:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6/QocpX/Yx1QPx7+OoGO0cuNtQS2CN33zDaLXn1WZR8=;
        b=Nw+pBrTS23BHanWlPy+y1VHb61+McjM7u2H5SlHBILp2I++sN+SgvVc4jh5/6McqGT
         2L7PDuMn+12oiGUBgZtyKhPNQTzGGkG6BAjaXAiYQKCWVf54sWOU+2n4iU3REKlzFDTd
         kuV6wtDwCby7eZRtd+MAJN4puzHYrvoMRwuHfiO43A/mcorfgkDhpABIatLE00reA4wr
         CzhLyryWU1D0NT/BSe/+90N1ygHA9lFoeLQPyNSuuJ1pC+xyEgQ0Al2liOPuLvE+VEiZ
         TiO22+CoAF99JqGV/u49T2PrKAhEioUvJQhapdazDePGO/2ESS2kq5c+K07oO/axh7KY
         fOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6/QocpX/Yx1QPx7+OoGO0cuNtQS2CN33zDaLXn1WZR8=;
        b=OW8TbybVtUzaqWYi9ZgJSQKz3xU3W9ZbmdY0QRb0Xa6aQraWqXHbIL4pjRcYsfhS4w
         c/XbtPakp5V2ji/emEnyrBpFJCFkFAhNbRqF0b2mJJyKAQWEtyzs4wEFJ0nFoTkTKr1p
         DQtjoSYetgsJ1c/9zQ4txEk1AI/9GzQhWqXfhnhny9qGSZq6r3270g6/n7Q1fTChTJZw
         12NGlI+rjJnAI21+KIBs/UATRN3SfRDOEyLm1TEHfV7F4OkcXVqkglMAHquUONmDhpPG
         oWTsHk4+MFwsW9xww6LuyjkLNNrI+jBoxGQoZN0tFVwDNMeHxzZ7HRRUZq3PMzpxF9/i
         H7dQ==
X-Gm-Message-State: AOAM532EZ66W6EP9gULJSBWkInJjcx+aXLTB6h9UFgJN3nT1YJjJFuDR
        PnugFsGvYRKBLng+k9i4doFheeXa4DdHJKz2GSBfME5mtre8+w==
X-Google-Smtp-Source: ABdhPJzcvVFQxd2mWsSPFtChivE713BfcIbVn8hoXDAkXa7iSw64V6dwye0/b3oPHnJF82hgeQWfTHfcqtxGeYhL/eI=
X-Received: by 2002:a81:75c6:0:b0:2d0:cbf8:e7b3 with SMTP id
 q189-20020a8175c6000000b002d0cbf8e7b3mr32425732ywc.255.1646268448878; Wed, 02
 Mar 2022 16:47:28 -0800 (PST)
MIME-Version: 1.0
References: <20220302195519.3479274-1-kafai@fb.com> <20220302195622.3483941-1-kafai@fb.com>
 <CANn89iKN06bKxjrEeZAmcj0x4tYMwRv-YzdZLWKbCcuTYT+SpQ@mail.gmail.com>
 <20220302223352.txuhu4ielmlxldrg@kafai-mbp> <CANn89i+ZLB8EK2CUC7dnERvcawSAOhpzHpeKSvL0dVfK-fusXg@mail.gmail.com>
 <20220303001901.nuq66ukomfqqkytg@kafai-mbp>
In-Reply-To: <20220303001901.nuq66ukomfqqkytg@kafai-mbp>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 2 Mar 2022 16:47:17 -0800
Message-ID: <CANn89i+Md-tykepszvB-KqebVBYYOOeHSC6NTptNjwk5QkE-zg@mail.gmail.com>
Subject: Re: [PATCH v6 net-next 10/13] net: Postpone skb_clear_delivery_time()
 until knowing the skb is delivered locally
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 2, 2022 at 4:20 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Wed, Mar 02, 2022 at 03:41:59PM -0800, Eric Dumazet wrote:

> > Name was a bit confusing :)
> A few names were attempted in the early version and
> then concluded on delivery_time. :p
>
> >
> > And it seems you have a big opportunity to not call ktime_get_real()
> > when skb->sk is known at this point (early demux)
> > because few sockets actually enable timestamping ?
> iiuc, you are suggesting to also check the skb->sk (if early demux)
> and check for SK_FLAGS_TIMESTAMP.
>
> Without checking skb->sk here, it should not be worse than the
> current ktime_get_real() done in dev.c where it also does not have sk
> available?  netstamp_needed_key should have been enabled as
> long as there is one sk asked for it.

Yes, but typically there is often one active timestamp consumer,
enabling the static key.

This is a corner case anyway, not sure if hosts running VM would have
slow  ktime_get_real()
