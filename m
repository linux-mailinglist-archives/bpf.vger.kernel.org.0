Return-Path: <bpf+bounces-14079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 417A17E067F
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 17:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6453F1C210D1
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 16:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792E81CA91;
	Fri,  3 Nov 2023 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbsJInSO"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061A11C6A8;
	Fri,  3 Nov 2023 16:26:46 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46E0D6A;
	Fri,  3 Nov 2023 09:26:25 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9c53e8b7cf4so335509666b.1;
        Fri, 03 Nov 2023 09:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699028784; x=1699633584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTnkfaaMf1CLAmf1Rg2wsHS7BcVuqGkZNamaGh2FvQ4=;
        b=UbsJInSOefG71c85sFN7Bv5MY6GB5OP67Kvnhp9H344IpQHR4/IEjCmK9GODo3hH+Z
         D9lfwHBaaj6YHRIbgZrhFcMKe8/fIb63XbjAm4cSpm064nq4WuMVWLrxpeTL0KiNNTye
         i8HxNE/FbFeJgtPn6Lo20COmwlJU1xbvw5TqcQeZvqVUebkylipMPpKXad8XW262u+bF
         09TumWtKl3EQPRJrZ4SSa9r6Hr/o7KxAipmVAoonPu/5GWZgoxIxEq9ajW1EQBDqPvCe
         HvD+d57Kyh9BSIJxeHzk4ufy1GWNrt1bcKDQva2JQVb+dgD7DNJoLB2PGEK2C6Ae6IVJ
         yk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699028784; x=1699633584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTnkfaaMf1CLAmf1Rg2wsHS7BcVuqGkZNamaGh2FvQ4=;
        b=XnRLCTSEJyYTQmJRTvAcHuzbY4rxZXHDVX7qxP4ltN9Q1mIy5/eOJxb5IXYueMwCRK
         eHOXidJsvjX1eloVfffhOJ5DTjWj4y4z6/sC+4vhRkBWzDqbBjt2q+BQUEt1/OtKIxMm
         dUQndXrjgqAuunpB3YIY0gvdLl0SNtqdepwQ/W1tmC7KIPPV+Zd6Ce0LGnn80WJPU9fu
         ciW1rKF1jMv9MzbntKy7mnK0WY2hGarNL6d97d0Dt75eg5f5oJsy06WoAEyzWw4O2W17
         ye6+kenxAWotvdUImMxPtBsO+J+XHUXfJOxUiHBLXV4s8yJCDFoH917+OrWmRT/izA9P
         TWHg==
X-Gm-Message-State: AOJu0Yye/ix8LnEtUe7A2wU2/oFLVBsF7jLCrXFhkZShCK7vCJG2BBbZ
	dstqzrsA50Hr2tw/cxt23MJa9ujL44p38Q2LQ3jFsq6t
X-Google-Smtp-Source: AGHT+IGakKETpikSrE5Xosw/DkfZZRBaiBc5vn5u0MXOqWdum9NK7AqxWpxFtFIqEj9IQslRRfFGUnfUvUQePkXGpyQ=
X-Received: by 2002:a17:907:3685:b0:9bd:a7a5:3a5a with SMTP id
 bi5-20020a170907368500b009bda7a53a5amr7824353ejc.36.1699028784033; Fri, 03
 Nov 2023 09:26:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103112237.1756288-1-anders.roxell@linaro.org>
In-Reply-To: <20231103112237.1756288-1-anders.roxell@linaro.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 3 Nov 2023 09:26:12 -0700
Message-ID: <CAEf4BzahAuskkD9YqxQpZDaUcu_jTuNAfbkkwP4dzJH=cTaVKA@mail.gmail.com>
Subject: Re: [PATCH] selftests: bpf: xskxceiver: ksft_print_msg: fix format
 type error
