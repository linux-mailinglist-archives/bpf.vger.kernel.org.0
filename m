Return-Path: <bpf+bounces-72383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CABC11EC6
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 23:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 30CA54EDFC6
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 22:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFC12F5473;
	Mon, 27 Oct 2025 22:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJ5P95zL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C3D1E47C5
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 22:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761605949; cv=none; b=fQo8yTx9BNkaVlUFq9/DXHS9iKipCdDsPm7yN/B+WX7IWNt48gQOcliQKG/eiJ0sGIYsqwTGIiFSlE9o2+ezj7g5djwFclzTY7X4dheVfI0r1MjvCAClxiJa2ctKYpoYMgNSQ0lhp4tjMTmn9RSAXomIL2wshFbCOQG3wMqFqiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761605949; c=relaxed/simple;
	bh=SSlbTM0aCQ+3P0NcumiDLC25TRhQuj76y2NEbJFHZrU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ikZ0tuJ6jcJyaZQHvJA2YkFTvz458qrWqA9BCU/4g2RG8Jgx8IQkE1V4hfUolf6xI8nD5oZKXHbg9gX0vP0ZEY729sMXStbd2iWV0dfyXV9nM7Awyv3jWdnJ7CcftPfvhSSoN1P+dsMSAIBIILDd9CvtvrvD0bTvcL2X6N6XBVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJ5P95zL; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7930132f59aso6918506b3a.0
        for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 15:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761605948; x=1762210748; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjrnVS1xmsMgG1UKR4+2B6fMs7jaMG8cOGDwwh5s2QM=;
        b=NJ5P95zLfEq/UmaFhzk673qqnAfYSo3hAfaINQ9m+roLtxIfFpvod7Gh3UyQ/Vr/fG
         +pqvSGtrprNQ5ec8aUji8HPh6O+EAKXtkrBKQvzO42GHDbWcRqIsF2wN4J/Cm1tsrv1k
         fzy5D5qUmbgukqNaSRdNGVR0GISIlkrKOx2y4TLP4SF9DMcDlfbU4OVj3R3KthbXvbou
         ujJUy5u64mPxQjH3toCKL0EnSdjvgYo9XRI95Vj8XJN25wBXYcJyPvUipUzNLYLLX3n1
         InnwU6e3mHXt0MT2K/e1mKL550z574GNm7+yNP7x7cZSwkIjzeKIPazpAIeqL+TSWfkf
         eDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761605948; x=1762210748;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HjrnVS1xmsMgG1UKR4+2B6fMs7jaMG8cOGDwwh5s2QM=;
        b=LA6BE2Hv++Ym4u3RQebKMzL+5EIRmO92NeomGi4HYJpm+SY0h3+ppFHPrk/zMhPn7/
         oTPyjcigeAFSa0tKBXXGsPvWrb4K1YprKxD/oKGlVM5s+yoqaYp4+LzwXHrzZV2psmwE
         gkMQKsf2NHVdXl7oraIg5iaLCq3cfVTC7HcYaseB7dYTgxob5cYn09O1GlE+W+spLIQ/
         CublQFi60WMDaOWsPbmf5+2pF+CUJRoaEeAGQiDxvrOepaeWYETk9Nq5mTN8vOcAaZPJ
         cV3CMET5fji9hMfSuUG5VHR3w7r7YTrydjvLCbq3h9c1Z0PmBH+G5Qcuwc6WRr1muLt3
         KTWA==
X-Forwarded-Encrypted: i=1; AJvYcCUFm73hZeSerF/oydhGo06p96Eu1e3X4ta09byNgS2INRkjjNWDLSepSpL+3g0ywN0x4Qk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFO2/ni72WL/MrvaOwaBm2eA8lDNEgUDyp8nRS4Obmad1ouJ1y
	xsxzJiIZPEj00HOJPmf9KVgCu3XADGYax0znaxB6MYHnu4z+zij67LTf
X-Gm-Gg: ASbGncu931jmfjYP3wqTaKrHqLlrSfhcyLBsIauy1LzT2tm2sot1x3u9FEQPgS2PzOz
	ZfnAroPJeLYUz7gGYHDSDzuEry1+8Y6Hs0qlLgQzOvGM87K1+dv56XKl6hEymSJqS3tntcI8c1T
	j2zBCYyOipYFvpu0k5selqb82EkxMBuLdocrHziUypQnpVwB0fk/pL1cmA0+fBV5ZVnxpcch0Jn
	XYwZNVVtvOfB0VV3QdkN2mwt16lsPBi22DRSZdBY8np2xG/giOxjUkrfDjLTJGoWQVmByqt4ntw
	k/eDRzWgxAAmSSGFEDrIcLguVYS+wso+kDfMQdo2PkDM6bqqAHMuZGWDO743f8ilDiVHoR/FmHD
	rrfu/UEc/LRUgKmWgQTLGtangHoxANlYhwZPFU7OXVAWuJNxemIMEy6Zl/DtonwqaHfpZsFwvUr
	cSg8g3hXk43r8Uq7F69cY=
