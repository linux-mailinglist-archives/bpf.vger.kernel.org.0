Return-Path: <bpf+bounces-73327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAA6C2A88D
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 09:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4CCB3A847F
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 08:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36552D7DDC;
	Mon,  3 Nov 2025 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lp9FOTLw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2072D7818
	for <bpf@vger.kernel.org>; Mon,  3 Nov 2025 08:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762157700; cv=none; b=dvRBnC1aSzgtclx0lYLxcaEDuxNVgiGMHqLlEn8XYqTry+7sz+qG3eQfkspnX3rEDuoGnyNbRC/krh7bzlTNTqTYB2zN/ZWL3gBIy5kjJ1IeLh5KmmGWViQHIb0XPm8Q7c1+UFlhOS/n+O0xgWZyIiMykW+j/a1qGwGvwNLNzw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762157700; c=relaxed/simple;
	bh=Wzkrhka1MC+pnQ5Wv66H14t/AoSZA4Dmc9JzgcEaWOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Onaz8NXBmUCsLjWBUzBemzI+2HeqaZUD/X9mKeo6dy/WkVbZHyZdJw1i8/LUTOR5izNN9xkBGxTbRltOBOHC4DR5O4BYfX2kccNXm3YtF3R4yiFTYF0+fWpRy30KYheWo+FMhj2iwshSSV3/jBQPPQzaTNZ/P629xG9AeXydKFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lp9FOTLw; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-640860f97b5so2719765a12.2
        for <bpf@vger.kernel.org>; Mon, 03 Nov 2025 00:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762157697; x=1762762497; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jSK1tesLxib5qFf2fLOLkJOj3qgc6+HNRW3ouzRosew=;
        b=lp9FOTLwrTEHr9jmLItBKWr2EHK6I88k7JbRbUB3ZwsaDt9eIjudDpKnIoxaAvQbuX
         6YcxFqBt3466/1GNy8d/X1dR3bU9k1Fgtfhb9ggK0Nt0CeN/HkiHiwRAZrC1wwGcmDpE
         cmdxGyAtz3RMwb2lTa3M4ey/Tva6mAqv83lKVp0bFvXtmZ3gIcxtvPKC8tnVcjiYAbrK
         BWPdhsCxNZ//Pb01w9WC9YVVYHwTAyQUdO80MzjlnPusJjoDdlccvYHhyItoGBCvu67Y
         AIJucjY7RXNdAoBhX8wFXwLjed66Eeq8sGZwZRZv+KxK4HxjB79gwYiJWVRl5Qbjd3R1
         DedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762157697; x=1762762497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSK1tesLxib5qFf2fLOLkJOj3qgc6+HNRW3ouzRosew=;
        b=idaNTwgQORtWQNMikvSUpdQKnS6F8K0P7PYuaZwLlFnzydYMDivPu7Yc3LEVl3Q0tM
         U+pexu2GORU2Vf05/yUruitHr558E8V6DXynxzvZ5/QzRpr4uwNMwEM8UYpRmYQBEMRx
         u9hjHDefZTXRlo83zAk9PzNuCB4MYC50UvR+1NbWGxDHfS0S/qb7IjuaHHNls+zjey3H
         SY9oc4p5puVI+kF97qvl3NWT29Mx/ignKO2sUER1K4XoTvaQ1bzRctj8GOlKLQYN8ViP
         teAacUpFHH7HUb9329jZflpRsNRvUr3DYWTPBp4kJKPK5pwKB5Th7k+9lKBS14/cnaLf
         qb7Q==
X-Gm-Message-State: AOJu0YwnsvIeIsx0D+N+5WZMK1kwHv/KA2l7Y9LZdKeZwAm6dYEKeVz1
	5e2Fgjhht3pECoU2K3pOD6be7YhhNu3Mn9B4zmczWIo2Indal8XQG8Y6
X-Gm-Gg: ASbGncvESRJsoCJnM7gGAJl5xT4aHNhowZO0QcEUbt4xjQ/pLCK5H4wYWACzQRJf6Eg
	O49t2Xo6k1cqn1CwH+CluiodhDyCmVTmFF8f7wWKf4d8032JuXBjIT4Z1dsxF4BmEafo6oSGA6o
	hBInjOdre0FtAGULZ38Ryg14ywnhLcaKy5lMmihB2BxhdGm7Ng+PU5lh+T1vMQKcfuNdMsuYx7/
	9bNNj+rPrfhZpkWJ91bcJqsn2FHlwsUOwuSlw6uytiPHoY9FxDnO2V4IkigbjO3O6jTjTx1pxXN
	lbkBl/6VPe6wLTXc5hTj/679QjUwy/CtiAMwcFC+FU3w0zFjze6QrqEufCJ/y9gf9sieHqJqg7z
	VLF8ECRalSnQt917PLqy6AH+VFysgLeI7MbIT0NjZkn+UOjWalpiF94ReKvReWXb7REg0n3XF/w
	hDqU6YkkfaEUac5Bb3IdAR
