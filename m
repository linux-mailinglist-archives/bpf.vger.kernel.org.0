Return-Path: <bpf+bounces-73806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE029C3A708
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 12:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED4113AA9D9
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 10:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794002ED87F;
	Thu,  6 Nov 2025 10:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VqxWTnNI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="grDVQcA4"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428392EAB64
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 10:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762426639; cv=none; b=dJclX1ReQ+1F1LnRSlVsuMgqGLRPO5MKKEZUGKxr+g758YPaqEANH/BSXqdZrteEjGRQl1i4DdjQSIP18S4lidRndYsF3LOfgcSnvaso4ghwIN8fza2WMdHxwoNBaWVdJiIDiL/S3tXJLgddXvZ8qkWp4eu8x2o+E5IquY7L6xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762426639; c=relaxed/simple;
	bh=9invMdERfhYKNnXg74LQAFbXckBFXN636tVMG/vPhmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CfhOJC76IE5x7xY4fHQJBDrV8BBnlcH+OtZAV7jLKbYGAEWQxKAG8esuDr8rt82wavyepdePWA4yNmZis0wM3X/o1dqrgFvyTSq7r+F0MivHjPmftJfzvsA+LYtlWRN6tr5nHa84fDzR9H16dJpZeEXeO2TGJ6G76u6glebS3x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VqxWTnNI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=grDVQcA4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762426636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kDAN1HMJoQQtQ55I20Dw66H+vj6obQIAmVodeSEuemo=;
	b=VqxWTnNIHukx3FndNseXfptaDOfwT/LREH8Cpog1TiTWjJHAYj1IVcG6JkBNEYu52TiCcg
	anFOqoHf9Tnyqc9KJKZwN4jtMGClm5f2/KOhcb9lSj17y8/88tkYFU751eKWaSU2PcWMLw
	CbU5icDS6lJDYS7h+nL6fa7gw0KWmpE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-D-nGXp4-PfG8J2ho8PqUVQ-1; Thu, 06 Nov 2025 05:57:14 -0500
X-MC-Unique: D-nGXp4-PfG8J2ho8PqUVQ-1
X-Mimecast-MFC-AGG-ID: D-nGXp4-PfG8J2ho8PqUVQ_1762426633
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-429c17b29f3so693980f8f.3
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 02:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762426632; x=1763031432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kDAN1HMJoQQtQ55I20Dw66H+vj6obQIAmVodeSEuemo=;
        b=grDVQcA4IIFdE0So8kwToiBQbNlLPgaIdDPiSxX+C/FuB++X/USEZOPz538ddu4iNT
         Mx3ebMoFz2lRn7MwLwXTUuMCHAt5XM7Ytnqr/Zu4kHRU9+4cgSpAIyXWXl3CVkXog45d
         BwKJucxcUPFMcjsl3o2eliFK4MjWROxAhSQRlQjV58OvFAHMwk8VA41EDUKctDdLYj++
         uhODnFr1vzcRSSG0GwusM9vO250X/D4dXLaPhVLjkEHw6A80FmaeqPQcPOT/2xGkFxuc
         QiCGAWA7ljTZNUhxTHi1t2+CMf/DRs/ayYeucX0R4dZqTenDsfpLK4E+G3+/pT8NnFMq
         0GqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762426632; x=1763031432;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kDAN1HMJoQQtQ55I20Dw66H+vj6obQIAmVodeSEuemo=;
        b=cASHf9BearHZavyX0B9X9c1bckXE1P4vKSoCP1I0RWmIRPKAD/YEiL94skKW9y5EBv
         pX/hYPpXEX8PXk36jrHIWMxkGsh6VRupXICafuMDn8kVl7AoOlaaCsVUBFTvkflUlRxe
         mXX3c8RGkD0AHHPIqwNHfcPfVNMTSFBhnJyXIAcUN4cSRR1OCZrBeKlnJdC6USxevIsu
         6KshhDXjiL/k+n5Og7sZQwTtiKj+ekFrfrppTtkQ8SHRL/EqgGj29oIJvU44IpKbE68I
         WMkWE/s7uBQglgnPNWtB1/pBLWHD7yd9N70IYRT/OQSjubo9S8N4S0WT3JREH2mB6e2i
         STXw==
