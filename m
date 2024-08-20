Return-Path: <bpf+bounces-37610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C92A39581A0
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 11:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C4511F239D2
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 09:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208B118A94F;
	Tue, 20 Aug 2024 09:08:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1A94595B;
	Tue, 20 Aug 2024 09:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724144904; cv=none; b=ZZJfAZhQ2tFipBzXl9YMM9NQOTVYzUwQW92gl+LJ+EiwCIc5PuzCKfGQBIPgVe0FAHS1+pEFRfF2CNP+4wMxA0S+bxLRW0c9AS7CsfXgn5EQbXezx7GEbm61MrnengWWzp7eMok09dJL+937mDaLUswh8Laxgjh/8h6pa8/mXUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724144904; c=relaxed/simple;
	bh=3iV/bcQZ6Tbd6EBTB+L/vJqSZBfIkuQvwRm/kGPOFTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qs1sx22AkXfHwIg7VPpzqobgqgJ7mGliJkAVhljdwY/zk7SX1Ajnun7ZEMoMqHWoXh2SphPiN+1pualCDesfQgWtQJ5SGu+NCt9k9dtZvuwOWAFsycHSWaFoQ++oNDBjxXnKPTUr+cuR5vohyz5OcDBZFGOhcHzNF8iVRUSc/qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-429da8b5feaso57424315e9.2;
        Tue, 20 Aug 2024 02:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724144901; x=1724749701;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ud6xvd3hRneccQ4KozyG7p4QZ+6fvXq21LPd+Tt+ZKQ=;
        b=wOe0hwXp1yrjz7Y3KQwqAT6IOMvaqHyQxa20NWj8exyS+bV32FHtdErvJLHEta7Gyh
         ngPYm2kyD6zMggMNvif9oMJb5xYJ0gwwHTbUC+L3saHTJKI7UC3F1uodD3335Wb9eAXu
         tgtzbhPYg5DvjfxiXo6h8FIUMmzlNvaeNCAxgQ5kCrTGxQi53q6JJxjHOjDnxztbrPCS
         bdnytJOBQ9REEIyaQhWjEtiZGso5iL8dezV7P5D5hODZ5lb4FZ8FKN+PLcYII2C4MXAC
         tNA16phw25cKO8TEFwTVO6rhTtg3yMrNjLOIGidr4cwBLsNPC7ryYxbaWbrPBwGwxIdS
         oS+w==
X-Forwarded-Encrypted: i=1; AJvYcCV9L0yDlxnAs8YhR9d9gN+oJhxnEUwQSh5nD8sLA3/6zVIfWnFIIsOy9CAnofs2xNICGtx6noFp+OS6X83n@vger.kernel.org, AJvYcCX8dzOcCoQTchDjaPcMquXW2M7WxPQfaxO6xY2x8NdJGVVk8kTpVQMSPJTkrqNH+Okxp/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2LNPb1QMzbSPs5SAZYQyUMoRqDycz6Eqdly6Uz3Z+aQwAo8k8
	sRomeDtfjjwa0b6aL7RgtylqmJLclQeAJwqWO5/IFrRU64eGjUf2
X-Google-Smtp-Source: AGHT+IGOyAPUuDtDrruF9x8Xf15VKb6LHXxQVkRdy7nKxnw2GvO7Qi1ZxIg9M/O2/BLqPdI+pZBQeg==
X-Received: by 2002:a05:600c:470c:b0:426:6fd2:e14b with SMTP id 5b1f17b1804b1-429ed79b837mr104492895e9.11.1724144900925;
        Tue, 20 Aug 2024 02:08:20 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ee54f73csm133394325e9.39.2024.08.20.02.08.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 02:08:20 -0700 (PDT)
Message-ID: <54ba38de-90e4-4444-8bb4-8b5f6bc11757@kernel.org>
Date: Tue, 20 Aug 2024 11:08:18 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] kbuild: bpf: Do not run pahole with -j on 32bit userspace
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, masahiroy@kernel.org
Cc: linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas@fjasle.eu>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, linux-kbuild@vger.kernel.org,
 bpf@vger.kernel.org, shung-hsi.yu@suse.com, msuchanek@suse.com
References: <20240820085950.200358-1-jirislaby@kernel.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240820085950.200358-1-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20. 08. 24, 10:59, Jiri Slaby (SUSE) wrote:
> From: Jiri Slaby <jslaby@suse.cz>
> 
> == WARNING ==
> This is only a PoC. There are deficiencies like CROSS_COMPILE or LLVM
> are completely unhandled.
> 
> The simple version is just do there:
>    ifeq ($(CONFIG_64BIT,y)
> but it has its own deficiencies, of course.
> 
> So any ideas, inputs?

Also as Shung-Hsi Yu suggests, we can cap -j to 1 in pahole proper when 
sizeof(long) == 4.

> == WARNING ==
> 
> When pahole is run with -j on 32bit userspace (32bit pahole in
> particular), it randomly fails with OOM:
>> btf_encoder__tag_kfuncs: Failed to get ELF section(62) data: out of memory.
>> btf_encoder__encode: failed to tag kfuncs!
> 
> or simply SIGSEGV (failed to allocate the btf encoder).
> 
> It very depends on how many threads are created.

I forgot to add, that it depends on the kernel version too. It happens 
much often with 6.11-rc now (vmlinux got big enough, apparently).

thanks,
-- 
js
suse labs


