Return-Path: <bpf+bounces-28696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 497978BD49F
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 20:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 043B02836AE
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 18:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC43745D9;
	Mon,  6 May 2024 18:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="etKHlPJi"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D489F374FE
	for <bpf@vger.kernel.org>; Mon,  6 May 2024 18:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715020337; cv=none; b=U2tzuP5Dg8TKTO/1AyjAceM+J1AT6J+aD+HZ7WDYq0XLYgcj8x/gCJN61cWXfYuZrMiXa16Y62ydyHOcUIavSnEcSRauQbJokie1NrR2cDaFnmGz9NStsfFjaGVThy60AFhL4PhgEu8PeYjehIMcKJUE+Q6MpxBBDwN/jIrTGrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715020337; c=relaxed/simple;
	bh=FaLL2keg4Z0TqB4PPBqx3scExC0Pv80VkHjIbBI0yA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VH0GTUYxamsZ00IHa7XFEgl6PLXjLiuQnAu6TVAfzCvuIXpNov+Y2sQjSskvA69PD/h3MTXBoPEZV/sIK4EcArNK/CgecY8fjy0yN57MicsyDFi1gHq/ifoRcAvZKKpAkVfuW+kvZnp7mgxBIREXi3gDImjB6v1FSD8So2pmAcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=etKHlPJi; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a95b1917-80aa-4c81-942d-91f369d31bb2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715020332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GXTewikY/+O4H08LhxPxTlmiouNVrqXA3Y8mBsBraTI=;
	b=etKHlPJiGDCRqyZgInkHUpfMSOVdKcnVXnj8/uiX89il6WBbYAOePK4e1D/HuWlPalpIl7
	FXJroscMQULDs4PBft6rnKLngZCZykpmL4IGXo/HrcvfiToYQZ3fdldECQeo5O8g04iC0g
	gOpPOckzCvYmQAP8OJTkafDKLvzrzFk=
Date: Mon, 6 May 2024 11:32:06 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: disable some `attribute ignored' warnings
 in GCC
Content-Language: en-GB
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org
Cc: david.faust@oracle.com, cupertino.miranda@oracle.com,
 Eduard Zingerman <eddyz87@gmail.com>
References: <20240503123213.5380-1-jose.marchesi@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240503123213.5380-1-jose.marchesi@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 5/3/24 5:32 AM, Jose E. Marchesi wrote:
> This patch modifies selftests/bpf/Makefile to pass -Wno-attributes to
> GCC.  This is because of the following attributes which are ignored:
>
> - btf_decl_tag
> - btf_type_tag
>
>    There are many of these.  At the moment none of these are
>    recognized/handled by gcc-bpf.
>
>    We are aware that btf_decl_tag is necessary for some of the
>    selftest harness to communicate test failure/success.  Support for
>    it is in progress in GCC upstream:
>
>    https://gcc.gnu.org/pipermail/gcc-patches/2024-May/650482.html
>
>    However, the GCC master branch is not yet open, so the series
>    above (currently under review upstream) wont be able to make it
>    there until 14.1 gets released, probably mid next week.

Thanks. It would be great if the patch can be merged soon.

>
>    As for btf_type_tag, more extensive work will be needed in GCC
>    upstream to support it in both BTF and DWARF.  We have a WIP big
>    patch for that, but that is not needed to compile/build the
>    selftests.

Thanks. Eduard has implemented in llvm with agreed new format. Since
the old phabricator becomes readonly, he will upstream the original
patch to llvm-project soon.

>
> - used
>
>    There are SEC macros defined in the selftests as:
>
>    #define SEC(N) __attribute__((section(N),used))
>
>    The SEC macro is used for both functions and global variables.
>    According to the GCC documentation `used' attribute is really only
>    meaningful for functions, and it warns when the attribute is used
>    for other global objects, like for example ctl_array in
>    test_xdp_noinline.c.
>
>    Ignoring this is bening.

Bening -> Benign?

>
> - visibility
>
>    In progs/cpumask_common.h:13 there is:
>
>      #define private(name) SEC(".bss." #name) __hidden __attribute__((aligned(8)))
>      private(MASK) static struct bpf_cpumask __kptr * global_mask;
>
>    The __hidden macro defines to:
>
>    tools/lib/bpf/bpf_helpers.h:#define __hidden __attribute__((visibility("hidden")))
>
>    GCC emits an "attribute ignored" warning because static implies
>    hidden visibility.
>
>    Ignoring this warning is benign.  An alternative would be to make
>    global_mask as non-static.

In the above, let us just remove __hidden from the '#define'.
As you mentioned, the 'global_mask' is already a static variable,
adding '__hidden' is not really needed at all.

>
> - align_value
>
>    In progs/test_cls_redirect.c:127 there is:
>
>    typedef uint8_t *net_ptr __attribute__((align_value(8)));
>
>    GCC warns that it is ignoring this attribute, because it is not
>    implemented by GCC.
>
>    I think ignoring this attribute in GCC is bening, because according

Bening -> Benign?

>    to the clang documentation [1] its purpose seems to be merely
>    declarative and doesn't seem to translate into extra checks at
>    run-time, only to pehaps better optimized code ("runtime behavior is
>    undefined if the pointed memory object is not aligned to the
>    specified alignment").

Yes, the attribute does not really enforce at runtime. It merely
give a declarative requirement.

>
>    [1] https://clang.llvm.org/docs/AttributeReference.html#align-value
>
> Tested in bpf-next master.
>
> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
> Cc: david.faust@oracle.com
> Cc: cupertino.miranda@oracle.com
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> ---
>   tools/testing/selftests/bpf/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index ba28d42b74db..5d9c906bc3cb 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -431,7 +431,7 @@ endef
>   # Build BPF object using GCC
>   define GCC_BPF_BUILD_RULE
>   	$(call msg,GCC-BPF,$(TRUNNER_BINARY),$2)
> -	$(Q)$(BPF_GCC) $3 -O2 -c $1 -o $2
> +	$(Q)$(BPF_GCC) $3 -Wno-attributes -O2 -c $1 -o $2

LGTM with above a few nits.
Acked-by: Yonghong Song <yonghong.song@linux.dev>

>   endef
>   
>   SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c

