Return-Path: <bpf+bounces-29553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 442EB8C2C98
	for <lists+bpf@lfdr.de>; Sat, 11 May 2024 00:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 676CB1C2149B
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 22:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA0713C3D6;
	Fri, 10 May 2024 22:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBFGgBPt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BE213D244
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 22:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715379983; cv=none; b=XbkCoF/2rH5UN9L+5/RER5NMnxuzQb8cgWmZG38H8+6dGP9pP7ehz3BzcRyYtje2+l6vamKuVEtkkxCdQzQ3+kockQA8H/EHCFRASDC51TDY1Yt8Gt+Alt1a2xESILjSM3N+GPzyDLBlMWYBULUF2aRYGwnUmc+k4Lps1searf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715379983; c=relaxed/simple;
	bh=4BB62TIa0evV0+3J8Do8jq1bhHCq0be1EKXpOOT5zig=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PhAOljsuLagIH3pcetXn0EjTBMr9vnKfeCSeUB2rNSRJX0feF/jmPbWpjN96lvjBHn7PKvXP3ttob93gzmREGix00+PZ3lOce/zcEJOjlvS62UcsBNTtEqwEbIJ7gsIIZ4rwwHDjGppdtgouxqfebLvGnln+oyFkXToOZARdZ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBFGgBPt; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2b4348fa971so1889294a91.1
        for <bpf@vger.kernel.org>; Fri, 10 May 2024 15:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715379981; x=1715984781; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rHprkPNm2+8IlA0q1sJrNNGC13o/f5WIzj3Mo5dBw+M=;
        b=aBFGgBPt/W/nDyvdDIuT7o8EgmvGOQrImrqWzfghV8C2PRwcBBXzzVo6YvIiMQyTW8
         E68EbWosgnAGHTyRHsEXHFi6hp/85jUeV5XawF8HeMzFkDMyjMIBlBHxd/KatiEDNo+i
         R+JLqTsiehaeGDHp3P2wIwSQCkIHUIrFN3iBMbCMPk+T0a7/Dgs+2TkyDAEWN/BmFBye
         jyty/SDSBHwwG3NtNNWILISiDgR7sDAoYP/qIGbB7dglUi/YrjLfh4Dl41bAYz2nWY68
         5IXrjjEYUH4q683NtcvIk805Co1FwQTrJECRSJA35N4r8ikcMe4kxFMGt8s5twFv+yAv
         c7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715379981; x=1715984781;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rHprkPNm2+8IlA0q1sJrNNGC13o/f5WIzj3Mo5dBw+M=;
        b=D4UMe0Bkft4RZGEYmj7GHU5CzvEsxyoEwF83LG6B1JpD4+DDODh++nDblxlF2FDusl
         5Bp+BkhfiitGzs5T5VG6iVJB6z5aFZo/jTiyp57rwgugdwEEpnNw7WXF+MnFQ7nlkPVk
         Oq5pqy8sff8c59RQu+0U7viZ1ArKmuFvvkZND/mSkHeZktVa0gXnlbTH2sdvS7KPs1LO
         0dcL7FDyhkXPPHmr/urB9tY8ny8gztmiCeyoeDSnIp9xYVgPA6CRamyr+XuDuBfmGpi5
         x7qQtbh63dUDcjy+T0z6slDwr4RebeGDFOXRPL6LxraJPWgKbwA559FwHjOAVWDsiv04
         ZD3g==
X-Forwarded-Encrypted: i=1; AJvYcCW0S2+wKMLBVuxewqdHF6UXGJEHPBzLrYKTklD/d73hL2+3NAbaxfmBEamoqIUc6Vbjs6nG8Mxwz9emMUN0uV+XzgVf
X-Gm-Message-State: AOJu0Yym6CE0BG+AaVXJbGZYnsuNVjvNlCDtLcX4EYMR5r8CuSrqa2pq
	bbwFll2Rhs4S6Y1tOvPxjNhCWUa8EZcs0XJd8rMuEwsdd5yIxjT9
X-Google-Smtp-Source: AGHT+IEh0QnD2fu4tD6BJ72WnxCiAL8c2Ruyg698Y2qsVTdnoEpOfGfTP1QzbLfu4iBNg61VbO/cCQ==
X-Received: by 2002:a17:90b:1914:b0:2b2:1d33:f687 with SMTP id 98e67ed59e1d1-2b6ccd8870emr3242581a91.47.1715379981345;
        Fri, 10 May 2024 15:26:21 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-634105e103dsm3101232a12.57.2024.05.10.15.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 15:26:20 -0700 (PDT)
