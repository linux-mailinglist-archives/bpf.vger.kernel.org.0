Return-Path: <bpf+bounces-18885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7298234F2
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 19:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBA271C24224
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 18:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B851CA8F;
	Wed,  3 Jan 2024 18:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ewtxdL48"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBACE1CA85
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 18:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-67f85fe5632so5548386d6.0
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 10:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704307838; x=1704912638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0sp+4Z7esZg8dAno6EaL5qNMmirNN9ujAQ8N5Wo+DTU=;
        b=ewtxdL48wLxxYXE459UuBKZmWgbR49nx9oQMAx7KIg0z71/1kk8jiZJfHfrkzK9CGv
         Px/Xst3hSZIKWK04KjWIh2qHbi1vFOVRku8zxQnU8U39tndr7IL2UrmcW+s7rstT9IBy
         Zsc4fKb1bySxTvxhz7bys6Kj7Kc9d4fyRLh34Tsx88v8zVzUvx/cO82D2v0m+dJ+B3Wj
         PULxuSuWioG/zXqKK1yqyNkiqxilnScSUdTm8akiF2+rmPu215bZH0zNLj2r9tC7oZLo
         YobyrOytID9QgLyWcvXcK2WK5em0awjUbB3hU8L7pf2cDwW5uqr9Ulc/FSlor3kaDMGk
         RkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704307838; x=1704912638;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0sp+4Z7esZg8dAno6EaL5qNMmirNN9ujAQ8N5Wo+DTU=;
        b=uIouwsuPd3jVvzJvGCpdkov+boIZnL23pgBKEyfbXmqcY7fWyiYNHT9r/qDerCOatV
         hsq9P26StQ7OQh/+WtHVQA1+c3DwBFq6czBtf0KLYs7lcK6APLB6E/wOU5CXb6ZjIqLB
         6LpPJnHNFwTqqqqrEwyvtsHd1+Cv7pMvzpBvVeNN35Cjm3veoRPij4Jv6yfweX1oMwWj
         fVMSFq3bbdjcUP4e6VK2BGkul1SbGeZwQcp7Svdu4S8Zll3ZMfDp2k/8XV8waoZ8Fu70
         iMoGUhKyuNHQsqYKeZnLzYY2VH5btgJpLQe1/tBLSq1RPrqy46qXipBYrZMll3jYIAKg
         s8WA==
X-Gm-Message-State: AOJu0YwaI8iwbJYsAQB8cH0EXy/+ER7xt6gWjPx2IsmfPXpqla20EhbW
	cCnIi/TpeU5KAe7eETb60l5mRZcWGYqD
X-Google-Smtp-Source: AGHT+IFhK5HzEBypbiw2Gsi3IVQysSC7aJLPPL5r6iRQGh6gl6E0AW+L11Me4oxE3WyJuEJADNgCnQ==
X-Received: by 2002:a0c:e885:0:b0:67f:9c35:ada3 with SMTP id b5-20020a0ce885000000b0067f9c35ada3mr1804323qvo.59.1704307837704;
        Wed, 03 Jan 2024 10:50:37 -0800 (PST)
Received: from [192.168.1.31] (d-65-175-157-166.nh.cpe.atlanticbb.net. [65.175.157.166])
        by smtp.gmail.com with ESMTPSA id v5-20020a0ced45000000b0067f40a725c3sm11146261qvq.33.2024.01.03.10.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 10:50:37 -0800 (PST)
Message-ID: <1364bc77-bbeb-42d2-96e6-7054507d0320@google.com>
Date: Wed, 3 Jan 2024 13:50:34 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] libbpf: add helpers for mmapping maps
To: John Fastabend <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, mattbobrowski@google.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240103153307.553838-1-brho@google.com>
 <20240103153307.553838-2-brho@google.com>
 <65959200a747b_2384720814@john.notmuch>
From: Barret Rhoden <brho@google.com>
Content-Language: en-US
In-Reply-To: <65959200a747b_2384720814@john.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/3/24 11:57, John Fastabend wrote:
> Should bpf_map__mmap_size just calls bpf_map_mmap_sz with
> the correct sz and max_entries?

will do, thanks!

