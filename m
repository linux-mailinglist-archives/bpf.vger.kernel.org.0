Return-Path: <bpf+bounces-59260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E29ACAC769B
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 05:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0FE3A75D2
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 03:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F2519DFA2;
	Thu, 29 May 2025 03:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUQCn2S9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BD020B80C;
	Thu, 29 May 2025 03:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748490287; cv=none; b=mvtcB2zPqJLUqQt1GHLxEdse8HOQqzgeMJ0Q++qfYu0cjmGJpyXgdhLBEkJVNUhUPbvlBgTrymgAC3pqxh40b+3sGXh9T2lv77m3xb7SsmKw5OB33PJmNusKDDK4LSMPEEUTcQxflXL6z9/6XDPFbM0jWCeT+T5QJ46ZZK6rFqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748490287; c=relaxed/simple;
	bh=qP5gjdbUL1UfLl8u+WQq9TWXaK1d3a5ARjTU0ouqSss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eJiFfTnfOtnpWnxNc889nqgKfNTtlyfYH/mvGBz9bOCmptU1Wy+2X1s8WvbYda64D56LXRnZWWIejpUtdZ013HoyOMdDAtaw0QJYEA5tnIZBIccd/JYrxlBYDfJPEWlJeDh6YKBBJ9+cXEPmiq8/0ARP7xvet+oMg1tLC2leons=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUQCn2S9; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-742c2ed0fe1so382276b3a.1;
        Wed, 28 May 2025 20:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748490285; x=1749095085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nbJOS9RirTTM579TH3s6Zvz82kENRx54Nq1I6huQPgk=;
        b=CUQCn2S93D3uOyzqE4bf/cLA5WxMlrUWWxPPuVmXDC2t88r0cM+pYf5xbw6kAbqCzv
         DtvUneIiaodcymSefmiCzCojKN4Zmoc/JKWa4jzLs5n7tnXuPKiiOy4Unjnvcn8pMVkc
         QIwjb8V+/BNY5C6G+xk2qvM0gthOjRCxJ3WppScvXNqsotsyageWoMN921DFsMlMCvCr
         RS40B+/GIEdxUfDQVwir/jyQ9CkbXLTKH4sY4PDs4b1yklHBOesOi4zGoDGx+XOuwCt4
         bNrkGHVZaBP1xDwiCkoNiLnFVZ6CdS0LPF42sCpOl6EXwRHctN2hcImqWNT+w1bfQnXi
         wRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748490285; x=1749095085;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nbJOS9RirTTM579TH3s6Zvz82kENRx54Nq1I6huQPgk=;
        b=TEuRYZOwgty3Hznmn74Y3VZ7fMTCRopxySQTBP7LJVNAmuzBV5I3ghILfOKhKpJnSH
         V6K8lQjo5Akk7tVU+S5CVN2MYswO98XYW5hwuNlSYtuC8eESABIVlxR5jTEV0+9rmj9y
         YCYbRHimbenAf/6lcH+KIUKfRqz7t6ctryZ3KmGZGcHwFlyAtb9MJJgHonDWOZV52vNa
         OLLQZ1U1g6Kcvt8cigsoElulGQSOJo1vaElLVkGXJyzwcMGBemI2fRWnCAZJZmsffYsr
         6bBOmeqlCsgEZwJrLeCCpCnFvr1c6owehzyvMCoJOqDvSAwbOPTIDGhKWm3XqREnPKm4
         UsfA==
X-Forwarded-Encrypted: i=1; AJvYcCVWtZq+m0ecINi1bcuGbz9V6XCYtFF6srrC9ZV4amcp1qhSh6bhPy0he09BJ9aei0+taX7r5/Mkq356bxgL@vger.kernel.org, AJvYcCX9Zy1hSkMfBBqeGy4HXtlQxAdxypYbfUGTRicdRmhTi+acZrUlIBwtKh6hUUQaLW2zQwsyPS7F@vger.kernel.org, AJvYcCXbSn/1qnkbPacUxv2o1MMADBzKqriS5cGW5UuxzH06gTuonO9acKGdeMg55OI6BQmX8kY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5PKIAA3/2RzyQ0DhiI90Z3MPiuU2kSHLewTRxrzQLuhj1i21+
	RnRkTzs9bPHPw+/39pKUcSJXBcTyLHC65aA8cEBpT2DQKThUjwKuNjBM
