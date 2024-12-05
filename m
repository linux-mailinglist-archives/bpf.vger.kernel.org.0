Return-Path: <bpf+bounces-46176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3E69E5EBA
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 20:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9763316BE9B
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 19:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBCA22D4E7;
	Thu,  5 Dec 2024 19:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCavIfJc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27B2224B0F;
	Thu,  5 Dec 2024 19:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733426688; cv=none; b=E6176EEotUks7rQ0VNs3D9WpvcAFW4+RP9RFKkOukjDvkb9o/ECXycG8digBypwnRfoXhk4I/LfefnDGIZOqLcZPc2NOf4pRr8ysQm4Ph50e/TMucChryqeQXEP6oGOKJNZPObeXxtMAQb1FZd+Vya/hyV5QzqvbIDZ9rdd6vFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733426688; c=relaxed/simple;
	bh=l+RkMx/mt1XUfqn55LLYS4opSUma14BDXGFBSwLsUBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwivJ/QK0glYAJOjr2yCF2Mic9z3DGW0kAR7kPV+y4X1jQPJzFQ1mdL/uuBZiWp4R6ianhfCiiBZxt7aFwGrTbEPCcxjkAixO3Wt0mJ4ZGu1pZzyjQZERkoP4YzKIv74rJUFfsJCZlEJEMMw/LW2cbLAF2D2H8qJ18v4mel+LNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCavIfJc; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7258ed68cedso1291474b3a.1;
        Thu, 05 Dec 2024 11:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733426685; x=1734031485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mRE/vWdS/sITcvJvFYmfWqYzfyCATymJHAuKTqgkqno=;
        b=LCavIfJca+fIq+GpC7K//992yhxVmnS8wYIq9sqY59zbpo5CC+NPXzFEG44UPk1uEB
         ZbwIpinAixqaF9w+ddZ1F2XahrkyrTZ9Rw2AiPp2xwVvKhkNKNWVWd4MBCYOQalnPZMG
         E3zP/R8aPAwu+XnuiAH9jSwwxW8BPMXTERIlAgfMHgD6cuMhljRZrm7yUpPZmrFO6w7J
         TuBQ5+ds2L2rFYK8xnI0aZMMmmNXWyY/+dLN2Xz/COx8jD49LxewJqIb9vtQIgPRbSce
         l3L++uIDaemKbd4wjWWLSH1N4oX9l4qMqyXYGmffyqllJYz6kFL+nt0fgiYyGPmVnT9j
         nadw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733426685; x=1734031485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRE/vWdS/sITcvJvFYmfWqYzfyCATymJHAuKTqgkqno=;
        b=EfB3Qp/OsLV4PFJnKIHU3JJ5pMGQHY4nxP9CyW+BCcwwX2yJK82V2OkpJTikFq0SL2
         nsPARfzAEVw7Y17EywVoYu8lBi+jph0KzJ0MBmfnnHDUBZ59s5bGYhATdT0TiO0Upkzm
         ODwmy0DeGpigZ3jc1WU/zlHv8IphL3buniau+8iysgh5+24J6mGNiY8b4Dh6K75RkWVj
         DVszeojK39UrN63axJn2isUhLnUyXbhVhrtaVx7wBP8CDkmfE//Mu4pEcnJROMF7SZmY
         yWRj3Q/KVTugvVpjjiU1kuvYXcpJ82+CTs8sp0/by8D2Ul2CzgDqmnuo2AGRqfkuh5Du
         mL+w==
X-Forwarded-Encrypted: i=1; AJvYcCVqJO4BpyCmvxwaEYxZhxft88OVqF21IOuc24WlIIlK+imWDc5LF26Gz/cBMW6XS9YWJ+k=@vger.kernel.org, AJvYcCWToTTAcf5OZ6HRW0Qt+TcnMarDDnzD4R+y9TTI43pw5T4R0/HbKAQ52BmTdS/pvikNxoW8ymGIBVmvAs4g@vger.kernel.org, AJvYcCXXwnyWArx6GksqawCLq4kDE7qOpwl5b74RzUYcbfJ8QozWnt/DbolxYjreqimmxxZMkCfnTSYUDqbcHI0A7FHiHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyddBcR9j1o8YMenhn7w0uIaPfEjl9+Q/FtPVZBNYTU6OhPfns4
	N1h+a6c4qNMBgqWavzXwNP5xqKKNwL++09gqfxhh/it05qAum+4=
