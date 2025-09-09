Return-Path: <bpf+bounces-67844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A03B4A593
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 10:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2277D16A375
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 08:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9174F254846;
	Tue,  9 Sep 2025 08:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a8nxIoOf"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DED24EF76
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 08:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757407181; cv=none; b=Gl5rbj/CFfnbGrfS2v83IXs1oMkpNY8iIq7BtDVftk0vPXfY4otyeURWVHRo7sVuREyw7WF+KV/FNRgTDLeTdgIPOaiSbANkTEWmssHLyJ+jAgJuOK20BcKWFq8sfCqejIk784nJahicq+f39O1fHRuFev1fBV+iDQfWuMs/cVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757407181; c=relaxed/simple;
	bh=vHPLwL5CQU5Z7ksG2yxqsuuGbT1FFTbEvzv+jOPpr/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F3nYrgrD4ZL1yuDePMGyUJ9QaL/w+v+HsPL3+P6GQ7txi2OPj90hukXcC7MIi//gQGjAruG14qYSKQPLnUz/uBUgc8C/4+05y0zmavwqvNRthKhQ9YHXUT+lyVrG989jbj/eDeWirFO4Y+Owa9d0vPwQ0CoPSC2pQlNXSXkHmVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a8nxIoOf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757407177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=maLbMap+2LT57yr3xpTTUZY1o3cg9/xDffeybKHOaQ8=;
	b=a8nxIoOfwkHRt68DI9SbfkmN+m7JjZE0X6/Pft+92cBjCsKeUQmoeVZVNN7O8/LUMN4aN8
	nkt0J8BUeI2xzd5/3uS5V4v6jYXyjfP8zMRBbdVqJndEqv/kZuaBaTgZSM8gAYjJVx/nC0
	J9JOFDAxv5H5hg172mu3Bg3umVuZGMM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-SpGXQHeaMkqdB49KGH8l9A-1; Tue, 09 Sep 2025 04:39:36 -0400
X-MC-Unique: SpGXQHeaMkqdB49KGH8l9A-1
X-Mimecast-MFC-AGG-ID: SpGXQHeaMkqdB49KGH8l9A_1757407175
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45dd9a66cfbso37143395e9.1
        for <bpf@vger.kernel.org>; Tue, 09 Sep 2025 01:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757407174; x=1758011974;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=maLbMap+2LT57yr3xpTTUZY1o3cg9/xDffeybKHOaQ8=;
        b=HsLbVRkbO54VeCCOkCBQHD+HUDOwZVt40jjSnj+QcXLnQSbyWPkfktBjyBmaewUfVq
         LkT29PQ0kZGfA/ggBlTU48KD5jwcE1YpM5K15zSIAHWcX2yRkJIwVcUVb4PUJpva7Y4p
         AWK/+EuzOnnAlkL/6ORfg2pVix3Bzbx5jXG9DpaHjeXL/HoimCj4M/0i7wic9M924yer
         XhWuZhHN6R5RnAuOzxPMY1GvhQDBHXsHY/e8jopOrW3KyvWHTukbSEJ/08Ubp3BZTO6i
         utiXEvZQ1F0gfTDHUOD9b5/9xgaXb0jdfFcQKgCmTAyr+VZXh5E86K9Rv4jXF5lyMRFY
         vHUg==
X-Forwarded-Encrypted: i=1; AJvYcCXeIB1c5bxUnfU7ArloJ4SjWOzUyMfqLgduOX8FI/B2cZgXjPwwj3WSGmja8gUl2QyIIn0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwvqp2zTN5IsnbeJHvZqSL8eAWVhJQqTl5riMBTu050qvX8YWd
	0qzV9n3gXR6o9PFAg+z2Reti11UToDh4E0S17sH/sKft3reAGw8mkSYC6z+pFmxyYl/YE/rRwdy
	JSUotToyC5ZO9BIqyV5+5jN4vEjtWzsGM7atVFREf0qrDj82yMrm0kLxq39NGlw==
X-Gm-Gg: ASbGncs/jQzzW8pfM3McK2prA9e/mDJ9xnN7c0+RcVN+mmSscMvfwYhyw7QPI8MhIcE
	AqK4oFaKZsFl3a97EUt3Sw3m0XaNHDMz4CFlmYRjnyBZY9rlturoiItUleCZAgwDkyxZf9LzZv9
	9HrTSChLvJBGaCOdJ8aAyMHY9er2fumyZpUzaJOKc6G6q3C21J0JVCQlsSg2sNo0noqg+5ubYDt
	NfQa0sId7UJfKGAyxGlrCWcdUhiuEXJyy7vMB6c+tB9PMh+eB0moBzDYiWETv5fetdlXVgChIMw
	p8j2Sw+LqLpSoCsIe8hFt4RWPdQHdCHDdf4vUwVP12Ug7Ol3jK20z8FRHT2Mn8mFj/nG0uK/Rhy
	n1q/2fqj4CNY=
X-Received: by 2002:a05:600c:3b1a:b0:45b:9291:320d with SMTP id 5b1f17b1804b1-45ddded3454mr106956635e9.31.1757407174300;
        Tue, 09 Sep 2025 01:39:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKYLjLr4ZoJ0jfoejUOqrxruD9FHV3EcrxDGxf12RFoTaR7PxwRKlFp81591joPR5nP+nJtQ==
X-Received: by 2002:a05:600c:3b1a:b0:45b:9291:320d with SMTP id 5b1f17b1804b1-45ddded3454mr106956235e9.31.1757407173858;
        Tue, 09 Sep 2025 01:39:33 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45cb61377a7sm274262995e9.13.2025.09.09.01.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 01:39:33 -0700 (PDT)
Message-ID: <6516a49f-5d4f-4c3a-8ddc-7d8623aeb816@redhat.com>
Date: Tue, 9 Sep 2025 10:39:32 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 next-next] net/cls_cgroup: Fix task_get_classid()
 during qdisc run
To: Yafang Shao <laoar.shao@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 daniel@iogearbox.net, bigeasy@linutronix.de, tgraf@suug.ch,
 paulmck@kernel.org, razor@blackwall.org
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20250902062933.30087-1-laoar.shao@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250902062933.30087-1-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/25 8:29 AM, Yafang Shao wrote:
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
> Given that dev_queue_xmit() always executes with bh disabled, we can use
> softirq_count() instead to obtain the correct classid.
> 
> The simple steps to reproduce this issue:
> 1. Add network delay to the network interface:
>   such as: tc qdisc add dev bond0 root netem delay 1.5ms
> 2. Build two distinct net_cls cgroups, each with a network-intensive task
> 3. Initiate parallel TCP streams from both tasks to external servers.
> 
> Under this specific condition, the issue reliably occurs. The kernel
> eventually dequeues an SKB that originated from Task-A while executing in
> the context of Task-B.
> 
> It is worth noting that it will change the established behavior for a
> slightly different scenario:
> 
>   <sock S is created by task A>
>   <class ID for task A is changed>
>   <skb is created by sock S xmit and classified>
> 
> prior to this patch the skb will be classified with the 'new' task A
> classid, now with the old/original one. The bpf_get_cgroup_classid_curr()
> function is a more appropriate choice for this case.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Thomas Graf <tgraf@suug.ch>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>

@Daniel: I'm wondering if you have some specific use-case explicit
leveraging the affected helper. If so, could you please test this change
does not break it?

Thanks,

Paolo


