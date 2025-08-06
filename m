Return-Path: <bpf+bounces-65165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3640B1CF8D
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 01:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DA347226A4
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 23:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66448277CBC;
	Wed,  6 Aug 2025 23:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqRQA8NK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763EC277803
	for <bpf@vger.kernel.org>; Wed,  6 Aug 2025 23:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754524456; cv=none; b=NEzzcfE32vk0l3TkFJ2zEaYBTfv9zUdGHLM5ID4nNzOvfm5XrA8E15AP7SlVhy3wPtqIz8GTkuGs3vzdqjnRJpRYXJlDiagiJ1LpgylxgKT8Ul5UQabQ89GO88vV/CYMvI6uWTu8VUwgaD/NnYYgvgh3/oknobreUYrVjrKrEcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754524456; c=relaxed/simple;
	bh=y8JixcSmy36bpJSoSPVqtgm1o4E8OzgMnIjom8bHdiA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HQnZkEbA5GFBC46u+8EmK4KwbllaWqWA4zgEjPa1KgpnmFZx8o/fWhlMfYzMmNcT46BCJm7GY7M9NqjlDaOVHVQQhib+fDhthNwDUleQmldfFvuD2VOfat9Jufs5FFCfqflXDVfTxGaG1RnunhtNGRWz8MkTCXVWfZQ5RrgDN7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqRQA8NK; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76bdce2ee10so428772b3a.2
        for <bpf@vger.kernel.org>; Wed, 06 Aug 2025 16:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754524454; x=1755129254; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1A7GfvLr7Gjjji9uWYRZJc+ld+L8P9jqpBJtWNspOec=;
        b=jqRQA8NKOaBrkWhv7jDB90MGJftdibshFvAwrP7H6JlGmuaMUDtJCGHbkC/1Jredzz
         vh0cFtKqi/547SPnjP9rg5zJF9K1fGmVwVO+C2SV8pr17LGrpWcW/SzZqt2d4IJ0s2cy
         6jj4lyZ/wjjn5kaBQqbTgPVWEvbnfR1EQJS59i70G6vAH+Ikv9nIwV7cyJ/toQu1v/Lp
         DuLzjFiA4idJzXZvTtytJn5wsUnxHpPNJ48xJ7n24Z23C+Tm7zdnMCjhe4JeXBCLvRzz
         HAoi/RHbMFzFAPTTK51bQKmK8/uFuDeeoSdBZaJqw2bDG+EHKqMVmBnEiNv7WC5EMiIb
         gLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754524454; x=1755129254;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1A7GfvLr7Gjjji9uWYRZJc+ld+L8P9jqpBJtWNspOec=;
        b=lrwD3VsvV0w5qpjJ5H6cErHOubLTFBPDD14oiGDjh3T1IDgp6kDeRcCjIcTQIv3yCy
         K/uXKo6OZiP8V5mZd3MQlll6W8kLAkBfgMTByLckCy6SPh77IPJC1yPRsSdSptp5qKGD
         lQ4no3qJEIxoOEAwsIajIQenGAstNQ0dTgyM0l+vKqJwaY8VCBlgXyJg9QvMHDpcr8S1
         b6UT4f31EY0s2bDSCDHEfEsDvgHR3+cDxWkSu/myIY3yETZN7bFZ+dXKeaPC9U02SkgL
         4mCiVjDp8/R1U2mx0/Cw9rOuolNQcfBzfF4v1fqETpcdh7gWleAJcfmRK4b4riVlzqnu
         cm/w==
X-Gm-Message-State: AOJu0Yw8f7a16qQOVkigKUckrBs807e+I7WNmts6t3KtPssv6IHbx9n7
	u9lWwvg1hBMaR69Zw86xfbJ5TXyCkugLxqwnTQpUFJwQXnEtA9MDjghrJnr2xz4d
X-Gm-Gg: ASbGncvNMa8gSia6G9M7q8vvDGBIEei+Cpav6JLCWpX22okdctlyYwk7VHR4hL30TLL
	E93qp1wmmvd+eo7X4C3MNxKu4IgP9041HUJxuNv4e9ROsMrm4ZSjrA+DmQzotygEv0pTv5P6sQg
	R4KjOjxGila4+tfbFF439GWl7jlN66ESEubW7223GNMrhNBZZTxPrE99e2mbanUOiQYwG5G8HqS
	2L5AZli7mpT+36QqReA4CBBX33vM7knJAzKXEAYGDL7IeChNca7MrmbcTmieScCmwdnldpCuIj0
	UdnIQ/7L3obdjuPhs/oF0Y2+/V1saiSzGX5gRGZwGAObwUoVGtaEpe3tSl53W3DKp6sGuRIXIV2
	C01z95wuo7SsYn91Z20KE46//
X-Google-Smtp-Source: AGHT+IGOrKwrKYO1PY2AY1yYxQFzsTQyaAGUuYmIHb7bQ86s9v/GBDLYcNeJajXlXV72Yoh+Ulk+GQ==
X-Received: by 2002:a05:6a00:8d1:b0:76b:fb4a:118c with SMTP id d2e1a72fcca58-76c2b001490mr6300179b3a.18.1754524454391;
        Wed, 06 Aug 2025 16:54:14 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::6? ([2620:10d:c090:600::1:e57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bdbda5f23sm14131283b3a.112.2025.08.06.16.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 16:54:13 -0700 (PDT)
Message-ID: <28f5fbaa5703e1ba2f4bb1648962aeb045f7b985.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/2] bpf: use realloc in bpf_patch_insn_data
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 06 Aug 2025 16:54:12 -0700
In-Reply-To: <4ad7e189907669e140553fba42759e97c691bfa0.camel@gmail.com>
References: <20250806200928.3080531-1-eddyz87@gmail.com>
		 <20250806200928.3080531-2-eddyz87@gmail.com>
	 <4ad7e189907669e140553fba42759e97c691bfa0.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-08-06 at 16:04 -0700, Eduard Zingerman wrote:
> On Wed, 2025-08-06 at 13:09 -0700, Eduard Zingerman wrote:
>
> [...]
>
> > @@ -20712,22 +20711,19 @@ static void adjust_insn_aux_data(struct bpf_v=
erifier_env *env,
> >  	 * (cnt =3D=3D 1) is taken or not. There is no guarantee INSN at OFF =
is the
> >  	 * original insn at old prog.
> >  	 */
> > -	old_data[off].zext_dst =3D insn_has_def32(insn + off + cnt - 1);
> > +	data[off].zext_dst =3D insn_has_def32(insn + off + cnt - 1);
> >
> >  	if (cnt =3D=3D 1)
> >  		return;
> >  	prog_len =3D new_prog->len;
> >
> > -	memcpy(new_data, old_data, sizeof(struct bpf_insn_aux_data) * off);
> > -	memcpy(new_data + off + cnt - 1, old_data + off,
> > -	       sizeof(struct bpf_insn_aux_data) * (prog_len - off - cnt + 1))=
;
> > +	memmove(data + off + cnt - 1, data + off,
> > +		sizeof(struct bpf_insn_aux_data) * (prog_len - off - cnt + 1));
> >  	for (i =3D off; i < off + cnt - 1; i++) {
> >  		/* Expand insni[off]'s seen count to the patched range. */
> > -		new_data[i].seen =3D old_seen;
> > -		new_data[i].zext_dst =3D insn_has_def32(insn + i);
> > +		data[i].seen =3D old_seen;
> > +		data[i].zext_dst =3D insn_has_def32(insn + i);
> >  	}
> > -	env->insn_aux_data =3D new_data;
> > -	vfree(old_data);
> >  }
>
> veristat-meta job failed on the CI [1] because the following piece is mis=
sing:
>
>   @@ -20719,6 +20719,7 @@ static void adjust_insn_aux_data(struct bpf_ver=
ifier_env *env,
>
>           memmove(data + off + cnt - 1, data + off,
>                   sizeof(struct bpf_insn_aux_data) * (prog_len - off - cn=
t + 1));
>   +       memset(data + off, 0, sizeof(struct bpf_insn_aux_data) * (cnt -=
 1));
>           for (i =3D off; i < off + cnt - 1; i++) {
>                   /* Expand insni[off]'s seen count to the patched range.=
 */
>                   data[i].seen =3D old_seen;
>
> I'm trying to figure out if I can add a selftest for this.
>
> [1] https://github.com/kernel-patches/bpf/actions/runs/16787563163/job/47=
542309875
>
> [...]

The error reported by verifier is "verifier bug: error during ctx access co=
nversion (0)",
signaled from convert_ctx_accesses(). The rewrite is attempted because
`env->insn_aux_data[i + delta].ptr_type` is set to 12 (PTR_TO_SOCK_COMMON).
The instruction for which rewrite is attempted is a load or store
instruction introduced as a result of inline_bpf_loop() call.
It has a wrong offset for bpf_sock_convert_ctx_access() rewrite,
hence rewrite attempt is unsuccessful and the above mentioned error is repo=
rted.
`env->insn_aux_data[i + delta].ptr_type` is set for the instruction in ques=
tion
because of missing memset(0). It is a value of the insn_aux_data inherited
from an instruction occurring at a small offset after bpf_loop call.

Here is a similar reproducer, but for PTR_TO_CTX (=3D=3D 2):

  struct { ... } map0 SEC(".maps"); // any valid map definition
  struct { ... } map1 SEC(".maps");
  struct { ... } map2 SEC(".maps");
 =20
  SEC("xdp")
  __success
  __naked void bug1(void)
  {
          asm volatile ("                                 \
          r0 =3D %[map0] ll;       /* 0 */                  \
          r0 =3D %[map1] ll;       /* 2 */                  \
          r1 =3D 1;                /* 4 */                  \
          r2 =3D dummy ll;         /* 5 */                  \
          r3 =3D 0;                /* 7 */                  \
          r4 =3D 0;                /* 8 */                  \
          call %[bpf_loop];      /* 9 */                  \
          r0 =3D 0;                /* 10 */                 \
          r0 =3D 0;                /* 11 */                 \
          r0 =3D %[map2] ll;       /* 12 */                 \
          exit;                                           \
  "       :
          : __imm(bpf_loop),
            __imm_addr(map0),
            __imm_addr(map1),
            __imm_addr(map2)
          : __clobber_all);
  }

Instruction `call %[bpf_loop]` is replaced by a sequence:

  9:  if r1 <=3D 0x800000 goto pc+2
  10: w0 =3D -7
  11: goto pc+16
  12: *(u64 *)(r10 -24) =3D r6
  ...

Note the store at offset (12). Because of the missing memset(0) it
inherits insn_aux_data fields from original instruction #12: `r0 =3D %[map2=
] ll`.
`struct bpf_insn_aux_data` is defined as follows:

   struct bpf_insn_aux_data {
         union {
                 enum bpf_reg_type ptr_type;
				 ...
                 struct {
                         u32 map_index;          /* index into used_maps[] =
*/
                         ...
                 };
				 ...
         };
   }

Here fields .ptr_type and .map_index have same offset.
The example above forces convert_ctx_accesses() to interpret .map_index as =
a .ptr_type.
The .map_index at offset 12 happens to be 2, which corresponds to PTR_TO_CT=
X.
convert_ctx_accesses() attempts to rewrite `12: *(u64 *)(r10 -24) =3D r6` a=
nd fails.

All in all, I think this test is fragile, so I'll post v2 w/o a selftest.

