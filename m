Return-Path: <bpf+bounces-3863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D5574596F
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 11:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E8BF1C208FB
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 09:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218E44431;
	Mon,  3 Jul 2023 09:57:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E095E1FDA
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 09:57:37 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561A810F2
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 02:57:35 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51d804c7d14so4773011a12.3
        for <bpf@vger.kernel.org>; Mon, 03 Jul 2023 02:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688378254; x=1690970254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M45z07O3hHoHAGcB6lIP4valT6fq8gen3lBb2oN7lCY=;
        b=gmR8vcTKMQ5SYSmqOGiQnOycwHRgw9SBgWT23205ODgFFnQsmAIw3P+J9s6EzqH/EC
         JNlne7MiIBZsn633QhivnEd3zG9Eja5QBnx2sMp/JB62mhdvc2ZOM/akekC1IGFRbolR
         iQDy/X2m40nCISOub6GFvn7qB5F67PS/zVWWPINmxc96tBnUZ69vgPCNDXxIzG3qcVeX
         vgtO/Bdm0yF9M+c+ubOglknHlq4i7wdIWQVkcxgLwbQCspCSThHag6pTMepiq1caED8+
         eca8TWbmlEY1G2Za09PJ6MQL5u7tG2rTfpsZ1Y/xV7DU7PjvQ8lyGmavYiiWa7PmXDUg
         npCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688378254; x=1690970254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M45z07O3hHoHAGcB6lIP4valT6fq8gen3lBb2oN7lCY=;
        b=aWc7n64jTe2A75D+Ly2xcozrS0A2m947q3JUnjnSAemN5zbwrDwsLyj0APHd9UwvAo
         SO5FjqTEuS4NnGoNqnTU2S+n30/u3VvZTZh4J2utGm0xaIvQSDwpyPYwVOGJe8qnZvVn
         B1mPweZS2FpRX4h89B/K8bqRiKAO1YB7gGdBm9/zd+JSMRxasuxSJz4tEgWMXi7U/PUF
         LX8ezE6hl4JlK+nX60CwuiLDoUpNHerc7y6sIwrF4Ndd0gx9/nk9EIBXIiYYf+2TvRPU
         3/AYQyHVeBnZnkhyu6RyzO62vX1QqKc/D3WQQ8gxmgY51ACP5kqoIoxddyIP1WeaH0y1
         cjpw==
X-Gm-Message-State: ABy/qLbmHxlrtc+BcVmmKK7PaCbgJejz52QpE5XACWEPz+Et9mHyOfyo
	ZPWU2PV0pI6Z8KlsRAeFPlOEiWqQsUBrIRy72G1jAA==
X-Google-Smtp-Source: APBJJlHJK06Lj4XGRl/BmnIuL51u84nWGWAcTxetG3hpLSZLo2p45TqXsSjUJOOMoVIun1qSvw3W6YSWFc18YGtkNnM=
X-Received: by 2002:aa7:d68f:0:b0:51d:e4dc:7176 with SMTP id
 d15-20020aa7d68f000000b0051de4dc7176mr6794062edr.20.1688378253785; Mon, 03
 Jul 2023 02:57:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230613-so-reuseport-v4-6-4ece76708bba@isovalent.com> <20230628185352.76923-1-kuniyu@amazon.com>
In-Reply-To: <20230628185352.76923-1-kuniyu@amazon.com>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Mon, 3 Jul 2023 10:57:23 +0100
Message-ID: <CAN+4W8hLXYZuNFG+=J-FWLXWhbwT5TrHjMg5VzjQhv2NBo5VaA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 6/7] bpf, net: Support SO_REUSEPORT sockets
 with bpf_sk_assign
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, haoluo@google.com, hemanthmalla@gmail.com, joe@cilium.io, 
	joe@wand.net.nz, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, martin.lau@linux.dev, mykolal@fb.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, sdf@google.com, shuah@kernel.org, 
	song@kernel.org, willemdebruijn.kernel@gmail.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 28, 2023 at 7:54=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:

> > +     reuse_sk =3D inet6_lookup_reuseport(net, sk, skb, doff,
> > +                                       saddr, sport, daddr, ntohs(dpor=
t),
> > +                                       ehashfn);
> > +     if (!reuse_sk || reuse_sk =3D=3D sk)
> > +             return sk;
> > +
> > +     /* We've chosen a new reuseport sock which is never refcounted. T=
his
> > +      * implies that sk also isn't refcounted.
> > +      */
> > +     WARN_ON_ONCE(*refcounted);
>
> One more nit.
>
> WARN_ON_ONCE() should be tested before inet6?_lookup_reuseport() not to
> miss the !reuse_sk case.

I was just pondering that as well, but I came to the opposite
conclusion. In the !reuse_sk case we don't really know anything about
sk, except that it isn't part of a reuseport group. How can we be sure
that it's not refcounted?

