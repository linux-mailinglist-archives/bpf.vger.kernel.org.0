Return-Path: <bpf+bounces-58536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 269A6ABD3BE
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 11:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CECE98A16FE
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 09:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D03A26A0B1;
	Tue, 20 May 2025 09:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H20gj8sS"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18795268C51
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 09:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747734250; cv=none; b=Nl2rU3Ru/C3ZMI1jcTv5WuRG3owbD2KdRwejh4Ad0dv1fPyLUp5pZksETFNHpf+Hq1KJEa4wbaXKoIlZNvFQVEivf5hlH1S7NYSzKD+tfEdCdlHMACgXbsbX8P6ypDml+ZZou9rlkN4XCJ+Eee8yv7T6gtsvX7Ow+wR2cJweZJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747734250; c=relaxed/simple;
	bh=GdfrJ9wEalOSO5bv0hmoFkzoT7yB2DwWV6SQJUpoaZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=M35QhkcNVbpZSLqy4o1SAd5/PiqWTdwtf8Yf8b0bIQpsGAJ+yGauQJUE+ERjzJDdhf8UqHKYWI9l1fgfsEu6JiVI2ujVRLU3F5WTRyz51DhVWq9zdjhFgAl38I015uhJUg+KM13Caw6MfEn3lvx5E5xSHspqlszAeFZ8G9DdMI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H20gj8sS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747734247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oVjYCglGOjhQOwhRRoCVF9gAuVp//nFBUyUL3xi0qNE=;
	b=H20gj8sSkKnuFQyMUepG6DhvAQXcSVeyQGpMPZexZDAIN+neRxihb5drYJtDAR7oPEdEyB
	p45hTz3bmuxLesJOOoixE2wRy3SO+rbGcb4IDJrcZr1OaanrZnruzldF5IQfc1+bfP55r4
	IsYzBDxeq1/kzYA2dk7SYTE+Sle/drQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-1mLrxQweNj6fo9pVyKkNNQ-1; Tue, 20 May 2025 05:44:05 -0400
X-MC-Unique: 1mLrxQweNj6fo9pVyKkNNQ-1
X-Mimecast-MFC-AGG-ID: 1mLrxQweNj6fo9pVyKkNNQ_1747734245
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a3683aa00eso1418167f8f.1
        for <bpf@vger.kernel.org>; Tue, 20 May 2025 02:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747734244; x=1748339044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oVjYCglGOjhQOwhRRoCVF9gAuVp//nFBUyUL3xi0qNE=;
        b=pBzrA4wvpnO3GYXSKosTXahd0z1XZHB1ZnH5WRntcbycgfPbDKEWGqkOrvcgSxx39H
         wSll73pfURtivEUk195cSeO7SiUI+0l+bXwDXRZXvoYZevqN4bS705oH5lcC3bjPCZj1
         qAGl/X+/IZPTVLv0rhP8yWmrFHj6JGr9OcbQWvHdeyVsEXexDXNt2Izxx5BoXIIV4iJK
         k08JESwnN2KsaJmP9ZqBEOWTKu77EaZKcfHLtxdn51OfOM6zKcAXewJGXzMVkE2bkfdg
         5s3px9FxN7YV7Tc+3mceb5F1W0dIMUJVXTTo6LRdZqb/a0PViwSDmiwOtDh3lrOmzzb/
         PyHA==
X-Forwarded-Encrypted: i=1; AJvYcCWYGmZ+QuKE5+9ED5gTNDPxlYqTCSuzrxajiJ1NFkkMCCGAyLLMFfZ6z8cdbQtozNDK3HA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrPPd5BybQL0c4yp6WVdsON2pLsLwmdLEjRyaz4nUJSF9UY3i9
	NtcrbbPpR5FMy42AnA9/SNGj4H8L8h6C3Ydyn3lLBbdJG9IMNB5Qpzgx0ho8ZlGk/NaGyzl9cbM
	4B+1YItjpFhvZSHX6FZWXieKonWubWMbKcHpNUqk4a2JMkd2QAQglPQ==
X-Gm-Gg: ASbGncss0SO+vA54K5JxrG5uZIXS42kYRAbEiOy2TMKbW1W/uKPO6WY/p7/X2NOK8Z5
	qdW5ytoE76c2hBI9jOIcb/7hXxwIO7Qt4gZ9MU16lBF0QUwbLRH9lTni8nsciRW24uMbDLyjlqY
	E5TNkka+/yEOgclFYbCT+JBYXV2U2ZumVqdgx+ndCf2Z+Y+uSxzL0bSNis943SjFNKW1JykpXvD
	TBaeA8SOIF/C9y6zzazHU6FVVpUkCetVPqvG415dm1EulSj2r0YAX5Sopqf6IsjKMwN7mZG6Ldu
	0TRguIjKSHpf0VA4kKK5drIzKYaDZ2+MUwy0ry9ObUEo9wmbINpPSXSxSZY=
X-Received: by 2002:a5d:5f4f:0:b0:3a3:6d25:b8e2 with SMTP id ffacd0b85a97d-3a36d25babemr6669825f8f.6.1747734244567;
        Tue, 20 May 2025 02:44:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2oghOI8vAadYac9W7SXycaXiUvUjylnYzfxLoDCc2r39zb/TatFV5FbKXsSsW2LJtvpmuhA==
X-Received: by 2002:a5d:5f4f:0:b0:3a3:6d25:b8e2 with SMTP id ffacd0b85a97d-3a36d25babemr6669787f8f.6.1747734244185;
        Tue, 20 May 2025 02:44:04 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:5710:ef42:9a8d:40c2:f2db? ([2a0d:3344:244f:5710:ef42:9a8d:40c2:f2db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5a04csm15574156f8f.23.2025.05.20.02.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 02:44:03 -0700 (PDT)
Message-ID: <f0941549-904a-452a-aafc-f42763d13d9e@redhat.com>
Date: Tue, 20 May 2025 11:44:01 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 06/15] tcp: accecn: add AccECN rx byte
 counters
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
 <20250514135642.11203-7-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250514135642.11203-7-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/14/25 3:56 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index 779a206a5ca6..3f8225bae49f 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -497,10 +497,11 @@ static void tcp_ecn_openreq_child(struct sock *sk,
>  	struct tcp_sock *tp = tcp_sk(sk);
>  
>  	if (treq->accecn_ok) {
> +		const struct tcphdr *th = (const struct tcphdr *)skb->data;

Minor nit: please insert an empty line between the variable declaration
and the code.

>  		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
>  		tp->syn_ect_snt = treq->syn_ect_snt;
>  		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
> -		tcp_ecn_received_counters(sk, skb);
> +		tcp_ecn_received_counters(sk, skb, skb->len - th->doff * 4);

There is an identic statement a few lines above, possibly worth an helper.

/P


