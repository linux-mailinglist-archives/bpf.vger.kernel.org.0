Return-Path: <bpf+bounces-69368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C80B95641
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 12:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C46FC3AFCE0
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 10:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD6C2F2909;
	Tue, 23 Sep 2025 10:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TAJwLRBR"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CA62ECE86
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 10:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758622137; cv=none; b=Dq3UuWc1eaNMc9joxon4WphmtBShBQCjLJqbvuugEVBSQHQgnbYufoNskifB2+3GvOkrhvDqHzqGUHcEwVINrNCgtY0qtKvH0jPjOp/63XR2g3ii1aU6fvPCaet8L1ZgbYgHj5zkpj7WI3zhpQuCrcfrviNZzLfQvBZEmA8MlTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758622137; c=relaxed/simple;
	bh=S3KOpBbqom2/3HrzTHThYA0lYWi/O5mMBlQ+qwi7tME=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JzEQ3jtbfGQttej16ziw0c8pqxxTmmKAsX3AmbubfmVZK4F0/DTUpQFrzMhu3vlZC27bM1pmEG08XuiOLGe/DqoYm++O+f0gySs5xOoPC5kkDaqtOHvSLRcClk4HghvYBtWfX6Ez5buKxS0APVeYPd8fZR21fqRcDaB/DXwXedw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TAJwLRBR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758622133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nAJnOq7wJ5XI1FIJLe0LF85/fgqZuSixFEm3aUU2pcI=;
	b=TAJwLRBR0nuiHGR+/950zNyNaIIipgI424WncV0PcWCnmj1cUYv8brCKeDHHoOXy1VEg4g
	x+b+KECzKgFmRZ6/ds6VtSHLtXPw6LCoLnK++ekPrIfsEIVQRmhRyImHcLNNMko4BWNTtg
	lTAVsB6Pfw+CmNE+AQxboIYxPQIu6Rg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-FLYmlZ_LPT6qGL2VoPPXrQ-1; Tue, 23 Sep 2025 06:08:52 -0400
X-MC-Unique: FLYmlZ_LPT6qGL2VoPPXrQ-1
X-Mimecast-MFC-AGG-ID: FLYmlZ_LPT6qGL2VoPPXrQ_1758622131
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b98de0e34so45485925e9.0
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 03:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758622131; x=1759226931;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nAJnOq7wJ5XI1FIJLe0LF85/fgqZuSixFEm3aUU2pcI=;
        b=igqp9PbI+N/fX572RiJdFyMDxEI1SCRG9jhNSXIMGrq/GaHaacJPK3BKxEPBVAaKAp
         s/o/IkhuaUupUmwzPVevF7a3btcSt8G0p/nU65KwY0Ok1ck9NQ0mrxfuTVPwrocJeONL
         zcneNdyITScW8vCpjmIiLqrDeOLHTn9Sh/12ST8UdM1NdF6V5rub6/8WDhKktEhG0Ks1
         v+IU1KPkpD+jEI8YvKU8HOS/YP+4JCeU+RNVnABJ04qd3uJEXHdgbIEEY8agVyed0zkM
         2j4jJY6JxEvqw/xqGJ3WIZKe3VqYxcHGtwR1WZVg+jaCQqUtB3P4zNRc/KjnJrH01qRD
         arCw==
X-Forwarded-Encrypted: i=1; AJvYcCXSPogHObzB9krCel5NZ9NbkBWL57uCIAed2K83wFvAidnM3YlEA83ygFqMmfYm3gH8ZIM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb1hZJsgdprRVN17Zp/GZoo2Ptjv7ocRWHyu34rBWcfkmMpg8N
	V5+1wdjud4Mj09Qj8ECTTIvStO672Jvdj6/uMQsm1Vac5JZCQm4XwNMMOlsZn/KpA6002pY6Rcg
	KX9lpQS0TiJTeK0NYSBefAFEtk7wGzGAEZm16RKSDHheowN5waY8GfA==
X-Gm-Gg: ASbGncu7NLdzmGWTQ3savh3rlfrmI8KFBzJDyr8jd8NAocXIM7J6LX0fLBLjsPG7dtb
	geY9Pbjp18L7wCNrCzcvnF4qLo1TmXf1aOjUWf9+4GQWN4S2IOOQ4uPIqgt83AxlFLUUGgcsHr0
	2KmSdkKgOwNUaEIzfs6xBjsn22jBkK/L+zolv2DahAxxg8Ioi92GiwajCEPo08Pt4z6eryxfu97
	hG1bQJL+sDBFR7QI9c0RMOf1bbEFKFzz85HRe6Sm68WwMLE8R21gZF8GsCbvKNvNdGvYt1u19Zh
	pJKB2G5qboAKw/N17PEY2erYaBx96GZlcKI822Kqo5wDKZqCl9ifNev0KtEv9gsBzIvp+TMKrj/
	79xBOYwu8rzr3
X-Received: by 2002:a05:600c:a48:b0:46d:45e:350a with SMTP id 5b1f17b1804b1-46e1dab50e6mr24289885e9.17.1758622130986;
        Tue, 23 Sep 2025 03:08:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGiVBoeiv8DFrvBqu78ojFZFjTSEy+NrpSObi8FAlZe/hiEW3VVmVz2sDexaIeGuLuj+QBIg==
X-Received: by 2002:a05:600c:a48:b0:46d:45e:350a with SMTP id 5b1f17b1804b1-46e1dab50e6mr24289565e9.17.1758622130617;
        Tue, 23 Sep 2025 03:08:50 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee1095489asm22527408f8f.24.2025.09.23.03.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 03:08:50 -0700 (PDT)
Message-ID: <790a6a0d-4611-4cad-b72d-a99daf7abb14@redhat.com>
Date: Tue, 23 Sep 2025 12:08:47 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 05/14] tcp: disable RFC3168 fallback
 identifier for CC modules
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20250918162133.111922-1-chia-yu.chang@nokia-bell-labs.com>
 <20250918162133.111922-6-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250918162133.111922-6-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/25 6:21 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> @@ -525,9 +527,10 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb
>  	}
>  }
>  
> -static inline void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th,
> +static inline void tcp_ecn_rcv_syn(struct sock *sk, const struct tcphdr *th,
>  				   const struct sk_buff *skb)
>  {
> +	struct tcp_sock *tp = tcp_sk(sk);

Minor nit: please leave an empty line between variable declarations and
code.

>  	if (tcp_ecn_mode_pending(tp)) {
>  		if (!tcp_accecn_syn_requested(th)) {
>  			/* Downgrade to classic ECN feedback */

/P


