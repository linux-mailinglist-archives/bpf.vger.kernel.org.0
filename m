Return-Path: <bpf+bounces-45972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 428819E0F7F
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 01:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A683FB22693
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 00:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44945A59;
	Tue,  3 Dec 2024 00:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5sUUdz9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBED645;
	Tue,  3 Dec 2024 00:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733184418; cv=none; b=d5X3MHkwSQwdbSDtOAuPhLb1dNJOfVaRR9v+6BfoVYzWX8H1Ig4tz6cLJCgb0k5imioAB7ZCUs83pFx3fH80zZ9ldJNhjgG6jpaVyMj346puxujVCXCZfJtn/v0p0IiJvbtGbesSuRQplMf8FHlFHAPouMucxpODIZ2isV57RTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733184418; c=relaxed/simple;
	bh=pW4nYHWR14o4ap1dbfmk9yTDBx86sUnB1m/+4K2dAkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opooaB3+CPCysnB3dgcGoBUhG3tcXIKnCvZpTXXrFo5gjJP1HtC004Pw7mM8hwWtnsNaZCAFABRFTaqgCUk1pdESzxE9sX/USzfHdN7WC+4UuXs5KCxC2FgojaK0eBWO5qluGuNff1ueXACAcZ4tmq+hWjM3orkgRdVkno99tJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5sUUdz9; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7250c199602so4073514b3a.1;
        Mon, 02 Dec 2024 16:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733184416; x=1733789216; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=odaPXKxztmpcnjVH9lWKPxgqWfcMuD0DR0cbvTk+PNk=;
        b=h5sUUdz9Z2WEmN5U6cufQLtIf8Gfl2dy3hPXiVAfm+Kk/2d/FqYptXQdMgsT3mu60k
         u0gdA84FqxX8TijvAPbvfOjBWuJAqTZ82CcfaWKM71JPTvBpuRiD5383NumAPqJP+El6
         MgqXIBVGpbNEU3SKNKPAiYPv/Au0ixzQP7ZmAXrvVkkk/C7bnOcnxO2RK50lXoKYWgTS
         CBY+Ttw/IeRzF4daSEyZTWRhDqleC4aCZlT6sSWQiQiRsejdWhVBRB9E08Tw3Ec9OBaI
         27I2uRJWgudTM9SV979e7/ppd0aQE61gIJAVWCimmvExwF65+QQsaI8kPQO9WdTospnt
         Vcew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733184416; x=1733789216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odaPXKxztmpcnjVH9lWKPxgqWfcMuD0DR0cbvTk+PNk=;
        b=A7ZxFHcdRO//hgkixuMc6A0cdWrWII5yQnoWKZZUyq+MWU1SqOZiwP6B5uz221DQeQ
         kqBqeAqqOpTek1jHQrfGBB+umSCj0RbbDyUcMRig2gjYo+8qMLMR+lOUYfM50TDllG3P
         wibJX0mAuvKZwyZva9uAhH+xVelEdr4s8k9g4vSYo3aZc7ScZ1uljrNvSJ/UGmPSkBJM
         nLdRxYVNmuLcqQKSrvfwq/OEHpLYwepBU4hOmOLwMbEnTYMkUdMAGE0MrO7as5x8pqDR
         N2mxII/INwiP32EVjmI3vVSrAYRQtI3OnRldsy9Uyn/JtR+WvtQxZnV9bKGJULp4R7ze
         YB1g==
X-Forwarded-Encrypted: i=1; AJvYcCVHGeY/wK3tbzHRNyj2Xnhep3PyjfgihZ1KcLrSKZZWvaC4/FoRFS+sloAuWrCkx/nuctU=@vger.kernel.org, AJvYcCW/BGrpvWjjislmcf+7p4UmSS92XZRrYmqn0LupecanoZyqBSi1jJF3oyM3LwdVBicJiJMlAqBm@vger.kernel.org
X-Gm-Message-State: AOJu0YwdUEPoG5l4oF0KClsysGn4s9UKL6GznyzBMunRurZEiS5H9Aia
	60NAcVRLnRxhlnlIwtxSMm4nLVA3nQef6di7kdOTBVttDIECAOg=
