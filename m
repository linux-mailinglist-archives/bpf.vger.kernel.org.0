Return-Path: <bpf+bounces-74706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF912C62E04
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 09:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 116874E838C
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 08:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806B830F924;
	Mon, 17 Nov 2025 08:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVnUNzKO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AC41946DF
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 08:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763367451; cv=none; b=rQXEw9FtwDBPzq6PfQVi2sXaeDWh47018bmQKaA6GYpm0gaB7SENzIzwWDT8I+xnbALlyr2Ohj0LSMpimNOrv7gl7uRSwVOlhaG0/8GT4v1+QituqIeRR5IeHFlwFvprNfoKLB28TaXtZ0UlwKIrPsiyXB4+Pym8NpViGTHXFMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763367451; c=relaxed/simple;
	bh=J+bIrP/P+MTdshr4HU8QEyLYBbuvOTac4sl3LzTQ5rY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZ+gBnTVtmOtTGByDNu4HGOWE1g5AYkgce7OAiVq6aPBF+C4bHmBJOLRuxciBShVExW3sCl5ylCcnH0OXhXLQYozTpVDtJzRe56oltsP6dTJWcS99JwVtXaCOifpS+GwPQy8xREoUh1gqRRoim6AZYIiNbBY1dzhWatAs5y/JeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVnUNzKO; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4779d47be12so10622815e9.2
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 00:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763367448; x=1763972248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g0B4WCZs4pgBJlPNp2u+xXO4QoO4aKEo0C86Nh/yo2Q=;
        b=WVnUNzKOq+CyEuIjt5NBpTYUk0BNlwejzt9HhxW6ixM6QdDPy57OgtzwU2w2aArrGh
         W9ZwWaFAwx/OgGsczIOZGY6wRdZO2ATeaVtEbM7H5kOffetmriMKJQ87jMRLFmrc4Qx8
         h/anZ8uawq81L8foleR+ot8O8u3c4gx4R1NL+DqyC/NkWdbdcQP6uPQeYeYxIaFUobs6
         jZvJWGbVaDBiF3O48DdEz3Kw/yGA49Xf2OI/jarQnYQgprKv+ZUTXXee/1Qp1NWshRgr
         PHmh9WgsEkIJwJ98oVz8dATBf/qClGKh57YIpCPKZK8b/Ft/IT9jIhpfQhJXa5hfb4Sa
         Ky2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763367448; x=1763972248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0B4WCZs4pgBJlPNp2u+xXO4QoO4aKEo0C86Nh/yo2Q=;
        b=d4G6njyAJhnrlrgkGYZJIyjqJp2C/bZ5REqZFE8gJPyAnebfo128JcTb7f0h5MgEpv
         a0VBYIOXqNA65XMK10GrYfDu07TPTQupwbAEQ/94qAP21WF7crcVrKKeD4MHTjmq+d1+
         DGX9halkbd68tGu9a3myfRAKGBeH8CrkPJ1oDO2ZjI3h3C1NATKMy1PiNbOnQ3K+4LlM
         rggp1Z18sYg8kAVzmybYGMNau8pg0C9FcQlnmnD+yOeLmwXFa8bW6lNjco7F1+3DsLby
         ZmTUE7ICpN/cKbaGsneEjRiVJoxLJmZhw9DjQ7hUnvWPuVmkwT/egPY2953W0dtYNS+J
         uXcA==
X-Gm-Message-State: AOJu0YxwTlZaTQKSHgrYYfpQrp6yVa3Xn1m8TP5Hj/CJgvGf3EEMfEG9
	Dbtn3GWb6ipwhTN4ECwgQuXeMQU7TjB6szeBcb+hYwJi+ARIE3jsKAxq
X-Gm-Gg: ASbGncuQXQT0sW8795rv00E7Wq81vIMzg/Ci2vhpGGs/5jAa65505O1oUsm390v8LRw
	Of2RX/wlMw7fEAWj2m6/jO4gXzydif+APyxYmwK4WSfogDKTllHZDHhHwCxcOzu1vBPDemXnVom
	h/1YH36JrBaiOLmAiAfUDODoBuzrGWW3BY+oxYpDL+OOx8t6JRiCdQ0zCXVJzzMtD2KliWlSJoD
	8HvQyIejgmv3FEvLCCznXu7kj+SFYrhUgdr6OvtITf1iJipsAeA7MGHxcz77KjUgajbKVIK6nJ8
	8hWUpD5AY4/kPjbbGPFrxVPVucaWFHGwPDwql7bl8w2j6GzvJFyiUTKso8EppUqkr5K4KwUIDhV
	Wa/BDnONrrzB9kmJyiAkeKeyms2IsiRoqyVh6SVnCAAxguhrinzzUklyIUf8KzE+MHsGj5L97E6
	gVXMKn5jB6+w==
X-Google-Smtp-Source: AGHT+IG/aTVzHJkxx9EMuyiJeEnO9rdV/7A6a5ZU9wY/v3CK4BRi+nd6wtNgzWg/gMvwEuXxhjYB8g==
X-Received: by 2002:a05:600c:c4a3:b0:471:13fa:1b84 with SMTP id 5b1f17b1804b1-4778fe5ec01mr112464335e9.12.1763367447583;
        Mon, 17 Nov 2025 00:17:27 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4779a684202sm117274235e9.10.2025.11.17.00.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 00:17:27 -0800 (PST)
Date: Mon, 17 Nov 2025 08:24:24 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 4/4] selftests: bpf: Enable gotox tests from
 arm64
Message-ID: <aRrbuNg8u/Dc0AMC@mail.gmail.com>
References: <20251117004656.33292-1-puranjay@kernel.org>
 <20251117004656.33292-5-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117004656.33292-5-puranjay@kernel.org>

On 25/11/17 12:46AM, Puranjay Mohan wrote:
> arm64 JIT now supports gotox instruction and jumptables, so run tests in
> verifier_gotox.c for arm64.
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  tools/testing/selftests/bpf/progs/verifier_gotox.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/verifier_gotox.c b/tools/testing/selftests/bpf/progs/verifier_gotox.c
> index b6710f134a1d..536c9f3e2170 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_gotox.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c
> @@ -6,7 +6,7 @@
>  #include "bpf_misc.h"
>  #include "../../../include/linux/filter.h"
>  
> -#ifdef __TARGET_ARCH_x86
> +#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)

Great to see this :)

>  #define DEFINE_SIMPLE_JUMP_TABLE_PROG(NAME, SRC_REG, OFF, IMM, OUTCOME)	\
>  									\
> @@ -384,6 +384,6 @@ jt0_%=:								\
>  	: __clobber_all);
>  }
>  
> -#endif /* __TARGET_ARCH_x86 */
> +#endif /* __TARGET_ARCH_x86 || __TARGET_ARCH_arm64 */
>  
>  char _license[] SEC("license") = "GPL";
> -- 
> 2.47.3
> 

Reviewed-by: Anton Protopopov <a.s.protopopov@gmail.com>