X-Gm-Gg: ASbGnctN3DntD5HgbXIeVVshHtOu7AekcTSd3ot17GMaadKzP5BjsuspgVxxLCb852d
	32iA0FVkFECKMYe5PmiS+u8TjLoVs1D8l+7R04lxxPnX23QK3aDs7mXGAPUoMY8zHtoeQmI+iyw
	C5uEwEUeKpKFSI4tU9WxGPNclxmijyj6GiDBw5JBeswzyoHdzkm8DoC22QxBC2dqsb5scxN/H+k
	GJkeljCWNYOkfh5jKpTLVlqGE6MeDYrSPbicuy9vPFe9kQCFA==
X-Google-Smtp-Source: AGHT+IEzCAH8rLJ0RnV8vk4K1vZD/GPkH620EnuCRv2+8uXr1ofdsYqkiy80sCazZwd6Gwc+d/9pvw==
X-Received: by 2002:a05:6a00:189c:b0:725:8c57:5969 with SMTP id d2e1a72fcca58-725b8178a9emr589258b3a.19.1733426684801;
        Thu, 05 Dec 2024 11:24:44 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a29c5719sm1648755b3a.27.2024.12.05.11.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 11:24:44 -0800 (PST)
Date: Thu, 5 Dec 2024 11:24:43 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Leo Yan <leo.yan@arm.com>
Cc: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Nick Terrell <terrelln@fb.com>, bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpftool: Fix failure with static linkage
Message-ID: <Z1H9-9xrWM4FBbNI@mini-arch>
References: <20241204213059.2792453-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241204213059.2792453-1-leo.yan@arm.com>

On 12/04, Leo Yan wrote:
> When building perf with static linkage:
> 
>   make O=/build LDFLAGS="-static" -C tools/perf VF=1 DEBUG=1
>   ...
>   LINK    /build/util/bpf_skel/.tmp/bootstrap/bpftool
>   /usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/13/../../../x86_64-linux-gnu/libelf.a(elf_compress.o): in function `__libelf_compress':
>   (.text+0x113): undefined reference to `ZSTD_createCCtx'
>   /usr/bin/ld: (.text+0x2a9): undefined reference to `ZSTD_compressStream2'
>   /usr/bin/ld: (.text+0x2b4): undefined reference to `ZSTD_isError'
>   /usr/bin/ld: (.text+0x2db): undefined reference to `ZSTD_freeCCtx'
>   /usr/bin/ld: (.text+0x5a0): undefined reference to `ZSTD_compressStream2'
>   /usr/bin/ld: (.text+0x5ab): undefined reference to `ZSTD_isError'
>   /usr/bin/ld: (.text+0x6b9): undefined reference to `ZSTD_freeCCtx'
>   /usr/bin/ld: (.text+0x835): undefined reference to `ZSTD_freeCCtx'
>   /usr/bin/ld: (.text+0x86f): undefined reference to `ZSTD_freeCCtx'
>   /usr/bin/ld: (.text+0x91b): undefined reference to `ZSTD_freeCCtx'
>   /usr/bin/ld: (.text+0xa12): undefined reference to `ZSTD_freeCCtx'
>   /usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/13/../../../x86_64-linux-gnu/libelf.a(elf_compress.o): in function `__libelf_decompress':
>   (.text+0xbfc): undefined reference to `ZSTD_decompress'
>   /usr/bin/ld: (.text+0xc04): undefined reference to `ZSTD_isError'
>   /usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/13/../../../x86_64-linux-gnu/libelf.a(elf_compress.o): in function `__libelf_decompress_elf':
>   (.text+0xd45): undefined reference to `ZSTD_decompress'
>   /usr/bin/ld: (.text+0xd4d): undefined reference to `ZSTD_isError'
>   collect2: error: ld returned 1 exit status
> 
> Building bpftool with static linkage also fails with the same errors:
> 
>   make O=/build -C tools/bpf/bpftool/ V=1
> 
> To fix the issue, explicitly link libzstd.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/bpf/bpftool/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index a4263dfb5e03..65b2671941e0 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -130,8 +130,8 @@ include $(FEATURES_DUMP)
>  endif
>  endif
>  
> -LIBS = $(LIBBPF) -lelf -lz
> -LIBS_BOOTSTRAP = $(LIBBPF_BOOTSTRAP) -lelf -lz
> +LIBS = $(LIBBPF) -lelf -lz -lzstd
> +LIBS_BOOTSTRAP = $(LIBBPF_BOOTSTRAP) -lelf -lz -lzstd
>  ifeq ($(feature-libcap), 1)
>  CFLAGS += -DUSE_LIBCAP
>  LIBS += -lcap
> -- 
> 2.34.1
> 

I'm not sure we 'offically' support -static builds, but this seems to be
ok. Tangential: maybe time to switch to pkg-config for bpftool? IIRC,
there is some flag to query for static lib dependencies... Will leave
it up to Quentin.

