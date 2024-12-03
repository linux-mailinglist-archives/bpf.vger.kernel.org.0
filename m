Return-Path: <bpf+bounces-46008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47ECB9E1E88
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 15:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBF82162173
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 14:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E791EF08A;
	Tue,  3 Dec 2024 14:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NT6gVW5V"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2241F4267
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 14:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733234410; cv=none; b=B0D6mR1CpWAFySKvHmb95zuIN4wNd5pNb+I9o1bdf0SAKT6l7CgKD77Mjy0sTGaJZPIJUxzM3Xc1VFwoS+h7mNaEAAmseaSfTYWDJ7bwLvwrFqW9kkprc+YQGbFmueOlo19T5sjfEVVcMB3qyz7EcfCauJdaK/PrN46hom5mp2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733234410; c=relaxed/simple;
	bh=dJjfJif9+NlZQkMt5icrEVoK39zkPJdf3OM+1DJQHmg=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bW8rMcDgvVHNGpb3+B1fTT6FuUvvkz4P+j/9JL9J9+uiXBXYfLRuYbnAOfxSKATWgREhvcR8YcSwBqtD1oJEbtGcew7bJdntIKfuc2Ox8zPie3AG7HNFIBOdesurHlEPzimFvKFIPtojS26jADYXwLljKGhjScMbILhEFVLptIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NT6gVW5V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733234407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fl1kU/L6n+zaZv63NSCNUSgE6RK0H5Lz0VGKZARdJxc=;
	b=NT6gVW5Vrd09nOKBnJDNlqzAe1fzN2ABSqBpZSAOTiou11x8iRFiN8X8Gxk9/zuzJ5lwew
	KEcDke/N6oQuWyfjDBZGauw0AsSEAV392teKBfR30tJP+Q+4Yn5X6UkYT+GsXDAKbsMXhz
	pahWFRUdNkG2E5GPZgk/EWfDYzQxa4I=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-IS5cWTh7OC6yw-7R-s3Y6Q-1; Tue, 03 Dec 2024 09:00:06 -0500
X-MC-Unique: IS5cWTh7OC6yw-7R-s3Y6Q-1
X-Mimecast-MFC-AGG-ID: IS5cWTh7OC6yw-7R-s3Y6Q
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-215936689e4so23979205ad.2
        for <bpf@vger.kernel.org>; Tue, 03 Dec 2024 06:00:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733234405; x=1733839205;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fl1kU/L6n+zaZv63NSCNUSgE6RK0H5Lz0VGKZARdJxc=;
        b=mW4szswfBB9gY+YyImS9Lj+fCS4MeXXEJByZt+3eKuM95PwH0sk7kKkkI8S/mb3lVq
         3QoxtNolEtyCTY9VmGnj62inZ2BQ5c88vIoMR/lsliQWdjPkVKJpQC6NkfhooS0d8GlB
         N7AXmjZmeEwat+Br31mYNs0P/kKws6i9JEvls9qsoj+5RMeRoGAIqORP/BprAW22EfeB
         +OI1jhxpM661y80eAPsQQMoRt8GC+QibSYuyrJl8PbSwpvlXmSrk0Fx8mVg00zAAd5F5
         16PVznd8Ugxjqv8To8aNDf9T4/BtLAPJmpytvXPp19hfVMUSiTSO5SwymrlVaTOkirEH
         T44A==
X-Forwarded-Encrypted: i=1; AJvYcCU4wV10eq4JQxDjEeSxwUsbdlOTz4VdOHXL1sWRI+S09YNNn+dqCDmEPN/dE/QkjmIg59o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybv/NxTVVsGCXZlzd0OPUGXuFhtYfaW2xNju3xZ842a8V6rw8a
	EmqkoaOWAwTUPqlVCkM8B7/JlgEOuaEe6UgP64mVeIXR12AFrd5Af2X/FxVMq24CYmiRpQpMMF9
	zNOdtZL2H47xjOoL3ZrMiGbbnS8pXzMbq8CPrIjIcY1OftnJzoA==
