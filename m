Return-Path: <bpf+bounces-3333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F4673C524
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 02:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF062281EA9
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 00:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4E8379;
	Sat, 24 Jun 2023 00:25:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15505360;
	Sat, 24 Jun 2023 00:25:16 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9829D2727;
	Fri, 23 Jun 2023 17:25:15 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b7db2e162cso1271755ad.1;
        Fri, 23 Jun 2023 17:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687566315; x=1690158315;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQXba6EmHlynNnz81zH/1sTIxaYKdX0Ois7d/fwOXMI=;
        b=eIbS0JCuNu/8Ovpf/c2OlH+8jANrdgUnFMfbDnMBGkVbzA48ccqQy5wIrhsPNfr6Wk
         vi4Lk94wu6uzt/gvypJW9pKK6zZXSJG8rz5x6P+E8CP6GdcaPlM/pvQtL0KIUTa8mZqk
         M6lhzo7ZNstRIRRX07Y+UCKYXRH2ssLY6mw52EoiTJVN0IvUrZ8P83ulz4YNhzqSXSeg
         8XMyYF9cstwdUXgkBbJIp68z20E/xtcxrHddht4Q2pvNEbzPUlPgYmpJyMZWOaFfO8kl
         4Lh0VO7tKxxGkcpnhLm7htNIawq3Ek3RLnf9XDsuloG5ridyLf+J0D5ubFSAPQkvzLn5
         0ErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687566315; x=1690158315;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nQXba6EmHlynNnz81zH/1sTIxaYKdX0Ois7d/fwOXMI=;
        b=Ql94TYfczEz5NQE7mIPd98WQEC2OGDnp94wB9uyNTCAxLWXSb45eD1XoeerYvuAFq7
         oviUe1DjVR1mXmYHhzRIM8yizznB1vp/rnkDwIGZ1RHcsOOr+zGxBhEMxgDZXz+O2NDI
         LtVHYr+XxGm6h9Mf4zx4VYrRk6RVGWOM7X2VdQhxPOsxEA60QXcIaX9H9d91EIyNpauE
         001mc6Kt5wdLwSv4dMhwMzNhNdxTVxdQ05knLFY7gI9jcWYCTvnQYw10bEkDaNR+m/Iu
         yC6VKM+4vp1x8FIYPeUyPnGQv4fEpxQiOawsJCWPIVLIhHCVO2pkjGkdJ2Xtc3GvbT2p
         U94A==
X-Gm-Message-State: AC+VfDzyMIICDTLwZlTow6Qg0D/gtbXKvQcGLbi9N4YDlLqQ2K24TCjY
	rgwG/lhjUxefZYBL+24OIIA=
X-Google-Smtp-Source: ACHHUZ4XzDWhPIyzekv0j5WRHtFAPr+h4KZbrDQTS1zXL/Bp5iN/F+SCxJxbCEDTTg7FhW+IuJLctw==
X-Received: by 2002:a17:902:d2c4:b0:1b3:e802:5de6 with SMTP id n4-20020a170902d2c400b001b3e8025de6mr629971plc.29.1687566314909;
        Fri, 23 Jun 2023 17:25:14 -0700 (PDT)
Received: from localhost ([98.97.117.85])
        by smtp.gmail.com with ESMTPSA id jk24-20020a170903331800b001a5fccab02dsm124709plb.177.2023.06.23.17.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 17:25:14 -0700 (PDT)
Date: Fri, 23 Jun 2023 17:25:13 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Stanislav Fomichev <sdf@google.com>, 
 bpf <bpf@vger.kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Song Liu <song@kernel.org>, 
 Yonghong Song <yhs@fb.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 Network Development <netdev@vger.kernel.org>
