Return-Path: <bpf+bounces-73407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3C3C2EBFA
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 02:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A981A18987C4
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 01:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89E027707;
	Tue,  4 Nov 2025 01:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AU0VTI96"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4C61DA60F
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 01:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762219817; cv=none; b=tY/EFoiyASGI7yqqGfjXQCM+wlWHgofr5enJmFV9pAREETuRfW8vObSTI8n92q5h7gOrG+bnYb4IAaRJmOkHzc4Adzi7PDUHhptnpRJG04VZbgtbnxGlb8EPDy8AWQk9s+SdLbb/grRNYH6Si2EP1KK9+ayTHxOKZE1QKNak0Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762219817; c=relaxed/simple;
	bh=qH1EuTmelNppmQXBTzMnMV9YubXyJykKF0i0r5JO48I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=opkjDdmlByduqKg/tTtU0Xj6oB/ltt1kxPiPWwu28359cFWEp6GlaeejOrloSaqzwvAzsqLCKfAPQd0lsNUcJRljorJSRvPILuqv3NV9AOFHGlOyJ9WF3HQ+dSA5PkZYbCVH6UEdQEj0nxOFY/rFqJQaVdYVxqa8cQf4l3tPsno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AU0VTI96; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2955623e6faso25160715ad.1
        for <bpf@vger.kernel.org>; Mon, 03 Nov 2025 17:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762219815; x=1762824615; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rxUq+UfD8JOiJXF4lVPcm5QyWNQMn9Y9IDz4FfYcrPc=;
        b=AU0VTI96bZHX5cgp3ZvlKSuzpBp3GJAxiAOoddfzRqoSa0mMp3bLA7TDUN/bRbmYOn
         ngyePCVuJd0K/uZ+u/x+mEekmOOGRCMnczHDHo9EdnTv0PSp4cUucF6D6prSpTBMOjV6
         67rC+hte8Rb5lHgk+p6pGYA9OVO7qc6SWejV05Ok0WgRuFPjDPZJefB66G7YK68ZtR92
         OQeSCKT19EWUMqUbjXmh64FsQFzC0A+Q+3Cn/dWm4P7t1GYu5vOe4mpv3P7mMjYqtOxB
         dkDMcPv4oY5WWb80N4nXM94wf7T5CGbNGm2bCd/evGvbIfV21deYTJvO1SdNoJyrTN/2
         Y5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762219815; x=1762824615;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rxUq+UfD8JOiJXF4lVPcm5QyWNQMn9Y9IDz4FfYcrPc=;
        b=ZhTmoe5PmSY9xFpHXgmhvPFAWCS2mpBjqI8IbrAXLxFYqrnJf2USn6BogsvYXXAN7/
         HMOpQgXr7Rfvvk2eZzGRuRqfFFA90GKTEV7aFAr4DwGM+sGd9AsYZl3rwBaqmWnKTSJ3
         227kdgdfkIUKWxSXfMJmThYg5GQmZodCNVCrV1IO1RAhn6kEP0xymKZThrv6e1MQ/bpB
         udcMvGeyVqbt727umP+rPDWiYS4+0HN+F/fWMS/Ww1NMarB63tYYhMrJ7vqSd2Njt63R
         due0GJhuTRzi5S9DOH75+YKv171VJnIqx81UV84yJt3J7ofGzkXBXbXIqNNuTq52/E1l
         n+Yg==
X-Gm-Message-State: AOJu0Yz5BMDNY8iPc1CKKvnnCb6uCn6ynQa1LLU9dD05fO2SC41TSf5O
	7hDSQP7BoMxAPKixK1ZMeYsMB2ngHqGLf9aW/6X3fAYu5i1w2yjDlX//
X-Gm-Gg: ASbGncv9T6f63gXD/U8GyaPkGzbfouV8z64ksC5KnHYNs/InFRJvSgKecY6OAZ7hkG0
	SXjfO947O498qJzrdXNmAq5L4Jq9nXT4kySR5SdplT2cg+91vjDYmQ+ZXbuR+TpcSgf7IHfqR24
	p2PDLJKArcguCPKk4vXwyWn+dWojPOzgJqusuyqsY+5zzfjO6eQ6qcxvuGxxpV9fSihJlSyiFJE
	yDSRsxLpBWezF8+C1S0kSJSRBckvX2CuBTsI7aS44cOdPrlfQ9QR7YkLUVKgIS2tNqBI1bx+t7e
	6XoKcC4n7KPuDGBPDtbD+QSZI0W5Zv4R/0h80kzSdW33oVtd2p4luHDdz1hpP6YcyPxDt1kmb2R
	CFls0dplBpoCZf+ftLrXv6MC2w/fsiY2mKQ2iJEyWLFdKd86ADZkpr3EzO0shIZ54GaXbumRY3W
	QqeupOxo5T4CUPVg3Ya5wSWmR+Mw==
