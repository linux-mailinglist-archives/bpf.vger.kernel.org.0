Return-Path: <bpf+bounces-32200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5720B909283
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 20:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A7E7B2616B
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 18:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FC219FA96;
	Fri, 14 Jun 2024 18:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZJjjEm4P"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024CF19EED1
	for <bpf@vger.kernel.org>; Fri, 14 Jun 2024 18:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718390854; cv=none; b=NRtLDpNhgWbEvIRNTUY4M7AxXZxbZumnFxNd7frr92+tLGuZUeLApDl+H3DPDcJ/FyLGbUugjTNqXH3TlHjaym4TaZ04zsPtdMAcIHa68Mj5H2yoPO5zs5kXO9y+1cWHsbeWZtq4+yk105BGvdziEueDtUgr1uiIyqyzkH2oO+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718390854; c=relaxed/simple;
	bh=UhMvojSAsVzgdczFuMToeNtcmzG5EXtM+jICfXnbchc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wn4iClfdGzmfJB7+HMJbC6/Tkr0gKCoiKVAnAeZQ8zld/XeC7VpF8KMxkII4LLnC4huLmJlj83lOdOedVOcb+vzg8Squa6IK2pXvf+G7XHLSIU9iURL/JXp/+047PWcFqu48eZMl6vhjXw4+nzc9QgRbhvxIQ8x724oZ8KaY0DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZJjjEm4P; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: tony.ambardar@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718390849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J1j5LuE41r0Wm0nd7SJIAvSnDEO04V6QUnARr9e2yXo=;
	b=ZJjjEm4PMOGrHVXdJnnhVcC572bWDnzNJN8v7GIOXLwEQ7QZ7dL+CvDeIS5iPzky1dAbkE
	pNWZOVAB56YGC6X8YTo1d82hZA+8ZvK6OqnY/yc57qENdqxBUhSatTFB357/ATaOgIE01X
	Ds+R1fwhdLCCCzbkBt/yO1qWW1FKnIk=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: andrii@kernel.org
X-Envelope-To: martin.lau@linux.dev
X-Envelope-To: eddyz87@gmail.com
X-Envelope-To: song@kernel.org
X-Envelope-To: john.fastabend@gmail.com
X-Envelope-To: kpsingh@kernel.org
X-Envelope-To: sdf@google.com
X-Envelope-To: haoluo@google.com
X-Envelope-To: jolsa@kernel.org
X-Envelope-To: ojeda@kernel.org
X-Envelope-To: stable@vger.kernel.org
Message-ID: <f1459b36-fd78-4ac3-8c37-e34222c546bf@linux.dev>
Date: Fri, 14 Jun 2024 11:47:19 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 1/2] compiler_types.h: Define __retain for
 __attribute__((__retain__))
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 stable@vger.kernel.org
References: <cover.1717413886.git.Tony.Ambardar@gmail.com>
 <cover.1717477560.git.Tony.Ambardar@gmail.com>
 <b31bca5a5e6765a0f32cc8c19b1d9cdbfaa822b5.1717477560.git.Tony.Ambardar@gmail.com>
 <7540222d-92e0-47f7-a880-7c4440671740@linux.dev>
 <ZmeEs2eaRe0E1Hk8@kodidev-ubuntu>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ZmeEs2eaRe0E1Hk8@kodidev-ubuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/10/24 3:56 PM, Tony Ambardar wrote:
> On Tue, Jun 04, 2024 at 10:55:39PM -0700, Yonghong Song wrote:
>> On 6/3/24 10:23 PM, Tony Ambardar wrote:
>>> Some code includes the __used macro to prevent functions and data from
>>> being optimized out. This macro implements __attribute__((__used__)), which
>>> operates at the compiler and IR-level, and so still allows a linker to
>>> remove objects intended to be kept.
>>>
>>> Compilers supporting __attribute__((__retain__)) can address this gap by
>>> setting the flag SHF_GNU_RETAIN on the section of a function/variable,
>>> indicating to the linker the object should be retained. This attribute is
>>> available since gcc 11, clang 13, and binutils 2.36.
>>>
>>> Provide a __retain macro implementing __attribute__((__retain__)), whose
>>> first user will be the '__bpf_kfunc' tag.
>>>
>>> Link: https://lore.kernel.org/bpf/ZlmGoT9KiYLZd91S@krava/T/
>>> Cc: stable@vger.kernel.org # v6.6+
>>> Signed-off-by: Tony Ambardar <Tony.Ambardar@gmail.com>
>>> ---
>>>    include/linux/compiler_types.h | 23 +++++++++++++++++++++++
>>>    1 file changed, 23 insertions(+)
>>>
>>> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
>>> index 93600de3800b..f14c275950b5 100644
>>> --- a/include/linux/compiler_types.h
>>> +++ b/include/linux/compiler_types.h
>>> @@ -143,6 +143,29 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
>>>    # define __preserve_most
>>>    #endif
>>> +/*
>>> + * Annotating a function/variable with __retain tells the compiler to place
>>> + * the object in its own section and set the flag SHF_GNU_RETAIN. This flag
>>> + * instructs the linker to retain the object during garbage-cleanup or LTO
>>> + * phases.
>>> + *
>>> + * Note that the __used macro is also used to prevent functions or data
>>> + * being optimized out, but operates at the compiler/IR-level and may still
>>> + * allow unintended removal of objects during linking.
>>> + *
>>> + * Optional: only supported since gcc >= 11, clang >= 13
>>> + *
>>> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-retain-function-attribute
>>> + * clang: https://clang.llvm.org/docs/AttributeReference.html#retain
>>> + */
>>> +#if __has_attribute(__retain__) && \
>>> +	(defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || \
>>> +	 defined(CONFIG_LTO_CLANG))
>> Could you explain why CONFIG_LTO_CLANG is added here?
>> IIUC, the __used macro permits garbage collection at section
>> level, so CLANG_LTO_CLANG without
>> CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
>> shuold not change final section dynamics, right?
> Hi Yonghong,
>
> I included the conditional guard to ensure consistent behaviour between
> __retain and other features forcing split sections. In particular, the same
> guard is used in vmlinux.lds.h to merge split sections where needed. For
> example, using __retain in llvm builds without CONFIG_LTO was failing CI
> tests on kernel-patches/bpf because the kernel didn't boot properly. And in
> further testing, the kernel had no issues loading BPF kfunc modules with
> such split sections, so I left the module (partial) linking scripts alone.

I tried with both bpf and bpf-next tree and I cannot make CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION=y
in .config file. The following are all occurances in Kconfig:

$ egrep -r HAVE_LD_DEAD_CODE_DATA_ELIMINATION
arch/mips/Kconfig:      select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
arch/powerpc/Kconfig:   select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if HAVE_OBJTOOL_MCOUNT && (!ARCH_USING_PATCHABLE_FUNCTION_ENTRY || (!CC_IS_GCC || GCC_VERSION >= 110100))
arch/riscv/Kconfig:     select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if !LD_IS_LLD
init/Kconfig:config HAVE_LD_DEAD_CODE_DATA_ELIMINATION
init/Kconfig:   depends on HAVE_LD_DEAD_CODE_DATA_ELIMINATION

Are there some pending patches to enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
for x86?

I could foce CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION=y with the following hack:
diff --git a/init/Kconfig b/init/Kconfig
index 72404c1f2157..adf8718e2f5b 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1402,7 +1402,7 @@ config CC_OPTIMIZE_FOR_SIZE
  endchoice
  
  config HAVE_LD_DEAD_CODE_DATA_ELIMINATION
-       bool
+       def_bool y
         help
           This requires that the arch annotates or otherwise protects
           its external entry points from being discarded. Linker scripts

But with the above, I cannot boot the kernel.


Did I miss anything?

>
> Maybe I misunderstand you question re: __used?
>
> Thanks,
> Tony
>>> +# define __retain			__attribute__((__retain__))
>>> +#else
>>> +# define __retain
>>> +#endif
>>> +
>>>    /* Compiler specific macros. */
>>>    #ifdef __clang__
>>>    #include <linux/compiler-clang.h>

