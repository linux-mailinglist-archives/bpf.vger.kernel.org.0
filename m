Return-Path: <bpf+bounces-35633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C12F493C169
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 14:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D7F2B22919
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 12:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782301991D6;
	Thu, 25 Jul 2024 12:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWmYS96G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF0B22089
	for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721909048; cv=none; b=f0+MG1hTGeunkzGoCviAv97Ng3RZMfbvUzrbP2VDNkAUxnr4SzHutlNWUvGpmUfEX+K2bkXjRTxaFM+IpCzkhu0ryVBVx+dTqwOplEIk0aPRV0oKv9VACyJtfkqKF9457dMyeLXlqKSuNCnrQRj9M9KUVCnxHPILvmBiqSVAA4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721909048; c=relaxed/simple;
	bh=+2AEyuhFqqhyUVWdnWnQ2FoGAH3hSmgJKKw9AIgZsC0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6mA76wTXCop8Y8XJWzK8m6Mnk5591dOkV/5LlKPUTivqZAsUk1F0wuGpLTnv40gPmn3x8fDokYf0/fwU21itIsx7lq6yPgG/x/nO2swk4na5TqYkTBtgRTKm2apcq+LMXUH89whJzX7M9/UQe0OA0++Zprsf+/2YDB1AJVSH0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWmYS96G; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42802de6f59so5959215e9.3
        for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 05:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721909045; x=1722513845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ItT9vvz1AiBsJ5TlkftiW0p8e5pTQ5kho3YRaHTmhk=;
        b=iWmYS96GXGs89NF7RxVlwr4iMrFjpLqxj1zPWNt72okB0b8rXR3bPUMV7hmSZJstrK
         par+13L9eqpk+yjkvCXurhLvVPkVNRA/OHtncHSy6CudhebuBhJzZOOe8zNNHcaMMx71
         CEAzJmvOS2Ny6LqZWSg9nZ8BbHUF5GX+TalQ7IwWvKKBTTVb6js4/AvvuNeuZ53AmJ9C
         +zgcLVdi7qDn3G6GSTwMYlhPndWLSOd7uIZS4+JCTlAUze5/zo82WVI6KcfNODj/ITrU
         7oM30Ire1YET+VAA3IcJTWUBxztLJ7wxV0z9115ryRvpDKLjr91Lws+ZZi4DZBPW+VUa
         IsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721909045; x=1722513845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ItT9vvz1AiBsJ5TlkftiW0p8e5pTQ5kho3YRaHTmhk=;
        b=OrNjOWbcQnelyWD5Qt8yxRPHbWDl0PjAbi65NBIPWb9n/1ch2EHqtZpTtjecQUBfPb
         OAI+OyAN+7blzq5pcy+7cD37IjYl4gMDvPzB4ZztgRkaO8pbqVm/ualIeP1ElkxjL6Bo
         Xt7TKe2pA0fxbt+THd03xMYiT/85JfU+cRpasz34oBe7O5M0UY+NP3MJuHE/dNWp5/AI
         CIHONHgtkC2O9ld7fQa5W8cirx6mE7j5R9kBQGvh0sjCnJup6nMsoxUHxSHLwtwwRtJA
         A1V7RnjVKydpAVcPWdDdXUG5Q+nJIw7KiLybA+ZJKU4cRSWlEGwIfOZIJ+vKA0VzSiMJ
         Dnkw==
X-Gm-Message-State: AOJu0YyA3rhGGjXAojlLAT5zIRcUQ7wyD5UIQvtD3GMT7x5xxUGQk5jZ
	MzVrwBkSm04dcfRjH8/Grjgc1RIK0UubO4ofdv/nI2lw+mV3tcvf
X-Google-Smtp-Source: AGHT+IFcOQCMEQUr6tdOgh0fd5ufuTc5zBVwwbA4ajz51pyLNix1qjPvZoh/3yTEZ1i30+cxt4eksA==
X-Received: by 2002:a05:600c:154f:b0:426:8ee5:5d24 with SMTP id 5b1f17b1804b1-42805711f73mr15861685e9.20.1721909044846;
        Thu, 25 Jul 2024 05:04:04 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42805730e52sm31290565e9.4.2024.07.25.05.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 05:04:04 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 25 Jul 2024 14:04:02 +0200
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
	adobriyan@gmail.com, shakeel.butt@linux.dev, hannes@cmpxchg.org,
	ak@linux.intel.com, osandov@osandov.com, song@kernel.org
Subject: Re: [PATCH v2 bpf-next 10/10] selftests/bpf: add build ID tests
Message-ID: <ZqI_MgOo6Y5mWv0O@krava>
References: <20240724225210.545423-1-andrii@kernel.org>
 <20240724225210.545423-11-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724225210.545423-11-andrii@kernel.org>

On Wed, Jul 24, 2024 at 03:52:10PM -0700, Andrii Nakryiko wrote:

SNIP

> +extern char build_id_start[];
> +extern char build_id_end[];
> +
> +int __attribute__((weak)) trigger_uprobe(bool build_id_resident)
> +{
> +	int page_sz = sysconf(_SC_PAGESIZE);
> +	void *addr;
> +
> +	/* page-align build ID start */
> +	addr = (void *)((uintptr_t)&build_id_start & ~(page_sz - 1));
> +
> +	/* to guarantee MADV_PAGEOUT work reliably, we need to ensure that
> +	 * memory range is mapped into current process, so we unconditionally
> +	 * do MADV_POPULATE_READ, and then MADV_PAGEOUT, if necessary
> +	 */
> +	madvise(addr, page_sz, MADV_POPULATE_READ);
> +	if (!build_id_resident)
> +		madvise(addr, page_sz, MADV_PAGEOUT);

could this fail? should we at least print the error,
might be tricky to display that becase it's called through system() ?

jirka

> +
> +	(void)uprobe();
> +
> +	return 0;
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	if (argc != 2)
> @@ -84,6 +121,10 @@ int main(int argc, char **argv)
>  		return bench();
>  	if (!strcmp("usdt", argv[1]))
>  		return usdt();
> +	if (!strcmp("uprobe-paged-out", argv[1]))
> +		return trigger_uprobe(false /* page-out build ID */);
> +	if (!strcmp("uprobe-paged-in", argv[1]))
> +		return trigger_uprobe(true /* page-in build ID */);
>  
>  error:
>  	fprintf(stderr, "usage: %s <bench|usdt>\n", argv[0]);
> diff --git a/tools/testing/selftests/bpf/uprobe_multi.ld b/tools/testing/selftests/bpf/uprobe_multi.ld
> new file mode 100644
> index 000000000000..a2e94828bc8c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/uprobe_multi.ld
> @@ -0,0 +1,11 @@
> +SECTIONS
> +{
> +	. = ALIGN(4096);
> +	.note.gnu.build-id : { *(.note.gnu.build-id) }
> +	. = ALIGN(4096);
> +}
> +INSERT AFTER .text;
> +
> +build_id_start = ADDR(.note.gnu.build-id);
> +build_id_end = ADDR(.note.gnu.build-id) + SIZEOF(.note.gnu.build-id);
> +
> -- 
> 2.43.0
> 
> 

