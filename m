Return-Path: <bpf+bounces-59705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2E2ACED47
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 12:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38DC6167FA5
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 10:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC872139C8;
	Thu,  5 Jun 2025 10:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eoJXXq2f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08393C17;
	Thu,  5 Jun 2025 10:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749117806; cv=none; b=nD8gZ5Y85QB/n2oSRWcuznn1o8XA6GqDAmHPBUivsN27CXafmra0fy36w/Ky0tXoqFn4+BG+bCrRsEQDtVPZ3Qu7fO49y6HtF9hKR7YGxp22FTbQfikSkeuZ2Aepxl74ydrJtjUFPup1gaaY9pS0eOwbVisu6WwbYsWzKcJ03Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749117806; c=relaxed/simple;
	bh=6VdhVIgY4gObSvVw7aopJxkQYQlxGwQ/xj0LUFPBHwY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=W/aaUESkjA2n0Ki526WfjlaCZSQpygilMaHgXbU2lCpRw9q67BQZCAENSK221t0OjC1ewA5wFioY8TvuLRU7rC7xJmHK4a5iwe5AuQY/zcup6FvlHfRDaxvrhFqpMBmKwbwDQWQsS1Z68q7YTMjUEsNu5W71dLKKRYOyXr0rCsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eoJXXq2f; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ad89c32a7b5so128648966b.2;
        Thu, 05 Jun 2025 03:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749117803; x=1749722603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kRhn1TiqH0KT2FFIUh+7ZR8UU9/ld3YwiYBPUh5bTGU=;
        b=eoJXXq2fuXTlv9ktEBMkhGRlCtFrqslM3cEGQb+wgEk4pWCCAWGe0k8/aVnggRp8ha
         zSC1jvzupUdwIG6i+e6npGD96JhGwOhs2/Y+ZypiZsiQe/mfR925SjuTpAFyiceXJ0Am
         QLPKtudUOdwLADyMGFzmiQVe4gBhdK/yGeNeYA7ZnqVmVWgWNj9JampIPfCYBNAFrvyP
         f1hpNTw7dk9DhpdQwRNOmKlnCp6R/6t1qmp9O/cCm5N7GapSwpTgQlKHZHQKrD46xW+v
         ecO2+68tY/MkZqHFyOhRP1ZOwMsgrP43YEM2WT5Lgl4cSrkyT8oPWFW4sxBDfl4MZWV9
         tADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749117803; x=1749722603;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kRhn1TiqH0KT2FFIUh+7ZR8UU9/ld3YwiYBPUh5bTGU=;
        b=kwrztgpEDA32SnfzE58fQlLnghrdqnRLj/6PEe3m5Vj/UwbEnXWmjn7kEJ6sZOVves
         8qYEV9V1vTCTb7J8mKCdtVCvwtEEJ/X9I3AtkEB/jE4z/ogOBlC+0XqH7dk0AiYrVmY/
         iKULGE/WrVqMlXMwRWiab6dZ993tgvT6Dg5uTbIGhIIue6PttWRjARdd2JQA6n5d+6/h
         damRHkoMuhDh7qv1WtYbhWvsXc/P/wDRWulQvTxnVoX+hYtqGKMkRmROzZ3iLo6ELZFQ
         U+mAxYx1AKZklV+4OjF6XJ2exZyMaIGKMnxUvvQDFKYqHDYtYp2F1bSUW6ILW9VAJ3np
         8vug==
X-Forwarded-Encrypted: i=1; AJvYcCUnIvfuqxcivTkW20XzQ9MCkvSSp4QjbbcLARGDHtbXmFsgnkmWjiAW8WAibkJ6tkcmxAM=@vger.kernel.org, AJvYcCVCYLO1pjaLUUuGm/ao6H2Afu7TpKTbLUewkzPNMSVxywq704Tzb0tP8ohx9LA+U/vWJ81by/y4mysNmA==@vger.kernel.org, AJvYcCWJZSwRqM/6ar7ZAq6sLpt9ljukZ3qhwJxaLzMO7c1rSmt+1nUmQwmg08f13j78a0IPj6nsQzov@vger.kernel.org
X-Gm-Message-State: AOJu0YzxlvilmOr7nUm8wat+Qd5wTLO7++DITZORfe1poYJI40stlZwE
	68oYUVyC+cuuaCW0TlQ8SmsLHX4ckBvX/i1/6LCj1Iqi1r8PSbRTr1pJ
X-Gm-Gg: ASbGncvThSt0Oo1bl8RKqq2Ke2xYttGC2Z7CY9kJvCBXaRU47hChcSABQsnFNfpTi9O
	406Acso31wd1DG+Ca7LG3xvByEqtrsouOXUvV7ejHyjtOg4sP60dTIyN24AVL9hCzj1BXj4mI3w
	zJ6ttDDXtGJHZivTdlkb5CBG+M21zg3mQYa4u+RBjrnfj/Og29aCYI5wJF7s1v7j1VOSrx87NWs
	6zZUYOEDRARipmh9tgj8QDSVQ2zdFU3Uwkvy7ORv0PBXMfKl8RTe6eHnRh9Njs7nUtMhAF/Um+l
	fpuHFAsy1sayTrvA+mZiNCHNkPLWspdW/MqehOcwVee4SbdT27YfS8g5SjDrX6Dr
X-Google-Smtp-Source: AGHT+IHiTJhxDSUUJslQqv/uJeFqGqftoei/4qY4933rA/xUChPfZH54s1BwMUBJdoWeD+pCDiWt8Q==
X-Received: by 2002:a17:906:c112:b0:ad2:15c4:e23f with SMTP id a640c23a62f3a-addf8ceab60mr524055766b.13.1749117802492;
        Thu, 05 Jun 2025 03:03:22 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::22f? ([2620:10d:c092:600::1:d66f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada6ad39f08sm1252267366b.144.2025.06.05.03.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 03:03:21 -0700 (PDT)
Message-ID: <d702507f-0c8c-494e-bbed-563c6f731e27@gmail.com>
Date: Thu, 5 Jun 2025 11:04:41 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 01/18] netmem: introduce struct netmem_desc mirroring
 struct page
From: Pavel Begunkov <asml.silence@gmail.com>
To: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, toke@redhat.com, tariqt@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-2-byungchul@sk.com>
 <37376916-6fd0-4a29-ba40-dec512f9796a@gmail.com>
Content-Language: en-US
In-Reply-To: <37376916-6fd0-4a29-ba40-dec512f9796a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/5/25 11:03, Pavel Begunkov wrote:
> On 6/4/25 03:52, Byungchul Park wrote:
>> To simplify struct page, the page pool members of struct page should be
>> moved to other, allowing these members to be removed from struct page.
>>
>> Introduce a network memory descriptor to store the members, struct
>> netmem_desc, and make it union'ed with the existing fields in struct
>> net_iov, allowing to organize the fields of struct net_iov.
> 
> Pavel Begunkov <asml.silence@gmail.com>

Oops, it should be

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov


