Return-Path: <bpf+bounces-73823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC62EC3AC82
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 13:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F391B34D16F
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 12:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF85324B2A;
	Thu,  6 Nov 2025 12:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CJ9nmZnr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="g/zlq+Wp"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63871322C81
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 12:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762430849; cv=none; b=WWH3bddIOL4Be4FJTN8U2mNKBnp2brF2DDamTYqrQB22kr5XylyADHNaZJNX5k0jg09tVsaJURTFf5Pbxnr4EbYQQdGkt09AN/FpywmgVQhW0vICIKqpAE8NIVphN1UfGpYXCNxTRPMtz1tRsYs8H5E1d1EM+XMK6XorSJ47zDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762430849; c=relaxed/simple;
	bh=IYqfFJNvPfd62Bb/O37mPF31V+FC5WYlcRjL6D8j4zs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MGRwRMlchkGa4qN+Q5nMFa5hHKaKrJ+3ILk//+w4DzBOFreoQrDlOwIUeM77gLzjvRdUrAkgxlcQ23OaqKrSgq9/PUmJe/aN80NuY7cSZyUTqER2K6XJaOsYXjXadtjfRTG1FTqWQualtImMMfy2somdbenl/Yow231ZpaqlONE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CJ9nmZnr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=g/zlq+Wp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762430847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+gQ4lVmNvCRfpjsdJ7H9mkpnntTRrFAHidg+hA5PZ9U=;
	b=CJ9nmZnrfLJVw736Y4hTcp9hdJZDyTSYdelhZbAMN7D2Go50ZnUnfY7eDfKbsQ5Yfi1g3c
	1+Q9UZHqVEmhCYPOlU6xUD8usQSzVOjvzZR+I5QhXflAXwaSf1FdeGjsbDvQDtlG2a6d3L
	ApumeWS7UvpRdlENc/pb+IzsG5eIFXw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-yZXJLfQkMIK3c6Sdx_gp6Q-1; Thu, 06 Nov 2025 07:07:26 -0500
X-MC-Unique: yZXJLfQkMIK3c6Sdx_gp6Q-1
X-Mimecast-MFC-AGG-ID: yZXJLfQkMIK3c6Sdx_gp6Q_1762430845
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-471201dc0e9so7767055e9.2
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 04:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762430845; x=1763035645; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+gQ4lVmNvCRfpjsdJ7H9mkpnntTRrFAHidg+hA5PZ9U=;
        b=g/zlq+WpDKimWpmkeKyt+MKx5G2ziwSBbDzLXgB48UtqegEJt1zP+2pce6jgxO5O1W
         DyUq85pBlOGO2Av84/eQuZY4MHMVK95Y0nQ150v+3fv4hPkymO7paXneC5SrA9URPqTc
         KIF0GIomqTq8fes1+EOHmEeB2lG598o+L7TQJC+8TwxtwyDj1zHz7fkx6cRYM56rSbDo
         Cx8kGDiV1OnTAuUzGBCUxUpXm6U75fEZBet0s2rRBe4eFFPP8Eh8scVkw6r9bfOUC7xG
         2jvrOdmE2oe34GpL003NkC6gLNwRP1V7MvuvI2LglOQkmDWGrAipSC8lZUhQfhYF/ZNK
         yLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762430845; x=1763035645;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+gQ4lVmNvCRfpjsdJ7H9mkpnntTRrFAHidg+hA5PZ9U=;
        b=UUjobXTccSe20l/MxvI+8R/6F9M1JTLIpFZv2r9LNUwPrxaf8bgisvfdkLXejpjiZe
         DeyxwnTeY7lQEjCLLbPyNH0q8ikjxk/Pxirn1LSFoj3aBwNVESJjlG6g69dzz0titJD2
         s6tzFCaaMGizDmreyrVhyNyhjjQ3GlHzu/XAjD4DyExjjvmFtdb2K8z0fjbZEXBMgGgA
         sjl1/QWMTSjaRzUvv7lgWI95OKWvirRDo8N9oFFvpHZquHxFVY0k2kvk4rihfT4kjFqn
         VQ+yaZfgRs0rglz8cRqJgAa7SmDQ5/8sjrr1IB7t4n1WjKJSUrmXccZ0uO9j535IuD0K
         pwdw==
