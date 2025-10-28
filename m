Return-Path: <bpf+bounces-72523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EFAC14753
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 12:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 498C6198421E
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 11:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4761B30DED9;
	Tue, 28 Oct 2025 11:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AA9haMyl"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DC130DEA2
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 11:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761652055; cv=none; b=j2SoI7rmdNNCy4z6B6nIftEbYOUbVi3xGPYe7DUnVj45T2eObXLRZjJU1VFTvzce3B2UJml1ZnJeVLY6kkQDqa+1atzVYpm6Pk4GIDlCCgrytd3tinXAMJAC4VVnR0oFpgF8qJdQlFF7R/0ecpFedU2zN6XgZTO1CfVLDlXfjH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761652055; c=relaxed/simple;
	bh=hTHSTmvO2gcuI9bvffQRykt0y1SGaZooIAbSqmRKxWY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Fy8ZQSmR3b9SqHjblJKfWmLgeYx9xMkzewV4rd9ymKasrpEEXinJJLIeL/MUUvNVJUeKp8L8P7oEeLyqePpoGenwv4xmIUMfGeWiT7asSAkhJf04vvrAs1iJLpxs9kHMSDm/LwNIhNvvI/6+9ClIsV7OYAav2nEqv1uTVREt+aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AA9haMyl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761652052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ej5v2AhyT2+gsUph5VSZWo0mYhFvGVyUF+E1rpDGkYk=;
	b=AA9haMylBAidafCPCHDsWLUkv37h7NL1XI4lk7FudkS2N2t/nbQI/gG6K84hzbZDevzl7f
	m+p1S6uKR3lfPYFsP14GQY1bUbI0xhJdOy0dE5Zp8RAVyTRyTHSzoWteD2QZxW1CZEWVlW
	o6QudmcANfiRdMezzYtk4o7oAIWx3w0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-YpodLPb2MHScnfgODTKR7g-1; Tue, 28 Oct 2025 07:47:31 -0400
X-MC-Unique: YpodLPb2MHScnfgODTKR7g-1
X-Mimecast-MFC-AGG-ID: YpodLPb2MHScnfgODTKR7g_1761652050
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-475dc22db7eso31031745e9.2
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 04:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761652050; x=1762256850;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ej5v2AhyT2+gsUph5VSZWo0mYhFvGVyUF+E1rpDGkYk=;
        b=nQstCSRO4SmbAVh3WB/5YEr04OkAn7RowL3rbLtScn6Ie48m+LFIpt3N6iwpHibrNL
         rutb+K9TwsxfibA3bFBCvo3v4AN4xvj6eRLAiHYb9Or5ECTG8CLmT225l7qTWBoNH+LZ
         Oe4DwUGoUlHLot1zjK926W1bdGMty1+s4TueQpaZGAbtBkjNMDJY5rIClMGl/mmerUXj
         zZDbZULQUZWyc/2V27A39e5UsQys8i1/ULzOz7+iqCTYcPsA15MGjsyMUNBfAXXO8qf4
         IUjEGCVrnR09IgBo/sBP4TZ+yWpbpmIzHG1w8QCcLhxcJJhn5vVL2T1DfT7twkHsv5cf
         Xdfg==
X-Forwarded-Encrypted: i=1; AJvYcCU8RaDhriqN8cPcUOiKsfkF0MogstjBMUuCSHrR0ac9xc6/Yhi+CYnJj+dG1/paeKqeyrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YynK44larrXTtTikQ6Wd2WhsXkJPcEoTo/tJSvQxiRoqnCPuWTm
	JZnQ19utMXRbFI5TuFVUkd0+dhH4gFcSpUYQX0k6vsMT7hhSyAg+/TQu+ednifTBs12c/MR+h/C
	Gwc/wkPMqd38OkdD8e+y3ldY7TlN9q3xy3qGvhvnOeIq0CtjU1PgNoQ==
X-Gm-Gg: ASbGnctZ4JMoRAOctXYpyDakHtKFACen/e8gvO8aNWEMQxLWplCyHiouJ9eT7XQ8K69
	ouBTm67Le0C239FLb1ZgkPdICpMVRpJaMf2k8KjqVpatypo6H+InxGrh9pcLe6Wva9Q3Nlhv7zL
	L4fZzgflVqwrzEMRoizEuGTp0YR5vBNIGl2DTl9AJpBChFX6Rt0OpKlSdDiypVNfq2QjiVwX58K
	CC3jQWkFyn/Z2oN/gzFcKyMsfsURgFrW3M4OjQdgsuuJJf4nK6GtcoHS29BZ/vkXW1QB6cbc/jH
	ZOGccm/dvVN3J5XT7PRNLpaO666RzZ3BPMMGbRnli5sHu/ghGuDBQatH432Qursjbbz1xb8XYAC
	eFJvu/7mU3YwONQZuT/6G2CTnatQ5KHuTaqHiRpja8hOVc9A=
X-Received: by 2002:a05:600c:b90:b0:477:58:7cfe with SMTP id 5b1f17b1804b1-47717e04c2bmr26367005e9.18.1761652049825;
        Tue, 28 Oct 2025 04:47:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYsmPrnr2n5dOG2TMddpHesTATKrRY3s7taqm1slxtVNIFUzWMD6kXpI/krQ6+LdMW9yh+6A==
X-Received: by 2002:a05:600c:b90:b0:477:58:7cfe with SMTP id 5b1f17b1804b1-47717e04c2bmr26366375e9.18.1761652049184;
        Tue, 28 Oct 2025 04:47:29 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd47793fsm194874245e9.3.2025.10.28.04.47.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 04:47:28 -0700 (PDT)
Message-ID: <7dfda5bb-665c-4068-acd4-795972da63e8@redhat.com>
Date: Tue, 28 Oct 2025 12:47:26 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/3] net,mptcp: fix proto fallback detection with
 BPF sockmap
From: Paolo Abeni <pabeni@redhat.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>, mptcp@lists.linux.dev
Cc: stable@vger.kernel.org, Jakub Sitnicki <jakub@cloudflare.com>,
 John Fastabend <john.fastabend@gmail.com>, Eric Dumazet
 <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20251023125450.105859-1-jiayuan.chen@linux.dev>
 <20251023125450.105859-2-jiayuan.chen@linux.dev>
 <c10939d2-437e-47fb-81e9-05723442c935@redhat.com>
Content-Language: en-US
In-Reply-To: <c10939d2-437e-47fb-81e9-05723442c935@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/25 12:30 PM, Paolo Abeni wrote:
> On 10/23/25 2:54 PM, Jiayuan Chen wrote:
>> When the server has MPTCP enabled but receives a non-MP-capable request
>> from a client, it calls mptcp_fallback_tcp_ops().
>>
>> Since non-MPTCP connections are allowed to use sockmap, which replaces
>> sk->sk_prot, using sk->sk_prot to determine the IP version in
>> mptcp_fallback_tcp_ops() becomes unreliable. This can lead to assigning
>> incorrect ops to sk->sk_socket->ops.
> 
> I don't see how sockmap could modify the to-be-accepted socket sk_prot
> before mptcp_fallback_tcp_ops(), as such call happens before the fd is
> installed, and AFAICS sockmap can only fetch sockets via fds.
> 
> Is this patch needed?

Matttbe explained off-list the details of how that could happen. I think
the commit message here must be more verbose to explain clearly the
whys, even to those non proficient in sockmap like me.

Thanks,

Paolo