X-Gm-Gg: ASbGncsPSAZFz+ByLee2/K+yw5Qms7jEliKCqpVvevSQnWSTqFbrR382QA1bW+3VCeE
	VDdNz5Ne06QcwWWzPrm+v0M2IpFwfbaRRypc8netr3xo/1+lwWsoYr9bB4TFaAT/7gvHKpYRt5o
	2Fhjl7m/txop6x2uP+cNqGJ8pu7aP7KZJHMQEx27kVZjCaKA+8WD7GfdZq14RULP2DajraATVvR
	kLFiMhQe5r82dWE9MpSgQXz+jlJz8zhGfI6WlOdk99k9BE=
X-Received: by 2002:a17:902:e742:b0:215:a039:738 with SMTP id d9443c01a7336-215bcea13a8mr32173985ad.5.1733234404690;
        Tue, 03 Dec 2024 06:00:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYiuXZetHC7zsjaCgaDZyegMyjpvT6rLdlGDyG4NPwbra0JvrrlkQFkV9cOrYMzAmHqqmD5Q==
X-Received: by 2002:a17:902:e742:b0:215:a039:738 with SMTP id d9443c01a7336-215bcea13a8mr32172915ad.5.1733234404092;
        Tue, 03 Dec 2024 06:00:04 -0800 (PST)
