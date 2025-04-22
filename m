Return-Path: <bpf+bounces-56451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC11A9782E
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 23:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497D017D9DC
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 21:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5992D1903;
	Tue, 22 Apr 2025 21:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxHowYRD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C662561AC
	for <bpf@vger.kernel.org>; Tue, 22 Apr 2025 21:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745356060; cv=none; b=Cq7CyixR5uQ1a1M9SRMH356unT0Wh3uR9uiVN8JHnZv5FXeKWBCyCvMvoiwzamd9KOYeurswbWUnwLEhBq6zs9mJhxOhuOnUBuLdyY1MAfLLE2WIhBj6qQYvd0b67h0qWTJprupoZrpHfvm4zgBX0cBkeEcpZIsNl0uAeVFAf24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745356060; c=relaxed/simple;
	bh=pqsXvY0eh7CkRf3yb0G0gWK0C5FzNW6o8+EDSlOMmt8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tWUX1DjvdRCysBMwYVbrkXUQu9rKA0nARRxwFQtN6ZKF79VOI8SwyCKoT20a1nmemSz/+1BoSY+EAQb9LOLlwYcATQvk6pzqx/pNI6upt8pk+EM5QuBgC3othN+yo6yt/NSzMEmbuuQxbM2rt9TNmi/NLJ+Rw2lV1N4Fq1lgSks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxHowYRD; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-227b828de00so61338165ad.1
        for <bpf@vger.kernel.org>; Tue, 22 Apr 2025 14:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745356059; x=1745960859; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WcDRJMLtorDseBZQyKZr6qbrbCA88JFc/nC6g6ecPis=;
        b=TxHowYRDdIJiqQoRemnSLZXL17a2+JXqUIiT/sdQCCiOjgq7vSyfCBC+smZQKxPsOf
         YteKPAJEMRFQwPwjhT7+P6QYgBPwLZIIdQmFYLb9rB9P/sNsBvim/Y9AL/rhpbfHD/hD
         qsWy/gxgtURhQVNheAE+GSXUCrI4emlEWWXNZbpw2hL5J0Dwwbw4WHakm6H4Fe6KTfmd
         v8mbcJSgdTrQn0ehd5xfjmE9ygPSlsyky8H2w5i7AjEs45QN9+8asr8MRQ7M9QXR3QhW
         qqJiUxuROY+iMUuP+ZDKNeNZ3lj+Y65rtNWW0qHbmIkV6nYsKTUOgFcK026ftmUBX16d
         Ucnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745356059; x=1745960859;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WcDRJMLtorDseBZQyKZr6qbrbCA88JFc/nC6g6ecPis=;
        b=DLDFfM8DHBvcPp/p9CArmYraBuhjT0Tk68r+xMdU4P5k3vVTCnZXlqX9NEKwRO0CV8
         01UHPJDD20v7K8dWXBRe9kg9NtGRpedbJPVG+cApbWa16HrA+iBQJwEnFrwhIhU0oioN
         6MTre9QTHxNbsCs7xTUnLVcispvb1ILBhgsfXiypQbcm1NSqKAARh2npyyd7XuKM4aZR
         DV943p0bwVIItvwI/oXhPYdmK/cCTYi+UF8fakY8OFouOUJ/PsI5iIu0APhyOBlf87Xy
         BJLPk2PZwfHTu4+miHLBMv1Mas4DqMnYLCdEpgeVJAq/4Rk5S/ghuYA3z7MnvmzXstMs
         U65w==
X-Gm-Message-State: AOJu0Yy/zi5zet5Ulph1eG1rDSWrTOZWwTAGTkQvmN7DiQPBI/9L1Jd5
	e4k1y5/1L27iRY7gUEdctlR86DmBqFicVMCz5wi8bNcTs+mbamxV
