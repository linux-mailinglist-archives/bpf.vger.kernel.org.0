Return-Path: <bpf+bounces-43223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A66169B14F5
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 07:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15DDF282856
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 05:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3C81632D9;
	Sat, 26 Oct 2024 05:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgM6vLyG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7072AE93
	for <bpf@vger.kernel.org>; Sat, 26 Oct 2024 05:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729919120; cv=none; b=rkR4ObByudIcWt9UNggHCV2WZp2pNlGXVkFu6B0rhJQR2EDTBFrKbbOSLELvZPLHgoBW7gDIUDOd5zqWYWf2YzIWotM7fLrrhd/H+m3N2EK9OqHU77mU05Lq+Ib/p7JQ8pDPwbH6j5vB2i+NxpYcIad5rwlee/rQkS4rqz0ywuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729919120; c=relaxed/simple;
	bh=moGSiS9lImhqu+ZZa0CNGaYfCBuqsKe8AgX88Es5Nis=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=BLXwPaoxncm93ucsNIXfTF+4Y85tkrJFFRHqmHCWPPpu38adPGJV4eg5X+YeaE5A9PrBUqY7WqqDZUJjdBIe836htvAizJ/iFgkr3Cp1DG1I7Ct+vesHx5xTmKKOzS9Xz8I1vfPD97V+MpVH9PflVQ8vqElebQzgsdMvsbpwkMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgM6vLyG; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c8c50fdd9so23444055ad.0
        for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 22:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729919117; x=1730523917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fi0UhH/1mybD0rjQDMKUwajQMLQ99jOjxhSSGaIb1nw=;
        b=YgM6vLyG8+y/jymzG3zFp8O2Ix77ExM6MjnY9fMiC0p8Px8CMJ+uqL0UlKenNRz8s9
         5YNbS7cVi0HnhnC38mT1afxSnBbRMrebMF6C8YhdfQusgptTIQc9F17v1ua99fXJa/7z
         BhgV0T++3tHMkYcU+bQl/cSXnfQ6EEIuGvEPNvkvQVgZTIY9AauwrxNtlcIanmcBVSA9
         GZE29mH80VBPj7bIkUPo7Hx8IL9MxF6i4pyf7kjnXcLRBJ08qWiUji2j8BlPxZjPymZy
         EORAvFZJoKlCAWoEJxBHFkBUPMQ7AfdIqK+zVdDZger+T1V7+AD79Y0jAatQbEIF+RPx
         1DNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729919117; x=1730523917;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fi0UhH/1mybD0rjQDMKUwajQMLQ99jOjxhSSGaIb1nw=;
        b=OqIzZnsVcRSAhzn5i2Y/UdfMdDN63ofOGbPm9Ph1PU0okkbQr2nXMHGAjjivrfBM4K
         K4j2pZ2lRNfwOi5JO4leVz+jl+ZQSLlizxXvomoCGl1l8nxOyHK9+cq3EVQ1gEDmJW+i
         6A24NcrVZvWIl9g8EOn1A8flZumMohg/ys3e1xFTjJ7DUwEpXEHYT7JYT/IwtHYnhSOw
         nt5luROfbupAsHvNwmIA9GInfdZXmam1h0eIbsamXpfYHcubg7LMVpyAcWSdRxIWRlhr
         MZoMxE/dxCzjCLrNh0bbeUR7FFx7HasJusMXRqbHmtZjC6tf38BYkrNsQGflljQ9mRdL
         hxig==
X-Forwarded-Encrypted: i=1; AJvYcCWPTCC6kI+OWu25Px0ZiUB8Xs6Y2/sj/aP79ltBpJLiJ2yGv40/YOso8TLv1wRtv5Zfxs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBMtzc0G/tBkZBIfqSYn/NMppVkTpMKYdO3InMTr9sEaxCylA4
	Cks6QLx0QtDRzMELp5aeDQsyaT3D3cyqJRJP9mGF3/j24IjLJHVp
