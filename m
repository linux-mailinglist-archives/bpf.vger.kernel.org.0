Return-Path: <bpf+bounces-3915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A5A746262
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 20:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDFFC280EB6
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 18:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F8E111B6;
	Mon,  3 Jul 2023 18:30:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A4C11C81;
	Mon,  3 Jul 2023 18:30:48 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1C2121;
	Mon,  3 Jul 2023 11:30:46 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-666ed230c81so3957179b3a.0;
        Mon, 03 Jul 2023 11:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688409046; x=1691001046;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=He8NzzwPdZ+gUI1RQp1DpiIr7HCamoUjJWEecs32J0I=;
        b=bBki6F9z+TUiBrWD0lPlrunTOOlReNa1f1RLmEmcy8bvfNWTUn0VdGIWd03CeyDCKu
         RsGxQlsw9l+8vgRRTZnYDCUdVWnQfmHvRsHf5jI3yQ7xce0kMf5+D1Gjk7J7FUFX66wD
         prITRwlufgaNH7jYZSUWHa1NYjb1HmMs4LBYEs1GbN6uohMy9ExppFgxlxX8eJwgGPUL
         ecPs6HpRP0FrECD0OXooulVyD4j+qfxDq6jkI3fuDTChMKUfV75DYJGwU4ux4r9hNxNq
         lsBQ67Hp5SYuiYDL8LYN+vWmqqFWDyAGlT0oGB4+3HHGv7/0JiP0fIV1VOGAcDnNg7WS
         SIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688409046; x=1691001046;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=He8NzzwPdZ+gUI1RQp1DpiIr7HCamoUjJWEecs32J0I=;
        b=lOm74a4prbRpKH2fpDSGI68xCvLhr12XOU3ZMRGtTQm6aTUSvU/UrASzHtk38skqhz
         ZU6L1V9Q0YnIZUJz2AcrTBP2zbrXWE1fqu/yVTRFOjCC8lCJKMLH0aFFOESI00bbhBZ5
         Nto9edidSg+xdNfv1JIUely4g7OzN/Ld9xRuo4eZqSxB5n0EFJe3S/nqBD7pzBn6OO/M
         B8C/rG0Ulhsitm1FQ3e5J0iDuyai6SV2kPB301MgarILgRepaK/izi5CxvbE1CjMXHIt
         eFBsbe17fdCJ2dt3ejJSmELGtNFwolcdB0gV/441Xs2PFBbouJ2jPByxlUYC0v8/igyK
         1t5w==
X-Gm-Message-State: ABy/qLYPaPgV6v02ZF0vs213PJkjQcE78v1juRWvJwvR28RExvzPLwm/
	1dYerLEA7Gck9C4Y9Iw66Fk=
X-Google-Smtp-Source: APBJJlHQnjSNISEr4ZzaEmcFxgM75F/5rkQGuaRH99XZXMo9tUChA0WkP4eh3zkdYqf4kZCSQRkviA==
X-Received: by 2002:a62:6450:0:b0:681:50fd:2b98 with SMTP id y77-20020a626450000000b0068150fd2b98mr11920407pfb.31.1688409046138;
        Mon, 03 Jul 2023 11:30:46 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba10::41f])
        by smtp.gmail.com with ESMTPSA id r2-20020a62e402000000b00672401787c6sm13073708pfh.109.2023.07.03.11.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 11:30:45 -0700 (PDT)
Date: Mon, 03 Jul 2023 11:30:44 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 Stanislav Fomichev <sdf@google.com>, 
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 bpf <bpf@vger.kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Song Liu <song@kernel.org>, 
 Yonghong Song <yhs@fb.com>, 
 KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 Network Development <netdev@vger.kernel.org>
Message-ID: <64a313d41bd2c_5fc9a20839@john.notmuch>
In-Reply-To: <20230630201100.0bb9b1f3@kernel.org>
References: <20230622195757.kmxqagulvu4mwhp6@macbook-pro-8.dhcp.thefacebook.com>
 <CAKH8qBvJmKwgdrLkeT9EPnCiTu01UAOKvPKrY_oHWySiYyp4nQ@mail.gmail.com>
 <CAADnVQKfcGT9UaHtAmWKywtuyP9+_NX0_mMaR0m9D0-a=Ymf5Q@mail.gmail.com>
 <CAKH8qBuJpybiTFz9vx+M+5DoGuK-pPq6HapMKq7rZGsngsuwkw@mail.gmail.com>
 <CAADnVQ+611dOqVFuoffbM_cnOf62n6h+jaB1LwD2HWxS5if2CA@mail.gmail.com>
 <m2bkh69fcp.fsf@gmail.com>
 <649637e91a709_7bea820894@john.notmuch>
 <CAADnVQKUVDEg12jOc=5iKmfN-aHvFEtvFKVEDBFsmZizwkXT4w@mail.gmail.com>
 <20230624143834.26c5b5e8@kernel.org>
 <ZJeUlv/omsyXdO/R@google.com>
 <ZJoExxIaa97JGPqM@google.com>
 <CAADnVQKePtxk6Nn=M6in6TTKaDNnMZm-g+iYzQ=mPoOh8peoZQ@mail.gmail.com>
 <CAKH8qBv-jU6TUcWrze5VeiVhiJ-HUcpHX7rMJzN5o2tXFkS8kA@mail.gmail.com>
 <649b581ded8c1_75d8a208c@john.notmuch>
 <20230628115204.595dea8c@kernel.org>
 <87y1k2fq9m.fsf@toke.dk>
 <649f78b57358c_30943208c4@john.notmuch>
 <20230630201100.0bb9b1f3@kernel.org>
