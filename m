Return-Path: <bpf+bounces-47687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 163489FE095
	for <lists+bpf@lfdr.de>; Sun, 29 Dec 2024 22:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DB013A1953
	for <lists+bpf@lfdr.de>; Sun, 29 Dec 2024 21:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E171991B2;
	Sun, 29 Dec 2024 21:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btgG/WMK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0316025948E;
	Sun, 29 Dec 2024 21:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735508469; cv=none; b=JuWG9111VwU4SAbpBrYNqQA3D6EtB9Y+i5j2CMpzykmPzN4Jv2duuSMDnKNXSb8ATzLR+f8cHGBelVtHQMFjoVQi+5zYYQOKensbOKGdkLE5QLpyA0fTrGOelUsKqIn9kNMYnLOphKVHXjXeBxcL6Eq6c6eRLxcHE3eRFmM1eaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735508469; c=relaxed/simple;
	bh=D06FWVQ72Q1jUyL3uABU0YJOtTC+K2u+2B7QmPqawpw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6dXRAPdWGGWZa6Hx8Tcl0oCDkuhqpRKK/fUHvprPJpeYxgiXhWtwAUh8AZ+ORkwV4+GhSah0f0d1CBVBSWyVOVH0BJV2ychGqORch4xSd2pRFru3CGaIqEGSyTcTEBkmU+KxpHoRm4y5qo7SjhXlv/PvU0yzr0+cSgZsHP09Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btgG/WMK; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so501316966b.3;
        Sun, 29 Dec 2024 13:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735508466; x=1736113266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CjKoJkAXM2FYJgrfE1zb1w/AkI3HXqXAjVCH3YWCGO8=;
        b=btgG/WMKiJu1VNbBS3QmaVT8XaTBAHV/noZloma88naQDPde0233dKb+vpDLjWTTIh
         Ehpr4oXDuZlOUXQuHuRQDQx9QpXBn6JnJ9R7eM4N1c4/RIINRQ5IBiBHFGlNE4mX5LZE
         xna/hnJ/LcPEtxzozTJWca3ZjuKXLMHjlOblbjGQBRxvT1O946CfscXgHWVxtup3NhGk
         UH9CqNEkfo9XvSGtXzPTBDEe7moq8/KO2sVi/nd1g0DPSUm2VJyeR1z4ClFFt3WfR8Vw
         DCvGl0dJrr69XiXq0pRQVVVhrT2yiGIu1ao5/Fb6GO6R5fUDTu8NMAWHHXdTiQkemciQ
         JKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735508466; x=1736113266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjKoJkAXM2FYJgrfE1zb1w/AkI3HXqXAjVCH3YWCGO8=;
        b=LXrYN7xLwOPKGDx1GxTgN2oir28ucx0yRwsk5+Y94qhIlBQ1MC7AMD9HJIl6DD9drM
         QCL3E8cHwKysTGUpZR3QJcZhLWY8QyJM6XV7iOl7qDs3AWxJidnraoE+zl8h2x6imukn
         n38xqbuXKj4HxnYZMkcZChbmtcABVO6PMCqYmrzJPMZFmsuX8ZxnUtPq0VcFWJS8WvMu
         EavExuyLbG+ANKGaNxDLV5N8Zs85QcU6Gp/J2I8GS+Sheycv9YuVwOW2YzWuiLiJDmKp
         i9rF/dUoxWlFGnbWcngRlrkreeYJJi7s1zx6XWLN7u0/DanoOCRKsQdYejCDVjOZn1ma
         Y/ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPig3gp4E0i+JKltK2WW591uNmOhnR1flXaJCwhWkyrEWU35sHydCfgmUMKE6L2LKoU12Z8No9WU2apTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD+NQ6HM2+Gt8UwMaqmNc4x01uI/kz7r1Q+vO5zwtzskZsGXtA
	+HzywVAzeAd2+NgfccLiit8RT0th669XqZextuRufYoua08VVfgS
