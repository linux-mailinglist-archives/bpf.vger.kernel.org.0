Return-Path: <bpf+bounces-19303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B195E8291BF
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 02:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B702B28708D
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 01:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBA381B;
	Wed, 10 Jan 2024 01:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNL1pZ0a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C8E63D
	for <bpf@vger.kernel.org>; Wed, 10 Jan 2024 01:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50eabfac2b7so3977553e87.0
        for <bpf@vger.kernel.org>; Tue, 09 Jan 2024 17:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704848878; x=1705453678; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7J7yTFGR2JB1/Y9ayBgddOOlo1XgU8PBshYct2bktb4=;
        b=dNL1pZ0aTsCWH6YgibjfnJi+owfDMZ7bjH8XcNEgdfdNIxkAPQhdgSaClBSBXrfZxH
         7Y0ZaAgQD2Vhl+NrvbxynTf0XHe3EecgWbMidj4JgKkW8NtohNnwHQCV9Qq8qp7bcK6K
         LIl1+krGA3t9xjCZCMBbuMXaLBYMxdusNbtR4CRnCaiXn04cL3biZYSJiMjQwfF+PtNs
         JcmrTaZYXMsyF6VVz6AsKJcdQHzk9ih0dzSi+1Q7ube+Y9F+x990pqBfk57ppGRZ4COK
         zGlrwMS5mwlLAsGM44fsQUD/4X2t0KViCl/QWJ9yE1WckPcfnhpkBJtbPxa8uhdpBjWg
         erpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704848878; x=1705453678;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7J7yTFGR2JB1/Y9ayBgddOOlo1XgU8PBshYct2bktb4=;
        b=IwaZjox9VX1kyda68ySk4unIYKNbMKcZGT71DnIJphNWg98XaeZC555XTRWISQo+cv
         Qk7keo54jEoNf6S1kukdZ58x6U9w5puXRp+Yuj2t8wyBZ4j9YjiDbZ/1HDbZITVNSQp9
         0DGs64WqwKvMV4b3a/ejFRWJ1eeq6oFbWxuXJ2PAkz5tOBJA9j3Ju3bj7Ohj9xeaVXrC
         qcluJU/8BwGyINbNCQg3W6K72ked3ekbCKzVFGOOgFbMrYYxEX1x2I9H1W+pgqvze1Qb
         sOq8QsHjhSI0prur0P01gYXIfVIAgboa6GDAS6rNTEoaCU034FI4GkpDWUk1zkUeNd64
         VVfQ==
X-Gm-Message-State: AOJu0YwkAXjs1r+Pdk/OceFVQ7Qz6Kl75DdHGYf8pB6pI5KciwtP5xbI
	AcepKwI0AEWggur6/Xh7WcQ=
X-Google-Smtp-Source: AGHT+IHxAqksSYdihm2fVDCau4c7mTvc3yU1duCGktJN6wiAtYseC4d0x1JCwdcyN8td6iIaJwpzhQ==
X-Received: by 2002:ac2:48a7:0:b0:50e:7e13:813a with SMTP id u7-20020ac248a7000000b0050e7e13813amr74576lfg.61.1704848877751;
        Tue, 09 Jan 2024 17:07:57 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id cf13-20020a056512280d00b0050e7b274362sm505179lfb.99.2024.01.09.17.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 17:07:57 -0800 (PST)
Message-ID: <0055d2a9f2fdbbcb524252e103440c387d3b5f3d.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: infer packet range for 'if pkt ==/!=
 pkt_end' comparisons
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, zenczykowski@gmail.com
Date: Wed, 10 Jan 2024 03:07:56 +0200
In-Reply-To: <e5c37e7b-0e6a-4892-82d0-1a0d4d4db1ef@linux.dev>
References: <20240108132802.6103-1-eddyz87@gmail.com>
	 <20240108132802.6103-3-eddyz87@gmail.com>
	 <e5c37e7b-0e6a-4892-82d0-1a0d4d4db1ef@linux.dev>
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