X-Google-Smtp-Source: AGHT+IGnfFwTR6Le8qLT5ZXfPrX+gkhUZcQJYm49ktMnAfLg50s2wErySe4UAZpyPLhpUNorNBzNKA==
X-Received: by 2002:a17:907:720b:b0:b41:873d:e226 with SMTP id a640c23a62f3a-b70700d6dd2mr1257423666b.1.1762157696621;
        Mon, 03 Nov 2025 00:14:56 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70b91e44a8sm323986266b.33.2025.11.03.00.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 00:14:56 -0800 (PST)
Date: Mon, 3 Nov 2025 08:21:15 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	aspsk@isovalent.com, daniel@iogearbox.net, eddyz87@gmail.com,
	qmo@kernel.org, yonghong.song@linux.dev, martin.lau@kernel.org,
	clm@meta.com
Subject: Re: [PATCH v10 bpf-next 08/11] libbpf: support llvm-generated
 indirect jumps
Message-ID: <aQhl+wrcZxzDWFkW@mail.gmail.com>
References: <20251102205722.3266908-9-a.s.protopopov@gmail.com>
 <311fb2ea7bc0de371449e98951bf8366aa8b30be8c50c8c549e2501fc9095878@mail.kernel.org>
 <aQfPbc97GSajDCcc@mail.gmail.com>
 <4a9ba760-c9e4-4851-b971-ac929811c52a@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a9ba760-c9e4-4851-b971-ac929811c52a@linux.dev>

