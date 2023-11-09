Return-Path: <bpf+bounces-14557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D4F7E64F0
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 09:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 010941C20A37
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 08:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EDB107A8;
	Thu,  9 Nov 2023 08:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJyLbeGk"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B640910797;
	Thu,  9 Nov 2023 08:08:27 +0000 (UTC)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86DD2D44;
	Thu,  9 Nov 2023 00:08:26 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-6708d2df1a3so937116d6.1;
        Thu, 09 Nov 2023 00:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699517306; x=1700122106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dh3aK/boLb55s+2CloV3PQFJiW07ZanTj3NExkitxvU=;
        b=WJyLbeGk62ZRdwPccPzEMqTIB4ABmtCO4CJkgVQ3URAaUkkmWusilE3sGH+OXUKGye
         N1xPnBwQcQHTIaz5bstDLKcjd5/Tr7fkRNfIwbR+3wCZW+n6hDw6VsFRmBJbZuuanI/0
         oT9jZpu4Jblh3IBfhC8uhADByBXtfjew3kq8GfIDwu6Uxs89/ZJOJAYghrQkGQbf6Mvm
         rrwLtxdhPbLfcZDpzYICdSIgSm3wEd7KohYrDVydIwwlJj7Yzha1jhj72kFkWehbZV8d
         FTTfHfrzEGw2RuUWwkOeNuhymTCF/g2ihk04cVatkm1OzFp0CZ4BfZiVlU29i8P3aZGT
         sGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699517306; x=1700122106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dh3aK/boLb55s+2CloV3PQFJiW07ZanTj3NExkitxvU=;
        b=ugzgUT9Yy9iemVs+LMReznS0m5i5S5B4vEqx9w3JdZcepiBQUo/PLxD/alkCjhtQQe
         a3n8fIGGc1T8t9Ii6DUUPeHdGoLIfD/RhxxjqNYQAb7AzrvTTXiCN0B80FIeNOEmhFjO
         bMkOBP29tsGXXMO6YuxOdYIKqzCv9RvHNICNbaQr/cddztNpdLvsDqii8U9BKp3AzWr4
         WIn9Jm9ziZ4g4dY72vaVi7KaaXque8o470CXFm+4qcy6ydjAKdVKBO/Qrwqgwb/LN3Q1
         IdUfK4FC6f/JJfPLhDkmpqDIq5B6oHNDTC5sEVJVE+hfNSEMzrFJ7W9G2On6R9cu5/K8
         /k+A==
X-Gm-Message-State: AOJu0YzOjxEdxNxj2x3QlErmbYEVquDBTRq2eV0iCPSJaQt1D6aWNVNI
	pQWwMwxGSNCtRyjljaso7DZ/x6SWdj6cU+7hFsE=
X-Google-Smtp-Source: AGHT+IH8i4A2b188pIGfsrVqj2SrzsVFFgMXFKHrIhORMO+ipexlXg3AcHeM3WCYcW218uLn10ecZsqlQ6SVT97+M0M=
X-Received: by 2002:a05:6214:1187:b0:66d:1bbb:e9f8 with SMTP id
 t7-20020a056214118700b0066d1bbbe9f8mr4089852qvv.6.1699517305657; Thu, 09 Nov
 2023 00:08:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231108110048.1988128-1-anders.roxell@linaro.org> <CAEf4Bzbbix1KpCKGhK3dnFK99YNyyQzXHp9RzDtd72x7-c6M3A@mail.gmail.com>
