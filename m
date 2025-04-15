Return-Path: <bpf+bounces-55930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7BAA8968B
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 10:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 349813B9393
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 08:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0492951B3;
	Tue, 15 Apr 2025 08:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MR0YZedr"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5152E284672
	for <bpf@vger.kernel.org>; Tue, 15 Apr 2025 08:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744705479; cv=none; b=uKpixa80MVPHl7DJkil3xroIeurTfKxjLl/nVfPECNipECUoAhBBlBHcILUd2DjxOvqR2RGf2RT3mFUH3TfQtFsJVxuwC89lUs2pY7w1eqTy/fCZF4ndATnBYukhuR2hz2bQBzu0nv++/EXO7L/3B7rfgpJyfAJkQn/JEsLoU9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744705479; c=relaxed/simple;
	bh=vKYv/M9ajhjCM9oA8bR/2eWFDBzWCgzTfxFv/jPwpuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BsfG6N8bCrRGxDhtVCD4ZbWiZn6IzlISIGVALC9WhMaSsmJd7YnuYkvZMNSNYKA9yYGXKKga1cTCZ9gjlOJ+f0ovg9/H84drg/qKEpGvSeLtqHjXezJaR6HODgedGD2rI/F/7szqaZJQZT6RA1wSxdfOWzjge4NRUVn/ysi4LAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MR0YZedr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744705476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fNUQZdJEfgBW55jJBNwuJY4OjuVE5fjTLKdKD/g6/bM=;
	b=MR0YZedrLhhVp9APbeEYfOM2m5nKGxjZkg4xxeYh6LzulYurGd1/S/YpyAtHYJGJL2E2dq
	zpXIFmTQ7o7Qs2h8OgHm4nUFelkL3MRt3hCsnAr7QR4QDvMyEfEXJlBY2wN/k6spp6QZLy
	IAnplaO1navzK8QxrAVcXB6sUelGxxc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-88l2eKoaPaWzfxLzJNtcNQ-1; Tue, 15 Apr 2025 04:24:35 -0400
X-MC-Unique: 88l2eKoaPaWzfxLzJNtcNQ-1
X-Mimecast-MFC-AGG-ID: 88l2eKoaPaWzfxLzJNtcNQ_1744705474
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d733063cdso42807755e9.0
        for <bpf@vger.kernel.org>; Tue, 15 Apr 2025 01:24:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744705473; x=1745310273;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fNUQZdJEfgBW55jJBNwuJY4OjuVE5fjTLKdKD/g6/bM=;
        b=UqpI5sFIxKK+J07V7nm4U2Z933eNYMDVxqrmwWeW2wRLrwaaW0idyV7QDypL8QjT4t
         XD6v/L0tXNujInT/X9fqCE907ldJlTgmFgCZcAaA8hOouwbeZuxjz8aS08Kr0thNHobE
         kRA28dA5Xktopp7LM31RAUcchIjrtSRW7KlnNeb6UrNcyszu8xNi6+hrpWJxWIsbbhFq
         z3eAvZ5WM9Ob7M5dRHD9fsLMV7ErTm7P9AsOnMZ3R5jvarv0E1jqC+6tG+7fr/cv6oX7
         n6VAQ5xPae+EJkZsN5253afqte2vvj6JZTOf1uyw3iwxHC42EDSDVZo7dtymoEjEg8DS
         f6xg==
X-Forwarded-Encrypted: i=1; AJvYcCVWV0HH+PobBhYqo9FB59tXql/39W+RFMu0l7LO9vT/6S5F/KJcz8d8xDU5oV7KkMgDOiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6LuvjSEAaACXCgIEGJKk5S6tAPjyPspcWogvmUFN6cgx2fWeL
	cfbU32ygnANlXRk195ppc73U2/u/joW15igz+05S7uJ7+5LEXoT9jF24rBhkOt7EgDDHUBmN/tu
	8H1BS971SF8/Xs7wS64ov6pUZ1D5aqiziG+rjjVad/KY5s+7YNw==
X-Gm-Gg: ASbGncv0qaXu4s6TqCK3aGabOAaPho6eJR2lfPRl1uHCu8HnD4g2jzgTAT1ZbO0Aht5
	7A4pvdF8dssyfR5yQNgJL59rKxOoFOCYUsv7cwjqjBCSfeozWxjQNmWyM1MX8/RvrOZp23LBjW0
	i+nOFZBtgUtn3ednegsGJN3qIRNDCp7uGyAOTmNfdBXSEgp2jw75qsIwO52OuU75VYH+iFlXMlS
	0hEAvjXCafjAU0lK/dvOZKb0D9Uw0WVNTI/GeJCyCWasquQWHZERRqdAISR4Gq2WrQKdbgIOZfg
	wHFAEmgJJ9TYnoTMR2bezLzZ/PNtcdRIj5cMn8Q=
