Return-Path: <bpf+bounces-53887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F7BA5DE52
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 14:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3761899FB3
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 13:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECED0248861;
	Wed, 12 Mar 2025 13:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ftz5LvY7"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2381DC184
	for <bpf@vger.kernel.org>; Wed, 12 Mar 2025 13:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741787268; cv=none; b=lhLRbd7tZsqbDDtD8yM7kjjiD00OOujA4ZU1spMcanfE7FOb++L3ZTIc8PPZ599WXUpxj602J4Hf4hxmVBdo6+FWhK8xHgQNZDL8rPq7tZ7eKYlRHkoa44hZw18dVPvuHgvgk97xMf/tAj3EYfcqMSgNK0/NCNQ7B8pz2Ae2vtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741787268; c=relaxed/simple;
	bh=6tGSGykodzCAtyZOeHBAPagJyYrkkHqB2fvCc3rQv6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HIN3NyjVJ0L++kn3SbzbQboYbUJVdnmgEhXz1vk91hRtZrvO0YrE7YG20OP60+yXb9rq86qsTT3JRmeUnw1yGz60w+fmUITiSPKYuA4Y7KGHpODy4xTmvsj+vCP7xJeSmBb9TIGdPABIf5fVPjS2zkrzMgM7ED+l0iMKcWQHW2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ftz5LvY7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741787265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OFQMZ93NHY8bxD+VWg+ibXC+CNZRdUJX6/ldMKrpat4=;
	b=Ftz5LvY7otp9WlSLo2cQEuvG3dCYycHkgBFAae1jN7XA79pE7WYzGjk6qPICUvCEKsN9Rj
	Yo4E6t8UV4d+Vglanx7zwBgPnQTxmupYjJz88+wSDajfmHsfYDeUF0h1OhoB9wsksFsI4G
	gb1hUisIGg70zdIG+yR0Jcr3Z6aUv5U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-_LVUsQ-rMzSx7r5tp1rhJQ-1; Wed, 12 Mar 2025 09:47:44 -0400
X-MC-Unique: _LVUsQ-rMzSx7r5tp1rhJQ-1
X-Mimecast-MFC-AGG-ID: _LVUsQ-rMzSx7r5tp1rhJQ_1741787262
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4394c489babso33793735e9.1
        for <bpf@vger.kernel.org>; Wed, 12 Mar 2025 06:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741787261; x=1742392061;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OFQMZ93NHY8bxD+VWg+ibXC+CNZRdUJX6/ldMKrpat4=;
        b=QYaZ27MM5BHnqKSUW3iILsR5cQhPwwTxfVVwAJoOM5to8sg5bfjh7XoPL9ZRG9eXxC
         WprU1YXzFiu/0uBLSm+Ogx9j6VSBGBLK/fM3YjzoEF/EGGYAf/Avpf4d2kNtv2lflZzj
         be+boEBkZISptG0sUQ788/H6S7Tuqc3RiBaN4bnngy6A6+TAkSM0OqhuWD1KSsuws/X/
         c4IntKsPd6ITTbbvsGtHQrVBgzxGS++zJKkeKqi4ZRpRAfv0amaXb+j9b8U0wZn65Xtl
         7BFf6YuuMYxiT6Ssycnn+84EmbqWVVUv9HnHIcBB5arUy3BLOuYJWyIrE4h76T8Nso0e
         9PTg==
X-Gm-Message-State: AOJu0Yy93UBWnnQruT305BBNhEA7GMnYndfjYIWq7EKP8+RdhqbKi0sE
	4V+v475moIdMeFFQrg8c26gWT7ILS619p5WpC3tLzWCSuOhdHPcwczsMbx+B4vKV0xzaXwVgEJL
	DYYc5JAGrZnZGHSLku6NwZ+gqKbT+4BtK11Nv5+A2K8j9Lx3bKiv+xx7H2qUAS7pqRBsEg4prew
	/YxgZTSdapErgOMqKtP63AyLxeps/rNE3S
X-Gm-Gg: ASbGncvuZEOAtGDToNTBm/WsRnX368zhNRCwdJmq3Dx6QOuaITht/QfRsjDakjjUem6
	KWfl6+cET6UihvJ1foWYXJqbej0Y5YwNgxK22MN8+ua13kVJw/u/Qo58A7wdGKOceqnYMJGnbLY
	3H0Ow21P/buqSmyVwE2tieqdT7aYnm3b2rtvQVgC7uGJ+nD8TxAjq+eULs1rI2TUJItND0ktEo+
	ModcWJ1hkifZsde3O+xGohgzHgKFAGqGQ6UK86bOf8kXohBG7k8b/S/8DCS9M+kXGwzZzhBCCMN
	Z9u1lEpdLWLP5J5vEbDw2sE4Mf343H8lVvl4IQ==
X-Received: by 2002:a05:600c:1992:b0:43d:db5:7b1a with SMTP id 5b1f17b1804b1-43d0db57d30mr13891105e9.12.1741787261443;
        Wed, 12 Mar 2025 06:47:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFim1teiRjnYUCj7jAuMBWa8P1fe+F8UirNjsD5dD4ijDHMeVddedYgZL/TK9xDaqnL04jinQ==
X-Received: by 2002:a05:600c:1992:b0:43d:db5:7b1a with SMTP id 5b1f17b1804b1-43d0db57d30mr13890715e9.12.1741787260942;
        Wed, 12 Mar 2025 06:47:40 -0700 (PDT)
