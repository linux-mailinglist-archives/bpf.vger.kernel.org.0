Return-Path: <bpf+bounces-33632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD1E923FB9
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 15:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9F4D28C0F8
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 13:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED831B5818;
	Tue,  2 Jul 2024 13:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NV2pOtL0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D1716631A;
	Tue,  2 Jul 2024 13:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719928678; cv=none; b=OStOtP5K6kkXPvqijGe4eU86HFw5cUoh5Hm6Xg9E0zv1YsTsP/dtcz7CDiISlWt28ViTGRfrtZ/s8hpifg2256wU95QunuWQ7H0jPwNzBaQwCCh8cv73DRzSFBZnH5aLMcywu1fIIJO0xv/HhpAz+gjoELR8N4UkZYa+144vHiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719928678; c=relaxed/simple;
	bh=R5jYsYDsbM4YHchYzsZARuDYKzl4575wfzad4Gt38O8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JlkW0zL7N4HA6BandD46KIH1ieoqDULRQmyO0fbB/lUrSLn6zqD7O6twLWE2+R99q+IlbDxRMtoVxWCMAapV4HpHWyVyONkLj2gPA7K0GAHbRoFi1XQTbvFmT5FCS8mcpxJowhhwtzMeNLg7ppIrNOY30Vl4hZOGTSOOqZPTpDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NV2pOtL0; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a732cb4ea31so553227066b.0;
        Tue, 02 Jul 2024 06:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719928674; x=1720533474; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n7FK8iXLG1SnlI4ndAhM4FDLc7t8LfJYFyucJUdAyuE=;
        b=NV2pOtL0xVTxjfXO5Joh5J5vUrus2V62Aptt6VRl7OBFTxi9HZpLBxEt1OvlVL9Y8T
         cgJm/IzdaDzdzHDn2BhUxwTY9n3TqlLPU2X7jodGNXuB233/4hzxsYUmUd3hClAN5EFa
         sfzSz4kXJnN6fC1NZn7le83aqa2LlWCcP9CW3dKOnj5WpcBgahIdcCWxEoN1dVrAuW23
         tvA9vbRb+s/uqZ0OnCCIrmyvPb5j8CULFBHUo099XPcrQMKPFYkU2mcZBwUh4Vi1nXFW
         Ipz6J1pYGPrZ1JK+8HaCvWWyTqLvKCx/63WUGHocIjA2j06xAnUglWqtTJdLyOGZzqnk
         0Oxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719928674; x=1720533474;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n7FK8iXLG1SnlI4ndAhM4FDLc7t8LfJYFyucJUdAyuE=;
        b=ibldktMISp81Z4lypxBRy+VVdthkaEUJYAmlGo1V6trd4CKjF1z5Cy4TNb4drkK8HK
         +3l7cPfURrutaNXNR5JW0BGijeVECdnRJ7ooG5h2CIy9geNDrvRHPf+nKP3Ue4pJ59uN
         Jg49mK2E6JMwgB5ErE6VB1aB8OjNat5CsBJL4mQtIPjxnEQtkIKGyXa4PNTedqx3WUsn
         wfxO/9NYOuVxR8WP/TEKKpHTn661CMsw1Ygw/TrjlrTMB+VbKPckGYLg281TezQ5VJAO
         yz8TpLvSC/zl+IcNBDFBBYEBAoLfdD+gA7Bg0RsMRg6x5CHa82ehybahLmRRXzVTcKxm
         2xKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnaBCx8tfyO8tqDZSueae4ekafDpEdO6gHxRLee0CrPHXMF6IH9A2YjQjlZTsTHbpv+DHhnBHxgJwJ2Fbl6QtXAQus4IOM
X-Gm-Message-State: AOJu0YwUdl+rAbsBUsKYQIECYOI+hNYZqmn1M0UrOZq+cig1FSsSF0Wq
	T1FHWBgVL06MOIqtCsLncucIV82NSsoFaEzKYPT0qULof3XAJ15E
