Return-Path: <bpf+bounces-41270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B42F9955F2
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 19:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2694284077
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 17:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E5F20CCD6;
	Tue,  8 Oct 2024 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKpNHRan"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2653020C498;
	Tue,  8 Oct 2024 17:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728409603; cv=none; b=qxVvnDtgU+tT2zjEL7PAi7nZAZqpBO0/KXxnVslj0fptejo4adug4cKe0DaA0VSyjyW0VdGUUx56wda8L0X8UcGXKlGSGPUc3gJAFkAhdMY8SyqBJUrE+s2nuYgiGoXeeRmYNwbnC4B9nlrt4pxPLHiIzI4kp/VdKWjcfVsx2AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728409603; c=relaxed/simple;
	bh=rQZnie03/b9gdEd5Gq74dUYxP9gKwCouQfu3CjgboYw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TC9ZdEtSIoyK01d4vXMU3xrRe/Dn05kEkxbzj7WNncUnnVpqzfUtZpqSJn9WcD7spVtN6bCGVV+u6ykL/AAg9CSp6NhqmpuDTid5Bs9/gZlYnfZx1GSLLRkdDEPrDUdHqBdvnRkD9/BWTZhGpuwSyc1EQ5rSK9zu2rqIi3oWkxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKpNHRan; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cbb08a1a5so60653435e9.3;
        Tue, 08 Oct 2024 10:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728409600; x=1729014400; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TGG8Ds8LPBNkbRbBzsXxgFnSTN/KDEGFwouaBCcY+Iw=;
        b=OKpNHRan9BUQG5q44HWGrmIxbGNmzAVv5myJV6ycKPF6i5iCZrfAJ5LBIeJwITuYWI
         Xp/gqasiri8qt/ONHrfJYwZNGW7qJPZH/kfh37LKY6mXFXh8OXK0jm4NjDOgrWH8B678
         d3312bEC0vE95yHGi09kIJljwM6TYcIX+iiyZp7mahebADcfCZQe8OB/fc7w4w68wxv/
         PNl9fOQtQDQNaVXIVgS5E/rJW93S5O/kmQXO2dYKQTarAm3D3RAc+PbIYUUoNBiUpYzC
         EWOR8h0/UkXPeheS2wKA6AMNrsOuGfFzdqJc2sewaOq51QYp8Ufrxe1e51A0FFi7KJgU
         dV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728409600; x=1729014400;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TGG8Ds8LPBNkbRbBzsXxgFnSTN/KDEGFwouaBCcY+Iw=;
        b=dzyOMHgY3kLhNt7QzsRAafomQsvmbzabE7aFQwQkKJYqVTAoWeQ8bJmTV5n1ZCXosp
         LSGM63sKMi9/55lYcruu7cPkZ/ovh9vNuDlyaTag0fRTCEd31+VMPIm7p5O/pJcPno3m
         +ScAP0Arc/JK92/Oc7fiNpJ50smGrexyc3L4DIM3SlmSgQJcYyyKVNlsLZ5o+hXAsKuU
         IjZ25+2Wh5ruB7gpsfU4Jl7u6ZryNABFoKoHAmDeg548455HhkV0vnffWOtPJkxVfayj
         oXzO3MKMR4w+y3Ktd1DYS3Nl5Cg4Qiydcc+r5y5y4fynam9UjjmHR6YKwXyTsu9GB3Nf
         Q10Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVwuzxNke4U9it8S5l5xXPVk4mX61aClamK7tH1oDUz1dsvEOVWWucSSry46+wJXKDEWEq2L47@vger.kernel.org, AJvYcCV98ErrRPRnOsGvicPTcqDUfRu+h8ho24FK8TsVGrf1NW7kRAWK7BZvOjVMBRE7N6sbV3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyydsaJZO6tAyob5XnvJom1wEuLWOOCiewIexThRShNG6Vz+1KA
	Aoh2Au8QrMC6uc1IXr1d0Rvk0dc/MeC/owr1QRvby4HpYbTAdOdV
X-Google-Smtp-Source: AGHT+IGWrWJzN0FDS882xYx5hCUiJYblE7srfaPFaZdCbV8w0UjkSr864UMWjP82/COLPiVkbBDnGw==
X-Received: by 2002:a5d:694f:0:b0:37c:c4d3:b9ba with SMTP id ffacd0b85a97d-37d0e6f2575mr10092962f8f.12.1728409600257;
        Tue, 08 Oct 2024 10:46:40 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89e8a519sm115870025e9.14.2024.10.08.10.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 10:46:39 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 8 Oct 2024 19:46:37 +0200
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Simon Sundberg <simon.sundberg@kau.se>, bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH bpf 2/4] selftests/bpf: Consolidate kernel modules into
 common directory
Message-ID: <ZwVv_ZOvh2mTGAlK@krava>
References: <20241008-fix-kfunc-btf-caching-for-modules-v1-0-dfefd9aa4318@redhat.com>
 <20241008-fix-kfunc-btf-caching-for-modules-v1-2-dfefd9aa4318@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241008-fix-kfunc-btf-caching-for-modules-v1-2-dfefd9aa4318@redhat.com>

On Tue, Oct 08, 2024 at 12:35:17PM +0200, Toke Høiland-Jørgensen wrote:

SNIP

> diff --git a/tools/testing/selftests/bpf/bpf_testmod/.gitignore b/tools/testing/selftests/bpf/test_kmods/.gitignore
> similarity index 100%
> rename from tools/testing/selftests/bpf/bpf_testmod/.gitignore
> rename to tools/testing/selftests/bpf/test_kmods/.gitignore
> diff --git a/tools/testing/selftests/bpf/test_kmods/Makefile b/tools/testing/selftests/bpf/test_kmods/Makefile
> new file mode 100644
> index 0000000000000000000000000000000000000000..393f407f35baf7e2b657b5d7910a6ffdecb35910
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/test_kmods/Makefile
> @@ -0,0 +1,25 @@
> +TEST_KMOD_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
> +KDIR ?= $(abspath $(TEST_KMOD_DIR)/../../../../..)
> +
> +ifeq ($(V),1)
> +Q =
> +else
> +Q = @
> +endif
> +
> +MODULES = bpf_testmod.ko bpf_test_no_cfi.ko
> +
> +$(foreach m,$(MODULES),$(eval obj-m += $(m:.ko=.o)))
> +
> +CFLAGS_bpf_testmod.o = -I$(src)
> +
> +all: modules.built
> +
> +modules.built: *.[ch]

curious, the top Makefile already checks for test_kmods/*.[ch], do we need *.[ch] ?

jirka

> +	+$(Q)make -C $(KDIR) M=$(TEST_KMOD_DIR) modules
> +	touch modules.built
> +
> +clean:
> +	+$(Q)make -C $(KDIR) M=$(TEST_KMOD_DIR) clean
> +	rm -f modules.built
> +
> diff --git a/tools/testing/selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.c b/tools/testing/selftests/bpf/test_kmods/bpf_test_no_cfi.c
> similarity index 100%
> rename from tools/testing/selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.c
> rename to tools/testing/selftests/bpf/test_kmods/bpf_test_no_cfi.c
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h
> similarity index 100%
> rename from tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h
> rename to tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> similarity index 100%
> rename from tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> rename to tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
> similarity index 100%
> rename from tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
> rename to tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> similarity index 100%
> rename from tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
> rename to tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> 
> -- 
> 2.47.0
> 