Message-ID: <392d0bfe027cb88a5813f0832715439a76ed9de6.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 07/11] libbpf: split BTF relocation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org,
 jolsa@kernel.org,  acme@redhat.com, quentin@isovalent.com
Cc: mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev,  song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com,  kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, houtao1@huawei.com,  bpf@vger.kernel.org,
 masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Date: Fri, 10 May 2024 15:26:19 -0700
In-Reply-To: <20240510103052.850012-8-alan.maguire@oracle.com>
References: <20240510103052.850012-1-alan.maguire@oracle.com>
	 <20240510103052.850012-8-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-10 at 11:30 +0100, Alan Maguire wrote:

Looks good to me, but I think that comparison function should be
extended to include 'size' to cover some corner cases, see below.

[...]

> +/* Simple string comparison used for sorting within BTF, since all disti=
lled types are
> + * named.
> + */
> +static int cmp_btf_types(const void *id1, const void *id2, void *priv)
> +{
> +	const struct btf *btf =3D priv;
> +	const struct btf_type *t1 =3D btf_type_by_id(btf, *(__u32 *)id1);
> +	const struct btf_type *t2 =3D btf_type_by_id(btf, *(__u32 *)id2);
> +
> +	return strcmp(btf__name_by_offset(btf, t1->name_off),
> +		      btf__name_by_offset(btf, t2->name_off));
> +}
> +
> +/* Comparison between base BTF type (search type) and distilled base typ=
es (target).
> + * Because there is no bsearch_r() we need to use the search key - which=
 also is
> + * the first element of struct btf_relocate * - as a means to retrieve t=
he
> + * struct btf_relocate *.
> + */
> +static int cmp_base_and_distilled_btf_types(const void *idbase, const vo=
id *iddist)
> +{
> +	struct btf_relocate *r =3D (struct btf_relocate *)idbase;
> +	const struct btf_type *tbase =3D btf_type_by_id(r->base_btf, *(__u32 *)=
idbase);
> +	const struct btf_type *tdist =3D btf_type_by_id(r->dist_base_btf, *(__u=
32 *)iddist);
> +
> +	return strcmp(btf__name_by_offset(r->base_btf, tbase->name_off),
> +		      btf__name_by_offset(r->dist_base_btf, tdist->name_off));
> +}

Interestingly, comparison by name might not be sufficient.
E.g. in my test kernel there are a few STRUCT/UNION types with duplicate na=
mes:

$ comm -3 <(bpftool btf dump file vmlinux | grep '^[\[0-9\]\+] \(STRUCT\|UN=
ION\)' \
            | grep -v "'(anon)'" | awk '{ print $3 }' | sort) \
          <(bpftool btf dump file vmlinux | grep '^[\[0-9\]\+] \(STRUCT\|UN=
ION\)' \
            | grep -v "'(anon)'" | awk '{ print $3 }' | sort -u)
'chksum_desc_ctx'
'console'
'disklabel'
'dma_chan'
'd_partition'
'getdents_callback'
'irq_info'
'netlbl_domhsh_walk_arg'
'pci_root_info'
'perf_aux_event'
'perf_aux_event'
'port'
'syscall_tp_t'

I checked 'disklabel' and 'dma_chan', these are legit structures with
different size and number of members. The number of members is not
stored in the distilled BPF, but size could be used for additional
disambiguation.

