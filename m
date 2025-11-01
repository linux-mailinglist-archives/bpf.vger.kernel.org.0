Return-Path: <bpf+bounces-73247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7BCC283C8
	for <lists+bpf@lfdr.de>; Sat, 01 Nov 2025 18:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6411F3B7C79
	for <lists+bpf@lfdr.de>; Sat,  1 Nov 2025 17:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30478295DB8;
	Sat,  1 Nov 2025 17:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRDa67Sy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A122C0F66
	for <bpf@vger.kernel.org>; Sat,  1 Nov 2025 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762017678; cv=none; b=eldIC3yDSNYjdUQJBw4CZxT+O6YYKXJ65KNzkq31C6Wt9A7flSp5xFQq+UWaBkaJrDSYN7eHapiMEHuBA5WZyX8akXnUrYVlJS1P7VfSx4cYqko4z9QxeEKqluaok18nJ3qyHKP/ogLzO25vOYpjU3VxNc+40LSt2ydKMBwGnJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762017678; c=relaxed/simple;
	bh=7hmfk6tMRXLLYUlHjlX35Nx0cDcyJVc59wLvQj0qTx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m79ANPDs+RKhrHG3TaurPL6DfTuEI0vrCB1V5IGHOUeNEznmJRnWrtUP19Ka0DlCXKs9mOft0a9kyqYL/2fQ0DEJRhYssD/Bw90x7uG8hAjYCYJPZwTFJzQ7fe2dhFQz0+vskXQjdPdlqd/2K60CzxXUSsMJa6cMic1pEbAgJ0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRDa67Sy; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-475ca9237c2so17367345e9.3
        for <bpf@vger.kernel.org>; Sat, 01 Nov 2025 10:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762017674; x=1762622474; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UL2jTy7hWBBgBTBLDtYJLSiuUglUkvBIMweoyywSSqs=;
        b=TRDa67SyrDRTTTk/iqlRfzBvQfzO9gWeAnuWtvDR+X2d03w796yJrno1QcURMHVD0z
         Kz1IRNn4yXiNAtel1D4P7Vsi04vLsYMKTgPhAiuEOrpwnIDTiLsxWvtV98uiKitajE3y
         V3x2QhyCYN/S9Eq7ZqCkrhH2O9WoBQ4I6ET1OcovVdJOf1MioaIvmgHes+UUhd0IrXqe
         zfK5UsxlWCZsvm9bipa7d/WsRCqrllr5FbHlszYsKpkg4IGI5MsOEguG2GirCf4EpFyN
         a+MhTNjxSDVkOuTFxJgAHhiQF6NikOjP22pICVPNl7VKCF8DvonV+72TsRoWFiZlXDKQ
         AAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762017674; x=1762622474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UL2jTy7hWBBgBTBLDtYJLSiuUglUkvBIMweoyywSSqs=;
        b=wCImAQVReAPg28faveSk7Sm+wnvirmltMiZit6RAZm2ehsVE6UetyP8ERQpft+Fx8L
         Q65vWmH98x6sVZKHoWO3L9Pa4C693Ktoz/dGPJIHIAzJKFrUZEJ4Q/fw1JSZlCjvx4Fe
         HTR2t6CV914nQOaoLqsxzCL5+KVz8+j/zLTDPhfHgqw/6d+9zHvItBnKOT2wnLePfcEJ
         BqpSAHF3NdwfFJXxVHi9phVIivY/aeTO0RViEGIM+LOHx+6Ha4BLIoL6WsvkToshs5yE
         Hwtbjyyj0LzzH5nF2+hx5ze6mSETy8O/nxy7bAxJLrYe4Wx+47z2nDvczaRbCbGYBeHL
         1Xmw==
X-Gm-Message-State: AOJu0YyuuSTvoSmhoWCnyVQa+/P5sAQSd6VrASnG200Ge3SpByLq9a6S
	j6QlnYHgbT4+L7fENFVb8Q8f+QHol7FS5/yo1Jnh9c7Q7NCC8rkoDUm+
