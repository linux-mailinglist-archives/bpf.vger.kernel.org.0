Return-Path: <bpf+bounces-54168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE6CA64548
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 09:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B73F3B3E25
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 08:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B57B21E0BB;
	Mon, 17 Mar 2025 08:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T3H1ktej"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C96821D3F1
	for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 08:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742199831; cv=none; b=CrmNvgnaKMXJho40udatmyAvh7mk8H1KIC4dPyFfUWrgDWxyZhEbEBE2CoFH6XL5a5ksDew1B+yNfrpYTSojSDcIl9mtsaCwg0iqN6HFSVRtxCKWDjiUziXD57R+QWs3IFxtiwSGaSY3j2xlVKBAbWRZ9aSy0jerm0ZBL9z7PsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742199831; c=relaxed/simple;
	bh=6F6vk/bCuTRFj9sHasYFtzBPnP8c9sLQfBUMl+1ThkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sxm19oixBTVRHJWeqt9h94liHPAOJsIW/e9QmPeGUpx8RxTzFmon1roD+GSBoxEXsFUFTiEDhHU2PTzrtZUWgAgu+rvpmp6s/Imd8xOEEGWwvLisNITVHRjet7AA360fbasXKloScgt+0KT0tzw7kz7qcoMEJjWTvHUgts4OjI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T3H1ktej; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742199828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rC5lK1FxM1eWQXOh9AroE9tnp2td4VImfPnxc4mu+rg=;
	b=T3H1ktejRD0Vh4sK7aDZUzpjaMS6nV/QZlHsgMGOhKwzEOcZyEmPPXxLsqEWE0kvvJNao1
	GQjq2qyskoAOvH0vUjUQdkF6YA/l7stQRNnnNv9H1Ucs+EBRVN4tNaYlBz5nZELtZiDJ61
	VGj5psdB1Ws2uXfqA6vvTstPhiMrijU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-u17aXGz7OuOHGJe20zKx2Q-1; Mon, 17 Mar 2025 04:23:46 -0400
X-MC-Unique: u17aXGz7OuOHGJe20zKx2Q-1
X-Mimecast-MFC-AGG-ID: u17aXGz7OuOHGJe20zKx2Q_1742199825
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43947979ce8so8328555e9.0
        for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 01:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742199825; x=1742804625;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rC5lK1FxM1eWQXOh9AroE9tnp2td4VImfPnxc4mu+rg=;
        b=Y2TGVwaRp1DJVD0I4asIz51MdRDo9j+ss58rZG+RQYhnaEVFdv+RA62cFELK3PYs5W
         w0lFhtrjgyLwlnzIZkU5BnHpYWsU/19j5CB7vTiXW808T11hC/0HHcgIW10oxHg7/K9Q
         tI00NgWr0rWIYcWDkEYAvd0wh3YkOOpxG/9TDB9K2z8Jxs7HexxC2bcbhipp8jCt3BWC
         zzKQ6xlIrh9UlVDmjGixC5T2Bg6BAzY90yPsJpQKuFho1RihdhmP2esXsdZnx7lrAYAG
         2X8xYvh03diHCzI12uK9Ee9fn47YsW2ZMSzkvSILhS3bt+qEQyxOJ/tGoq6AO/HQEoY6
         Efrw==
X-Forwarded-Encrypted: i=1; AJvYcCXnMq6FGwXBiIag+idzLsYgs/z7aiE0yiSshulzC8tL5kVoqlWyuDCWWbH5SfniHQ00Lwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV0GGvjoe0TfOWLd/f6mphOPgbCs97WlhWYLs6jEpei2T/6tnL
	QA1HnPyv0IDwocQTbPi9zMjmLhvOGfif1CaWGmrrZ0CWMWUR1Pf7c2gAfxA3ion4FFRsIqBqi8p
	B1EKYWQnQKhZegxSysw0g3+ZOS1c4UftoR9BnulZIzdTllrHpMA==
X-Gm-Gg: ASbGnctyV/dgAn/1pZgJojZoBJ84ouXzJXc+QVKaBAKcNpLYB7GTcZD4PQBdWayWVij
	0NBrCzhUFCSHaTy9eEO9CK0NV2QO8FljNhaz2N4rjxn4U7P/yI+5hrP8/MMthKg+E+rNQw2zyRE
	/9KQZjNLkDDx8pKvq2oupaO32ASoOM2xPIk0JAI1Fq+SURZk9KnS5ZWbJ/+AJg2dAkBLA7/L4FH
	pbLM/Jja91H8GeHXQrpPbmp8b/w/awyo/+jFYlPj7T+5D7+ejhbSWAOtvqdKbiiHQZ3BwoXnamH
	9YJSD2VWxRoILbtI1ygmSAS5L3XUWFRgSz3Wvmp7eYLNuQ==
X-Received: by 2002:a05:600c:511c:b0:43c:fbba:41ba with SMTP id 5b1f17b1804b1-43d1ecd60c1mr109892925e9.28.1742199825098;
        Mon, 17 Mar 2025 01:23:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvXGGv6tXY3ajGLLrOXr011xmJAYRLTHi8JZasNx5okT9lH6f9KisDDn8lGridr/hz5ZTMqg==
X-Received: by 2002:a05:600c:511c:b0:43c:fbba:41ba with SMTP id 5b1f17b1804b1-43d1ecd60c1mr109892625e9.28.1742199824734;
        Mon, 17 Mar 2025 01:23:44 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d2010de59sm96734785e9.33.2025.03.17.01.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 01:23:44 -0700 (PDT)
Message-ID: <981a871f-e0c0-4741-8e7e-4a4e5d93541d@redhat.com>
Date: Mon, 17 Mar 2025 09:23:42 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/3] selftest/bpf: Add test for AF_VSOCK connect()
 racing sockmap update
To: Michal Luczaj <mhal@rbox.co>, Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250316-vsock-trans-signal-race-v3-0-17a6862277c9@rbox.co>
 <20250316-vsock-trans-signal-race-v3-2-17a6862277c9@rbox.co>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250316-vsock-trans-signal-race-v3-2-17a6862277c9@rbox.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/16/25 11:45 PM, Michal Luczaj wrote:
> Racing signal-interrupted connect() and sockmap update may result in an
> unconnected (and missing vsock transport) socket in a sockmap.
> 
> Test spends 2 seconds attempting to reach WARN_ON_ONCE().
> 
> connect
>   / state = SS_CONNECTED /
>                                 sock_map_update_elem
>   if signal_pending
>     state = SS_UNCONNECTED
> 
> connect
>   transport = NULL
>                                 vsock_bpf_recvmsg
>                                   WARN_ON_ONCE(!vsk->transport)
> 
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

This is apparently causing some bpf self-test failure. (Timeout? the
self-test failure output is not clear to me.)

Could you please have a look?

Thanks!

Paolo


