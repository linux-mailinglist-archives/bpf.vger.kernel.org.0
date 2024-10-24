Return-Path: <bpf+bounces-43012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0C89ADB1B
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 06:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E86711C21340
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 04:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816A516E89B;
	Thu, 24 Oct 2024 04:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfNzeaSz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5921212CD96
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 04:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729745225; cv=none; b=AMQfnmeQ1NZ2zsZ8Y+KarB4WBW9n4b0Nt9RTfvYMk4VAok/LPcgyVMMaHvqu4mr0bxBAM3hqGasCXW+rffhg/KKeAlQ6bKUu0ZZ15zJ7ztinkw4uHpBfPHdFXjyCrURiaysoPZ36wtfaHgJ0nZfKHLsNgINJmsjpKLlsdTmQPYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729745225; c=relaxed/simple;
	bh=78ElZEbq+wzhIZIbb4iM1+4N9squW2hLZpp/wmtxjmg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=q2xCiFkZyYZBqT6efd3gsmFUi7wbqpyyD4XteawKVXblI9b1s1DP7HgVjLFqmJpDz7zpFvWmBoPotVX68OdkAGZojYZvhTQLyi/naeXb3LJ6JmWP4CA88xcRkaY6wrPofZ47X/wMS1VmMOXd3bz6LUAq88RZ5meuab2ucMkxZWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfNzeaSz; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20cf3e36a76so4614235ad.0
        for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 21:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729745222; x=1730350022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/3DovfNc8oUuWHbWOc9/b4aou79/IrPjTtYLKDe7d8=;
        b=gfNzeaSzww2lAosOmFVdOSj/7qYssOtAIAsZVliAhCzRc3y1qc+dHK1jc7YJrVhm9n
         j/bsFprEg2K6uwAlo43FFlrWFO0UGmdjnd4WDveAZdTXbPoF2SIlv7Iq0rQWs3RLbeqo
         NdzKN3FQPI03T4LpM1cKIgIvA+hTWSLxsmOcbE0MP5H6XC4W40EA7nD1F8eheBqytnfU
         mo9VqFzDVBc8Z8Tsf5r0qxjswkIbnbxTJ7yMMuDg6/heOFKSn7PwSwA91l2oHpEPhn9s
         hKRcRp98eCfF6lwbjThFt2fJy3Q8ECE5aNmbP3NB5RrinNgSJAZOnvmpnas15yzJcEPO
         VOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729745222; x=1730350022;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y/3DovfNc8oUuWHbWOc9/b4aou79/IrPjTtYLKDe7d8=;
        b=ZywYTwRwvddpzacw36bcJFkjHar8DLUCKlwjoicDmydKw9HCZBE5HA5oXfA/s/lsnC
         tpzIQy/HWa87G79518eJNFqqDifIJ82/JMJOCnEW3rEhdvmSKtZy2X0VrPO3kpO+ew+n
         smvNaX9wPFWHRsgPoQdQ7itR4cjEQG0Zx+HeUJP9wDzGkaSvGQ735wa6tI8YqZUVPxj4
         Iz4ZPBkjPMYx9Toz/pBIESJsK4qAyCiVfSybNNG4hdzVf5qLSdVR5Z2hKTyeGEgZyyGL
         ywYRvb4QUs1CR6Oem9AXP/8srAOBSJy8XrAbrMtN1upiEqCt5FmGGYwPZfEsBRfCyglQ
         Z8oA==
X-Forwarded-Encrypted: i=1; AJvYcCXtS27tPOAleAqwBtjINmTbAfWuvVM5JL5ggigQnHQsOnG9OJGu2xKx1aNrCdbHxzYI+4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRrINtGGG+hkDMEA5VXybakeH8XCZ48Uvv1wqrVfM+YFOcsJ6g
	aoCNa2nykeOWIYNFuIM7cuOwte2SBzkyA6bkRp21swr3dR2ySJjZ
X-Google-Smtp-Source: AGHT+IHjP2OHZzYoqd8HDKxYvaVPiXPQeK7qTOTAYJ6F5dcgXQu4we4J0CyoePXWaV6/rxVVCSK1wQ==
X-Received: by 2002:a17:903:234c:b0:20c:8cf9:6147 with SMTP id d9443c01a7336-20fa9deb69dmr65296935ad.1.1729745222473;
        Wed, 23 Oct 2024 21:47:02 -0700 (PDT)
Received: from localhost ([98.97.32.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0c0ee1sm64939785ad.160.2024.10.23.21.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 21:47:02 -0700 (PDT)
Date: Wed, 23 Oct 2024 21:47:01 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: zijianzhang@bytedance.com, 
 bpf@vger.kernel.org
Cc: martin.lau@linux.dev, 
 daniel@iogearbox.net, 
 john.fastabend@gmail.com, 
 ast@kernel.org, 
 andrii@kernel.org, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 mykolal@fb.com, 
 shuah@kernel.org, 
 jakub@cloudflare.com, 
 liujian56@huawei.com, 
 zijianzhang@bytedance.com, 
 cong.wang@bytedance.com
Message-ID: <6719d145530fb_1cb22084e@john.notmuch>
In-Reply-To: <20241020110345.1468595-3-zijianzhang@bytedance.com>
References: <20241020110345.1468595-1-zijianzhang@bytedance.com>
 <20241020110345.1468595-3-zijianzhang@bytedance.com>
Subject: RE: [PATCH bpf 2/8] selftests/bpf: Fix SENDPAGE data logic in
 test_sockmap
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

zijianzhang@ wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>
> 
> In the SENDPAGE test, "opt->iov_length * cnt" size of data will be sent
> in cnt times of sendfile.
> 1. In push/pop tests, they will be invoked cnt times, for the simplicity of
> msg_verify_data, change chunk_sz to iov_length
> 2. Change iov_length in test_send_large from 1024 to 8192. We have pop test
> where txmsg_start_pop is 4096. 4096 > 1024, an error will be returned.
> 
> Fixes: 328aa08a081b ("bpf: Selftests, break down test_sockmap into subtests")
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> ---

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

