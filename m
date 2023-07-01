Return-Path: <bpf+bounces-3833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CED67445B7
	for <lists+bpf@lfdr.de>; Sat,  1 Jul 2023 02:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D3DD1C20C3C
	for <lists+bpf@lfdr.de>; Sat,  1 Jul 2023 00:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6C717D0;
	Sat,  1 Jul 2023 00:52:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E18217C8;
	Sat,  1 Jul 2023 00:52:13 +0000 (UTC)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAF94201;
	Fri, 30 Jun 2023 17:52:07 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-55e04a83465so1740814eaf.3;
        Fri, 30 Jun 2023 17:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688172727; x=1690764727;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2VPicmntt3qnQ6kFYbLh0AYt3Qn4Ziu9nCMNn3gQzSg=;
        b=PQHiDR6K5UPc3xz7a+8Q/a0o/cqeotPWy50DDrndnsECk0yOtS4bUlxp3eVsahi3zg
         PhQi1r4ZBrmQR8vwY95Ws/2Tc4HZxkjhlm6tyIBnNXB1hPuc6+mtX/FB8GjEpKl91HFB
         ZlkKpg9T/ONXpFT7moIo7zis/gX7xRP15uVAnk/IvWsC4IbZYt7hXQbk5Vq6sqcw+BtL
         W4eSQ/Ajn2vfLXkYcaOvXgamo2H+dIN486OLQRxlkDXa7dZUD0VoZFZPDlRk6xnQbXDk
         aItkhg+BwblX4nAj3z/sVvXJKNNhWekukMRPKNDifctGci+avcDItwLUCoDqVPAlQJGG
         UTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688172727; x=1690764727;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2VPicmntt3qnQ6kFYbLh0AYt3Qn4Ziu9nCMNn3gQzSg=;
        b=E+NVGsdRIKUYh0YkudKb5TYjFNLVb14IJr3cNuC/XQfTKcjZxAm12nusuMcdWmx/45
         X/XgESOZbFXVzX+b0NrUqZPY+JD5GBzgFnsB05BVRymv9szNyuEHzkySThTbJF+DOTvx
         kbvdbmlbGMvgyLjyL0NRwc+tymLmZNXzETfXAWM+HnWtv8gOm+G7XPu5ILtSDV80aWKU
         452ZIpLPpVbvI/hnCWPAVCs0ogDlrRwS3iNha61EcVRrtfBBlRikBhhI9vwWkRP1ln5+
         ofCC4SNwsYeYwYGMlcl10lFTxm4J8FskIr7pvGaIo6recQX8UH3v5080yebiPy3VDqE4
         WF/Q==
X-Gm-Message-State: ABy/qLZxg/1ffloE5DrqKkQq7tsNs+s8oPfptZfiPl6g9k9gt4R48mF/
	5M6yjNb6SPRk3DJW8fRZEdk=
X-Google-Smtp-Source: APBJJlFOaxzB920y3V/8zAeiF8iT3l7HVtt0sUuiUJ8o1wO2Jc1khY31Km9dWgFfbK7YEQXU9wB4JQ==
X-Received: by 2002:a05:6358:700e:b0:134:d336:a1e8 with SMTP id 14-20020a056358700e00b00134d336a1e8mr3814017rwo.19.1688172727007;
        Fri, 30 Jun 2023 17:52:07 -0700 (PDT)
Received: from localhost ([156.39.10.100])
        by smtp.gmail.com with ESMTPSA id iw13-20020a170903044d00b001b801044466sm9160038plb.114.2023.06.30.17.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 17:52:06 -0700 (PDT)
Date: Fri, 30 Jun 2023 17:52:05 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: Stanislav Fomichev <sdf@google.com>, 
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
Message-ID: <649f78b57358c_30943208c4@john.notmuch>
In-Reply-To: <87y1k2fq9m.fsf@toke.dk>
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

Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> Jakub Kicinski <kuba@kernel.org> writes:
> =