X-Google-Smtp-Source: AGHT+IEdhRTeP5ed0S3Gtf55NVJL8EBM0TC0J7/G3yv+ZzkohBIzdo1JzxsSXQuw3r0CgFMAdnjPMg==
X-Received: by 2002:a17:902:f68e:b0:20c:7661:dc9a with SMTP id d9443c01a7336-210c59379a0mr28337045ad.3.1729919117463;
        Fri, 25 Oct 2024 22:05:17 -0700 (PDT)
Received: from localhost ([98.97.36.166])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc044da4sm17605925ad.246.2024.10.25.22.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 22:05:16 -0700 (PDT)
Date: Fri, 25 Oct 2024 22:05:15 -0700
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
Message-ID: <671c788b7322c_656c20869@john.notmuch>
In-Reply-To: <20241020110345.1468595-9-zijianzhang@bytedance.com>
References: <20241020110345.1468595-1-zijianzhang@bytedance.com>
 <20241020110345.1468595-9-zijianzhang@bytedance.com>
Subject: RE: [PATCH bpf 8/8] bpf, sockmap: Fix sk_msg_reset_curr
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
> Found in the test_txmsg_pull in test_sockmap,
> ```
> txmsg_cork = 512;
> opt->iov_length = 3;
> opt->iov_count = 1;
> opt->rate = 512;
> ```
> The first sendmsg will send an sk_msg with size 3, and bpf_msg_pull_data
> will be invoked the first time. sk_msg_reset_curr will reset the copybreak
> from 3 to 0, then the second sendmsg will write into copybreak starting at
> 0 which overwrites the first sendmsg. The same problem happens in push and
> pop test. Thus, fix sk_msg_reset_curr to restore the correct copybreak.
> 
> Fixes: bb9aefde5bba ("bpf: sockmap, updating the sg structure should also update curr")
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>

Hi Zijian, question on below.

> ---
>  net/core/filter.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 8e1a8a8d8d55..b725d3a2fdb8 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2619,18 +2619,16 @@ BPF_CALL_2(bpf_msg_cork_bytes, struct sk_msg *, msg, u32, bytes)
>  

I find push_data a bit easier to think through so allow me to walk
through a push example.

If we setup so that curr=0 and copybreak=3 then call

 push_data(skmsg, 2, 2);

When we get to the sk_msg_reset_curr we should have a layout,

  msg->sg.data[0] = length(2) equal to original [0,2]
  msg->sg.data[1] = length(2)
  msg->sg.data[2] = legnth(1) equal to original [3] 

The current before the reset curr will be,

 curr = 1
 copybreak = 3

>  static void sk_msg_reset_curr(struct sk_msg *msg)
>  {
> -	u32 i = msg->sg.start;
> -	u32 len = 0;
> -

with above context i = 0

> -	do {
> -		len += sk_msg_elem(msg, i)->length;
> -		sk_msg_iter_var_next(i);
> -		if (len >= msg->sg.size)
> -			break;
> -	} while (i != msg->sg.end);

When we exit loop,

  i = 3
  len = 5
  
  msg->sg.curr = 3
  msg->sg.copybreak = 0

So we zero the copy break and set curr = 3. The next send
should happen over sg.curr=3? What did I miss?

> +	if (!msg->sg.size) {
> +		msg->sg.curr = msg->sg.start;
> +		msg->sg.copybreak = 0;
> +	} else {
> +		u32 i = msg->sg.end;
>  
> -	msg->sg.curr = i;
> -	msg->sg.copybreak = 0;
> +		sk_msg_iter_var_prev(i);

With this curr will always point to the end-1 but I'm not sure this can
handle the case where we have done sk_msg_alloc() so we have start/end
setup. And then on a copy fault for example we might have curr pointing
somewhere in the middle of that. I think I will need to construct the
example, but I believe this is originally why the 'i' is discovered
by sg walk vs simpler end.

> +		msg->sg.curr = i;
> +		msg->sg.copybreak = msg->sg.data[i].length;

This does seem more accurate then simply zero'ing out the copybreak
which is a good thing.

> +	}
>  }
>  
>  static const struct bpf_func_proto bpf_msg_cork_bytes_proto = {
> -- 
> 2.20.1
> 



