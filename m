Return-Path: <bpf+bounces-19336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B76882A033
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 19:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24F061C22379
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 18:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A080D4D13D;
	Wed, 10 Jan 2024 18:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMoQxwNI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973594D114
	for <bpf@vger.kernel.org>; Wed, 10 Jan 2024 18:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5534dcfdd61so7917551a12.0
        for <bpf@vger.kernel.org>; Wed, 10 Jan 2024 10:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704911017; x=1705515817; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eqljTxWrqLtqbWb+tnYOjCjk5VWFaB2ZrbtDHniKLDc=;
        b=iMoQxwNIBwLdvhdCAUX+0AFGXygl0kJqseDVtaawgHQVx/pvybZYoK10jO1qAPAWYM
         x98VpdshEQISHNb6dhW9/BLWP9BQAf1shOgFfAaivj8JVWHZXSBPVUx8dRdzraV8Mj71
         76i/3LViWISlgdZvX5zXSS/QLAa/QMH29H7wAAK3vzIPYrivzyRx9+vJhEkxIu5kQ35j
         13JVGNTpGlsjYxk1z8+OnHLqwX40gD5micTQys0O4897bejt4ZYviznvvqUceKuspUZr
         jGUi+alXqwUZ5w1AsdGT4g/wFcJ7eEXhKTnU7s0+KVxakAM3EpU1t3YrZhqY8lrzxCOH
         KSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704911017; x=1705515817;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eqljTxWrqLtqbWb+tnYOjCjk5VWFaB2ZrbtDHniKLDc=;
        b=L77vB4vHH8kFsZsp66iQvb9IjCA65VH3gJU2+UWPQsMZxwXfG7rurxduTgAnhAycuH
         38Ya5iO8cZ6et6fB6YUf7tzT/S23bJYO+4ltPk3eo+9z/JfnPpPs1ldIOHErGgRIWNWb
         BGH5YRIOuPCFPN8TiPCsb2E1bFCgk2DTJkR4JNMMURDoa/llAIHwCxqkPB2knAhMJtm8
         GsLOg4k9Mh3NdNSd6EtrzCv0gtTb3YxUGhEPP/qgMOzrVTDEq3PeQ90ipIOAHGSE/xqy
         X7kOfNB97oMdLJfFqkP5AoFTkQ6ZWimY/xDEsJBTEmTVtJ61fqdZV2Lus9oJeKtf9TNF
         MwiA==
X-Gm-Message-State: AOJu0YwVQqAjTPTlAH2xk+6M8yaJbAFHd11b0HSBSAuVNz3EG0FRPqHt
	/BI67Esm+87MW85lCpYrP5s=
X-Google-Smtp-Source: AGHT+IHQ7JspifQjSs9uMIvNgzAzCoaANBgQlndNSAK4uI6GM1T6el+Lm/FERrPXkk1SZ5dc01hM2A==
X-Received: by 2002:a50:d691:0:b0:557:ca6e:603c with SMTP id r17-20020a50d691000000b00557ca6e603cmr526880edi.15.1704911016658;
        Wed, 10 Jan 2024 10:23:36 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id h21-20020aa7de15000000b00556fe614fe3sm2238004edv.21.2024.01.10.10.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 10:23:36 -0800 (PST)
Message-ID: <8e8fa80e093108b2de5956317cbc65b6612a3890.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: infer packet range for 'if pkt ==/!=
 pkt_end' comparisons
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, zenczykowski@gmail.com
Date: Wed, 10 Jan 2024 20:23:35 +0200
In-Reply-To: <0055d2a9f2fdbbcb524252e103440c387d3b5f3d.camel@gmail.com>
References: <20240108132802.6103-1-eddyz87@gmail.com>
	 <20240108132802.6103-3-eddyz87@gmail.com>
	 <e5c37e7b-0e6a-4892-82d0-1a0d4d4db1ef@linux.dev>
	 <0055d2a9f2fdbbcb524252e103440c387d3b5f3d.camel@gmail.com>
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

On Wed, 2024-01-10 at 03:07 +0200, Eduard Zingerman wrote:
> On Tue, 2024-01-09 at 09:26 -0800, Yonghong Song wrote:
> [...]
> >=20
> > What will happen if there are multiple BPF_JEQ/BPF_JNE? I made a change=
 to one of tests
