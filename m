Return-Path: <bpf+bounces-40386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26910987F47
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 09:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B14BF1F22D8C
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 07:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F444184546;
	Fri, 27 Sep 2024 07:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CM9/xFHO"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8DF165EED
	for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 07:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727421641; cv=none; b=AYWpRyidncyQ4BbFr/3kmLrimaxDm5oUvToYUPswIw1VdI45WrGriYR2zjUrle9cTafETNw+CNxdbt+xvH/KwCpyKIWGKBt5xMWOsPy8ow49RRFmBCgB7C4HUMRDuJNnNT1Kr+oZXasFuTrA/v0r5hjsGcfGjcqbyo/1WBmahsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727421641; c=relaxed/simple;
	bh=A82VXPQlwwyWnVcVamSsyuS6KR8L6TBqczr+M/sGebI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jnoXNLchI20iOAgU8z3c4p5PPGXirHC6CKOltxZokD1LNPn94eruRUpdnWBXFmaOKHSqUL/lEiMZUuD89swPzcStvDHqlo4CPTVO3LR7j3yz9EZgM9X+n56/gAgtYNptJK43ESjtN8oeH+4PDFuf7UPyTjrdjm14UOT41mBiqr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CM9/xFHO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727421638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lXc3GvQT8efa5Z65LW80Ygqlsgw/TcxXxsYCOan4vgI=;
	b=CM9/xFHOTQI6JdKVu2t65Bfio8hXe3EQ/1bkjt1/30kYeCzb4s5Jqs9tSGNf8q3cCTAYZi
	ZewuX0Dn2jJHjLiYd0umAOs4ElwMKdqzGnkN5HSazKBjzxoPCi66eteMysAuw0UlJUQ6iI
	OOp8rcM6GXPC/EDortWFsxhuYlYcQSo=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-yHmQdJNEPweJv5rps1jHIA-1; Fri, 27 Sep 2024 03:20:36 -0400
X-MC-Unique: yHmQdJNEPweJv5rps1jHIA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-53897f0d1a4so1380231e87.3
        for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 00:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727421635; x=1728026435;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lXc3GvQT8efa5Z65LW80Ygqlsgw/TcxXxsYCOan4vgI=;
        b=pYdk8l2ae0oPkbEAOO8pNZ4Tp7iNemjqf40p1Y09lZaac4Zc4bp3xarNS3JovNjShh
         9RcQ6hBULVMRkGbNy0dvIQ9zpWjLJViacnkRrBzVzxznXK9fNEEK7vnL5XHhViSptkJj
         DNu33m6R+bUrIzDr07CJGmQVXkkdfPhhhqa/VZmM4ur52hPPUTIVCx9H9fB162CtOCCV
         Pm5y/WAOahapefRAoEnAYKsW9Ofu/r1U2yfRdeosEsvemA3WhxTQckVNK5GNv9gPRkf7
         CpJa6dcD7YeQU2VxVbjO3RLoRnbmY/wYzsPJUGo+RmBbuCk0x1EhZO6eyS10UXyRYhEG
         bB0A==
X-Forwarded-Encrypted: i=1; AJvYcCUi2H7tGYGRdTFJCxx5zt7skQXvtQf5Sfvd8A2d2e3BmY6Lgo0Ka1sOcT5wxM2fbDezna0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZnUpNCXLU9V1jPOun67AWD8lGDCvAM0Jx5KKoqFSDB9i58SVg
	vbjzqnCiXiq4945A6LA2byyjmwlg3P6QraJ+LlyLLdDsyiCrYr+bLmesqzYMF1wjQ82yf6bVjMG
	j/uIEyJUQ//meiRp5hycfGkFfftdbB2Y6unvwnMvOj424LVLFBGyFVKzRjKg=