X-Google-Smtp-Source: AGHT+IGq7tuGGeg/1rSdlBf/9sGsnRHrqGyod4a03g8r6wtb3VuKsR6+DgpabABd5ZA+zpcAfE8mew==
X-Received: by 2002:a17:903:1d0:b0:295:7804:13b7 with SMTP id d9443c01a7336-295780423bamr99152625ad.10.1762219814645;
        Mon, 03 Nov 2025 17:30:14 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:3eb6:963c:67a2:5992? ([2620:10d:c090:500::5:d721])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601972892sm5418225ad.23.2025.11.03.17.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 17:30:14 -0800 (PST)
Message-ID: <8a1e75661013bda97b22371cabdb9bc8f92101d3.camel@gmail.com>
Subject: Re: [PATCH v10 bpf-next 08/11] libbpf: support llvm-generated
 indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, Yonghong Song
	 <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Quentin Monnet <qmo@kernel.org>
Date: Mon, 03 Nov 2025 17:30:12 -0800
In-Reply-To: <4c9b089ea2c24b12d0d83f507c986d544f2c4e75.camel@gmail.com>
References: <20251102205722.3266908-1-a.s.protopopov@gmail.com>
		 <20251102205722.3266908-9-a.s.protopopov@gmail.com>
	 <4c9b089ea2c24b12d0d83f507c986d544f2c4e75.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-11-03 at 17:15 -0800, Eduard Zingerman wrote:
