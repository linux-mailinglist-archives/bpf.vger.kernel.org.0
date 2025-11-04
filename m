Return-Path: <bpf+bounces-73406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8089AC2EB8D
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 02:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A533A6C1D
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 01:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F2320C029;
	Tue,  4 Nov 2025 01:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blFsPbRH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1565A1946DF
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 01:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762218919; cv=none; b=KzyJFXQPy9taOmF7owTWReCleyT3qQw+/A47BzbgfPjXG/6urzTxqIEpFQ1CctGIMMdArjKURLlxdfCHtv1nD24BQnsktiCie8EBmkLs7nY/18ZpBkNF3Kc4tj7mlUk+dT0uRlF2uhw0HdbMF+lpfq93+L8kuEEswmO3xu57oL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762218919; c=relaxed/simple;
	bh=ZTqdZ3yQIfGqItFcsfiE76xhafAZpfidgWpiDr7G5oE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hVul5IXRnkBnhC1OVLUelftJsF9CGqKUjlKe86URsvJBNY4bHy4N90PcQ/m45z+56EO+mg/73G0bjgcJZ6iDRU4SkD3NSsPGfh0+UQdG2DNVWz0ifAKDTHt7OfsgZNEJDKeJus7NOAOlGUV5cMF0EbUno2cOpG0yqaj513VDw6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blFsPbRH; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7aad4823079so1655570b3a.0
        for <bpf@vger.kernel.org>; Mon, 03 Nov 2025 17:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762218917; x=1762823717; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2N+A1QQZ+fP3K1/y6w/UlWxA5h3NAwObdbgwyz6WuAs=;
        b=blFsPbRHb6d6pvRaOyx0mAtJ68zgewWZB8KuTIQ1RRvzxf2/0zjocQZ06xuE0rBl8n
         eWeMpTiIWc6xVy7jqLDyjySkQQG2Kra+Z3SYeMR0pKKwuiU3t1HLNy7FTKpN7CsZak9o
         Y913amW/bQv0JhahFVMpMP6iPUENMT8P4MkWn3u7UfIrmnqte858AX6Tl443J5MI0YWS
         Q/d3lpjJJCK5Lym+DH/P0anvDUmS/mBO2f1ciIC/44NeVgxbsbLDVmTuvznReEkeBK3j
         ngpPFOQrgvIeimM/ltArRT5SdvhQSvgfyLYUdNKZj394ubJaY+HhqoTVBEbWvLVA4N89
         0IKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762218917; x=1762823717;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2N+A1QQZ+fP3K1/y6w/UlWxA5h3NAwObdbgwyz6WuAs=;
        b=unitvJngitqx4iMKxL9r4K7IsLdwKX6BFBJeylQTCBQTqPQ6Ek5LAPhY1wFT3bXqzg
         T+Kg/46D7OGo/RLxLPd1K/oQVyJ0azjcEoUqohSnl8SG6Co+tYd6eBgOjZDBUn7QGxgR
         mySt63OMU2DM24Ukc6GLL/xNcUVl6rxwECeRa4AT+b6i/7qM63/qUTdhMJHV3VHCqRqh
         RdSSWFcrKtdZcZPHuDuR2XycjIbBsO+CoK7h/N4F0ZqHeCtCIsXfuRAC1lEyrJZlG4GZ
         Gg5xyJT8Gn+r+wkbqMhx+qSVtRArhyKNRcIGQDewz0iruhbcCUslSGPk38ao4Pgxs2Yg
         6mlw==
X-Gm-Message-State: AOJu0Yxk0muqkvGJzH3Tztg0fAAHReEuUVLPYTngqpOWcMq0ygq/eyte
	QuPPeT2jt+HvAaHnzS/3BN0PSLwcfqgVz3QDsP47+RyG+SOSUkZGMkSQ
X-Gm-Gg: ASbGncvL4+fYfXw3lYH+v1Qoc+moF6V+xk62L7MyHSt5xMiAK+Xwj2sFAYtR1iRFUeA
	nVrOxc8e1NiTtRjCHfksRZxqixv1JAuRcQd0EugZpY7R7AJmxJ06DaQjx6fk3TFdDt+P3l0vnl2
	mzpraq5bpDGbU+eTCNHe+F1KFYPuzUKkLLG73ulozNLdQR64+fsHjsDGGYDLcS0YOdiyx1wSvvB
	lPfiUk+Lk+pUl0WMHdBDVMvWLiaNRf8gd4u0XUw7CeCKjWH4JW+KPzjh4+AGf8EcRcrdTcxqfpk
	eFqkKuql0V3Scpg87Dq/lVWEVB2MEHBoJrR0/lPkaGxZ6JOejIKvnHIaSKtY8bVP77eGBr1N37b
	BWS/ke8Ge+a96txHdFWuKl70S9uLhT08uljamq3+WNKbvOzyJvm3jWYt7vKJ0vUqDnoqHl6MiCv
	ut9kkZ/932lYtB5TFL3mnEo3gkGzy9ETVvZV1qKyEouJdZzyE=