X-Received: by 2002:a05:600c:a53:b0:43d:fa59:af97 with SMTP id 5b1f17b1804b1-43f3a9aedd2mr137483015e9.32.1744705472725;
        Tue, 15 Apr 2025 01:24:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9p2z4UapZcr7Xqst3QaiQ7S8RXnCmG/NalHMoIBtWDxFXLmzHcbd+AlPzv4FdLt/ZCrgM4Q==
X-Received: by 2002:a05:600c:a53:b0:43d:fa59:af97 with SMTP id 5b1f17b1804b1-43f3a9aedd2mr137482755e9.32.1744705472321;
        Tue, 15 Apr 2025 01:24:32 -0700 (PDT)
Received: from [192.168.88.253] (146-241-34-52.dyn.eolo.it. [146.241.34.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f206332d9sm201428715e9.13.2025.04.15.01.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 01:24:31 -0700 (PDT)
Message-ID: <0a239bd2-b943-473b-ac3d-d3bf0401df34@redhat.com>
Date: Tue, 15 Apr 2025 10:24:29 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: tls: explicitly disallow disconnect
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Jakub Kicinski
 <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, borisp@nvidia.com, john.fastabend@gmail.com,
 sd@queasysnail.net, syzbot+b4cd76826045a1eb93c1@syzkaller.appspotmail.com,
 bpf@vger.kernel.org, jiayuan.chen@linux.dev,
 Alexei Starovoitov <ast@kernel.org>
References: <20250404180334.3224206-1-kuba@kernel.org>
 <e0ea9f710fde34bdce42515f8c68722015403ab9@linux.dev>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <e0ea9f710fde34bdce42515f8c68722015403ab9@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/25 5:16 AM, Ihor Solodrai wrote:
> On 4/4/25 11:03 AM, Jakub Kicinski wrote:
>> syzbot discovered that it can disconnect a TLS socket and then
>> run into all sort of unexpected corner cases. I have a vague
>> recollection of Eric pointing this out to us a long time ago.
>> Supporting disconnect is really hard, for one thing if offload
>> is enabled we'd need to wait for all packets to be _acked_.
>> Disconnect is not commonly used, disallow it.
>>
>> The immediate problem syzbot run into is the warning in the strp,
>> but that's just the easiest bug to trigger:
>>
>>   WARNING: CPU: 0 PID: 5834 at net/tls/tls_strp.c:486 tls_strp_msg_load+0x72e/0xa80 net/tls/tls_strp.c:486
>>   RIP: 0010:tls_strp_msg_load+0x72e/0xa80 net/tls/tls_strp.c:486
>>   Call Trace:
>>    <TASK>
>>    tls_rx_rec_wait+0x280/0xa60 net/tls/tls_sw.c:1363
>>    tls_sw_recvmsg+0x85c/0x1c30 net/tls/tls_sw.c:2043
>>    inet6_recvmsg+0x2c9/0x730 net/ipv6/af_inet6.c:678
>>    sock_recvmsg_nosec net/socket.c:1023 [inline]
>>    sock_recvmsg+0x109/0x280 net/socket.c:1045
>>    __sys_recvfrom+0x202/0x380 net/socket.c:2237
>>
>> Fixes: 3c4d7559159b ("tls: kernel TLS support")
>> Reported-by: syzbot+b4cd76826045a1eb93c1@syzkaller.appspotmail.com
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> Hi everyone.
> 
> This patch has broken a BPF selftest and as a result BPF CI:
> * https://github.com/kernel-patches/bpf/actions/runs/14458537639
> * https://github.com/kernel-patches/bpf/actions/runs/14457178732
> 
> The test in question is test_sockmap_ktls_disconnect_after_delete
> (tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c) [1].
> 
> Since the test is about disconnect use-case, and the patch disallows
> it, I assume it's appropriate to simply remove the test?

Ideally, yes. disconnect() implementation by its own nature error and
race prone, I guess  TLS adds some more spice to it. Unless there is a
real end-user scenario behind it, removing the disconnect()
implementation is by far the best option.

Still the test presence hints at some possible use-case[???]. Was it
created using the plain tcp test cases as a template?

Thanks,

Paolo


