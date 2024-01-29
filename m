Return-Path: <bpf+bounces-20562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD7D840402
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 12:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B5881F21657
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 11:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219645C8FD;
	Mon, 29 Jan 2024 11:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="G8atFPLb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69B05C5E0
	for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 11:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706528589; cv=none; b=B6KTC2JyFBHl0bdTBlcm3PZLk2Nui1yBE2k/3q7GNFA4gxXBgNTBN1Isx7AFobcWycVy+X8oS87qL/xoNhv/tQqsFUtYTYUhj19BXuY45M+2yOaDlPSe5400dS4Fwi2ItuDCouwmzOfI22p0BYxRoKxOxXwLyFpkefav2qnrRQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706528589; c=relaxed/simple;
	bh=gPA17xZLo9IDKsqW7ioface1iKvRFE0TAGGexIcqAdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYEJ6YF4tzzysJNUPBvvh8oD//Kz5Rto+S9H+Bo+L24/ms4SzkH82Ca8rZlkSIJZ93Uh1lPfRifVzORnKSbFYN3+vMjC/QlSd6fVdh/1FpA195pkGw0xB+A4A3/HDCnjizALuHKHl+Q/QIRfrO1FxXkRwhx8liPkPM2jYvyMDbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=G8atFPLb; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55f0367b15fso931967a12.0
        for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 03:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1706528586; x=1707133386; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jll+xDGWtNinZyXQQxr9XYKpco16f8UDTOTc59xvHik=;
        b=G8atFPLbKCtf2BdCTGBCMauIu2zsYTWk5S92gU/fpQ8ENB0UfZc9zW7+3j/6QX2spx
         PK7YBGqp6sLyAGTK7wx9t9W7NZv8f177pm+OtrzzViqaAXrrw3eqCKwpP1RstEFz5O23
         nSjwtK1xBGONtEQjBITyXveINMEC/CuRh59SBTb5z2p5xUzYM8mr1Hs9CexoEpHNVanx
         GjZ6nLY4Ot88exWFu6b/WNYtT6yvQvmV0oJZp7+kPnMg0nlrl2Srvl5Q3zRmyB/iZk1J
         M2H2+IQQiSGlQwFg7APCkgvnC+YRvt2q+pQ2EdjNIwnBc+fbnQkC8xSr55T/lGB2JMPO
         +/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706528586; x=1707133386;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jll+xDGWtNinZyXQQxr9XYKpco16f8UDTOTc59xvHik=;
        b=tY2H2kQUR9E7cUR4cqeSL5h34LuRdMl26OJ8ZfoRKAjtHc9jVgvUKzfqyPnIjXpF4a
         7HxXfjf7+usFSbVGfF1xnO1U/PwfIp4uGKgIRjdHfPChlteLA3zd0/uLxf68Lx5NpYJE
         w3NB+l+tEwXp5NHKLJyGW+tHlqH8Rjj53SpVWY551RjpmO4ELH5SUrl/ctFHW8ooUwfk
         Ec4VM2qUEIg2j0oA10iUC0MVow2Ye+7t89hgk3t8SgzxCDG0ERByS1QxDTmalKXL16qR
         DKFSL9JTS9lnWHjtbG68Ht12mbW8Bfj7SnLF6z0zT047h+hYtftxclR1Ioh4Mvssymlg
         lcug==
X-Gm-Message-State: AOJu0Yy862MNcNk3ZTqvdae6+K7upBKPoo2zLn4aPziLX40P3hqeFI1q
	WzjYYwJl5NsxO9dhvI8QH/H8WFlj9+wsPUvJp86Diq2a9h9IveepvcLmD66mZoM=
X-Google-Smtp-Source: AGHT+IEH86+9YzoszcB0Vw77R/3cAt0Y76DqSvHQ0Vzf0hiKE1eyYrhFeBRHNrBofYY00RvjvRoY9g==
X-Received: by 2002:a05:6402:22ea:b0:55e:ed35:ffce with SMTP id dn10-20020a05640222ea00b0055eed35ffcemr2148019edb.37.1706528586113;
        Mon, 29 Jan 2024 03:43:06 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id fk1-20020a056402398100b0055d19c9daf2sm3657333edb.15.2024.01.29.03.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 03:43:05 -0800 (PST)
Date: Mon, 29 Jan 2024 12:43:04 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org, 
	linux-riscv@lists.infradead.org, netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, 
	Luke Nelson <luke.r.nels@gmail.com>, Pu Lehui <pulehui@huawei.com>
Subject: Re: Re: [PATCH RESEND bpf-next v3 4/6] riscv, bpf: Add necessary Zbb
 instructions
Message-ID: <20240129-d06c79a17a5091b3403fc5b6@orel>
References: <20240115131235.2914289-1-pulehui@huaweicloud.com>
 <20240115131235.2914289-5-pulehui@huaweicloud.com>
 <871qa2zog6.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871qa2zog6.fsf@all.your.base.are.belong.to.us>

On Sat, Jan 27, 2024 at 06:16:41PM +0100, Björn Töpel wrote:
> Pu Lehui <pulehui@huaweicloud.com> writes:
> 
> > From: Pu Lehui <pulehui@huawei.com>
> >
> > Add necessary Zbb instructions introduced by [0] to reduce code size and
> > improve performance of RV64 JIT. Meanwhile, a runtime deteted helper is
> > added to check whether the CPU supports Zbb instructions.
> >
> > Link: https://github.com/riscv/riscv-bitmanip/releases/download/1.0.0/bitmanip-1.0.0-38-g865e7a7.pdf [0]
> > Signed-off-by: Pu Lehui <pulehui@huawei.com>
> > ---
> >  arch/riscv/net/bpf_jit.h | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >
> > diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
> > index e30501b46f8f..51f6d214086f 100644
> > --- a/arch/riscv/net/bpf_jit.h
> > +++ b/arch/riscv/net/bpf_jit.h
> > @@ -18,6 +18,11 @@ static inline bool rvc_enabled(void)
> >  	return IS_ENABLED(CONFIG_RISCV_ISA_C);
> >  }
> >  
> > +static inline bool rvzbb_enabled(void)
> > +{
> > +	return IS_ENABLED(CONFIG_RISCV_ISA_ZBB) && riscv_has_extension_likely(RISCV_ISA_EXT_ZBB);
> 
> Hmm, I'm thinking about the IS_ENABLED(CONFIG_RISCV_ISA_ZBB) semantics
> for a kernel JIT compiler.
> 
> IS_ENABLED(CONFIG_RISCV_ISA_ZBB) affects the kernel compiler flags.
> Should it be enough to just have the run-time check? Should a kernel
> built w/o Zbb be able to emit Zbb from the JIT?
>

My two cents (which might be worth less than two cents due to my lack of
BPF knowledge) is yes, the JIT should be allowed to emit Zbb instructions
even when the kernel is not built with a compiler which has done so. In
fact, we have insn-def.h for situations similar to this.

Thanks,
drew

