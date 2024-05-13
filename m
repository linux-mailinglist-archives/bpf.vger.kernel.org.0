Return-Path: <bpf+bounces-29648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 902578C455D
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 18:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0D7C1C20AEC
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 16:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115551B5A4;
	Mon, 13 May 2024 16:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="SNNKkRaY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D4C1BF40
	for <bpf@vger.kernel.org>; Mon, 13 May 2024 16:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715619212; cv=none; b=VvZB1whSDW6ZrUpQSVQXiq5YvBF4zlJhr93nQjGxqgcZnc9J/TcUKPSjIaxzAtzC3n3K99kEw16oKB8Qizxs3230Zpi7xCJ1cfD4tJbJkiVhxsfRmprRe6CPx7cwEIPEuKnzgkolpFHkRc8og2oJ6LgMcRme3IBxlI/szpZMYnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715619212; c=relaxed/simple;
	bh=tYn3826eEKH6f1tndWzHmG2prJ0t5GbyHtUGkIAnuMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eu2u+986mz2g+/ycd7Ou12YUUUIlJQMyVlgKje3iSd34Z551ovZiDVOFLwIasrcjkBBF42nG9p9fM4luvDlbiJUQmsJn0Z1pUFMQ5Kmmqs+TBzguoaqPFevwDZF5vMnvvTkNVfeGYU8caizXOPfYq8nxsJnNFimlFNlWpgVyclI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=SNNKkRaY; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a59a387fbc9so1192570666b.1
        for <bpf@vger.kernel.org>; Mon, 13 May 2024 09:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1715619208; x=1716224008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1oBPAF2w8fZVPm8NSdnQib33iYXIwPTD6vxiqg/Fetg=;
        b=SNNKkRaYQuij4To8x+gJc4DMrcnqbzUS7gXbORoJyHuIp8AWlISFOmdRlKYqFA60mF
         c8yZkPhgmsLykqJBnl/znaz7/5H9gxteZrHY46xIJHhwj5jUjzAKU02HTmrJxRs3UQFO
         mnllTA2n/pZ7bzdfysfyuNg8UwwX5JlbKoX63FPM+kXbU+6r+TJ98S9cdwfVz/6br1SO
         dy7VIx5cbUDlRWDMM8HoVKL+0GExvFa4LE6XoqNS0MPpk29MyFSIf8V6EtDKn/Obcp44
         qjJdbGb7o3zMK9Q9t2Sdw0WXcS6ju2QcuH9OrltssXJcSiZjVHVHaIMvdptVJ1lfaCgE
         sWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715619208; x=1716224008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oBPAF2w8fZVPm8NSdnQib33iYXIwPTD6vxiqg/Fetg=;
        b=QNkxZd1FghzYcKmCjX2N+YNwH0UzwoSDMR6RRFNmg7fSQiAYnvdwWfReLIUaJi7ysE
         MjOGGjrWBdmrAUFVbNf3eKcYDP/CsEHu+1HtKLbYPCTmH5NxQtkcue6T35vQns0jaMx7
         jk1Z0niQYiTitwDFkXt31JiEGUn8BZ0nqKmrlK/psAi7SffnylFvN0eciNFC09Y2o4rp
         iYVluDSO/EhUetN7WmXbe0ngaLNpJP4nt2Jj8PTnhuZlnKl5OFT6y163Bu1iqxIT2M4C
         u/uBoSvLASQGTWEerxJD5sJ2uLK9zjDNkRhu/VXgtJ9alP8+qkxJ9RPBIAdqq9ZvqR6Y
         KlUg==
X-Forwarded-Encrypted: i=1; AJvYcCWAHcBLXhAiXaqOp/jfIaONrdX3/7nntL52kRA1xZYe5Gj/OLVROykd/RNY2MzA5jHTX8LGIl+kIy+NO7HNwYzTOqYJ
X-Gm-Message-State: AOJu0YwqrrdapgHMwJpFxxUsGjAyJRuhKFKrBzj14HgqSSiv0ib7s+en
	UKgt0FSoRQdIizWMgiNAnZv++bTVo+QDYAeiDgeU176GV4dn0S/DsfIr3KNWqYM=
X-Google-Smtp-Source: AGHT+IGdnmvLUxoBJc6VxZdO9jyZljv6lqT40AVcHBqVs5j7MRwp1eJG+AnOtf3UQerVicHm0jYmkw==
X-Received: by 2002:a50:d596:0:b0:572:d4fc:cc3 with SMTP id 4fb4d7f45d1cf-5734d5974d0mr7375118a12.2.1715619208429;
        Mon, 13 May 2024 09:53:28 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c2c7d79sm6427800a12.59.2024.05.13.09.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 09:53:27 -0700 (PDT)
