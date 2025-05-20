Return-Path: <bpf+bounces-58539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D16AABD3E9
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 11:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B333E7A9513
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 09:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129C5268C4B;
	Tue, 20 May 2025 09:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O81hku0v"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CB2261568
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 09:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747734600; cv=none; b=BJe3pkrv5oovkn60v2QXdowk0Mis5+Zibod1B5h4uh+YWMVBY7luRjxyJIEluWwWSX8YrQGBcbcBToPLuT5JIYeW31Pk3Xj3JIls5s9auQ0DUYXfGwIgywGMlDzG/jwAWeu4xHGw1uLSDsA5locA9SSEh/iW6/MWUZ1+L1Z5Kxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747734600; c=relaxed/simple;
	bh=zmMeJiDDZWaauBVCwiIbfO5yDwZo3DooABBxbFXHDdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=grx+EveGsHpIGWDuZqOPKOPw9CEQ3l3TUfjhhMugDOP68U7Efqgo7pgHMDSabW3YsZ5cKwEiOZxPODncKCGB8COuLKMTs3E1EGKOVmrlg9+RoaHWuVgr8yRJ+pHGHdHrbyCpB8Sa3GFlOhTSc/r5xBHFayju7S8SK1FVS7v3gxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O81hku0v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747734597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aKVK+uAlT4VzaC9oAx0YIHTOnxhoJDuCN0nhLSXNB60=;
	b=O81hku0vozDSd0vx5MrGGGu4I9sBNeLDddnul+OCTTTQZemvHGvQI9LD+6XRCBoNz/MjwN
	AUNtL+bUx6DxqKbBmR5kVmYOOWGg4HsKd+S12s091OKOLFYGYVXJO2oyBXp73j+j07SnEt
	RfkHfPQSGcRH3NX9fk9K2+eKz3FUp+c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-2Aa4xmZjMWW4K_gUsvebAQ-1; Tue, 20 May 2025 05:49:55 -0400
X-MC-Unique: 2Aa4xmZjMWW4K_gUsvebAQ-1
X-Mimecast-MFC-AGG-ID: 2Aa4xmZjMWW4K_gUsvebAQ_1747734595
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a367b3bc13so1148059f8f.3
        for <bpf@vger.kernel.org>; Tue, 20 May 2025 02:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747734595; x=1748339395;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aKVK+uAlT4VzaC9oAx0YIHTOnxhoJDuCN0nhLSXNB60=;
        b=PiHS+7p5ViiTecRBakn/wdDli68qjEG1HAZBHyOM6+Jchu9VdpjmnolQf3R1HMOZGy
         eErI1Dg24G6UQXgVvXuMkRTEGfLlA6NKqBzZyKjDV6bGeKLtR1oV+SXKO3fM5ybPDT+i
         ihPyBkUUyjaso/wVKRKApIU4dax/D5Gv0h5x1rlpzmj8Ze2n0rzexT6qj7cDrPG0QdLD
         CX7r5XiBgg1qLxzifuxuWZ0e59P2RR4a5qWCFXe5L+wgQ6WxlT0WIewoXjMGyf0fVjwH
         oRGcoifhdafNWhuDxsfsf71Pwc/jcLcRfyE2xeMPBnPvzS84Okuu3Q1mfbO9vMIvNjC9
         i6sw==
X-Forwarded-Encrypted: i=1; AJvYcCXT2OgWD05ivRkpm5klsvYn94CRDT+8zFahCLYvsKRSbWTT+1sOaMJUnzz0qsXbm6g18cg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp8QJHmjM6j+wRnIWq5wf890bvd7s4kre3QX9oF65Zx5HSuWP5
	s3j0Z+Hg/zFv/TP+ObnO78505XRuaC9x/8Ly82wfMXQHvWr+HwHqgJls0QLingNs37QaVoeou2Q
	R+Bn5z3DvLLSsyys2XbGob67ha/DMVQCNYY9u2ZjayY9U9vno+2ZVHA==
