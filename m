Return-Path: <bpf+bounces-72962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AE9C1E05F
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 02:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FE6F3AB905
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 01:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87B2273810;
	Thu, 30 Oct 2025 01:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f9eLZxr4"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D321D86DC
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 01:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761787706; cv=none; b=WoGczWNFr+jVOr78uE5G1sBDwiZmqOtNzkR1G71jfGTgnG5FUxh+vCUVgCR2ZVOo9kYqfBn0b4VvmJgBiWKQun/q30g30K512t8h1kMQ7BRvL7SLyzpFzuR1n2WoqhtuZjeFXmDXigDkDzZyLBRZBBpGSZxyKsZd1saeGG1R5bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761787706; c=relaxed/simple;
	bh=iL5D8itr/el5KrLESNKEM6VoYGHTBwLtLTjMgngUfi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fUaXvalvpimbiHpsFPdKjALUGh5juXxiXSSYtehmW06J0dzUngvM4HjKmh4tOQ5LShxk6V1aZZQCz3VflNfglMdJcMmd/Ny6yL5Pwyl9NkeCE6V2aTIvkIrjSPyZ0WPRoypEq2pmeK2ZGLUZqAxD3InF7ppK2twvOh8PR+rQbUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f9eLZxr4; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761787701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zXCTy3Y8hBGFqtQpVTXuc6P59/je3/ISdwtaSBuxkHE=;
	b=f9eLZxr4JDJ/WNN5CG4aHbqTlyMp2NvX3VNxMGkU7ygGy/dq5v2D5ZzuqDek1pB8NOitxc
	7uZQgP76tooDnwkhJRJMG2QvVkOZrBxAGqbABTV40a4x3dyXi9Rgvw+ra/PW273XzBm0/o
	7oYVeoxQKo3OMWVgQ440hEnfbjMjaAE=
From: Menglong Dong <menglong.dong@linux.dev>
To: bpf@vger.kernel.org, Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Menglong Dong <menglong8.dong@gmail.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>
Subject:
 Re: [PATCH bpf] bpf: Make migrate_{disable,enable} always inline if in header
 file
Date: Thu, 30 Oct 2025 09:00:47 +0800
Message-ID: <12769486.O9o76ZdvQC@7950hx>
In-Reply-To: <20251029183646.3811774-1-yonghong.song@linux.dev>
References: <20251029183646.3811774-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/10/30 02:36, Yonghong Song wrote:
> With latest bpf/bpf-next tree and latest pahole master, I got the following
> build failure:
> 
>   $ make LLVM=1 -j
>     ...
>     LD      vmlinux.o
>     GEN     .vmlinux.objs
>     ...
>     BTF     .tmp_vmlinux1.btf.o
>     ...
>     AS      .tmp_vmlinux2.kallsyms.o
>     LD      vmlinux.unstripped
>     BTFIDS  vmlinux.unstripped
>   WARN: resolve_btfids: unresolved symbol migrate_enable
>   WARN: resolve_btfids: unresolved symbol migrate_disable
>   make[2]: *** [/home/yhs/work/bpf-next/scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 255
>   make[2]: *** Deleting file 'vmlinux.unstripped'
>   make[1]: *** [/home/yhs/work/bpf-next/Makefile:1242: vmlinux] Error 2
>   make: *** [/home/yhs/work/bpf-next/Makefile:248: __sub-make] Error 2
> 
> In pahole patch [1], if two functions having identical names but different
> addresses, then this function name is considered ambiguous and later on
> this function will not be added to vmlinux/module BTF.
> 
> Commit 378b7708194f ("sched: Make migrate_{en,dis}able() inline") changed
> original global funcitons migrate_{enable,disable} to
>   - in kernel/sched/core.c, migrate_{enable,disable} are global funcitons.
>   - in other places, migrate_{enable,disable} may survive as static functions
>     since they are marked as 'inline' in include/linux/sched.h and the
>     'inline' attribute does not garantee inlining.
> 
> If I build with clang compiler (make LLVM=1 -j) (llvm21 and llvm22), I found
> there are four symbols for migrate_{enable,disable} respectively, three
> static functions and one global function. With the above pahole patch [1],
> migrate_{enable,disable} are not in vmlinux BTF and this will cause
> later resolve_btfids failure.
> 
> Making migrate_{enable,disable} always inline in include/linux/sched.h
> can fix the problem.
> 
>   [1] https://lore.kernel.org/dwarves/79a329ef-9bb3-454e-9135-731f2fd51951@oracle.com/
> 
> Fixes: 378b7708194f ("sched: Make migrate_{en,dis}able() inline")
> Cc: Menglong Dong <menglong8.dong@gmail.com>
> Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  include/linux/sched.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index cbb7340c5866..b469878de25c 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2407,12 +2407,12 @@ static inline void __migrate_enable(void) { }
>   * be defined in kernel/sched/core.c.
>   */
>  #ifndef INSTANTIATE_EXPORTED_MIGRATE_DISABLE
> -static inline void migrate_disable(void)
> +static __always_inline void migrate_disable(void)
>  {
>  	__migrate_disable();
>  }

Thanks for the fixing :)

Acked-by: Menglong Dong <menglong.dong@linux.dev>

>  
> -static inline void migrate_enable(void)
> +static __always_inline void migrate_enable(void)
>  {
>  	__migrate_enable();
>  }
> 





