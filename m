Return-Path: <bpf+bounces-70330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABFEBB7E4C
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 20:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50AFF19E66BF
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 18:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2432DA750;
	Fri,  3 Oct 2025 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6NeoKDp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046141F0991
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 18:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759516822; cv=none; b=XQ6uT38BDRhXCl4EzL7v5mHarXpOMJ4KexFitGNOdHL0OrV7R0EBog/kAOUPPS2//r1Irn4OGMhgkBCea+xBq2iYhW6AIQ4C83m+MKnXf48pa8i07EbbyQGkuL/ITK/ywdsvMKZDVqDFs5myaMiFRtvEKFldsSUT537JmsT8XWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759516822; c=relaxed/simple;
	bh=Woq853mvGAMO6CmEsURJF3tx+e9e31WCa8gexM5Tm14=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WqYNS+uoeELsq0Vfkys3Me2ZwuMqySJC++n2/prBiXUKuWnWH8knhwhkdWv8Bl4qfKioesBP1EeIebRM7UHGj/OSXarkWOjQOFfLoYdv8ukV7Eit4HOFCRZ9U5a+tva0TrFbFu8tUT9bIiYk/AYBy9tGhxvLq8lpvqAGNSU1+Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6NeoKDp; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7811a5ec5b6so2894486b3a.1
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 11:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759516820; x=1760121620; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q03YCDb11ma83spptLR/yIQFhTXTEgL/uv2nY2wRfSI=;
        b=Y6NeoKDpouQodgjlGs3Q2o68dkKyqQYmXVSz78dmccuRUs1kRkhUSjvoOoOEto2a90
         ZyGK9NIG2AZiuDvAV4lsIC5SYQZAcHDmch2j2gxuPpITmTsd4AWRQqDkARfOCxoLW2Dt
         31uQ5SGsNpwsmbtvxlojQX006KrFyu3FMuqhUsVRmJTqnaAnTmdOsuJLhSb1XgqoxykH
         k8jEVnrhLuRDL3AgK1QFAr3cB0Zwh6siLPkQgrIZCRPUd3kxmpiHvZ9IbmYUq6BVSwOY
         Gr/n3BAusRdcjZgqYTTdQ0EO+3sWyGT4kMlvIUjvvGXn8hbHrNNDAoaSKOszCl4Na8EV
         lgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759516820; x=1760121620;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q03YCDb11ma83spptLR/yIQFhTXTEgL/uv2nY2wRfSI=;
        b=CSpLs655vUJSylf4oaQqX/SuvvNPxAa7rgn1JSQEXory8NhU0J3h+Pz7E2moz4EYnM
         fvAJiyI6pd8CT+Nmg5mQY9sDs21PpxohAzNvR+W36xx1PyLXhC4deKPIA+mn2ybheQ1I
         fH90t5I38rwpsQGNEhSkquI/h7Bz97zaMpMi1CrlMRCf90ilnIHC7kpvvgaHrdV5C3r5
         f0FoIXJNZiamzWYPwjb3XnGxn3rokN9TTXMkMdD6rZ33AHeWgo8bOK9uQMqpAZSF64Bq
         3vnc/BK34JU7WCjYGXTrjPUqJgE0YJndp4DArZcfvqlz/hICAzWJxFx5SERiuGfVZnOQ
         QVdw==
X-Forwarded-Encrypted: i=1; AJvYcCVMIpTnk6pTbEMot2RDRHVaNVvAOE04UcO9PETUujwSevTum6dD7Rp3MMx/n8c2FVO0aDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN2zyTyzj6KtNC5A1pNtmzBe55gUI64PvXP+w1Ch9Dm26cm0yE
	60JV29Fz2spmZC0CUNjuuqgol2tiJNP05zC14mjtT9QhuL8GmEv3J6AI
X-Gm-Gg: ASbGncsPmjR3gk2HVfaZqBBD/unCp8pxZUfWsfipw15+LjCDoWQVNCe+NHH0unt2wJo
	swg1qrznA1/4j9epvCp564KsDk/MZ4ASenviXrZBLjUL2+DgUVMgR9AcUMOFOmKeYaNMIn+r8BL
	fKZo6rTgV40IsZZzCJemJPeLugBKxo8HPyjD6CXl/Bqkbjn0TU7V2eq+wvH63HifzXv86wsPzzN
	uk93qRPgMvg4CpB2lXviR0sv7oydYpDY9oNM3mMEbxVqx/94f+XfE/mHlFNYw64WKXTIVyFRkBC
	qDtY1AZjZZmo1XWN6DlifejbGSCaeXrylT97+emwgz2LkVUsz0ngUGmUMOXI4QY4eu/kKUkStig
	/hJ5SD1OV51Gs9vLnLFUA8gh/FattMjs34bXerh+KTh2ROgnUQ0p3Flx+K+SR/vgv9xC4qpap
X-Google-Smtp-Source: AGHT+IFPujm6mea2pKOdlFHvhx6ubnZr5TKhJm4/X2h6P+evPOm3QaW0bkTTqOzdT8rZycIjjH2nCw==
X-Received: by 2002:a17:90b:1c8e:b0:330:b9e8:32e3 with SMTP id 98e67ed59e1d1-339c221543cmr5102593a91.12.1759516820184;
        Fri, 03 Oct 2025 11:40:20 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2a3b:74c8:31da:d808? ([2620:10d:c090:500::4:e149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339c4a3255bsm2891520a91.16.2025.10.03.11.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 11:40:19 -0700 (PDT)
Message-ID: <10973dbe691484a3a77938db374f9056ce23513a.camel@gmail.com>
Subject: Re: [RFC PATCH v1 02/10] bpf: widen dynptr size/offset to 64 bit
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Fri, 03 Oct 2025 11:40:18 -0700
In-Reply-To: <20251003160416.585080-3-mykyta.yatsenko5@gmail.com>
References: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com>
	 <20251003160416.585080-3-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-03 at 17:04 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Dynptr currently caps size and offset at 24 bits, which isn=E2=80=99t suf=
ficient
> for file-backed use cases; even 32 bits can be limiting. Refactor dynptr
> helpers/kfuncs to use 64-bit size and offset, ensuring consistency
> across the APIs.
>=20
> This change does not affect internals of xdp, skb or other dynptrs,
> which continue to behave as before.
>=20
> The widening enables large-file access support via dynptr, implemented
> in the next patches.

Maybe add a note here that this change does not break binary
compatibility with BPF programs compiled for older kernels?

>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 8f23f5273bab..7cc4f2e05ed2 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3372,13 +3372,13 @@ typedef int (*copy_fn_t)(void *dst, const void *s=
rc, u32 size, struct task_struc
>   * direct calls into all the specific callback implementations
>   * (copy_user_data_sleepable, copy_user_data_nofault, and so on)
>   */
> -static __always_inline int __bpf_dynptr_copy_str(struct bpf_dynptr *dptr=
, u32 doff, u32 size,
> +static __always_inline int __bpf_dynptr_copy_str(struct bpf_dynptr *dptr=
, u64 doff, u64 size,
>  						 const void *unsafe_src,
>  						 copy_fn_t str_copy_fn,

The definition for copy_fn_t looks like:

  typedef int (*copy_fn_t)(void *dst, const void *src, u32 size, struct tas=
k_struct *tsk);

should we change it to use u64 as well? Probably does not matter.

>  						 struct task_struct *tsk)
>  {
>  	struct bpf_dynptr_kern *dst;
> -	u32 chunk_sz, off;
> +	u64 chunk_sz, off;
>  	void *dst_slice;
>  	int cnt, err;
>  	char buf[256];

[...]

