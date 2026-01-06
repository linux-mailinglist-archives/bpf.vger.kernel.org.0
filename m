Return-Path: <bpf+bounces-78019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CC4CFB4B8
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 23:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A45D307D465
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 22:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97C02FFDE6;
	Tue,  6 Jan 2026 22:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FO6F7gDI"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF0823D297
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 22:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767739956; cv=none; b=NMYwWnvI2l9i9ZWglWJcSkwLSC3CZ0XOZT0DV4Tc0axv3MhL57XZ/m1NH1tv81RNyYuWF4D9V0dMe0bXkxDtRPeRsYdeMmdNBrAYBt3zOrdNNbT1fum3eRViWYjzJYBj3rIXuiyE2Pe/a4qeHPWT40YJ4TozbSRMUJK2sH+kXL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767739956; c=relaxed/simple;
	bh=1I9PhPhwjz4zpv/lwxWy0m5qsgaDYe1kMeNdZHDdqvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f05szd/nl0BvE1DgOfeMxvP97yheaW+20TM0TnLyAA59vC6oSr61hQ0E0X4FC40AuiArh15F/VZGt8bEUlkEd+4rrxZQEn/1Pjli8zMZj+ndrRvSavV3ZrdvzliGW+iCXpPHiRntq/iOq+a6Cs4sVBZaR7HkBAhJi/hZ76VqBuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FO6F7gDI; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <55a1fc6b-5129-4017-af17-e0476626b1b1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767739941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XXmV/ni98VprxjTHfbU5Ht4acAC5wfPvoZyvlG/xTzg=;
	b=FO6F7gDI/9h0xNZLkenSrXomTM/eRP8O+lkwptlFvrDrkQH3wnQShoqLrA27Ym14+vPDAd
	8WntSO9d0bJ5Ju4mxTh3nm6hBbZRTXoXzWTiJBvtcGTNWq7YbzQP1By9yVtucc8MFsfwa+
	ZDz+bTknIFfRI3XUdt3tVd+zXcHY0UE=
Date: Tue, 6 Jan 2026 14:51:43 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] scripts/gen-btf.sh: Ensure initial object in
 gen_btf_o is ELF with correct endianness
To: Nathan Chancellor <nathan@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20260106-fix-gen-btf-sh-lto-v2-1-01d3e1c241c4@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260106-fix-gen-btf-sh-lto-v2-1-01d3e1c241c4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/6/26 2:44 PM, Nathan Chancellor wrote:
> After commit 600605853f87 ("scripts/gen-btf.sh: Fix .btf.o generation
> when compiling for RISCV"), there is an error from llvm-objcopy when
> CONFIG_LTO_CLANG is enabled:
> 
>   llvm-objcopy: error: '.tmp_vmlinux1.btf.o': The file was not recognized as a valid object file
>   Failed to generate BTF for vmlinux
> 
> KBUILD_CFLAGS includes CC_FLAGS_LTO, which makes clang emit an LLVM IR
> object, rather than an ELF one as expected by llvm-objcopy.
> 
> Most areas of the kernel deal with this by filtering out CC_FLAGS_LTO
> from KBUILD_CFLAGS for the particular object or directory but this is
> not so easy to do in bash. Just include '-fno-lto' after KBUILD_CFLAGS
> to ensure an ELF object is consistently created as the initial .o file.
> 
> Additionally, while there is no reported or discovered bug yet, the
> absence of KBUILD_CPPFLAGS from this command could result in incorrect
> endianness because KBUILD_CPPFLAGS typically contains '-mbig-endian' and
> '-mlittle-endian' so that biendian toolchains can be used. Include it in
> this ${CC} command to hopefully limit necessary changes to this command
> for the foreseeable future.
> 
> Fixes: 600605853f87 ("scripts/gen-btf.sh: Fix .btf.o generation when compiling for RISCV")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> Changes in v2:
> - Conservatively include KBUILD_CPPFLAGS as well, as it contains
>   endianness flags for some targets.
> - Link to v1: https://patch.msgid.link/20260105-fix-gen-btf-sh-lto-v1-1-18052ea055a9@kernel.org
> ---
>  scripts/gen-btf.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/gen-btf.sh b/scripts/gen-btf.sh
> index d6457661b9b6..be21ccee3487 100755
> --- a/scripts/gen-btf.sh
> +++ b/scripts/gen-btf.sh
> @@ -87,7 +87,7 @@ gen_btf_o()
>  	# SHF_ALLOC because .BTF will be part of the vmlinux image. --strip-all
>  	# deletes all symbols including __start_BTF and __stop_BTF, which will
>  	# be redefined in the linker script.
> -	echo "" | ${CC} ${CLANG_FLAGS} ${KBUILD_CFLAGS} -c -x c -o ${btf_data} -
> +	echo "" | ${CC} ${CLANG_FLAGS} ${KBUILD_CPPFLAGS} ${KBUILD_CFLAGS} -fno-lto -c -x c -o ${btf_data} -

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Thank you!

>  	${OBJCOPY} --add-section .BTF=${ELF_FILE}.BTF \
>  		--set-section-flags .BTF=alloc,readonly ${btf_data}
>  	${OBJCOPY} --only-section=.BTF --strip-all ${btf_data}
> 
> ---
> base-commit: a069190b590e108223cd841a1c2d0bfb92230ecc
> change-id: 20260105-fix-gen-btf-sh-lto-007fe4908070
> 
> Best regards,
> --  
> Nathan Chancellor <nathan@kernel.org>
> 