On Tue, 2024-01-09 at 09:26 -0800, Yonghong Song wrote:
[...]
>=20
> What will happen if there are multiple BPF_JEQ/BPF_JNE? I made a change t=
o one of tests
> in patch 3:
>=20
> +SEC("tc")
> +__success __log_level(2)
> +__msg("if r3 !=3D r2 goto pc+3         ; R2_w=3Dpkt_end() R3_w=3Dpkt(off=
=3D8,r=3D0xffffffffffffffff)")
> +__naked void data_plus_const_neq_pkt_end(void)
> +{
> +       asm volatile ("                                 \
> +       r9 =3D r1;                                        \
> +       r1 =3D *(u32*)(r9 + %[__sk_buff_data]);           \
> +       r2 =3D *(u32*)(r9 + %[__sk_buff_data_end]);       \
> +       r3 =3D r1;                                        \
> +       r3 +=3D 8;                                        \
> +       if r3 !=3D r2 goto 1f;                            \
> +       r3 +=3D 8;                                        \
> +       if r3 !=3D r2 goto 1f;                            \
> +       r1 =3D *(u64 *)(r1 + 0);                          \
> +1:                                                     \
> +       r0 =3D 0;                                         \
> +       exit;                                           \
> +"      :
> +       : __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
> +         __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data=
_end))
> +       : __clobber_all);
> +}
>=20
>=20
> The verifier output:
> func#0 @0
> Global function data_plus_const_neq_pkt_end() doesn't return scalar. Only=
 those are supported.
> 0: R1=3Dctx() R10=3Dfp0
> ; asm volatile ("                                       \
> 0: (bf) r9 =3D r1                       ; R1=3Dctx() R9_w=3Dctx()
> 1: (61) r1 =3D *(u32 *)(r9 +76)         ; R1_w=3Dpkt(r=3D0) R9_w=3Dctx()
> 2: (61) r2 =3D *(u32 *)(r9 +80)         ; R2_w=3Dpkt_end() R9_w=3Dctx()
> 3: (bf) r3 =3D r1                       ; R1_w=3Dpkt(r=3D0) R3_w=3Dpkt(r=
=3D0)
> 4: (07) r3 +=3D 8                       ; R3_w=3Dpkt(off=3D8,r=3D0)
> 5: (5d) if r3 !=3D r2 goto pc+3         ; R2_w=3Dpkt_end() R3_w=3Dpkt(off=
=3D8,r=3D0xffffffffffffffff)
> 6: (07) r3 +=3D 8                       ; R3_w=3Dpkt(off=3D16,r=3D0xfffff=
fffffffffff)
> 7: (5d) if r3 !=3D r2 goto pc+1         ; R2_w=3Dpkt_end() R3_w=3Dpkt(off=
=3D16,r=3D0xffffffffffffffff)
> 8: (79) r1 =3D *(u64 *)(r1 +0)          ; R1=3Dscalar()
> 9: (b7) r0 =3D 0                        ; R0_w=3D0
> 10: (95) exit
>=20
> from 7 to 9: safe
>=20
> from 5 to 9: safe
> processed 13 insns (limit 1000000) max_states_per_insn 0 total_states 1 p=
eak_states 1 mark_read 0
>=20
> insn 5, for this_branch (straight one), r3 range will be 8 and assuming p=
kt_end is 8.
> insn 7, r3 range becomes 18 and then we assume pkt_end is 16.
>=20
> I guess we should handle this case. For branch 5 and 7, it cannot be that=
 both will be true.

This is an interesting case.
reg->range is set to AT_PKT_END or BEYOND_PKT_END only in
try_match_pkt_pointers() (in mark_pkt_end() call).
And this range mark appears not to be reset by +=3D operation
(which might add a negative number as well).
So, once r3 is marked AT_PKT_END it would remain so
even after r3 +=3D 8, which is obviously not true.
Not sure what to do yet.