Date: Mon, 13 May 2024 18:53:26 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Xiao Wang <xiao.w.wang@intel.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	luke.r.nels@gmail.com, xi.wang@gmail.com, bjorn@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pulehui@huawei.com, haicheng.li@intel.com, conor@kernel.org
Subject: Re: [PATCH v2] riscv, bpf: Optimize zextw insn with Zba extension
Message-ID: <20240513-5c6f04fb4a29963c63d09aa2@orel>
References: <20240511023436.3282285-1-xiao.w.wang@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240511023436.3282285-1-xiao.w.wang@intel.com>

On Sat, May 11, 2024 at 10:34:36AM GMT, Xiao Wang wrote:
> The Zba extension provides add.uw insn which can be used to implement
> zext.w with rs2 set as ZERO.
> 
> Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> ---
> v2:
> * Add Zba description in the Kconfig. (Lehui)
> * Reword the Kconfig help message to make it clearer. (Conor)
> ---
>  arch/riscv/Kconfig       | 22 ++++++++++++++++++++++
>  arch/riscv/net/bpf_jit.h | 18 ++++++++++++++++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 6bec1bce6586..e262a8668b41 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -586,6 +586,14 @@ config RISCV_ISA_V_PREEMPTIVE
>  	  preemption. Enabling this config will result in higher memory
>  	  consumption due to the allocation of per-task's kernel Vector context.
>  
> +config TOOLCHAIN_HAS_ZBA
> +	bool
> +	default y
> +	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64ima_zba)
> +	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32ima_zba)
> +	depends on LLD_VERSION >= 150000 || LD_VERSION >= 23900
> +	depends on AS_HAS_OPTION_ARCH
> +
>  config TOOLCHAIN_HAS_ZBB
>  	bool
>  	default y
> @@ -601,6 +609,20 @@ config TOOLCHAIN_HAS_VECTOR_CRYPTO
>  	def_bool $(as-instr, .option arch$(comma) +v$(comma) +zvkb)
>  	depends on AS_HAS_OPTION_ARCH
>  
> +config RISCV_ISA_ZBA
> +	bool "Zba extension support for bit manipulation instructions"
> +	depends on TOOLCHAIN_HAS_ZBA

We handcraft the instruction, so why do we need toolchain support?

> +	depends on RISCV_ALTERNATIVE

Also, while riscv_has_extension_likely() will be accelerated with
RISCV_ALTERNATIVE, it's not required.

> +	default y
> +	help
> +	   Add support for enabling optimisations in the kernel when the Zba
> +	   extension is detected at boot.
> +
> +	   The Zba extension provides instructions to accelerate the generation
> +	   of addresses that index into arrays of basic data types.
> +
> +	   If you don't know what to do here, say Y.
> +
>  config RISCV_ISA_ZBB
>  	bool "Zbb extension support for bit manipulation instructions"
>  	depends on TOOLCHAIN_HAS_ZBB
> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
> index f4b6b3b9edda..18a7885ba95e 100644
> --- a/arch/riscv/net/bpf_jit.h
> +++ b/arch/riscv/net/bpf_jit.h
> @@ -18,6 +18,11 @@ static inline bool rvc_enabled(void)
>  	return IS_ENABLED(CONFIG_RISCV_ISA_C);
>  }
>  
> +static inline bool rvzba_enabled(void)
> +{
> +	return IS_ENABLED(CONFIG_RISCV_ISA_ZBA) && riscv_has_extension_likely(RISCV_ISA_EXT_ZBA);
> +}
> +
>  static inline bool rvzbb_enabled(void)
>  {
>  	return IS_ENABLED(CONFIG_RISCV_ISA_ZBB) && riscv_has_extension_likely(RISCV_ISA_EXT_ZBB);
> @@ -937,6 +942,14 @@ static inline u16 rvc_sdsp(u32 imm9, u8 rs2)
>  	return rv_css_insn(0x7, imm, rs2, 0x2);
>  }
>  
> +/* RV64-only ZBA instructions. */
> +
> +static inline u32 rvzba_zextw(u8 rd, u8 rs1)
> +{
> +	/* add.uw rd, rs1, ZERO */
> +	return rv_r_insn(0x04, RV_REG_ZERO, rs1, 0, rd, 0x3b);
> +}
> +
>  #endif /* __riscv_xlen == 64 */
>  
>  /* Helper functions that emit RVC instructions when possible. */
> @@ -1159,6 +1172,11 @@ static inline void emit_zexth(u8 rd, u8 rs, struct rv_jit_context *ctx)
>  
>  static inline void emit_zextw(u8 rd, u8 rs, struct rv_jit_context *ctx)
>  {
> +	if (rvzba_enabled()) {
> +		emit(rvzba_zextw(rd, rs), ctx);
> +		return;
> +	}
> +
>  	emit_slli(rd, rs, 32, ctx);
>  	emit_srli(rd, rd, 32, ctx);
>  }
> -- 
> 2.25.1
>

Thanks,
drew

