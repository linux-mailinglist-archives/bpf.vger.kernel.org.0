Return-Path: <bpf+bounces-13722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E6E7DD117
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 17:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 577B2281813
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 16:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F2D200C8;
	Tue, 31 Oct 2023 16:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntX1teUK"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D9E1E52F;
	Tue, 31 Oct 2023 16:00:55 +0000 (UTC)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F80C8F;
	Tue, 31 Oct 2023 09:00:53 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5a8ee23f043so56003877b3.3;
        Tue, 31 Oct 2023 09:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698768053; x=1699372853; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tuh8lobn4dw14kkRl42qTBsxM0jfE9mEKdvfz/qg/Hk=;
        b=ntX1teUKeQ2lrxZVlO/bRCvTYlvX13nKyxaJlD/zxPk90l6JgSpfpskGJo09U0qZaq
         yPblxLEm00JVzYy3OKekprHXEWxJoL4vbAXQjhBzFtkmviFXvyAsEJKUQms6Mc17zPNu
         obpeBL07e8T5hQdOxIpgHuibxEOxeWgHcV3PxW8kJgcee24dvgxYj0y4pqUjl2Li1+9u
         Of7yut482cW0oQDCY7cQRrRn3q2uprj7iGLJw6I/TZ+NiaVpSE5eA+xb/UfbyYPARcJc
         72EiqAOu9DhwUOYLtvf0in7sV0L4DMpD6jr9B9yNfAlVlG5H2qmRYZh6Y0tzmgfXqGZC
         CxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698768053; x=1699372853;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tuh8lobn4dw14kkRl42qTBsxM0jfE9mEKdvfz/qg/Hk=;
        b=c0SHjSccf5/lKeR6YFtKezTgbg+pikXdavsEcKs4ih9cwTMDT7vpNiwvwbkcz9u1bP
         tKpO8j666M+YJ7rQT6p0NRe4PbCqd9NmZh4bG0+jUpF3Ytp83UUdGuJ80h6PgUhgZCX7
         1imBwkAQSqIfnInK3dGtTkOU4mIaEdZfFENXpVLTIZNORr0Q1Z5khKqz+AO1yLl+E6ig
         ORv2CJainBnncP9MWu4DsVUUgZL/ub7VmaZJS+v6iDwjQwkjYEObeiKLsayrukPMJns5
         ie1cSzImV/2yZAMnN3xQMo9yM2POMLocPpffOJAFn97fwbw6ZVux39opQzma7/MYA9ns
         WMaA==
X-Gm-Message-State: AOJu0YwoU0UxeukeB24APraYabYh8GwMsY2mtgHxyTLYHIkXDa0M63QO
	fRtEkA3fJw3JjsEvzBSv5TU=
X-Google-Smtp-Source: AGHT+IGEY4R4/oysytP5UjACH8+KiBQMWlNqSqVk4RX/8c6fB7vVUScjQ9lndKDNNpBzeBlKpfzjgQ==
X-Received: by 2002:a25:d888:0:b0:d81:97c:c016 with SMTP id p130-20020a25d888000000b00d81097cc016mr11738783ybg.15.1698768052816;
        Tue, 31 Oct 2023 09:00:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:ac50:f3c6:2a0c:d29? ([2600:1700:6cf8:1240:ac50:f3c6:2a0c:d29])
        by smtp.gmail.com with ESMTPSA id f13-20020a25b08d000000b00da06fc45421sm949229ybj.54.2023.10.31.09.00.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 09:00:52 -0700 (PDT)
Message-ID: <01c4a7d7-c162-4a3d-887c-398db295fa34@gmail.com>
Date: Tue, 31 Oct 2023 09:00:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 02/10] bpf, net: introduce
 bpf_struct_ops_desc.
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com,
 bpf@vger.kernel.org, ast@kernel.org, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org, drosen@google.com
Cc: kuifeng@meta.com, netdev@vger.kernel.org
References: <20231030192810.382942-1-thinker.li@gmail.com>
 <20231030192810.382942-3-thinker.li@gmail.com>
 <bb7bbfa2-94b1-041d-7255-bb8c7e56e6c7@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <bb7bbfa2-94b1-041d-7255-bb8c7e56e6c7@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/30/23 23:40, Martin KaFai Lau wrote:
> 
> nit. I think this should be renamed to bpf_

Sure! It looks better.