X-Gm-Gg: ASbGncuotUgjQzjTJGVAiBAo59SmqZJ9+iZ6jjFUAzq+kkDpGpWz1GLd3qgYi0Kgz6a
	KJCigg3rSCdmfvhiJCpN7FTAfmCHTs2GJb3g3l7ycDSZGvSg8vGKUOAUGOS5yYMz7l58zbrWfRk
	WOk47bTFE00Mj9xgd7DNSjqYxqY0oX/GmF7GdMn+/8Kq0G2VmJ+Ilto9civvv1JSX3eq9xV7C5h
	SkybuliFsFPhg2Sla+Wb7JLxcuEs7ddQifhbKam3J/O0mCsgQ7sdIqhQ9NyV+Zc37pnRZNWqIUN
	SPYDFTskJCph1fiD9zx/LmI8YWq7SO54uQsLJIUvGC8YngbmZAAo6csf2VUfhnjouRELPNCnsE6
	GZtk1Ak7/Ujxy9tO3MgtrS12j/CwJdwPxN+iUsLPPKY010LIU03SqkBxVVKxCoMb2llqTCCjSzs
	ZRzHkK04js1fgV3CHWI3i5
X-Google-Smtp-Source: AGHT+IFDPMnAGpcDbYVPLF5IkXB0PWY1cz5Vx0NkwJnUBlMq+ZAMWdR2eYxggRLTdyKDoMKHPEVCFQ==
X-Received: by 2002:a05:600c:5307:b0:477:af8:25a with SMTP id 5b1f17b1804b1-477302d5e76mr68197075e9.0.1762017673860;
        Sat, 01 Nov 2025 10:21:13 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c9416f82sm3873055f8f.6.2025.11.01.10.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 10:21:13 -0700 (PDT)
Date: Sat, 1 Nov 2025 17:27:37 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	aspsk@isovalent.com, daniel@iogearbox.net, eddyz87@gmail.com,
	qmo@kernel.org, yonghong.song@linux.dev, martin.lau@kernel.org,
	clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH v9 bpf-next 06/11] bpf, x86: add support for indirect
 jumps
Message-ID: <aQZDCStdMJq/fG09@mail.gmail.com>
References: <20251101110717.2860949-7-a.s.protopopov@gmail.com>
 <22279948629130284ac94db4c37f1d6e44f0ac9dd2e6724e8562ba9d87156f61@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22279948629130284ac94db4c37f1d6e44f0ac9dd2e6724e8562ba9d87156f61@mail.kernel.org>

