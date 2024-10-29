Return-Path: <bpf+bounces-43379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EAB9B4886
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 12:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F703B22D68
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 11:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9E6205159;
	Tue, 29 Oct 2024 11:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bv+D4CYE"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9564205138
	for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 11:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730202309; cv=none; b=O3fKlMESvayRI8KV0iGS6fbrIgr+p+NCLHG51hVPbkOvkdRNIE9hOGmUEf8ShupqAelZ6L4smM67Kdd7EqwXXJdaYgQFqGd4RboeFGNZl5nqgUwe9bkwt0IUw1gsMzix1Ut44M/l0zXDpLRg9Lojgefzwl/KzKNqeXW4Z0vfARo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730202309; c=relaxed/simple;
	bh=CX437E5Nyr2HYosbicnnbaJHOmbM/1dS1617DLcMqpU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=IlxiUPEpLC9r3ct3HN3LxNumQnxECREvSTQ2k09uv8cLud6692sB4HSx3g9IZTS9g0t3lnqxl5bO3iApV9zUY6nsRvO1tRG+pN+YGcDyzBMoSkT8qlAkZtzKTvE/Q6+JJ+nPxl2IHnHLU3vwL2UN+9x7yDhAimo1Rib12xxqu+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bv+D4CYE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730202307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=49UcOAd11qTq48MxmdhR0W2W8pgp3a9g0OPoFOxPnQQ=;
	b=Bv+D4CYEAGTVxrvinlJFmGF9OOaqI5h+5nz5N9KcKKmCRUsOnbxRVU4eZ+VHA6malVhXEs
	0mZZRAQlVqaCDTync1RM67NY0KTKa5I32n672Dz2gg3aeHVUB0uER7GHRtxKDymPtb0k/Y
	D5WhOsTcRVIDsj8C9IJlaKz2jcy8HL8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-bdNcIPaEMxac_Pp1LMnwmw-1; Tue, 29 Oct 2024 07:45:05 -0400
X-MC-Unique: bdNcIPaEMxac_Pp1LMnwmw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d458087c0so3791155f8f.1
        for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 04:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730202304; x=1730807104;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=49UcOAd11qTq48MxmdhR0W2W8pgp3a9g0OPoFOxPnQQ=;
        b=dOM90g0z+xdPzwHL22ZlsYlwxlTOj4MIpaRurELPSqW5znWT5rJ4Q3zQZqxWBCkgQz
         CkQDLm91yQXXoADlFF9cGYNrrq8jxlZvFbYglz/mGDGrYgQuXSNldzTFHgziWlBdCp6f
         yxX2Pch3rQHk9mzJnIdoQkqjUfJCFCU9IL2eKFhxsuOQ2Ni+hNbfKE0lWq6OTqPbTRJD
         18Y/60pJ4oJqAhNNEXdgqAq5Tfum5bW/5fGxcwKF2SHx1pgdpOCKv7YNRpEZJdjD6nSf
         JELaE7uvrcWkeR/PHyaFfiZm5YVciWpIp+Dk63we7PK20L2ZSQLpmd5S+UifRG/YOLbG
         fVFg==
X-Forwarded-Encrypted: i=1; AJvYcCVkw98kZJpiV0PNAPtCgqO90qzpOyWdDVFhHgWJnDq3WtfvHL7p757gxg6Qh/y9beGkPM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPAbCqvjU4+bs5dUQotXJh15S21wZ8hMFbaRuSV1jS1NDPSnqm
	erpwZh6tyuDegHTdQxVv0L4w4xf2uPkRVPVMKmMbehW0qRhmbMYEv5gcik26PfZzLvBFbzmEg30
	cQPGZ0eJEmN61Ep07t1M9bO6RcKcjf4KDiWCOCvoF3SOpphLyog==
X-Received: by 2002:a5d:5d81:0:b0:37c:ce3c:e15d with SMTP id ffacd0b85a97d-3817d61fb7fmr1367027f8f.14.1730202304586;
        Tue, 29 Oct 2024 04:45:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/lxsuiQaY7ZPpA/B+Yv1BwvjwJSqs6qwfakzz1rOvHV9fzRSiAVjNm271n7SSsQctwyc2/g==
X-Received: by 2002:a5d:5d81:0:b0:37c:ce3c:e15d with SMTP id ffacd0b85a97d-3817d61fb7fmr1367006f8f.14.1730202304188;
        Tue, 29 Oct 2024 04:45:04 -0700 (PDT)
Received: from [192.168.88.248] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b1c65dsm12359697f8f.8.2024.10.29.04.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 04:45:03 -0700 (PDT)
Message-ID: <6b5b7133-0dee-4539-8109-674f236e0fa5@redhat.com>
Date: Tue, 29 Oct 2024 12:45:01 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 04/14] tcp: extend TCP flags to allow AE
 bit/ACE field
From: Paolo Abeni <pabeni@redhat.com>
To: chia-yu.chang@nokia-bell-labs.com, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 dsahern@kernel.org, netfilter-devel@vger.kernel.org, kadlec@netfilter.org,
 coreteam@netfilter.org, pablo@netfilter.org, bpf@vger.kernel.org,
 joel.granados@kernel.org, linux-fsdevel@vger.kernel.org, kees@kernel.org,
 mcgrof@kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
References: <20241021215910.59767-1-chia-yu.chang@nokia-bell-labs.com>
 <20241021215910.59767-5-chia-yu.chang@nokia-bell-labs.com>
 <3f194c95-5633-42c2-802a-9a04b4a33a8c@redhat.com>
Content-Language: en-US
In-Reply-To: <3f194c95-5633-42c2-802a-9a04b4a33a8c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/24 12:43, Paolo Abeni wrote:
> On 10/21/24 23:59, chia-yu.chang@nokia-bell-labs.com wrote:
>> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
>> index 9d3dd101ea71..9fe314a59240 100644
>> --- a/net/ipv4/tcp_ipv4.c
>> +++ b/net/ipv4/tcp_ipv4.c
>> @@ -2162,7 +2162,8 @@ static void tcp_v4_fill_cb(struct sk_buff *skb, const struct iphdr *iph,
>>  	TCP_SKB_CB(skb)->end_seq = (TCP_SKB_CB(skb)->seq + th->syn + th->fin +
>>  				    skb->len - th->doff * 4);
>>  	TCP_SKB_CB(skb)->ack_seq = ntohl(th->ack_seq);
>> -	TCP_SKB_CB(skb)->tcp_flags = tcp_flag_byte(th);
>> +	TCP_SKB_CB(skb)->tcp_flags = ntohs(*(__be16 *)&tcp_flag_word(th)) &
>> +				     TCPHDR_FLAGS_MASK;
> 
> As you access the same 2 bytes even later.

[Whoops, sorry part of the reply was unintentionally stripped.]

I suggest creating a specific helper to fetch them.

/P


