Return-Path: <bpf+bounces-78208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A287D0215B
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 11:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6146731275E4
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 09:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26868337104;
	Thu,  8 Jan 2026 08:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J23X+UuI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="K6pYkrNq"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29AA36AB7A
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 08:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767861306; cv=none; b=cktk+pCEf5hnYMZPAy/QUKRHDeGTSEp2iUT2XBbtwVMilPfvt4KBpvi4JDX2Fmmrg/O5nTovUqJuXP9YSuV4+V+atf3JGZECgLMvUkM+ol0nzJ89xe8/IejFpe8pINnSSy9hHZhTGMlmVd/JmALtW4bJKMSrxdCyjkm8zi4vhGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767861306; c=relaxed/simple;
	bh=vOqy1647WRoRymxOMyXMEG8qnGN00OXJpzkXEokwITs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kXkv8qDDsW9RpJPAbAdHbeC99iZBNA7aJVsqe/vLUeAobUJs51B2lmUv5ThiS+ydsrxk21fIHzW7meuUSohevrTzUk9728Di79oLA3VPN+7x4NPEPVpymOuaKKslRXev686nDHGzN7ExDTDgmuYYdUBksEt121RhNQd6K/4RGr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J23X+UuI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=K6pYkrNq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767861294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G3izPdtqXaA4EZIquGKpD4hKmpzGXchWnG6uLb78MGE=;
	b=J23X+UuIVT5b2yfdKDZrkT7yOctgGdkIPZ3nfHy2hOtw3GmcZIpqI5nvffTsGFYBJNOhL2
	JvhL5uns/GekLbbsKO+TMAOyWXwvwl8TTD7MgL/hsSY3U3LMIIsUjOkCVDKKwPhDuQxPzA
	Yz8yE6tlkdx20mUWLt8jnmpdN4BOGnY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-e8Bv6KFBPeaG2j4YUCBQug-1; Thu, 08 Jan 2026 03:34:51 -0500
X-MC-Unique: e8Bv6KFBPeaG2j4YUCBQug-1
X-Mimecast-MFC-AGG-ID: e8Bv6KFBPeaG2j4YUCBQug_1767861290
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-430ffa9fccaso2150825f8f.1
        for <bpf@vger.kernel.org>; Thu, 08 Jan 2026 00:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767861290; x=1768466090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G3izPdtqXaA4EZIquGKpD4hKmpzGXchWnG6uLb78MGE=;
        b=K6pYkrNqcNjfA68oKoBMJy8uzKTXCn1nNZmV+13XHevU8yk/NRVpLmCk9w7lRu4zFm
         +/s7VDAzU6q6sCJoXsKT2J2hmeclRtBW7KDV1iU4yG4HJlbFJVRepTmoMG/mdVYMkS5/
         m5Xd+frci9SzO/ainVdYma5C852c7iXOeDxSuK3rz85E9wzIR+ubxiwuxbl9zXmOYiNP
         rEvuakL7XG0h3K5xwOvr2gA/wZHljxGbLXBi8qWOSVZOAEXa258q6djz8A9yNii6N8f3
         Zd5PLJm2PV02rGuK+KLI6D373ptOvMFsdRhQq7EaCmd+NP9waUv9PGG/7pbadVYjS75F
         IV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767861290; x=1768466090;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G3izPdtqXaA4EZIquGKpD4hKmpzGXchWnG6uLb78MGE=;
        b=OFN1REzIgyZ+FUjISxlJ+IPzuqqaQpMUvwflmp8ie33uMW13slB5jHEzSip5E3Gsbm
         9lbaNCPrWV482YICu23qhnDDSScj8GUj0JPK6JIpRGCfCoiQdmDRZy63IP70j2q4TJ/j
         CdwOZnga4wg5xg80uO7LxPc6JbjoWGOuD0g5ZTqSJMozB41Dh+IjYQFqsnkAIIFQU7m7
         MsbrPEEXFX5SfJg3g00v58NPIYbMJrxcwUic1t4foRhs0VG4oWvURRKpSCHSxnNBgu3M
         eys3KrBN/yMSXCHm2lhotwONC1039dHwL+ee6y7dt1QMggxEAWrYBGn0dZlRITLlhdrw
         9RUA==
