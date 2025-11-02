Return-Path: <bpf+bounces-73273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBCDC29736
	for <lists+bpf@lfdr.de>; Sun, 02 Nov 2025 22:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E05704E4585
	for <lists+bpf@lfdr.de>; Sun,  2 Nov 2025 21:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CFD1E260A;
	Sun,  2 Nov 2025 21:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBDoAkUV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99312BCF5
	for <bpf@vger.kernel.org>; Sun,  2 Nov 2025 21:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762119156; cv=none; b=BSdTnfVtCHc1PmtlgA9OvfXazAHDWBvtwXITe0i5+zhz6KceH+ZMw/2v5Eaf8x8iAYOdzuva9E2xqortkVDJ1ahIk7CX+p3s7LoKnXAkx/xy3PI3EvnbKbiw7I7/bHO4S8lFqKYG3cUkwtJGLLM7DNRhiT46SZsnLBfaJFambmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762119156; c=relaxed/simple;
	bh=cQSjC5lIjXmczeE602DdhyDR0uBZVqiS70jv+J7IIs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmH8kRNMPv41998WiAgbdBSntGgE0Z/Xib6iqyQ8cRM88cQBkN/VmY/wvL5rKSJTxbOE2y26izUzE6qttsjuG+vvdibEik6iVCLri/BTlRbGk+7Krer+2miICl7PlZkydvv7XzV0ZZAU18djwdsk0ke7lTYbvrxmGQFqr8/q0qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBDoAkUV; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-640860f97b5so2305427a12.2
        for <bpf@vger.kernel.org>; Sun, 02 Nov 2025 13:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762119153; x=1762723953; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TVX1GgSI7iY/rkZKS3WhyzbSe9olbRyzB3hWYYm8YDw=;
        b=NBDoAkUVCo+p4B2ltXubWbzaw4UVeQHcXf+eHC4xK58BSYTcX6XeEv3k56sgED9L+D
         XnS2Hw9jsO9u0U4c24+Ns+C2lCPQWjgvBiTs6gvK35XzJydqsQg5MP0t8Zg4e7Q2AX6Y
         hD84Gbanbd7Lp5rQMviDQpbxebGk1DrwzbMVCYrOEbun4Do9Uroejfpcl+Tyg61k5f3F
         6u1dIaB8i6A8Tu8rDSuLHkK2QRWEMzvGj8fbhdqYKwdxW+B0wOKN4MMRBn1+feNPB5Fi
         +pAALraZq1DhLOjDwaVtvR8+Q6eNjhLd2rjiKmEodPPrVH0CCT6GOTRKUb4UbH4n5srt
         gd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762119153; x=1762723953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVX1GgSI7iY/rkZKS3WhyzbSe9olbRyzB3hWYYm8YDw=;
        b=dYkxjS+ViewF94mV8zkoQcS63q1rI91uTQI1/9FBn8ihkJ6iBNz593wzWkJcK/v1NA
         9YIrtd4DAiq03baV6UYIPz9vCoLPUEamzHu1GQr4Gjd5Tx5a5O+d7hCFVDDqagfSErGH
         2BGE4z5HQp6V47GU77KvDSsdIFuGgWbv1mnDEBrkBZeGrefL7bOg7R2Eot5znoEZMKG1
         H1Fc8/tQmIwuzWnGsRMq9CKbceVdUBHGDyfKXYnRMKDFXAlurFw8vuJ5V9FcCpKLv2OG
         WTrA74J2bXr/P0LvGXcBqM3MuJPZaTtCqj/Utm4ftjA6cs15Xms7g8WXw1u2WJZiBSm/
         2Rlg==
X-Gm-Message-State: AOJu0YyHv/AcWR+7Hb2TUMlRAP7bls9lLk+QXvqSFdjGY24tUJm4KemR
	MjFpU9OxalaUkcDjMMJBhozINblld0n1FylJZO5trqUcO8jjEq44FeZv
