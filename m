Return-Path: <bpf+bounces-29700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AA88C5742
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 15:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE52F1C2190C
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 13:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FC81448D7;
	Tue, 14 May 2024 13:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="hZdFBYV2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C556111AA
	for <bpf@vger.kernel.org>; Tue, 14 May 2024 13:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715693827; cv=none; b=upXnfnX6NxcLZWIlaKnygIoM9UaVszs66fnvOMoCcGW76FBPYqdhQ42GDQTkvhgf6i0Ybe1A3EEU+vlWZ555A9xG0WCIsFO5DB5ngYFemR50gfaV2/dLPCCJGUdVnDwHZ0ftP8seYuWclulgMt/jvsCbq8V7cA5nw5Co0lRL88g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715693827; c=relaxed/simple;
	bh=9jwDZpLtXYdH7f8CnFUzmEywmSNfCgk8pbmzgdwGhI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tb8khyEME/RxzFjtOba+DCxlbN3uzWUx9H5h5Nj6eEkm2iED+M6g2H43XxDuDCk3gcpFnhti3VSvpXQ6/10FKgbqXaNTADWADci2Mqrjrg+aIsCd09fb9vVcfDs1S5/CdIfVQfd8VTqMcirrmAeJTWxUScfpU0lhNj6KfcsgqOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=hZdFBYV2; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57230faeb81so83088a12.0
        for <bpf@vger.kernel.org>; Tue, 14 May 2024 06:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1715693824; x=1716298624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5cx8eGFgWusFqzKnU2m9G7FMZaETmak6wJbi8q40vVg=;
        b=hZdFBYV2+XzypQogGpMgmZm8vdz+UUkGm8qa750aNKPo6eccbsZx8zq+3QDhycU4vy
         6A3z4IBl3h4p19S9j5Jth5k4gh0BrHAQTqdFDq7UViq3U9ONcPAbnWQ7Qjn0QAQIwncY
         LPolpxVn7aa7hNOSI868J+B8ngM27D7QYbiX4dSM5KUXo2o/gXtOjSeyb5Rabr1T1ngx
         OH2ZUEib7xwsswWRXgwtHxadRcp11Tw0gR4WGtWrs6NvjUM5K5YFZHVZOgqymwHzgRwv
         SYMlZEXXfr+T0LskVc3lHA7970Igf4kB0H71knTy3NOr2z1GNRbe9/TZfMUGZW9Wa/1m
         WAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715693824; x=1716298624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cx8eGFgWusFqzKnU2m9G7FMZaETmak6wJbi8q40vVg=;
        b=laxme9zdNbYGWHc5iPLlz4UESJL4Qu3B4zJUF4Xb1Rewn8gCjELqDzZJKd3tI7uAlU
         cQofpOYMCoLlkAXcR9NJL3Xei2cV2KT3bWti8Ts4CEAwm8ai0A/yLPDGb9qgeFi4oGAn
         YPvYm/KCJMFv9DXfmFE0l5YFqTdO1Egfugc5rMG+8Ap0BCgEGmjWiC4B6MwQ1R498eg2
         MIOyDoS5T3rMIopKoqEvOr9TW+Pgd+Odh/hZRoRVSYueuc2Nv7hTfvHlVJrht+Jn/Jd0
         XvsFi41WVFREeRkkQQJgFCk7mR0v8uYd2M1SuWnek8rULE14OP+3TUkwGf6DBV40uhFe
         ZFQg==
X-Forwarded-Encrypted: i=1; AJvYcCWpwjt014aBc/jkT70FJhX5ydgZzoayQqJCQCpItnzlA7tlzxIozXBxLnT2uEg1S93EcHyZbvl/q57Ys62RO+iZGN/g
X-Gm-Message-State: AOJu0Yzagzgp1o1VfXea7MhUgflT5xd5yT5V8oTotaXaftKulskWnx+q
	/gwupBbPFsLPdUTYgTPMW/+SKpYCVMh41zwB+gsT3E/MDITrQmMWt3plVdGqSQU=
X-Google-Smtp-Source: AGHT+IEG34t1nBcoasxIfz0onNp1LM/pKZDSI+MHo8bRyXMguGfrUzwtpC0PIzhm4BplctJR8CpzvQ==
X-Received: by 2002:a50:935b:0:b0:574:ecec:1887 with SMTP id 4fb4d7f45d1cf-574ecec19camr187645a12.32.1715693823501;
        Tue, 14 May 2024 06:37:03 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bebb6d5sm7523102a12.34.2024.05.14.06.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 06:37:03 -0700 (PDT)
Date: Tue, 14 May 2024 15:37:02 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: "Wang, Xiao W" <xiao.w.wang@intel.com>
Cc: "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, 
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, 
	"luke.r.nels@gmail.com" <luke.r.nels@gmail.com>, "xi.wang@gmail.com" <xi.wang@gmail.com>, 
	"bjorn@kernel.org" <bjorn@kernel.org>, "ast@kernel.org" <ast@kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "andrii@kernel.org" <andrii@kernel.org>, 
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "eddyz87@gmail.com" <eddyz87@gmail.com>, 
	"song@kernel.org" <song@kernel.org>, "yonghong.song@linux.dev" <yonghong.song@linux.dev>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"sdf@google.com" <sdf@google.com>, "haoluo@google.com" <haoluo@google.com>, 
	"jolsa@kernel.org" <jolsa@kernel.org>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "pulehui@huawei.com" <pulehui@huawei.com>, 
	"Li, Haicheng" <haicheng.li@intel.com>, "conor@kernel.org" <conor@kernel.org>, 
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH v2] riscv, bpf: Optimize zextw insn with Zba extension
Message-ID: <20240514-944dec90b2c531d8b6c783f7@orel>
References: <20240511023436.3282285-1-xiao.w.wang@intel.com>
 <20240513-5c6f04fb4a29963c63d09aa2@orel>
 <DM8PR11MB575179A3EB8D056B3EEECA74B8E32@DM8PR11MB5751.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR11MB575179A3EB8D056B3EEECA74B8E32@DM8PR11MB5751.namprd11.prod.outlook.com>

