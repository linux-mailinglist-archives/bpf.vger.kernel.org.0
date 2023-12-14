Return-Path: <bpf+bounces-17826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A73FE8131B5
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 14:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CF531C21A95
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 13:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907C856B68;
	Thu, 14 Dec 2023 13:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsCoIcZl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A033111;
	Thu, 14 Dec 2023 05:36:56 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32f8441dfb5so7373326f8f.0;
        Thu, 14 Dec 2023 05:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702561015; x=1703165815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6S2+AU1W7+DGowTp+6xRDiKLzpMDOMD4cB5epYgiBJA=;
        b=YsCoIcZlpgEbD91G0hPIliOu/4DFbJ7khNODY6WSu8F3WrryH7s8P+i3ymxUqcHRmb
         RSSH1EWk6YY5GrdIIXe8umLG/vLRAi81ZX2ydfkF2X/G+Bap3+5IxOQTMwNkl+6p1y2g
         M3Uyp2YHgX9MDDJHi08SnXW6lQu+9ONnVQeXrdoIklYda/yWZNaUSqk1zjRcHiUsQN09
         ypyfluRsRw0XQHNgzUfJpFEeMryYB1q1DeKznTjGpJ0HEMlDotSPu7HBcuHJgXLNL5hR
         dadnI/Hbsj1GRBILAyKjTeXIKJ7BaXlcH2lOCcaZ8mJ2KV8+w9R8jW9+GrfjYtZB48r8
         jQiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702561015; x=1703165815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6S2+AU1W7+DGowTp+6xRDiKLzpMDOMD4cB5epYgiBJA=;
        b=aLdGaFmw67zngrbDolOUPZ2dbGmUcjZMgh0fWUnxBF6U+65ErKlYitbaHWzWQH3sI4
         dR6BAnghe1jWI9Jnoe7YjQCL+6JNa6MKOWRtL0rkTunDeIdeby7kP/0tlU0VlVipUQD7
         4GbMOO2akMgur378BtzAB5H1Olz5I9dlb0MXOnlddsIhyB5cpnTXBW3I//RpIRI/98lh
         6iOxKi0wwFV5QmsYDUze9z0ron5ENiwP+w9XauxHXXQnSKc4sUvbKyMGsmkIL+X+33Kn
         mJLoBvYe3wAp2yvo4/ZRGeKTjylyb/tIHQK5eMD6CoF1yd7kOnHn31+8hZGid5yuZant
         b1zg==
X-Gm-Message-State: AOJu0YyDJ6Lt8M4+WEHxYnj/13XSCfzpU6BnLqrHSebtPI3Zwa1Otujm
	ygQxLo4TUBLEZ86fbj0mIsavz0QeK//bN+GKfaE=
X-Google-Smtp-Source: AGHT+IHoAnSXH6VL2+jFHotZlpX2frkhvp7d85GQIlKqay5gsslFEaKZdbkSq7mjO1ppywoG3BXsuLxJ9SOYsZJ0l1c=
X-Received: by 2002:adf:f412:0:b0:336:3434:7a6e with SMTP id
 g18-20020adff412000000b0033634347a6emr2237437wro.131.1702561014531; Thu, 14
 Dec 2023 05:36:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214130007.33281-1-tushar.vyavahare@intel.com> <ZXsBx31uOqyrfDvD@boxer>
In-Reply-To: <ZXsBx31uOqyrfDvD@boxer>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 14 Dec 2023 05:36:42 -0800
Message-ID: <CAADnVQLEXLO-5CHcY3mVPjtLq7TCgkyYXpqm73aakBCdr3Kg4w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/xsk: fix for SEND_RECEIVE_UNALIGNED test
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Tushar Vyavahare <tushar.vyavahare@intel.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	"Karlsson, Magnus" <magnus.karlsson@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 5:23=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Thu, Dec 14, 2023 at 01:00:07PM +0000, Tushar Vyavahare wrote:
>
> I think target tree should be bpf, not bpf-next

no. selftests/bpf are fine with bpf-next 99% of the time.

