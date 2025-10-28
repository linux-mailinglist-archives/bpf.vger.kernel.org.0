Return-Path: <bpf+bounces-72519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FEAC145F4
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 12:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7867B1AA2F40
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 11:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6093C30BB88;
	Tue, 28 Oct 2025 11:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bl+PkCHh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A3630AD0A
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 11:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761650991; cv=none; b=mE0tvSQEXK8/gIQgaSD8IB2aDoxnWoLLxvpZE8VL9plA1StqaP0lxOjCWZWR9TSqzwDgz2E/ItitKxxEDrXnHQuP3nslUWfBR5cFUqZIUmMfMtZPZ/jovrUNWZW4PvrBv3aZw0iXGBZRjTmY5ovKwETzfftpbe8Ile0/Hyk2E6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761650991; c=relaxed/simple;
	bh=yW8g7Nz5mEz0pFXVGxkC5gGDPd7vI7fusbZ2qqMTwwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmCjDgam91yGFlehKqYVGfSeuWsBwVfMnVs9xa39k1Oui6qK99iKHnNssMmkWKzk7N/RowQHXycFEzCvWck+ULQ24GjN8CaNYK6pSpXxmgd4RBbmG59A2m+XckgGVRo0QUNfuaQfr8ObEqkPdk/Gf/E8E7aImaeYepLpMq3xPYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bl+PkCHh; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4285169c005so2700338f8f.0
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 04:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761650987; x=1762255787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YjCgLDxLk72QdxTNsmTRBmor2rVOHL35E2u7lpIiizw=;
        b=Bl+PkCHhg04NI5cLYed5MaEVBvZLFcANusjMa7+XES3LZrPWggeqC6s4iXnqE9CF0E
         R7HMML/+n8JvdiyBoG3ltOWUKbb4olyVDpWFh64dFwaqOSsOqnwZsGlbMBqPGZDBokMW
         f7GeEgxy1e+H0l2P+hDqM27Liqzk04aTfuT3Aq4RuYggPS3A+5jcCLM/dzibiVsL0NKh
         kbgEUA9mKI4ajkIYHullML+JCywRkDDT+RzT7WACLQQjKFPSpr0TjIdNiq9cGMLc3Ht3
         NPgPfes0QaH3oMVcpZtjtHaWS9U6cOCEzgHx0TO6yCDFedT5LvWnIW5zbZzwyjaeOMpF
         jihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761650987; x=1762255787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjCgLDxLk72QdxTNsmTRBmor2rVOHL35E2u7lpIiizw=;
        b=DRzRTtNnizUt+d5nf3l4U8XB8IYC9wHJtu2jOpKqTzYLlJm0WtPmBEymFPC8I9SFOX
         K6Yn4/JwnPQJHfGlgsnIOpgg6MvnUM1lrsEiEeMWHp9kRIord0SKtBMKAVB/4YNlZd2x
         WHsaB8HC1U6QpN/fED2Msg/iGmHk8UMbbmsAr43yYc0ZZomkz4suEdZAWC8zXMSSMnhV
         77IjF9BYxHUvJ4SwIOTVrfkEIVJYymiyGPGMRquBIwUrvHTxLZw1LXg2fm/N46zjAxnC
         QJk/4uMznERmuoIwWigekzfjkrPJ1SQ+xRnlnAMX2RjbrvsLNufuTJ0Rq3MsR7SDgQrg
         FfSg==
X-Gm-Message-State: AOJu0YzuwG07+ncLTnpykZupv16LHQohhV63SPUl4SYF0Cq0AkNYM0/9
	VTC2rr3zbhvbh03Z6g8FlKQWWZNSX5aRRSCYSflVjQ5aK/9Shxea++MY
X-Gm-Gg: ASbGncv9m+LpoOQ192aUm6erEdwCgY2FRr4wm72n71Jj0afZSu5OpJcsTRJ96i8VLxx
	ziq7XDUcRVxFdlnsfnkJHdgrOCHgJZ0y+e7XFOFRJNg7lAI0qPlhmkfUWr2briSTQsEQ5KxDSlc
	QOifyGiPEZBg/jIfb97uTsMXUW1ZxIIZJ5aO+rPZJ1OWL9arhnj0H1vHehPllMKvHb/67bTKj5C
	8sR+/X8DWyxPueWKOT3IU4wnBFKZcZJilTTtT2ATC2cnXe0nqlSgg8z95HY1dlwbAdTxM2QllY1
	wL6+lwHJxvQbxqem6nMw54NcsEQjJqJkEC7rqGF2jW3Gk3miIBiHUgzyAb38Z9ANO3rP28i9OLH
	bfIyzrmvFG/q97Cih3spRvPmjQr5anzmmyF9g0BNQZXr0gvSBvStXuFvbmGT2TRowHJ7yemsD6h
	YoB0MFmenKyw==