> +
> +/* Build a map from distilled base BTF ids to base BTF ids. To do so, it=
erate
> + * through base BTF looking up distilled type (using binary search) equi=
valents.
> + *
> +static int btf_relocate_map_distilled_base(struct btf_relocate *r)
> +{
> +	struct btf_type *t;
> +	const char *name;
> +	__u32 id;
> +
> +	/* generate a sort index array of type ids sorted by name for distilled
> +	 * base BTF to speed lookups.
> +	 */
> +	for (id =3D 1; id < r->nr_dist_base_types; id++)
> +		r->dist_base_index[id] =3D id;
> +	qsort_r(r->dist_base_index, r->nr_dist_base_types, sizeof(__u32), cmp_b=
tf_types,
> +		(struct btf *)r->dist_base_btf);
> +
> +	for (id =3D 1; id < r->nr_base_types; id++) {
> +		struct btf_type *dist_t;
> +		int dist_kind, kind;
> +		bool compat_kind;
> +		__u32 *dist_id;
> +
> +		t =3D btf_type_by_id(r->base_btf, id);
> +		kind =3D btf_kind(t);
> +		/* distilled base consists of named types only. */
> +		if (!t->name_off)
> +			continue;
> +		switch (kind) {
> +		case BTF_KIND_INT:
> +		case BTF_KIND_FLOAT:
> +		case BTF_KIND_ENUM:
> +		case BTF_KIND_ENUM64:
> +		case BTF_KIND_FWD:
> +		case BTF_KIND_STRUCT:
> +		case BTF_KIND_UNION:
> +			break;
> +		default:
> +			continue;
> +		}
> +		r->search_id =3D id;
> +		dist_id =3D bsearch(&r->search_id, r->dist_base_index, r->nr_dist_base=
_types,
> +				  sizeof(__u32), cmp_base_and_distilled_btf_types);
> +		if (!dist_id)
> +			continue;
> +		if (!*dist_id || *dist_id > r->nr_dist_base_types) {
> +			pr_warn("base BTF id [%d] maps to invalid distilled base BTF id [%d]\=
n",
> +				id, *dist_id);
> +			return -EINVAL;
> +		}
> +		/* validate that kinds are compatible */
> +		dist_t =3D btf_type_by_id(r->dist_base_btf, *dist_id);
> +		dist_kind =3D btf_kind(dist_t);
> +		name =3D btf__name_by_offset(r->dist_base_btf, dist_t->name_off);
> +		compat_kind =3D dist_kind =3D=3D kind;
> +		if (!compat_kind) {
> +			switch (dist_kind) {
> +			case BTF_KIND_FWD:
> +				compat_kind =3D kind =3D=3D BTF_KIND_STRUCT || kind =3D=3D BTF_KIND_=
UNION;
> +				break;
> +			case BTF_KIND_ENUM:
> +				compat_kind =3D kind =3D=3D BTF_KIND_ENUM64;
> +				break;
> +			default:
> +				break;
> +			}
> +			if (!compat_kind) {
> +				pr_warn("kind incompatibility (%d !=3D %d) between distilled base ty=
pe '%s'[%d] and base type [%d]\n",
> +					dist_kind, kind, name, *dist_id, id);
> +				return -EINVAL;
> +			}
> +		}
> +		/* validate that int, float struct, union sizes are compatible;
> +		 * distilled base BTF encodes an empty STRUCT/UNION with
> +		 * specific size for cases where a type is embedded in a split
> +		 * type (so has to preserve size info).  Do not error out
> +		 * on mismatch as another size match may occur for an
> +		 * identically-named type.
> +		 */
> +		switch (btf_kind(dist_t)) {
> +		case BTF_KIND_INT:

Nit: INT is followed by u32 with additional information,
     maybe that should be compared as well.

> +		case BTF_KIND_FLOAT:
> +		case BTF_KIND_STRUCT:
> +		case BTF_KIND_UNION:
> +			if (t->size =3D=3D dist_t->size)
> +				break;
> +			continue;
> +		default:
> +			break;
> +		}
> +		r->map[*dist_id] =3D id;
> +	}
> +	/* ensure all distilled BTF ids have a mapping... */
> +	for (id =3D 1; id < r->nr_dist_base_types; id++) {
> +		t =3D btf_type_by_id(r->dist_base_btf, id);
> +		name =3D btf__name_by_offset(r->dist_base_btf, t->name_off);
> +		if (!r->map[id]) {
> +			pr_warn("distilled base BTF type '%s' [%d] is not mapped to base BTF =
id\n",
> +				name, id);
> +			return -EINVAL;
> +		}

Nit: maybe rewrite this like below?

		if (r->map[id])
			continue;

		t =3D btf_type_by_id(r->dist_base_btf, id);
		name =3D btf__name_by_offset(r->dist_base_btf, t->name_off);
		pr_warn("distilled base BTF type '%s' [%d] is not mapped to base BTF id\n=
",
			name, id);

> +	}
> +	return 0;
> +}

[...]

