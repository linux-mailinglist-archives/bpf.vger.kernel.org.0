Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246FA6B7DC9
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 17:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjCMQin (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 12:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbjCMQi1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 12:38:27 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85209211EF
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 09:38:09 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id z83so8581876ybb.2
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 09:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678725489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXVCL+FUXjevsSnXExogjehFT5TaSaLvqJy7Moz3lmw=;
        b=G8JNrqDsB+7Mb8BTzjDSH4wSJkqHGLkb1EYmXYIZLmRlgKlwJLWcTZAcln37LifxBA
         GM+LIRREH3fQsw2O0o+RbCPCUqzrZhRm6FUIxV0fraGcNM62H8hIrGx/ZVVXXwlYqXVS
         dz9iV8xfqIShuxvgCX5WmI4PH40Poqu7Q66+BzLATPGfTp1JU94A/IJzLGWaN3KxXI2f
         MSq7tDLIj08Nh10+TwsgxKwJAWRw6+FC0NEHwnoFcYifvq6iilrg4JbthBrDLGB+y0h9
         f0HKW/NQ43wpjNBqRs+iiM6718O4759m3LIyjtn6/7Y/TnKAcJaHq0W+tFzU8gvLgVsD
         Le/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678725489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXVCL+FUXjevsSnXExogjehFT5TaSaLvqJy7Moz3lmw=;
        b=EeJXJo8fT86v7D+11ftE3npeF9XVfArWdDi/xa3rCcWuN/XHvz/CJCZm7U7LY1RgQY
         K0AL/8s9JwtoFKS5UqLRLeWeY/DfWVrulazYZXoIosEJRKgOu4FgCPf/rVUO1tTDxsDE
         hF9y/FCyo5uvN89lJ4tRivcoQWFMvXgTQ15rNS4dHnoNtbKuJDkDNMCGc4n8JfXoR62q
         sHFxLlk1/ePo62qJbTM+qULrys2otHspxGJHYtpc04Qm6QTOFTDUCrH+PtQwXQZIS4P7
         7+gtLjotdhnPVnmU/vLDu/KKZVyBeAM+r7axretQryquinmd7PbU8xOb63TkN5d9kXkh
         Cpaw==
X-Gm-Message-State: AO0yUKX/4eSp3VFOB7LSY2nPRK+6A9tVO1J8aAim7AwxnnYLbBbfz6qz
        NbxAawOP3+UUgGmba7lBPvLDSrGS9i0JMMomIOJTbg==
X-Google-Smtp-Source: AK7set/IQcNZthyx88Mbxzx66TOXfEDevKhd+YrWCFW0+HXybGOYBv2DXDnXATMlxiBLluWLdUbud6Poejw1CGZhlIA=
X-Received: by 2002:a5b:4ca:0:b0:aaf:b6ca:9a30 with SMTP id
 u10-20020a5b04ca000000b00aafb6ca9a30mr21440309ybp.6.1678725488813; Mon, 13
 Mar 2023 09:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1678364612.git.lorenzo@kernel.org> <f20cfdb08d7357b0853d25be3b34ace4408693be.1678364613.git.lorenzo@kernel.org>
 <f5167659-99d7-04a1-2175-60ff1dabae71@tessares.net> <CANn89i+4F0QUqyDTqJ8GWrWvGnTyLTxja2hbL1W_rVdMqqmxaQ@mail.gmail.com>
 <CANn89iL=zQQygGg4mkAG+MES6-CpkYBL5KY+kn4j=hAowexVZw@mail.gmail.com> <ZA9Q7fvuf4oGh9PY@lore-desk>
In-Reply-To: <ZA9Q7fvuf4oGh9PY@lore-desk>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 13 Mar 2023 09:37:57 -0700
Message-ID: <CANn89iJEtCp1jUDkW9e4v0tbB0w8TjFczS0YSJcYDOVBeL5zhA@mail.gmail.com>
Subject: Re: [PATCH net v2 6/8] veth: take into account device reconfiguration
 for xdp_features flag
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
        saeedm@nvidia.com, leon@kernel.org, shayagr@amazon.com,
        akiyano@amazon.com, darinzon@amazon.com, sgoutham@marvell.com,
        lorenzo.bianconi@redhat.com, toke@redhat.com, teknoraver@meta.com,
        ttoukan.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 13, 2023 at 9:36=E2=80=AFAM Lorenzo Bianconi <lorenzo@kernel.or=
g> wrote:
>
> > On Mon, Mar 13, 2023 at 8:50=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Mon, Mar 13, 2023 at 7:15=E2=80=AFAM Matthieu Baerts
> > > <matthieu.baerts@tessares.net> wrote:
> > > >
> > > > Hi Lorenzo,
> > > >
> > > > On 09/03/2023 13:25, Lorenzo Bianconi wrote:
> > > > > Take into account tx/rx queues reconfiguration setting device
> > > > > xdp_features flag. Moreover consider NETIF_F_GRO flag in order to=
 enable
> > > > > ndo_xdp_xmit callback.
> > > > >
> > > > > Fixes: 66c0e13ad236 ("drivers: net: turn on XDP features")
> > > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > >
> > > > Thank you for the modification.
> > > >
> > > > Unfortunately, 'git bisect' just told me this modification is the o=
rigin
> > > > of a new WARN when using veth in a netns:
> > > >
> > > >
> > > > ###################### 8< ######################
> > > >
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > > WARNING: suspicious RCU usage
> > > > 6.3.0-rc1-00144-g064d70527aaa #149 Not tainted
> > > > -----------------------------
> > > > drivers/net/veth.c:1265 suspicious rcu_dereference_check() usage!
> > > >
> > > > other info that might help us debug this:
> > > >
> > >
> > > Same observation here, I am releasing a syzbot report with a repro.
> > >
> > >
> >
> > I guess a fix would be:
> >
>
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

Can you submit a formal fix ?

Thanks.