X-Google-Smtp-Source: AGHT+IH2HqD5izfKCSSLrGswi6+i1YWaBA+ICZDZLQ4sVhN4O2GnDe+J7F6F+MWd2qssMhCawY4LUQ==
X-Received: by 2002:a17:906:494a:b0:a6f:7707:b846 with SMTP id a640c23a62f3a-a72aee66c4dmr877328666b.15.1719928673929;
        Tue, 02 Jul 2024 06:57:53 -0700 (PDT)
Received: from krava (37-188-191-130.red.o2.cz. [37.188.191.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf61f4dsm421550166b.71.2024.07.02.06.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 06:57:53 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 2 Jul 2024 15:57:47 +0200
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Puranjay Mohan <puranjay@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH bpf-next v6 0/3] Add 12-argument support for RV64 bpf
 trampoline
Message-ID: <ZoQHW2EaisezC1t5@krava>
References: <20240702121944.1091530-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240702121944.1091530-1-pulehui@huaweicloud.com>

On Tue, Jul 02, 2024 at 12:19:41PM +0000, Pu Lehui wrote:
> This patch adds 12 function arguments support for riscv64 bpf
> trampoline. The current bpf trampoline supports <= sizeof(u64) bytes
> scalar arguments [0] and <= 16 bytes struct arguments [1]. Therefore, we
> focus on the situation where scalars are at most XLEN bits and
> aggregates whose total size does not exceed 2×XLEN bits in the riscv
> calling convention [2].
> 
> Link: https://elixir.bootlin.com/linux/v6.8/source/kernel/bpf/btf.c#L6184 [0]
> Link: https://elixir.bootlin.com/linux/v6.8/source/kernel/bpf/btf.c#L6769 [1]
> Link: https://github.com/riscv-non-isa/riscv-elf-psabi-doc/releases/download/draft-20230929-e5c800e661a53efe3c2678d71a306323b60eb13b/riscv-abi.pdf [2]
> 
> v6:
> - Remove unnecessary skel detach ops as it will be covered by skel destroy ops.

selftests bits lgtm

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
> v5: https://lore.kernel.org/all/20240702013730.1082285-1-pulehui@huaweicloud.com/
> - Remove unnecessary copyright.
> 
> v4: https://lore.kernel.org/all/20240622022129.3844473-1-pulehui@huaweicloud.com/
> - Separate many args test logic from tracing_struct. (Daniel)
> 
> v3: https://lore.kernel.org/all/20240403072818.1462811-1-pulehui@huaweicloud.com/
> - Variable and macro name alignment:
>   nr_reg_args: number of args in reg
>   nr_stack_args: number of args on stack
>   RV_MAX_REG_ARGS: macro for riscv max args in reg
> 
> v2: https://lore.kernel.org/all/20240403041710.1416369-1-pulehui@huaweicloud.com/
> - Add tracing_struct to DENYLIST.aarch64 while aarch64 does not yet support
>   bpf trampoline with more than 8 args.
> - Change the macro RV_MAX_ARG_REGS to RV_MAX_ARGS_REG to synchronize with
>   the variable definition below.
> - Add some comments for stk_arg_off and magic number of skip slots for loading
>   args on stack.
> 
> v1: https://lore.kernel.org/all/20240331092405.822571-1-pulehui@huaweicloud.com/
> 
> Pu Lehui (3):
>   riscv, bpf: Add 12-argument support for RV64 bpf trampoline
>   selftests/bpf: Factor out many args tests from tracing_struct
>   selftests/bpf: Add testcase where 7th argment is struct
> 
>  arch/riscv/net/bpf_jit_comp64.c               | 66 +++++++++----
>  tools/testing/selftests/bpf/DENYLIST.aarch64  |  1 +
>  .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 19 ++++
>  .../selftests/bpf/prog_tests/tracing_struct.c | 44 ++++++++-
>  .../selftests/bpf/progs/tracing_struct.c      | 54 -----------
>  .../bpf/progs/tracing_struct_many_args.c      | 95 +++++++++++++++++++
>  6 files changed, 202 insertions(+), 77 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/tracing_struct_many_args.c
> 
> -- 
> 2.34.1
> 