X-Forwarded-Encrypted: i=1; AJvYcCWktWC2UX8Bgn/ItkgN9Dwt4n1zoE34JtiLt4CVVjhsvKMAJy5oHuNxbPTU0ZVKwJ/It2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6jG6cbTYCGISEWQ4h+3FS6Ptuvg33nEirv09oLzptBDc3T5z1
	rdzVg3+ZICdPrIflUVrNbDFWP7etbsIGzSBENzQ4L5vIWRtHLnGE/qzv+pXy8XzMw3f4CaQC1UE
	V4PQ9f4zHzyY7UPGCIrq10ekZXuF9JEDezTgP2aF1J0RThIbyGUB10Q==
X-Gm-Gg: ASbGncvlxBGxGFheZNP8wzK67CG1bj6ecspNUlr6orZSeaOyGXg48BtNZFlVXEpW+6T
	3ssPg73qM5IR1cRkQzD3mSBjk0qZVO4bK8m1dBXxRSLrf2G37oEkrPnfDI7Aff4JBI8rmv6iPf6
	zoKHatwkSOcXcTWQ8ij9WkJLn6iW2Iat4rafiWg2r49UWY1w3TSyECaPe+S1ZLNJnnVlGXt1TWq
	PxjgAbcnQVClMIMtgVBYIy4aNrrVbN9ercAMRDw5sYytXOXFOAbnieHhmDfY9JFEqLN+lEs7Ykf
	cCRBsT0D7zHh2x1fMXJkrIm+n5CJ5L/AgRxfuZn+D9Z6RDBfr7O/cWRmh0+/HCrpYck6mc+Xdwq
	KBA==
X-Received: by 2002:a05:600c:4e88:b0:46e:46c7:b79a with SMTP id 5b1f17b1804b1-4775cdad65dmr61056475e9.2.1762430843031;
        Thu, 06 Nov 2025 04:07:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFx03MVe1UPLGcOQ/uXdT9zWecweOElKZRclz+LOkTGKy97++ZKxB8Kf0/fNaib1PlyCL3ejw==
X-Received: by 2002:a05:600c:4e88:b0:46e:46c7:b79a with SMTP id 5b1f17b1804b1-4775cdad65dmr61056065e9.2.1762430842523;
        Thu, 06 Nov 2025 04:07:22 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776250d3d0sm45954345e9.7.2025.11.06.04.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 04:07:21 -0800 (PST)
Message-ID: <d1045b08-2cc9-42c7-816b-ba467c27086c@redhat.com>
Date: Thu, 6 Nov 2025 13:07:19 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 10/14] tcp: accecn: retransmit SYN/ACK without
 AccECN option or non-AccECN SYN/ACK
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
 <20251030143435.13003-11-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251030143435.13003-11-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/30/25 3:34 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> For Accurate ECN, the first SYN/ACK sent by the TCP server shall set the
> ACE flag (see Table 1 of RFC9768) and the AccECN option to complete the
> capability negotiation. However, if the TCP server needs to retransmit such
> a SYN/ACK (for example, because it did not receive an ACK acknowledging its
> SYN/ACK, or received a second SYN requesting AccECN support), the TCP server
> retransmits the SYN/ACK without the AccECN option. This is because the
> SYN/ACK may be lost due to congestion, or a middlebox may block the AccECN
> option. Furthermore, if this retransmission also times out, to expedite
> connection establishment, the TCP server should retransmit the SYN/ACK with
> (AE,CWR,ECE) = (0,0,0) and without the AccECN option, while maintaining
> AccECN feedback mode.
> 
> This complies with Section 3.2.3.2.2 of the AccECN specification (RFC9768).
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  include/net/tcp_ecn.h | 14 ++++++++++----
>  net/ipv4/tcp_output.c |  2 +-
>  2 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
> index c66f0d944e1c..99d095ed01b3 100644
> --- a/include/net/tcp_ecn.h
> +++ b/include/net/tcp_ecn.h
> @@ -651,10 +651,16 @@ static inline void tcp_ecn_clear_syn(struct sock *sk, struct sk_buff *skb)
>  static inline void
>  tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
>  {
> -	if (tcp_rsk(req)->accecn_ok)
> -		tcp_accecn_echo_syn_ect(th, tcp_rsk(req)->syn_ect_rcv);
> -	else if (inet_rsk(req)->ecn_ok)
> -		th->ece = 1;
> +	if (!req->num_retrans || !req->num_timeout) {

Why `if (!req->num_timeout)` is not a sufficient condition here?

Simplifying the above condition will make the TCP_SYNACK_RETRANS
alternative simpler, I think.

/P


