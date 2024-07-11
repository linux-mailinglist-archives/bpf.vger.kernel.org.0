Return-Path: <bpf+bounces-34569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 966DA92EAE5
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 16:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E031F22C7E
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 14:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C5A16A37C;
	Thu, 11 Jul 2024 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMrZirJ/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F705167DB8
	for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 14:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720708620; cv=none; b=MdXAo1LD9BCAEzbBBNd9bIOhRaPUPass3o7/fi5y6jUZ/dcCm09+OULSN81ELQQLucfc+xywf8wnSDUXUJN3hE9u64xANnZOb/vgvFZsvGYwhkc01D3bzjEEVY3483f0zGV4UYJInUN0X22iLUMULlB0kDvRwKpovQP/Y8nZ1Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720708620; c=relaxed/simple;
	bh=jNU6uP7Tki2NDH0wUWVid/wTZnWHhC1Q4VXui39whTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SAN2wJVhKxlC6ovb6h2xJDZV77IR6Or0tlc2pwxlhQATQYIOYcUOpgBNrbTRBwjN9BsMZJM3fBmIv3BgTesGUGVaunJALP7RWxLARlRry9t2E5WJVB4Xce6y48pHxLfCVGNIucXJWNuF6TycUSPnPZQn01jTtZ2LSz57hJ4OGWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMrZirJ/; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2c7fa0c9a8cso766403a91.1
        for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 07:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720708618; x=1721313418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zEkQl61ru6GDsSu8LYs9ys0LbxKW+sub3YPfMyFz+M8=;
        b=WMrZirJ/szop5bFAgeQ6/9mWS4z3xC0dPgUScK6fJ5D0kbBgQ3l/0kiT6oMoZ8f1Vo
         cZOiQyPuWhc6Sf8QEFy5nVwCIcQL1fTz7BkZj/H6KkS+RLa/x7Bf3MLFt/fqlx2fmqlf
         Rm98Fw3KJa4h++K7KzJI+fckPj/2ealYjPLsoxpdqdp0vxIwV/lOKtNSJgUcVZebqXEZ
         oi+bIALLHMBX6jST/lhbzbYZ5jyvqvo3roOQkXVo10KJITgZpI0m4lxXY0lcAyxwO21Q
         M9ei8l3rfRmYK53ggvC667Z4anCPzM1BevvN5mSMdxDx1PUzuEnn9lUPyGOYIPuTUotM
         tOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720708618; x=1721313418;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zEkQl61ru6GDsSu8LYs9ys0LbxKW+sub3YPfMyFz+M8=;
        b=rbv+4i0ce/BbmD53INwTgAG1TaqFcmMZ2+8Ni1qbXO0L9SNe50tauMiEkFvdmvqoXt
         Xb5IkpqJ5PWDIg/FySSp+tXQSRN08PGn1bqDTschxCbEIOFmWFnDclBNYqm+bcvXWfCA
         KBDpJks01rxPLMDERF/69Bm4P52gk3X4B6pSOZQXGXEQVa9S0iBa/AvBED+nc7vCP+NW
         Fzy+VN4FYewCPbM/2Eu4PtOqqsMUmBJ1gktoc/QgDtobeFg+B9eNpsMltvS33CLboI6S
         ov8zoA5dJyHDFppHoxeIkES69iIPoN8eF72kuXGDUa1X3I7qpFJpEhJ89qSjSbWBNPUc
         CYBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzJ5HesffdAi/0AKbxFE6LxpT6YGgCl65TXRUAwxMCQn4o8j3iGOgPgGuR/el4hND8uUrAW+3mDMv9Es4AfKx1vDBF
X-Gm-Message-State: AOJu0YyLOpZpvtNAMKC7cZg/bhU5+efkaPhRR7oOwPZTiYzOZw08TmJO
	m7Cme5QQUcO5uOuwj3BicugdJhpKF39Zvyw8qFL1ZuzVRF1pBkyy
