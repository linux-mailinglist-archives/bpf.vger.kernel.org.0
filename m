Return-Path: <bpf+bounces-71104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8E5BE25BA
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 11:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B2FE423E25
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 09:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9988230EF9D;
	Thu, 16 Oct 2025 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XoKCLfig"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CFE2E62AD
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 09:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760606717; cv=none; b=Zi2y9IvdNcroFz3X3eetxmkpqQSoSQ9CodfYPrYSIWN8CmnXzv2kpCh6IZHSmJPW1Yqhc5K1+ygWLucRuk8NIqLva06fLfKLZPym+z1b8ys3I7PIGqvGpZbkH3qwCdyWqWTVNf4nnY3NZp355Bpb3qogsaX1MsQLKa1TP/Q0sPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760606717; c=relaxed/simple;
	bh=m2KeARvuTRmdyoLiLI4saJD6ImG7emQEBqfOCbuYQQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bcaWUzSZp00ERvJbAOGq59dmB1ldZrChZXh6t2HpbPAwh/vQHVfuN0FDfmwQisqyS9A+xaNSQWIfvV5Ko/H7KzV+YzHpYu1CeKooodP86KT6RenHI9L52ID6rEMA8OAUgCCrQuF0Fmo9q5nsTt71yg+EJMI6eSsMSMKBsiq4QIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XoKCLfig; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760606714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U6o+0dlH/LO6+L4uMhml00siHNkD8OlJHU5sP6Kvv18=;
	b=XoKCLfigCuDOIdckgLC0yYhjNUUXOLlE3GF4ejj5IuP40pJBmZb4vzY88S2hV/qDraTYUj
	V+3TtRszR+4Re0iyAVnIDgjdRsFntdChfwYFDIEFxaPntMtyx8/L0I8OKLAcE/AMNkBDlm
	ZYJya+NVz7q7212KoIAh7oF+XQvCKMc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-Ni1HZJbUMGyhAnl_y6iQLA-1; Thu, 16 Oct 2025 05:25:13 -0400
X-MC-Unique: Ni1HZJbUMGyhAnl_y6iQLA-1
X-Mimecast-MFC-AGG-ID: Ni1HZJbUMGyhAnl_y6iQLA_1760606712
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-471144baa7eso2968975e9.0
        for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 02:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760606712; x=1761211512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U6o+0dlH/LO6+L4uMhml00siHNkD8OlJHU5sP6Kvv18=;
        b=NnRUhs+diA2ei6xblk7Fjl23bCcIvw9z1ryXCP1BgobDyGMpyqf6sT4wQuJTzYJFqA
         XmbU4Bo8ocPHHMMKiuKa8g/r9mCAPO/++nAGHEUJhX17sEqag9IWGxxi3OjAZdxG7z/g
         dt+gjZd8cgimUPITubWE/3LLbo3tRUW6vUdoOsxaWdrhjlAasMSeSqsIoYAX0NLhK8f+
         wUkv4ELvCcWymaPPI4ZqVZ12SFkLhXd4MZG0mXRNNdIC5fVEJ9m0+nOGQukpoc5LRlmG
         /73jpwgqJcUS75dFcBnboq5tzWC1dTQ453rIbGfvyQeY7T2X0n27ACx/ex0ykkMyGYXd
         udVw==
X-Forwarded-Encrypted: i=1; AJvYcCVdybRW18UnX4nqN+f5UZgRy/G9Cdezg1Mg/bKBXZGyFg1RXGXaSa5gz4YIu1HOOTac8IU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOWLH2Z04TVZ8gSzBM2xnV36S56Q0OVXd4hkl1q3LQ/jOrYiV+
	9sz2pzn9V50vg4fcrY3VnlMeb7GikfDb7K9muke66noTdlacnANDT7hyofELo5P3U2lNkQWRgoN
	l3Cs37Ez7p5Lt3zX929TWdAXjKxUcnmz99afuzj0hGhSTC1VUOogjbQ==
X-Gm-Gg: ASbGncuwudbdxUy8QYEPtkyapbZRzXkkrYXJP/O4+LB9LYiN+cZ9AECi7RgBq3rZJ50
	AxZ0TUMmdhvFHuEwYnkOWWUnfHq6dLa76lgFDhR2Rp1k/yMtzbRdoxsoPfxtKh765TBsOMfTBgP
	WLIsPuH1p3dnNx8Px+tbmUfFsesAb3r0u4rZs+fbUVPVGNBCOZzaY5XZlTS/3JdGfTnLzKaQeTU
	HOq5htNyy0PtXkrN2jfiRx09aI4y4dESCBbFCdJAFb4viNVIb+4ceb8POSjOzQudKlRjWH2/ysA
	CfuU9dkDqs7UK/xFpZHwHtmYrFgcVM6A35lj7P2xnZlDVuozyLKTbeaiFeEVLzj0b7MpERXUvVY
	bZYo6SB2LbOPSgXd4qL1A3fvl+L5CapJnK0qw5nhwUqbYRfY=
X-Received: by 2002:a05:600c:8487:b0:45b:80ff:58f7 with SMTP id 5b1f17b1804b1-46fa9b16570mr237048515e9.36.1760606711780;
        Thu, 16 Oct 2025 02:25:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHODLXNXbl09HgER/Hf+hYD5m43sAstxJrTZCO15jaacFlZi4yisRDZcg7tAy/BjWtv6IsDQ==
X-Received: by 2002:a05:600c:8487:b0:45b:80ff:58f7 with SMTP id 5b1f17b1804b1-46fa9b16570mr237048295e9.36.1760606711423;
        Thu, 16 Oct 2025 02:25:11 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47114428dbfsm14687365e9.5.2025.10.16.02.25.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 02:25:09 -0700 (PDT)
Message-ID: <9ad5cdc8-c900-4ada-ba62-5ee313829bac@redhat.com>
Date: Thu, 16 Oct 2025 11:25:06 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 12/13] tcp: accecn: detect loss ACK w/ AccECN
 option and add TCP_ACCECN_OPTION_PERSIST
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
References: <20251013170331.63539-1-chia-yu.chang@nokia-bell-labs.com>
 <20251013170331.63539-13-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251013170331.63539-13-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/13/25 7:03 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 61aada9f3a6f..edfcce235d2c 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -4808,6 +4808,7 @@ static void tcp_dsack_extend(struct sock *sk, u32 seq, u32 end_seq)
>  
>  static void tcp_rcv_spurious_retrans(struct sock *sk, const struct sk_buff *skb)
>  {
> +	struct tcp_sock *tp = tcp_sk(sk);

Minot nit: An empty line is needed here.

/P


