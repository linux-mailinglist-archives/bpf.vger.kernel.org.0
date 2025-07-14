Return-Path: <bpf+bounces-63205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E66B8B04278
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 17:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0488E4A49A6
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 15:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BF325BEFE;
	Mon, 14 Jul 2025 15:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHlm/59X"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB7C259C84
	for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 15:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505237; cv=none; b=W5SqOIeHJFL87Xja/eacdAnw2IfKdSbKmOVhXahmRfnHiRe95nuoD6UCuKfUv1neGeBt2LysyHRvMqom01SHlYloku50m1AmOfeHlm2/lI6TNQzfxqMpYcCxkg1KjJK42HsVmNUYPywS9vixE+CfO8eY1+qyfniFmfdiHhb759g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505237; c=relaxed/simple;
	bh=IHKSZdBg3WcFhFDOVCLrgHqXdaBXMkfRz+CGmXp1u3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VT9utcRnPWkJVyhdwrBrQEzg5Weu0hgHIquHi/QGiPFs13SmMdVRJ2JN21eIu5/m+tT0y0bNHkTu9wXFSjnwDlerUo5/gv2sYYQx2NZzwtaaH/+Bxi4j+CpjJTvccqWRRof50KzP0Kr6pgPvVeBWfVAUMyIgA1RpQ4yDvMfFG+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cHlm/59X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752505234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aFwyX6lIQ0fjoLyREcaVc/pevM031iihhbAQ/uu7vB8=;
	b=cHlm/59XL6xIPLOGB9cvD+Ggupaog3r1L3iWBVLpiLXsOy4fl5VARqwHbd23tUOAs1qJeo
	8CLDht86gwKF/bQDCs8diJbsL9YbqhKVrDkWzKUL/KGxXZUFDh9gdFHiAcbYDdyE1VNPHW
	PvAapgmlfLLsG7uC9b52QioxhKUTyXM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-0CPmEe3YNOiJyPIUS4q9sw-1; Mon, 14 Jul 2025 11:00:32 -0400
X-MC-Unique: 0CPmEe3YNOiJyPIUS4q9sw-1
X-Mimecast-MFC-AGG-ID: 0CPmEe3YNOiJyPIUS4q9sw_1752505229
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-455e9daab1cso5905325e9.1
        for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 08:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752505229; x=1753110029;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aFwyX6lIQ0fjoLyREcaVc/pevM031iihhbAQ/uu7vB8=;
        b=ujOgVQws1sfKkrQxQoMMArl/rFbp1fU1vtT6XjKShx8qSSoyDAGXKrHMHxYvacrGYD
         p8ztZ4TuiGn5a3QKPv3FtzP93pXtfMFOG8j6kkcSuhjW5wDJfTnbxnFrDLrO8hCEgyq8
         FIRk/kLyGf4witI5pJbBs7iXH1PWPIbfWWYWL+aEb1P5h0X/S85F8WKzjyWHInWYN5lY
         I+esvBy6pnQC+yzj7KWJdLqqlZoX90munzOS6XvblbWXKVA/XV9JZVLg2VN2KTleE3IP
         V4781LljpROMYL70BBFQAEvarv//hPQ3LE1P7Sq3Q7ITwxd41lgrg9H4ePAaaG3WKI9J
         sP0g==
X-Forwarded-Encrypted: i=1; AJvYcCUMlVlNPWf28E4rQhaIPdZ4yhSbj/LBS+TIcfYlakRRrQWQyTfusVV2GOHnYxedFMgFbhY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2wom+AJkmaerXq2w/nxIK0KFqwNDs1bw6y2g/RXE0K0q1VJq2
	NPL/AVj4ToQw+vK6tYuh7+lPNH09M9pISXJZOMmUqKce9TUrzwYh/2iKfmGFWBouJeV+A00H4XW
	WHf4/2T4Lard2uVcwUrMxByaWeNp5JVlZmZRRTvIxES5MdRoebvIuMQ==
X-Gm-Gg: ASbGnctjxJqMjfMYtWtzrxVaYF1zBWoSqtgO7iZWOd/T6IiofCU9Nkdhzu31CnXnpDr
	FpQ0H/XfEz9HX0qU75XCAWpUKMbegk2loeGaYkayPjLVXo9nb3xZ1foGD/s16E8F8xRwDgd/HKM
	zbTZGZXTGqblVlkU+Wthst89lVwu/Bv/kqpZWVmi38oOK9JUp22SoXDFKnTEKqk2/APcQPnJ5/u
	6Ir/1KmWWPn7mS3d8l1p/CM3sXP94JOND/NbNYerFdkHDCpUrG0WFU7RyNUxpbdZx3KLEKcRBZL
	o9WaAbhAoMpDpTKz0lSEmfEUT7BlQo3yRiaF9QL8K2w=
X-Received: by 2002:a05:600c:37cf:b0:456:fd4:5322 with SMTP id 5b1f17b1804b1-4560fd45573mr66168735e9.11.1752505229183;
        Mon, 14 Jul 2025 08:00:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/DiiAZoBKMtGEbuxHY6nd18x8tIp6jAQkUUQbuvelaXC253z18SXm8PELPhx5Rs/OhWM7Ng==
X-Received: by 2002:a05:600c:37cf:b0:456:fd4:5322 with SMTP id 5b1f17b1804b1-4560fd45573mr66168005e9.11.1752505228616;
        Mon, 14 Jul 2025 08:00:28 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.155.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4560ddf5e0esm69819555e9.18.2025.07.14.08.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 08:00:28 -0700 (PDT)
Message-ID: <0e71834c-881e-4a13-a2c0-3443e2ab7605@redhat.com>
Date: Mon, 14 Jul 2025 17:00:25 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 net-next 13/15] tcp: accecn: AccECN option failure
 handling
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
References: <20250704085345.46530-1-chia-yu.chang@nokia-bell-labs.com>
 <20250704085345.46530-14-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250704085345.46530-14-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/4/25 10:53 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> @@ -443,9 +456,34 @@ static inline void tcp_accecn_set_ace(struct tcp_sock *tp, struct sk_buff *skb,
>  	}
>  }
>  
> +static inline u8 tcp_accecn_option_init(const struct sk_buff *skb,
> +					u8 opt_offset)
> +{
> +	u8 *ptr = skb_transport_header(skb) + opt_offset;
> +	unsigned int optlen = ptr[1] - 2;
> +
> +	WARN_ON_ONCE(ptr[0] != TCPOPT_ACCECN0 && ptr[0] != TCPOPT_ACCECN1);

You should probably error out from this function when WARN_ON_ONCE() is
true. I've no idea about the possibly meaningful error value to be returned.

/P


