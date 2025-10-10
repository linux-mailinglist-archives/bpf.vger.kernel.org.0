Return-Path: <bpf+bounces-70745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 486DABCD9E8
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 16:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 80C0E4E852A
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 14:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC49D2F619B;
	Fri, 10 Oct 2025 14:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYIDHRBw"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E446E2F6585
	for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 14:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108027; cv=none; b=BfqQRn751JQiyn2WZjcN/4XWg/371GKD+1VXUS89BSITME7+cljOwDqqCVoMp19ZdP1wVbvt0NR01Pieso4VpQFpyM0uGtHf4SdRyq3x9RVfIAIBPOptvm+BA/y3ibHYKgNQxW7uCcMZaaT7AVQ3iG0bEKtliaReOQATfcOJygM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108027; c=relaxed/simple;
	bh=RE51Q+tai5wxyY7IBNplIrEXUroPvyfLKx/UM06nsPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XE6ac7rlBI5tfKIkAyXsNgwsOw+NPRMMFjssyA8d2zcCD1tNUB3QP6bilLWoxJ4QWpGallKgwxOcbgicdwIjl3VPqgxaXAZf1TudyWBLKunmh/oH4eOFvHlMF2YAFjULp0A1uupWnmUjAXyVNzeMFP2/Slp5zHfc9RKph5T7HhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JYIDHRBw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760108024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mm1LsfcOuzKZTTBgXzTaGHCG8Gr2uq1l0R9yl5s8auw=;
	b=JYIDHRBwniy3mwrkyr7lR76A2mlZEKeUTs6BhgoLhKj4oM1C4WMnOvkOi4cG8i/TUK6AH2
	0jmlGjrb4mnOKp5MvzHB7iZq5rHoalRPjiT0tXYXbHY1VT2DMbli3h8swtpa5HsSWl399H
	qiGfzFHRLrE9JQRmByqYZKrJVziLfyw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-r1F4234SMN2IuN4webK_Pw-1; Fri, 10 Oct 2025 10:53:42 -0400
X-MC-Unique: r1F4234SMN2IuN4webK_Pw-1
X-Mimecast-MFC-AGG-ID: r1F4234SMN2IuN4webK_Pw_1760108022
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b3cbee9769fso257898166b.3
        for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 07:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108021; x=1760712821;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mm1LsfcOuzKZTTBgXzTaGHCG8Gr2uq1l0R9yl5s8auw=;
        b=tzQ/GkXDGVFRVZ0iZhPTZ/OJqzYCMzvKe3CMWvBDf5oVgMVldmxNyQh4OenJKmWrPf
         unQQZC27MTCCw7w2QYuVvdSxo3y0tu0tN+vyXZfpUF+xq2bMoRXK4agRZPU/x92Gi5SM
         lt8anogYKjRodTMivHKEwVpCIsUzA9Xbiwn9OVl6nOztzveS0Ze66KtjewvK0Tdjr2sg
         W7fQgJawKFr6ek62PI3ks67y6xqd+zTIG+4G/tk9HkEbWW8JWkP/XIvcq3qDmsYpuNnQ
         2qKnwzKOr4+1gAoV8IXZ9+uWtuXC7BTU/gEc8TNmyMT6YHoRz0Szj1UB992LGzB9RUEJ
         OE7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXcG1IcOJw2V7zixo7BpddBZo6dRkTsLptRwDzZ00UpIAlBJhHAdgG8CzSHOZ3dtm0fBrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyAPaU7M91bP21vU23QWvNjuRpDdMvzet2LpfIAeNu7E1MVwww
	ay1P6s7KipJMpfUEMZxlE+p9eCkzzl2lBMPkvDQetxdFv4UJhH+B8f311bJaBsDgVmvgIkvUA82
	lHegFCEEZFkzDOgyG12zTnl3CHCLVqyCCAruB0J/8+INYpZ0m5XXV3g==
X-Gm-Gg: ASbGncveCvwjD3zPOJkplDNbqyHJhmJUHKZtr28+fCN4CZQhUakKtciP8Tpwp8+HbrG
	16nEbUlPlrobou21PHm2ghYWpPWOHGyoK1bNOGmJE9aJKjkM8vtuQLK8MYSpHjM7ShsfZ77gEUb
	p897yHU08dxLN89Tq3ksRez9GY7oDA169/vW9gVruNO87KgbO9jIiGaZ8W31NCbNHFjW4SQIEvY
	prUQ6xogx4vRlrvE/NuB5f+fgz4IRuWRKyTecS5yI++BKlnlqj79BieF64sDUCwyWEjxZoZO/48
	voc3a2dctWnEMzDEXEny3ufbjcMkQqosx+B/cNfQPIc2WblUJfcdOmfOTKG4WTlUOhCb4fsVx7c
	Dbnl2kS5RijoN
X-Received: by 2002:a17:907:3d16:b0:b38:25b2:e71c with SMTP id a640c23a62f3a-b50ac1c0d4amr1269989166b.41.1760108021596;
        Fri, 10 Oct 2025 07:53:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvs40B7jZcN/+w79lx0XokZpMjaCzgtfhFa84wc/vDHQJD9iDkyGA8sI2ISLmd873BOO53wg==
X-Received: by 2002:a17:907:3d16:b0:b38:25b2:e71c with SMTP id a640c23a62f3a-b50ac1c0d4amr1269983566b.41.1760108021007;
        Fri, 10 Oct 2025 07:53:41 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d8283sm249396166b.38.2025.10.10.07.53.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 07:53:40 -0700 (PDT)
Message-ID: <0ec01c17-1c39-4207-96f8-597bc8d6c394@redhat.com>
Date: Fri, 10 Oct 2025 16:53:36 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 00/13] AccECN protocol case handling series
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
References: <20251010131727.55196-1-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251010131727.55196-1-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/25 3:17 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Hello,
> 
> Plesae find the v4 AccECN case handling patch series, which covers
> several excpetional case handling of Accurate ECN spec (RFC9768),
> adds new identifiers to be used by CC modules, adds ecn_delta into
> rate_sample, and keeps the ACE counter for computation, etc.
> 
> This patch series is part of the full AccECN patch series, which is available at
> https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/
> 
> Best regards,
> Chia-Yu

## Form letter - net-next-closed

The merge window for v6.18 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations. We are
currently accepting bug fixes only.

Please repost when net-next reopens after October 12th.

RFC patches sent for review only are obviously welcome at any time.