X-Gm-Gg: ASbGncs8tnhkmgnipnzmUgFoPSAxmG1DBO0WLADytxWi0h1r+4KSKtD0oxfR6CjJLBN
	IgHfisqdW+vrf0RMKeTwxHl93CKsBEX1cZuDt/q2F6xMOGK9+ySj7GwevENnxdcsfqHCrGYVHuP
	JSTfbHYp4HElhT/R3RrcYgYOJe2f7iuX87+o0IuF+pdREUf5YwH0QXHuVF3MLCM/CT1noVco6pu
	zhszF5fz7gN4NzjntpVwI04+abhnwuRHzkscc5dAeYkmLyWV1j6QfSP81Alh+fGuCI9RdnkpPpj
	lSYG3R4oEz3ZMv1Y1+2aoxb4QU2BmXW1fr46roilMRuSJ9abRINMSHlppok3CZ39SPGhi/wRA5M
	Qe99/gvv94lBTvely8VeOUe0kNe1rWEfG+BYP
X-Google-Smtp-Source: AGHT+IGzpp+yFzFB3LHe0wo9L12fBskGn3KUXtzadW4NYiqfzcITkoJlkzjviP3Km5G42o8xBZu06w==
X-Received: by 2002:a05:6a00:234b:b0:740:595a:f9bf with SMTP id d2e1a72fcca58-747b0c8cademr1149905b3a.3.1748490285078;
        Wed, 28 May 2025 20:44:45 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:76aa:9d32:607:b042? ([2001:ee0:4f0e:fb30:76aa:9d32:607:b042])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afe966easm374915b3a.4.2025.05.28.20.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 20:44:44 -0700 (PDT)
Message-ID: <3d9999b6-5c8b-4ab1-a9c6-e7cd09488779@gmail.com>
Date: Thu, 29 May 2025 10:44:37 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v2 2/2] selftests: net: add XDP socket tests
 for virtio-net
To: ALOK TIWARI <alok.a.tiwari@oracle.com>, netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250527161904.75259-1-minhquangbui99@gmail.com>
 <20250527161904.75259-3-minhquangbui99@gmail.com>
 <0a827263-7257-4ac6-89cf-d694c9d3ab65@oracle.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <0a827263-7257-4ac6-89cf-d694c9d3ab65@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/29/25 00:04, ALOK TIWARI wrote:
>
>
> On 27-05-2025 21:49, Bui Quang Minh wrote:
>> +def main():
>> +    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
>> +        cfg.bin_local = path.abspath(path.dirname(__file__)
>> +                            + "/../../../drivers/net/hw/xsk_receive")
>> +        cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
>> +
>> +        server_cmd = f"{cfg.bin_remote} -s -i {cfg.remote_ifname} "
>> +        server_cmd += f"-r {cfg.remote_addr_v["4"]} -l 
>> {cfg.addr_v["4"]}"
>> +        client_cmd = f"{cfg.bin_local} -c -r {cfg.remote_addr_v["4"]} "
>> +        client_cmd += f"-l {cfg.addr_v["4"]}"
>> +
>> +        ksft_run(globs=globals(), case_pfx={"test_"}, args=(cfg, 
>> server_cmd, client_cmd))
>> +    ksft_exit()
>
> SyntaxError ?
> inner ["4"] uses double quotes, which clash with the outer double 
> quotes of the f-string

This works just fine because the ["4"] is inside {}. But I can fix this 
to avoid confusion.

Thanks,
Quang Minh.


