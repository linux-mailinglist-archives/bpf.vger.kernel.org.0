Return-Path: <bpf+bounces-14518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C62B7E5BEC
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 18:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BBACB20F24
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 17:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7E030351;
	Wed,  8 Nov 2023 17:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmEdigN8"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF53B31A6F;
	Wed,  8 Nov 2023 17:03:30 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E90E1FF5;
	Wed,  8 Nov 2023 09:03:30 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9a6190af24aso1111698566b.0;
        Wed, 08 Nov 2023 09:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699463008; x=1700067808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5NR/7zKi+/oiqZ54JSFP0TLZYYpLQwpmUmfEUcwBvI=;
        b=MmEdigN87e0BF5FA4sxqDyz29RE5zh2+IVO310sVGK/8mPJkkNTzREXnNrgn8lKMKT
         A8YhsJ7HRzzF9itCgW9IjhJIBJsi51sy9J7ACcCPs/JCKfi1SPa7DwUV1Qoy2mDG11TS
         ho5fl/tq8kbqhDAF2RLYosNUhNdtUUW6QaXzlqYQ10k2goGlvTr90lQ3CUc4oO/SqBSE
         xMVV/H/qJHLRLigtdKQcp8Ib6LxMPzKB7Y5vsKqpGOtoxCtLjMyZBEnyDY/1GwscKa9s
         cwC3gRGZW8OMXBYT/3dYn4xVoaWnWRSW/UXcX/w3rmEujBpiLWPIACgAA682gRImW0CA
         2Bqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699463008; x=1700067808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5NR/7zKi+/oiqZ54JSFP0TLZYYpLQwpmUmfEUcwBvI=;
        b=wz8tKERUDVrXGqexEZLHtvqYVGVUhwdjjr7HnG4PQrwXc4QplWDibhGPI8yRkZ8WZt
         iJ8ZMxS4WX0EohWMrFNnygER2qysRAqlcIoP+r56To6wIR4BXARBIy7NeMZQQ2Zfk/Be
         Ojx3ZJ2Z/+/7w/d+c3GW5XmwSEiNUgC2lR30iNgokflt32Q9hZrqAEVUC5XUnfoYUfgZ
         NsT2tv/SA+0Ui6OtUYhxD1Iq+NxrPrbP0iFDl+oFTBdY8RVhroU3hu8OtnExID2WaExY
         QVKfKxVETb3IC/PQa05mGrXDO38DnQ/ST+P+VmbfwDX/38NGy8RigBns4Pn4gNq0wQP+
         zznQ==
X-Gm-Message-State: AOJu0Yx0dwDh5+eFjpmnwpCEx4oM8SEn+tnZCCQLSK8c5vggfkJA37IV
	juTZ4DI0sBJgguMqn/pL6NVUcD1i/NpP3PluI/U=
X-Google-Smtp-Source: AGHT+IGT0WqJGvLBjAdabk5bYNm3hDWuM/paOADIY+4ELcAhc+CPTYvUGcejY38H6jJNeeNIbd+FhuBcsmh6K3wdG5g=
X-Received: by 2002:a17:906:4fd5:b0:9c6:19ea:cdd6 with SMTP id
 i21-20020a1709064fd500b009c619eacdd6mr2326618ejw.50.1699463008052; Wed, 08
 Nov 2023 09:03:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231108110048.1988128-1-anders.roxell@linaro.org>
In-Reply-To: <20231108110048.1988128-1-anders.roxell@linaro.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 8 Nov 2023 09:03:16 -0800
Message-ID: <CAEf4Bzbbix1KpCKGhK3dnFK99YNyyQzXHp9RzDtd72x7-c6M3A@mail.gmail.com>
Subject: Re: [PATCHv2] selftests: bpf: xskxceiver: ksft_print_msg: fix format
 type error
To: Anders Roxell <anders.roxell@linaro.org>
Cc: bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 8, 2023 at 3:00=E2=80=AFAM Anders Roxell <anders.roxell@linaro.=
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
> Fixing the issues by casting to (unsigned long long) and changing the
> specifiers to be %llx, since with u64s it might be %llx or %lx,
> depending on architecture.
>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  tools/testing/selftests/bpf/xskxceiver.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/sel=
ftests/bpf/xskxceiver.c
> index 591ca9637b23..1ab9512f5aa2 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c
> @@ -908,8 +908,9 @@ static bool is_metadata_correct(struct pkt *pkt, void=
 *buffer, u64 addr)
>         struct xdp_info *meta =3D data - sizeof(struct xdp_info);
>
>         if (meta->count !=3D pkt->pkt_nb) {
> -               ksft_print_msg("[%s] expected meta_count [%d], got meta_c=
ount [%d]\n",
> -                              __func__, pkt->pkt_nb, meta->count);
> +               ksft_print_msg("[%s] expected meta_count [%d], got meta_c=
ount [%llx]\n",

why hex? %llu?

> +                              __func__, pkt->pkt_nb,
> +                              (unsigned long long)meta->count);
>                 return false;
>         }
>
> @@ -926,11 +927,13 @@ static bool is_frag_valid(struct xsk_umem_info *ume=
m, u64 addr, u32 len, u32 exp
>
>         if (addr >=3D umem->num_frames * umem->frame_size ||
>             addr + len > umem->num_frames * umem->frame_size) {
> -               ksft_print_msg("Frag invalid addr: %llx len: %u\n", addr,=
 len);
> +               ksft_print_msg("Frag invalid addr: %llx len: %u\n",
> +                              (unsigned long long)addr, len);
>                 return false;
>         }
>         if (!umem->unaligned_mode && addr % umem->frame_size + len > umem=
->frame_size) {
> -               ksft_print_msg("Frag crosses frame boundary addr: %llx le=
n: %u\n", addr, len);
> +               ksft_print_msg("Frag crosses frame boundary addr: %llx le=
n: %u\n",
> +                              (unsigned long long)addr, len);
>                 return false;
>         }
>
> @@ -1029,7 +1032,8 @@ static int complete_pkts(struct xsk_socket_info *xs=
k, int batch_size)
>                         u64 addr =3D *xsk_ring_cons__comp_addr(&xsk->umem=
->cq, idx + rcvd - 1);
>
>                         ksft_print_msg("[%s] Too many packets completed\n=
", __func__);
> -                       ksft_print_msg("Last completion address: %llx\n",=
 addr);
> +                       ksft_print_msg("Last completion address: %llx\n",
> +                                      (unsigned long long)addr);
>                         return TEST_FAILURE;
>                 }
>
> @@ -1513,8 +1517,9 @@ static int validate_tx_invalid_descs(struct ifobjec=
t *ifobject)
>         }
>
>         if (stats.tx_invalid_descs !=3D ifobject->xsk->pkt_stream->nb_pkt=
s / 2) {
> -               ksft_print_msg("[%s] tx_invalid_descs incorrect. Got [%u]=
 expected [%u]\n",
> -                              __func__, stats.tx_invalid_descs,
> +               ksft_print_msg("[%s] tx_invalid_descs incorrect. Got [%ll=
x] expected [%u]\n",

should this be %llu? Or the switch to the hex was intentional?

> +                              __func__,
> +                              (unsigned long long)stats.tx_invalid_descs=
,
>                                ifobject->xsk->pkt_stream->nb_pkts);
>                 return TEST_FAILURE;
>         }
> --
> 2.42.0
>

