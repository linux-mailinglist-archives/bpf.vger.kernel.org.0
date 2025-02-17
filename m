Return-Path: <bpf+bounces-51718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F0FA37ADB
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 06:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C51FD16CE00
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 05:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5DC17C21E;
	Mon, 17 Feb 2025 05:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3Lom8Zg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA17E142E67;
	Mon, 17 Feb 2025 05:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739769700; cv=none; b=pnvMhpRlxEL7OJuT32LQXP+jxdQvPFfwSFCVk9yLOX3saqYppPLHRgIFHYdmbP4Lc36gFKpBQ8aAKGgES+NPBzEa6kDyXZeXqP8pU83KuZ48IMi2Ecn/X+6K8Ql73RlXAhYhMxPEd1cx47+z7S/Cq4vXhqPjcMeCy03U1P8aYBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739769700; c=relaxed/simple;
	bh=sjoCwO9d9om7MmK37AEOIfXLwyChaa15G4IG12FPC/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sXAknWI+f+OBEhQE0ljv/IRO/QcZ//w+0biqYgIvSLwZRCwty9Jbv/IT8oKOODzElzK3UKd38KHvu6h7QPuSitJWFjynREsrRqYnQT1XNR/kro3vsYWl36/2mN+lxaWQ/gr+jOGqjYj3ZmIoIajh2+D9DXpqUiBD8Yu/UXnAgW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3Lom8Zg; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-221206dbd7eso12952445ad.2;
        Sun, 16 Feb 2025 21:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739769698; x=1740374498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/XwSW7PHY2f1VnmVU0Y4+WCWXZUOX7V/Jy8Aied84U=;
        b=C3Lom8Zg+ezlaoA7QDug001cUOfH75Gvtq15Ri4FFXDUqtYrMxtm6dW1X1uLdWH8wy
         1RRjNq6FOtDmgSd2w7qBePz1LBWevMditJW5b/5abuQ3K0FDPTNybKS/xFOlNO8vjycP
         EbxpgBF8krW9kv4gTHd5wlfL8R9hJcuahWxCdPAuqWzyurT4l98H0mh/NDM35VLYgJ7X
         8mFpDGH83b+R0yFTGH4gzq+w5q08HMhtp8qO5XOC82PMhWeiwAdA354NQ6CqGzrrG8a5
         mQn5BjiAlFIfFQwXZ3suDLkcdBY8ndOsWmQuGqiavZiDpjjfIwZv6bvLYrgc4lkjownd
         EZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739769698; x=1740374498;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M/XwSW7PHY2f1VnmVU0Y4+WCWXZUOX7V/Jy8Aied84U=;
        b=F3CgZt3G32zkzwtvWafZFWEQkTrS/U/CVLXqaFduMQ7zN0E6O/2tthH4W6TCembike
         Hyo4qFYsCmQjKB6Bb2kf+DhshtScdtU0hNFQKeV0473GdyEulMp430uwCPr+D3+Bc2Es
         XD/YsRaj3U5k4h/USS0jpMTy7lg+DU8ewSZ0xpGaGIbwIh+aOsSHM0tKC2yYU4dakhOi
         iitNWjL211/40fk+Xb5LUDkHfP5TDDztlhOEIpY+gjVbdM0pB5zhnsDf+GABmV1nmyss
         NKwvT2V1ijP3MKhNdUb9TFOPLE3n0vZMWnjIRKM1dFXwncw86W342V2GMLFrlLd+5nXg
         sWRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD2QE1xi9e1x5d14OdKqgkZb8t1bgyMYCIpMapku3aJIJ+KosLbIcCqAx82YShbIKrHnlRAdIfzzf+Agc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxumFYtuwWK9RigBrbPnbi8X9o6rYfe4a/MfnBR5RaR/T862txf
	I1J6eBiilmWoK23tMrpGIX2vRBw29pw104/yPM36eV1DtGFz6OHI
