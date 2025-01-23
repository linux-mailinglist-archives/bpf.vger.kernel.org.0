Return-Path: <bpf+bounces-49599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DBEA1AA48
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 20:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEAA67A152E
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 19:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3CE1AA1DC;
	Thu, 23 Jan 2025 19:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJeom4x3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962E01BC4E;
	Thu, 23 Jan 2025 19:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737660043; cv=none; b=sRktpW0IIrYedhDdszYrbukMPYSjAW1WlgNRW39vsuqggs8jpwNqhPJdk75N2q4zrzvxybCtz7ZfondNTEvGo7hpOSQFZILHlbcyv3/ydT9LdJfIZsJG8lJltOQ6pSR5YQUR1crNV+OLL1eC7b5xzzVISQanOEYx+w4At1VkNJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737660043; c=relaxed/simple;
	bh=J9ZDJv3TysCorCOVylLlEakob1sm5Qd0Kax/rgGJwtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvjSfN2TMLxECpT3YoG1N7Y1Gp3syYhrhtjgUfMFW10cvJiLMYmBHIzlYZyyGs7P3XOj37W4F5+QV7gAs5aya7ooAtYgljW/lYGMUVv+vr1oI/5BTH/3AtL4aBtGQ98VOcCWgOQ4W5JkK2rksX6IFoSkQXzMPktFRJw3VDKnvPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJeom4x3; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21670dce0a7so26525915ad.1;
        Thu, 23 Jan 2025 11:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737660041; x=1738264841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K3bkcSbL22vAtmOSHMqvV5wV/9yr5XjhjBGupkH/g54=;
        b=bJeom4x3Bj1eiNazYRm1RwUBHl81mKRq9sSWuqMod+pnhMWYrkLBMzNHFdoJxkooik
         DcU6KglhrttOQCf/B8KMjC5cacP9KA9ACCWswzHOWSLSfkGN/VGuMz1LC+X9UsgKELmL
         PXORZsRbL64FsrTWtx0vCIbifJxGlC9RKMIJW27iz1ug5maY6IyDyyCZBeicI33SB5Dt
         iGLwQXGdwvoglqqeqVUgaKzz6mLI82hmA7Dd/p05qhIYyaMY6Whqyi0RnrOYEu8t54KI
         0yh0U+wpGjcSHlTNYlo5MVbgcjhiSgYBGr4I2RcGw/mRDLfkSCFdPPfxNyQ2SpAx4GxI
         1xjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737660041; x=1738264841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3bkcSbL22vAtmOSHMqvV5wV/9yr5XjhjBGupkH/g54=;
        b=QWYAzRjTwUK5bE6srEHuyTDt/sNzqW2BdjWJkXWN2Qge+6mwWCigPOaWl1O09wOGAg
         7DCOgzqgXNrlAVm5ZibTiM6bh6KHWCWRwmYE19mraCBsA2OzOKE9K6cPCtoVaKN41zYm
         ebRH4S2PHHE50bcKyKJ2VvnLXfDnt6luI4xsjpHMf6HKOl+vIVeMj58pqWk4o5GGuNmm
         sqeqlE/mDQve9p06IIdRdvUGYT/o/4RdZ8jLxPFnKwEgE5MBt+P+bd62d0rnpuciMP/+
         ZBcYwnJSacnb6ZMw5Th/c/snQMRokvJomVy2RIIbDSJERt7PZzb6vKwYtmYzL+81mK7n
         hMug==
X-Forwarded-Encrypted: i=1; AJvYcCV9JE1lk4Z0iUsdmj03F3R+PxvEtUhFTsg3KRZkky61pl75AamD4eusW+R5sFENNR+J40GTzLNH@vger.kernel.org, AJvYcCX/FUaDN9uiTc3qQfgebSDzFKpehYmfFuxjc1ROfRG2Vk6Wc+NeodDmSLvDjoyTgBJ3AEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDzIJhoEYJR8mZ26WPQthxy3apa4DrFM77ReK4AvsnULULbyzv
	CDrI5DrySle0JQhgIRKL1Gy+1IciiruwHtwTH5/O8QDDK1I8NBw=
X-Gm-Gg: ASbGncukJL9xPTB4pEzCVF2U98JEcEis4bzMDpYHLCu4k9jVlRKyDfNYSvGPBc5TXcT
	8lLHDYH3XNKM0UduICDSiJS1tiWNxqhf+5B1xkkrNGg3wUHgcjevs/UP4CUNnkd3ATB6vJNzi14
	EELeUUFmB8p/SBTEiVzML/IIvdzsKBh2tMX1VPCpqrV7z00nRXKWi6EITo3STCMI29Gx98lG3yR
	tNIQDUPyA5GTzNk/XWg1ibw+ryVH4Ov+zkXaMDZov62O6yq5JKt+xItbS9Jg8GTU1lDCsMJXt9l
	+9q6L2YknX/yktM4Ojaa1s/HpGJTyJnOgSDnwcI=
X-Google-Smtp-Source: AGHT+IGfHHVtqaWb5QfrQ+qrsCPrIM27urFzeMzlSNAIuyuuE5fQcRYhUpKjGr7kYgvH9CBAhfQmcg==
X-Received: by 2002:a05:6a21:6d96:b0:1e1:a434:2964 with SMTP id adf61e73a8af0-1eb2147d404mr40393710637.2.1737660040735;
        Thu, 23 Jan 2025 11:20:40 -0800 (PST)
Received: from localhost (c-174-160-0-128.hsd1.ca.comcast.net. [174.160.0.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a760b1bsm300020b3a.95.2025.01.23.11.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 11:20:40 -0800 (PST)
Date: Thu, 23 Jan 2025 11:20:39 -0800
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
Subject: Re: [PATCH bpf v2 1/2] bpf, test_run: Fix use-after-free issue in
 eth_skb_pkt_type()
Message-ID: <Z5KWh8u4bmPxA4Ot@mini-arch>
References: <20250121150643.671650-1-syoshida@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250121150643.671650-1-syoshida@redhat.com>

On 01/22, Shigeru Yoshida wrote:
> KMSAN reported a use-after-free issue in eth_skb_pkt_type()[1]. The
> cause of the issue was that eth_skb_pkt_type() accessed skb's data
> that didn't contain an Ethernet header. This occurs when
> bpf_prog_test_run_xdp() passes an invalid value as the user_data
> argument to bpf_test_init().
> 
> Fix this by returning an error when user_data is less than ETH_HLEN in
> bpf_test_init(). Additionally, remove the check for "if (user_size >
> size)" as it is unnecessary.
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
> Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