On 25/11/02 04:32PM, Ihor Solodrai wrote:
> 
> 
> On 11/2/25 1:38 PM, Anton Protopopov wrote:
> > On 25/11/02 09:13PM, bot+bpf-ci@kernel.org wrote:
> >>
> >> ```
> >> commit b44690c09995d34f7665c7d687b359d41a6ab79f
> >> Author: Anton Protopopov <a.s.protopopov@gmail.com>
> >>
> >> libbpf: support llvm-generated indirect jumps
> >>
> >> This commit adds support for LLVM-generated indirect jumps in BPF v4
> >> instruction set. It handles jump table metadata from the .jumptables
> >> ELF section and creates BPF_MAP_TYPE_INSN_ARRAY maps for them.
> >>
> >>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> >>> index fbe74686c..ed14090a9 100644
> >>> --- a/tools/lib/bpf/libbpf.c
> >>> +++ b/tools/lib/bpf/libbpf.c
> >>
> >> [ ... ]
> >>
> >>> @@ -6144,6 +6192,157 @@ static void poison_kfunc_call(struct bpf_program *prog, int relo_idx,
> >>>  	insn->imm = POISON_CALL_KFUNC_BASE + ext_idx;
> >>>  }
> >>>
> >>> +static int find_jt_map(struct bpf_object *obj, struct bpf_program *prog, int sym_off)
> >>> +{
> >>
> >> [ ... ]
> >>
> >>> +static int create_jt_map(struct bpf_object *obj, struct bpf_program *prog, struct reloc_desc *relo)
> >>> +{
> >>> +	const __u32 jt_entry_size = 8;
> >>> +	int sym_off = relo->sym_off;
> >>> +	int jt_size = relo->sym_size;
> >>> +	__u32 max_entries = jt_size / jt_entry_size;
> >>> +	__u32 value_size = sizeof(struct bpf_insn_array_value);
> >>> +	struct bpf_insn_array_value val = {};
> >>> +	int subprog_idx;
> >>> +	int map_fd, err;
> >>> +	__u64 insn_off;
> >>> +	__u64 *jt;
> >>> +	__u32 i;
> >>> +
> >>> +	map_fd = find_jt_map(obj, prog, sym_off);
> >>> +	if (map_fd >= 0)
> >>> +		return map_fd;
> >>> +
> >>> +	if (sym_off % jt_entry_size) {
> >>> +		pr_warn("map '.jumptables': jumptable start %d should be multiple of %u\n",
> >>> +			sym_off, jt_entry_size);
> >>> +		return -EINVAL;
> >>> +	}
> >>> +
> >>> +	if (jt_size % jt_entry_size) {
> >>> +		pr_warn("map '.jumptables': jumptable size %d should be multiple of %u\n",
> >>> +			jt_size, jt_entry_size);
> >>> +		return -EINVAL;
> >>> +	}
> >>> +
> >>> +	map_fd = bpf_map_create(BPF_MAP_TYPE_INSN_ARRAY, ".jumptables",
> >>> +				4, value_size, max_entries, NULL);
> >>> +	if (map_fd < 0)
> >>> +		return map_fd;
> >>> +
> >>> +	if (!obj->jumptables_data) {
> >>> +		pr_warn("map '.jumptables': ELF file is missing jump table data\n");
> >>> +		err = -EINVAL;
> >>> +		goto err_close;
> >>> +	}
> >>> +	if (sym_off + jt_size > obj->jumptables_data_sz) {
> >>> +		pr_warn("map '.jumptables': jumptables_data size is %zd, trying to access %d\n",
> >>> +			obj->jumptables_data_sz, sym_off + jt_size);
> >>> +		err = -EINVAL;
> >>> +		goto err_close;
> >>> +	}
> >>> +
> >>> +	subprog_idx = -1; /* main program */
> >>> +	if (relo->insn_idx < 0 || relo->insn_idx >= prog->insns_cnt) {
> >>> +		pr_warn("map '.jumptables': invalid instruction index %d\n", relo->insn_idx);
> >>> +		err = -EINVAL;
> >>> +		goto err_close;
> >>> +	}
> >>> +	if (prog->subprogs)
> >>> +		subprog_idx = find_subprog_idx(prog, relo->insn_idx);
> >>> +
> >>> +	jt = (__u64 *)(obj->jumptables_data + sym_off);
> >>> +	for (i = 0; i < max_entries; i++) {
> >>> +		/*
> >>> +		 * The offset should be made to be relative to the beginning of
> >>> +		 * the main function, not the subfunction.
> >>> +		 */
> >>> +		insn_off = jt[i]/sizeof(struct bpf_insn);
> >>> +		if (subprog_idx >= 0) {
> >>> +			insn_off -= prog->subprogs[subprog_idx].sec_insn_off;
> >>> +			insn_off += prog->subprogs[subprog_idx].sub_insn_off;
> >>> +		} else {
> >>> +			insn_off -= prog->sec_insn_off;
> >>> +		}
> >>> +
> >>> +		/*
> >>> +		 * LLVM-generated jump tables contain u64 records, however
> >>> +		 * should contain values that fit in u32.
> >>> +		 */
> >>> +		if (insn_off > UINT32_MAX) {
> >>> +			pr_warn("map '.jumptables': invalid jump table value 0x%llx at offset %d\n",
> >>> +				(long long)jt[i], sym_off + i);
> >>                                                       ^^^^^^^^^^^^
> >>
> >> Does this error message print the correct offset? Since jt is a pointer
> >> to __u64, the array access jt[i] is at byte offset "sym_off + i * 8",
> >> not "sym_off + i". All the other error messages in create_jt_map report
> >> byte offsets and sizes (sym_off, jt_size, sym_off + jt_size), so this
> >> one should probably be "sym_off + i * jt_entry_size" for consistency.
> > 
> > Is there a way to run this AI as part of any PR to
> > kernel-patches/bpf, not only those coming from the mailing list?
> > Maybe for a selected commit?
> 
> Hi Anton,
> 
> If you have access to an "agentic" AI coding tool that runs locally,
> such as Claude Code, you can use our prompts repository [1] with a
> trigger prompt like this:
> 
>   Current directory is the root of a Linux Kernel git repository.
>   Using the prompt `review/review-core.md` and the prompt directory
>   `review` do a code review of the top commit in the Linux repository.
> 
> The prompts expect the "agent" to be able to read and write files, and
> execute basic commands such as grep, find, awk and similar.
> 
> In principle it's possible to enable the review CI job for arbitrary
> pull requests, but the tokens are not free so we haven't considered
> that yet.
> 
> [1] https://github.com/masoncl/review-prompts

Nice, thanks!

> > 
> > Also, how deterministinc it is?  Will it generate different comments
> > for a given patch for different runs?
> 
> The short answer is no, the answers are not deterministic.
> 
> However for typical/obvious bugs you might often get a comment about
> the same issue worded differently.

Ok, makes sense

> > 
> >>> +			err = -EINVAL;
> >>> +			goto err_close;
> >>> +		}
> >>> +
> >>> +		val.orig_off = insn_off;
> >>> +		err = bpf_map_update_elem(map_fd, &i, &val, 0);
> >>> +		if (err)
> >>> +			goto err_close;
> >>> +	}
> >>> +
> >>> +	err = bpf_map_freeze(map_fd);
> >>> +	if (err)
> >>> +		goto err_close;
> >>> +
> >>> +	err = add_jt_map(obj, prog, sym_off, map_fd);
> >>> +	if (err)
> >>> +		goto err_close;
> >>> +
> >>> +	return map_fd;
> >>> +
> >>> +err_close:
> >>> +	close(map_fd);
> >>> +	return err;
> >>> +}
> >>
> >> [ ... ]
> >>
> >>
> >> ```
> >>
> >> ---
> >> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> >> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> >>
> >> In-Reply-To-Subject: `libbpf: support llvm-generated indirect jumps`
> >> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19018051915
> > 
> 