On Tue, May 14, 2024 at 07:36:04AM GMT, Wang, Xiao W wrote:
> 
> 
> > -----Original Message-----
> > From: Andrew Jones <ajones@ventanamicro.com>
> > Sent: Tuesday, May 14, 2024 12:53 AM
> > To: Wang, Xiao W <xiao.w.wang@intel.com>
> > Cc: paul.walmsley@sifive.com; palmer@dabbelt.com;
> > aou@eecs.berkeley.edu; luke.r.nels@gmail.com; xi.wang@gmail.com;
> > bjorn@kernel.org; ast@kernel.org; daniel@iogearbox.net; andrii@kernel.org;
> > martin.lau@linux.dev; eddyz87@gmail.com; song@kernel.org;
> > yonghong.song@linux.dev; john.fastabend@gmail.com; kpsingh@kernel.org;
> > sdf@google.com; haoluo@google.com; jolsa@kernel.org; linux-
> > riscv@lists.infradead.org; linux-kernel@vger.kernel.org; bpf@vger.kernel.org;
> > pulehui@huawei.com; Li, Haicheng <haicheng.li@intel.com>;
> > conor@kernel.org
> > Subject: Re: [PATCH v2] riscv, bpf: Optimize zextw insn with Zba extension
> > 
> > On Sat, May 11, 2024 at 10:34:36AM GMT, Xiao Wang wrote:
> > > The Zba extension provides add.uw insn which can be used to implement
> > > zext.w with rs2 set as ZERO.
> > >
> > > Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> > > ---
> > > v2:
> > > * Add Zba description in the Kconfig. (Lehui)
> > > * Reword the Kconfig help message to make it clearer. (Conor)
> > > ---
> > >  arch/riscv/Kconfig       | 22 ++++++++++++++++++++++
> > >  arch/riscv/net/bpf_jit.h | 18 ++++++++++++++++++
> > >  2 files changed, 40 insertions(+)
> > >
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index 6bec1bce6586..e262a8668b41 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -586,6 +586,14 @@ config RISCV_ISA_V_PREEMPTIVE
> > >  	  preemption. Enabling this config will result in higher memory
> > >  	  consumption due to the allocation of per-task's kernel Vector
> > context.
> > >
> > > +config TOOLCHAIN_HAS_ZBA
> > > +	bool
> > > +	default y
> > > +	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64ima_zba)
> > > +	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32ima_zba)
> > > +	depends on LLD_VERSION >= 150000 || LD_VERSION >= 23900
> > > +	depends on AS_HAS_OPTION_ARCH
> > > +
> > >  config TOOLCHAIN_HAS_ZBB
> > >  	bool
> > >  	default y
> > > @@ -601,6 +609,20 @@ config TOOLCHAIN_HAS_VECTOR_CRYPTO
> > >  	def_bool $(as-instr, .option arch$(comma) +v$(comma) +zvkb)
> > >  	depends on AS_HAS_OPTION_ARCH
> > >
> > > +config RISCV_ISA_ZBA
> > > +	bool "Zba extension support for bit manipulation instructions"
> > > +	depends on TOOLCHAIN_HAS_ZBA
> > 
> > We handcraft the instruction, so why do we need toolchain support?
> 
> Good point, we don't need toolchain support for this bpf jit case.
> 
> > 
> > > +	depends on RISCV_ALTERNATIVE
> > 
> > Also, while riscv_has_extension_likely() will be accelerated with
> > RISCV_ALTERNATIVE, it's not required.
> 
> Agree, it's not required. For this bpf jit case, we should drop these two dependencies.
> 
> BTW, Zbb is used in bpf jit, the usage there also doesn't depend on toolchain and
> RISCV_ALTERNATIVE, but the Kconfig for RISCV_ISA_ZBB has forced the dependencies
> due to Zbb assembly programming elsewhere.
> Maybe we could just dynamically check the existence of RISCV_ISA_ZB* before jit code
> emission? or introduce new config options for bpf jit? I prefer the first method and
> welcome any comments.

My preferences is to remove as much of the TOOLCHAIN_HAS_ stuff as
possible. We should audit the extensions which have them to see if
they're really necessary. I don't mind depending on RISCV_ALTERNATIVE,
since it's almost required for riscv at this point anyway.

Thanks,
drew

> 
> Thanks,
> Xiao
> 
> [...]
> > >  {
> > > +	if (rvzba_enabled()) {
> > > +		emit(rvzba_zextw(rd, rs), ctx);
> > > +		return;
> > > +	}
> > > +
> > >  	emit_slli(rd, rs, 32, ctx);
> > >  	emit_srli(rd, rd, 32, ctx);
> > >  }
> > > --
> > > 2.25.1
> > >
> > 
> > Thanks,
> > drew

