Return-Path: <bpf+bounces-41543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFCB998071
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 10:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 529981C26024
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 08:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC2D1CF282;
	Thu, 10 Oct 2024 08:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W8h74ZtX"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EB51CEEA2
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 08:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728548764; cv=none; b=faomVMqbs5kB/5epGO/MzjfQaAcysMaH9MlHJEYFqWbqPA5ctcHfF066tD1hMCwQiXv1AHAKXFFwF2Ohp6w5Hs7UbVkXul40lBgeJdZHXm/2B8ue/hiH75IE+BcFQBR8QDfHLP3yr5/Ajos2vecz7apPjZVegnhXZR3Tgo0N/qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728548764; c=relaxed/simple;
	bh=dqyQvgHvQL/aQd0lGWWhd3kBvQIxg+mwqM9znGxTZig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n/DQYWHvn1sP5TIetSsgUoBoI7dLOQzXnj6nrqbTrUrHbj/ZnN9QO1shda1VtfTyOQtznTqbHz4tY1HgpQhye/NYK4HzOaBQHD0s5fjtzCJU4YNDHmIeEkNisEBQBy6Ri1oUKLz5Cfvr3Vd8urMQoFywdRJbUCP1c3nqRHmFHPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W8h74ZtX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728548761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j1h1uJoRfos/O8AAaaZabotvNCrfCwdQaEKlDSIDITk=;
	b=W8h74ZtXnke/TyNE0ePPskRGD6z9vEug8CFU112Kj6Ev8LYcfsoMwsTu+C13TvIL9ROYoA
	kSvRhrjeJ2XKeWiIdSE6kfNEQSMOAgjCVFmpBL5zRkcsc+fjbZnYXaE6RHaLQ7FYG0kVRp
	dKaZgkLSoSUY+fbapxvZgCbpZ6hwNOU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-PLZI29rPOf-aA4iZZ_fHhQ-1; Thu, 10 Oct 2024 04:25:56 -0400
X-MC-Unique: PLZI29rPOf-aA4iZZ_fHhQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d389ffddfso359988f8f.1
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 01:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728548755; x=1729153555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j1h1uJoRfos/O8AAaaZabotvNCrfCwdQaEKlDSIDITk=;
        b=Lcek5XQWQ77FjHZiBZkEb1M2mQ3IeBqggvpizHRn3ItZ0VQs5g/X/VTRLw5kM3zH71
         lvyr9NRJP6HOQoG5+kHX14yKRdlP+qeRYhw0tskzIH/LjWHgidpEB9JfYnjEEow3sxLO
         Z5Bn5dsrFj+syFHZ9wnxkdWtxMJglNjPRAZ+oWdtjOoKKo8BoroJAb8mA2pofje+ZqAK
         lDDkb2exFSW8r4LPO00rbMh097eUa3pLxCDqFy8bim+FKQdJPso1Aq8psTbo5jTO3eUG
         HASdnIyJYV5ItlpQ5wu6bAS/exlBAxSRQ1mBQUHz6bQ434ybP1cC5FBz5QjAg83hmDzV
         VH0w==
X-Forwarded-Encrypted: i=1; AJvYcCVAo0AuAA85JuTZq4bPHw5MLZB/Cr7VUjEJoT9/SW2S98NHiKmnEr5/Z4yZpv046Zw/PEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzwfKqSgegUdYcTe24BY+RdPnE0ryytr+l3Zdb3K2xaZhNkVkG
	5heap5qWkUqufvgK3/4e1yM8NI1QQ1QSzpCz2k4W3i8e1NX2VHFssVYG62AUgUbPZCY3scSmhdu
	NH6qfT7P7Pz1V4gCXrBUaQTZExCuxZNc5xHm5eJ16rz0YpPV5OlWYjqAt2efK
X-Received: by 2002:a5d:4109:0:b0:37c:cfa4:d998 with SMTP id ffacd0b85a97d-37d3ab0118amr4315413f8f.49.1728548754918;
        Thu, 10 Oct 2024 01:25:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUzRA5DsZ8WcessaPKi5kUw1LuvxVNbo8hX2evZpBQA6p8oT+WfWiN1QuaiBkJBSm0JUYRPA==
X-Received: by 2002:a5d:4109:0:b0:37c:cfa4:d998 with SMTP id ffacd0b85a97d-37d3ab0118amr4315373f8f.49.1728548754437;
        Thu, 10 Oct 2024 01:25:54 -0700 (PDT)
Received: from [192.168.88.248] (146-241-27-157.dyn.eolo.it. [146.241.27.157])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a8b80sm836160f8f.9.2024.10.10.01.25.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 01:25:54 -0700 (PDT)
Message-ID: <7caf130c-56f0-4f78-a006-5323e237cef1@redhat.com>
Date: Thu, 10 Oct 2024 10:25:51 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/7] net: ip: make fib_validate_source()
 return drop reason
To: Menglong Dong <menglong8.dong@gmail.com>, edumazet@google.com,
 kuba@kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, dongml2@chinatelecom.cn, bigeasy@linutronix.de,
 toke@redhat.com, idosch@nvidia.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20241007074702.249543-1-dongml2@chinatelecom.cn>
 <20241007074702.249543-2-dongml2@chinatelecom.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241007074702.249543-2-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/7/24 09:46, Menglong Dong wrote:
> In this commit, we make fib_validate_source/__fib_validate_source return
> -reason instead of errno on error. As the return value of them can be
> -errno, 0, and 1, we can't make it return enum skb_drop_reason directly.
> 
> In the origin logic, if __fib_validate_source() return -EXDEV,
> LINUX_MIB_IPRPFILTER will be counted. And now, we need to adjust it by
> checking "reason == SKB_DROP_REASON_IP_RPFILTER". However, this will take
> effect only after the patch "net: ip: make ip_route_input_noref() return
> drop reasons", as we can't pass the drop reasons from
> fib_validate_source() to ip_rcv_finish_core() in this patch.
> 
> We set the errno to -EINVAL when fib_validate_source() is called and the
> validation fails, as the errno can be checked in the caller and now its
> value is -reason, which can lead misunderstand.
> 
> Following new drop reasons are added in this patch:
> 
>    SKB_DROP_REASON_IP_LOCAL_SOURCE
>    SKB_DROP_REASON_IP_INVALID_SOURCE
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>

Looking at the next patches, I'm under the impression that the overall 
code will be simpler if you let __fib_validate_source() return directly 
a drop reason, and fib_validate_source(), too. Hard to be sure without 
actually do the attempt... did you try such patch by any chance?

Thanks!

Paolo