X-Received: by 2002:a05:6512:3a8f:b0:52c:8aa6:4e9d with SMTP id 2adb3069b0e04-5389fc44dafmr1554707e87.29.1727421634793;
        Fri, 27 Sep 2024 00:20:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkljuiUqe0sWSrGhUrLD8rzyWnWLQ7ZPhWlz8K+xtptZpYnoPhl/5UvIp4qMEGr/JnCJxj5g==
X-Received: by 2002:a05:6512:3a8f:b0:52c:8aa6:4e9d with SMTP id 2adb3069b0e04-5389fc44dafmr1554688e87.29.1727421634360;
        Fri, 27 Sep 2024 00:20:34 -0700 (PDT)
Received: from [192.168.0.113] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c882405692sm792413a12.10.2024.09.27.00.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 00:20:33 -0700 (PDT)
Message-ID: <bfb5ff37-863c-4f1c-a60d-245982ec37ef@redhat.com>
Date: Fri, 27 Sep 2024 09:20:32 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add tests for string
 kfuncs
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
References: <cover.1727335530.git.vmalik@redhat.com>
 <34e1a69f9e45fc8e4373d04f5543a1ffa32981fd.1727335530.git.vmalik@redhat.com>
 <731080a35952545500de577329e16cdd75fe787e.camel@gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <731080a35952545500de577329e16cdd75fe787e.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/27/24 03:57, Eduard Zingerman wrote:
> On Thu, 2024-09-26 at 09:29 +0200, Viktor Malik wrote:
>> The tests attach to `raw_tp/bpf_testmod_test_write_bare` triggerred by
>> `trigger_module_test_write` which writes the string "aaa..." of the
>> given size.
>>
>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>> ---
> 
> I thought about making these tests more terse as follows:
> 
> --- 8< ----------------------------------
> 
> // SPDX-License-Identifier: GPL-2.0
> 
> #include <linux/bpf.h>
> #include <bpf/bpf_helpers.h>
> #include "bpf_misc.h"
> 
> int bpf_strcmp(const char *cs, const char *ct) __ksym;
> char *bpf_strchr(const char *s, int c) __ksym;
> 
> static char *abc = "abc";
> 
> #define __test(retval) SEC("raw_tp") __success __retval(retval)
> 
> __test(2) int test_strcmp(void *ctx) { return bpf_strcmp(abc, "abd"); }
> __test(1) int test_strchr(void *ctx) { return bpf_strchr(abc, 'b') - abc; }
> 
> char _license[] SEC("license") = "GPL";
> 
> ---------------------------------- >8 ---
> 
> (plus registration in tools/testing/selftests/bpf/prog_tests/verifier.c)
> 
> However, this does not pass verification with the following error:
> 
>     VERIFIER LOG:
>     =============
>     arg#0 reference type('UNKNOWN ') size cannot be determined: -22
>     0: R1=ctx() R10=fp0
>     ; __test(2) int test_strcmp(void *ctx) { return bpf_strcmp(abc, "abd"); } @ verifier_str.c:15
>     0: (18) r1 = 0xffff8881019533dc       ; R1_w=map_value(map=.rodata.str1.1,ks=4,vs=8,off=4)
>     2: (18) r2 = 0xffff8881019533d8       ; R2_w=map_value(map=.rodata.str1.1,ks=4,vs=8)
>     4: (85) call bpf_strcmp#64714
>     write into map forbidden, value_size=8 off=4 size=1
>     processed 3 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
>     =============
>     #503/1   verifier_str/test_strcmp:FAIL
> 
> Note that each string literal in the BPF program is in fact a pointer
> to a read-only map. Hence in current form these new functions are not
> very ergonomic. I think verifier should be extended to check 'const'
> qualifiers for the kfuncs and allowing access in such cases.

Yeah, I noticed the same problem when I was trying to come with shorter
tests. Teaching verifier to allow passing pointers to read-only maps to
these kfuncs is certainly a good thing, I'll have a look into it.

On the other hand, bpftrace stores string literals on stack so these
kfuncs would be useful to us straight away.

Viktor

> 
> [...]
> 


