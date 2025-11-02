Return-Path: <bpf+bounces-73272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96169C29721
	for <lists+bpf@lfdr.de>; Sun, 02 Nov 2025 22:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D551A188D39B
	for <lists+bpf@lfdr.de>; Sun,  2 Nov 2025 21:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D541DC198;
	Sun,  2 Nov 2025 21:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdKVjopU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F524F50F
	for <bpf@vger.kernel.org>; Sun,  2 Nov 2025 21:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762118997; cv=none; b=TWxHc6e1KREsS+zLgwgGQz8rBpM67QHomo4jmqoylIk8ybT/Z49zGlZ+tddiBuOeaBORVFtjy0E6rj4PiZVrkIkCDzz7sIcQT44+1L8lV7/vWayr1FFtljYOT1JI08EIWe0nJ4cw+2zmf5clMypJMkqria6yatXG8XTPBeWZQsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762118997; c=relaxed/simple;
	bh=ToA/qpvRXg/eWOC6mAwKuKEJnF8s4lOTDgJl0MVSbbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CB1y6FQm9QHwogggrl+JNt2Zj5BL5dinVcQk4tua8gVtVi5F8AjYPDLGkZ5JbJ79b5mjTC91bbGTo41UgcLuaVww5QWBskct8qLeDQoTKFEbGsIOW9T8Gn1FDVHs6LjfXDzdJrXGRUv5aBg1F+quMVo9Ycpc7LOaTP/+sYVKPRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdKVjopU; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b70406feed3so820518466b.3
        for <bpf@vger.kernel.org>; Sun, 02 Nov 2025 13:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762118994; x=1762723794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5x5Ba/ZRvGaploZJg/1SA8KpfziQRUydmbpGE1VAZxs=;
        b=fdKVjopUT3hWO+12F3tmjAzVndkmYTSJ4oifMUOPhcGHUH4Aq277mxAahp6Ud5w1eh
         /3i7U87z7s1pQaQzqmbfCRe80JCbDd9iCWEo63LBzDaWvuUHC7Jntj5Qj8YOAiw95DwD
         42TBC+Mz8WXS/Prfk1L2f9RWSa8GS4Crg6T3CINSYiBW1LNiI+5+Hu+acxe04kWYGuNE
         4LdliJnO2p9ysguCBVFmG3zdm9JbNsdgSsQDNZCDczQIOVZh5SLlw68XhjoDJhNZon9X
         eta2PEjKbTNyeoy5n/EtlU/B374DtodTfOKP2OJZpxTo6YNDqe04pOnEDY7w0dx98MAx
         qR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762118994; x=1762723794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5x5Ba/ZRvGaploZJg/1SA8KpfziQRUydmbpGE1VAZxs=;
        b=kbGI7EsoA2l4pcb+YtHVElQd5K2qUxlS1YFl7S/J7eDDXjhFxg+uLnZh5qD6oa7brY
         KI/Y6LOlzl5x8E1hdAOq94UM5T0JgIRQNf5ajUX+k4qxpb2gk7wHTRFeiBOtF4kSe2rd
         e4sChhNCbxazWa2hNYfENYk5SFhkxxJiIFq6znidSFjGifs9bSD2ZOTrzWgQgHxWb++b
         W1jHymqxiZ+9KiqBHO6IlChfc+1EE47eFOb9AwbGdPIYd9MMpRu44CBpTfV4sJkC6cg1
         lGc8P7fQ0a+LABS/JynX4xHTd0D+DqRnGuLG0A6447aCbFkvc8Cl51SWBQckdssi8KoJ
         K32w==
X-Gm-Message-State: AOJu0YxVNUnhUPXw6N0DSNzAmN22G8MDuVYE9Sg9+8flQvbuKx8q2ggp
	oUZeGCuCh5oM7KWT9QqfHtceTZGVRFdnzqkuJNMbZFOjSV64A6F97aci
X-Gm-Gg: ASbGncuECmjqC39d9Vucjez+QnbdqYUYWWjkUY9fDs7+xi88YefSXx9Ib+lMgPwD69m
	6g6yuKMaAnjs3HdDN68J39MjWhVzDm2t/o2lEz9PbrSpn8Hdb2z/rxkbXDQtNARzoXHHZTfP0R4
	uNVpsg1F7S0mYeMOra+wp9qbiP9UFaX5ejiztsdLyERqvM4LTut+0JBEnOjacEXokcTX20YVy29
	Kmax8+yc5xE2hkRZ4eg//96QL8NIG2ag1Lfz2hg/KnFlGon+vxfH146ZfSqw/Vi2kHtBKFJtbZT
	TFY7QItVsL/d802sIAEh95e8HEKpw+3fH7ed0iSxsoNC0PoTEylI79NG3gdg569EgFmXX33Lolz
	CFK/Phsq+gX2EA63jC1tp3zEgrmZXwhhJeNJ5PvbIUa0lsf3QA1FFI4yiJUaE05X2Md5CHpnixp
	OG7Jv6cdDOEA==
X-Google-Smtp-Source: AGHT+IF+BY6CVQ+rHSsF6mJZpcT0+REs21cNjwaNqHiTU+dl/VBl3S8oNyHrX5mdmpcbewJDvlRQRw==
X-Received: by 2002:a17:906:7313:b0:b70:f2c4:bdf7 with SMTP id a640c23a62f3a-b70f2c4c188mr87234866b.31.1762118993579;
        Sun, 02 Nov 2025 13:29:53 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077cda5e5sm848760966b.61.2025.11.02.13.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 13:29:53 -0800 (PST)
Date: Sun, 2 Nov 2025 21:36:14 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	aspsk@isovalent.com, daniel@iogearbox.net, eddyz87@gmail.com,
	qmo@kernel.org, yonghong.song@linux.dev, martin.lau@kernel.org,
	clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH v10 bpf-next 08/11] libbpf: support llvm-generated
 indirect jumps
Message-ID: <aQfOzrnGvewzFE2U@mail.gmail.com>
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

Yes, you're right. This can be fixed as a follow up or in a respin.

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


