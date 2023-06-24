Return-Path: <bpf+bounces-3340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AF273C663
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 04:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41B6A281E6B
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 02:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3B139F;
	Sat, 24 Jun 2023 02:52:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8387F;
	Sat, 24 Jun 2023 02:52:18 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AE510F4;
	Fri, 23 Jun 2023 19:52:16 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f957a45b10so1688476e87.0;
        Fri, 23 Jun 2023 19:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687575135; x=1690167135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YiaSgwKIgDzjt8h2SP6OaFlkBqoIZ7USz7iUuScyu0k=;
        b=R18NtES5xWXIYIVjryWLi2jv9T0ndZTK0Kbxfw0GIdd1xKRClH1hDmPz9sj7xFLpiy
         ZyrT0ip+LjEiI9zduiPbGA3ipZiTy/IYrtfPMGI5XsYkmJBVAlUAQFKXoN1/3qPFHNbU
         88IiF6X1KmVDPLoyc2V4CfUgtJpj3ODxQAzndJIO26F1MjuWSRBCdacdsrh8fjJ1FWWm
         9+WMt3Mi+TJyDfgLnqeOWJPWK3MpJVDsCwQ0LVF+LoJ1lpb93XIsjV8D2NvXsMNP4cNM
         6aRGrlgFHyRzZtel1KkHLDa3GUMCpBZvv7XRwUsB1AyOF7Nja9VkB1ekiWRc3VwWNsiQ
         FTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687575135; x=1690167135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YiaSgwKIgDzjt8h2SP6OaFlkBqoIZ7USz7iUuScyu0k=;
        b=JeCJlVL2NMfWgcz9ND8oRANhToL/eIk0EjfkJthemfvyhGQ6NTitO/zK3fcK7vSOV/
         2Mx8ZASYBdAKtN4OC2hmZYt1xd+gtWi/qG983Cek4ejpOVmOsHjm8fYYifbrVLrIvq/p
         VEUCziD9WHESQqd1A+yqky8s74/p3OAJ25xqwtgjz9QYhEnKDEFk5MRrspe+qZckU2Ss
         +1uVd1REQEZFHeBlF1TKjUU27jOfolCp5yQ8Cem03dXH8lX7ugY0nMRDvUSNtgZJrNuh
         LH3jqc23x4D8xHI6DNbyzh1Ny9SAzBk6oR4QThR5ZwNsNjaEbvnF50fhrBoRknrCiMsB
         2Z2w==
X-Gm-Message-State: AC+VfDyunWKY3nXgMGo3LeF4qVH0mmfgt/IMpYvOxd2mfg/kdwkz7ym3
	ai2pCtgVlWC1pZyB/yDwA/g2zy7XpSSOWB7eEiw=
X-Google-Smtp-Source: ACHHUZ5pTxM16a5/EW6GTIFyrL4F2xPaqSvAj6vnxF2XIJx40+cSRKV/XlKkkizTyB4CF6189f6wOOGsByYn6mM5YO4=
X-Received: by 2002:a19:4f52:0:b0:4f8:66e1:14e3 with SMTP id
 a18-20020a194f52000000b004f866e114e3mr11143450lfk.17.1687575134374; Fri, 23
 Jun 2023 19:52:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621170244.1283336-1-sdf@google.com> <20230621170244.1283336-12-sdf@google.com>
 <20230622195757.kmxqagulvu4mwhp6@macbook-pro-8.dhcp.thefacebook.com>
 <CAKH8qBvJmKwgdrLkeT9EPnCiTu01UAOKvPKrY_oHWySiYyp4nQ@mail.gmail.com>
 <CAADnVQKfcGT9UaHtAmWKywtuyP9+_NX0_mMaR0m9D0-a=Ymf5Q@mail.gmail.com>
 <CAKH8qBuJpybiTFz9vx+M+5DoGuK-pPq6HapMKq7rZGsngsuwkw@mail.gmail.com>
 <CAADnVQ+611dOqVFuoffbM_cnOf62n6h+jaB1LwD2HWxS5if2CA@mail.gmail.com>
 <m2bkh69fcp.fsf@gmail.com> <649637e91a709_7bea820894@john.notmuch>
