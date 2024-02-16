Return-Path: <bpf+bounces-22176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 320DB85856E
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 19:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5E891F25C39
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 18:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A14D135402;
	Fri, 16 Feb 2024 18:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbhnlW2C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609621353EB
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 18:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708108855; cv=none; b=mHfI5njQxpQrX7m7xHxztrVBvp5V7Mj2P9kQhHjgh5Xt8N++4cVYmIQJggGgbO8rwP2GBQLtbqKNYlyYNvNR3QVp9Wy8ShODXnApYZnbudXbTeQK2xwyAG1DVGaa3pIp3Rfu4q55UG/1MuaLD6arRABAb+XOyuSnnXCjAlqQ5c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708108855; c=relaxed/simple;
	bh=np0c3JmLlv6MOGXzDLoy/mCimTreg8f/hDj4eh3scOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YMnR8tD7C1th5W3O/i5ZBCnHvJH8OEbsHTdJPNs0pXA9X61glf3hG/XqpbZCNOx3LtOrxhC7uZtvBzzU6N5S3hRLMCPeatPytrQ9PfZNubnpBIJMNPz5zrkT9lVciD9qvJN7i4MgPGmERxis+J9MW9pDV6FfenNnOJk6LofnSbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbhnlW2C; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-607e54b6cf5so12649537b3.0
        for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 10:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708108853; x=1708713653; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CsslCffcOpkVblCjecb4TuDhGb+S6Wl09xafVHGXqCM=;
        b=MbhnlW2CzHsWN7OAeulwLtvTr4947CcNHqqpWEhZ80xqluyi0beYaf1bIo/ciWo++d
         qoODx0RGxPMHYNVuw/SZ0mqGu7qwg8GPclBZ2leZN51HBiXGimeECvh3m7ghgRYEuxUN
         aY/iU3bO4oWBdk2CS3nKExIqH5ALlEXccZpaKBxXA/gOu30BIn7CMKGYjGBTA+9nb9E7
         JfCTu4Em7Gnbgo0neVqABz1JSgCxkRX1wF+TDgrOAu4BYtqMLEBsGYIqtO/yvizocegg
         Ceu0yQ3MkWbtmcDQ6tyza7adpCK7cyHPq2/MCrk+U6IyEJ1LCTLYKBLIe/s0SOxgy5IT
         5qgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708108853; x=1708713653;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CsslCffcOpkVblCjecb4TuDhGb+S6Wl09xafVHGXqCM=;
        b=bBMJfgT9rOVFh+edCX64MviZobMz/+DixCguaPvfBlTFFrjzkFyXDlvQJ03hnmrark
         dcqk3QJeaqCoagx2EdyPleV1FzglO9cUil1fENkfdZiPB6TlcY/KvI+HLBncrDyym3wk
         aZOdVtKsVK4JGxjr49yWcFXXCiOiWxv4gY6Ama7MIAdSfH6ooyr/IuxRwsBQkKrKYjk4
         +mvotmFIKL0ugf7+LmCm97ANbLGDbeQBOWrH3XPsFpbTI75sV96jh81lFEdIIkkCdop5
         Q5iWCkBkOsH6ohQaifp5Eldsu3w8e5HauqmoUgCNcFw0i7cDZnamUW17p1/ZofU/4ku+
         LTEA==
X-Forwarded-Encrypted: i=1; AJvYcCWn/9QE7Yqbef5xpelj/Z6cLgf3Oz1yaoXaZTn8Q6fPdrZRSOwnTosIhkvB/KsQnGpV6ahTIAlG+6562AhZ/rcXiwXc
X-Gm-Message-State: AOJu0YzD80ZF2SK/SDjMjhCtRQgMIkmv5D9sBZnEw76lKXG2r3iSOLH2
	dr59G6bFhewjmUbpoDgEB4lOnsPjdodKQLFaBiBI+SPIiUeC3jAk
X-Google-Smtp-Source: AGHT+IG81olXk5PxHc7sWPyUP6r2ALmPZgRNp6N0eVfaWXzMsc/X0qNn+xZt4O1/qotVO3EFrV3mdw==
X-Received: by 2002:a81:920f:0:b0:604:de1c:5406 with SMTP id j15-20020a81920f000000b00604de1c5406mr4253894ywg.8.1708108853245;
        Fri, 16 Feb 2024 10:40:53 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:6477:3a7d:9823:f253? ([2600:1700:6cf8:1240:6477:3a7d:9823:f253])
        by smtp.gmail.com with ESMTPSA id e129-20020a0df587000000b00604a2e45cf2sm450852ywf.140.2024.02.16.10.40.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 10:40:52 -0800 (PST)
Message-ID: <6a994e6e-0e83-4242-aeab-94d9f3e5df8b@gmail.com>
Date: Fri, 16 Feb 2024 10:40:51 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 0/2] Check cfi_stubs before registering a
 struct_ops type.
Content-Language: en-US
To: thinker.li@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org
Cc: kuifeng@meta.com
References: <20240216020350.2061373-1-thinker.li@gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20240216020350.2061373-1-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

It fails on CI.
I am fixing it.

On 2/15/24 18:03, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Recently, cfi_stubs were introduced. However, existing struct_ops
> types that are not in the upstream may not be aware of this, resulting
> in kernel crashes. By rejecting struct_ops types that do not provide
> cfi_stubs properly during registration, these crashes can be avoided.
> 
> ---
> Changes from v1:
> 
>   - Check *(void **)(cfi_stubs + moff) to make sure stub functions are
>     provided for every operator.
> 
>   - Add a test case to ensure that struct_ops rejects incomplete
>     cfi_stub.
> 
> v1: https://lore.kernel.org/all/20240215022401.1882010-1-thinker.li@gmail.com/
> 
> Kui-Feng Lee (2):
>    bpf: Check cfi_stubs before registering a struct_ops type.
>    selftests/bpf: Test case for lacking CFI stub functions.
> 
>   kernel/bpf/bpf_struct_ops.c                   | 14 +++
>   tools/testing/selftests/bpf/Makefile          | 10 +-
>   .../selftests/bpf/bpf_test_no_cfi/Makefile    | 19 ++++
>   .../bpf/bpf_test_no_cfi/bpf_test_no_cfi.c     | 93 +++++++++++++++++++
>   .../bpf/prog_tests/test_struct_ops_no_cfi.c   | 31 +++++++
>   tools/testing/selftests/bpf/testing_helpers.c |  4 +-
>   tools/testing/selftests/bpf/testing_helpers.h |  2 +
>   7 files changed, 170 insertions(+), 3 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/bpf_test_no_cfi/Makefile
>   create mode 100644 tools/testing/selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.c
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_no_cfi.c
> 