X-Gm-Gg: ASbGncujRiDG2C3uGRebjMUAj2e3hkHygsB3rj35iqykbMmQH5RNDpKXtFzUVIMFE73
	Bqya8AB10amYa/3DdGXDzPsnzvxwcoS5c1qgdAFNz+ElBXNit1F0Mb69qtgmYXsGzRNtEIu6Y3Z
	ieIonn7j1GQM8I8MtpJECVqmbrvl8MLSlHf1PiKj5AjzunbBRAp17zbkpucZMyItqhq43di4La9
	PVfHIWXvAmawHiic4uqG3BMCXWJ8ZJLrfmRqMZO7bLY7WsXVQ==
X-Google-Smtp-Source: AGHT+IE1xZk4cRfuKt5+QJo6nCZ0LktFfvaWl2IiS62w8FMN3W27I0sqro0CutIw4GbjT9qmtx7YbA==
X-Received: by 2002:a05:6a00:1789:b0:714:15ff:a2a4 with SMTP id d2e1a72fcca58-7257fa78c52mr377708b3a.13.1733184416402;
        Mon, 02 Dec 2024 16:06:56 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c3a0f8asm7334623a12.71.2024.12.02.16.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 16:06:55 -0800 (PST)
Date: Mon, 2 Dec 2024 16:06:55 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Shigeru Yoshida <syoshida@redhat.com>, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	hawk@kernel.org, lorenzo@kernel.org, toke@redhat.com,
	bpf@vger.kernel.org, netdev@vger.kernel.org,
	syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH bpf] bpf, test_run: Fix use-after-free issue in
 eth_skb_pkt_type()
Message-ID: <Z05Ln1XgniGiSuKu@mini-arch>
References: <20241201152735.106681-1-syoshida@redhat.com>
 <Z03dL0zxEnmzZUN7@mini-arch>
 <80d8c4cf-2897-4385-b849-2dbac863ee39@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <80d8c4cf-2897-4385-b849-2dbac863ee39@linux.dev>

