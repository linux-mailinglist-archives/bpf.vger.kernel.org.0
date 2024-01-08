Return-Path: <bpf+bounces-19190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C59DC827050
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 14:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E96B51C228AE
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 13:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408DD4597E;
	Mon,  8 Jan 2024 13:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwOD3s4Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D7045943
	for <bpf@vger.kernel.org>; Mon,  8 Jan 2024 13:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-557dcb0f870so396113a12.2
        for <bpf@vger.kernel.org>; Mon, 08 Jan 2024 05:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704721777; x=1705326577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/dppo67RVAjc4Gf+PU21CXfwM4RbMYMPqnFHtOQcPM=;
        b=gwOD3s4YjGyVIfldLlpIxY3pZDAZk1YpdE4eZ01ZRQZzDjOsP7wKSLceXd0anGOYyf
         3vAK26UnWG8dvOzS+OiqfySszWxXlHKglWIFZehdL+xzowuV9ESwtiJ+rIqEBQzU7ZCT
         Yn4JiWLSKOp3BwCGjA/Q/M4MkF/z7T6sJhWeyKB6NvSl3r/IhE4RzrQ8mzwVjPBfhkmP
         H6JHO0Oqz5xp4qtdm1ww5L4QeHwmB13usMAIYJ+32U1STy51cGY7ntuLYHX9yRMLGmDI
         7zxyWPgX+aH6HOdQMCK2pYHhBOtcUsbsCm70gueBWR7gcvE6/NsbBygnOjMRnk02IIwq
         aVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704721777; x=1705326577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/dppo67RVAjc4Gf+PU21CXfwM4RbMYMPqnFHtOQcPM=;
        b=uEubhpUsetWOD1PZ10wG/UeV0ARbn34TSlGqCI3XBdbQgE5fvMpLL2hGsHbzWP67kF
         LzvdedD1yoItgnWwdV86DozeNVPWiIe5tGCGh2MV2yF9q8FnAiszTU8VcrYUpCk5gjCb
         64A5XgAH7DbG/zFQjHd2WMyOuh3PlgoOd0PK7pIbRoDwf85dq72yHtFqoHMVL0p7l1i/
         SJfMBWgrn3P6h6jplpFAmGe4kEaCdJqLCWVxJ31Vw57Y0ap3YoGfZFHoLCnkcN27wrWs
         TVh9b2AtYnmg4Phq88BLY+2+iqFIPm1byf7a03/F7rYnLoTEXPZrNBSpWjLE7C0NL0aw
         ovyw==
X-Gm-Message-State: AOJu0YyKEZkjYklLb4BxrPwJwKrZPRF0K8KcK+AXuwZfAQauaUGzcCf0
	KZnPbvKT9MBWJEXb/19U6u12+afh3+FGAOQur5w=
X-Google-Smtp-Source: AGHT+IG5vMQXX2C3JznKW0WnIqOtYqp/+vu8T0kOIFviVJ/4P8rkW6HSgPINHfvLmB8MdETTxmMVyFGJ0Y8UPhFt0a0=
X-Received: by 2002:a17:906:398e:b0:a28:cb84:1888 with SMTP id
 h14-20020a170906398e00b00a28cb841888mr1769730eje.2.1704721777048; Mon, 08 Jan
 2024 05:49:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108132802.6103-1-eddyz87@gmail.com> <20240108132802.6103-3-eddyz87@gmail.com>
In-Reply-To: <20240108132802.6103-3-eddyz87@gmail.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Date: Mon, 8 Jan 2024 05:49:25 -0800
Message-ID: <CAHo-OowJWNFMAEwvFhaPUevHjTYBe71NuMgYLBShtzxFcSQ3jw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: infer packet range for 'if pkt ==/!=
 pkt_end' comparisons
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(I've looked at all 3 patches, and they seem fine... but I don't claim
to understand the intricacies of the verifier/registers/etc well
enough to be certain)

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

it's possible this would be better without the 'goto' as just 'if (rA
=3D=3D rB) ...'

>
> It is valid to infer that R bytes are available in packet.
> This change should allow verification of BPF generated for
> C code like below:
>
>   if (data + 42 !=3D data_end) { ... }

this should probably be:
  if (data + 42 !=3D data_end) return;
  ...

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
> +               break;
>         default:
>                 return false;
>         }
> --
> 2.43.0
>