X-Gm-Gg: ASbGnctTi5UJ9Pn3jI7RzUhCZkxknbyb86PZfBRFj+k9V21oNYTWyU4CrOtYGxHBcCl
	nPGFvLZcKRbF/3m013TrcNsuVMG02P3+5l12nacutS8MRn/A7dBakrkvzs1Yh/kczdyAKT4mXAv
	ziaodB7XgVba7mSlpX9Ek9ZRTF9XyPUGsVGHrymtugb8G89ABmPeNv9kNnX/mOQ5avrMVjS5plN
	8Ypp7usjXrz5X3o7HNrX2NkdizGfcPPofkqflOAwzN9mJZsdrU2kVE3RqTe6r0uaC1UdUNLnWzU
	TBBhVtZ7ZtOPgucLBf7d+Bx4Vh2aM64T+JmHuggyiKIygaXiGWmA+8wSUwcVMXpmuX8zdtX58hX
	Sl+Y3eN3701d2j+YRRH0NYui+bND2Z4AOkZxzCk4V2g+V0Og9LckEjRkAVh/TBrNYUexaiurk0f
	nsGeQVXfvYGw==
X-Google-Smtp-Source: AGHT+IHzhRKXY80Qqe9hDLq29/EVZvrhbHFlEyoPKLAgQk+TB99kBXaiAurwwLyyMiJiv1r8qKaD3A==
X-Received: by 2002:a05:6402:440d:b0:637:dfb1:33a8 with SMTP id 4fb4d7f45d1cf-64076f7cb99mr10588462a12.3.1762119152985;
        Sun, 02 Nov 2025 13:32:32 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6408ef1c486sm6230947a12.36.2025.11.02.13.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 13:32:32 -0800 (PST)
Date: Sun, 2 Nov 2025 21:38:53 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	aspsk@isovalent.com, daniel@iogearbox.net, eddyz87@gmail.com,
	qmo@kernel.org, yonghong.song@linux.dev, martin.lau@kernel.org,
	clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH v10 bpf-next 08/11] libbpf: support llvm-generated
 indirect jumps
Message-ID: <aQfPbc97GSajDCcc@mail.gmail.com>
References: <20251102205722.3266908-9-a.s.protopopov@gmail.com>
 <311fb2ea7bc0de371449e98951bf8366aa8b30be8c50c8c549e2501fc9095878@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <311fb2ea7bc0de371449e98951bf8366aa8b30be8c50c8c549e2501fc9095878@mail.kernel.org>

