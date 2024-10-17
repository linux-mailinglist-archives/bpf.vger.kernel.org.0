Return-Path: <bpf+bounces-42274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C1F9A1A78
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 08:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2A6B281BD0
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 06:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D587D15ADA6;
	Thu, 17 Oct 2024 06:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FTh3EjRb"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D54174EFA
	for <bpf@vger.kernel.org>; Thu, 17 Oct 2024 06:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729145289; cv=none; b=qeflarltSoIa9brQ/8KbwP67IYZmhr1+ae/ZFfQkiLw7/n2NVnwemGMRQqg8OBu4Nfhuq1twMaljZIBSKprUx5MO0tz+rIw1Ekmed/6yUF3GnlnHIffhKR80xsHWsOgy+FbuUdKSulMIvQGLxOxHHPpEX1Ha3MWuNXuLAc8yKGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729145289; c=relaxed/simple;
	bh=0l9ywL2mSSIqQ5VTTEHTmomUG2Z4+58aiIU2W0dG+mw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G8Ns6Xb06Xz2nAgucQBIimzbWWV+n+mS0PHWjnBpvZ1imcVwTF4iBMN1LdAKvt4SSvG/AH6BNfw0u+NsjoGLnxPSmhBKV9JMxcsomHAR9GWGJJ0ferJ5pdIiFiX2JLre9VCU2oSh/Q6+AjvzjhYSnr+34Jp6XDFnrXn7fiLfmZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FTh3EjRb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729145286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SMcDlBeVVknQpX1Q2UU7bZYEFTSRp3jjaHAleBRFfRw=;
	b=FTh3EjRbZZtOO5sp0p9ALtS9ccLCs4K0adVJO89FF/x5VV9fuP2fpVFt899JZpL8A7drXh
	oMUxugVK9/LYZw3L4cb7rbfhupCHcKL92d0A9wGCtJqpJJr2PS6BDaV21lVWOtv+WGsivb
	+BudXAec4uLjHKhlwn7Xvl4NjyDRZRw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-kxTa8gG9OYGsB3IZZS2z6g-1; Thu, 17 Oct 2024 02:08:05 -0400
X-MC-Unique: kxTa8gG9OYGsB3IZZS2z6g-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43057c9b32bso4083835e9.0
        for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 23:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729145284; x=1729750084;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SMcDlBeVVknQpX1Q2UU7bZYEFTSRp3jjaHAleBRFfRw=;
        b=pO966lj1hhtUKnflZ2bsOZwtRPaOqpz2QHkNUctj+ybZxwMkDmmeAnQuZL6noou0it
         APtBQnyCiS1LkqFoIETNVeIPlEStCNEqOMUa/FK35XGfGX0uB7TLr7tgt8XZVdyAWdZe
         vlXEAAtsxUjCJZU2V5K4VsmOXKGpO9S7n7c/aRqlRx34v0mg9pynDumV29YeRnCxkAvq
         LejXl0Dz4zf63twycG6Zj9yf9beSNtRKa1Lnh2BIl91L5DpXtWH11cdQEMrYI6Jh0ewL
         bAVi18FjwaKm/cnarTNKFuNOvcNmOXrv3aHlMPrAjBsLmDCIcXax9h0sI9xRRngwRyOd
         QP9g==
X-Gm-Message-State: AOJu0YzBwNfyLjOp+OFRmyEP29yuGUocikb7icSzV9Ud7EIuvauOqYaq
	ylVHJNHfOBa2PoIdAYiDwh89S+r5t5EkFYNLdSoUING9hvCAHIUkOjdOs9ZRzBKMsDK4cCjpfxt
	KIgZkRvmGOTu43BH6CH4EVU2bExyIQjqQwgcZrSRrr0muVtah
X-Received: by 2002:a05:600c:3328:b0:431:5970:806f with SMTP id 5b1f17b1804b1-43159708617mr9097125e9.34.1729145283942;
        Wed, 16 Oct 2024 23:08:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjVgrkMSnfEiBuTUCuuOs+weX14ctE+KZLJBgECpUuaTte1zE2PcaPn216eyLi5LEXr9v0DQ==
X-Received: by 2002:a05:600c:3328:b0:431:5970:806f with SMTP id 5b1f17b1804b1-43159708617mr9096875e9.34.1729145283502;
        Wed, 16 Oct 2024 23:08:03 -0700 (PDT)
Received: from [192.168.0.113] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43158c516b0sm14425565e9.46.2024.10.16.23.08.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 23:08:02 -0700 (PDT)
Message-ID: <e54824cb-06b8-43ed-955b-5077c70cf902@redhat.com>
Date: Thu, 17 Oct 2024 08:08:00 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/3] bpftool: Prevent setting duplicate
 _GNU_SOURCE in Makefile
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
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
 <CAEf4BzYJQMFv=BaB0=foVyAPVazhPreVx7c0PVWK28cLuELbtg@mail.gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <CAEf4BzYJQMFv=BaB0=foVyAPVazhPreVx7c0PVWK28cLuELbtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/16/24 22:34, Andrii Nakryiko wrote:
> On Mon, Oct 14, 2024 at 11:55 PM Viktor Malik <vmalik@redhat.com> wrote:
>>
>> When building selftests with CFLAGS set via env variable, the value of
>> CFLAGS is propagated into bpftool Makefile (called from selftests
>> Makefile). This makes the compilation fail as _GNU_SOURCE is defined two
>> times - once from selftests Makefile (by including lib.mk) and once from
>> bpftool Makefile (by calling `llvm-config --cflags`):
>>
>>     $ CFLAGS="" make -C tools/testing/selftests/bpf
>>     [...]
>>     CC      /bpf-next/tools/testing/selftests/bpf/tools/build/bpftool/btf.o
>>     <command-line>: error: "_GNU_SOURCE" redefined [-Werror]
>>     <command-line>: note: this is the location of the previous definition
>>     cc1: all warnings being treated as errors
>>     [...]
>>
>> Let bpftool Makefile check if _GNU_SOURCE is already defined and if so,
>> do not let llvm-config add it again.
>>
>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>> ---
>>  tools/bpf/bpftool/Makefile | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
>> index ba927379eb20..2b5a713d71d8 100644
>> --- a/tools/bpf/bpftool/Makefile
>> +++ b/tools/bpf/bpftool/Makefile
>> @@ -147,7 +147,13 @@ ifeq ($(feature-llvm),1)
>>    # If LLVM is available, use it for JIT disassembly
>>    CFLAGS  += -DHAVE_LLVM_SUPPORT
>>    LLVM_CONFIG_LIB_COMPONENTS := mcdisassembler all-targets
>> -  CFLAGS  += $(shell $(LLVM_CONFIG) --cflags)
>> +  # When bpftool build is called from another Makefile which already sets
>> +  # -D_GNU_SOURCE, do not let llvm-config add it again as it will cause conflict.
>> +  ifneq ($(filter -D_GNU_SOURCE=,$(CFLAGS)),)
>> +    CFLAGS += $(filter-out -D_GNU_SOURCE,$(shell $(LLVM_CONFIG) --cflags))
> 
> why not always do filter-out and avoid this ugly ifneq?

Because in that case, _GNU_SOURCE would not be defined for some builds
(e.g. plain bpftool build). I'm not entirely sure what the implications
are so I wanted to stay on the safe side. Anyways, I gave it a try and
bpftool builds without _GNU_SOURCE just fine so I think that we can drop
the ifneq.

> 
>> +  else
>> +    CFLAGS += $(shell $(LLVM_CONFIG) --cflags)
>> +  endif
>>    LIBS    += $(shell $(LLVM_CONFIG) --libs $(LLVM_CONFIG_LIB_COMPONENTS))
>>    ifeq ($(shell $(LLVM_CONFIG) --shared-mode),static)
>>      LIBS += $(shell $(LLVM_CONFIG) --system-libs $(LLVM_CONFIG_LIB_COMPONENTS))
>> --
>> 2.47.0
>>
> 