Subject: Re: [RFC bpf-next v2 11/11] net/mlx5e: Support TX timestamp metadata
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jakub Kicinski wrote:
> On Fri, 30 Jun 2023 17:52:05 -0700 John Fastabend wrote:
> > Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > > Jakub Kicinski <kuba@kernel.org> writes:
> > > > Sorry but this is not going to happen without my nack. DPDK was a=
 much
> > > > cleaner bifurcation point than trying to write datapath drivers i=
n BPF.
> > > > Users having to learn how to render descriptors for all the NICs
> > > > and queue formats out there is not reasonable. Isovalent hired  =

> > =

> > I would expect BPF/driver experts would write the libraries for the
> > datapath API that the network/switch developer is going to use. I wou=
ld
> > even put the BPF programs in kernel and ship them with the release
> > if that helps.
> > =

> > We have different visions on who the BPF user is that writes XDP
> > programs I think.
> =

> Yes, crucially. What I've seen talking to engineers working on TC/XDP
> BPF at Meta (and I may not be dealing with experts, Martin would have
> a broader view) is that they don't understand basics like s/g or
> details of checksums.

Interesting data point. But these same engineers will want to get
access to the checksum, but don't understand it? Seems if your
going to start reading/writing descriptors even through kfuncs
we need to get some docs/notes on how to use them correctly then.
We certainly wont put guardrails on the read/writes for performance
reasons.

> =

> I don't think it is reasonable to call you, Maxim, Nik and co. "users".=

> We're risking building system so complex normal people will _need_ an
> overlay on top to make it work.

I consider us users. We write networking CNI and observability/sec
tooling on top of BPF. Most of what we create is driven by customer
environments and performance. Maybe not typical users I guess, but
also Meta users are not typical and have their own set of constraints
and insights.

> =

> > > > a lot of former driver developers so you may feel like it's a goo=
d
> > > > idea, as a middleware provider. But for the rest of us the matrix=

> > > > of HW x queue format x people writing BPF is too large. If we can=
  =

> > =

> > Its nice though that we have good coverage for XDP so the matrix
> > is big. Even with kfuncs though we need someone to write support.
> > My thought is its just a question of if they write it in BPF
> > or in C code as a reader kfunc. I suspect for these advanced features=

> > its only a subset at least upfront. Either way BPF or C you are
> > stuck finding someone to write that code.
> =

> Right, but kernel is a central point where it can be written, reviewed,=

> cross-optimized and stored.

We can check BPF codes into the kernel.

> =

> > > > write some poor man's DPDK / common BPF driver library to be sele=
cted
> > > > at linking time - we can as well provide a generic interface in
> > > > the kernel itself. Again, we never merged explicit DPDK support, =

> > > > your idea is strictly worse.  =

> > > =

> > > I agree: we're writing an operating system kernel here. The *whole
> > > point* of an operating system is to provide an abstraction over
> > > different types of hardware and provide a common API so users don't=
 have
> > > to deal with the hardware details.  =

> > =

> > And just to be clear what we sacrifice then is forwards/backwards
> > portability.
> =

> Forward compatibility is also the favorite word of HW vendors when =

> they create proprietary interfaces. I think it's incorrect to call
> cutting functionality out of a project forward compatibility.
> If functionality is moved the surface of compatibility is different.

Sure a bit of an abuse of terminology.

> =

> > If its a kernel kfunc we need to add a kfunc for
> > every field we want to read and it will only be available then.
> > Further, it will need some general agreement that its useful for
> > it to be added. A hardware vendor wont be able to add some arbitrary
> > field and get access to it. So we lose this by doing kfuncs.
> =

> We both know how easy it is to come up with useful HW, so I'm guessing
> this is rhetorical.

It wasn't rhetorical but agree we've been chasing this for years
and outside of environments where you own a very large data center
and sell out VMs or niche spaces its been hard to come up with a
really good general use case.

> =

> > Its pushing complexity into the kernel that we maintain in kernel
> > when we could push the complexity into BPF and maintain as user
> > space code and BPF codes. Its a choice to make I think.
> =

> Right, and I believe having the code in the kernel, appropriately
> integrated with the drivers is beneficial. The main argument against =

> it is that in certain environments kernels are old. But that's a very
> destructive argument.

My main concern here is we forget some kfunc that we need and then
we are stuck. We don't have the luxury of upgrading kernels easily.
It doesn't need to be an either/or discussion if we have a ctx()
call we can drop into BTF over the descriptor and use kfuncs for
the most common things. Other option is to simply write a kfunc
for every field I see that could potentially have some use even
if I don't fully understand it at the moment.

I suspect I am less concerned about raw access because we already
have BTF infra built up around our network observability/sec
solution so we already handle per kernel differences and desc.
just looks like another BTF object we want to read. And we
know what dev and types we are attaching to so we don't have
issues with is this a mlx or intel or etc device.

Also as a more practical concern how do we manage nic specific
things? Have nic spcific kfuncs? Per descriptor tx_flags and
status flags. Other things we need are ptr to skb and access
to the descriptor ring so we can pull stats off the ring. I'm
not arguing it can't be done with kfuncs, but if we go kfunc
route be prepared for a long list of kfuncs and driver specific
ones.

.John=

