Return-Path: <bpf+bounces-66267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92455B3104D
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 09:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 850931CE3CD1
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 07:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9CA2E8B67;
	Fri, 22 Aug 2025 07:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="O8Y5inc9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88AB2E7BD5
	for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 07:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755847607; cv=none; b=SitTSFyqud9//t6uUgMYgdaT2VZuW4pJAa1zDydBjUWayxdmxeTEuVnu2OyQGTEfY+qgB0mFK1NJ6DsS6saxVLWE+mGOgYf9w9nePJc0/LOoXwvhhD11XQEk+iQb00ONmnf6Udq1PnsH7NoL4XJJKY6igD4xkg3HGUB+g+Z0WXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755847607; c=relaxed/simple;
	bh=/YzDiNUs0MNdPN24taJl6Bj7ZP9vE4B0C45SZtCHV7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rlucnemk21Wpy5Wh2QeaSI4Cp6KxyIqVps7D4CSKkSTlV/JCyFQmZnCNBKaZDH9AkuD0KxMKbnVHETdQ7AfbpBKqnfyxnY90IDdYffLtFk74PpujuY4+x8xF02knBwDgjNiWgP+X3kdHaEk1U6VGWKBdV7gMCXqhPk3x5LK4m3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=O8Y5inc9; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-619487c8865so4999558a12.1
        for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 00:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1755847604; x=1756452404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YkCBHqC6hkeu3pks9cF863PKhddTjTOP8QecN7y7a1I=;
        b=O8Y5inc9Y9Cufnp7ah9Sg8j3JzztwhZkgo9DrNv/QEJyuTk4wnSsmQEhaqyXMe2waY
         Eww4ycA47p981fUoegZCkbifj9u96SFO2H/HumZxtIw8PVHNjMhh1jukzHg/weteyoCr
         lgOj8YoKNqrTxGWFfEO4yQqTxAtsx5z6wsS8yXOpQl1KV7jlXxrxpFsG/TLjCB1kyusi
         coRN+AGXwUatmUJWEvsA7Brt4hVm6FStahek97zhy1/OO6/oG+n6FU8YplB6ReDSirGA
         xF2KCiufZtrQMsD5UtOnEj9kHkwzVEajVre9M9CpspvYr3QHYPOY/I3YY9/pFEwiUvVe
         YxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755847604; x=1756452404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YkCBHqC6hkeu3pks9cF863PKhddTjTOP8QecN7y7a1I=;
        b=BnwfNaVe6Bxspv1U3q3MoqoItOPqJ8QrvCnqQ+MpXuNXI+IDCKDf0rjFPJuV1aS+ef
         op9XChWNNLOym1BPJb4jHyCxWxK4CI4KNA9c4o/O6lHnCKSNDleIXuLbxypgFjZSqKPY
         2zIAvfOgX3Mog6waX0GOvMVDOaDX1ZTc60UhlnecaG0jLoK8zdzhllNjO8IOLmBAeruj
         0+KX9N/UilmJo+djPgc9ChgueCgca3p86lBkYKO1QgwaFY69jt5RmUKCEt5bSR97OSxE
         1PHQCpyEJZw2ghroNh7DDGpBmo1Ii3f+Y4HLRYNjKL8sAn/J91WWpD1giAUiBVUq9jd0
         PE9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqQE0y1wBV/ZzCIODrFaAkajhp6hfZRXlMQWZpZy1TpOlAxi8jCNYAeU4bXITj6B3++no=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTYd/U8hulPAt7nmer1VX/Ub9HEHBKTnn0dyifJAaWLoocE02Y
	hc0BoYK1W8QEEc4ExFUW2JZEgIvhay+8mRZAsO/TNqtpOPmwrbovyfCr86epthi1A9o=
