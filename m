Return-Path: <bpf+bounces-20859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32588844734
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 19:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C431D1F26A69
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 18:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8170C17BD3;
	Wed, 31 Jan 2024 18:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VA2S/U/t"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE07D37E
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 18:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706726051; cv=none; b=of/uXit/TJzH4oKgXXAx9ADEwzvQT8IfSLfmYKSE3Tb9iGwVNkOGzqaZ76SjZOlRo5yBEYd44KIsTo8pCUoojaqT5YEnxO0/qw/gE3Stk1UZo7Kzp415ONORwhvT5ui901qS3MOUheKbLrCY4sPTnMoRoEJoQon3NHbParWR4kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706726051; c=relaxed/simple;
	bh=Om4Txx+gcGrK5TwrXQH+XXTlxsvK73Ufc+2OUv7ceaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=smEvJ/ITFDQ7spGa18fNhcz9BDvA+DpMfh7Mxy2uZUo+Vjxi1twXf2ssfcBFkKJZ+YA6qlTDFaRsdKMhQ4EDARJuyzIhU/iSD1pYxX124Jco+9LpBm//zLvSJ84PDIU4b5HIoUKl1GbwgY5hE0BAesUWql2NTF+HDIVK/Hb66a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VA2S/U/t; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <aab2e90a-aa65-480f-8f08-186ebe3e81de@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706726045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O20dHPLpf1RJET0X9H/BJ7tmF0EG154LX3Dj8e34uPs=;
	b=VA2S/U/tbB4wAg0pWvF/LRpdWqHlOaLjwdrWbE15tyiDdxIxmiPeR92gTz8V5KrIFKo7s8
	IPdD7vyCfLD3bhAzfaSlyD3I3Hu7svMJ3YdLw4QMQ3bIvGEbfkxzUIl/C/GzkYeuLmbAXf
	u52672Huay+Zbu5Hs1XRoZbT5/WavFk=
Date: Wed, 31 Jan 2024 10:33:57 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next V2] bpf: use -Wno-address-of-packed-member when
 building with GCC
Content-Language: en-GB
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Yonghong Song
 <yhs@meta.com>, Eduard Zingerman <eddyz87@gmail.com>,
 David Faust <david.faust@oracle.com>,
 Cupertino Miranda <cupertino.miranda@oracle.com>
References: <20240131094459.24818-1-jose.marchesi@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240131094459.24818-1-jose.marchesi@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/31/24 1:44 AM, Jose E. Marchesi wrote:
> [Differences from V1:
> - Now pragmas are used in testfiles instead of flags
>    in Makefile.]
>
> GCC implements the -Wno-address-of-packed-member warning, which is
> enabled by -Wall, that warns about taking the address of a packed
> struct field when it can lead to an "unaligned" address.  Clang
> doesn't support this warning.

Look like this is not true.

$ cat t.c
struct __attribute__ ((packed)) Packed {
   char a;
   int b;
   int c;
   char d;
};

void test(const int *i, int *ptr);
int foo() {
   struct Packed p;
   p.c = 1;
   test(&p.c, &p.c);
   return 0;
}
$ /home/yhs/work/llvm-project/llvm/build.16/install/bin/clang --version
clang version 16.0.3 (https://github.com/llvm/llvm-project.git da3cd333bea572fb10470f610a27f22bcb84b08c)
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: /home/yhs/work/llvm-project/llvm/build.16/install/bin
$ /home/yhs/work/llvm-project/llvm/build.16/install/bin/clang --target=bpf -O2 -c t.c
t.c:12:9: warning: taking address of packed member 'c' of class or structure 'Packed' may result in an unaligned pointer value [-Waddress-of-packed-member]
   test(&p.c, &p.c);
         ^~~
t.c:12:15: warning: taking address of packed member 'c' of class or structure 'Packed' may result in an unaligned pointer value [-Waddress-of-packed-member]
   test(&p.c, &p.c);
               ^~~
2 warnings generated.
$ /home/yhs/work/llvm-project/llvm/build.16/install/bin/clang --target=bpf -O2 -c t.c -Wno-address-of-packed-member
$

But each compiler internal diag detection logic could be different, so
it is totally possible that gcc might emit warning while clang does not
like in some selftests mentioned.

>
> This triggers the following errors (-Werror) when building three
> particular BPF selftests with GCC:
>
>    progs/test_cls_redirect.c
>    986 |         if (ipv4_is_fragment((void *)&encap->ip)) {
>    progs/test_cls_redirect_dynptr.c
>    410 |         pkt_ipv4_checksum((void *)&encap_gre->ip);
>    progs/test_cls_redirect.c
>    521 |         pkt_ipv4_checksum((void *)&encap_gre->ip);
>    progs/test_tc_tunnel.c
>     232 |         set_ipv4_csum((void *)&h_outer.ip);
>
> These warnings do not signal any real problem in the tests as far as I
> can see.
>
> This patch adds pragmas to these test files that inhibit the
> -Waddress-of-packed-member if the compiler is not Clang.
>
> Tested in bpf-next master.
> No regressions.
>
> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Yonghong Song <yhs@meta.com>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: David Faust <david.faust@oracle.com>
> Cc: Cupertino Miranda <cupertino.miranda@oracle.com>
> ---
>   tools/testing/selftests/bpf/progs/test_cls_redirect.c        | 4 ++++
>   tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c | 4 ++++
>   tools/testing/selftests/bpf/progs/test_tc_tunnel.c           | 4 ++++
>   3 files changed, 12 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect.c b/tools/testing/selftests/bpf/progs/test_cls_redirect.c
> index 66b304982245..23e950ad84d2 100644
> --- a/tools/testing/selftests/bpf/progs/test_cls_redirect.c
> +++ b/tools/testing/selftests/bpf/progs/test_cls_redirect.c
> @@ -22,6 +22,10 @@
>   
>   #include "test_cls_redirect.h"
>   
> +#if !__clang__
> +#pragma GCC diagnostic ignored "-Waddress-of-packed-member"
> +#endif

So I suggest to remove the above '#if !__clang__' guard.

> +
>   #ifdef SUBPROGS
>   #define INLINING __noinline
>   #else
[...]