> > On Tue, 27 Jun 2023 14:43:57 -0700 John Fastabend wrote:
> >> What I think would be the most straight-forward thing and most flexi=
ble
> >> is to create a <drvname>_devtx_submit_skb(<drivname>descriptor, sk_b=
uff)
> >> and <drvname>_devtx_submit_xdp(<drvname>descriptor, xdp_frame) and t=
hen
> >> corresponding calls for <drvname>_devtx_complete_{skb|xdp}() Then yo=
u
> >> don't spend any cycles building the metadata thing or have to even
> >> worry about read kfuncs. The BPF program has read access to any
> >> fields they need. And with the skb, xdp pointer we have the context
> >> that created the descriptor and generate meaningful metrics.
> >
> > Sorry but this is not going to happen without my nack. DPDK was a muc=
h
> > cleaner bifurcation point than trying to write datapath drivers in BP=
F.
> > Users having to learn how to render descriptors for all the NICs
> > and queue formats out there is not reasonable. Isovalent hired

I would expect BPF/driver experts would write the libraries for the
datapath API that the network/switch developer is going to use. I would
even put the BPF programs in kernel and ship them with the release
if that helps.

We have different visions on who the BPF user is that writes XDP
programs I think.

> > a lot of former driver developers so you may feel like it's a good
> > idea, as a middleware provider. But for the rest of us the matrix
> > of HW x queue format x people writing BPF is too large. If we can

Its nice though that we have good coverage for XDP so the matrix
is big. Even with kfuncs though we need someone to write support.
My thought is its just a question of if they write it in BPF
or in C code as a reader kfunc. I suspect for these advanced features
its only a subset at least upfront. Either way BPF or C you are
stuck finding someone to write that code.

> > write some poor man's DPDK / common BPF driver library to be selected=

> > at linking time - we can as well provide a generic interface in
> > the kernel itself. Again, we never merged explicit DPDK support, =

> > your idea is strictly worse.
> =

> I agree: we're writing an operating system kernel here. The *whole
> point* of an operating system is to provide an abstraction over
> different types of hardware and provide a common API so users don't hav=
e
> to deal with the hardware details.

And just to be clear what we sacrifice then is forwards/backwards
portability. If its a kernel kfunc we need to add a kfunc for
every field we want to read and it will only be available then.
Further, it will need some general agreement that its useful for
it to be added. A hardware vendor wont be able to add some arbitrary
field and get access to it. So we lose this by doing kfuncs.

Its pushing complexity into the kernel that we maintain in kernel
when we could push the complexity into BPF and maintain as user
space code and BPF codes. Its a choice to make I think.

Also abstraction can cost cycles. Here we have to prepare the
structure and call kfunc. The kfunc can be inlined if folks
do the work. It may be small cost but not free.

> =

> I feel like there's some tension between "BPF as a dataplane API" and
> "BPF as a kernel extension language" here, especially as the BPF

Agree. I'm obviously not maximizing for ease of use for the dataplane
API as BPF. IMO though even with the kfunc abstraction its niche work
writing low level datapath code that requires exposing a user
API higher up the stack. With a DSL (P4, ...) for example you could =

abstract away the complexity and then compile down into these
details. Or if you like tables an Openflow style table interface
would provide a table API.

> subsystem has grown more features in the latter direction. In my mind,
> XDP is still very much a dataplane API; in fact that's one of the main
> selling points wrt DPDK: you can get high performance networking but
> still take advantage of the kernel drivers and other abstractions that

I think we agree on the goal a fast datapath for the nic.

> the kernel provides. If you're going for raw performance and the abilit=
y
> to twiddle every tiny detail of the hardware, DPDK fills that niche
> quite nicely (and also shows us the pains of going that route).

Summary on my side is we minimize kernel complexity
by raw descriptor reads, we don't need to know what we
want to read in the future and we need folks who understand
the hardware regardless of where the code lives in BPF
or C. C certainly helps the picking what kfunc to use
but we also have BTF that solves this struct/offset problem
for non-networking use cases already.

> =

> -Toke
> =

