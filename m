Return-Path: <bpf+bounces-2688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C84DC732419
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 02:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A64628158A
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 00:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837C0398;
	Fri, 16 Jun 2023 00:09:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571977C
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 00:09:31 +0000 (UTC)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33E018D
	for <bpf@vger.kernel.org>; Thu, 15 Jun 2023 17:09:29 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-54f87d5f1abso166060a12.0
        for <bpf@vger.kernel.org>; Thu, 15 Jun 2023 17:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686874169; x=1689466169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92fQJzfB4RZzAA1tM9wgM08WjhNjZ7Gnu3A68q9wLec=;
        b=vRQoB3UxR6R6UA/EAnuvcOoF6xxSsHAzHPpG7X7Mff88JACQHrqekCKe9W6hY7DUkv
         Pr76NVwCPtKmiRMZhOI9yG0BH2lqb3irohAzmzrpo2/fWmTRA7jnAMO2X0Fs3Scwf0Pz
         Nkl5hsAvbcztqi6+Bg6u5ygLuHKHoNjlv9Qf61OZ+sfWp9icpv26b3DVWwnkuFb9GPoO
         HzlEBM9bEjAAL4UI6nCuPFwEBUSB0+7/bWwabQnMzELUU72OpN7V/UBT4KLGAekRHQ48
         JNCMxstpuvdKIsv28VWvKkbiuDzu5/ep8h1Hc0/aMJ/8v38qlHqU8j6nNcbiVeaOS0fN
         dNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686874169; x=1689466169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92fQJzfB4RZzAA1tM9wgM08WjhNjZ7Gnu3A68q9wLec=;
        b=ceV1QSmI7xbeqtmOM8MM8yP3hh/l6p24znaWShJHa2XhMUCICVp+sRZEklta7lZI8n
         hI9f0Mel08gkQ04RpLvsVwkqSj/W8cYo2RvmuBYnovRja4GT9WBBK5my6qfq2Plef7ga
         QVNkahxUn9eil/QyV60HvhDmVVEU57djDdEyLiaGLigRJ/V4BUgXTVnrXtn7zTA5BBxR
         XBygNC+HgdGV/Pgd2ofyljelfs4zpsDYm/2iXiaWj/ZWL7EbAtp2NHrmqPglY3OvLndb
         +mo83Ol0EtPiBrCJFs5coFHw6ogn2FjCYja9wCipGvI6JK9nOmO1LsETKx8ZlAixpbhR
         nl7Q==
X-Gm-Message-State: AC+VfDx9rJ8JDGMfM12G6H4AUgYG+KzOBk6xvXfxLIPbVmZfKiKQOcpI
	+FK2lS4tzvZkgp/x6fDiHwaOJnHN4NWCAL+UkK/k+g==
X-Google-Smtp-Source: ACHHUZ5fQN13BA5/fwv12kbeIqTw2YcXYX4lelUNUpQiuD32pWxko6O34viDMt0BO2mDgkgD7msMPUskZ/PRrp9bh0Q=
X-Received: by 2002:a17:90a:7bc4:b0:25b:f396:c3bc with SMTP id
 d4-20020a17090a7bc400b0025bf396c3bcmr229965pjl.48.1686874169214; Thu, 15 Jun
 2023 17:09:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230612172307.3923165-1-sdf@google.com> <87cz20xunt.fsf@toke.dk>
In-Reply-To: <87cz20xunt.fsf@toke.dk>
From: Stanislav Fomichev <sdf@google.com>
Date: Thu, 15 Jun 2023 17:09:17 -0700
Message-ID: <CAKH8qBuAUems8a7kKJPcFvarW2jy4qTf4sAM8oUC8UHj-gE=ug@mail.gmail.com>
Subject: Re: [RFC bpf-next 0/7] bpf: netdev TX metadata
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 12, 2023 at 2:01=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@kernel.org> wrote:
>
> Some immediate thoughts after glancing through this:
>
> > --- Use cases ---
> >
> > The goal of this series is to add two new standard-ish places
> > in the transmit path:
> >
> > 1. Right before the packet is transmitted (with access to TX
> >    descriptors)
> > 2. Right after the packet is actually transmitted and we've received th=
e
> >    completion (again, with access to TX completion descriptors)
> >
> > Accessing TX descriptors unlocks the following use-cases:
> >
> > - Setting device hints at TX: XDP/AF_XDP might use these new hooks to
> > use device offloads. The existing case implements TX timestamp.
> > - Observability: global per-netdev hooks can be used for tracing
> > the packets and exploring completion descriptors for all sorts of
> > device errors.
> >
> > Accessing TX descriptors also means that the hooks have to be called
> > from the drivers.
> >
> > The hooks are a light-weight alternative to XDP at egress and currently
> > don't provide any packet modification abilities. However, eventually,
> > can expose new kfuncs to operate on the packet (or, rather, the actual
> > descriptors; for performance sake).
>
> dynptr?
>
> > --- UAPI ---
> >
> > The hooks are implemented in a HID-BPF style. Meaning they don't
> > expose any UAPI and are implemented as tracing programs that call
> > a bunch of kfuncs. The attach/detach operation happen via BPF syscall
> > programs. The series expands device-bound infrastructure to tracing
> > programs.
>
> Not a fan of the "attach from BPF syscall program" thing. These are part
> of the XDP data path API, and I think we should expose them as proper
> bpf_link attachments from userspace with introspection etc. But I guess
> the bpf_mprog thing will give us that?
>
> > --- skb vs xdp ---
> >
> > The hooks operate on a new light-weight devtx_frame which contains:
> > - data
> > - len
> > - sinfo
> >
> > This should allow us to have a unified (from BPF POW) place at TX
> > and not be super-taxing (we need to copy 2 pointers + len to the stack
> > for each invocation).
>
> Not sure what I think about this one. At the very least I think we
> should expose xdp->data_meta as well. I'm not sure what the use case for
> accessing skbs is? If that *is* indeed useful, probably there will also
> end up being a use case for accessing the full skb?

I spent some time looking at data_meta story on AF_XDP TX and it
doesn't look like it's supported (at least in a general way).
You obviously get some data_meta when you do XDP_TX, but if you want
to pass something to the bpf prog when doing TX via the AF_XDP ring,
it gets complicated.
In zerocopy mode, we can probably use XDP_UMEM_UNALIGNED_CHUNK_FLAG
and pass something in the headroom.
If copy-mode, there is no support to do skb_metadata_set.

Probably makes sense to have something like tx_metalen on the xsk? And
skb_metadata_set it in copy more and skip it in zerocopy mode?
Or maybe I'm missing something?

