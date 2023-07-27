Return-Path: <bpf+bounces-6099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF21D765B50
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 20:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14D8E1C215FF
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 18:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7702917ACF;
	Thu, 27 Jul 2023 18:23:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4420A27127
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 18:23:29 +0000 (UTC)
Received: from out-108.mta0.migadu.com (out-108.mta0.migadu.com [91.218.175.108])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5087526B2
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 11:23:28 -0700 (PDT)
Message-ID: <87f58a7c-2dee-9dcd-156f-edc41bfea38a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690482204; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b60kJCPabQJkT35gIDAP++RJPy/QBXfwHhrngXV1+Vc=;
	b=GBhnp40h4N+JLjjgkG9rLrjy4DKQ8eDs0BN68hfpHZaFaR+Poz24P0kYDbLohuxNntmJNJ
	E8V24Gz7GyY1dlGCsmeZN3qlwJIh+3PeNy2yarxDcxpeMoOpIWrDRZa2QRDf3VXkY5V/AN
	+boFxJEgSkofonb0zzFEv9qyws+IfcU=
Date: Thu, 27 Jul 2023 11:23:21 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH] libbpf: fix warnings "'pad_type' 'pad_bits' 'new_off' may
 be used uninitialized"
Content-Language: en-US
To: Jiri Olsa <olsajiri@gmail.com>,
 Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230727082536.1974154-1-xiangyu.chen@eng.windriver.com>
 <ZMJOl5uLrK9rucXB@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ZMJOl5uLrK9rucXB@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/27/23 4:01 AM, Jiri Olsa wrote:
> On Thu, Jul 27, 2023 at 04:25:36PM +0800, Xiangyu Chen wrote:
>> From: Xiangyu Chen <xiangyu.chen@windriver.com>
>>
>> When turn on the yocto DEBUG_BUILD flag, the build options for gcc would enable maybe-uninitialized,
>> and following warnings would be reported as below:
> 
> curious, what's the gcc version? I can't reproduce that,
> and we already have all warnings enabled:
> 
>    CFLAGS += -Werror -Wall
> 
> they seem like false warnings also, because ARRAY_SIZE(pads)
> will be always > 0

Agree. This definitely a false positive.
In kernel top Makefile, we have

# Enabled with W=2, disabled by default as noisy
ifdef CONFIG_CC_IS_GCC
KBUILD_CFLAGS += -Wno-maybe-uninitialized
endif

That means gcc -maybe-uninitialized is very noisy.

> 
> jirka
> 
>>
>> | btf_dump.c: In function 'btf_dump_emit_bit_padding':
>> | btf_dump.c:916:4: error: 'pad_type' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>> |   916 |    btf_dump_printf(d, "\n%s%s: %d;", pfx(lvl), pad_type,
>> |       |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> |   917 |      in_bitfield ? new_off - cur_off : 0);
>> |       |      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> | btf_dump.c:929:6: error: 'pad_bits' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>> |   929 |   if (bits == pad_bits) {
>> |       |      ^
>> | btf_dump.c:913:28: error: 'new_off' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>> |   913 |       (new_off == next_off && roundup(cur_off, next_align * 8) != new_off) ||
>> |       |       ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> |   HOSTLD  scripts/mod/modpost
>>
>> Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
>> ---
>>   tools/lib/bpf/btf_dump.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
>> index 4d9f30bf7f01..79923c3b8777 100644
>> --- a/tools/lib/bpf/btf_dump.c
>> +++ b/tools/lib/bpf/btf_dump.c
>> @@ -867,8 +867,8 @@ static void btf_dump_emit_bit_padding(const struct btf_dump *d,
>>   	} pads[] = {
>>   		{"long", d->ptr_sz * 8}, {"int", 32}, {"short", 16}, {"char", 8}
>>   	};
>> -	int new_off, pad_bits, bits, i;
>> -	const char *pad_type;
>> +	int new_off = 0, pad_bits = 0, bits, i;
>> +	const char *pad_type = NULL;
>>   
>>   	if (cur_off >= next_off)
>>   		return; /* no gap */
>> -- 
>> 2.34.1
>>
>>
> 

