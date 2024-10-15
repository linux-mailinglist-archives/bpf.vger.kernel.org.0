Return-Path: <bpf+bounces-42003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9012E99E39D
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 12:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C2841F23641
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 10:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254651D5AC9;
	Tue, 15 Oct 2024 10:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NSl08NuK"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE881D14FF
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 10:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728987482; cv=none; b=g7U2u3rG4lmEW15Tt6lyCqH2rJiguWqLNz/AgyGrzMmr2RO1FJHwbu8xM35nJ6tdAFcHk5g3CN21Rh4QiHCppQeGX1zzeqN+OHUVmDGicvKy++v7toHJVj01Wy4MHROZzLEPC/qmNY78XWz2FJzpEK2B7IKhVr27aOXV4VI6xLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728987482; c=relaxed/simple;
	bh=bdA1KB+IUuDLkKYjBaXg08SdqCgIeG/17o+iJ+fC120=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lhxskNUwVm6PWqQgBMkLFuB8FqZNfjiCx4S3wxjjYuVmOdi/rLzS+JsDL3bQdakG1twHXq91rwPqu0bmBCzFGj/RluHat/MvcGFhDfI5rHMjl3obTGkPoRSFq/Us1tKzGM66VwvFUBw9zup+SYltig0v6PSgupxtR7pNl780f6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NSl08NuK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728987479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uRZFeFk0HaHVJ/nK2dwPD2a2Aff5qCtCDD2HPY5bW1s=;
	b=NSl08NuKJpsyHQ7OoiCznkUaNV4uMyo/Z98MM5ZmHyBmuLS4GnwRI9HVeK7edfzn4PMxbH
	j3QNRGlidtn3OAeflU87hiCTR8KR0VTnDr3hmrVLiXPK4MECPYSIEn4IIi4TPCv3tvcKGj
	fbzbQl+K5mcRY1pbxWVPJ9JLcKFLbsk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-hnM-Q0n-M2-FX4ez_5bbgg-1; Tue, 15 Oct 2024 06:17:58 -0400
X-MC-Unique: hnM-Q0n-M2-FX4ez_5bbgg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43127097727so18666255e9.0
        for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 03:17:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728987477; x=1729592277;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uRZFeFk0HaHVJ/nK2dwPD2a2Aff5qCtCDD2HPY5bW1s=;
        b=Ch+Y+56jwCwCgqmgNlKWeGA1mEDjbk91srrTPATs8glW3Vv9c6fDk4NlFJwkF8IBaB
         DRR031NySXoVAlBHprgm9ITY7zxP3sFyqUZ6o9gGe8n9xSw45TKdToKV7pnpbS55i5hr
         2JjgKUblDnZEUlk/bOOUbJv97USya3fK6FSrz6y79pfAoMSa+bwWxBzWNQM8s1l2f3aO
         1zPemQcgwEn+tXpxtqt41DuEptGBKnPHQXHNR9RiAnIGy6TfGP0iA0VhaIb0oaZpTKDD
         FTDotY2qqT22Q/MDlyLsaBYB9QHbX11U6gSZfW7P75BHZj2fORpIwyONneazG8/fvfk1
         bF4A==
X-Forwarded-Encrypted: i=1; AJvYcCXmZF+EwS98LQgddfsNIUvYJkuZ2d8Ud1gj27DyenY+HXcV+rw84hnnrO2eZx9nfzWbYgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YybkEHAmKgl41805272Jt8F235qExvzAppkd1jLVa+/+gsMNrBi
	7DIy9n09LgoAzqSqliEPmFLYMTIbVYedA7WWWKyQDmGT/mHq9CBT+Ql95A4HPH2WkZC5NE4QcfQ
	bxVTpThGUDV9XF/fPuf8DdW5avFv1+llbc6MrGmk0azal9rfo
X-Received: by 2002:a05:600c:3b83:b0:426:6710:223c with SMTP id 5b1f17b1804b1-4311ded1fdfmr128625325e9.9.1728987477540;
        Tue, 15 Oct 2024 03:17:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+RR1oQUE3fqyHE44o9XfpYQA+FBcIHCjkuGHKCp3DN5dojze7G4ODUrweFaz/j/iz50CzWA==
