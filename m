Return-Path: <bpf+bounces-36463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D66AA948D99
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 13:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8109D1F23158
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 11:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286DC1C2335;
	Tue,  6 Aug 2024 11:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9hPHjbE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0D813B2AC;
	Tue,  6 Aug 2024 11:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722943460; cv=none; b=TqqRx1/BbyoY352exZwbEbidatRfFB0b+1Dxx2RhCNJymZs7B9bKUqm/j/RcY3HMrnjHMQgcpuUDi7wlO8fkHD5iSsJD7RkUuRdQg0chvYS4I8k0gnNF4X2d8JnpqtP95f6tprcfHHkv9HaUYeM7y1Swc2pcUOTL68w9l58rJHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722943460; c=relaxed/simple;
	bh=NLJFKlsrv5HZC+jpQ0fj6SQCwJrn1odW8ws5NvM5/FU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mD1ACyH5Ky8DVrHaxOsvW0BDhjE4l7mo48KeVzLnZ6O6B2ARJ3RvTcdxymwWgJxl5wM3VqBWjwifpbVBPa1nH4UE0UHeIGQrdSnX0syB6USnMNhaA739nfXiad6ny1qU/T6MoifsFmQm/6+fyJciNB9FkepoHCw3akcMMTpfvDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9hPHjbE; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso646087a12.3;
        Tue, 06 Aug 2024 04:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722943457; x=1723548257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GgG5bT+5Oy8mtqui+2A+oSAac16iD+OUBZ0++IA9yGw=;
        b=U9hPHjbE1GfcG44RKGwDiWhzo1Bzfb7oDsFWU1MyXLvTIp+fahFeH4xtWDY+CD+Xjn
         C3bhesCJ+kWOdWFBchdauNCb5d+WMEbSCbMUtg8qIHMbiYaJvX4tGn+l7F8qBIeo5dQq
         88fvKd+vI6KIDYgWZKoBPofvw5JMq2AQOEDnuMqLTeoEM1//JVCsMRFLBVBB2La3C54q
         TQrgg0P0fXoNWGUUIZcNmtQCl9N1l24mdfAUvgH9ZxzsuJUgqf8zDQv2iEg6X7I3/jSE
         YJg5nucj2UhRwVqgsLQvi2m7WdHs7PYlJa+5Htc1W6x8Jsa9e0UJ6TxQ8dMUqlhUPos5
         1/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722943457; x=1723548257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgG5bT+5Oy8mtqui+2A+oSAac16iD+OUBZ0++IA9yGw=;
        b=WAMIOhpWJQdhhOmYY2nZFDlHxB31xKE7GIlHIsG9oggmy10lOKVE5eWjSdj3sTzhTm
         sA9Uf2tL6/xksF4m1pMUjFhiV2oqcalWjGlZkIbeK+wt4d4e2GbGmLwAFDeBLi3CYfJt
         VRgDBzZD4uTUyGjwFVfxhbzHbnrLrJ6vCgBu8DMAGIRMlQyo2um4iE8NA58IuUkyzYuc
         loAmT9E0CuaNzPWNJoq/rPCHpA3XXrNiQIgCa+G/LKiI+QykIXVSzSmbIVyuLYt3HziM
         3illDDLmxDB6cjWf5BAnOQzEQ5ZzJkiHHyn0kbsXJnOAXyXThOS/4UtxTN7DHHGLAtBj
         qdQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeo6YJV/Qwz3nhbbG8nC+kOV5IkWyaXiYHyXGoUHfiw5Og3Aq+LHU4ptm8+7rXSFV5Av9QwLSWjS+I/DwZvjpCEXTzcs7DQHzCeC7ubZpGeOXlCPsxOoYcoukr6JBAnJLMKmRrZoM0tjItxyrLscsKS43/efdrY3MG
X-Gm-Message-State: AOJu0YwP6b7M72hz3XudV+O96iZMjPl4wEkDvk4RvfU67+txdWLrQPg5
	I/ltwvWyfXQs1vf0SiGOo8ERTPDR1EPm4NxbS6Q7j/SsOhjBrYZ+
X-Google-Smtp-Source: AGHT+IFgVDW4rgXOYxPYQc3gQW4V0fzzE6vvVdZBkhDqcoL+eee8Fr/uTFjVUjJF/eGwwBa2+EE23w==
X-Received: by 2002:a17:907:1c2a:b0:a7a:a138:dbd2 with SMTP id a640c23a62f3a-a7dc509f3bcmr933115666b.50.1722943457201;
        Tue, 06 Aug 2024 04:24:17 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ec8cd5sm536901166b.213.2024.08.06.04.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 04:24:12 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 6 Aug 2024 13:24:07 +0200
To: Ma Ke <make24@iscas.ac.cn>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	delyank@fb.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] libbpf: check the btf_type kind to prevent error
Message-ID: <ZrIH1_UYOYWkaawc@krava>
References: <20240806105142.2420140-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806105142.2420140-1-make24@iscas.ac.cn>

On Tue, Aug 06, 2024 at 06:51:42PM +0800, Ma Ke wrote:
> To prevent potential error return values, it is necessary to check the
> return value of btf__type_by_id. We can add a kind checking to fix the
> issue.
> 
> Cc: stable@vger.kernel.org
> Fixes: 430025e5dca5 ("libbpf: Add subskeleton scaffolding")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  tools/lib/bpf/libbpf.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index a3be6f8fac09..d1eb45d16054 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -13850,6 +13850,9 @@ int bpf_object__open_subskeleton(struct bpf_object_subskeleton *s)
>  		var = btf_var_secinfos(map_type);
>  		for (i = 0; i < len; i++, var++) {
>  			var_type = btf__type_by_id(btf, var->type);
> +			if (!var_type)
> +				return libbpf_err(-ENOENT);

hum btf__type_by_id sets errno to EINVAL in case of error

I think we should keep that or just pass errno like we do earlier in the function

  libbpf_err(-errno)

jirka

> +
>  			var_name = btf__name_by_offset(btf, var_type->name_off);
>  			if (strcmp(var_name, var_skel->name) == 0) {
>  				*var_skel->addr = map->mmaped + var->offset;
> -- 
> 2.25.1
> 

