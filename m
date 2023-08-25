Return-Path: <bpf+bounces-8722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D0978923F
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 01:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4C9C1C2104F
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 23:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2751AA71;
	Fri, 25 Aug 2023 23:13:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645F9198A5
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 23:13:48 +0000 (UTC)
Received: from out-244.mta1.migadu.com (out-244.mta1.migadu.com [IPv6:2001:41d0:203:375::f4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16082118
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 16:13:46 -0700 (PDT)
Message-ID: <5afada42-8548-1709-26a1-ad68d4c45915@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1693005225; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MPUDqyXIpPWZoUXasA/qa6fv4c9PSgIrXQXFgXkxR1M=;
	b=GEya/nCYWRQggufusLHSzoM7GiAyDCC/vuYzmT5ASj6pdi/BWOJg7rrOXDOIMovTPrkMOJ
	hHhWzxL16NFdU+0pREaSzsyZ8+WH9fB8CF24DKxFPFvXU0MlYPcpak4Ca0UJyB8FGf87PT
	SoMShlUB9A/BpKOt7GDjY8exqUGIKBM=
Date: Fri, 25 Aug 2023 16:13:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v2 06/13] libbpf: Add __percpu_kptr macro
 definition
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20230825195328.92126-1-yonghong.song@linux.dev>
 <20230825195359.94315-1-yonghong.song@linux.dev>
 <CAEf4BzaA6y5sru6y0HK=6u4n+F-tOZ+5TFvBCbiMfRj7Ti-iUw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzaA6y5sru6y0HK=6u4n+F-tOZ+5TFvBCbiMfRj7Ti-iUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/25/23 2:13 PM, Andrii Nakryiko wrote:
> On Fri, Aug 25, 2023 at 12:54 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> Add __percpu_kptr macro definition in bpf_helpers.h.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   tools/lib/bpf/bpf_helpers.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
>> index bbab9ad9dc5a..77ceea575dc7 100644
>> --- a/tools/lib/bpf/bpf_helpers.h
>> +++ b/tools/lib/bpf/bpf_helpers.h
>> @@ -181,6 +181,7 @@ enum libbpf_tristate {
>>   #define __ksym __attribute__((section(".ksyms")))
>>   #define __kptr_untrusted __attribute__((btf_type_tag("kptr_untrusted")))
>>   #define __kptr __attribute__((btf_type_tag("kptr")))
>> +#define __percpu_kptr __attribute__((btf_type_tag("percpu_kptr")))
> 
> total nitpick, but given kptr_untrusted, should this stick to the
> pattern and be __kptr_percpu? It keeps this "kptr" umbrella/namespace
> consistent

Alexei mentioned that __kptr_untrusted might be deprecated in
the future.

I am using __percpu_kptr just feel it is more nature to user
e.g., we use 'percpu ptr' for kernel percpu ptr. But I can change
the name if there is a consensus among community.

> 
>>
>>   #define bpf_ksym_exists(sym) ({                                                                        \
>>          _Static_assert(!__builtin_constant_p(!!sym), #sym " should be marked as __weak");       \
>> --
>> 2.34.1
>>

