Return-Path: <bpf+bounces-18798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 886B28221F3
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 20:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3366D283AFD
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 19:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FAB15AEF;
	Tue,  2 Jan 2024 19:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoSq3zrM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CFD16404
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 19:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a2343c31c4bso1091912266b.1
        for <bpf@vger.kernel.org>; Tue, 02 Jan 2024 11:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704223441; x=1704828241; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ykg6yfMffw2GeED4iX9YAI9YkerDSwG6egIdW11nODo=;
        b=NoSq3zrM2cnkmYfIl6gjbz+WqjJ3yrG5U42ZfUp1fX4Qqq/GNnDZaCBx+TO3+7hOQ8
         31rlGgMdmWeE5VSjXL2ZyAHE3bg8AhhU3c+9REuiUunuD1RMqdkyDx9SuUwQeXaKGKSP
         JfVBozq5TKJbxEmW6jtJMI2F0V/n6L47BB4YF14YoraitFpCpDZiHXZfysUsHEt+Ojmp
         hGZZr5XAmorCDqVmmVHzNr9qMSySQbkvbfeADrm5TsUf276qRNxlkAmDEsn/EWvxK1r/
         Zk5hDf971Tzt5gVqmi/GdNPtmkTQYebt2A1ivk+SavEqszqISZ2D8LqcGHxwvJVjhdy/
         NLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704223441; x=1704828241;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ykg6yfMffw2GeED4iX9YAI9YkerDSwG6egIdW11nODo=;
        b=w5HpCBvieSa6THi9TEbiqZ6Y3ubA2ioUSbQHNHEe8YxTb+n+QJMmr2l52RoNo75FS/
         1oz2A0vE7Osmcc1QhJGkECQGkZk9Fct4rFd4Y0u4/HP3os/9Bbr47B/eP/qtzeHIgcKO
         rHyEe5OYV5avOAx+TQC4ZSJiFruzDWJwPtK2I6M2OAyIKQyntFpYP/XXxIa6Fzx4kWtW
         bYrJAA0HY2q2uWJRjScGlFZxOF4sfKIQpWJtNXwTPEOyakSnycRWjuS2YdBR5C1bw3wR
         pG2P4CVrE3zYChW3l9AEJCaOZuU5h2gMTMSbShECR9fiLVUVc8yVylflXgQDE8BWR3wc
         dr/g==
X-Gm-Message-State: AOJu0YzYcTi1iBPPCVG/av1ASNh9CexIzJCqLcqqllcOJHMSeo7mhOtf
	mvqSnOEN0Cq/joofVfndcikQY+aUnKY=
X-Google-Smtp-Source: AGHT+IHTIGpdZRA6EbVkOcooxsL+qnF++1PGvoraVCLKuxVd0Dds8EXZiski7Ik+x1tjLm178ahQnA==
X-Received: by 2002:a17:906:44:b0:a27:908b:e6b4 with SMTP id 4-20020a170906004400b00a27908be6b4mr1835547ejg.2.1704223441204;
        Tue, 02 Jan 2024 11:24:01 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id fw22-20020a170907501600b00a26b44ac54dsm10784083ejc.68.2024.01.02.11.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 11:24:00 -0800 (PST)
Message-ID: <85731a963139eb226b76069a5422ecbac063dd74.camel@gmail.com>
Subject: Re: Funky verifier packet range error (> check works, != does not).
From: Eduard Zingerman <eddyz87@gmail.com>
To: Maciej =?UTF-8?Q?=C5=BBenczykowski?= <zenczykowski@gmail.com>
Cc: BPF Mailing List <bpf@vger.kernel.org>, Alexei Starovoitov
 <ast@kernel.org>
Date: Tue, 02 Jan 2024 21:23:59 +0200
In-Reply-To: <CAHo-OowjLmtEPmoo2rQ3i4_3mO0Uy6Sr9+pdcv2qCbahdVVgxg@mail.gmail.com>
References: 
	<CAHo-Oow5V2u4ZYvzuR8NmJmFDPNYp0pQDJX66rZqUjFHvhx82A@mail.gmail.com>
	 <1b75e54f235a7cb510768ca8142f15171024dd78.camel@gmail.com>
	 <CAHo-OowjLmtEPmoo2rQ3i4_3mO0Uy6Sr9+pdcv2qCbahdVVgxg@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-01-02 at 10:30 -0800, Maciej =C5=BBenczykowski wrote:
[...]
>=20
> The check is:
>   if (data + 98 !=3D data_end) return;
> so now (after this check) you *know* that 'data + 98 =3D=3D data_end' and
> thus you know there are *exactly* 98 valid bytes.

Apologies, you are correct.
So you want to have something along the following lines:

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a376eb609c41..6ddb34d5b9aa 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14712,6 +14712,28 @@ static bool try_match_pkt_pointers(const struct bp=
f_insn *insn,
                        return false;
                }
                break;
+       case BPF_JEQ:
+       case BPF_JNE:
+               if ((dst_reg->type =3D=3D PTR_TO_PACKET &&
+                    src_reg->type =3D=3D PTR_TO_PACKET_END) ||
+                   (dst_reg->type =3D=3D PTR_TO_PACKET_META &&
+                    reg_is_init_pkt_pointer(src_reg, PTR_TO_PACKET)) ||
+                   (dst_reg->type =3D=3D PTR_TO_PACKET_END &&
+                    src_reg->type =3D=3D PTR_TO_PACKET) ||
+                   (reg_is_init_pkt_pointer(dst_reg, PTR_TO_PACKET) &&
+                    src_reg->type =3D=3D PTR_TO_PACKET_META)) {
+                       /* pkt_data' !=3D pkt_end, pkt_meta' !=3D pkt_data,
+                        * pkt_end !=3D pkt_data', pkt_data !=3D pkt_meta'
+                        */
+                       struct bpf_verifier_state *eq_branch;
+
+                       eq_branch =3D BPF_OP(insn->code) =3D=3D BPF_JEQ ? o=
ther_branch : this_branch;
+                       find_good_pkt_pointers(eq_branch, dst_reg, dst_reg-=
>type, true);
+                       mark_pkt_end(eq_branch, insn->dst_reg, false);
+               } else {
+                       return false;
+               }
+               break;
        case BPF_JGE:
                if ((dst_reg->type =3D=3D PTR_TO_PACKET &&
                     src_reg->type =3D=3D PTR_TO_PACKET_END) ||

Right?

This passes the following test case:

SEC("tc")
__success
__naked void data_plus_const_eq_pkt_end(void)
{
        asm volatile ("                                 \n\
        r9 =3D r1;                                        \n\
        r1 =3D *(u32*)(r9 + %[__sk_buff_data]);           \n\
        r2 =3D *(u32*)(r9 + %[__sk_buff_data_end]);       \n\
        r3 =3D r1;                                        \n\
        r3 +=3D 8;                                        \n\
        if r3 !=3D r2 goto 1f;                            \n\
        r1 =3D *(u64 *)(r1 + 0);                          \n\
1:                                                      \n\
        r0 =3D 0;                                         \n\
        exit;                                           \n\
"       :
        : __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
          __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_e=
nd))
        : __clobber_all);
}

And it's variations for EQ/NEQ, positive/negative.

