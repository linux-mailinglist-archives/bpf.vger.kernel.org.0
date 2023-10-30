Return-Path: <bpf+bounces-13611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E98F7DBBC4
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 15:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F182B20D7C
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 14:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD8C179BA;
	Mon, 30 Oct 2023 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcEyUoSq"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5731179A9
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 14:28:25 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50993E1;
	Mon, 30 Oct 2023 07:28:23 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9c41e95efcbso641463566b.3;
        Mon, 30 Oct 2023 07:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698676102; x=1699280902; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u0Ba+CU8RcT0wuH5/vn/ZGnDcbiiXPMOx61eDYzjvoA=;
        b=IcEyUoSqMXAkH1hSTbTjA7m6yljNU4zBciDCZ+zZ/KATk8X8rp9fg3Sl71IPpR/l3W
         k6RRJNlTGFog1v+iAlhWFP/JCMXEZDTlFsX6HVeW3gozF/gj4ynf4d3Ih6TctTLFRpsa
         2mTimkzuyiTxX2kqrTnz2SUhV+26m5qGm1ScAsYDohcP/IID3aHMTyeg9eV0+zxQFLTw
         iUXTbEYynl4gE9vSPfPA8ldHRN5Oqa607B7UcH59C9aGT25//SrIsnNBtbWFWS0QpWed
         hSEo4At08tiEcomgN74OUTyb6MGQ5UyCxjMKnl55XDb2GWKI4LabKk35zKy5pbIJUuDq
         a9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698676102; x=1699280902;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u0Ba+CU8RcT0wuH5/vn/ZGnDcbiiXPMOx61eDYzjvoA=;
        b=OGEk1DP2L8A9Yq5894Yy0XfPo4dn7hTMYmAQ/7OHnnhE1t31A5Zh+j5LDhw6uA8juu
         lVbziaAUPhOoI7pZbdcO3mnv4B9lsU+bTUmmsdGT7Gh1ecurl8vp763950P7m3WSrbsk
         8PsOJBPBt4yHL0XdqiZCZVf0m807qKYeMQvP6Bn2jwibHZ3iH6eJU7j27ytiSyP4jFPO
         cnkbKMa56zhprxCAHyhGva+/1Joo+k3UnKo/42dtJaw6O47vkHjuRxUE8/woR7JQVsmn
         7LFKBFCKhBwcnKiCzsKMrgpg7Axn8ZwjP0ALOhybFv/oYkmq8Yq/qeXO8DWUcEbocinZ
         jlMA==
X-Gm-Message-State: AOJu0Yw+i/WD5ArqMIxibwv0QhFolgyLRl1T6KtoLF5qL/txT/ZHW+2S
	ibApPwSu7N4zAiEcHpGBSh4=
X-Google-Smtp-Source: AGHT+IE1AosW5mAoF5xqHP39ytt9ZiS0AAWnK83MbaNEXJL1yVUOSHmdhJBL6uK2A4jrxQJ0WYrUNw==
X-Received: by 2002:a17:907:26c4:b0:9b2:aa2f:ab69 with SMTP id bp4-20020a17090726c400b009b2aa2fab69mr7966571ejc.30.1698676101528;
        Mon, 30 Oct 2023 07:28:21 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id x15-20020a1709065acf00b0099bcf9c2ec6sm6059183ejs.75.2023.10.30.07.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 07:28:21 -0700 (PDT)
Message-ID: <0ee068765d5992f4907a6d3320d4c7c5b9e6e4ba.camel@gmail.com>
Subject: Re: [RFC bpf 1/2] bpf: Fix precision tracking for BPF_ALU |
 BPF_TO_BE | BPF_END
From: Eduard Zingerman <eddyz87@gmail.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andriin@fb.com>,  Alexei Starovoitov <ast@kernel.org>, Toke
 =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,  John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  stable@vger.kernel.org, Mohamed Mahmoud
 <mmahmoud@redhat.com>, Tao Lyu <tao.lyu@epfl.ch>
Date: Mon, 30 Oct 2023 16:28:19 +0200
In-Reply-To: <20231030132145.20867-2-shung-hsi.yu@suse.com>
References: <20231030132145.20867-1-shung-hsi.yu@suse.com>
	 <20231030132145.20867-2-shung-hsi.yu@suse.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-10-30 at 21:21 +0800, Shung-Hsi Yu wrote:
> BPF_END and BPF_NEG has a different specification for the source bit in
> the opcode compared to other ALU/ALU64 instructions, and is either
> reserved or use to specify the byte swap endianness. In both cases the
> source bit does not encode source operand location, and src_reg is a
> reserved field.
>=20
> backtrack_insn() currently does not differentiate BPF_END and BPF_NEG
> from other ALU/ALU64 instructions, which leads to r0 being incorrectly
> marked as precise when processing BPF_ALU | BPF_TO_BE | BPF_END
> instructions. This commit teaches backtrack_insn() to correctly mark
> precision for such case.
>=20
> While precise tracking of BPF_NEG and other BPF_END instructions are
> correct and does not need fixing because their source bit are unset and
> thus treated as the BPF_K case, this commit opt to process all BPF_NEG
> and BPF_END instructions within the same if-clause so it better aligns
> with current convention used in the verifier (e.g. check_alu_op).
>=20
> Fixes: b5dc0163d8fd ("bpf: precise scalar_value tracking")
> Cc: stable@vger.kernel.org
> Reported-by: Mohamed Mahmoud <mmahmoud@redhat.com>
> Tested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Tested-by: Tao Lyu <tao.lyu@epfl.ch>
> Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> ---
>  kernel/bpf/verifier.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 873ade146f3d..646dc49263fd 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3426,7 +3426,12 @@ static int backtrack_insn(struct bpf_verifier_env =
*env, int idx, int subseq_idx,
>  	if (class =3D=3D BPF_ALU || class =3D=3D BPF_ALU64) {
>  		if (!bt_is_reg_set(bt, dreg))
>  			return 0;
> -		if (opcode =3D=3D BPF_MOV) {
> +		if (opcode =3D=3D BPF_END || opcode =3D=3D BPF_NEG) {
> +			/* sreg is reserved and unused
> +			 * dreg still need precision before this insn
> +			 */
> +			return 0;
> +		} else if (opcode =3D=3D BPF_MOV) {
>  			if (BPF_SRC(insn->code) =3D=3D BPF_X) {
>  				/* dreg =3D sreg or dreg =3D (s8, s16, s32)sreg
>  				 * dreg needs precision after this insn