X-Google-Smtp-Source: AGHT+IGoFzsgMuCvI3WFTIV1gLAsLg6Eqf2qi2R8NNJbSTC22ej3QSGhm/TBF6Apyuq4bSYsHAEokw==
X-Received: by 2002:a05:6a00:4b10:b0:7a2:7930:6854 with SMTP id d2e1a72fcca58-7a441bbe8b6mr1739421b3a.13.1761605947623;
        Mon, 27 Oct 2025 15:59:07 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a445156004sm245114b3a.51.2025.10.27.15.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 15:59:07 -0700 (PDT)
Message-ID: <b6f1be926ea382a9d4d30bdb8d09fa6b06d00165.camel@gmail.com>
Subject: Re: [PATCH v7 bpf-next 09/12] libbpf: support llvm-generated
 indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Mon, 27 Oct 2025 15:59:04 -0700
In-Reply-To: <dd184cdb0593392c6ad6c19111bfa17ac56bcb1f.camel@gmail.com>
References: <20251026192709.1964787-1-a.s.protopopov@gmail.com>
		 <20251026192709.1964787-10-a.s.protopopov@gmail.com>
	 <dd184cdb0593392c6ad6c19111bfa17ac56bcb1f.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-27 at 15:38 -0700, Eduard Zingerman wrote:
> [...]
>
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
> > +		pr_warn("jumptable start %d should be multiple of %u\n",
> > +			sym_off, jt_entry_size);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (jt_size % jt_entry_size) {
> > +		pr_warn("jumptable size %d should be multiple of %u\n",
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
> > +		pr_warn("jumptables_data size is %zd, trying to access %d\n",
> > +			obj->jumptables_data_sz, sym_off + jt_size);
> > +		err =3D -EINVAL;
> > +		goto err_close;
> > +	}
> > +
> > +	jt =3D (__u64 *)(obj->jumptables_data + sym_off);
> > +	for (i =3D 0; i < max_entries; i++) {
> > +		/*
> > +		 * The offset should be made to be relative to the beginning of
> > +		 * the main function, not the subfunction.
> > +		 */
> > +		insn_off =3D jt[i]/sizeof(struct bpf_insn);
> > +		if (!prog->subprogs) {
> > +			insn_off -=3D prog->sec_insn_off;
> > +		} else {
> > +			subprog_idx =3D find_subprog_idx(prog, relo->insn_idx);
>
> Nit: find_subprog_idx(prog, relo->insn_idx) can be moved outside of the l=
oop, I think.
>
> > +			if (subprog_idx < 0) {
> > +				pr_warn("invalid jump insn idx[%d]: %d, no subprog found\n",
> > +					i, relo->insn_idx);
> > +				err =3D -EINVAL;
> > +			}
> > +			insn_off -=3D prog->subprogs[subprog_idx].sec_insn_off;
> > +			insn_off +=3D prog->subprogs[subprog_idx].sub_insn_off;
> > +		}

I think I found a bug, related to this code path.
Consider the following test case:

	SEC("socket")
	__naked void foo(void)
	{
	        asm volatile ("                                         \
	        .pushsection .jumptables,\"\",@progbits;                \
	jt0_%=3D:                                                         \
	        .quad ret0_%=3D;                                          \
	        .quad ret1_%=3D;                                          \
	        .size jt0_%=3D, 16;                                       \
	        .global jt0_%=3D;                                         \
	        .popsection;                                            \
	                                                                \
	        r0 =3D jt0_%=3D ll;                                         \
	        r0 +=3D 8;                                                \
	        r0 =3D *(u64 *)(r0 + 0);                                  \
	        .8byte %[gotox_r0];                                     \
	        ret0_%=3D:                                                \
	        r0 =3D 0;                                                 \
	        exit;                                                   \
	        ret1_%=3D:                                                \
	        r0 =3D 1;                                                 \
	        call bar;                                               \
	        exit;                                                   \
	"       :                                                       \
	        : __imm_insn(gotox_r0, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_=
REG_0, 0, 0 , 0))
	        : __clobber_all);
	}
=09
	__used
	static int bar(void)
	{
	        return 0;
	}

Note a call instruction referring bar().  It triggers the code path
above (we need a test case with subprograms in verifier_gotox).
The test case fails to load with the following error:

  libbpf: invalid jump insn idx[0]: 0, no subprog found
  libbpf: prog 'foo': relo #0: can't create jump table: sym_off 368
  libbpf: prog 'foo': failed to relocate data references: -EINVAL

If I remove the `call bar;`, test case loads and passes.

> > +
> > +		/*
> > +		 * LLVM-generated jump tables contain u64 records, however
> > +		 * should contain values that fit in u32.
> > +		 */
> > +		if (insn_off > UINT32_MAX) {
> > +			pr_warn("invalid jump table value %llx at offset %d\n",
                                                          ^^^^
Nit:                                              maybe add 0x prefix here?

> > +				jt[i], sym_off + i);
> > +			err =3D -EINVAL;
> > +			goto err_close;
> > +		}
> > +
> > +		val.orig_off =3D insn_off;
> > +		err =3D bpf_map_update_elem(map_fd, &i, &val, 0);
> > +		if (err)
> > +			goto err_close;
> > +	}
>
> [...]