On 25/11/01 11:30AM, bot+bpf-ci@kernel.org wrote:
> 
> ```
> commit cb92a900026e1efa9f89af1f2682f1b544cc7e22
> Author: Anton Protopopov <a.s.protopopov@gmail.com>
> 
> bpf, x86: add support for indirect jumps
> 
> This patch adds support for indirect jumps (gotox instruction) in BPF
> programs, introducing a new PTR_TO_INSN register type to ensure jump
> targets are loaded from verified instruction array maps.
> 
> > diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
> > index d29f38721..7bf345a87 100644
> > --- a/kernel/bpf/bpf_insn_array.c
> > +++ b/kernel/bpf/bpf_insn_array.c
> > @@ -114,6 +114,20 @@ static u64 insn_array_mem_usage(const struct bpf_map *map)
> >  	return insn_array_alloc_size(map->max_entries);
> >  }
> >
> > +static int insn_array_map_direct_value_addr(const struct bpf_map *map, u64 *imm, u32 off)
> > +{
> > +	struct bpf_insn_array *insn_array = cast_insn_array(map);
> > +
> > +	if ((off % sizeof(long)) != 0 ||
> > +	    (off / sizeof(long)) >= map->max_entries)
> > +		return -EINVAL;
> > +
> > +	/* from BPF's point of view, this map is a jump table */
> > +	*imm = (unsigned long)insn_array->ips + off;
> > +
> > +	return 0;
> > +}
> 
> The insn_array_alloc_size() function can overflow. It computes:
> 
>   base_size + max_entries * (entry_size + sizeof(long))
> 
> and returns u32. With entry_size=16 and sizeof(long)=8, if max_entries
> exceeds ~178 million, the multiplication overflows u32 before the
> result is widened to u64 in insn_array_alloc(). This could result in
> allocating a buffer much smaller than intended.
> 
> While BPF programs have size limits, max_entries validation in
> insn_array_alloc_check() only checks != 0 without an upper bound. Should
> insn_array_alloc_size() return u64 or add overflow checking?

Yes, however see the comments in the relevant patch, not here.

> [ ... ]
> 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 2b771e2bf..3fdabae07 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> 
> [ ... ]
> 
> > @@ -17833,6 +17861,197 @@ static struct bpf_iarray *iarray_realloc(struct bpf_iarray *old, size_t n_elem)
> >  	return new;
> >  }
> >
> > +static int copy_insn_array(struct bpf_map *map, u32 start, u32 end, u32 *items)
> > +{
> > +	struct bpf_insn_array_value *value;
> > +	u32 i;
> > +
> > +	for (i = start; i <= end; i++) {
> > +		value = map->ops->map_lookup_elem(map, &i);
> > +		if (!value)
> > +			return -EINVAL;
> > +		items[i - start] = value->xlated_off;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int cmp_ptr_to_u32(const void *a, const void *b)
> > +{
> > +	return *(u32 *)a - *(u32 *)b;
> > +}
> > +
> > +static int sort_insn_array_uniq(u32 *items, int cnt)
> > +{
> > +	int unique = 1;
> > +	int i;
> > +
> > +	sort(items, cnt, sizeof(items[0]), cmp_ptr_to_u32, NULL);
> > +
> > +	for (i = 1; i < cnt; i++)
> > +		if (items[i] != items[unique - 1])
> > +			items[unique++] = items[i];
> > +
> > +	return unique;
> > +}
> > +
> > +/*
> > + * sort_unique({map[start], ..., map[end]}) into off
> > + */
> > +static int copy_insn_array_uniq(struct bpf_map *map, u32 start, u32 end, u32 *off)
> > +{
> > +	u32 n = end - start + 1;
> > +	int err;
> > +
> > +	err = copy_insn_array(map, start, end, off);
> > +	if (err)
> > +		return err;
> > +
> > +	return sort_insn_array_uniq(off, n);
> > +}
> > +
> > +/*
> > + * Copy all unique offsets from the map
> > + */
> > +static struct bpf_iarray *jt_from_map(struct bpf_map *map)
> > +{
> > +	struct bpf_iarray *jt;
> > +	int n;
> > +
> > +	jt = iarray_realloc(NULL, map->max_entries);
> > +	if (!jt)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	n = copy_insn_array_uniq(map, 0, map->max_entries - 1, jt->items);
> > +	if (n < 0) {
> > +		kvfree(jt);
> > +		return ERR_PTR(n);
> > +	}
> > +
> > +	return jt;
> > +}
>                   ^^^^
> 
> The iarray_realloc() call sets jt->cnt = map->max_entries, but
> copy_insn_array_uniq() returns n (the actual number of unique items)
> which could be less. The function returns without updating jt->cnt to n.
> 
> In jt_from_subprog()->jt_from_map(), at the check:
> 
>   if (jt_cur->items[0] >= subprog_start && jt_cur->items[0] < subprog_end)
> 
> Can items[0] be accessed when n=0? If the map contains no valid entries,
> jt_cur->cnt still equals max_entries but no items were populated.
> 
> Later at:
> 
>   memcpy(jt->items + old_cnt, jt_cur->items, jt_cur->cnt << 2);
> 
> This copies jt_cur->cnt elements, but cnt=max_entries, not the actual
> count. Does this copy uninitialized memory from the jt_cur->items array?

Right, looks suspicious. No problem, with accessing items[0], as at
least one element will be there. However, it looks like it might
if fact copy duplicated values. Will fix.

> [ ... ]
> 
> > @@ -18855,6 +19074,9 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
> >  		return regs_exact(rold, rcur, idmap) && rold->frameno == rcur->frameno;
> >  	case PTR_TO_ARENA:
> >  		return true;
> > +	case PTR_TO_INSN:
> > +		return (rold->off == rcur->off && range_within(rold, rcur) &&
> > +			tnum_in(rold->var_off, rcur->var_off));
> >  	default:
> >  		return regs_exact(rold, rcur, idmap);
> >  	}
>                      ^^^^
> 
> Should PTR_TO_INSN check map_ptr equality like PTR_TO_MAP_VALUE does?
> 
> The PTR_TO_MAP_VALUE case uses memcmp() which compares all fields
> including map_ptr. But this PTR_TO_INSN case only checks off, range, and
> var_off. If a BPF program uses multiple INSN_ARRAY maps with different
> jump tables, could state pruning incorrectly consider two PTR_TO_INSN
> registers equivalent when they point to different maps?

Thanks AI, looks real, will add a fix.

> 
> ```
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> In-Reply-To-Subject: `bpf, x86: add support for indirect jumps`
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/18995945884


