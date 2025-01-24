Return-Path: <bpf+bounces-49634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8398FA1AE36
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 02:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28AF33A2AFF
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 01:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE0D1CCEF8;
	Fri, 24 Jan 2025 01:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhNb/rST"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6037213AC1;
	Fri, 24 Jan 2025 01:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737682452; cv=none; b=j5tqrNRKRP9xl/bCCfrb0jJaPtXdmo02Q0q4Vci3W54zstbV2hHtbwYy0frea4I6alkanLKV+cRtdV+7LB8WssueC5CouGVqfi5kYj1/y57r35Gix4IThlPAiQXU27+APsOW9TxM3M6d2AvMtnb7kBdpZm1igeOpWuCvwU8U388=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737682452; c=relaxed/simple;
	bh=sejR6Z4MKrrCHrzrWdG5xzzarOxbt7DvKQJLsitMfPQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kTeE0Vmz2MUEy42YPTIPzf2//KUDooW/ACm+03TIDtQaIlyN3D3efpzeRdqZSU5E5/j9IXTR/jQpBwb9JkK6S1UTexMWHd9hvWPaH00/rgsRUES3TrGVPdFceIZ00GM4UPk+AO/T1lywuPN3FlEQyCL+7nov72IIf0Si3uzTq14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhNb/rST; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2164b662090so30586745ad.1;
        Thu, 23 Jan 2025 17:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737682449; x=1738287249; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ARHu4bMkYGtpw9cYv7QD45vIUC2+7L5VxMho3x6k2EQ=;
        b=YhNb/rST2ok45Sis8uc02gZIHggrgaqnyu0aoyNV3HD80ZaTM3QnQkU5v/vNo4MJe/
         8fTK+6C3bNucqR9zn6iIJeQLYtE8hXMxRovm593XYVdsnsPiMBOF6m5eMUF7i9B14VOb
         Q4J+Nrqmfbutk7ZpeW7aWXgeKFPQHNEu7kN39cylh8xXs2VQLybcCi+yGjQwjMZq4Ql2
         IT3Gu6jtEyd2v/FwVElo4TtSwX/LKReorCYx56SZtjjQkf3NL6QwhLiPcx+3oV+wL2Ct
         Lml6oIrfyJU2wdQk30mYXtkZcZFjbQPgMgZpcODPgydRUFwppVvBRtkJPMVQDXqsgk4Q
         VRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737682449; x=1738287249;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ARHu4bMkYGtpw9cYv7QD45vIUC2+7L5VxMho3x6k2EQ=;
        b=Y240edX5ZuTYttwNNUVC9vJ2G0OmDPgn3JqI/wgCPFKO9ImdSF0iXNDxgvmPMpPE9g
         L+ZIiJWbycmawaM3Nx44e/A39zjjZ8BrTByQ37PjxdgnsXk7ab9elAX0mfQr7HdkTHao
         ZoUZoUnajaF8kVvkN+Bf4OEN7e3pcBAna+SZjK6woKRIFTEMWt7SosyHoEg0Eo4YzJVp
         pO/of+UxkTuHhB+GSzT7VXVhC9dMUvELPFAG2GvchZOuuLyTLrCeMTBjND/TilD//WZv
         S/tLKrCyEpFUUypO7JkPe2Yx/805kTXmbfyVjNSZHT8cYmJR1XZ7ygpn/pN4Fy3V32Y8
         oUug==
X-Forwarded-Encrypted: i=1; AJvYcCXDNRSDoKc0VZWBHn/pFVvn4PBSU49WwdJYiOQi/5y0HKA0v4k9AU7xFZ7/G6byQXvuRrKO8E59cM/lQ5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/D03x/F5B8SUz6Kpt3JFN+KSMeMdufYQWxvBPqofjPfEqXmfY
	kOXI2nbzx+00lfMqsTp3RJCySfZdVgqznujh0ogA/e8d4+HGD1nU
