Return-Path: <bpf+bounces-50525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 667C5A29566
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 16:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F962167418
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 15:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C0A18FDDE;
	Wed,  5 Feb 2025 15:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnYFwDPP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30CE17B4FF;
	Wed,  5 Feb 2025 15:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770867; cv=none; b=UQPpwCR01FK4RYfOq69iYjB4Dok8OWLKWo4yPAlO3XksQSUwSDi2CqfLTgkHriwfZUypK82fbxN1dJi+Qi9iHEpDps6VODAmXhFoAAnjWQC9Ql8B+qvFZ/30O10+s37K2sYDNfdbPemSfL5Ftk/5Hj2JhiJ5u5u7Q/x3+qsbZTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770867; c=relaxed/simple;
	bh=NddFo7pHGxOYVD1rlayBJJ2Yt2lNUNtVRU4Hs7xUq6Y=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=AOU3GIJaSm2JPNw0iR8NVqmJCEtuJfjpS9JenBAHDUn7JakSnHv31k2L+9J7EsD3Y1T/ObzXgLoInvIp8at0K7XF1xM3uzUlxJaXzHR5fCwd14lS2m9/OZsAXEQ1ij402GMGTzOfM6fYJmezZipg1aqnjhowoP3LD+Cy2SOPe/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnYFwDPP; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4aff620b232so2115826137.0;
        Wed, 05 Feb 2025 07:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738770865; x=1739375665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoodWVEkqC0vSzEBKMeol9Q37vSk2OY2aQv2UOwU71I=;
        b=GnYFwDPPtp8W9mwmYvOQSlwxnMnqeo95RPUGcUbmmJWyBY2L5Jg379jkYSMofDABNS
         MhtZxbY2SmzmP4C9j82u6409At3V1nB8ei1PwrooYfs6dzaqZ9tPFzVqpuQg0v/ipI2i
         2kYmaYQ0K0/CmvNrpJ/acnGmAQSAnO8dTg1P1vzro0wQ7R1B+L4y+/q4/UdSyQ5j3AOe
         rJWbhxGUZWnOCcgvC749TEVFamLHvMySGec81MQVERrvpe8AQeafyREKFK1hAagKfJ4V
         WMQ6jTzyBe/iEURp7vs9WWK4ThjQappaYnCFW4xWgfNS5A9SP+4W7xw4x/eZOXhVIS2Q
         7+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738770865; x=1739375665;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BoodWVEkqC0vSzEBKMeol9Q37vSk2OY2aQv2UOwU71I=;
        b=pVxgh/dRGp+LsVDZO26c4DJmuq8FoZxvCCDqpuF1tF8OP6NdNoVwT/a+pd6WAhueEo
         B1gE3mgNt6wqzhikt5RB5Poc6q7j85BcZagzvT0KeFD9c1m4KzrXx/spv+rETHE6lg4H
         ya4BvbKtQWxNCc1EzzYum5C42UtlRMW7yjczwbQcZmVBdCC7MFzAvf+uUpMICUSbc9By
         LAYiuQAuB7j5EB5RTZlff0Gh8M/342Uwfpm0HqCXCU/1qmin6lBgQTfQrFoHRnkTz27F
         nHxW+/ckLYYoaJ0um8pMrqdD0hLo+myia8DSInfY9F7wCFxCFQJc+9XHEBBK3AnVGWDL
         Rd/g==
X-Forwarded-Encrypted: i=1; AJvYcCWwf2kZIEDvU66JQ0wb3fzsbxaFqP65oUVAV7AqnXrpMOldd9Dr2DraK7J2hMTVZib+HaN5flk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyAqV0OcAby/w8V37klhFAFyQS4AlM58tGeSM9eyl98827hatl
	cOeu+4PPwTBpQTWRTXrT9o71ED4FORogYFugx8ViLzOPjCbh6lDp
X-Gm-Gg: ASbGncv6wathWg9ByMhJ5WES+n2NhhJd9Li1KHyQdDrazhOJdDlSUMigw5o/44Vrvyv
	+w8p/iB0+KKdqxDWZ7VwO2tHfhN9PTXEJkSdQqHFAWc9EnvPOs8yCECZ1lh0Bo5dNks1j1kpkJX
	8wLiMkQs3zwpiIj0K/fNLicq40Rh0KK2UhcS2NyfT0wJ/Qwk+gJDLIsGPvO1W35wRUnl0QjPjd0
	jmpcCHWzPfe2UUUC8xjO9TwgQk23Imm6Np8njJ+1m/QpeT9AYBCCcbbYjHqWMp7lblO5WMv/qgK
	djZe6v2jT/K/qUOmVNGKQMdMQ7ARCVvYb7DuDsvca7um3NNSBeJu7ZO9JA0y5vE=
