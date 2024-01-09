Return-Path: <bpf+bounces-19242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD721827C33
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 01:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4590628516F
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 00:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8D8A50;
	Tue,  9 Jan 2024 00:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcMO+gad"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FFD647
	for <bpf@vger.kernel.org>; Tue,  9 Jan 2024 00:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50e7d6565b5so2541416e87.0
        for <bpf@vger.kernel.org>; Mon, 08 Jan 2024 16:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704761155; x=1705365955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhWFTWUzeI0kbfJO5FVpC2TNo1q6ZT2LOEVaOqDoCKk=;
        b=KcMO+gadtDKEVXc+KKzngjin9SGdSBWs33BUqYHjxya9C9qlYZDO7ceNcMqZPTj1Nw
         dBztWAb01Aa27mxUUgIVgJNGtS9p9JGJbgylQ1tvDSo1DOWvb8v0oi1ShPUpg46jh9DM
         Pndm0btieocjMsqSirv2ZfHosrKUGyg2jwpfzXajyHe90RG26q9iULsQVKYkzETniM1c
         IciA3m6OV9E7/gsM6EsQDoGWKiO89V3EeXOnSxo2dTqWecktSoHYI6lVRG/rUKN28ncO
         5l+dYbryv0zexKsUAtZq73s5cU1ikt2tUIyh9eQc4MKttvZSQrz253jIQaOpqOw2672d
         D+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704761155; x=1705365955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GhWFTWUzeI0kbfJO5FVpC2TNo1q6ZT2LOEVaOqDoCKk=;
        b=Rx37qeXhqLRorPJSb8uPgQC1BAqhfBkNoSDhdnVpZzm64XKXASU68H8of9B6wM62lW
         905vhYqMNK3vo4xaD2Ypgr8c6TFl/ecJ+31joUwN1D+oRHHJ3BnJfUGSIT6/i442qcGL
         GVIXquL9mtXA8TwGxXLjcQXqSy/rJ3p0dkuBrJlSW0jvMv4fhkwpM3WIzgOLazCIpjxo
         VKj5zDz34ZIIcaXM6UyJqjvzINDxVUbM/L71FJZ2fwF1g1zz8YGIUFGPhC2wAUEEvqRw
         4FrsR4VBhYEfCGucAg8CDXGDA2aSiN1BuW9lGAxKnoVBvUaoCEHmTB3oIALd1u3EmrOj
         qVRA==
X-Gm-Message-State: AOJu0YyhdCHygO1Y5PTa6SNphQ8o8dmpfpZl5YYaFC0b9U4AwB2QCSpU
	0m5bfQ6vGkq9+vZmCbVKT8+cu/rQfJFWmdmIGiQ=
X-Google-Smtp-Source: AGHT+IHrGInvzAxcJl1uUIILhJRBN6awd3hqjvlVUphfcD8inMM3z4xgm9kfwnUTNwfb7tdHfhdB1mR8KTfi+lHO3AQ=
X-Received: by 2002:ac2:4853:0:b0:50e:7dcc:ee63 with SMTP id
 19-20020ac24853000000b0050e7dccee63mr1741138lfy.35.1704761154431; Mon, 08 Jan
 2024 16:45:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108132802.6103-1-eddyz87@gmail.com> <20240108132802.6103-3-eddyz87@gmail.com>
In-Reply-To: <20240108132802.6103-3-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 8 Jan 2024 16:45:41 -0800
Message-ID: <CAEf4BzYSPGmMucCwADeKYcivyyvnf0jDvxuRGieMGeW8+Ci89w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: infer packet range for 'if pkt ==/!=
 pkt_end' comparisons
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, zenczykowski@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 5:28=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> Extend try_match_pkt_pointers() to handle =3D=3D and !=3D operations.
> For instruction:
>
>       .--------------- pointer to packet with some range R
>       |     .--------- pointer to packet end
>       v     v
>   if rA =3D=3D rB goto ...
>
> It is valid to infer that R bytes are available in packet.
> This change should allow verification of BPF generated for
> C code like below:
>
>   if (data + 42 !=3D data_end) { ... }
>
> Suggested-by: Maciej =C5=BBenczykowski <zenczykowski@gmail.com>
> Link: https://lore.kernel.org/bpf/CAHo-Oow5V2u4ZYvzuR8NmJmFDPNYp0pQDJX66r=
ZqUjFHvhx82A@mail.gmail.com/
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  kernel/bpf/verifier.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 918e6a7912e2..b229ba0ad114 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14677,6 +14677,7 @@ static bool try_match_pkt_pointers(const struct b=
pf_insn *insn,
>                                    struct bpf_verifier_state *this_branch=
,
>                                    struct bpf_verifier_state *other_branc=
h)
>  {
> +       struct bpf_verifier_state *eq_branch;
>         int opcode =3D BPF_OP(insn->code);
>         int dst_regno =3D insn->dst_reg;
>
> @@ -14713,6 +14714,13 @@ static bool try_match_pkt_pointers(const struct =
bpf_insn *insn,
>                 find_good_pkt_pointers(other_branch, dst_reg, dst_reg->ty=
pe, opcode =3D=3D BPF_JLT);
>                 mark_pkt_end(this_branch, dst_regno, opcode =3D=3D BPF_JL=
E);
>                 break;
> +       case BPF_JEQ:
> +       case BPF_JNE:
> +               /* pkt_data =3D=3D/!=3D pkt_end, pkt_meta =3D=3D/!=3D pkt=
_data */
> +               eq_branch =3D opcode =3D=3D BPF_JEQ ? other_branch : this=
_branch;
> +               find_good_pkt_pointers(eq_branch, dst_reg, dst_reg->type,=
 true);
> +               mark_pkt_end(eq_branch, dst_regno, false);

hm... if pkt_data !=3D pkt_end in this_branch, can we really infer
whether reg->range is BEYOND_PKT_END or AT_PKT_END? What if it's
IN_FRONT_OF_PKT_END?

> +               break;
>         default:
>                 return false;
>         }
> --
> 2.43.0
>

