Return-Path: <bpf+bounces-77887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA0ACF5C2C
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 23:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1CED302C4CC
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 22:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F032DEA93;
	Mon,  5 Jan 2026 22:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qKZNEmuc"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ACD56B81
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 22:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767650516; cv=none; b=r3oQQg7uOZhuY4bccYLUBp3zTKGZ7yBljqOqsiJUVRVw6nAv9XYQj4A7Uu319xihyNQ8mh4+kV6CB82MHmxIUlr0pVB2xld3VflkPa0qU/OTxWwqJRqqmMU3DwiABkfASskvnhSxCWfbvzZXWSWcE/QcO5ND7Vc+RMhPI9+Z2Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767650516; c=relaxed/simple;
	bh=pjdGQ2KtPe94IOqq2TsMeOtrdqDybwwb7f6zof5lH4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aUMJG2o75q84uK3FnGfIeXOGAMNkDi00rn6SLvu8D7AzS/pacIhvJiyXrK91rFNG+poWIN0fDmgeqFeVrTbvg/0SnIXMuANoCWkpcAKa9PX0Q5Oex7DMV0TEARkl5xpE3SG8f0g6xEUGdmOLqM2LUVIv7ZsWwwF0LQpDe7772lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qKZNEmuc; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ff8187bd-0bae-4b49-8844-6c975a2e79c6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767650502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OWDr5izXo49pXkOlm+Lks9DAXAhAWAAFj7Ad3Ul3D2o=;
	b=qKZNEmucmlOmieL2UYG+ra6rt6XPtgIkrhrwaR047sfNSE/td34L+DZBkr7Y8OLTqPwAYH
	Nao5OsMbgGqB/8PMTtjgu4w7LPgnPs4GnUzoYruQpWJlvsQd8Xsn6qjaePavToUOiLzmfe
	lqYB07XyW3oPxk90+z+FLS0NJQ+LyNE=
Date: Mon, 5 Jan 2026 14:01:36 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] scripts/gen-btf.sh: Disable LTO when generating
 initial .o file
To: Nathan Chancellor <nathan@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20260105-fix-gen-btf-sh-lto-v1-1-18052ea055a9@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260105-fix-gen-btf-sh-lto-v1-1-18052ea055a9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/5/26 1:12 PM, Nathan Chancellor wrote:
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
> Fixes: 600605853f87 ("scripts/gen-btf.sh: Fix .btf.o generation when compiling for RISCV")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  scripts/gen-btf.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/gen-btf.sh b/scripts/gen-btf.sh
> index d6457661b9b6..08b46b91c04b 100755
> --- a/scripts/gen-btf.sh
> +++ b/scripts/gen-btf.sh
> @@ -87,7 +87,7 @@ gen_btf_o()
>  	# SHF_ALLOC because .BTF will be part of the vmlinux image. --strip-all
>  	# deletes all symbols including __start_BTF and __stop_BTF, which will
>  	# be redefined in the linker script.
> -	echo "" | ${CC} ${CLANG_FLAGS} ${KBUILD_CFLAGS} -c -x c -o ${btf_data} -
> +	echo "" | ${CC} ${CLANG_FLAGS} ${KBUILD_CFLAGS} -fno-lto -c -x c -o ${btf_data} -
>  	${OBJCOPY} --add-section .BTF=${ELF_FILE}.BTF \
>  		--set-section-flags .BTF=alloc,readonly ${btf_data}
>  	${OBJCOPY} --only-section=.BTF --strip-all ${btf_data}

Hi Nathan, thank you for the patch.

I'm starting to think it wasn't a good idea to do

	echo "" | ${CC} ...

here, given the number of associated bugs.

Before gen-btf.sh was introduced, the .btf.o binary was generated with this [1]:

	${OBJCOPY} --only-section=.BTF --set-section-flags .BTF=alloc,readonly \
		--strip-all ${1} "${btf_data}" 2>/dev/null

I changed to ${CC} on the assumption it's a quicker operation than
stripping entire vmlinux. But maybe it's not worth it and we should
change back to --strip-all? wdyt?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/link-vmlinux.sh?h=v6.18#n110

> 
> ---
> base-commit: a069190b590e108223cd841a1c2d0bfb92230ecc
> change-id: 20260105-fix-gen-btf-sh-lto-007fe4908070
> 
> Best regards,
> --  
> Nathan Chancellor <nathan@kernel.org>
> 


