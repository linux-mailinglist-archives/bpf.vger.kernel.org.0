Return-Path: <bpf+bounces-37168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 238E6951885
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 12:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 318F01C21C09
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 10:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC821AD9C6;
	Wed, 14 Aug 2024 10:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WYV12BnM"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CAE137C37
	for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 10:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723630770; cv=none; b=T8rOt4OSYn/bePEABX+anVW0dxOgbBwBJyTngr+PhvfCrj2kKqPXsprkpyE/sqFcyBf4hsEZ7+eE+wxUmIIOPpplFXUe6x1HWNlPrnVeiMGNCH3VeFL/7jniN8umip+lkUr4nZQdlNy64DAqDHVMp3W8AketIKwRZzmsj3Ij7DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723630770; c=relaxed/simple;
	bh=t9lVZHego+h/pLmlzoNvSZksj3Uj4t0Eq1GVG8OUPEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tt0jdgLbs0xKyLTX+S8jYw70/QityEGZ9jmSUsojTegie8oZgxf0HjLjBo24UxHypKIV2UkeHsOyau+BmKfYcVTolFwqVou5QqzNlKWYYDcGmc1qVTl2wcUdxmMSvSsZ3kT8AUG6H9QLf7ENTnNupSj//5qw9OjbNJApxRMq7Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WYV12BnM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723630767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XQWCdYGEvzzQfWsQLEE3cpHvTLmChkz9jo+vfBfpfZA=;
	b=WYV12BnMIXjvs6vrQrNlnQOpQNClBYYEV/jpcRYmDDsXzn/1+/hQGjs/qfm9bol0W1MxrI
	9z8e7pc/kICb+//39tLYYeaIEKdmlaISq5wU+zShRKrSmwhFOC4iwQirvLUxaPOgi94nn+
	/H8uKM8uW6E45sR49D1CuTXU5PDP6tI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-P7YgTFkvOamDbxux-PR6Wg-1; Wed, 14 Aug 2024 06:19:26 -0400
X-MC-Unique: P7YgTFkvOamDbxux-PR6Wg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-428fb085cc3so977235e9.1
        for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 03:19:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723630765; x=1724235565;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XQWCdYGEvzzQfWsQLEE3cpHvTLmChkz9jo+vfBfpfZA=;
        b=IOkmeaU6lzqNaf8FoVkeoTI67p+2uvfojieP/qduCDQIqPbpOXsJrOezBz9sb/Db+b
         e8m2IRyveqJ7hTZxU/cyK/5OuuTYqU5/BJYSw46i+zzbb6zZ3YCBGIfpe318nvubMpVJ
         E+49RkO69gfqYHRhJJuw6yaEzVERJrSYngeGUyCjBdsTKgpdv+jFCyiJWk9GOHQ41PwJ
         jF4xLFGrJANKmcTsiJ5qbCMA2cgvawBSIxomZbp3saQmCGt1P9aYl8GUG5tV5GKplaMO
         7XLh+IGKn669IGDZbdMTTAus5ZyyGQJmbBdtgHZMOVoorviL4LU5g9D8r/Bh9PRmIazI
         yITw==
X-Forwarded-Encrypted: i=1; AJvYcCVxPuarx1+uupAvFVjeldAvrQTBA07EvtgcGOVLwT/Fq4NUCKG9nhcwQBiyPCBorBvMBZOpFiyCsOw3RKpR9EaHUdNw
X-Gm-Message-State: AOJu0YwX6goU4igm/u088FcwvCNUAd8loUKYGXv32Z8XI1/TtLFVQVZO
	48bLg/On3qHrFdE1PnZMHF4fS7XtO4KhOYtgpdn7yl9WfK4pfh0mmC2zvqomJmGJ9Rgzp2KSOQX
	mM88v7E210dFxiCoZxoVs0CVoW+7XGC3kuIN2ds/mvG2g0YSbNg==
X-Received: by 2002:a05:6000:400f:b0:362:1322:affc with SMTP id ffacd0b85a97d-3717783c1f3mr1085865f8f.5.1723630765357;
        Wed, 14 Aug 2024 03:19:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+2zmzguzbPlqBDa5DdkqASnHlckLXCCqilxRkhHTezxJvU5BSWXWkGwI3l725zZBIVkJLog==
X-Received: by 2002:a05:6000:400f:b0:362:1322:affc with SMTP id ffacd0b85a97d-3717783c1f3mr1085841f8f.5.1723630764798;
        Wed, 14 Aug 2024 03:19:24 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1711:4010:5731:dfd4:b2ed:d824? ([2a0d:3344:1711:4010:5731:dfd4:b2ed:d824])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4e51eb47sm12533174f8f.88.2024.08.14.03.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 03:19:24 -0700 (PDT)
Message-ID: <244ef3bd-2f2b-4820-9fe0-a10641c0829b@redhat.com>
Date: Wed, 14 Aug 2024 12:19:22 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] selftests: udpgro: report error when receive
 failed
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Ignat Korchagin <ignat@cloudflare.com>, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org
References: <20240814075758.163065-1-liuhangbin@gmail.com>
 <20240814075758.163065-2-liuhangbin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240814075758.163065-2-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/24 09:57, Hangbin Liu wrote:
> Currently, we only check the latest senders's exit code. If the receiver
> report failed, it is not recoreded. Fix it by checking the exit code
> of all the involved processes.
> 
> Before:
>    bad GRO lookup                          ok
>    multiple GRO socks                      ./udpgso_bench_rx: recv: bad packet len, got 1452, expected 14520
> 
>   ./udpgso_bench_rx: recv: bad packet len, got 1452, expected 14520
> 
>   failed
>   $ echo $?
>   0
> 
> After:
>    bad GRO lookup                          ok
>    multiple GRO socks                      ./udpgso_bench_rx: recv: bad packet len, got 1452, expected 14520
> 
>   ./udpgso_bench_rx: recv: bad packet len, got 1452, expected 14520
> 
>   failed
>   $ echo $?
>   1
> 
> Fixes: 3327a9c46352 ("selftests: add functionals test for UDP GRO")
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>   tools/testing/selftests/net/udpgro.sh | 41 ++++++++++++++++-----------
>   1 file changed, 24 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/udpgro.sh b/tools/testing/selftests/net/udpgro.sh
> index 11a1ebda564f..7e0164247b83 100755
> --- a/tools/testing/selftests/net/udpgro.sh
> +++ b/tools/testing/selftests/net/udpgro.sh
> @@ -49,14 +49,15 @@ run_one() {
>   
>   	cfg_veth
>   
> -	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 1000 -R 10 ${rx_args} && \
> -		echo "ok" || \
> -		echo "failed" &
> +	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 1000 -R 10 ${rx_args} &
> +	local PID1=$!
>   
>   	wait_local_port_listen ${PEER_NS} 8000 udp
>   	./udpgso_bench_tx ${tx_args}
> -	ret=$?
> -	wait $(jobs -p)
> +	check_err $?
> +	wait ${PID1}
> +	check_err $?
> +	[ "$ret" -eq 0 ] && echo "ok" || echo "failed"

I think that with the above, in case of a failure, every test after the 
failing one will should fail, regardless of the actual results, am I 
correct?

Thanks,

Paolo