X-Gm-Gg: ASbGncvwEWdRtXj+p7kl9bMGz6mnMVu1dp7avOoRAh1woNRlWjbbSUud7Ky9vIQVPsP
	wQFmWifvdsliWcWxK2X1gQUSi1kA/OYrvV35zx3vXhE5atS6ZpVZ1mvwazH5FaK7GrZV4Wxax2t
	BR3KMnzoqdXfKZPx1LWyrcIqd/D9zVDFoOZscnzSuPKWjmbAx66gYnV9ikOJWyK0SzbEb52JCdP
	NovgKWiq26du34fSn6eqObdSG167ea12Qs172KREnDIc5YAl8tLUXENF6d6+O8EZXsqQ+tfziQo
	PdufWKCxCuzdFYvAitzVi/Yh+fGJ7vjyu0g=
X-Google-Smtp-Source: AGHT+IF2EKRmwxzMNJLjYC12kbuGYs/1giNDSpyHQvKZ3f91hT57q340+egUNjLJUu60qYSEurb1EQ==
X-Received: by 2002:a17:902:c943:b0:220:f7bb:849 with SMTP id d9443c01a7336-22103f06486mr127524025ad.13.1739769697769;
        Sun, 16 Feb 2025 21:21:37 -0800 (PST)
Received: from [172.23.160.155] ([183.134.211.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d453sm62226065ad.115.2025.02.16.21.21.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 21:21:37 -0800 (PST)
Message-ID: <2b025df3-144b-4909-a2b4-66356540f71c@gmail.com>
Date: Mon, 17 Feb 2025 13:21:31 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND bpf-next v7 0/4] Add prog_kfunc feature probe
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250212153912.24116-1-chen.dylane@gmail.com>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <20250212153912.24116-1-chen.dylane@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/2/12 23:39, Tao Chen 写道:
> More and more kfunc functions are being added to the kernel.
> Different prog types have different restrictions when using kfunc.
> Therefore, prog_kfunc probe is added to check whether it is supported,
> and the use of this api will be added to bpftool later.
> 
> Change list:
> - v6 -> v7:
>    - wrap err with libbpf_err
>    - comments fix
>    - handle btf_fd < 0 as vmlinux
>    - patchset Reviewed-by: Jiri Olsa <jolsa@kernel.org>
> - v6
>    https://lore.kernel.org/bpf/20250211111859.6029-1-chen.dylane@gmail.com
> 
> - v5 -> v6:
>    - remove fd_array_cnt
>    - test case clean code
> - v5
>    https://lore.kernel.org/bpf/20250210055945.27192-1-chen.dylane@gmail.com
> 
> - v4 -> v5:
>    - use fd_array on stack
>    - declare the scope of use of btf_fd
> - v4
>    https://lore.kernel.org/bpf/20250206051557.27913-1-chen.dylane@gmail.com/
> 
> - v3 -> v4:
>    - add fd_array init for kfunc in mod btf
>    - add test case for kfunc in mod btf
>    - refactor common part as prog load type check for
>      libbpf_probe_bpf_{helper,kfunc}
> - v3
>    https://lore.kernel.org/bpf/20250124144411.13468-1-chen.dylane@gmail.com
> 
> - v2 -> v3:
>    - rename parameter off with btf_fd
>    - extract the common part for libbpf_probe_bpf_{helper,kfunc}
> - v2
>    https://lore.kernel.org/bpf/20250123170555.291896-1-chen.dylane@gmail.com
> 
> - v1 -> v2:
>    - check unsupported prog type like probe_bpf_helper
>    - add off parameter for module btf
>    - check verifier info when kfunc id invalid
> - v1
>    https://lore.kernel.org/bpf/20250122171359.232791-1-chen.dylane@gmail.com
> 
> Tao Chen (4):
>    libbpf: Extract prog load type check from libbpf_probe_bpf_helper
>    libbpf: Init fd_array when prog probe load
>    libbpf: Add libbpf_probe_bpf_kfunc API
>    selftests/bpf: Add libbpf_probe_bpf_kfunc API selftests
> 
>   tools/lib/bpf/libbpf.h                        |  19 ++-
>   tools/lib/bpf/libbpf.map                      |   1 +
>   tools/lib/bpf/libbpf_probes.c                 |  86 +++++++++++---
>   .../selftests/bpf/prog_tests/libbpf_probes.c  | 111 ++++++++++++++++++
>   4 files changed, 201 insertions(+), 16 deletions(-)
> 

Ping...

Hi Andrii, Eduard,

I've revised the previous suggestions. Please review it again. Thanks.

-- 
Best Regards
Dylane Chen

