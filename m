Return-Path: <bpf+bounces-29858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E28E8C79C8
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 17:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98CA31F22DAA
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 15:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFD614D70C;
	Thu, 16 May 2024 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KygvtkIO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD4814D44D
	for <bpf@vger.kernel.org>; Thu, 16 May 2024 15:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715874611; cv=none; b=RDM2un3ZKo19vt8ayk00ls00W1DUan2+TCmmzUdC6nPTO5zHcijLKzdAjySH82uF7V/P9jupcpI39tu8ddl/zc+ABuev6YJwfP0uWSbGhVE0ouEWwf9+QW883tluoCBr1Q+RT4lx84CjBE2ihFeoFp6tfZpodQacqXCSEMJGuXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715874611; c=relaxed/simple;
	bh=C2S+Wcg1T1bDn7HdR6vfDNd7hPYvGbP2fXOfs5dd6ZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g0OOtrb8t1tqBhdjDGuQAqeQ75s+EnlJVTI7iPkAuHWr1geJ4TC8dXwTRRRTGXU2cNZE4d3+K44fV0EMK8Ryy+BvP61Tscd0k3mzTNaYd4XpF0faOpwElHKYnIvi6RaIJEoI+8NM7v+n53OIIU3ymhku3OR6ygUJcspb0rGQ6ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KygvtkIO; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7e1b88a886fso5549239f.0
        for <bpf@vger.kernel.org>; Thu, 16 May 2024 08:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1715874609; x=1716479409; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P+iK/FVhZ4HUNEOzdTMBxIyNYiEbX2AZzsfqmN9W/BY=;
        b=KygvtkIOUT6biaordQ3w+WUwvxASyMz+pLz1DE35nNfEcMRVZuxGNLdnzw+5wWRTwm
         yyHTTtqgNTEzM6KudcdfQC2/D8IuNtsWcLtH5kaymoUzF2tLZUA8cuP4HP+1v/IULPzU
         083xnHcDCF3WUP/jSfZqSpJT+xHb8fEuCsJtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715874609; x=1716479409;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P+iK/FVhZ4HUNEOzdTMBxIyNYiEbX2AZzsfqmN9W/BY=;
        b=qePO7Hf80kcOoj6Pywio7T4QNMsKUgAv0SLeIrl7/rL+iMSx9OyDpuGFscU7UfayE5
         rWBrWwsd33OydmZJYfejEJBwSQB1EexUIjj02wGnFgXCe3OlGzmoXMmNJA9CH6cGa5U2
         uiZaO/2LfZUiJbZk+WX7Mhtk6dyPGI7Ktmm9mt3cHSuGoSihgHk10Zyt6TOfg9JFsdwm
         yx4CxaVOrwrVZZRbSQXSLmC0bulkBdCndCGQgHq2y9NyvZMKldo9A3vgZqFCSbkvxKfw
         V0jutQoyqBUWs4nnKBfasWJsLW2iW+DXUThpgM3rbaaVcnaTytJesRlEXJEbUPdxrYsC
         NrQA==
X-Forwarded-Encrypted: i=1; AJvYcCWCDuFTS4bLMlPQ6t2SBEcDLe/DQIO1mD6PDggmWjdfdMGKJELzjlnYTyueclJKdft1tcsF1/HmLHXbGWU4rpcgSs+D
X-Gm-Message-State: AOJu0YxFzEWrVlXz3iOZMlQESyhJIl5dLy4Q/CNmvQ+F9YpPrZkjr3bj
	UAyyV/Xu1QUAzrCRd6GtR0U0NkK7zyxyIz03B4hxae7Xd0AaPuR8iTuzFAFA9fI=
X-Google-Smtp-Source: AGHT+IFJbIeUVLI7ISOMfUKtjb3QlrF6+MESxVkubwkrIwTVWoi4y8+3A4qy7lb3Ntw2ajnuWMf8Hw==
X-Received: by 2002:a05:6602:59e:b0:7d9:eeb8:ddeb with SMTP id ca18e2360f4ac-7e1b5202ae8mr1886131739f.2.1715874608958;
        Thu, 16 May 2024 08:50:08 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-489376de185sm4147976173.150.2024.05.16.08.50.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 08:50:08 -0700 (PDT)
Message-ID: <bec3f30e-fc9a-45e2-b6ea-d739b2a2d019@linuxfoundation.org>
Date: Thu, 16 May 2024 09:50:06 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/66] selftests/cgroup: Drop define _GNU_SOURCE
To: Tejun Heo <tj@kernel.org>, Edward Liaw <edliaw@google.com>
Cc: shuah@kernel.org, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Christian Brauner <brauner@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Zefan Li
 <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Muchun Song <muchun.song@linux.dev>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Yosry Ahmed <yosryahmed@google.com>,
 Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@android.com, linux-security-module@vger.kernel.org,
 netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
 bpf@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 Shuah Khan <skhan@linuxfoundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20240510000842.410729-1-edliaw@google.com>
 <20240510000842.410729-9-edliaw@google.com>
 <ZkJHvrwZEqg6RJK5@slm.duckdns.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ZkJHvrwZEqg6RJK5@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/13/24 11:02, Tejun Heo wrote:
> On Fri, May 10, 2024 at 12:06:25AM +0000, Edward Liaw wrote:
>> _GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
>> redefinition warnings.
>>
>> Signed-off-by: Edward Liaw <edliaw@google.com>
> 
> Applied to cgroup/for-6.10.
> 
> Thanks.
> 

Hi Tejun,

Please don't include this in your PR to Linus. This patch series needs
to go together as it is causing several build warns and some errors.

thanks,
-- Shuah