In-Reply-To: <CAEf4Bzbbix1KpCKGhK3dnFK99YNyyQzXHp9RzDtd72x7-c6M3A@mail.gmail.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Thu, 9 Nov 2023 09:08:14 +0100
Message-ID: <CAJ8uoz1_g7mZfqUqMfQZEewGgDB0tCjWB_Eb+D6MmBxGS0Zt-w@mail.gmail.com>
Subject: Re: [PATCHv2] selftests: bpf: xskxceiver: ksft_print_msg: fix format
 type error
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Anders Roxell <anders.roxell@linaro.org>, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 8 Nov 2023 at 18:03, Andrii Nakryiko <andrii.nakryiko@gmail.com> wr=
ote:
>
> On Wed, Nov 8, 2023 at 3:00=E2=80=AFAM Anders Roxell <anders.roxell@linar=
o.org> wrote:
> >
> > Crossbuilding selftests/bpf for architecture arm64, format specifies
> > type error show up like.
> >
> > xskxceiver.c:912:34: error: format specifies type 'int' but the argumen=
t
> > has type '__u64' (aka 'unsigned long long') [-Werror,-Wformat]
> >  ksft_print_msg("[%s] expected meta_count [%d], got meta_count [%d]\n",
> >                                                                 ~~
> >                                                                 %llu
> >                 __func__, pkt->pkt_nb, meta->count);
> >                                        ^~~~~~~~~~~
> > xskxceiver.c:929:55: error: format specifies type 'unsigned long long' =
but
> >  the argument has type 'u64' (aka 'unsigned long') [-Werror,-Wformat]
> >  ksft_print_msg("Frag invalid addr: %llx len: %u\n", addr, len);
> >                                     ~~~~             ^~~~
> >
> > Fixing the issues by casting to (unsigned long long) and changing the
> > specifiers to be %llx, since with u64s it might be %llx or %lx,
> > depending on architecture.
> >
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >  tools/testing/selftests/bpf/xskxceiver.c | 19 ++++++++++++-------
> >  1 file changed, 12 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/s=
elftests/bpf/xskxceiver.c
> > index 591ca9637b23..1ab9512f5aa2 100644
> > --- a/tools/testing/selftests/bpf/xskxceiver.c
> > +++ b/tools/testing/selftests/bpf/xskxceiver.c
> > @@ -908,8 +908,9 @@ static bool is_metadata_correct(struct pkt *pkt, vo=
id *buffer, u64 addr)
> >         struct xdp_info *meta =3D data - sizeof(struct xdp_info);
> >
> >         if (meta->count !=3D pkt->pkt_nb) {
> > -               ksft_print_msg("[%s] expected meta_count [%d], got meta=
_count [%d]\n",
> > -                              __func__, pkt->pkt_nb, meta->count);
> > +               ksft_print_msg("[%s] expected meta_count [%d], got meta=
_count [%llx]\n",
>
> why hex? %llu?

You are correct, it should be %llu in both these cases. The original
%d was incorrect here and good that it was corrected to a 64-bit
unsigned.

>
> > +                              __func__, pkt->pkt_nb,
> > +                              (unsigned long long)meta->count);
> >                 return false;
> >         }
> >
> > @@ -926,11 +927,13 @@ static bool is_frag_valid(struct xsk_umem_info *u=
mem, u64 addr, u32 len, u32 exp
> >
> >         if (addr >=3D umem->num_frames * umem->frame_size ||
> >             addr + len > umem->num_frames * umem->frame_size) {
> > -               ksft_print_msg("Frag invalid addr: %llx len: %u\n", add=
r, len);
> > +               ksft_print_msg("Frag invalid addr: %llx len: %u\n",
> > +                              (unsigned long long)addr, len);
> >                 return false;
> >         }
> >         if (!umem->unaligned_mode && addr % umem->frame_size + len > um=
em->frame_size) {
> > -               ksft_print_msg("Frag crosses frame boundary addr: %llx =
len: %u\n", addr, len);
> > +               ksft_print_msg("Frag crosses frame boundary addr: %llx =
len: %u\n",
> > +                              (unsigned long long)addr, len);
> >                 return false;
> >         }
> >
> > @@ -1029,7 +1032,8 @@ static int complete_pkts(struct xsk_socket_info *=
xsk, int batch_size)
> >                         u64 addr =3D *xsk_ring_cons__comp_addr(&xsk->um=
em->cq, idx + rcvd - 1);
> >
> >                         ksft_print_msg("[%s] Too many packets completed=
\n", __func__);
> > -                       ksft_print_msg("Last completion address: %llx\n=
", addr);
> > +                       ksft_print_msg("Last completion address: %llx\n=
",
> > +                                      (unsigned long long)addr);
> >                         return TEST_FAILURE;
> >                 }
> >
> > @@ -1513,8 +1517,9 @@ static int validate_tx_invalid_descs(struct ifobj=
ect *ifobject)
> >         }
> >
> >         if (stats.tx_invalid_descs !=3D ifobject->xsk->pkt_stream->nb_p=
kts / 2) {
> > -               ksft_print_msg("[%s] tx_invalid_descs incorrect. Got [%=
u] expected [%u]\n",
> > -                              __func__, stats.tx_invalid_descs,
> > +               ksft_print_msg("[%s] tx_invalid_descs incorrect. Got [%=
llx] expected [%u]\n",
>
> should this be %llu? Or the switch to the hex was intentional?

Same thing here. The original %u should really have been %llu since
the stats is 64-bits. But no reason for the hex here since it is not
an address.

> > +                              __func__,
> > +                              (unsigned long long)stats.tx_invalid_des=
cs,
> >                                ifobject->xsk->pkt_stream->nb_pkts);
> >                 return TEST_FAILURE;
> >         }
> > --
> > 2.42.0
> >
>