> > Fix test broken by shared umem test and framework enhancement commit.
> >
> > Correct the current implementation of pkt_stream_replace_half() by
> > ensuring that nb_valid_entries are not set to half, as this is not true
> > for all the tests. Ensure that the expected value for valid_entries for
> > the SEND_RECEIVE_UNALIGNED test equals the total number of packets sent=
,
> > which is 4096.
> >
> > Create a new function called pkt_stream_pkt_set() that allows for packe=
t
> > modification to meet specific requirements while ensuring the accurate
> > maintenance of the valid packet count to prevent inconsistencies in pac=
ket
> > tracking.
> >
> > Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > Fixes: 6d198a89c004 ("selftests/xsk: Add a test for shared umem feature=
")
> > Reported-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
>
> besides subject fix,
>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>
> >
> > ---
> > v1->v2
> > - Updated git commit message for better clarity as suggested in the
> >   review. [Maciej]
> > - Renamed pkt_valid() to set_pkt_valid() for better clarity. [Maciej]
> > - Fixed double space issue. [Maciej]
> > - Included Magnus's acknowledgement.
> > - Remove the redundant part from the set_pkt_valid() if condition.
> >   [Maciej]
> > - remove pkt_modify().
> > - added pkt_stream_pkt_set(). [Magnus]
> > - renamed mod_valid to prev_pkt_valid. [Tirtha]
> > ---
> >  tools/testing/selftests/bpf/xskxceiver.c | 25 +++++++++++++++---------
> >  1 file changed, 16 insertions(+), 9 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/s=
elftests/bpf/xskxceiver.c
> > index b604c570309a..b1102ee13faa 100644
> > --- a/tools/testing/selftests/bpf/xskxceiver.c
> > +++ b/tools/testing/selftests/bpf/xskxceiver.c
> > @@ -634,16 +634,24 @@ static u32 pkt_nb_frags(u32 frame_size, struct pk=
t_stream *pkt_stream, struct pk
> >       return nb_frags;
> >  }
> >
> > +static bool set_pkt_valid(int offset, u32 len)
> > +{
> > +     return len <=3D MAX_ETH_JUMBO_SIZE;
> > +}
> > +
> >  static void pkt_set(struct pkt_stream *pkt_stream, struct pkt *pkt, in=
t offset, u32 len)
> >  {
> >       pkt->offset =3D offset;
> >       pkt->len =3D len;
> > -     if (len > MAX_ETH_JUMBO_SIZE) {
> > -             pkt->valid =3D false;
> > -     } else {
> > -             pkt->valid =3D true;
> > -             pkt_stream->nb_valid_entries++;
> > -     }
> > +     pkt->valid =3D set_pkt_valid(offset, len);
> > +}
> > +
> > +static void pkt_stream_pkt_set(struct pkt_stream *pkt_stream, struct p=
kt *pkt, int offset, u32 len)
> > +{
> > +     bool prev_pkt_valid =3D pkt->valid;
> > +
> > +     pkt_set(pkt_stream, pkt, offset, len);
> > +     pkt_stream->nb_valid_entries +=3D pkt->valid - prev_pkt_valid;
> >  }
> >
> >  static u32 pkt_get_buffer_len(struct xsk_umem_info *umem, u32 len)
> > @@ -665,7 +673,7 @@ static struct pkt_stream *__pkt_stream_generate(u32=
 nb_pkts, u32 pkt_len, u32 nb
> >       for (i =3D 0; i < nb_pkts; i++) {
> >               struct pkt *pkt =3D &pkt_stream->pkts[i];
> >
> > -             pkt_set(pkt_stream, pkt, 0, pkt_len);
> > +             pkt_stream_pkt_set(pkt_stream, pkt, 0, pkt_len);
> >               pkt->pkt_nb =3D nb_start + i * nb_off;
> >       }
> >
> > @@ -700,10 +708,9 @@ static void __pkt_stream_replace_half(struct ifobj=
ect *ifobj, u32 pkt_len,
> >
> >       pkt_stream =3D pkt_stream_clone(ifobj->xsk->pkt_stream);
> >       for (i =3D 1; i < ifobj->xsk->pkt_stream->nb_pkts; i +=3D 2)
> > -             pkt_set(pkt_stream, &pkt_stream->pkts[i], offset, pkt_len=
);
> > +             pkt_stream_pkt_set(pkt_stream, &pkt_stream->pkts[i], offs=
et, pkt_len);
> >
> >       ifobj->xsk->pkt_stream =3D pkt_stream;
> > -     pkt_stream->nb_valid_entries /=3D 2;
> >  }
> >
> >  static void pkt_stream_replace_half(struct test_spec *test, u32 pkt_le=
n, int offset)
> > --
> > 2.34.1
> >
>