X-Google-Smtp-Source: AGHT+IGaZB9Igz9IYb+D3G+OrMBa/jeZTKkKMRhGrnmPqqO6JtnwqdTA/1N+uvmQYlhhiSwdGpN5yA==
X-Received: by 2002:a17:90b:1090:b0:2c9:7e98:a4b8 with SMTP id 98e67ed59e1d1-2ca35c71f09mr6440613a91.24.1720708618388;
        Thu, 11 Jul 2024 07:36:58 -0700 (PDT)
Received: from [192.168.1.76] (bb219-74-23-111.singnet.com.sg. [219.74.23.111])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a93e499sm14042884a91.2.2024.07.11.07.36.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 07:36:57 -0700 (PDT)
Message-ID: <a18c5f22-7105-4f58-ab88-d03a5d750d39@gmail.com>
Date: Thu, 11 Jul 2024 22:36:50 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 bpf-next 3/3] selftests/bpf: Add testcases for tailcall
 hierarchy fixing
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 maciej.fijalkowski@intel.com, puranjay@kernel.org, jakub@cloudflare.com,
 pulehui@huawei.com, kernel-patches-bot@fb.com
References: <20240623161528.68946-1-hffilwlqm@gmail.com>
 <20240623161528.68946-4-hffilwlqm@gmail.com>
 <5665eb1f4217948a3a06b6898762abf719f141cd.camel@gmail.com>
Content-Language: en-US
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <5665eb1f4217948a3a06b6898762abf719f141cd.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/7/11 10:01, Eduard Zingerman wrote:
> On Mon, 2024-06-24 at 00:15 +0800, Leon Hwang wrote:
>> Add some test cases to confirm the tailcall hierarchy issue has been fixed.
>>
>> On x64, the selftests result is:
>>
>> cd tools/testing/selftests/bpf && ./test_progs -t tailcalls
>> 327/18  tailcalls/tailcall_bpf2bpf_hierarchy_1:OK
>> 327/19  tailcalls/tailcall_bpf2bpf_hierarchy_fentry:OK
>> 327/20  tailcalls/tailcall_bpf2bpf_hierarchy_fexit:OK
>> 327/21  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_fexit:OK
>> 327/22  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_entry:OK
>> 327/23  tailcalls/tailcall_bpf2bpf_hierarchy_2:OK
>> 327/24  tailcalls/tailcall_bpf2bpf_hierarchy_3:OK
>> 327     tailcalls:OK
>> Summary: 1/24 PASSED, 0 SKIPPED, 0 FAILED
>>
>> On arm64, the selftests result is:
>>
>> cd tools/testing/selftests/bpf && ./test_progs -t tailcalls
>> 327/18  tailcalls/tailcall_bpf2bpf_hierarchy_1:OK
>> 327/19  tailcalls/tailcall_bpf2bpf_hierarchy_fentry:OK
>> 327/20  tailcalls/tailcall_bpf2bpf_hierarchy_fexit:OK
>> 327/21  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_fexit:OK
>> 327/22  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_entry:OK
>> 327/23  tailcalls/tailcall_bpf2bpf_hierarchy_2:OK
>> 327/24  tailcalls/tailcall_bpf2bpf_hierarchy_3:OK
>> 327     tailcalls:OK
>> Summary: 1/24 PASSED, 0 SKIPPED, 0 FAILED
>>
>> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
>> ---
> 
> Nitpick:
> I think that test cases *_hierarchy_{2,3} could be rewritten as
> example by this link:
> https://gist.github.com/eddyz87/af9b50d0ff3802b43f0e148591790017
> It uses test_loader.c machinery, you can use RUN_TESTS macro from any
> prog_tests/*.c file to run test cases from a specific binary file.

It seems great to me. Thank you for your example.

Thanks,
Leon

> 
> Otherwise these test cases look good to me.
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> 
> [...]