Received: from localhost ([240d:1a:c0d:9f00:523b:c871:32d4:ccd0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2154c2b9bdcsm71167585ad.258.2024.12.03.05.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 06:00:03 -0800 (PST)
Date: Tue, 03 Dec 2024 22:59:56 +0900 (JST)
Message-Id: <20241203.225956.138899513616764420.syoshida@redhat.com>
To: stfomichev@gmail.com, martin.lau@linux.dev
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 hawk@kernel.org, lorenzo@kernel.org, toke@redhat.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, syzkaller@googlegroups.com
Subject: Re: [PATCH bpf] bpf, test_run: Fix use-after-free issue in
 eth_skb_pkt_type()
From: Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <Z05Ln1XgniGiSuKu@mini-arch>
References: <Z03dL0zxEnmzZUN7@mini-arch>
	<80d8c4cf-2897-4385-b849-2dbac863ee39@linux.dev>
	<Z05Ln1XgniGiSuKu@mini-arch>
X-Mailer: Mew version 6.9 on Emacs 29.4
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 2 Dec 2024 16:06:55 -0800, Stanislav Fomichev wrote:
> On 12/02, Martin KaFai Lau wrote:
>> On 12/2/24 8:15 AM, Stanislav Fomichev wrote:
>> > On 12/02, Shigeru Yoshida wrote:
>> > > KMSAN reported a use-after-free issue in eth_skb_pkt_type()[1]. The
>> > > cause of the issue was that eth_skb_pkt_type() accessed skb's data
>> > > that didn't contain an Ethernet header. This occurs when
>> > > bpf_prog_test_run_xdp() passes an invalid value as the user_data
>> > > argument to bpf_test_init().
>> > > 
>> > > Fix this by returning an error when user_data is less than ETH_HLEN in
>> > > bpf_test_init().
>> > > 
>> > > [1]
>> > > BUG: KMSAN: use-after-free in eth_skb_pkt_type include/linux/etherdevice.h:627 [inline]
>> > > BUG: KMSAN: use-after-free in eth_type_trans+0x4ee/0x980 net/ethernet/eth.c:165
>> > >   eth_skb_pkt_type include/linux/etherdevice.h:627 [inline]
>> > >   eth_type_trans+0x4ee/0x980 net/ethernet/eth.c:165
>> > >   __xdp_build_skb_from_frame+0x5a8/0xa50 net/core/xdp.c:635
>> > >   xdp_recv_frames net/bpf/test_run.c:272 [inline]
>> > >   xdp_test_run_batch net/bpf/test_run.c:361 [inline]
>> > >   bpf_test_run_xdp_live+0x2954/0x3330 net/bpf/test_run.c:390
>> > >   bpf_prog_test_run_xdp+0x148e/0x1b10 net/bpf/test_run.c:1318
>> > >   bpf_prog_test_run+0x5b7/0xa30 kernel/bpf/syscall.c:4371
>> > >   __sys_bpf+0x6a6/0xe20 kernel/bpf/syscall.c:5777
>> > >   __do_sys_bpf kernel/bpf/syscall.c:5866 [inline]
>> > >   __se_sys_bpf kernel/bpf/syscall.c:5864 [inline]
>> > >   __x64_sys_bpf+0xa4/0xf0 kernel/bpf/syscall.c:5864
>> > >   x64_sys_call+0x2ea0/0x3d90 arch/x86/include/generated/asm/syscalls_64.h:322
>> > >   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>> > >   do_syscall_64+0xd9/0x1d0 arch/x86/entry/common.c:83
>> > >   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> > > 
>> > > Uninit was created at:
>> > >   free_pages_prepare mm/page_alloc.c:1056 [inline]
>> > >   free_unref_page+0x156/0x1320 mm/page_alloc.c:2657
>> > >   __free_pages+0xa3/0x1b0 mm/page_alloc.c:4838
>> > >   bpf_ringbuf_free kernel/bpf/ringbuf.c:226 [inline]
>> > >   ringbuf_map_free+0xff/0x1e0 kernel/bpf/ringbuf.c:235
>> > >   bpf_map_free kernel/bpf/syscall.c:838 [inline]
>> > >   bpf_map_free_deferred+0x17c/0x310 kernel/bpf/syscall.c:862
>> > >   process_one_work kernel/workqueue.c:3229 [inline]
>> > >   process_scheduled_works+0xa2b/0x1b60 kernel/workqueue.c:3310
>> > >   worker_thread+0xedf/0x1550 kernel/workqueue.c:3391
>> > >   kthread+0x535/0x6b0 kernel/kthread.c:389
>> > >   ret_from_fork+0x6e/0x90 arch/x86/kernel/process.c:147
>> > >   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>> > > 
>> > > CPU: 1 UID: 0 PID: 17276 Comm: syz.1.16450 Not tainted 6.12.0-05490-g9bb88c659673 #8
>> > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
>> > > 
>> > > Fixes: be3d72a2896c ("bpf: move user_size out of bpf_test_init")
>> > > Reported-by: syzkaller <syzkaller@googlegroups.com>
>> > > Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
>> > > ---
>> > >   net/bpf/test_run.c | 2 +-
>> > >   1 file changed, 1 insertion(+), 1 deletion(-)
>> > > 
>> > > diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
>> > > index 501ec4249fed..756250aa890f 100644
>> > > --- a/net/bpf/test_run.c
>> > > +++ b/net/bpf/test_run.c
>> > > @@ -663,7 +663,7 @@ static void *bpf_test_init(const union bpf_attr *kattr, u32 user_size,
>> > >   	if (size < ETH_HLEN || size > PAGE_SIZE - headroom - tailroom)
>> > >   		return ERR_PTR(-EINVAL);
>> > > -	if (user_size > size)
>> > > +	if (user_size < ETH_HLEN || user_size > size)
>> > >   		return ERR_PTR(-EMSGSIZE);
>> > >   	size = SKB_DATA_ALIGN(size);
>> > > -- 
>> > > 2.47.0
>> > > 
>> > 
>> > I wonder whether 'size < ETH_HLEN' above is needed after your patch.
>> > Feels like 'user_size < ETH_HLEN' supersedes it.
>> 
>> May be fixing it by replacing the existing "size" check with "user_size"
>> check? Seems more intuitive that checking is needed on the "user_"size
>> instead of the "size". The "if (user_size > size)" check looks useless also.
>> Something like this?
>> 
>> -	if (size < ETH_HLEN || size > PAGE_SIZE - headroom - tailroom)
>> +	if (user_size < ETH_HLEN || user_size > PAGE_SIZE - headroom - tailroom)
>> 		return ERR_PTR(-EINVAL);
>> 
>> -	if (user_size > size)
>> -		return ERR_PTR(-EMSGSIZE);
>> -
>> 
> 
> Agreed, that should do it. IIUC, 'user_size > size' only makes sense
> for the bpf_prog_test_run_xdp case and the caller handles this case
> anyway (size > max_data_sz).

Thank you for your comment.  I'll take your suggestion and test it
with the reproducer.

Thanks,
Shigeru


