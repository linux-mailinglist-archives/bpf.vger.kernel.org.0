Return-Path: <bpf+bounces-13249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D770C7D6D9D
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 15:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6608DB2119E
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 13:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D66128DAE;
	Wed, 25 Oct 2023 13:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QD32+QiB"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146BA27EF3
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 13:49:47 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0204E133
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 06:49:43 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5401bab7525so6997291a12.2
        for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 06:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698241781; x=1698846581; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EHoUAsqfrYubL+RZW9jVu2or01d75OpQpOW5wkod1pY=;
        b=QD32+QiBxUIp+24ee2/6clSfgZVslNeVgHZKjijfpqRM4tsrPz39xuRi6mdtfWgt2D
         Ws6TzGwLdciIiHq/NTBinO04BgRkOnRjGTEz6m6CJmC3ZhcW+4UtoxV3FAjvxuWsIXju
         LU/0C7/Eraj7IOEgd1SVxD2FmEzMNVyefNqXxO6iRJqUnM3HgKqXYVtMsQRGVRaKZ1Gi
         3YlZF07P6RelU7aDX2gRjFtsLEsl5HFMKvAwE2T5M0bPYZSD6gMgKhp1lWx23WQGd9WW
         OOsE0J9KdfQQkinR1U5BQLe9LZQmysy1waBiwzF2YcbF9JJqVNAxs89ymjTIgs8QXRsl
         221Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698241781; x=1698846581;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EHoUAsqfrYubL+RZW9jVu2or01d75OpQpOW5wkod1pY=;
        b=QDQ5uEbRcQ9CYNBW5vg3/XKTHX4Dio3s7jTkDFdttuG5WVV8gse9co1hGuVE3/7ErC
         AbK7Y9ZzQxtRHGE1/nhDEFJIngwPEFGkDchM/yGhENHoy2H6jqp4q3/I2yYorKYJTazS
         yfd1jcpr+vCGmI7uIS5SHustbq2Ipb5yRtQcOy0GIa+aHahKNS1B7eyVc2tCpWtGIrQM
         MnEvmYiAx6OBXnN0/B3aCVdOJGh7AiD08Iqq2yBgRxx6BiEqJNr7iyz9wP5klFPnx893
         L6W1g1o1rUeH4nKmJa3qPdfu9ZkIPzYDNEHHQm3hzMvnMTtssV/totZncf9ofi9fwv8j
         ip8A==
X-Gm-Message-State: AOJu0YxJPdgAv0FnJH4iw64bO8NBm0L8q7mGB9NPA50DtFug8deudCnL
	1Tf2mxnEPZZWi5PcxMz6bj0=
X-Google-Smtp-Source: AGHT+IGjmw9St41gir5RLFR8rHeyYklgMFuKsJe1fDrb76IwLCbWIuEiFCn/QgRpYXiNtJ7Gb6c6Ew==
X-Received: by 2002:a17:907:3fa2:b0:9c7:5437:841e with SMTP id hr34-20020a1709073fa200b009c75437841emr10624495ejc.11.1698241781178;
        Wed, 25 Oct 2023 06:49:41 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id x13-20020a170906710d00b009ad87fd4e65sm9918416ejj.108.2023.10.25.06.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 06:49:40 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 25 Oct 2023 15:49:38 +0200
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@kernel.org, kernel-team@meta.com,
	bjorn@kernel.org, xukuohai@huawei.com, pulehui@huawei.com,
	iii@linux.ibm.com
Subject: Re: [PATCH v5 bpf-next 0/7] Allocate bpf trampoline on bpf_prog_pack
Message-ID: <ZTkc8hR3ALOsABQq@krava>
References: <20231024224601.2292927-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231024224601.2292927-1-song@kernel.org>

On Tue, Oct 24, 2023 at 03:45:54PM -0700, Song Liu wrote:
> This set enables allocating bpf trampoline from bpf_prog_pack on x86. The
> majority of this work, however, is the refactoring of trampoline code.
> This is needed because we need to handle 4 archs and 2 users (trampoline
> and struct_ops).
> 
> 1/7 through 6/7 refactors trampoline code. A few helpers are added.
> 7/7 finally let bpf trampoline on x86 use bpf_prog_pack.
> 
> Changes in v5:
> 1. Adjust size of trampoline ksym. (Jiri)
> 2. Use "unsigned int size" arg in image management helpers.(Daniel)
> 
> Changes in v4:
> 1. Dropped 1/8 in v3, which is already merged in bpf-next.
> 2. Add Reviewed-by from Björn Töpel.
> 
> Changes in v3:
> 1. Fix bug in s390. (Thanks to Ilya Leoshkevich).
> 2. Fix build error in riscv. (kernel test robot).
> 
> Changes in v2:
> 1. Add missing changes in net/bpf/bpf_dummy_struct_ops.c.
> 2. Reduce one dry run in arch_prepare_bpf_trampoline. (Xu Kuohai)
> 3. Other small fixes.
> 
> Song Liu (7):
>   bpf: Let bpf_prog_pack_free handle any pointer
>   bpf: Adjust argument names of arch_prepare_bpf_trampoline()
>   bpf: Add helpers for trampoline image management
>   bpf, x86: Adjust arch_prepare_bpf_trampoline return value
>   bpf: Add arch_bpf_trampoline_size()
>   bpf: Use arch_bpf_trampoline_size
>   x86, bpf: Use bpf_prog_pack for bpf trampoline

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
>  arch/arm64/net/bpf_jit_comp.c   |  55 +++++++++-----
>  arch/riscv/net/bpf_jit_comp64.c |  25 ++++---
>  arch/s390/net/bpf_jit_comp.c    |  56 +++++++++------
>  arch/x86/net/bpf_jit_comp.c     | 124 +++++++++++++++++++++++++-------
>  include/linux/bpf.h             |  14 +++-
>  include/linux/filter.h          |   2 +-
>  kernel/bpf/bpf_struct_ops.c     |  19 +++--
>  kernel/bpf/core.c               |  21 +++---
>  kernel/bpf/dispatcher.c         |   7 +-
>  kernel/bpf/trampoline.c         | 101 +++++++++++++++++++-------
>  net/bpf/bpf_dummy_struct_ops.c  |   7 +-
>  11 files changed, 299 insertions(+), 132 deletions(-)
> 
> --
> 2.34.1

