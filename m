Return-Path: <bpf+bounces-59719-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F61AACEDF0
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 12:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13C213AC6D6
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 10:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DF9217F55;
	Thu,  5 Jun 2025 10:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0xI634D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A03D216E1B;
	Thu,  5 Jun 2025 10:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749120279; cv=none; b=SJpeE5q45xZQ9c1lMjayJxXJ+LCeqDfyoUWYWJQIf4u5uvDCSs/+UGj9GQ2gxFJdnfbDftHlj1PaQ3R22rwEFR8NzVdn/kjIQVqacwJSFf/gJKXoI8HcU26RIyvGv1D8u+93hIpEL/gWp6BuIceFmiwDSfqVtK1F43fw3aJ/R9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749120279; c=relaxed/simple;
	bh=by1AkYL87Pi+fiVN1giz5RnLQJTTmp6OBMIWVKLOnvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W95/3sLQMUBa4NzWzd4HLxiA5AyEJt3xEAkGZXxDhfr6gads46GAkT9tDDkbaZVfaXiWDdQ0ZAP/Pk2bOyNLdOh4nrTC3rWHnXDcBAVz8gK34MaxW6TBgxvO6O7MFY46uUfJ04aDtK/Uayrj5E0HhxMN8zKwdm4lcgHZBkTZxNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0xI634D; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-601dfef6a8dso1476116a12.1;
        Thu, 05 Jun 2025 03:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749120276; x=1749725076; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F7FTGxaBrcdmW1IQa2oQBHmxtbU4ciUz1wN4deKFVz0=;
        b=H0xI634DMSaUMIQ7dD3wDFZm5yiyPQqgFrTbnN5XsVHlYrKLp0Ix8iHm6tDQq2GLXE
         ozubwZh7E+pZAhk3w1RK/U1tToyc8E4aUiHSPNE8du6wNERRqsOmJH+GGbUiEAtrLwdi
         gwMkjv/bUtKrbyS49U0/zO/6zAvUrNGTF6KwCNqNGeqFHMSAKafcpzP//7Z1odZD/iPo
         n5Yko3qfytqzVpYEIYR9fRqYblZBxoaE4g7J4bz9kBPLI4BndRDz8KlporEdGwRj6nOe
         eu3/1Lh1ni7FA7tEUYki3MyHGtQxLHK3a69jLZSBDdnlBb9o+9N7U2PC7YxMr+FapU7C
         tJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749120276; x=1749725076;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F7FTGxaBrcdmW1IQa2oQBHmxtbU4ciUz1wN4deKFVz0=;
        b=eKpvFF2wKIXc/xJmESJnn1Kw+3LnzMqKQr8H8RU6GGHZvVTcLXHZNbDjAvNO8mv7lk
         F0Rpxqqn1+Wej5w+MV7W5VDCNghy5jRKZVqs+/X8AT7VmouN9fSDr9x7ImDz9srow1/E
         1LBwaR8fM2HYRCz9XXSqlK2uuAhwWOQCD4Qq3dHQk59c+WFek/eixcfILVco6jyNNqu7
         tgZ5URZFOrVpUq0Lph3BHwKdnMDA20dPwTwZd5QkWqFnvOngPomutAk6lTwpSfX26gm8
         ZS7sobZC5QeBriyoV9AefD6QQ5vh/l37cFFvlvp1Gga08sojznBzMR5ZToCqa3MiMWd4
         CvnQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3Nelnsqzc8RWQXUaTbS4hd/OP3IboWgi+qajNbHqYcxMXtjqoTgm+PFwNOvJI+lRGybG13dfB7ihI9Q==@vger.kernel.org, AJvYcCVxI452Zja76eg4pwL+ti3W92++4f19MyyZF7xV6AXFykRPgR2t8OGaJkETk5xOyGWn8Iw=@vger.kernel.org, AJvYcCXVBYM0kqnEpnehYIQUO0+aGi+UEXUtuC/vjVcMV7V/TV6i9drSLQZS0uF6Rw78KVfHzrMDZKKd@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+6wt2ysLdllYQp//gJVj5WsvW8Mi4mjCPgZs7wzPMMN/4HeFU
	bUpa1F7S7aWf7pNlntJ83O1J8QypJhEavazE0UmXjvyhiMZwt+ii5EXG
X-Gm-Gg: ASbGncvGj162Nm+C6w7bTvdGQ2avmWOYoQ6nydoveV1ZZnv1Vz12y8fbhlhQWn6gwZd
	sUWenxGL9gzqpciUOBHDIpjasW/MoGN7r0LOJDjMxDY9b/kLMiHBP1rsqNJKHnbjjY5jGjMt05d
	1NEiAPOdGHwk7v4aOO6IxKmrUiRF2HKfWLsA5tE26t3o2Bb6VRLGqzAQMH4cvhpK8Wt82/ixFHW
	sbjn2LTog3/zpkO+e9P2z7mTnJYBd7Y/1eUyh4FhXat+gG85/7N3QqOx8ZejUJid5ivqqbUUlE8
	rX3EGi1VgMnLiFpOLteeDH3coyl/Gy74UwkG0WtmWb4/ojKV9+mhv8OXP5ndFRJVnxHW40yNsh0
	=
X-Google-Smtp-Source: AGHT+IGrNlVNBxYH1Qw4BJcMlD9wPo9FZS5uq/T0w5h54iF3LFmutxFxiAB1Kft62Bkasv3yfTqYkw==
X-Received: by 2002:a05:6402:5108:b0:607:2d8a:9b3e with SMTP id 4fb4d7f45d1cf-6072d8a9c61mr1315016a12.2.1749120276326;
        Thu, 05 Jun 2025 03:44:36 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::22f? ([2620:10d:c092:600::1:d66f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6072f9da0besm516701a12.42.2025.06.05.03.44.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 03:44:35 -0700 (PDT)
Message-ID: <5838de86-7469-479c-a9eb-973dca75e557@gmail.com>
Date: Thu, 5 Jun 2025 11:45:55 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 16/18] netmem: introduce a netmem API,
 virt_to_head_netmem()
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
 <20250604025246.61616-17-byungchul@sk.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250604025246.61616-17-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/25 03:52, Byungchul Park wrote:
> To eliminate the use of struct page in page pool, the page pool code
> should use netmem descriptor and APIs instead.
> 
> As part of the work, introduce a netmem API to convert a virtual address
> to a head netmem allowing the code to use it rather than the existing
> API, virt_to_head_page() for struct page.

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov


