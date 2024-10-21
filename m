Return-Path: <bpf+bounces-42590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 035AE9A6138
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 12:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6BFF1F22A0E
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 10:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A791E4919;
	Mon, 21 Oct 2024 10:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hq52sTMJ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92E41E47DF
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 10:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504994; cv=none; b=pq9omXONw74wetqhEZaisylIqVJukf4c7w8HhlZf4jWLyWfBQOZ0Cen3LKcl+FcPDzaCIURahSMwNUYME79jLiefdQYsJ+qDHL2HQ0GZ4g81G4Fjz6+NeTFEM12OjVVOHpdDZS5OkasBcubCk537/GkF321zAQBRo6hqhegF670=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504994; c=relaxed/simple;
	bh=I+fgLQYvZA4NHmjabi9mLzQKoBBv8sQ86evUvZ0B3KM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nGdPJfkaFlFgIBtHJSUoU9yypzl3Ky02V61iqQx0Q2vMkl49waPN4E7UkC0eHUilXUrSq0BBszzevHcm7WRhOcB/pv54zTIOuXZEX4pas3sZ4B7WmRX9Y5mWkSUNN/n9GjM8F9Paaq0KD9tPMXcPk5LTv5bCTMvaJQbH7iOFfK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hq52sTMJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729504991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xyJEmcQ9WC5ci3BgLXvbHouj36m3b4UCzV4/eAbKmds=;
	b=hq52sTMJ5GyfhAsIQCgqRyU9GgeSbML7nAgnNfLwvb0aPCxzYrCmZ6ymRA+T9jQ0IYFfcq
	gsqKnfGm6nxHPNEXciVd76sT/iVmz4SLBIIFxCgRquGbd1sWRVryy2yJV4nnUY4ExBaf/M
	RlqSCNa9dXqzOg9gyWFaBmbgyJuDcnk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-J11mLquWPJeMtqnOdnXjCg-1; Mon, 21 Oct 2024 06:03:10 -0400
X-MC-Unique: J11mLquWPJeMtqnOdnXjCg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d537292d7so2999838f8f.2
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 03:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729504989; x=1730109789;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xyJEmcQ9WC5ci3BgLXvbHouj36m3b4UCzV4/eAbKmds=;
        b=pptR+/02p0eirh4luSR2m2V1TzscGTYz3isrtSPdJKPIzeH4oqM/8NA4N56a6H7kab
         /yCSjYKDU0CK60UtbO+tjJaktHn+3NawCCA0oH0TSiKoSXDpm93cxZawgpmxVofzZLKo
         VodLMM7nUIUCYbEv77j4xuB/cUh/maYmw/lf9ichSd4Sqnhl3AVIvrNM/wX1rEtEALIu
         MDEyFkvgKPfuMdy84yZSL4t67K6hCZcHzeeZoRwIduyVljXyddoeBldXVI7g0pXw0hP0
         HuZkmY/LqUxH5+oRn/GOnFQwznetzidDlUbfoMYUKIYca29EAqy/xhLjhFH9rkkHQZu6
         hK3A==
X-Forwarded-Encrypted: i=1; AJvYcCVbzlDp4qeMcN+PSBAlCGmAs/BYnijbsswIS48UGDg/fJ/6YJf45YDe5ykBjO71tAMEGqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/V42qFwgDhrvo9wy0Lsz56yCo0hTwZjrp8LzF5df6dUv+i1v9
	CGbl7jVuN/csNv9p+CTfchaCzp3T6ELcOLWRFZ4hUDD8ZJOvWaYu0JAE5TKiGriiK2RrbetY06R
	r/Ej78sal4u68nGxQQwHW6YvG9t1BIJUSTUydXhs3CVWyUKf2Sw==
X-Received: by 2002:a5d:45cd:0:b0:374:c1c5:43ca with SMTP id ffacd0b85a97d-37eab4d1157mr8503630f8f.32.1729504989291;
        Mon, 21 Oct 2024 03:03:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9g89QrZrvWMTWImI7QH5apSf6nTS4fXvPKvygF4vW9LE+7/wxBk6jbiygE/3PCkrJ2u0ofQ==
X-Received: by 2002:a5d:45cd:0:b0:374:c1c5:43ca with SMTP id ffacd0b85a97d-37eab4d1157mr8503606f8f.32.1729504988968;
        Mon, 21 Oct 2024 03:03:08 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b944fbsm3940643f8f.72.2024.10.21.03.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 03:03:08 -0700 (PDT)
Message-ID: <86d785cd-41de-484d-ae17-ffdb4aa9393e@redhat.com>
Date: Mon, 21 Oct 2024 12:03:05 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 01/10] net: ip: refactor
 fib_validate_source/__fib_validate_source
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 dsahern@kernel.org, pablo@netfilter.org, kadlec@netfilter.org,
 roopa@nvidia.com, razor@blackwall.org, gnault@redhat.com,
 bigeasy@linutronix.de, idosch@nvidia.com, ast@kernel.org,
 dongml2@chinatelecom.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, bridge@lists.linux.dev, bpf@vger.kernel.org
References: <20241015140800.159466-1-dongml2@chinatelecom.cn>
 <20241015140800.159466-2-dongml2@chinatelecom.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241015140800.159466-2-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/15/24 16:07, Menglong Dong wrote:
> @@ -352,6 +353,28 @@ static int __fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
>  	struct flowi4 fl4;
>  	bool dev_match;
>  
> +	/* Ignore rp_filter for packets protected by IPsec. */
> +	if (!rpf && !fib_num_tclassid_users(net) &&
> +	    (dev->ifindex != oif || !IN_DEV_TX_REDIRECTS(idev))) {
> +		if (IN_DEV_ACCEPT_LOCAL(idev))
> +			goto last_resort;

IMHO the re-usage of the 'last_resort' macro makes the patch a little
hard to read, as this is an 'accept' condition. I think it would be
better to retain the original code. If you really want to avoid the
small duplication, you could instead introduce an 'ok' label towards the
end of this function:

last_resort:
        if (rpf)
                goto e_rpf;

ok:
        *itag = 0;
        return 0;

And jump there.

Thanks,

Paolo