X-Google-Smtp-Source: AGHT+IGyb070xp1TAY9/hmfH0vIei5z7pLSfRHLpkJL76Go1KURLWYqldJWvZslXqO7xtooG9FPJvw==
X-Received: by 2002:a05:6102:3306:b0:4af:fc14:f138 with SMTP id ada2fe7eead31-4ba478b3694mr2316719137.7.1738770864612;
        Wed, 05 Feb 2025 07:54:24 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b9baa14c0fsm2414454137.2.2025.02.05.07.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 07:54:24 -0800 (PST)
Date: Wed, 05 Feb 2025 10:54:23 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 horms@kernel.org
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kerneljasonxing@gmail.com>
Message-ID: <67a389af981b0_14e0832949d@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250204183024.87508-13-kerneljasonxing@gmail.com>
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-13-kerneljasonxing@gmail.com>
Subject: Re: [PATCH bpf-next v8 12/12] selftests/bpf: add simple bpf tests in
 the tx path for timestamping feature
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> Bpf prog calculates a couple of latency delta between each tx points
> which SO_TIMESTAMPING feature has already implemented. It can be used
> in the real world to diagnose the behaviour in the tx path.
> 
> Also, check the safety issues by accessing a few bpf calls in
> bpf_test_access_bpf_calls().
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>

> +static bool bpf_test_delay(struct bpf_sock_ops *skops, const struct sock *sk)
> +{
> +	struct bpf_sock_ops_kern *skops_kern;
> +	u64 timestamp = bpf_ktime_get_ns();
> +	struct skb_shared_info *shinfo;
> +	struct delay_info dinfo = {0};
> +	struct sk_tskey key = {0};
> +	struct delay_info *val;
> +	struct sk_buff *skb;
> +	struct sk_stg *stg;
> +	u64 prior_ts, delay;
> +
> +	if (bpf_test_access_bpf_calls(skops, sk))
> +		return false;
> +
> +	skops_kern = bpf_cast_to_kern_ctx(skops);
> +	skb = skops_kern->skb;
> +	shinfo = bpf_core_cast(skb->head + skb->end, struct skb_shared_info);
> +	key.tskey = shinfo->tskey;
> +	if (!key.tskey)
> +		return false;
> +
> +	key.cookie = bpf_get_socket_cookie(skops);
> +	if (!key.cookie)
> +		return false;
> +
> +	if (skops->op == BPF_SOCK_OPS_TS_SND_CB) {
> +		stg = bpf_sk_storage_get(&sk_stg_map, (void *)sk, 0, 0);
> +		if (!stg)
> +			return false;
> +		dinfo.sendmsg_ns = stg->sendmsg_ns;
> +		bpf_map_update_elem(&time_map, &key, &dinfo, BPF_ANY);
> +		goto out;
> +	}
> +
> +	val = bpf_map_lookup_elem(&time_map, &key);
> +	if (!val)
> +		return false;
> +
> +	switch (skops->op) {
> +	case BPF_SOCK_OPS_TS_SCHED_OPT_CB:
> +		delay = val->sched_delay = timestamp - val->sendmsg_ns;
> +		break;

For a test this is fine. But just a reminder that in general a packet
may pass through multiple qdiscs. For instance with bonding or tunnel
virtual devices in the egress path.

> +	case BPF_SOCK_OPS_TS_SW_OPT_CB:
> +		prior_ts = val->sched_delay + val->sendmsg_ns;
> +		delay = val->sw_snd_delay = timestamp - prior_ts;
> +		break;
> +	case BPF_SOCK_OPS_TS_ACK_OPT_CB:
> +		prior_ts = val->sw_snd_delay + val->sched_delay + val->sendmsg_ns;
> +		delay = val->ack_delay = timestamp - prior_ts;
> +		break;

Similar to the above: fine for a test, but in practice be aware that
packets may be resent, in which case an ACK might precede a repeat
SCHED and SND. And erroneous or malicious peers may also just never
send an ACK. So this can never be relied on in production settings,
e.g., as the only signal to clear an entry from a map (as done in the
branch below).

> +	}
> +
> +	if (delay >= delay_tolerance_nsec)
> +		return false;
> +
> +	/* Since it's the last one, remove from the map after latency check */
> +	if (skops->op == BPF_SOCK_OPS_TS_ACK_OPT_CB)
> +		bpf_map_delete_elem(&time_map, &key);
> +
> +out:
> +	return true;
> +}
> +