X-Google-Smtp-Source: AGHT+IH7du2s6JZ+NcimEPobbBhXZr8uraCj4aaKPCWe+jYizMClcsV3G/zDXkw+WJCRfarZFo4Zmw==
X-Received: by 2002:a05:6a00:2e27:b0:7ac:87af:cf37 with SMTP id d2e1a72fcca58-7ac87afd00dmr3048363b3a.31.1762218917237;
        Mon, 03 Nov 2025 17:15:17 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:3eb6:963c:67a2:5992? ([2620:10d:c090:500::5:d721])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd39210edsm777677b3a.26.2025.11.03.17.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 17:15:16 -0800 (PST)
Message-ID: <4c9b089ea2c24b12d0d83f507c986d544f2c4e75.camel@gmail.com>
Subject: Re: [PATCH v10 bpf-next 08/11] libbpf: support llvm-generated
 indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, Yonghong Song
	 <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Quentin Monnet <qmo@kernel.org>
Date: Mon, 03 Nov 2025 17:15:14 -0800
In-Reply-To: <20251102205722.3266908-9-a.s.protopopov@gmail.com>
References: <20251102205722.3266908-1-a.s.protopopov@gmail.com>
	 <20251102205722.3266908-9-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-11-02 at 20:57 +0000, Anton Protopopov wrote:

[...]