X-Gm-Gg: ASbGnctg9L1D866ujgwLp5lucFyjIjEvhrRvxBADy3epwEbcicPtfptMdJ1MrTjs1iM
	v/sfuBfh9Dz+Cp+FDfTACEwHmfKzeOezf6uO4UajTomg5LeGKiLqPb9INsKcaZ5L2u03GcUraoD
	QnmIvu62IHl1he/6W639PQfQ5sJysxoYRMth2kNG8YBmtD5Fn6brS5p3Dhah37iyLt1ELlZpVfi
	wzsnNHW3CCSAndyJ4zE1gHe1o/5fuE85MqtrYh5xnlDaxedWWAQ10q2JzxnXI1fwnwhUYhUBpOf
	nRgrDOOvnjgj4f5xws8HDo5Jrb/1yhkHuK5VzklRIN5biOjnEl5HA4fNGPLLnlMaA+q4mAn82aV
	hNIP16/T70LL4h00HHCjSbG4l2DPmXpy9jESYlXhpWHWYthO3zC+URA==
X-Google-Smtp-Source: AGHT+IHGfZ8P7tgu80xMWCg8ePf2z7xgt63VR2ssnLjdHjM9Fx5i6pO37IMRM0WOjccKlN04n6re1A==
X-Received: by 2002:a17:906:3689:b0:afe:2ef3:8358 with SMTP id a640c23a62f3a-afe2ef387eemr107664466b.22.1755847603725;
        Fri, 22 Aug 2025 00:26:43 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded5353cdsm550935966b.106.2025.08.22.00.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 00:26:43 -0700 (PDT)
Message-ID: <87303e90-3c74-4e4f-8fac-2001d82b90d8@blackwall.org>
Date: Fri, 22 Aug 2025 10:26:41 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/cls_cgroup: Fix task_get_classid() during qdisc
 run
To: Yafang Shao <laoar.shao@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 daniel@iogearbox.net, bigeasy@linutronix.de, tgraf@suug.ch,
 paulmck@kernel.org
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20250822064200.38149-1-laoar.shao@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250822064200.38149-1-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/22/25 09:42, Yafang Shao wrote:
> During recent testing with the netem qdisc to inject delays into TCP
> traffic, we observed that our CLS BPF program failed to function correctly
> due to incorrect classid retrieval from task_get_classid(). The issue
> manifests in the following call stack:
> 
>         bpf_get_cgroup_classid+5
>         cls_bpf_classify+507
>         __tcf_classify+90
>         tcf_classify+217
>         __dev_queue_xmit+798
>         bond_dev_queue_xmit+43
>         __bond_start_xmit+211
>         bond_start_xmit+70
>         dev_hard_start_xmit+142
>         sch_direct_xmit+161
>         __qdisc_run+102             <<<<< Issue location
>         __dev_xmit_skb+1015
>         __dev_queue_xmit+637
>         neigh_hh_output+159
>         ip_finish_output2+461
>         __ip_finish_output+183
>         ip_finish_output+41
>         ip_output+120
>         ip_local_out+94
>         __ip_queue_xmit+394
>         ip_queue_xmit+21
>         __tcp_transmit_skb+2169
>         tcp_write_xmit+959
>         __tcp_push_pending_frames+55
>         tcp_push+264
>         tcp_sendmsg_locked+661
>         tcp_sendmsg+45
>         inet_sendmsg+67
>         sock_sendmsg+98
>         sock_write_iter+147
>         vfs_write+786
>         ksys_write+181
>         __x64_sys_write+25
>         do_syscall_64+56
>         entry_SYSCALL_64_after_hwframe+100
> 
> The problem occurs when multiple tasks share a single qdisc. In such cases,
> __qdisc_run() may transmit skbs created by different tasks. Consequently,
> task_get_classid() retrieves an incorrect classid since it references the
> current task's context rather than the skb's originating task.
> 
> Given that dev_queue_xmit() always executes with bh disabled, we can safely
> use in_softirq() instead of in_serving_softirq() to properly identify the
> softirq context and obtain the correct classid.
>
 
nit: you are no longer using in_softirq() in v2, you should update the
commit message as well.

[snip]

Cheers,
 Nik