On 25/11/02 09:13PM, bot+bpf-ci@kernel.org wrote:
> 
> ```
> commit b44690c09995d34f7665c7d687b359d41a6ab79f
> Author: Anton Protopopov <a.s.protopopov@gmail.com>
> 
> libbpf: support llvm-generated indirect jumps
> 
> This commit adds support for LLVM-generated indirect jumps in BPF v4
> instruction set. It handles jump table metadata from the .jumptables
> ELF section and creates BPF_MAP_TYPE_INSN_ARRAY maps for them.
> 
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index fbe74686c..ed14090a9 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> 
> [ ... ]
> 
> > @@ -6144,6 +6192,157 @@ static void poison_kfunc_call(struct bpf_program *prog, int relo_idx,
> >  	insn->imm = POISON_CALL_KFUNC_BASE + ext_idx;
> >  }
> >
> > +static int find_jt_map(struct bpf_object *obj, struct bpf_program *prog, int sym_off)
> > +{
> 
> [ ... ]
> 
> > +static int create_jt_map(struct bpf_object *obj, struct bpf_program *prog, struct reloc_desc *relo)
> > +{
> > +	const __u32 jt_entry_size = 8;
> > +	int sym_off = relo->sym_off;
> > +	int jt_size = relo->sym_size;
> > +	__u32 max_entries = jt_size / jt_entry_size;
> > +	__u32 value_size = sizeof(struct bpf_insn_array_value);
> > +	struct bpf_insn_array_value val = {};
> > +	int subprog_idx;
> > +	int map_fd, err;
> > +	__u64 insn_off;
> > +	__u64 *jt;
> > +	__u32 i;
> > +
> > +	map_fd = find_jt_map(obj, prog, sym_off);
> > +	if (map_fd >= 0)
> > +		return map_fd;
> > +
> > +	if (sym_off % jt_entry_size) {
> > +		pr_warn("map '.jumptables': jumptable start %d should be multiple of %u\n",
> > +			sym_off, jt_entry_size);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (jt_size % jt_entry_size) {
> > +		pr_warn("map '.jumptables': jumptable size %d should be multiple of %u\n",
> > +			jt_size, jt_entry_size);
> > +		return -EINVAL;
> > +	}
> > +
> > +	map_fd = bpf_map_create(BPF_MAP_TYPE_INSN_ARRAY, ".jumptables",
> > +				4, value_size, max_entries, NULL);
> > +	if (map_fd < 0)
> > +		return map_fd;
> > +
> > +	if (!obj->jumptables_data) {
> > +		pr_warn("map '.jumptables': ELF file is missing jump table data\n");
> > +		err = -EINVAL;
> > +		goto err_close;
> > +	}
> > +	if (sym_off + jt_size > obj->jumptables_data_sz) {
> > +		pr_warn("map '.jumptables': jumptables_data size is %zd, trying to access %d\n",
> > +			obj->jumptables_data_sz, sym_off + jt_size);
> > +		err = -EINVAL;
> > +		goto err_close;
> > +	}
> > +
> > +	subprog_idx = -1; /* main program */
> > +	if (relo->insn_idx < 0 || relo->insn_idx >= prog->insns_cnt) {
> > +		pr_warn("map '.jumptables': invalid instruction index %d\n", relo->insn_idx);
> > +		err = -EINVAL;
> > +		goto err_close;
> > +	}
> > +	if (prog->subprogs)
> > +		subprog_idx = find_subprog_idx(prog, relo->insn_idx);
> > +
> > +	jt = (__u64 *)(obj->jumptables_data + sym_off);
> > +	for (i = 0; i < max_entries; i++) {
> > +		/*
> > +		 * The offset should be made to be relative to the beginning of
> > +		 * the main function, not the subfunction.
> > +		 */
> > +		insn_off = jt[i]/sizeof(struct bpf_insn);
> > +		if (subprog_idx >= 0) {
> > +			insn_off -= prog->subprogs[subprog_idx].sec_insn_off;
> > +			insn_off += prog->subprogs[subprog_idx].sub_insn_off;
> > +		} else {
> > +			insn_off -= prog->sec_insn_off;
> > +		}
> > +
> > +		/*
> > +		 * LLVM-generated jump tables contain u64 records, however
> > +		 * should contain values that fit in u32.
> > +		 */
> > +		if (insn_off > UINT32_MAX) {
> > +			pr_warn("map '.jumptables': invalid jump table value 0x%llx at offset %d\n",
> > +				(long long)jt[i], sym_off + i);
>                                                       ^^^^^^^^^^^^
> 
> Does this error message print the correct offset? Since jt is a pointer
> to __u64, the array access jt[i] is at byte offset "sym_off + i * 8",
> not "sym_off + i". All the other error messages in create_jt_map report
> byte offsets and sizes (sym_off, jt_size, sym_off + jt_size), so this
> one should probably be "sym_off + i * jt_entry_size" for consistency.

Is there a way to run this AI as part of any PR to
kernel-patches/bpf, not only those coming from the mailing list?
Maybe for a selected commit?

Also, how deterministinc it is?  Will it generate different comments
for a given patch for different runs?

> > +			err = -EINVAL;
> > +			goto err_close;
> > +		}
> > +
> > +		val.orig_off = insn_off;
> > +		err = bpf_map_update_elem(map_fd, &i, &val, 0);
> > +		if (err)
> > +			goto err_close;
> > +	}
> > +
> > +	err = bpf_map_freeze(map_fd);
> > +	if (err)
> > +		goto err_close;
> > +
> > +	err = add_jt_map(obj, prog, sym_off, map_fd);
> > +	if (err)
> > +		goto err_close;
> > +
> > +	return map_fd;
> > +
> > +err_close:
> > +	close(map_fd);
> > +	return err;
> > +}
> 
> [ ... ]
> 
> 
> ```
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> In-Reply-To-Subject: `libbpf: support llvm-generated indirect jumps`
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19018051915