> > in patch 3:
> >=20
> > +SEC("tc")
> > +__success __log_level(2)
> > +__msg("if r3 !=3D r2 goto pc+3         ; R2_w=3Dpkt_end() R3_w=3Dpkt(o=
ff=3D8,r=3D0xffffffffffffffff)")
> > +__naked void data_plus_const_neq_pkt_end(void)
> > +{
> > +       asm volatile ("                                 \
> > +       r9 =3D r1;                                        \
> > +       r1 =3D *(u32*)(r9 + %[__sk_buff_data]);           \
> > +       r2 =3D *(u32*)(r9 + %[__sk_buff_data_end]);       \
> > +       r3 =3D r1;                                        \
> > +       r3 +=3D 8;                                        \
> > +       if r3 !=3D r2 goto 1f;                            \
> > +       r3 +=3D 8;                                        \
> > +       if r3 !=3D r2 goto 1f;                            \
> > +       r1 =3D *(u64 *)(r1 + 0);                          \
> > +1:                                                     \
> > +       r0 =3D 0;                                         \
> > +       exit;                                           \
> > +"      :
> > +       : __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data))=
,
> > +         __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, da=
ta_end))
> > +       : __clobber_all);
> > +}
> >=20
> >=20
> > The verifier output:
> > func#0 @0
> > Global function data_plus_const_neq_pkt_end() doesn't return scalar. On=
ly those are supported.
> > 0: R1=3Dctx() R10=3Dfp0
> > ; asm volatile ("                                       \
> > 0: (bf) r9 =3D r1                       ; R1=3Dctx() R9_w=3Dctx()
> > 1: (61) r1 =3D *(u32 *)(r9 +76)         ; R1_w=3Dpkt(r=3D0) R9_w=3Dctx(=
)
> > 2: (61) r2 =3D *(u32 *)(r9 +80)         ; R2_w=3Dpkt_end() R9_w=3Dctx()
> > 3: (bf) r3 =3D r1                       ; R1_w=3Dpkt(r=3D0) R3_w=3Dpkt(=
r=3D0)
> > 4: (07) r3 +=3D 8                       ; R3_w=3Dpkt(off=3D8,r=3D0)
> > 5: (5d) if r3 !=3D r2 goto pc+3         ; R2_w=3Dpkt_end() R3_w=3Dpkt(o=
ff=3D8,r=3D0xffffffffffffffff)
> > 6: (07) r3 +=3D 8                       ; R3_w=3Dpkt(off=3D16,r=3D0xfff=
fffffffffffff)
> > 7: (5d) if r3 !=3D r2 goto pc+1         ; R2_w=3Dpkt_end() R3_w=3Dpkt(o=
ff=3D16,r=3D0xffffffffffffffff)
> > 8: (79) r1 =3D *(u64 *)(r1 +0)          ; R1=3Dscalar()
> > 9: (b7) r0 =3D 0                        ; R0_w=3D0
> > 10: (95) exit
> >=20
> > from 7 to 9: safe
> >=20
> > from 5 to 9: safe
> > processed 13 insns (limit 1000000) max_states_per_insn 0 total_states 1=
 peak_states 1 mark_read 0
> >=20
> > insn 5, for this_branch (straight one), r3 range will be 8 and assuming=
 pkt_end is 8.
> > insn 7, r3 range becomes 18 and then we assume pkt_end is 16.
> >=20
> > I guess we should handle this case. For branch 5 and 7, it cannot be th=
at both will be true.
>=20
> This is an interesting case.
> reg->range is set to AT_PKT_END or BEYOND_PKT_END only in
> try_match_pkt_pointers() (in mark_pkt_end() call).
> And this range mark appears not to be reset by +=3D operation
> (which might add a negative number as well).
> So, once r3 is marked AT_PKT_END it would remain so
> even after r3 +=3D 8, which is obviously not true.
> Not sure what to do yet.

Here is another example which is currently not handled correctly,
even w/o my patch:

SEC("tc")
__success
__naked void pkt_vs_pkt_end_with_bound_change(void)
{
	asm volatile ("					\
	r9 =3D r1;					\
	r0 =3D 0;						\
	r1 =3D *(u32*)(r9 + %[__sk_buff_data]);		\
	r2 =3D *(u32*)(r9 + %[__sk_buff_data_end]);	\
	r3 =3D r1;					\
	r3 +=3D 8;					\
	if r3 <=3D r2 goto 1f;				\
	r3 -=3D 8;					\
	if r3 >=3D r2 goto 1f;				\
	r4 =3D *(u64 *)(r1 + 0);				\
1:	exit;						\
"	:
	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
	: __clobber_all);
}

Verifier log:

  0: R1=3Dctx() R10=3Dfp0
  ; asm volatile ("					\
  0: (bf) r9 =3D r1                       ; R1=3Dctx() R9_w=3Dctx()
  1: (b7) r0 =3D 0                        ; R0_w=3D0
  2: (61) r1 =3D *(u32 *)(r9 +76)         ; R1_w=3Dpkt(r=3D0) R9_w=3Dctx()
  3: (61) r2 =3D *(u32 *)(r9 +80)         ; R2_w=3Dpkt_end() R9_w=3Dctx()
  4: (bf) r3 =3D r1                       ; R1_w=3Dpkt(r=3D0) R3_w=3Dpkt(r=
=3D0)
  5: (07) r3 +=3D 8                       ; R3_w=3Dpkt(off=3D8,r=3D0)
  6: (bd) if r3 <=3D r2 goto pc+3         ; R2_w=3Dpkt_end() R3_w=3Dpkt(off=
=3D8,r=3D0xfffffffffffffffe)
  7: (17) r3 -=3D 8                       ; R3_w=3Dpkt(r=3D0xffffffffffffff=
fe)
  8: (3d) if r3 >=3D r2 goto pc+1         ; R2_w=3Dpkt_end() R3_w=3Dpkt(r=
=3D0xfffffffffffffffe)
  10: (95) exit

  from 6 to 10: safe
  processed 11 insns (limit 1000000) max_states_per_insn 0 total_states 1 p=
eak_states 1 mark_read 1

At (6) for this_branch r3 is marked BEYOND_PKT_END,
       packet range is known to be 8;
at (7) it is changed to point back to start of the packet;
at (8) is_pkt_ptr_branch_taken() incorrectly predicts that
       r3 >=3D r2 (r3 - packet start, r2 - packet end).