X-Gm-Gg: ASbGncsrWBELGHGfJdoW3RsK59C9VfqrtHBKFuRkHAu3EWRB4vgxAoSYIuA2UA2Xv/5
	w+Ev0W+imsOwSavlYSgc8k/dpH6G0rXWVB2A/5Zg+Z5NIeKcYSc/MOGn4yjqCJG6I0WkE8xKqZy
	YPRGxPRr+CVaHMadJbgFs6e3K5qCo/w+TNDt5SXCs+45HHI+4UnG3AHbdWq+RcxiNHnrZjWlPZv
	IhxjpqDHTSIzSXpnPFq8NopmFrOG2pBSv/v0ABoA1nEG0qxuA7z33oK/fZJiOJUv05Ke394MSn4
	RM+R1M2kaZXePilKalTHCdITkxmw5mEIN4ioYsUSHmkg
X-Google-Smtp-Source: AGHT+IELzDm2El/8RKjKEC6mJ3V2Tdj73FWvH4hx3hC+Vqao+JsDH2rr/n9tQhQ+W/tK+Dq5lAfOqA==
X-Received: by 2002:a17:902:ef08:b0:216:393b:23d4 with SMTP id d9443c01a7336-22c5356713dmr265398095ad.11.1745356058619;
        Tue, 22 Apr 2025 14:07:38 -0700 (PDT)
Received: from ezingerman-mba ([2620:10d:c090:500::6:9822])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb4622sm90017845ad.108.2025.04.22.14.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 14:07:38 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  Martin KaFai Lau <martin.lau@kernel.org>,  Emil Tsalapatis
 <emil@etsalapatis.com>,  Barret Rhoden <brho@google.com>,  kkd@meta.com,
  kernel-team@meta.com
Subject: Re: [RFC PATCH bpf-next/net v1 08/13] bpf: Add dump_stack()
 analogue to print to BPF stderr
In-Reply-To: <20250414161443.1146103-9-memxor@gmail.com> (Kumar Kartikeya
	Dwivedi's message of "Mon, 14 Apr 2025 09:14:38 -0700")
References: <20250414161443.1146103-1-memxor@gmail.com>
	<20250414161443.1146103-9-memxor@gmail.com>
Date: Tue, 22 Apr 2025 14:07:35 -0700
Message-ID: <m2msc7rjl4.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> Introduce a kernel function which is the analogue of dump_stack()
> printing some useful information and the stack trace. This is not
> exposed to BPF programs yet, but can be made available in the future.
>
> When we have a PC for a BPF program in the stack trace, also
> additionally output the filename and line number to make the trace
> helpful. The rest of the trace can be passed into ./decode_stacktrace.sh
> to obtain the line numbers for kernel symbols.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Seems to work as advertised.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> +static int dump_stack_bpf_linfo(u64 ip, const char **filep)
> +{
> +	struct bpf_prog *prog = bpf_prog_ksym_find(ip);
> +	int idx = -1, insn_start, insn_end, len;
> +	struct bpf_line_info *linfo;
> +	void **jited_linfo;
> +	struct btf *btf;
> +
> +	btf = prog->aux->btf;
> +	linfo = prog->aux->linfo;
> +	jited_linfo = prog->aux->jited_linfo;
> +
> +	if (!btf || !linfo || !prog->aux->jited_linfo)
> +		return -1;
> +	len = prog->aux->func ? prog->aux->func[prog->aux->func_idx]->len : prog->len;
> +
> +	linfo = &prog->aux->linfo[prog->aux->linfo_idx];
> +	jited_linfo = &prog->aux->jited_linfo[prog->aux->linfo_idx];
> +
> +	insn_start = linfo[0].insn_off;
> +	insn_end = insn_start + len;
> +
> +	for (int i = 0; linfo[i].insn_off >= insn_start && linfo[i].insn_off < insn_end; i++) {
> +		if (jited_linfo[i] >= (void *)ip)
> +			break;
> +		idx = i;
> +	}
> +
> +	if (idx == -1)
> +		return -1;
> +
> +	*filep = btf_name_by_offset(btf, linfo[idx].file_name_off);
> +	*filep = strrchr(*filep, '/') ?: *filep;
> +	*filep += 1;

Nit: `+= 1` not needed if '/' was not found?

> +
> +	return BPF_LINE_INFO_LINE_NUM(linfo[idx].line_col);
> +}

[...]