X-Gm-Gg: ASbGncuAydJbsrNsq9s+uYnAXHebomxTnRdmxnjJx4wyhjpjVWVRY7N2AHJeR5KWSsi
	CZ0ULpecntGvDI3GwEmMD2ZKkGCdK6WAy0ZhTZcuUkN3dSv+4Qp/EP4M9WvWD+DKuzCiKW9GaMg
	k2z8sfOvvKG+QQJUu+S9Fhfd83DWlWonTLQX9YyFOtDElB0Swe6dpkh40hWxzuo0AN9qjpFvYVC
	+7TGgmE8Gsw3b5AhAyffo/hXL6EUM8ekJKW4obI+SVST1seu7jvt4NnDh8XGOo=
X-Google-Smtp-Source: AGHT+IGKWDt89dzf4ZRj41FFxzHbEVakDZlSKfNiL/tqqfliDSb70qDQv2RDtOeQqzS+hceSVohExw==
X-Received: by 2002:a17:907:2d1f:b0:aa6:966d:3f93 with SMTP id a640c23a62f3a-aac2b0a5b51mr2789716966b.23.1735508466034;
        Sun, 29 Dec 2024 13:41:06 -0800 (PST)
Received: from krava (85-193-35-38.rib.o2.cz. [85.193.35.38])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e895d26sm1386364866b.79.2024.12.29.13.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2024 13:41:05 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 29 Dec 2024 22:40:58 +0100
To: Jiayuan Chen <mrpre@163.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, ast@kernel.org,
	edumazet@google.com, jakub@cloudflare.com, davem@davemloft.net,
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, song@kernel.org,
	john.fastabend@gmail.com, andrii@kernel.org, mhal@rbox.co,
	yonghong.song@linux.dev, daniel@iogearbox.net,
	xiyou.wangcong@gmail.com, horms@kernel.org, eddyz87@gmail.com,
	mykolal@fb.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, shuah@kernel.org, pulehui@huawei.com
Subject: Re: [PATCH bpf-next v2] selftests/bpf: avoid generating untracked
 files when running bpf selftests
Message-ID: <Z3HB6mUNW6beUkwz@krava>
References: <20241224075957.288018-1-mrpre@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241224075957.288018-1-mrpre@163.com>

On Tue, Dec 24, 2024 at 03:59:57PM +0800, Jiayuan Chen wrote:
> Currently, when we run the BPF selftests with the following command:
> 'make -C tools/testing/selftests TARGETS=bpf SKIP_TARGETS=""'
> 
> The command generates untracked files and directories with make version
> less than 4.4:
> '''
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
> 	tools/testing/selftests/bpfFEATURE-DUMP.selftests
> 	tools/testing/selftests/bpffeature/
> '''
> We lost slash after word "bpf".
> 
> The reason is slash appending code is as follow:
> '''
> OUTPUT := $(OUTPUT)/
> $(eval include ../../../build/Makefile.feature)
> OUTPUT := $(patsubst %/,%,$(OUTPUT))
> '''
> 
> This way of assigning values to OUTPUT will never be effective for the
> variable OUTPUT provided via the command argument [1] and bpf makefile
> is called from parent Makfile(tools/testing/selftests/Makefile) like:
> '''
> all:
>   ...
> 	$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET
> '''
> 
> According to GNU make, we can use override Directive to fix this issue [2].
> 
> [1]: https://www.gnu.org/software/make/manual/make.html#Overriding
> [2]: https://www.gnu.org/software/make/manual/make.html#Override-Directive
> Fixes: dc3a8804d790 ("selftests/bpf: Adapt OUTPUT appending logic to lower versions of Make")
> 
> Signed-off-by: Jiayuan Chen <mrpre@163.com>

lgtm, tested with make 4.3

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka


> 
> ---
> v1->v2: fix patchwork check fail.
> ---
> ---
>  tools/testing/selftests/bpf/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 9e870e519c30..eb4d21651aa7 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -202,9 +202,9 @@ ifeq ($(shell expr $(MAKE_VERSION) \>= 4.4), 1)
>  $(let OUTPUT,$(OUTPUT)/,\
>  	$(eval include ../../../build/Makefile.feature))
>  else
> -OUTPUT := $(OUTPUT)/
> +override OUTPUT := $(OUTPUT)/
>  $(eval include ../../../build/Makefile.feature)
> -OUTPUT := $(patsubst %/,%,$(OUTPUT))
> +override OUTPUT := $(patsubst %/,%,$(OUTPUT))
>  endif
>  endif
>  
> -- 
> 2.43.5
> 

