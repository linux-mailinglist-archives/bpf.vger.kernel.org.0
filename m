Return-Path: <bpf+bounces-45941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A2F9E0C08
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 20:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E7F9B67398
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 16:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889B917A5A4;
	Mon,  2 Dec 2024 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEXQ+8al"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EACA175D29;
	Mon,  2 Dec 2024 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733156148; cv=none; b=QeyVRebC1luZPMbbIz/PISYy1snKoz/55LGNKeqgk0r7zcvMlBFuFMayIjnR8agRctarYxtKK86ijww2oTtE5iw7heOL6f8lYf/oFwu8fvaElRtEbDxWbgkNJ17UWOjPEoOEtAzwOuldUHVIDo8uAuIMhTo8BQSFY8+NaQ4tUno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733156148; c=relaxed/simple;
	bh=vKH/VyHGs5Vu3c6cGYEA/Eqhr391RwOu84Z53Nh4V3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPG92GKII652+oMDrc78buJnv21Qgrcjyt4W62y3NCsijaJSZUsw2u2fasyqDupPIWpFoka0YZdljv1elasYT73bYRMC7agI0UDJbaVubiujtyIg0KhhB+xs1rUK8tI1KQqmtb4VL0BjQw2iYyXqn/zXvOzxiHjJ0HX5VEj7Z7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEXQ+8al; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7250906bc63so3285598b3a.1;
        Mon, 02 Dec 2024 08:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733156146; x=1733760946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eW/wfnh8N5no52Gp+owhRKuizaBDFaei5Sky6tMENBs=;
        b=jEXQ+8alsh6XT1yZJ5IOADOyZKZdlMS7RCyaZb7zT1ErA0FXiORUgOyOBcOxu42mIz
         rQWJ+rPbGBzzqfDa3HMVPp25No1IZf0QTqYTlHs0MR0E5IWKnEuqjaoyGekEBmRvxPEt
         nMSsThsFmscn+dMYF1PHddaW6G+yde7Z+ZUNFglwaifJ2fpNmSCxsjFgwyck/atrgkob
         Bz1FsAqrYIymjeMFrhpMsy1zwRfZwC2oEIG3XoR0jQrzFK/JXCJMe6PUie37hbl86wxX
         bLpBv+SC20mqjzOxvJNG1r3c1jriIXmkLbMNXtRojitpheKix9yXqG9nDooC92hFSyEN
         0PMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733156146; x=1733760946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eW/wfnh8N5no52Gp+owhRKuizaBDFaei5Sky6tMENBs=;
        b=XjAbc5ilsOvvy9NE1XRO5liz37Hwl3sWJHxw4ijcnSPVon/k7pTeaLzel9IW66pPkk
         R7HCBvE4kGTpxn+DSG4HA8ASnFbm+Mnb/igetCtZgsuZSEHtDsbeSfu4bz1w25SdXfIE
         WumdiePeODgtmNL8U8sILY4IKlstYcAJm1fPv4lfdDOwSP22wbGYsTXuhrRrWiyI++H+
         RprBWnw5GPJvC0DeoSiUJjYBBBkbK8Ok3Y1XQw7dyK54c9A4zIw1tS7AmN2G73OAon3Q
         2wbTVpzSG16R+/FF4kBM9mCV+ivd6mVyAsc/8YXhhdxZS4qTjgZkwEmWXepxc22a5CmV
         9EjA==
X-Forwarded-Encrypted: i=1; AJvYcCXNcqHzpprLZWLHXLnzaqD7ZPAHffN3Gj2zYagub7/R/ZTZY5xlQhejABBGy6uKXJ5KUQ0=@vger.kernel.org, AJvYcCXz4Z/Qsu3vpTJ5hnGQy8ZUPBBwaHjf7niKqnsoTYPKFCG7btndlwPz/k4SLlLYU7I7OovnnYbQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyuA2d+uqeyUuMRn8234BumAuxp++Y/zw5pM/GlVwNLdP0MyylP
	DXh1ptqYuGIDDjfcCHm60KYu36m25yZvddiOq6Tjh+mWLFqk1Ms=
X-Gm-Gg: ASbGncvOVMwT/ekfCAPOQHW6JOXPY0J1aOVfuFgmJDLMa8Kcu2avVnevsBry9/KdQ3d
	g8g0vFRvh38Wxz982Yb+nhgd3ysQKK2dcIFxSbotRcG6GKdTFlfnRYj6rUHwyzJ9DKix+jHTyZh
	WZGLQsG2ASKTmkNXBr1OpSvAbcAm2aeFfcCjeT0Ja4EtIdZkeNhMPDKl3E4+XzQnRu/sTdA31dx
	9rjXlMvrIiUC45FWmxZ7mNBbkgJngOkzpxGgENHZZ2yIJDS2g==