X-Gm-Gg: ASbGnctmotEn/Fci+dpRXw+zJudOe2WnEBDiu63STghZUxYAPSw3ePzqbx76UugIa9T
	dkz6gwN8zVIh2R1nNw/r593fhanumhK+EHkOaf2OZRS1jFrzo8TVIFPADQQOOWHf+FUlPBShazF
	zmF7/JhgTjEw8iqIPlUHpWhJMLECmXsC67Z2QZwP5XZ0xLzk165bRsjsGC17gU3ss9PYNKamkFG
	qxwpWjvRX0xnX5xLninOLPpbr+ugl1mF1jLeTtF03BYzrFoS7qNmY42saLWaKk4YC2UB2CYlUDQ
	BVsys42oFjiT4d6QHgW+MMfNRna4S8J5UTkagTzdL+PKIddo6EHruOVMhiY=
X-Received: by 2002:a5d:6a49:0:b0:3a3:5cca:a56a with SMTP id ffacd0b85a97d-3a35ccaa7ccmr9872991f8f.32.1747734594720;
        Tue, 20 May 2025 02:49:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERZPLs4JlsuZmumP5YHPtj9qIckLqLuPz2NZ0FOXcdTy6ANbEKQ9dbQymmsaS/IsilI+AwLw==
X-Received: by 2002:a5d:6a49:0:b0:3a3:5cca:a56a with SMTP id ffacd0b85a97d-3a35ccaa7ccmr9872974f8f.32.1747734594291;
        Tue, 20 May 2025 02:49:54 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:5710:ef42:9a8d:40c2:f2db? ([2a0d:3344:244f:5710:ef42:9a8d:40c2:f2db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca88a13sm15601908f8f.74.2025.05.20.02.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 02:49:53 -0700 (PDT)
Message-ID: <6ce5f200-aacc-4b01-b3b6-b2dbe543248d@redhat.com>
Date: Tue, 20 May 2025 11:49:51 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 10/15] tcp: accecn: AccECN option send control
To: chia-yu.chang@nokia-bell-labs.com, linux-doc@vger.kernel.org,
 corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com,
 jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, andrew+netdev@lunn.ch, donald.hunter@gmail.com,
 ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
References: <20250514135642.11203-1-chia-yu.chang@nokia-bell-labs.com>
 <20250514135642.11203-11-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250514135642.11203-11-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/14/25 3:56 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> @@ -6450,8 +6480,12 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
>  	 * RFC 5961 4.2 : Send a challenge ack
>  	 */
>  	if (th->syn) {
> -		if (tcp_ecn_mode_accecn(tp))
> +		if (tcp_ecn_mode_accecn(tp)) {
> +			u8 opt_demand = max_t(u8, 1, tp->accecn_opt_demand);
> +
>  			accecn_reflector = true;
> +			tp->accecn_opt_demand = opt_demand;

There is similar code to update accecn_opt_demand above, possibly worth
an helper.

> @@ -1237,12 +1253,16 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
>  	}
>  
>  	if (tcp_ecn_mode_accecn(tp) &&
> -	    sock_net(sk)->ipv4.sysctl_tcp_ecn_option) {
> +	    sock_net(sk)->ipv4.sysctl_tcp_ecn_option &&
> +	    (sock_net(sk)->ipv4.sysctl_tcp_ecn_option >= TCP_ECN_OPTION_FULL ||
> +	     tp->accecn_opt_demand ||
> +	     tcp_accecn_option_beacon_check(sk))) {
>  		int saving = opts->num_sack_blocks > 0 ? 2 : 0;
>  		int remaining = MAX_TCP_OPTION_SPACE - size;
>  
>  		opts->ecn_bytes = tp->received_ecn_bytes;
> -		size += tcp_options_fit_accecn(opts, tp->accecn_minlen,
> +		size += tcp_options_fit_accecn(opts,
> +					       tp->accecn_minlen,
>  					       remaining,
>  					       saving);

Please avoid unneeded white-space only changes.

/P