X-Forwarded-Encrypted: i=1; AJvYcCXBbtimnkgv0OgCk35wE34O2YpX9+IJ4W7tj2Ce0WhytLuRfmdXLxHb3GRSUnBSkZsli6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMSfwRIKVaMG9x0ihcOTPffmDGRvUWHYNXgFjV8BGzMnVop/gy
	LDbhFAJoycIL8Nl7bNXQsonsZqcWn4g48KreLFICawqAUBxVmAF937veOZn0n6cIGao884k4fxk
	cqJAeYUneWvc39kEqo+MATWHUQTxMpv2srav7nyswRubyR3MkhFz2mA==
X-Gm-Gg: AY/fxX6OJJXKXlDh5FCZJswU2fnZYWDoLl5qQ0ZF8g2beEyzXOlCuVS5N7oMtr5Yvqh
	oHg5yrWWfFnGxfdPVPWYaei0GY353VrkrR7+WcEZT6ht2VR0JQkAkgtsc3qybO2rXNK+N272lOM
	6x0R4+qaW8e1kf/ICtdV2eGJZ1H17kjER0i/LrUcalCpiMKgblgoVMwbssZC1ZfRc8K63l1DDXn
	s6nAEzM2EnNTUak16X57FY3gZZLhyAkaOr7OgAH94R7gO8ZdR1+3+6nldpXnmuRw2GjT6KvkVIB
	bSO2nqJYgkkL/pSsWirkTw0VmEqCRDpT05WDKMnaMCm1lMBjC2aJ4bAm7SBdnSYMW17qdwGAC+r
	x5EEhJ7aM40lryg==
X-Received: by 2002:a5d:64c4:0:b0:430:fbad:687a with SMTP id ffacd0b85a97d-432c378a4cfmr7270538f8f.13.1767861289930;
        Thu, 08 Jan 2026 00:34:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJdXnc4ULpa81FnMPK+JkotChAGavVuM3yRwe+jMFsfmaDecitohHZqOK7h9/y3DI6QU+Rqw==
X-Received: by 2002:a5d:64c4:0:b0:430:fbad:687a with SMTP id ffacd0b85a97d-432c378a4cfmr7270478f8f.13.1767861289456;
        Thu, 08 Jan 2026 00:34:49 -0800 (PST)
Received: from [192.168.88.32] ([212.105.149.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ede7esm14917323f8f.32.2026.01.08.00.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 00:34:48 -0800 (PST)
Message-ID: <6491258b-0ef5-4789-b856-3e9cd9a3fbd5@redhat.com>
Date: Thu, 8 Jan 2026 09:34:46 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 10/13] tcp: accecn: unset ECT if receive or
 send ACE=0 in AccECN negotiaion
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com, parav@nvidia.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20260103131028.10708-1-chia-yu.chang@nokia-bell-labs.com>
 <20260103131028.10708-11-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260103131028.10708-11-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/3/26 2:10 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> @@ -1103,6 +1104,9 @@ static void reqsk_timer_handler(struct timer_list *t)
>  	    (!resend ||
>  	     !tcp_rtx_synack(sk_listener, req) ||
>  	     inet_rsk(req)->acked)) {
> +		if (req->num_retrans > 1 && tcp_rsk(req)->accecn_ok)
> +			tcp_accecn_fail_mode_set(tcp_sk(sk_listener),
> +						 TCP_ACCECN_ACE_FAIL_SEND);

Minor nit: AFAICS the above block is repeated 3 times and could deserve
landing in it's own helper.

/P


