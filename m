Return-Path: <bpf+bounces-3290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8853273BC9B
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 18:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70F431C212C8
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 16:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89B1BE48;
	Fri, 23 Jun 2023 16:32:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D80100B5;
	Fri, 23 Jun 2023 16:32:33 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9EC26A9;
	Fri, 23 Jun 2023 09:32:31 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b477e9d396so13976211fa.3;
        Fri, 23 Jun 2023 09:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687537950; x=1690129950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2I3GjaHedd8UwqHCD/cICvG+HnMoaDQVwpMURCXNbWM=;
        b=ioRCSav5i/KJc6UheQJQp+/pherHS7TJA4doFCMudjZ8PyA1SimcloaNAtx2HKwNKR
         2uJ0GhR3m2EvzA+dMm9b3EBqvPwqWcPR3R09OyP57WYVE4ASK8WhrTwXCXDFEbiswmN2
         I7zqDO2u84i5sHByXZidl4KnXxUcAfkMCccUPunTW5VUz9P7fG6Xipln3g79oABQsxC0
         +x3WzKnUH8d3MwRigN888G4Blfbjg8+6HvPT3xMxP+HRvDMJ9Ofx2QAP83AmaTSiVjMY
         bgCnjvQ1p1gkG8II2AlFg3aCSjKehJs6H4itiQ5MF6sgONbXZYf6R/xIg+kJGHTwGevQ
         swxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687537950; x=1690129950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2I3GjaHedd8UwqHCD/cICvG+HnMoaDQVwpMURCXNbWM=;
        b=h0sQT5j39+mvo/EHHCmthLtncVXMM1JkZOOnb9XTND5U/yU4sDCfuReYGxbcAD6YA0
         x3l+0XNFLMWy5+ZHZQOhLx7UHabebbpg28DNT9C6zNq6I/SMIzsD47gfljI6vBkAwkEB
         TC+PyEG3KiRMFVJLSD/oYjlLhnfcOJuKJKrvgEKaPuXK4GjnYr5f6IC9VeFkhxAEp22t
         LnPgPd7Ktc9pTK8jWXIXOocQJVM9bHJjCyO2kYebesIqekjXSqQ29vDriykTQuMUJ0hI
         jc7jN22KV4yrXJvA4uGTVapJZX9C1qiQiNBa/XzISavsFAIkhhR1BKS74TmRu6YS+L6B
         BKTQ==
X-Gm-Message-State: AC+VfDwRFPuTDukuoWS3RpuIPInco5JfKl/OwQSvglHzqumexRBtl6aT
	mohQaacUTkSbKFY1270e1z/qnUDCc9hwLXywFfk=
X-Google-Smtp-Source: ACHHUZ5S/at/i6kLM6YR/JIGPMDyIJU3E/zSkDUpsnv9G/W9xjd6SC9GiIKxbnpztpujI9hS3uL4Mm4qrHOdd1w8QUw=
X-Received: by 2002:a2e:9105:0:b0:2b5:910c:ecda with SMTP id
 m5-20020a2e9105000000b002b5910cecdamr4867354ljg.44.1687537949658; Fri, 23 Jun
 2023 09:32:29 -0700 (PDT)
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
 <CAADnVQ+611dOqVFuoffbM_cnOf62n6h+jaB1LwD2HWxS5if2CA@mail.gmail.com> <4c592016-5b5e-9670-2231-b44642091d46@redhat.com>
In-Reply-To: <4c592016-5b5e-9670-2231-b44642091d46@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 23 Jun 2023 09:32:18 -0700
Message-ID: <CAADnVQKT06t=-4zrHQobSpL06JpQh90vMfPpcYvXs8881GxMWg@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 11/11] net/mlx5e: Support TX timestamp metadata
To: Maryam Tahhan <mtahhan@redhat.com>
Cc: Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, "Wiles, Keith" <keith.wiles@intel.com>, 
	Jesper Brouer <jbrouer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 3:16=E2=80=AFAM Maryam Tahhan <mtahhan@redhat.com> =
wrote:
>
> On 23/06/2023 03:35, Alexei Starovoitov wrote:
> > Why do you think so?
> > Who are those users?
> > I see your proposal and thumbs up from onlookers.
> > afaict there are zero users for rx side hw hints too.
> >
> >> the specs are
> >> not public; things can change depending on fw version/etc/etc.
> >> So the progs that touch raw descriptors are not the primary use-case.
> >> (that was the tl;dr for rx part, seems like it applies here?)
> >>
> >> Let's maybe discuss that mlx5 example? Are you proposing to do
> >> something along these lines?
> >>
> >> void mlx5e_devtx_submit(struct mlx5e_tx_wqe *wqe);
> >> void mlx5e_devtx_complete(struct mlx5_cqe64 *cqe);
> >>
> >> If yes, I'm missing how we define the common kfuncs in this case. The
> >> kfuncs need to have some common context. We're defining them with:
> >> bpf_devtx_<kfunc>(const struct devtx_frame *ctx);
> > I'm looking at xdp_metadata and wondering who's using it.
> > I haven't seen a single bug report.
> > No bugs means no one is using it. There is zero chance that we managed
> > to implement it bug-free on the first try.
> > So new tx side things look like a feature creep to me.
> > rx side is far from proven to be useful for anything.
> > Yet you want to add new things.
> >
>
> Hi folks
>
> We in CNDP (https://github.com/CloudNativeDataPlane/cndp) have been

with TCP stack in user space over af_xdp...

> looking to use xdp_metadata to relay receive side offloads from the NIC
> to our AF_XDP applications. We see this is a key feature that is
> essential for the viability of AF_XDP in the real world. We would love
> to see something adopted for the TX side alongside what's on the RX
> side. We don't want to waste cycles do everything in software when the
> NIC HW supports many features that we need.

Please specify "many features". If that means HW TSO to accelerate
your TCP in user space, then sorry, but no.