X-Forwarded-Encrypted: i=1; AJvYcCUIdDUUjCR4ONM6kB7G/qtPwXSkan5SCPau+7+wGC0byBCPpVzkxFc/jCqbRsEu+jFha0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzeNr36IKJ82XQUzi441zWU6lprjDRbjPgAgqBMwMtcPMH88HT
	pp5VMJ+gFpOWsT3QfwwY/LAxtVR7/i5y5fLTtIlM/y9FVBP2ISyC9Byw+QBgJ8t+OMOV2tEq56A
	SPjOzqVYg+0lByTqD8SSaO/M1MIep7Gi0kth0O8SodT6RR2yEpr32Lg==
X-Gm-Gg: ASbGnct0GadMcsYPnYH4Y5UnW8pyYkz2EYlPt0QDEdqF7NyBj41ZfHEgGSJGI055MoH
	RTrBKWV9fGt9kL9jUa9zT1mKua5MESCSSp8ITmlwC4Sa1pvQH0tBwR67r4fAfcZSy02XowgH1vH
	pE9nAf5oYqBE+/d22qBfNyx5pXgG2e8ZpH+zaDCt1WPZ/gfpY8Bj+muQfLRkOwa7MDS2kPi3JNH
	pPbUUiSIKLL+KEQc4GJBTr4YYv2xLcwLSANEzvTfAGUiN/xcqFb38+4FdLqlnfiCskCUZv68nDK
	ThZRdW/lV+ldSLIUQ+GQWeR9U0cOFwkcHcdPQLC3iXcqWdH0T5FidBXL/K3qMpfpngoYur/iBX0
	OpA==
X-Received: by 2002:a05:6000:2811:b0:429:edfa:309e with SMTP id ffacd0b85a97d-429edfa32admr1087644f8f.20.1762426632515;
        Thu, 06 Nov 2025 02:57:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuo4Zz37FAjgeqMkvLjK2yjkrDZq4CtR/TEtSlcvQWi/2zCplPBisLlN9/n2avyBib7PRi5Q==
X-Received: by 2002:a05:6000:2811:b0:429:edfa:309e with SMTP id ffacd0b85a97d-429edfa32admr1087626f8f.20.1762426632119;
        Thu, 06 Nov 2025 02:57:12 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb49baf4sm4127409f8f.33.2025.11.06.02.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 02:57:11 -0800 (PST)
Message-ID: <2f38933e-f24e-4a14-a906-0d06bc194a21@redhat.com>
Date: Thu, 6 Nov 2025 11:57:09 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 01/14] tcp: try to avoid safer when ACKs are
 thinned
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
 <20251030143435.13003-2-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251030143435.13003-2-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/30/25 3:34 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Ilpo Järvinen <ij@kernel.org>
> 
> Add newly acked pkts EWMA. When ACK thinning occurs, select
> between safer and unsafe cep delta in AccECN processing based
> on it. If the packets ACKed per ACK tends to be large, don't
> conservatively assume ACE field overflow.
> 
> This patch uses the existing 2-byte holes in the rx group for new
> u16 variables withtout creating more holes. Below are the pahole
> outcomes before and after this patch:
> 
> [BEFORE THIS PATCH]
> struct tcp_sock {
>     [...]
>     u32                        delivered_ecn_bytes[3]; /*  2744    12 */
>     /* XXX 4 bytes hole, try to pack */
> 
>     [...]
>     __cacheline_group_end__tcp_sock_write_rx[0];       /*  2816     0 */
> 
>     [...]
>     /* size: 3264, cachelines: 51, members: 177 */
> }
> 
> [AFTER THIS PATCH]
> struct tcp_sock {
>     [...]
>     u32                        delivered_ecn_bytes[3]; /*  2744    12 */
>     u16                        pkts_acked_ewma;        /*  2756     2 */
>     /* XXX 2 bytes hole, try to pack */
> 
>     [...]
>     __cacheline_group_end__tcp_sock_write_rx[0];       /*  2816     0 */
> 
>     [...]
>     /* size: 3264, cachelines: 51, members: 178 */
> }
> 
> Signed-off-by: Ilpo Järvinen <ij@kernel.org>
> Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