On 12/02, Martin KaFai Lau wrote:
> On 12/2/24 8:15 AM, Stanislav Fomichev wrote:
> > On 12/02, Shigeru Yoshida wrote:
> > > KMSAN reported a use-after-free issue in eth_skb_pkt_type()[1]. The
> > > cause of the issue was that eth_skb_pkt_type() accessed skb's data
> > > that didn't contain an Ethernet header. This occurs when
> > > bpf_prog_test_run_xdp() passes an invalid value as the user_data
> > > argument to bpf_test_init().
> > > 
> > > Fix this by returning an error when user_data is less than ETH_HLEN in
> > > bpf_test_init().
> > > 
> > > [1]
> > > BUG: KMSAN: use-after-free in eth_skb_pkt_type include/linux/etherdevice.h:627 [inline]
> > > BUG: KMSAN: use-after-free in eth_type_trans+0x4ee/0x980 net/ethernet/eth.c:165
> > >   eth_skb_pkt_type include/linux/etherdevice.h:627 [inline]
> > >   eth_type_trans+0x4ee/0x980 net/ethernet/eth.c:165
> > >   __xdp_build_skb_from_frame+0x5a8/0xa50 net/core/xdp.c:635
> > >   xdp_recv_frames net/bpf/test_run.c:272 [inline]
> > >   xdp_test_run_batch net/bpf/test_run.c:361 [inline]
> > >   bpf_test_run_xdp_live+0x2954/0x3330 net/bpf/test_run.c:390
> > >   bpf_prog_test_run_xdp+0x148e/0x1b10 net/bpf/test_run.c:1318
> > >   bpf_prog_test_run+0x5b7/0xa30 kernel/bpf/syscall.c:4371
> > >   __sys_bpf+0x6a6/0xe20 kernel/bpf/syscall.c:5777
> > >   __do_sys_bpf kernel/bpf/syscall.c:5866 [inline]
> > >   __se_sys_bpf kernel/bpf/syscall.c:5864 [inline]
> > >   __x64_sys_bpf+0xa4/0xf0 kernel/bpf/syscall.c:5864
> > >   x64_sys_call+0x2ea0/0x3d90 arch/x86/include/generated/asm/syscalls_64.h:322
> > >   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > >   do_syscall_64+0xd9/0x1d0 arch/x86/entry/common.c:83
> > >   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > 
> > > Uninit was created at:
> > >   free_pages_prepare mm/page_alloc.c:1056 [inline]
> > >   free_unref_page+0x156/0x1320 mm/page_alloc.c:2657
> > >   __free_pages+0xa3/0x1b0 mm/page_alloc.c:4838
> > >   bpf_ringbuf_free kernel/bpf/ringbuf.c:226 [inline]
> > >   ringbuf_map_free+0xff/0x1e0 kernel/bpf/ringbuf.c:235
> > >   bpf_map_free kernel/bpf/syscall.c:838 [inline]
> > >   bpf_map_free_deferred+0x17c/0x310 kernel/bpf/syscall.c:862
> > >   process_one_work kernel/workqueue.c:3229 [inline]
> > >   process_scheduled_works+0xa2b/0x1b60 kernel/workqueue.c:3310
> > >   worker_thread+0xedf/0x1550 kernel/workqueue.c:3391
> > >   kthread+0x535/0x6b0 kernel/kthread.c:389
> > >   ret_from_fork+0x6e/0x90 arch/x86/kernel/process.c:147
> > >   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> > > 
> > > CPU: 1 UID: 0 PID: 17276 Comm: syz.1.16450 Not tainted 6.12.0-05490-g9bb88c659673 #8
> > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
> > > 
> > > Fixes: be3d72a2896c ("bpf: move user_size out of bpf_test_init")
> > > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > > Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> > > ---
> > >   net/bpf/test_run.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> > > index 501ec4249fed..756250aa890f 100644
> > > --- a/net/bpf/test_run.c
> > > +++ b/net/bpf/test_run.c
> > > @@ -663,7 +663,7 @@ static void *bpf_test_init(const union bpf_attr *kattr, u32 user_size,
> > >   	if (size < ETH_HLEN || size > PAGE_SIZE - headroom - tailroom)
> > >   		return ERR_PTR(-EINVAL);
> > > -	if (user_size > size)
> > > +	if (user_size < ETH_HLEN || user_size > size)
> > >   		return ERR_PTR(-EMSGSIZE);
> > >   	size = SKB_DATA_ALIGN(size);
> > > -- 
> > > 2.47.0
> > > 
> > 
> > I wonder whether 'size < ETH_HLEN' above is needed after your patch.
> > Feels like 'user_size < ETH_HLEN' supersedes it.
> 
> May be fixing it by replacing the existing "size" check with "user_size"
> check? Seems more intuitive that checking is needed on the "user_"size
> instead of the "size". The "if (user_size > size)" check looks useless also.
> Something like this?
> 
> -	if (size < ETH_HLEN || size > PAGE_SIZE - headroom - tailroom)
> +	if (user_size < ETH_HLEN || user_size > PAGE_SIZE - headroom - tailroom)
> 		return ERR_PTR(-EINVAL);
> 
> -	if (user_size > size)
> -		return ERR_PTR(-EMSGSIZE);
> -
> 

Agreed, that should do it. IIUC, 'user_size > size' only makes sense
for the bpf_prog_test_run_xdp case and the caller handles this case
anyway (size > max_data_sz).