X-Google-Smtp-Source: AGHT+IHdKZ4DjXfo0tLnEtHRICNhBAhY92uoAXU97x9uWgtkTFfPImHj4pxzZtATdJeGIfa2kd0P3A==
X-Received: by 2002:a05:6a00:22cf:b0:725:37a4:8827 with SMTP id d2e1a72fcca58-7253f2df712mr31237136b3a.3.1733156145693;
        Mon, 02 Dec 2024 08:15:45 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541762411sm8970776b3a.20.2024.12.02.08.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 08:15:45 -0800 (PST)
Date: Mon, 2 Dec 2024 08:15:43 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	hawk@kernel.org, lorenzo@kernel.org, toke@redhat.com,
	bpf@vger.kernel.org, netdev@vger.kernel.org,
	syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH bpf] bpf, test_run: Fix use-after-free issue in
 eth_skb_pkt_type()
Message-ID: <Z03dL0zxEnmzZUN7@mini-arch>
References: <20241201152735.106681-1-syoshida@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241201152735.106681-1-syoshida@redhat.com>

On 12/02, Shigeru Yoshida wrote:
> KMSAN reported a use-after-free issue in eth_skb_pkt_type()[1]. The
> cause of the issue was that eth_skb_pkt_type() accessed skb's data
> that didn't contain an Ethernet header. This occurs when
> bpf_prog_test_run_xdp() passes an invalid value as the user_data
> argument to bpf_test_init().
> 
> Fix this by returning an error when user_data is less than ETH_HLEN in
> bpf_test_init().
> 
> [1]
> BUG: KMSAN: use-after-free in eth_skb_pkt_type include/linux/etherdevice.h:627 [inline]
> BUG: KMSAN: use-after-free in eth_type_trans+0x4ee/0x980 net/ethernet/eth.c:165
>  eth_skb_pkt_type include/linux/etherdevice.h:627 [inline]
>  eth_type_trans+0x4ee/0x980 net/ethernet/eth.c:165
>  __xdp_build_skb_from_frame+0x5a8/0xa50 net/core/xdp.c:635
>  xdp_recv_frames net/bpf/test_run.c:272 [inline]
>  xdp_test_run_batch net/bpf/test_run.c:361 [inline]
>  bpf_test_run_xdp_live+0x2954/0x3330 net/bpf/test_run.c:390
>  bpf_prog_test_run_xdp+0x148e/0x1b10 net/bpf/test_run.c:1318
>  bpf_prog_test_run+0x5b7/0xa30 kernel/bpf/syscall.c:4371
>  __sys_bpf+0x6a6/0xe20 kernel/bpf/syscall.c:5777
>  __do_sys_bpf kernel/bpf/syscall.c:5866 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5864 [inline]
>  __x64_sys_bpf+0xa4/0xf0 kernel/bpf/syscall.c:5864
>  x64_sys_call+0x2ea0/0x3d90 arch/x86/include/generated/asm/syscalls_64.h:322
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xd9/0x1d0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Uninit was created at:
>  free_pages_prepare mm/page_alloc.c:1056 [inline]
>  free_unref_page+0x156/0x1320 mm/page_alloc.c:2657
>  __free_pages+0xa3/0x1b0 mm/page_alloc.c:4838
>  bpf_ringbuf_free kernel/bpf/ringbuf.c:226 [inline]
>  ringbuf_map_free+0xff/0x1e0 kernel/bpf/ringbuf.c:235
>  bpf_map_free kernel/bpf/syscall.c:838 [inline]
>  bpf_map_free_deferred+0x17c/0x310 kernel/bpf/syscall.c:862
>  process_one_work kernel/workqueue.c:3229 [inline]
>  process_scheduled_works+0xa2b/0x1b60 kernel/workqueue.c:3310
>  worker_thread+0xedf/0x1550 kernel/workqueue.c:3391
>  kthread+0x535/0x6b0 kernel/kthread.c:389
>  ret_from_fork+0x6e/0x90 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> CPU: 1 UID: 0 PID: 17276 Comm: syz.1.16450 Not tainted 6.12.0-05490-g9bb88c659673 #8
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
> 
> Fixes: be3d72a2896c ("bpf: move user_size out of bpf_test_init")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
>  net/bpf/test_run.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 501ec4249fed..756250aa890f 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -663,7 +663,7 @@ static void *bpf_test_init(const union bpf_attr *kattr, u32 user_size,
>  	if (size < ETH_HLEN || size > PAGE_SIZE - headroom - tailroom)
>  		return ERR_PTR(-EINVAL);
>  
> -	if (user_size > size)
> +	if (user_size < ETH_HLEN || user_size > size)
>  		return ERR_PTR(-EMSGSIZE);
>  
>  	size = SKB_DATA_ALIGN(size);
> -- 
> 2.47.0
> 

I wonder whether 'size < ETH_HLEN' above is needed after your patch.
Feels like 'user_size < ETH_HLEN' supersedes it.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

