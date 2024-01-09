Return-Path: <bpf+bounces-19240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA972827C27
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 01:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86DB01F241CD
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 00:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E5539E;
	Tue,  9 Jan 2024 00:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHGx94nJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63B0370
	for <bpf@vger.kernel.org>; Tue,  9 Jan 2024 00:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33677fb38a3so2570256f8f.0
        for <bpf@vger.kernel.org>; Mon, 08 Jan 2024 16:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704760869; x=1705365669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWBrUHm1A8atZLyptd7jmcXQtY/89jU2BTsJtF2nbqY=;
        b=cHGx94nJ62ByfPA+AWV8PTHYomYKvzMPct9hS/TVPxIYcdk5F9eyBPfkUc0Ds3M14R
         m4tWC+78zJhP2waPcWj9mZea1igmPD+ZMZwDpbDrBkA2LTNK1PTeCXnXw2PenTEX/vNT
         BMP/Zg+bNUXgh44+g8iN37S10gmwjXfIt2nS1KrLdqvLW8jqHW/7tQNlKPPnbb6EFVtW
         LgOuRNM1NIm3WyaTzx93SIJPi1f6hbXgkdkjYhaUK78UkTrOd+M3wb670cyISajmmLHr
         YsLynvIDuWxPLaqh9OaXjY3Rv4m/vsJW/KFJ0KYO4d9qKMIDlreOyD5DMNPgapEJeUP1
         BEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704760869; x=1705365669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWBrUHm1A8atZLyptd7jmcXQtY/89jU2BTsJtF2nbqY=;
        b=v9DBVDp18s7SOCfZQherZhL36dkcnXThWQyr3PM9inV2IxBF/IknFNOZnqs9CLIED/
         fuzhtK7NPIP7EOEfDu9zxCDaW/ZMSlMSNjov8rDavneWLTgckqbyAwMjF8ipjcOgdjRj
         Q21PvN/2DKRbV0EY8igsZ6+XtrWMNPl2c5EuuYC5q+yCibsfqjCIzzu4VmkUnk+J8u9l
         SKL0akaGUOlwzN/EwwyeHOaY0zlSjDzczGC3k3cnAREkEF5uV4WG2EWhPdxCZ78oOUy6
         kS5bWzkDK4YSIvqa/5NatkNubICd3xc6ij4b1yAPGxiPvIZFh+0fqz2uMnYzJ9kSNMKr
         4aeA==
X-Gm-Message-State: AOJu0Yzy7jqOjfgjZv1vRtISu0tLMRUmZS9xoIyQdiTGavzVQVXe7jw4
	pO4n5xE0FVgNdZZ+4/VkaJ8X3cuWSNmm1xTUXCcIqhZW
X-Google-Smtp-Source: AGHT+IHWO9dEi72YIW2KIhu6QBSAtwm8+ToSBYzXRzYd3Jtlz3KL+aEKuSKmFUnMYTFYkpyep1nZk02JOjlTwNqAvUM=
X-Received: by 2002:a05:6000:1147:b0:337:6258:4e73 with SMTP id
 d7-20020a056000114700b0033762584e73mr113558wrx.87.1704760868956; Mon, 08 Jan
 2024 16:41:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108132802.6103-1-eddyz87@gmail.com> <20240108132802.6103-2-eddyz87@gmail.com>
In-Reply-To: <20240108132802.6103-2-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 8 Jan 2024 16:40:56 -0800
Message-ID: <CAEf4Bzb5NNWRroWtg5cRy4FUV8-AhrRbsd7_D12F3SJu7hTcqw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: simplify try_match_pkt_pointers()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, zenczykowski@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 5:28=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> Reduce number of cases handled in try_match_pkt_pointers()
> to <pkt_data> <op> <pkt_end> or <pkt_meta> <op> <pkt_data>
> by flipping opcode.
>
> Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  kernel/bpf/verifier.c | 104 ++++++++++--------------------------------
>  1 file changed, 24 insertions(+), 80 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index adbf330d364b..918e6a7912e2 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14677,6 +14677,9 @@ static bool try_match_pkt_pointers(const struct b=
pf_insn *insn,
>                                    struct bpf_verifier_state *this_branch=
,
>                                    struct bpf_verifier_state *other_branc=
h)
>  {
> +       int opcode =3D BPF_OP(insn->code);
> +       int dst_regno =3D insn->dst_reg;
> +
>         if (BPF_SRC(insn->code) !=3D BPF_X)
>                 return false;
>
> @@ -14684,90 +14687,31 @@ static bool try_match_pkt_pointers(const struct=
 bpf_insn *insn,
>         if (BPF_CLASS(insn->code) =3D=3D BPF_JMP32)
>                 return false;
>
> -       switch (BPF_OP(insn->code)) {
> +       if (dst_reg->type =3D=3D PTR_TO_PACKET_END ||
> +           src_reg->type =3D=3D PTR_TO_PACKET_META) {
> +               swap(src_reg, dst_reg);
> +               dst_regno =3D insn->src_reg;
> +               opcode =3D flip_opcode(opcode);
> +       }
> +
> +       if ((dst_reg->type !=3D PTR_TO_PACKET ||
> +            src_reg->type !=3D PTR_TO_PACKET_END) &&
> +           (dst_reg->type !=3D PTR_TO_PACKET_META ||
> +            !reg_is_init_pkt_pointer(src_reg, PTR_TO_PACKET)))
> +               return false;

this inverted original condition just breaks my brain, I can't wrap my
head around it :) I think the original is easier to reason about
because it's two clear allowable patterns for which we do something. I
understand that this early exit reduces nestedness, but at least for
me it would be simpler to have the original non-inverted condition
with a nested switch.


> +
> +       switch (opcode) {
>         case BPF_JGT:
> -               if ((dst_reg->type =3D=3D PTR_TO_PACKET &&
> -                    src_reg->type =3D=3D PTR_TO_PACKET_END) ||
> -                   (dst_reg->type =3D=3D PTR_TO_PACKET_META &&
> -                    reg_is_init_pkt_pointer(src_reg, PTR_TO_PACKET))) {
> -                       /* pkt_data' > pkt_end, pkt_meta' > pkt_data */
> -                       find_good_pkt_pointers(this_branch, dst_reg,
> -                                              dst_reg->type, false);
> -                       mark_pkt_end(other_branch, insn->dst_reg, true);
> -               } else if ((dst_reg->type =3D=3D PTR_TO_PACKET_END &&
> -                           src_reg->type =3D=3D PTR_TO_PACKET) ||
> -                          (reg_is_init_pkt_pointer(dst_reg, PTR_TO_PACKE=
T) &&
> -                           src_reg->type =3D=3D PTR_TO_PACKET_META)) {
> -                       /* pkt_end > pkt_data', pkt_data > pkt_meta' */
> -                       find_good_pkt_pointers(other_branch, src_reg,
> -                                              src_reg->type, true);
> -                       mark_pkt_end(this_branch, insn->src_reg, false);
> -               } else {
> -                       return false;
> -               }
> -               break;

[...]

