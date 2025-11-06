Return-Path: <bpf+bounces-73825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0425C3AD98
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 13:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2A0BC343B02
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 12:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A495329E54;
	Thu,  6 Nov 2025 12:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jtb7j9l5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eNJfxlhp"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27498329373
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 12:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762431478; cv=none; b=tlFLQsqczQaYiVBbGIyBui6fdmLNEAhJtsYggiuFWm4RrbLunmfC7qTfRjqSrb9Uw0T7Ah2Y7VuxFgt59h0WBq45+09fRv4GaNp97KiOhqecL76sjs8vq3QJY3/uGyqMI1jgbnSuDFa5fdBDn++IJBghYrE8gCDPQZdECH9AWDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762431478; c=relaxed/simple;
	bh=9LV353o44e7iaytKxoKO3m56wFwJYwJhc6jN9BswQpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iF56FN9/pBzNGHMsQk8UkfsfBMof9SrzPvbuXSYCmNhw6/zM+PTYT2dzeJQB57cgQxG+hOUQUpKx5Qa61/Cq4D+msZzP/Fsma9keDiIsuAenxMPIBe19If/0b1YzdqmJdtC53/N7u7DLbssVoJNJEsdE2M0s+pmQOhoVYDtsgJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jtb7j9l5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eNJfxlhp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762431468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sJOFsQmt4z32StWI73+K+fCNACFUE/4kjllWzy5Yuds=;
	b=Jtb7j9l5Dox5h1YcH8NgyYzFs0owW+ttbzl4PBe85JGy2a+PWxaZ3bWwZkECSGnq4lCvcL
	2upQ7S2d4N9gtlW7ve5n5UxvrthRPXL/87LgvOZ6SQZaVMVMLh2Wi0n1vrpCB3llGFfsea
	ty62Nx4krvZQhzTJd0BHJ7hWW8AFzXM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-9Trb2bKNNEKCXz6GQccGew-1; Thu, 06 Nov 2025 07:17:47 -0500
X-MC-Unique: 9Trb2bKNNEKCXz6GQccGew-1
X-Mimecast-MFC-AGG-ID: 9Trb2bKNNEKCXz6GQccGew_1762431462
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4775e54a70aso8629835e9.0
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 04:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762431460; x=1763036260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sJOFsQmt4z32StWI73+K+fCNACFUE/4kjllWzy5Yuds=;
        b=eNJfxlhpb0EtmNe4zpHP4H+ssnYCTOxUxUbU26NKQVuag87NkWcpY94Docy9z1GEJ7
         DDIbEuab3l+8e+EhFt4wwYjOBlTYobHeMtKPRRzrqSUnzjK9gbyAOVYq0IChSAiR2zHU
         tQ+V/8YpvXmhiGpbM7kruWmRFxBTIuKqnWZ19D8NWwVuSieLhA1BOLwZEG3HtLrXcVgm
         eFD3cDtTYHEXQVI4pFT/NZbjebs4hCfs3K31r3P/ZXufnDZhtZtiPbiJAzhpWJ2vRB1/
         2djJEqci5M3DGEJg6e+PVFlof00Pck2WSEIFVemog8DopKHFc/qxUKMEG/YLBq1fJAGu
         yLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762431460; x=1763036260;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJOFsQmt4z32StWI73+K+fCNACFUE/4kjllWzy5Yuds=;
        b=xSnktnThRIqWCjZ2ICOpxdqtLev+Qdd3LUZpbkMqDyIhUOJ6Qv17hseF6UBxxCJwIL
         teDtFU9M50CB9XsgQPdtAXOdKrmvJ3YNeZcFyx6948uZZsXpZjsTkIMSq8131CvZ4JQD
         Hi8NmEymKUSnh+ap1q6us4nrRa08hNWz+G8yQOAfz0PRHLGI7ANOwT4vEfbbWpjWDV8M
         dtW6sNmNjzPKpibmZ7yYTRVq2SCYX5PkmBaFLE76g7gQY3kfx4bOtfXT0wNRWFk4r89+
         Awy0ddlRLebvrM5ktEl0Zu7gYG9gamA2p6itxEMXAryRwHFumETgiVKY5aJDuUSh2AyY
         M/5w==
X-Forwarded-Encrypted: i=1; AJvYcCURUBlu6g6KP9CgcZw9XPM04087EWNc0TghLhgFGbDxdRAIo21X1GjeviERQHyHzChUU3k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkgyk7VqUtbQGpTPTN3oBvxRWvqbhVc6Y31ewEGZTFYO+6F4Xd
	CZbE79n4KC9Viebimq17mwtqFnVOs8OPEHG14KPlqG6Ib17lPP9S2VL710DybpmHdTvjCn8lg3r
	EpUCc9w6qmJAcjRPPF+3TGikAp8uujskD8yvlry/jZTUd5OMzIJL1xQ==
X-Gm-Gg: ASbGncsQRopkZdt/9eYu+EDJzHbUlqDsdnUZCLCzEauNyXuLddphYfvjfPPdF+yuZII
	JS1wNVf7gxgCS97A+nAcRMLonTTs8pr3JZqfe8LZfQvZDD9cLe1prJtJIZgU6hdo/+L1E3RgPKY
	3PLPpg+a4ZBWLfp9petJAIhMXsEVulJ89Rgp51V1EXit40Uqx25npnRJBQBoiFziGpfos+LkafG
	dt+UEdKrgrZSEF7N4UO60H0aCotpCUx+/d2bfhpSfLFL05WmEPxWe/biRg2i9DKl2ocPx22ZtxV
	6Z3txEnDCRyL9wP8Bxcy1jyGAeIj8x7fTPpPdzBlM1tVSYcafN5tJygTHJ79O2C18JDEdIvtNsi
	7RQ==
X-Received: by 2002:a05:600c:4ed4:b0:477:3012:d285 with SMTP id 5b1f17b1804b1-4775cdacf5amr60826665e9.3.1762431460408;
        Thu, 06 Nov 2025 04:17:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPlniGNFV9Ibj9f6xLOEXX+53/yBS8AakakQvea5myq2HDP+liFvl4AiG9oo5p7c3OOkui0Q==
X-Received: by 2002:a05:600c:4ed4:b0:477:3012:d285 with SMTP id 5b1f17b1804b1-4775cdacf5amr60826455e9.3.1762431459953;
        Thu, 06 Nov 2025 04:17:39 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477626eb4fdsm44212655e9.17.2025.11.06.04.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 04:17:39 -0800 (PST)
Message-ID: <f88dac3b-3467-44cf-9725-7d8525615bda@redhat.com>
Date: Thu, 6 Nov 2025 13:17:37 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 11/14] tcp: accecn: unset ECT if receive or
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
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
 <20251030143435.13003-12-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251030143435.13003-12-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/25 3:34 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> @@ -4006,7 +4008,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
>  	memset(th, 0, sizeof(struct tcphdr));
>  	th->syn = 1;
>  	th->ack = 1;
> -	tcp_ecn_make_synack(req, th);
> +	tcp_ecn_make_synack((struct sock *)sk, req, th);
>  	th->source = htons(ireq->ir_num);
>  	th->dest = ireq->ir_rmt_port;
>  	skb->mark = ireq->ir_mark;

Whoops, I missed the const cast in the previous revisions. This could
make the code generated by the compiler for the caller incorrect -
assuming the changed field is actually constant.

I don't have a good idea on how to address this. Changing the argument
type for the whole call chain looks like a no go.

/P