X-Google-Smtp-Source: AGHT+IE5qq891CxveQGBhHUICR+3eb9kcVrHrIk0YPelQtP3jGpg4pfaRa5eOtHmYzGbbU321v2SjQ==
X-Received: by 2002:a05:6000:144e:b0:3ee:154e:4f9 with SMTP id ffacd0b85a97d-429a7e569c1mr2624429f8f.20.1761650987153;
        Tue, 28 Oct 2025 04:29:47 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952da12dsm20186971f8f.29.2025.10.28.04.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 04:29:46 -0700 (PDT)
Date: Tue, 28 Oct 2025 11:36:22 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v7 bpf-next 09/12] libbpf: support llvm-generated
 indirect jumps
Message-ID: <aQCqtmlebrAngJTf@mail.gmail.com>
References: <20251026192709.1964787-1-a.s.protopopov@gmail.com>
 <20251026192709.1964787-10-a.s.protopopov@gmail.com>
 <dd184cdb0593392c6ad6c19111bfa17ac56bcb1f.camel@gmail.com>
 <b6f1be926ea382a9d4d30bdb8d09fa6b06d00165.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6f1be926ea382a9d4d30bdb8d09fa6b06d00165.camel@gmail.com>

On 25/10/27 03:59PM, Eduard Zingerman wrote:
> On Mon, 2025-10-27 at 15:38 -0700, Eduard Zingerman wrote:
> > [...]
> >
> > > +static int create_jt_map(struct bpf_object *obj, struct bpf_program *prog, struct reloc_desc *relo)
> > > +{
> > > +	const __u32 jt_entry_size = 8;
> > > +	int sym_off = relo->sym_off;
> > > +	int jt_size = relo->sym_size;
> > > +	__u32 max_entries = jt_size / jt_entry_size;
> > > +	__u32 value_size = sizeof(struct bpf_insn_array_value);
> > > +	struct bpf_insn_array_value val = {};
> > > +	int subprog_idx;
> > > +	int map_fd, err;
> > > +	__u64 insn_off;
> > > +	__u64 *jt;
> > > +	__u32 i;
> > > +
> > > +	map_fd = find_jt_map(obj, prog, sym_off);
> > > +	if (map_fd >= 0)
> > > +		return map_fd;
> > > +
> > > +	if (sym_off % jt_entry_size) {
> > > +		pr_warn("jumptable start %d should be multiple of %u\n",
> > > +			sym_off, jt_entry_size);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	if (jt_size % jt_entry_size) {
> > > +		pr_warn("jumptable size %d should be multiple of %u\n",
> > > +			jt_size, jt_entry_size);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	map_fd = bpf_map_create(BPF_MAP_TYPE_INSN_ARRAY, ".jumptables",
> > > +				4, value_size, max_entries, NULL);
> > > +	if (map_fd < 0)
> > > +		return map_fd;
> > > +
> > > +	if (!obj->jumptables_data) {
> > > +		pr_warn("map '.jumptables': ELF file is missing jump table data\n");
> > > +		err = -EINVAL;
> > > +		goto err_close;
> > > +	}
> > > +	if (sym_off + jt_size > obj->jumptables_data_sz) {
> > > +		pr_warn("jumptables_data size is %zd, trying to access %d\n",
> > > +			obj->jumptables_data_sz, sym_off + jt_size);
> > > +		err = -EINVAL;
> > > +		goto err_close;
> > > +	}
> > > +
> > > +	jt = (__u64 *)(obj->jumptables_data + sym_off);
> > > +	for (i = 0; i < max_entries; i++) {
> > > +		/*
> > > +		 * The offset should be made to be relative to the beginning of
> > > +		 * the main function, not the subfunction.
> > > +		 */
> > > +		insn_off = jt[i]/sizeof(struct bpf_insn);
> > > +		if (!prog->subprogs) {
> > > +			insn_off -= prog->sec_insn_off;
> > > +		} else {
> > > +			subprog_idx = find_subprog_idx(prog, relo->insn_idx);
> >
> > Nit: find_subprog_idx(prog, relo->insn_idx) can be moved outside of the loop, I think.
> >
> > > +			if (subprog_idx < 0) {
> > > +				pr_warn("invalid jump insn idx[%d]: %d, no subprog found\n",
> > > +					i, relo->insn_idx);
> > > +				err = -EINVAL;
> > > +			}
> > > +			insn_off -= prog->subprogs[subprog_idx].sec_insn_off;
> > > +			insn_off += prog->subprogs[subprog_idx].sub_insn_off;
> > > +		}
> 
> I think I found a bug, related to this code path.
> Consider the following test case:
> 
> 	SEC("socket")
> 	__naked void foo(void)
> 	{
> 	        asm volatile ("                                         \
> 	        .pushsection .jumptables,\"\",@progbits;                \
> 	jt0_%=:                                                         \
> 	        .quad ret0_%=;                                          \
> 	        .quad ret1_%=;                                          \
> 	        .size jt0_%=, 16;                                       \
> 	        .global jt0_%=;                                         \
> 	        .popsection;                                            \
> 	                                                                \
> 	        r0 = jt0_%= ll;                                         \
> 	        r0 += 8;                                                \
> 	        r0 = *(u64 *)(r0 + 0);                                  \
> 	        .8byte %[gotox_r0];                                     \
> 	        ret0_%=:                                                \
> 	        r0 = 0;                                                 \
> 	        exit;                                                   \
> 	        ret1_%=:                                                \
> 	        r0 = 1;                                                 \
> 	        call bar;                                               \
> 	        exit;                                                   \
> 	"       :                                                       \
> 	        : __imm_insn(gotox_r0, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_0, 0, 0 , 0))
> 	        : __clobber_all);
> 	}
> 	
> 	__used
> 	static int bar(void)
> 	{
> 	        return 0;
> 	}
> 
> Note a call instruction referring bar().  It triggers the code path
> above (we need a test case with subprograms in verifier_gotox).
> The test case fails to load with the following error:
> 
>   libbpf: invalid jump insn idx[0]: 0, no subprog found
>   libbpf: prog 'foo': relo #0: can't create jump table: sym_off 368
>   libbpf: prog 'foo': failed to relocate data references: -EINVAL
> 
> If I remove the `call bar;`, test case loads and passes.

Yes, looks like this was introduced with that latest refactor: just checked
that the main program in libbpf is not a subprog[0] (as in verifier). Will
re-re-factor as follows:

        subprog_idx = -1; /* main program */
        if (relo->insn_idx < 0 || relo->insn_idx >= prog->insns_cnt) {
                pr_warn("invalid instruction index %d\n", relo->insn_idx);
                err = -EINVAL;
                goto err_close;
        }
        if (prog->subprogs)
                subprog_idx = find_subprog_idx(prog, relo->insn_idx);

        jt = (__u64 *)(obj->jumptables_data + sym_off);
        for (i = 0; i < max_entries; i++) {
                /*
                 * The offset should be made to be relative to the beginning of
                 * the main function, not the subfunction.
                 */
                insn_off = jt[i]/sizeof(struct bpf_insn);
                if (subprog_idx >= 0) {
                        insn_off -= prog->subprogs[subprog_idx].sec_insn_off;
                        insn_off += prog->subprogs[subprog_idx].sub_insn_off;
                } else {
                        insn_off -= prog->sec_insn_off;
                }

> > > +
> > > +		/*
> > > +		 * LLVM-generated jump tables contain u64 records, however
> > > +		 * should contain values that fit in u32.
> > > +		 */
> > > +		if (insn_off > UINT32_MAX) {
> > > +			pr_warn("invalid jump table value %llx at offset %d\n",
>                                                           ^^^^
> Nit:                                              maybe add 0x prefix here?
> 
> > > +				jt[i], sym_off + i);
> > > +			err = -EINVAL;
> > > +			goto err_close;
> > > +		}
> > > +
> > > +		val.orig_off = insn_off;
> > > +		err = bpf_map_update_elem(map_fd, &i, &val, 0);
> > > +		if (err)
> > > +			goto err_close;
> > > +	}
> >
> > [...]

