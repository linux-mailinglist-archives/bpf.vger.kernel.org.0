Return-Path: <bpf+bounces-43101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A68379AF40E
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 22:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8A2E1C2188B
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 20:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8CA1F8184;
	Thu, 24 Oct 2024 20:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="K5YaENmF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9155C1DD0F9
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 20:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729802919; cv=none; b=rQpZiXdKTXzfica8mZ2PV6Is3ZWO2y+gdIkodHaNSbYBB9gtxJwOmkhG96GJkXoi+6+OlwBAMmh1AZHBmQjaYryrYKskPuN6pCpCAmELg/MW1ElRpLrgCxbwu3vnxGqwdVchkr+JsvVLHJnjMCjZnSKUQqGm9jfHNsQqor0CL9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729802919; c=relaxed/simple;
	bh=HManR9oWkMekN3fG5gWVzGjndazzQGk5+adWwt70WE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P1lKsCJAGHTKvMflAWDllw3w3UgL4Eq2jNLSK/DzxEuZK3uDQvW/C4XRIwfVCum6pFG6HCRR88IJWk559lOiYMRnRgkYKlkfCqx8G5yw27s1puOsmWmm2/K0fjmPZa0TihavikooQT9Y8PZbU1kWfqaJr1s6RYcxznU9Tp6dZqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=K5YaENmF; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b147a2ff04so97031885a.3
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 13:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729802916; x=1730407716; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xDBMy5+0eyZ2YVU9NBBoNKr7Ah21kLzSXh4wAZgdl/c=;
        b=K5YaENmFxbVjtlugjur/WRKsGRkIUEAiwqqz82LmssLj3Dr9Yt5idImMLZkGqILBOL
         o84Co4xJA1BQm9mML83Pl88df5L2Y44lzCClxko0llxGbS1M+LaCbX4jfANFP+hGS+4U
         4AuP23eRz2d4hOK8KtlFe/1vsLEU0fnwoTtuOetGBXVo6Yy/3VqnZVMi1j/YbDaHn61x
         Z13OoDmc0vbb9iT9WN9gfDAwTxCcZcj3TPftGpP17edJIerMN8CX1sV6Go5WXG1LWgpk
         93/tBPimfW5RksFk43RGdwidIJxW2+YPPhFZHX3fXPa9caZ2IC78/Ue0EWpx6OIvjEjr
         Dx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729802916; x=1730407716;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xDBMy5+0eyZ2YVU9NBBoNKr7Ah21kLzSXh4wAZgdl/c=;
        b=uMgzJ9bsAYEcuRoQSvrmELwUWS1v75BQoBVmxH9tQBFcmJ4XxPKAzzPYkLJJaE6J2B
         O1z8YCRhwf8PrFPqpjbSaftMx4D3mXFc2OJ1usUS4Z2kxquvKxsGbflanOlmsWURkrzI
         qnW1ftgIgwXn0U49RaBVtdfvwV2JN64FJwrN55z2H1r2+LUcHDmmnkxuEdyDLSWN1D/a
         Gm9TNMlm1CtpkehyiL4H1Rm32YD/DnsQRG9dxgPjOOyT3jMq/jFOp97cWXVbU63rLfX6
         lFSdhxwBMrmQYyGviRRz/Ootlpq8phTm4Xj1Yi3Kp5dHmc3ZAbPdjmAQQ9At6KlxrfUv
         cbIw==
X-Forwarded-Encrypted: i=1; AJvYcCWiN4o7kluLsYL2x5mKCZBRJat3NMmnBeiAyM8P+t/TjKonMFlK2siQWyTfBLQv5FCmTp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YynurmqaBKKV3xSZvMLjvehBnp9kZZEHXZQecL4sJNHvKUIpTVz
	KYGmwl0j/2p9YPjaZtmWg42D2s57cz6JeMuj7wMHYirYvkNkSuvr8ZnHylSTD3o=
X-Google-Smtp-Source: AGHT+IFqjiXC6EqeO8fMfN/0fb3mse1JnYo1NmJZprvsNp8opMsBrMNgXz1BVj1iwBMQi46LaS659A==
X-Received: by 2002:a05:6214:418e:b0:6cd:7a2e:4611 with SMTP id 6a1803df08f44-6ce342b9fc0mr104787026d6.47.1729802916446;
        Thu, 24 Oct 2024 13:48:36 -0700 (PDT)
Received: from [10.200.180.69] ([130.44.212.152])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce009dd217sm53630366d6.110.2024.10.24.13.48.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 13:48:35 -0700 (PDT)
Message-ID: <1fbe638a-9502-4b8a-9bc1-6b74ef78482f@bytedance.com>
Date: Thu, 24 Oct 2024 13:48:27 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 0/8] Fixes to bpf_msg_push/pop_data and test_sockmap
To: Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Cc: martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mykolal@fb.com, shuah@kernel.org, jakub@cloudflare.com,
 liujian56@huawei.com, cong.wang@bytedance.com
References: <20241020110345.1468595-1-zijianzhang@bytedance.com>
 <6719c7aede141_1cb2208a6@john.notmuch>
 <fe0ac5b2-f662-4635-92db-081fadb5e375@iogearbox.net>
 <148ce32b-b17e-4612-a30b-baa2c249eeb2@bytedance.com>
 <eef6d5c9-358c-4c94-b0a7-cd04b5f9c34a@iogearbox.net>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <eef6d5c9-358c-4c94-b0a7-cd04b5f9c34a@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/24/24 11:12 AM, Daniel Borkmann wrote:
>> This series depends on my previous fixes to test_sockmap("Two fixes for
>> test_sockmap"), and they were merged to bpf/bpf-next.git (net branch) a
>> week ago. Shall I wait for merging of them to the latest bpf, and then
>> rebase?
> 
> Then this series also needs to be based against bpf-next, net branch (along
> with PATCH bpf-next in $subj) so that the CI can pick it up.
> 
> Thanks,
> Daniel

I tried bpf-next, and found I still could not pass the apply test.
Then, I sent another series with bpf-next/next in $subj, and it also
failed, but the CI is running somehow. Not sure what is the right way to
target bpf-next, net branch?

Apologize for the flood of emails. Could you help me change the state of
the wrong patch series, so that it won't bother others?

Thanks,
Zijian