Received: from [10.43.17.17] (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba8a9sm21117212f8f.9.2025.03.12.06.47.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 06:47:40 -0700 (PDT)
Message-ID: <f185389d-f911-46a6-9fb7-d949b00deca5@redhat.com>
Date: Wed, 12 Mar 2025 14:47:39 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix string read in strncmp
 benchmark
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
References: <20250312083859.1019635-1-vmalik@redhat.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <20250312083859.1019635-1-vmalik@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/12/25 09:38, Viktor Malik wrote:
> The strncmp benchmark uses the bpf_strncmp helper and a hand-written
> loop to compare two strings. The values of the strings are filled from
> userspace. One of the strings is non-const (in .bss) while the other is
> const (in .rodata) since that is the requirement of bpf_strncmp.
> 
> The problem is that in the hand-written loop, Clang optimizes the reads
> from the const string to always return 0 which breaks the benchmark.
> 
> Mark the const string as volatile to avoid that.
> 
> The effect can be seen on the strncmp-no-helper variant.
> 
> Before this change:
> 
>     # ./bench strncmp-no-helper
>     Setting up benchmark 'strncmp-no-helper'...
>     Benchmark 'strncmp-no-helper' started.
>     Iter   0 (8440.107us): hits    0.000M/s (  0.000M/prod), drops    0.000M/s, total operations    0.000M/s
>     Iter   1 (73909.374us): hits    0.000M/s (  0.000M/prod), drops    0.000M/s, total operations    0.000M/s
>     Iter   2 (-8140.994us): hits    0.000M/s (  0.000M/prod), drops    0.000M/s, total operations    0.000M/s
>     Iter   3 (3094.474us): hits    0.000M/s (  0.000M/prod), drops    0.000M/s, total operations    0.000M/s
>     Iter   4 (-2828.468us): hits    0.000M/s (  0.000M/prod), drops    0.000M/s, total operations    0.000M/s
>     Iter   5 (2635.595us): hits    0.000M/s (  0.000M/prod), drops    0.000M/s, total operations    0.000M/s
>     Iter   6 (-306.478us): hits    0.000M/s (  0.000M/prod), drops    0.000M/s, total operations    0.000M/s
>     Summary: hits    0.000 ± 0.000M/s (  0.000M/prod), drops    0.000 ± 0.000M/s, total operations    0.000 ± 0.000M/s
> 
> After this change:
> 
>     # ./bench strncmp-no-helper
>     Setting up benchmark 'strncmp-no-helper'...
>     Benchmark 'strncmp-no-helper' started.
>     Iter   0 (21180.011us): hits    5.320M/s (  5.320M/prod), drops    0.000M/s, total operations    5.320M/s
>     Iter   1 (-692.499us): hits    5.246M/s (  5.246M/prod), drops    0.000M/s, total operations    5.246M/s
>     Iter   2 (-704.751us): hits    5.332M/s (  5.332M/prod), drops    0.000M/s, total operations    5.332M/s
>     Iter   3 (62057.929us): hits    5.299M/s (  5.299M/prod), drops    0.000M/s, total operations    5.299M/s
>     Iter   4 (-7981.421us): hits    5.303M/s (  5.303M/prod), drops    0.000M/s, total operations    5.303M/s
>     Iter   5 (3500.341us): hits    5.306M/s (  5.306M/prod), drops    0.000M/s, total operations    5.306M/s
>     Iter   6 (-3851.046us): hits    5.264M/s (  5.264M/prod), drops    0.000M/s, total operations    5.264M/s
>     Summary: hits    5.338 ± 0.147M/s (  5.338M/prod), drops    0.000 ± 0.000M/s, total operations    5.338 ± 0.147M/s
> 

Ah, forgot fixes:

Fixes: 9c42652f8be3 ("selftests/bpf: Add benchmark for bpf_strncmp() helper")

> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
>  tools/testing/selftests/bpf/progs/strncmp_bench.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/strncmp_bench.c b/tools/testing/selftests/bpf/progs/strncmp_bench.c
> index 18373a7df76e..92a828a1ebea 100644
> --- a/tools/testing/selftests/bpf/progs/strncmp_bench.c
> +++ b/tools/testing/selftests/bpf/progs/strncmp_bench.c
> @@ -9,7 +9,7 @@
>  
>  /* Will be updated by benchmark before program loading */
>  const volatile unsigned int cmp_str_len = 1;
> -const char target[STRNCMP_STR_SZ];
> +const volatile char target[STRNCMP_STR_SZ];
>  
>  long hits = 0;
>  char str[STRNCMP_STR_SZ];
> @@ -17,7 +17,7 @@ char str[STRNCMP_STR_SZ];
>  char _license[] SEC("license") = "GPL";
>  
>  static __always_inline int local_strncmp(const char *s1, unsigned int sz,
> -					 const char *s2)
> +					 const volatile char *s2)
>  {
>  	int ret = 0;
>  	unsigned int i;
> @@ -43,7 +43,7 @@ int strncmp_no_helper(void *ctx)
>  SEC("tp/syscalls/sys_enter_getpgid")
>  int strncmp_helper(void *ctx)
>  {
> -	if (bpf_strncmp(str, cmp_str_len + 1, target) < 0)
> +	if (bpf_strncmp(str, cmp_str_len + 1, (const char *)target) < 0)
>  		__sync_add_and_fetch(&hits, 1);
>  	return 0;
>  }