To: Anders Roxell <anders.roxell@linaro.org>
Cc: bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 4:23=E2=80=AFAM Anders Roxell <anders.roxell@linaro.=
org> wrote:
>
> Crossbuilding selftests/bpf for architecture arm64, format specifies
> type error show up like.
>
> xskxceiver.c:912:34: error: format specifies type 'int' but the argument
> has type '__u64' (aka 'unsigned long long') [-Werror,-Wformat]
>  ksft_print_msg("[%s] expected meta_count [%d], got meta_count [%d]\n",
>                                                                 ~~
>                                                                 %llu
>                 __func__, pkt->pkt_nb, meta->count);
>                                        ^~~~~~~~~~~
> xskxceiver.c:929:55: error: format specifies type 'unsigned long long' bu=
t
>  the argument has type 'u64' (aka 'unsigned long') [-Werror,-Wformat]
>  ksft_print_msg("Frag invalid addr: %llx len: %u\n", addr, len);
>                                     ~~~~             ^~~~
>

With u64s it might be %llx or %lx, depending on architecture, so best
is to force cast to (long long) or (unsigned long long) and then use
%llx.

> Fixing the issues by using the proposed format specifiers by the
> compilor.
>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  tools/testing/selftests/bpf/xskxceiver.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/sel=
ftests/bpf/xskxceiver.c
> index 591ca9637b23..dc03692f34d8 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c
> @@ -908,7 +908,7 @@ static bool is_metadata_correct(struct pkt *pkt, void=
 *buffer, u64 addr)
>         struct xdp_info *meta =3D data - sizeof(struct xdp_info);
>
>         if (meta->count !=3D pkt->pkt_nb) {
> -               ksft_print_msg("[%s] expected meta_count [%d], got meta_c=
ount [%d]\n",
> +               ksft_print_msg("[%s] expected meta_count [%d], got meta_c=
ount [%llu]\n",
>                                __func__, pkt->pkt_nb, meta->count);
>                 return false;
>         }
> @@ -926,11 +926,11 @@ static bool is_frag_valid(struct xsk_umem_info *ume=
m, u64 addr, u32 len, u32 exp
>
>         if (addr >=3D umem->num_frames * umem->frame_size ||
>             addr + len > umem->num_frames * umem->frame_size) {
> -               ksft_print_msg("Frag invalid addr: %llx len: %u\n", addr,=
 len);
> +               ksft_print_msg("Frag invalid addr: %lx len: %u\n", addr, =
len);
>                 return false;
>         }
>         if (!umem->unaligned_mode && addr % umem->frame_size + len > umem=
->frame_size) {
> -               ksft_print_msg("Frag crosses frame boundary addr: %llx le=
n: %u\n", addr, len);
> +               ksft_print_msg("Frag crosses frame boundary addr: %lx len=
: %u\n", addr, len);
>                 return false;
>         }
>
> @@ -1029,7 +1029,7 @@ static int complete_pkts(struct xsk_socket_info *xs=
k, int batch_size)
>                         u64 addr =3D *xsk_ring_cons__comp_addr(&xsk->umem=
->cq, idx + rcvd - 1);
>
>                         ksft_print_msg("[%s] Too many packets completed\n=
", __func__);
> -                       ksft_print_msg("Last completion address: %llx\n",=
 addr);
> +                       ksft_print_msg("Last completion address: %lx\n", =
addr);
>                         return TEST_FAILURE;
>                 }
>
> @@ -1513,7 +1513,7 @@ static int validate_tx_invalid_descs(struct ifobjec=
t *ifobject)
>         }
>
>         if (stats.tx_invalid_descs !=3D ifobject->xsk->pkt_stream->nb_pkt=
s / 2) {
> -               ksft_print_msg("[%s] tx_invalid_descs incorrect. Got [%u]=
 expected [%u]\n",
> +               ksft_print_msg("[%s] tx_invalid_descs incorrect. Got [%ll=
u] expected [%u]\n",
>                                __func__, stats.tx_invalid_descs,
>                                ifobject->xsk->pkt_stream->nb_pkts);
>                 return TEST_FAILURE;
> --
> 2.42.0
>
>

