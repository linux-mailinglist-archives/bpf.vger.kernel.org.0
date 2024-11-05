Return-Path: <bpf+bounces-44027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E8D9BCBCA
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 12:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D601283A23
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 11:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582E71D5143;
	Tue,  5 Nov 2024 11:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LwISbJSW"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35AD1D435C
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 11:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730805956; cv=none; b=mTC2s2a4386lr8mmILwk7VDIA/qtCmGYcCZe+P6BoCnyg5XfYfCwK0VWlBkTlB52WX0NXKSDkXbLB250M26HkaX22oku60VqOHg7BHW8E1W1Fhyl19yFzNvCCskqKY53+QAxOu9FDFM4y0QOW2BzFI2RbXDvNy1Q0LxbjnRkoEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730805956; c=relaxed/simple;
	bh=8AFVGRwtaJeSF+KSoKYzsx4Byj0svgLauYfW+TOaTno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=puJvVaXJkcdn8vsyS2YcX8ZoQkzqDalV9KztmHK0MBZMqW2Nk8gBs1Oqgd1lIZUmJzkpKBsBRnAexRj94UiL4cNWyrwZQWSGJ3FO2u2kyTxbaTi5Jg9n5KBOwD/bfbzvoYIZspVBYCHJ9+rSWEH58c1TkLwS1S5R0a2a/T+YCmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LwISbJSW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730805953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AsybYOao8j0qbOJ+5wLogVpuC2sFzLXUAO410jIN/GU=;
	b=LwISbJSWt4++gRUA8KOJfm53IMVcvuzSoNqdRMiARnWWeEj3U6prHgwuc5iTjJ88iiLJBL
	+Q5yl6x7UlQ5Hm0z7gJKFhDkBFBlXWlTj7VkuNCG6BV6yY7RC8D+8CHymkmm3vvQz8Ldmm
	/fldtCyVD/OwQINff4nc0hRs7uLlir0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-5ESzRhohNGmpBO1rlurwjg-1; Tue, 05 Nov 2024 06:25:51 -0500
X-MC-Unique: 5ESzRhohNGmpBO1rlurwjg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d537292d7so3619076f8f.2
        for <bpf@vger.kernel.org>; Tue, 05 Nov 2024 03:25:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730805950; x=1731410750;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AsybYOao8j0qbOJ+5wLogVpuC2sFzLXUAO410jIN/GU=;
        b=uwt65MvSEU7w4GaQuECXi9f0yzzi2JhwWrOta9WSRoQtqlxf7J5GbW33HV7bQYtf/Q
         0JNbenZxKndPbFlmeBQHQaEXjVhLjPbd0fFWcYEjDLl+PcV2zsmhGr6uSk+0EZ7Aaysi
         ys2P9pWsdDtPV+mQkljRYQr55uSngbxtZTujGSDhMeYLjb7gbMRR9kdvinaAeRMbs8G/
         Oq0jycBI8tRjGFLy1PqdJMhGFOnqZT5oz5qwYZPJhsbXeeviWz5L1OdElvPXUs7RrVue
         yiKKZoHlLk5fiMsrvVi+E/4u33UYcxZywiwc7EfsZxoIJK90WW4c6MFJQvJ1+2rXVZNE
         XjiA==
X-Forwarded-Encrypted: i=1; AJvYcCUckXCdLNmSazzjzQnB0AyC/AZgetVqkxIDsOFKkFKPjKl27b8iphAuvMwZJ95uBuOMkHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP5AhDpckZA26Q5+UfKRo0lyT76jwVpgxR24McVGOsuWw6ZPPc
	l97UDq+0uOyWaZSAS8FLei/5CMyjcI7f82513IkS+uo3ad8gnoiPj6CMp3xrRxiBlb/kfCsAAGU
	6c6G0j1rxRlDzjuGxiPXTTp0CuhpiH2ITGiH9ASRO7DsqFr7AFQ==
X-Received: by 2002:a5d:5e87:0:b0:37d:39d8:b54b with SMTP id ffacd0b85a97d-381c7ae1552mr13768270f8f.58.1730805950643;
        Tue, 05 Nov 2024 03:25:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjLB5E+ROQ7F6DRPhVbGIzb5at4ILUKJu3X2OrRGqPJDFCPvEe/hdkUEhFiHeOv+TQOCR9oA==
X-Received: by 2002:a5d:5e87:0:b0:37d:39d8:b54b with SMTP id ffacd0b85a97d-381c7ae1552mr13768245f8f.58.1730805950234;
        Tue, 05 Nov 2024 03:25:50 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10e7449sm15923971f8f.49.2024.11.05.03.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 03:25:49 -0800 (PST)
Message-ID: <7b8b83b4-f745-4f3b-8cac-2f190937667a@redhat.com>
Date: Tue, 5 Nov 2024 12:25:48 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND net-next v4 8/9] net: ip: make
 ip_mkroute_input/__mkroute_input return drop reasons
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, dsahern@kernel.org, pablo@netfilter.org,
 kadlec@netfilter.org, roopa@nvidia.com, razor@blackwall.org,
 gnault@redhat.com, bigeasy@linutronix.de, hawk@kernel.org,
 idosch@nvidia.com, dongml2@chinatelecom.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, bridge@lists.linux.dev, bpf@vger.kernel.org
References: <20241030014145.1409628-1-dongml2@chinatelecom.cn>
 <20241030014145.1409628-9-dongml2@chinatelecom.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241030014145.1409628-9-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/24 02:41, Menglong Dong wrote:
> @@ -1820,7 +1822,8 @@ static int __mkroute_input(struct sk_buff *skb, const struct fib_result *res,
>  		 */
>  		if (out_dev == in_dev &&
>  		    IN_DEV_PROXY_ARP_PVLAN(in_dev) == 0) {
> -			err = -EINVAL;
> +			/* what do we name this situation? */
> +			reason = SKB_DROP_REASON_ARP_PVLAN_DISABLE;

I don't have a better suggestion :(

Please drop the comment and re-iterate the question in the commit
message after a '---' separator, so we can merge the patch unmodified if
nobody suggests a better one.

Thanks,

Paolo