In-Reply-To: <649637e91a709_7bea820894@john.notmuch>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 23 Jun 2023 19:52:03 -0700
Message-ID: <CAADnVQKUVDEg12jOc=5iKmfN-aHvFEtvFKVEDBFsmZizwkXT4w@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 11/11] net/mlx5e: Support TX timestamp metadata
To: John Fastabend <john.fastabend@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 5:25=E2=80=AFPM John Fastabend <john.fastabend@gmai=
l.com> wrote:
>
> Donald Hunter wrote:
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> >
> > > On Thu, Jun 22, 2023 at 3:13=E2=80=AFPM Stanislav Fomichev <sdf@googl=
e.com> wrote:
> > >>
> > >> We want to provide common sane interfaces/abstractions via kfuncs.
> > >> That will make most BPF programs portable from mlx to brcm (for
> > >> example) without doing a rewrite.
> > >> We're also exposing raw (readonly) descriptors (via that get_ctx
> > >> helper) to the users who know what to do with them.
> > >> Most users don't know what to do with raw descriptors;
> > >
> > > Why do you think so?
> > > Who are those users?
> > > I see your proposal and thumbs up from onlookers.
> > > afaict there are zero users for rx side hw hints too.
> >
> > We have customers in various sectors that want to use rx hw timestamps.
> >
> > There are several use cases especially in Telco where they use DPDK
> > today and want to move to AF_XDP but they need to be able to benefit
> > from the hw capabilities of the NICs they purchase. Not having access t=
o
> > hw offloads on rx and tx is a barrier to AF_XDP adoption.
> >
> > The most notable gaps in AF_XDP are checksum offloads and multi buffer
> > support.
> >
> > >> the specs are
> > >> not public; things can change depending on fw version/etc/etc.
> > >> So the progs that touch raw descriptors are not the primary use-case=
.
> > >> (that was the tl;dr for rx part, seems like it applies here?)
> > >>
> > >> Let's maybe discuss that mlx5 example? Are you proposing to do
> > >> something along these lines?
> > >>
> > >> void mlx5e_devtx_submit(struct mlx5e_tx_wqe *wqe);
> > >> void mlx5e_devtx_complete(struct mlx5_cqe64 *cqe);
> > >>
> > >> If yes, I'm missing how we define the common kfuncs in this case. Th=
e
> > >> kfuncs need to have some common context. We're defining them with:
> > >> bpf_devtx_<kfunc>(const struct devtx_frame *ctx);
> > >
> > > I'm looking at xdp_metadata and wondering who's using it.
> > > I haven't seen a single bug report.
> > > No bugs means no one is using it. There is zero chance that we manage=
d
> > > to implement it bug-free on the first try.
> >
> > Nobody is using xdp_metadata today, not because they don't want to, but
> > because there was no consensus for how to use it. We have internal POCs
> > that use xdp_metadata and are still trying to build the foundations
> > needed to support it consistently across different hardware. Jesper
> > Brouer proposed a way to describe xdp_metadata with BTF and it was
> > rejected. The current plan to use kfuncs for xdp hints is the most
> > recent attempt to find a solution.
>
> The hold up on my side is getting it in a LST kernel so we can get it
> deployed in real environments. Although my plan is to just cast the
> ctx to a kernel ctx and read the data out we need.

+1

> >
> > > So new tx side things look like a feature creep to me.
> > > rx side is far from proven to be useful for anything.
> > > Yet you want to add new things.
>
> From my side if we just had a hook there and could cast the ctx to
> something BTF type safe so we can simply read through the descriptor
> I think that would sufficient for many use cases. To write into the
> descriptor that might take more thought a writeable BTF flag?

That's pretty much what I'm suggesting.
Add two driver specific __weak nop hook points where necessary
with few driver specific kfuncs.
Don't build generic infra when it's too early to generalize.

It would mean that bpf progs will be driver specific,
but when something novel like this is being proposed it's better
to start with minimal code change to core kernel (ideally none)
and when common things are found then generalize.

Sounds like Stanislav use case is timestamps in TX
while Donald's are checksums on RX, TX. These use cases are too different.
To make HW TX checksum compute checksum driven by AF_XDP
a lot more needs to be done than what Stan is proposing for timestamps.