> On Sun, 2025-11-02 at 20:57 +0000, Anton Protopopov wrote:
>=20
> [...]
>=20
> > +static int create_jt_map(struct bpf_object *obj, struct bpf_program *p=
rog, struct reloc_desc *relo)
> > +{
> > +	const __u32 jt_entry_size =3D 8;
> > +	int sym_off =3D relo->sym_off;
> > +	int jt_size =3D relo->sym_size;
> > +	__u32 max_entries =3D jt_size / jt_entry_size;
> > +	__u32 value_size =3D sizeof(struct bpf_insn_array_value);
> > +	struct bpf_insn_array_value val =3D {};
> > +	int subprog_idx;
> > +	int map_fd, err;
> > +	__u64 insn_off;
> > +	__u64 *jt;
> > +	__u32 i;
> > +
> > +	map_fd =3D find_jt_map(obj, prog, sym_off);
> > +	if (map_fd >=3D 0)
> > +		return map_fd;
> > +
> > +	if (sym_off % jt_entry_size) {
> > +		pr_warn("map '.jumptables': jumptable start %d should be multiple of=
 %u\n",
> > +			sym_off, jt_entry_size);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (jt_size % jt_entry_size) {
> > +		pr_warn("map '.jumptables': jumptable size %d should be multiple of =
%u\n",
> > +			jt_size, jt_entry_size);
> > +		return -EINVAL;
> > +	}
> > +
> > +	map_fd =3D bpf_map_create(BPF_MAP_TYPE_INSN_ARRAY, ".jumptables",
> > +				4, value_size, max_entries, NULL);
> > +	if (map_fd < 0)
> > +		return map_fd;
> > +
> > +	if (!obj->jumptables_data) {
> > +		pr_warn("map '.jumptables': ELF file is missing jump table data\n");
> > +		err =3D -EINVAL;
> > +		goto err_close;
> > +	}
> > +	if (sym_off + jt_size > obj->jumptables_data_sz) {
> > +		pr_warn("map '.jumptables': jumptables_data size is %zd, trying to a=
ccess %d\n",
> > +			obj->jumptables_data_sz, sym_off + jt_size);
> > +		err =3D -EINVAL;
> > +		goto err_close;
> > +	}
> > +
> > +	subprog_idx =3D -1; /* main program */
> > +	if (relo->insn_idx < 0 || relo->insn_idx >=3D prog->insns_cnt) {
> > +		pr_warn("map '.jumptables': invalid instruction index %d\n", relo->i=
nsn_idx);
> > +		err =3D -EINVAL;
> > +		goto err_close;
> > +	}
> > +	if (prog->subprogs)
> > +		subprog_idx =3D find_subprog_idx(prog, relo->insn_idx);
> > +
> > +	jt =3D (__u64 *)(obj->jumptables_data + sym_off);
> > +	for (i =3D 0; i < max_entries; i++) {
> > +		/*
> > +		 * The offset should be made to be relative to the beginning of
> > +		 * the main function, not the subfunction.
> > +		 */
> > +		insn_off =3D jt[i]/sizeof(struct bpf_insn);
> > +		if (subprog_idx >=3D 0) {
> > +			insn_off -=3D prog->subprogs[subprog_idx].sec_insn_off;
> > +			insn_off +=3D prog->subprogs[subprog_idx].sub_insn_off;
>=20
> I'd like to reiterate my point about relocation related warnings [1]:
>=20
>   > I'm seeing the following messages when rebuilding bpf_gotox using
>   > llvm main, where Yonghong added __BPF_FEATURE_GOTOX.
>   >
>   >     CLNG-BPF [test_progs-cpuv4] bpf_gotox.bpf.o
>   >     GEN-SKEL [test_progs-cpuv4] bpf_gotox.skel.h
>   >   libbpf: elf: skipping relo section(13) .rel.jumptables for section(=
6) .jumptables
>   >   libbpf: elf: skipping relo section(13) .rel.jumptables for section(=
6) .jumptables
>=20
> In the context of Yonghong's reply [2].
>=20
> I inserted some debug prints and confirm that these relocations are
> generated for basic block labels, e.g.:
>=20
>   .S file corresponding to shortened bpf_gotox.c:
>       ...
>              gotox r1
>      .Ltmp25:
>      .Ltmp26:
>      .Ltmp27:                                # Block address taken
>      LBB0_5:                                 # %l1
>              #DEBUG_LABEL: one_jump_two_maps:l1
>              .loc    0 36 10 is_stmt 1               # progs/bpf_gotox.c:=
36:10
>      .Ltmp28:
>              w1 =3D *(u32 *)(r10 - 4)
>       ...
>              .section        .jumptables,"",@progbits
>     BPF.JT.0.0:
>             .quad   LBB0_5
>=20
>   objdump --symbols, corresponding to same shortened bpf_gotox.c:
>=20
>     Symbol table '.symtab' contains 18 entries:
>        Num:    Value          Size Type    Bind   Vis       Ndx Name
>          ...
>          2: 0000000000000000     0 SECTION LOCAL  DEFAULT     3 syscall
>=20
>   objdump --relocations, corresponding to same shortened bpf_gotox.c:
>=20
>     Relocation section '.rel.jumptables' at offset 0xde8 contains 4 entri=
es:
>          Offset             Info             Type               Symbol's =
Value  Symbol's Name
>      0000000000000000  0000000200000002 R_BPF_64_ABS64         0000000000=
000000 syscall
>      ...
>=20
> Here the first entry corresponds to LBB0_5 symbol, specifically:
>=20
>                          Relocation type (R_BPF_64_ABS64).
>                              vvvvvvvv
>    0000000000000000  0000000200000002 R_BPF_64_ABS64         000000000000=
0000 syscall
>    ^^^^^^^^^^^^^^^^  ^^^^^^^^                                ^^^^^^^^^^^^=
^^^^
>    Offset at which   Section                                 Given that r=
elocation type is
>    to apply the      index                                   R_BPF_64_ABS=
64, this is the value
>    relocation,       for 'syscall'.                          which has to=
 be written at offset.
>    first jumptables                                          (See [3]).
>    record.
>=20
> Given above, I conclude that:
>=20
> - [to Anton] libbpf has to apply the relocations from .rel.jumptables
>   in order to assign correct the sec_insn_off for records in the jump
>   table.  Right now we imply that each record in the table corresponds
>   to a section where jump table is referenced from, but that is not
>   true.
>=20
> - [to Yonghong] LLVM should generate a different relocation kind,
>   or a different "Symbol's Value", otherwise applying relocations as
>   instructed in [3] will lead to zeroes in the jump table:
>  =20
>   > In another case, R_BPF_64_ABS64 relocation type is used for normal
>   > 64-bit data. The actual to-be-relocated data is stored at
>   > r_offset and the read/write data bitsize is 64 (8 bytes). The
>   > relocation can be resolved with the symbol value plus implicit
>   > addend.
>=20
> [1] https://lore.kernel.org/bpf/68754a9c03b960d5057de816b217e824e51021a1.=
camel@gmail.com/
> [2] https://lore.kernel.org/bpf/3b07e879-9905-4161-88e0-05ed54bdb628@linu=
x.dev/
> [3] https://docs.kernel.org/bpf/llvm_reloc.html


Ok, according to [4], the "implicit addend" means the value in the
location to be modified. Meaning that final calculation should be:

  <jump-table value> + <'syscall' symbol value>

So, we either need to assume that section symbol values are always
zero, or do the computation on the libbpf side.  (Or skip generating
such relocations in LLVM, if we know that symbol value is zero).

[4] System V Application Binary Interface, Edition 4.1,
    Section 4-28, Page 72.

[...]

> > +		} else {
> > +			insn_off -=3D prog->sec_insn_off;
> > +		}
> > +
> > +		/*
> > +		 * LLVM-generated jump tables contain u64 records, however
> > +		 * should contain values that fit in u32.
> > +		 */
> > +		if (insn_off > UINT32_MAX) {
> > +			pr_warn("map '.jumptables': invalid jump table value 0x%llx at offs=
et %d\n",
> > +				(long long)jt[i], sym_off + i);
> > +			err =3D -EINVAL;
> > +			goto err_close;
> > +		}
> > +
> > +		val.orig_off =3D insn_off;
> > +		err =3D bpf_map_update_elem(map_fd, &i, &val, 0);
> > +		if (err)
> > +			goto err_close;
> > +	}
>=20
> [...]

