Return-Path: <bpf+bounces-36930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E7294F6DF
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 20:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9967E1F21E49
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 18:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8266218A6CB;
	Mon, 12 Aug 2024 18:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b6tE210k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6962B9B7
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 18:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723488349; cv=none; b=hpquvMuUQxi1Qp9Jd/uXwUhuyRYiaEClP7QQbLsZyZbB526zONCUXDKzPkm+6MvzwJfy/7aRRwj/2jtELrVZZaRyYmXdEgN/yJM0ApTEQ9Cy/Jepn3YjpBPNu98mZUjwMKBpyXwG+5Bxxim11du9SN2U09fGGkIxqOEooIoar5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723488349; c=relaxed/simple;
	bh=M/C4JzZfCpraR492cAqV4PSdQFuO9UvF8X5yhHwIT7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eg9IqKJak8p4wMiiHgz1CMSWUVF63IPRsIh/qFD88GVhZ1KeTiWUg+gOZ5rPirpxQz6IcUwBK5XK2D6a2YThRmkEyvhREdPAq6rDF77jDA7dbWiutdA1iMAw4w2oVuz2z6bVlRQPSPP6To+craw21yFLKC+fxFmuoBgyoZ178Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b6tE210k; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ff67158052so29544745ad.0
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 11:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723488347; x=1724093147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XiLLVNhKxzufakuTnT1HixaXv07M6bXdLAyySx2HLEw=;
        b=b6tE210kWbLKfqrVVOPR40hT9U81Y51UZNXCniHU+pNR2mej8OYB/QT4hN+pQdlGEg
         aDj7P2E9Ir0UhKoqscGTbj9pW7MLvBKKvS54K1eIlNPRsiSxySSQmLtnzAt4W7PJewYQ
         6Gh7DHZ2EZPH5/XR+CaYP7eY3aSfq1t2CaFr4ZS4OVEPbhutgp4XjlYLyo+6yj2PEW2F
         2R4sjGIhUhpUDfKpR1b4ImILFjSdjfTDaMX9N9tPN9mzTWk166xPUlGlyH2R8+13LaKv
         oNhuaOh7xpByd9a5lFAbV6+/0EwJMBKVl5Rr3ZtDu/qj71QazQWLxVGEDnjCtErt7jN1
         pC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723488347; x=1724093147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XiLLVNhKxzufakuTnT1HixaXv07M6bXdLAyySx2HLEw=;
        b=w4Gv8ZAhVCFsbQP0GR1IshjTL2XaIuHlk7i6182YtCk9fkEcM4PFqlM00gl7p21QjL
         dE8K6GsoApprywAKSGpYsqWo1U18mMRZ/S8F0CnhwPaNphK7sTnA3gzpApt2I5GA0eIz
         En7yNltbWWLS3pgr4Xneh/3m3R0gBMGPKyupXVC1drWC2icirKex109DSR9+tsk+rfjV
         Ysf+nkybeJEBRl8CPlFgStJaQIYJEYYlYC184S8xSaox2kyTDijlIPlJb3ktw+Cqvr2s
         Ram+B+VCsKkonYuO6180ddcHcddzxEwUpTjZxyXVU/Ff/V+Nv0nz1SaLzr04UrWNld10
         AqRw==
X-Forwarded-Encrypted: i=1; AJvYcCXLuxE5GxFucvVJsPhJTfsaAUQztsuhcoYJrXVbt7W2RBFPZYSJFEnqxMMDJmuVnizlSsYue7lwATBkY55YqOrZxWQR
X-Gm-Message-State: AOJu0Yzj5owQesAFIoQTzNNcqM067qVvyVT+ifW6H8dIngDBvtTX2blV
	CQUOQD9+7xMvOALFV3eRMjahIwRH9HFFLGiAOL5LvbL/EpL3gIFvK13ua3FIPw==
X-Google-Smtp-Source: AGHT+IFhbCBz42sc9Pe9ZhZ49b2TtWnEzIVgikuPiH9asK3zzWawPidQbC9gNHq0QdelvJeQQv15aA==
X-Received: by 2002:a17:902:da83:b0:1fc:57b7:995c with SMTP id d9443c01a7336-201ca12b0a4mr13026295ad.7.1723488346432;
        Mon, 12 Aug 2024 11:45:46 -0700 (PDT)
Received: from google.com (99.34.197.35.bc.googleusercontent.com. [35.197.34.99])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1c4556sm88145ad.248.2024.08.12.11.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 11:45:45 -0700 (PDT)
Date: Mon, 12 Aug 2024 18:45:40 +0000
From: Neill Kapron <nkapron@google.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] libbpf: fix license for btf_relocate.c
Message-ID: <ZrpYVOaMvEo3UZwf@google.com>
References: <20240810093504.2111134-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240810093504.2111134-1-alan.maguire@oracle.com>

On Sat, Aug 10, 2024 at 10:35:04AM +0100, Alan Maguire wrote:
> License should be
> 
> // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> 
> ...as with other libbpf files.
> 
> Fixes: 19e00c897d50 ("libbpf: Split BTF relocation")
> Reported-by: Neill Kapron <nkapron@google.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf_relocate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/btf_relocate.c b/tools/lib/bpf/btf_relocate.c
> index 17f8b32f94a0..4f7399d85eab 100644
> --- a/tools/lib/bpf/btf_relocate.c
> +++ b/tools/lib/bpf/btf_relocate.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
>  /* Copyright (c) 2024, Oracle and/or its affiliates. */
>  
>  #ifndef _GNU_SOURCE
> -- 
> 2.43.5
>

Thanks Alan. Patch LGTM, but I'm not certain of the legal aspect of
relicencing, so will leave reviewed-by to others.

Neill