Message-ID: <649637e91a709_7bea820894@john.notmuch>
In-Reply-To: <m2bkh69fcp.fsf@gmail.com>
References: <20230621170244.1283336-1-sdf@google.com>
 <20230621170244.1283336-12-sdf@google.com>
 <20230622195757.kmxqagulvu4mwhp6@macbook-pro-8.dhcp.thefacebook.com>
 <CAKH8qBvJmKwgdrLkeT9EPnCiTu01UAOKvPKrY_oHWySiYyp4nQ@mail.gmail.com>
 <CAADnVQKfcGT9UaHtAmWKywtuyP9+_NX0_mMaR0m9D0-a=Ymf5Q@mail.gmail.com>
 <CAKH8qBuJpybiTFz9vx+M+5DoGuK-pPq6HapMKq7rZGsngsuwkw@mail.gmail.com>
 <CAADnVQ+611dOqVFuoffbM_cnOf62n6h+jaB1LwD2HWxS5if2CA@mail.gmail.com>
 <m2bkh69fcp.fsf@gmail.com>
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

Donald Hunter wrote:
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> =

> > On Thu, Jun 22, 2023 at 3:13=E2=80=AFPM Stanislav Fomichev <sdf@googl=
e.com> wrote:
> >>
> >> We want to provide common sane interfaces/abstractions via kfuncs.
> >> That will make most BPF programs portable from mlx to brcm (for
> >> example) without doing a rewrite.
> >> We're also exposing raw (readonly) descriptors (via that get_ctx
> >> helper) to the users who know what to do with them.
> >> Most users don't know what to do with raw descriptors;
> >
> > Why do you think so?
> > Who are those users?
> > I see your proposal and thumbs up from onlookers.
> > afaict there are zero users for rx side hw hints too.
> =

> We have customers in various sectors that want to use rx hw timestamps.=

> =

> There are several use cases especially in Telco where they use DPDK
> today and want to move to AF_XDP but they need to be able to benefit
> from the hw capabilities of the NICs they purchase. Not having access t=
o
> hw offloads on rx and tx is a barrier to AF_XDP adoption.
> =

> The most notable gaps in AF_XDP are checksum offloads and multi buffer
> support.
> =

> >> the specs are
> >> not public; things can change depending on fw version/etc/etc.
> >> So the progs that touch raw descriptors are not the primary use-case=
.
> >> (that was the tl;dr for rx part, seems like it applies here?)
> >>
> >> Let's maybe discuss that mlx5 example? Are you proposing to do
> >> something along these lines?
> >>
> >> void mlx5e_devtx_submit(struct mlx5e_tx_wqe *wqe);
> >> void mlx5e_devtx_complete(struct mlx5_cqe64 *cqe);
> >>
> >> If yes, I'm missing how we define the common kfuncs in this case. Th=
e
> >> kfuncs need to have some common context. We're defining them with:
> >> bpf_devtx_<kfunc>(const struct devtx_frame *ctx);
> >
> > I'm looking at xdp_metadata and wondering who's using it.
> > I haven't seen a single bug report.
> > No bugs means no one is using it. There is zero chance that we manage=
d
> > to implement it bug-free on the first try.
> =

> Nobody is using xdp_metadata today, not because they don't want to, but=

> because there was no consensus for how to use it. We have internal POCs=

> that use xdp_metadata and are still trying to build the foundations
> needed to support it consistently across different hardware. Jesper
> Brouer proposed a way to describe xdp_metadata with BTF and it was
> rejected. The current plan to use kfuncs for xdp hints is the most
> recent attempt to find a solution.

The hold up on my side is getting it in a LST kernel so we can get it
deployed in real environments. Although my plan is to just cast the
ctx to a kernel ctx and read the data out we need.

> =

> > So new tx side things look like a feature creep to me.
> > rx side is far from proven to be useful for anything.
> > Yet you want to add new things.

From my side if we just had a hook there and could cast the ctx to
something BTF type safe so we can simply read through the descriptor
I think that would sufficient for many use cases. To write into the
descriptor that might take more thought a writeable BTF flag?

> =

> We have telcos and large enterprises that either use DPDK or use
> proprietary solutions for getting traffic to user space. They want to
> move to AF_XDP but without at least RX and TX checksum offloads they ar=
e
> paying a CPU tax for using AF_XDP. One customer is also waiting for
> multi-buffer support to land before they can adopt AF_XDP.
> =

> So, no it's not feature creep, it's a set of required features to reach=

> minimum viable product to be able to move out of a lab and replace
> legacy in production.



