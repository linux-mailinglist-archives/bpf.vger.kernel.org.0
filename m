Return-Path: <bpf+bounces-56104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5800A9151A
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 09:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFAC3189E5AB
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 07:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FD021ABC4;
	Thu, 17 Apr 2025 07:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+IJMyzA"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90362192FE
	for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 07:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744874790; cv=none; b=HDzXEXcvGQraTLNqC9rpRF3YxxG5DhhsvnfjbDjjq2m/faU2Q9BCHom/BUHb6PGWn4hQXxmyf8IukFXjkHG2ntlfav/B0O520a/xk/J0LqN1WghhK6N+DyTIFtQteUq1tVLoMw/aXbspVRYuJdu5FferXxVvgtm/uvdg4rl4++o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744874790; c=relaxed/simple;
	bh=Pt4wMjTOPxLyncUhsljlu78aefYEy0zJC2OQzWrprQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CphVZ3JgZrBikD1bpEelk0h+0t3TYxU3TqfXaL7o2x1YM289ZmemInckgA1VPEV9iXWtDPHrcBSZkK0oOQDpUyOBpxjt8hqw/ChQVArBYPxwfvL66NDwi8nce+IfecDAsRgOI+ot5owIcJpIuWDYo4jSDfsWj2zWlyjs4K2shSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H+IJMyzA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744874787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Udp20JCu0lxnLB5nbtOFfZ2GpP06hSOWr1XwI2XNqTs=;
	b=H+IJMyzAGSpkLDY1iwPhkgG7FkggGIOcWMM/Wnh00s8ugaA3IrtwEGAnUdHztPeYhwQmbF
	1N+76SJhCUcq37O2lAJRCFIbLbcMO2jUnlgtgFy4rXnHa0ukxIkPfaNhKsd2Al/HvqDBKP
	Dvzq2XODTE/rblPsC9UXVou65yf/Jkc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-PD5uCquXONGgtzuAXbaaTw-1; Thu, 17 Apr 2025 03:26:25 -0400
X-MC-Unique: PD5uCquXONGgtzuAXbaaTw-1
X-Mimecast-MFC-AGG-ID: PD5uCquXONGgtzuAXbaaTw_1744874784
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3912b54611dso231396f8f.1
        for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 00:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744874784; x=1745479584;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Udp20JCu0lxnLB5nbtOFfZ2GpP06hSOWr1XwI2XNqTs=;
        b=QZ/zXyFrBZGBZXlk7ZwZktoebvMLhz2RsQ5ZXN/G6q/JG1H8hSLj8/E/jZKnWnbMpD
         KuL+aJBVydxkueI+9HAf/TCTbF/0j2JF0lwe2yqz01qlD8gVvaa7MADfhJlWSbw+iYKg
         wPSsMJwqgGqaL095QMsbxNOb7jr+rgswWSJ6wvZGxwAjY94KbulZqBwvvMp8uoshq/6Z
         1r7Et1hAKpadJKlPq/L6O5upC4f3sC4BVRl3ZdyRfzlqO642/T+vF2mLu9o56Iau80xt
         JL4+thCihLDiYJO3RELr9YbAcmsT8pQOcikp6hjqPxBhacp22QVj6JX1xywnP1yuRL1Z
         HtIw==
X-Forwarded-Encrypted: i=1; AJvYcCVTJzmnNVqs1+w4i4lwKcAzeYEs1FDGI1IXLtH5IrsDNAqKJhkIRDtwDeRn4dZR0zlAOoE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5g8jyDYobpKGQaj/4D0Cx1HBwdo79M/6cpZ3spDzKYRrPnKEA
	Z6iivRcLz+V8Q+M1wffc7snLzfkIGcZTCgcYFS8F1Q+fIFXXZrkCrbUvZatSjFIDZLS+1wRLi2q
	AYx0ZAHNdMN+sY0JAI/6xChslBMtLgBtU7L5KeINlHn5etLx3Qw==
X-Gm-Gg: ASbGncs3SLr5k90mVT3a+8ezH8DRar5vMYWla2J415L2s+c9TJbMRJ9Hxh3ke+8gCyH
	RyUT//iD0jNFzcfuS8wu7wmGugw3q59p84hphAUxFV78EIEuFMbk9t6PsuIMqvkjmu2MJsR2dHq
	vwwHWgBRBevlANOkZOUQXGVwMzRPjOYvm/5ksXp+EtQO0mnkt8oOCEk5epwyRWX+PpHTc03Ma2+
	kO6d2GooK0dlc7Hd1PNjcun7ws4CnYjR18wG/LzMERB1AmmB18SrZdysz+06Yz+bvvVvmXzgUfE
	Jj62FQ5Vvdp6ba01H7nDX3x7W2mkDXQHOX1ZU8um5w==
X-Received: by 2002:a05:6000:144f:b0:391:241d:a13e with SMTP id ffacd0b85a97d-39ee5b9f5b6mr4191469f8f.48.1744874784108;
        Thu, 17 Apr 2025 00:26:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX40ws3+eqraZDVy9FNzNzHM8/7zc1TFMhaZr7xBFr7xp/tveKs9AoQ1WnxQPtgH7HvwyHGw==
X-Received: by 2002:a05:6000:144f:b0:391:241d:a13e with SMTP id ffacd0b85a97d-39ee5b9f5b6mr4191442f8f.48.1744874783782;
        Thu, 17 Apr 2025 00:26:23 -0700 (PDT)
Received: from [192.168.88.253] (146-241-55-253.dyn.eolo.it. [146.241.55.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae96c03dsm18792656f8f.24.2025.04.17.00.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 00:26:23 -0700 (PDT)
Message-ID: <b1fa9607-f9bd-4feb-a22f-55453a9403e9@redhat.com>
Date: Thu, 17 Apr 2025 09:26:22 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/4] selftests: drv-net: Test that NAPI ID is
 non-zero
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org
Cc: kuba@kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 "open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)"
 <bpf@vger.kernel.org>
References: <20250417013301.39228-1-jdamato@fastly.com>
 <20250417013301.39228-5-jdamato@fastly.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250417013301.39228-5-jdamato@fastly.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/25 3:32 AM, Joe Damato wrote:
> diff --git a/tools/testing/selftests/drivers/net/napi_id.py b/tools/testing/selftests/drivers/net/napi_id.py
> new file mode 100755
> index 000000000000..aee6f90be49b
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/napi_id.py
> @@ -0,0 +1,24 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +from lib.py import ksft_run, ksft_exit
> +from lib.py import ksft_eq, NetDrvEpEnv
> +from lib.py import bkg, cmd, rand_port, NetNSEnter
> +
> +def test_napi_id(cfg) -> None:
> +    port = rand_port()
> +    listen_cmd = f'{cfg.test_dir / "napi_id_helper"} {cfg.addr_v['4']} {port}'

Not really a full review, but this is apparently causing self-tests
failures:

# selftests: drivers/net: napi_id.py
#   File
"/home/virtme/testing-17/tools/testing/selftests/drivers/net/./napi_id.py",
line 10
#     listen_cmd = f'{cfg.test_dir / "napi_id_helper"} {cfg.addr_v['4']}
{port}'
#                                                                   ^
# SyntaxError: f-string: unmatched '['
not ok 1 selftests: drivers/net: napi_id.py # exit=1

the second "'" char is closing the python format string, truncating the
cfg.addr_v['4'] expression.

Please run the self test locally before the next submission, thanks!

/P