X-Gm-Gg: ASbGnctoWcGR8hR/pZqCj0xBXjx25FW5Ag8aJcQIvfvbJ+fMGDCr0k/9t+v4cGODZZq
	S43R9oSkw33fcN+OatGuJcho/42/CgvbAT1hfZ9WDVFTLQaBDYdxXn/zafTxTFHOV5utfzx2sdC
	vntXs8Txt+tDEi3Fjsf4BIh5CbToAGd6L9Ae+vCMM1c3QqNEQRy4jLNcPKA5fpHIyjKccX6j5gv
	gAMJ8IuUlnQGBrTiyUCmkYywx29cJF4HQ/69wkTBg/Ypb8tYa83gUQCcfRKQ53DwDfQINEe0/vg
	Qg==
X-Google-Smtp-Source: AGHT+IGqeIJps6jXZkspI7e6Zi2SJKnC1wgmlAmCEB2RFyNqwi4l67qjvvir+Et6o8duJrj7v++pUw==
X-Received: by 2002:a17:903:1205:b0:215:7b06:90ca with SMTP id d9443c01a7336-21c3550c4eamr394957565ad.17.1737682449508;
        Thu, 23 Jan 2025 17:34:09 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ac49745c0b9sm512204a12.78.2025.01.23.17.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 17:34:09 -0800 (PST)
Message-ID: <8d286a6b2a5f481e1eb23466c199a1b05ec81a88.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] libbpf: Add libbpf_probe_bpf_kfunc API
From: Eduard Zingerman <eddyz87@gmail.com>
To: Tao Chen <chen.dylane@gmail.com>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 23 Jan 2025 17:34:04 -0800
In-Reply-To: <20250123170555.291896-2-chen.dylane@gmail.com>
References: <20250123170555.291896-1-chen.dylane@gmail.com>
	 <20250123170555.291896-2-chen.dylane@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-01-24 at 01:05 +0800, Tao Chen wrote:

[...]

> +int libbpf_probe_bpf_kfunc(enum bpf_prog_type prog_type, int kfunc_id,
> +			   __s16 off, const void *opts)
                                 ^^^
Nit:                      maybe name this btf_fd?

> +{

In v2 function looks identical to libbpf_probe_bpf_helper,
do we want to copy-paste it or introduce a utility:

  static int probe_insn(enum bpf_prog_type prog_type, struct bpf_insn insn,
                        const char **accepted_msgs)

And call it from both libbpf_probe_bpf_{helper,kfunc}?

> +	struct bpf_insn insns[] =3D {
> +		BPF_EXIT_INSN(),
> +		BPF_EXIT_INSN(),
> +	};
> +	const size_t insn_cnt =3D ARRAY_SIZE(insns);
> +	int err;
> +	char buf[4096];
> +
> +	if (opts)
> +		return libbpf_err(-EINVAL);
> +
> +	/* Same logic as probe_bpf_helper check */
> +	switch (prog_type) {
> +	case BPF_PROG_TYPE_TRACING:
> +	case BPF_PROG_TYPE_EXT:
> +	case BPF_PROG_TYPE_LSM:
> +	case BPF_PROG_TYPE_STRUCT_OPS:
> +		return -EOPNOTSUPP;
> +	default:
> +		break;
> +	}
> +
> +	insns[0].code =3D BPF_JMP | BPF_CALL;
> +	insns[0].src_reg =3D BPF_PSEUDO_KFUNC_CALL;
> +	insns[0].imm =3D kfunc_id;
> +	insns[0].off =3D off;
> +
> +	buf[0] =3D '\0';
> +	err =3D probe_prog_load(prog_type, insns, insn_cnt, buf, sizeof(buf));
> +	if (err < 0)
> +		return libbpf_err(err);
> +
> +	/* If BPF verifier recognizes BPF kfunc but it's not supported for
> +	 * given BPF program type, it will emit "calling kernel function
> +	 * bpf_cpumask_create is not allowed", if the kfunc id is invalid,
> +	 * it will emit "kernel btf_id 4294967295 is not a function"
> +	 */
> +	if (err =3D=3D 0 && (strstr(buf, "not allowed") || strstr(buf, "not a f=
unction")))
> +		return 0;
> +
> +	return 1; /* assume supported */
> +}
> +
>  int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_=
id helper_id,
>  			    const void *opts)
>  {