> +static int create_jt_map(struct bpf_object *obj, struct bpf_program *pro=
g, struct reloc_desc *relo)
> +{
> +	const __u32 jt_entry_size =3D 8;
> +	int sym_off =3D relo->sym_off;
> +	int jt_size =3D relo->sym_size;
> +	__u32 max_entries =3D jt_size / jt_entry_size;
> +	__u32 value_size =3D sizeof(struct bpf_insn_array_value);
> +	struct bpf_insn_array_value val =3D {};
> +	int subprog_idx;
> +	int map_fd, err;
> +	__u64 insn_off;
> +	__u64 *jt;
> +	__u32 i;
> +
> +	map_fd =3D find_jt_map(obj, prog, sym_off);
> +	if (map_fd >=3D 0)
> +		return map_fd;
> +
> +	if (sym_off % jt_entry_size) {
> +		pr_warn("map '.jumptables': jumptable start %d should be multiple of %=
u\n",
> +			sym_off, jt_entry_size);
> +		return -EINVAL;
> +	}
> +
> +	if (jt_size % jt_entry_size) {
> +		pr_warn("map '.jumptables': jumptable size %d should be multiple of %u=
\n",
> +			jt_size, jt_entry_size);
> +		return -EINVAL;
> +	}
> +
> +	map_fd =3D bpf_map_create(BPF_MAP_TYPE_INSN_ARRAY, ".jumptables",
> +				4, value_size, max_entries, NULL);
> +	if (map_fd < 0)
> +		return map_fd;
> +
> +	if (!obj->jumptables_data) {
> +		pr_warn("map '.jumptables': ELF file is missing jump table data\n");
> +		err =3D -EINVAL;
> +		goto err_close;
> +	}
> +	if (sym_off + jt_size > obj->jumptables_data_sz) {
> +		pr_warn("map '.jumptables': jumptables_data size is %zd, trying to acc=
ess %d\n",
> +			obj->jumptables_data_sz, sym_off + jt_size);
> +		err =3D -EINVAL;
> +		goto err_close;
> +	}
> +
> +	subprog_idx =3D -1; /* main program */
> +	if (relo->insn_idx < 0 || relo->insn_idx >=3D prog->insns_cnt) {
> +		pr_warn("map '.jumptables': invalid instruction index %d\n", relo->ins=
n_idx);
> +		err =3D -EINVAL;
> +		goto err_close;
> +	}
> +	if (prog->subprogs)
> +		subprog_idx =3D find_subprog_idx(prog, relo->insn_idx);
> +
> +	jt =3D (__u64 *)(obj->jumptables_data + sym_off);
> +	for (i =3D 0; i < max_entries; i++) {
> +		/*
> +		 * The offset should be made to be relative to the beginning of
> +		 * the main function, not the subfunction.
> +		 */
> +		insn_off =3D jt[i]/sizeof(struct bpf_insn);
> +		if (subprog_idx >=3D 0) {
> +			insn_off -=3D prog->subprogs[subprog_idx].sec_insn_off;
> +			insn_off +=3D prog->subprogs[subprog_idx].sub_insn_off;

I'd like to reiterate my point about relocation related warnings [1]:

  > I'm seeing the following messages when rebuilding bpf_gotox using
  > llvm main, where Yonghong added __BPF_FEATURE_GOTOX.
  >
  >     CLNG-BPF [test_progs-cpuv4] bpf_gotox.bpf.o
  >     GEN-SKEL [test_progs-cpuv4] bpf_gotox.skel.h
  >   libbpf: elf: skipping relo section(13) .rel.jumptables for section(6)=
 .jumptables
  >   libbpf: elf: skipping relo section(13) .rel.jumptables for section(6)=
 .jumptables

In the context of Yonghong's reply [2].

I inserted some debug prints and confirm that these relocations are
generated for basic block labels, e.g.:

  .S file corresponding to shortened bpf_gotox.c:
      ...
             gotox r1
     .Ltmp25:
     .Ltmp26:
     .Ltmp27:                                # Block address taken
     LBB0_5:                                 # %l1
             #DEBUG_LABEL: one_jump_two_maps:l1
             .loc    0 36 10 is_stmt 1               # progs/bpf_gotox.c:36=
:10
     .Ltmp28:
             w1 =3D *(u32 *)(r10 - 4)
      ...
             .section        .jumptables,"",@progbits
    BPF.JT.0.0:
            .quad   LBB0_5

  objdump --symbols, corresponding to same shortened bpf_gotox.c:

    Symbol table '.symtab' contains 18 entries:
       Num:    Value          Size Type    Bind   Vis       Ndx Name
         ...
         2: 0000000000000000     0 SECTION LOCAL  DEFAULT     3 syscall

  objdump --relocations, corresponding to same shortened bpf_gotox.c:

    Relocation section '.rel.jumptables' at offset 0xde8 contains 4 entries=
:
         Offset             Info             Type               Symbol's Va=
lue  Symbol's Name
     0000000000000000  0000000200000002 R_BPF_64_ABS64         000000000000=
0000 syscall
     ...

Here the first entry corresponds to LBB0_5 symbol, specifically:

                         Relocation type (R_BPF_64_ABS64).
                             vvvvvvvv
   0000000000000000  0000000200000002 R_BPF_64_ABS64         00000000000000=
00 syscall
   ^^^^^^^^^^^^^^^^  ^^^^^^^^                                ^^^^^^^^^^^^^^=
^^
   Offset at which   Section                                 Given that rel=
ocation type is
   to apply the      index                                   R_BPF_64_ABS64=
, this is the value
   relocation,       for 'syscall'.                          which has to b=
e written at offset.
   first jumptables                                          (See [3]).
   record.

Given above, I conclude that:

- [to Anton] libbpf has to apply the relocations from .rel.jumptables
  in order to assign correct the sec_insn_off for records in the jump
  table.  Right now we imply that each record in the table corresponds
  to a section where jump table is referenced from, but that is not
  true.

- [to Yonghong] LLVM should generate a different relocation kind,
  or a different "Symbol's Value", otherwise applying relocations as
  instructed in [3] will lead to zeroes in the jump table:
 =20
  > In another case, R_BPF_64_ABS64 relocation type is used for normal
  > 64-bit data. The actual to-be-relocated data is stored at
  > r_offset and the read/write data bitsize is 64 (8 bytes). The
  > relocation can be resolved with the symbol value plus implicit
  > addend.

[1] https://lore.kernel.org/bpf/68754a9c03b960d5057de816b217e824e51021a1.ca=
mel@gmail.com/
[2] https://lore.kernel.org/bpf/3b07e879-9905-4161-88e0-05ed54bdb628@linux.=
dev/
[3] https://docs.kernel.org/bpf/llvm_reloc.html

> +		} else {
> +			insn_off -=3D prog->sec_insn_off;
> +		}
> +
> +		/*
> +		 * LLVM-generated jump tables contain u64 records, however
> +		 * should contain values that fit in u32.
> +		 */
> +		if (insn_off > UINT32_MAX) {
> +			pr_warn("map '.jumptables': invalid jump table value 0x%llx at offset=
 %d\n",
> +				(long long)jt[i], sym_off + i);
> +			err =3D -EINVAL;
> +			goto err_close;
> +		}
> +
> +		val.orig_off =3D insn_off;
> +		err =3D bpf_map_update_elem(map_fd, &i, &val, 0);
> +		if (err)
> +			goto err_close;
> +	}

[...]