X-Received: by 2002:a05:600c:3b83:b0:426:6710:223c with SMTP id 5b1f17b1804b1-4311ded1fdfmr128625025e9.9.1728987476979;
        Tue, 15 Oct 2024 03:17:56 -0700 (PDT)
Received: from [10.202.145.128] (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f6c4cbcsm13233665e9.39.2024.10.15.03.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 03:17:56 -0700 (PDT)
Message-ID: <636a7e45-ddf5-49f1-8013-96c8b6c9ca28@redhat.com>
Date: Tue, 15 Oct 2024 12:17:54 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/3] bpftool: Prevent setting duplicate
 _GNU_SOURCE in Makefile
To: Quentin Monnet <qmo@kernel.org>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
References: <cover.1728975031.git.vmalik@redhat.com>
 <507d699068777b78a5720e617c99fb19a9bb8a89.1728975031.git.vmalik@redhat.com>
 <13c4f2dd-e315-4d0e-9481-b385946c33dc@kernel.org>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <13c4f2dd-e315-4d0e-9481-b385946c33dc@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/15/24 12:03, Quentin Monnet wrote:
> 2024-10-15 08:54 UTC+0200 ~ Viktor Malik <vmalik@redhat.com>
>> When building selftests with CFLAGS set via env variable, the value of
>> CFLAGS is propagated into bpftool Makefile (called from selftests
>> Makefile). This makes the compilation fail as _GNU_SOURCE is defined two
>> times - once from selftests Makefile (by including lib.mk) and once from
>> bpftool Makefile (by calling `llvm-config --cflags`):
>>
>>      $ CFLAGS="" make -C tools/testing/selftests/bpf
>>      [...]
>>      CC      /bpf-next/tools/testing/selftests/bpf/tools/build/bpftool/btf.o
>>      <command-line>: error: "_GNU_SOURCE" redefined [-Werror]
>>      <command-line>: note: this is the location of the previous definition
>>      cc1: all warnings being treated as errors
>>      [...]
>>
>> Let bpftool Makefile check if _GNU_SOURCE is already defined and if so,
>> do not let llvm-config add it again.
>>
>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>> ---
>>   tools/bpf/bpftool/Makefile | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
>> index ba927379eb20..2b5a713d71d8 100644
>> --- a/tools/bpf/bpftool/Makefile
>> +++ b/tools/bpf/bpftool/Makefile
>> @@ -147,7 +147,13 @@ ifeq ($(feature-llvm),1)
>>     # If LLVM is available, use it for JIT disassembly
>>     CFLAGS  += -DHAVE_LLVM_SUPPORT
>>     LLVM_CONFIG_LIB_COMPONENTS := mcdisassembler all-targets
>> -  CFLAGS  += $(shell $(LLVM_CONFIG) --cflags)
>> +  # When bpftool build is called from another Makefile which already sets
>> +  # -D_GNU_SOURCE, do not let llvm-config add it again as it will cause conflict.
> 
> 
> Thanks! Can you please make your comment more explicit and mention the 
> file tools/testing/selftests/lib.mk and/or the use case addressed 
> (building bpftool from selftests), given that you match on the exact 
> string "-D_GNU_SOURCE="? Your check won't skip adding the duplicate 
> definition if someone passes "-D_GNU_SOURCE", without the "=", by 
> calling the Makefile from another path; that's fine, but I don't want 
> users to read the Makefile and expect it to remove the second definition 
> in such a case.

Right, that's a good point, I'll expand the comment.

Thanks!

> 
> 
>> +  ifneq ($(filter -D_GNU_SOURCE=,$(CFLAGS)),)
>> +    CFLAGS += $(filter-out -D_GNU_SOURCE,$(shell $(LLVM_CONFIG) --cflags))
>> +  else
>> +    CFLAGS += $(shell $(LLVM_CONFIG) --cflags)
>> +  endif
> 
> Looks good otherwise:
> 
> Reviewed-by: Quentin Monnet <qmo@kernel.org>
> 


