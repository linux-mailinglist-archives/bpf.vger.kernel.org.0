Return-Path: <bpf+bounces-72521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C38C9C14650
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 12:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35E5D5E704B
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 11:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA2530499B;
	Tue, 28 Oct 2025 11:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3e5aH2B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FC41D63EF
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 11:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761651357; cv=none; b=mpi1KD6gDT8zqS1RrEbNIcE+uisGEz7KORyQZdD7qJ/548eXyKXWfO6PrPiHwB4/wQ5WKDHpE/M+RcJnN+M7J19TF2aVCxvTWi2t0IR12DcOfFkdJ7e5CCww7CKUJ/J2m0hv6BhyUvbpQ3w626C1bQT38jEhTmLh1K2yKg2icec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761651357; c=relaxed/simple;
	bh=vlahLeRGzYV4iG2ay45RoZtL9g/Xgo0UJHNDArsrhhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVlrXRwqEHCIRr+J/xE+wO0ZYjwuAt7wvZbJ+w7B3bYZxVOLXk+t/Cm/O9uu7gCXxrAWjSikj13J03/WD89tyu3zBJV5ht+T1REeAKYwymlpfAEZW/4UP4ZCIXfM5z/U2TUxmswb/P9P0CnTHzudz4NJHjKfEXBBm88bDyZ0rAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3e5aH2B; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-475dae5d473so33925345e9.2
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 04:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761651354; x=1762256154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XK9+fJKosdQsDKP510vQadPkF9fV/6LidRTWjZtcVP4=;
        b=Y3e5aH2B340HD5oP2DTwDAGGX/QTfuSXSJAunBZis8Sysqzte5aq/kmCdhYxi+iTgY
         auv/tSaAiJJO3PvOcK6Phke6ik0eXNG7FIyUjo7mrDlLBDP+piftE0OrlgFMMOLGmKq/
         Uicdj8MCYSAauSzWVVeGWGtM3jlr8vbGRr04Y9S3mfBRpvw4lSlbrSGhfXgO/4fVeQIp
         orR1UYbAjAVq/+GDlUVUZtF5RTIJ22mLAu3leNHi36oxyhOumQX78ISKBDFNZ5NWIMTG
         zOHBKIOPCrP3WFx5tn2yNTm+Z8v9jFpLAcezYB/uyiLehXnH5AO04NYkMjRj+ZRVy0FJ
         JScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761651354; x=1762256154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XK9+fJKosdQsDKP510vQadPkF9fV/6LidRTWjZtcVP4=;
        b=G3u0rDcdT0A1RNk8bjqQuNFzRJKrnVXIX3PG4z8ltGJ+nRCsG/KNPzqqT6NrZD2KIl
         eWyRZWdzRsBI6k4dCp4dHticXEvKc5SXxaAh8R4o17KFWg5n1zBmG7BYehVcTsPCKxnV
         2yrWE4VHrkR1n8fuUK9EC0fYq8yAXmewltC0vUb0ZTVRIBa8xUkvpJwwx5IsqghT4YQW
         2se6jLNZbKQafLCx3Sz3FiqLoZm+VfRXt6CxAqHO4lxjtmfzYluxOj1QZAtYxngJmAL/
         tzBkm4e2zkb7odqo8aNAcA7hJjJFM+8o6Zvk00I7bS8hcw642VdJK2kh3H51FSN1RWEW
         /AxQ==
X-Gm-Message-State: AOJu0YwJrC3BL1DCnEuJQyyfIOrhyVLyym18jIifaP0sKDhJo8/ETN9Q
	z/J+e+WbRb7gilTiJUavqb+Nifj8BaBkLQScZvXj2ptlFh2X+UEXXwXwzkP8Jg==
X-Gm-Gg: ASbGncuBlpe1vxDccNrno5b6w9CJfy6SLrGPaZ20BOgVel0TacLhPjRZf+fjCoza9AZ
	s9XOOFMDjLBTE8rdg5WwofpjhKFEl1QiEKv1+XLLn1WBXSrTTN70xMySkH1NXaN9eO9necOTDSA
	6tn5j15MsUIEm8MUzvPQ+HC1khZD3zl8mB/ixEuGOM+RnRhV7TgndnlMA82vZdffbUbM2Re9SPd
	fS3GtEwKokufOnrVqNM0gGm4/1KX9/Fj4t1eLJn8DmwPdp1tmbdlRCAlaApGDQ2nOY15AJjkiG2
	HiZgWFlT0rusxKUS3j6rBpDBBJWSLBOQEcylYwsm1ds1GNN1HyWTJHd+Va/9bKfRlaKEgrpbnJc
	POP/zkb3cPlTjWwxpSUSZwB+Ug0cjLpY+HN9l5NmOLEIsCYyYwgEAklejwqnSKCiFyjUJHM+qD7
	RLQcy8z3HJtA==
X-Google-Smtp-Source: AGHT+IFzUwl7+OOVcpYfN2c62FGGKpDpbj6qGu5s5jrg6AGk2H5MTi+w0XfVEOYOcMS6HNo69sEGmg==
X-Received: by 2002:a05:600c:4691:b0:46e:4b79:551 with SMTP id 5b1f17b1804b1-47717e552bbmr25145655e9.31.1761651354348;
        Tue, 28 Oct 2025 04:35:54 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd4a5cc4sm188222225e9.11.2025.10.28.04.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 04:35:53 -0700 (PDT)
Date: Tue, 28 Oct 2025 11:42:29 +0000
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
Message-ID: <aQCsJZ6549YD9Wou@mail.gmail.com>
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
> 
> > > +
> > > +		/*
> > > +		 * LLVM-generated jump tables contain u64 records, however
> > > +		 * should contain values that fit in u32.
> > > +		 */
> > > +		if (insn_off > UINT32_MAX) {
> > > +			pr_warn("invalid jump table value %llx at offset %d\n",
>                                                           ^^^^
> Nit:                                              maybe add 0x prefix here?

Sure, added.

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

