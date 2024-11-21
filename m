Return-Path: <bpf+bounces-45325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1179D4750
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 06:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F118E1F2266B
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 05:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DB3156256;
	Thu, 21 Nov 2024 05:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0rP1bd/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851B12309B6
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 05:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732167832; cv=none; b=lja5XYJDZNvLGGigzDBA385NF3D7SN71zmIegA/iEALCirl7vGe5/mPbN20RX1Z39LhfOiD8qH8IvVVaMd4A8Oh0hUPiqSJd2jwMHA1otr50i6NsllM3G3yQeBjNSxcMHmquZ7CzxOKIHUVTwS5NOCmEYk0HaVkDKyHWVQFO+7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732167832; c=relaxed/simple;
	bh=T75h3BvDSgwJ8XVAh2ilAk600kme7OzyKA3IgvNqcFU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=sHDrc48oeN5vwVRf4lfSvrnkUOTLipbdcyZnVu1Ec6FkEw7mPB4pR+c9UaPRUjKTOuP1vyeI0V3HMONJFa0ccaRic7lXQgIbVDbQ8qlg2IZWrRvqU6XFuPqavT87cmILqwT/F2pzXAN9XYgNr/W5NnmG54F6rcQ1wWTPhAgjxGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0rP1bd/; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21278f3d547so3678925ad.1
        for <bpf@vger.kernel.org>; Wed, 20 Nov 2024 21:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732167830; x=1732772630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qn27QLU6VuuGfAVIFNRICVEozADVeDK8Vi6CHmlxZX0=;
        b=l0rP1bd/XlTjWo0GKt1nVCGZjG45XhhUmvzz3+XRdvgSFhn3zYl6KM9+X90VzEYJ4C
         690/t4khfj5MsHc2BAKonSA4icYjdzwzFG+gTpuCclDsJhY+x4N/cnM6XFgGU+VAZwwi
         wiDsOxtxL6HbQAOKSiID8Y1OSCKB6D9A9nYGBm5ADaZBFbtCsxGfRx4SGo1XYYv+iHV3
         MNSqKX+IcM7CbWmjBphd/PR2u6OKIwnPSvKlveMA3p+otMz6LnC46o6I/s/LihIAQ9by
         X/YjYF9Ihc+KqUOVCHbRoMYDMrP0xUo88gEOuLDkLAhC16xpYnxb8wvBDibZC+zzyPZn
         AhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732167830; x=1732772630;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qn27QLU6VuuGfAVIFNRICVEozADVeDK8Vi6CHmlxZX0=;
        b=p8k4uBBE9snE59JtP7msv76ESpJi5Xen0WIsmAGW3fklolAZIB/RvB6t/7RjCYhhwK
         WM36G4JyYXlxaSDVib9LNmN2Z4cSNEal47GFxdCbTUfRMdiL1IUJVQ62EfMe0brO897u
         dR7U9Z3zcL1FZ/OaW//O+HxXHvL4IjmhKaF3pvpZCrUlucO6EYPAEdbCKgPHgQu13+nR
         Enprjw2JNwll22V8JypyWk92jcitNELjAD2IGdqOialFLH20wgaPJZ5J+DkOohpD3nhj
         WEDD19eB0lVVeUOwN4MKCZyibfN+Wh+ropnfMjNDBPVbR10fqnpVAmgL7h9s43MOrHfU
         WFTg==
X-Forwarded-Encrypted: i=1; AJvYcCUsjwkMg6vNTmz7ugkRV51c+l5rLWuQxvILam1hePOrnpa1PsqBBhGJ1td1FkwfrJi2EQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeZhCl7Mr9yjXb8jD5BRdIo5/k4qp/PKeF/O8Mr5UIZQuoTS2G
	tRggnt63etn5hdf36J8lLUCN1qFLvhUByqY/1ojKhKqTpTEzRyLv
X-Gm-Gg: ASbGnctWat+5z2RaQrhVwDCE4xZR580ETgx7uyl3jSmu3koxUxq5MjbO8HM4ggP4geS
	2kJdpjcTDaHm7hQt84TEJNzwqs8TQgsKi/jhckNT4y4uDi5Z8PNEOWAfB2FaKxdUjHksulq95v4
	o2soe6/479aY1jxxiqLdhw0e6IremBsdfKCuP54C2Gg5fcH8tTYiV42J/i6h9pUjhF3hL0rp8qP
	8HEq01Y0wv1xK10WbcKwtTzuxiRMGrdE2wU2N8vNFTlm7K9MOc=
X-Google-Smtp-Source: AGHT+IHbJpdWe7Q+YMrYENl6yVLz9l38Z6DaFUDs6pXHous4rrrEUIRcz4K6XC4Fqzmw8cI/nHDGdg==
X-Received: by 2002:a17:902:f681:b0:212:12a2:4007 with SMTP id d9443c01a7336-2126a3dadf5mr74820065ad.34.1732167829692;
        Wed, 20 Nov 2024 21:43:49 -0800 (PST)
Received: from localhost ([98.97.39.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2128788cceasm5183415ad.52.2024.11.20.21.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 21:43:48 -0800 (PST)
Date: Wed, 20 Nov 2024 21:43:48 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: zijianzhang@bytedance.com, 
 bpf@vger.kernel.org
Cc: edumazet@google.com, 
 john.fastabend@gmail.com, 
 jakub@cloudflare.com, 
 davem@davemloft.net, 
 dsahern@kernel.org, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 mykolal@fb.com, 
 shuah@kernel.org, 
 wangyufen@huawei.com, 
 xiyou.wangcong@gmail.com, 
 zijianzhang@bytedance.com
Message-ID: <673ec8941b96d_157a20829@john.notmuch>
In-Reply-To: <20241016234838.3167769-3-zijianzhang@bytedance.com>
References: <20241016234838.3167769-1-zijianzhang@bytedance.com>
 <20241016234838.3167769-3-zijianzhang@bytedance.com>
Subject: RE: [PATCH bpf 2/2] tcp_bpf: Fix the sk_mem_uncharge logic in
 tcp_bpf_sendmsg
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
> The current sk memory accounting logic in __SK_REDIRECT is pre-uncharging
> tosend bytes, which is either msg->sg.size or a smaller value apply_bytes.
> Potential problems with this strategy are as follows:
> - If the actual sent bytes are smaller than tosend, we need to charge some
> bytes back, as in line 487, which is okay but seems not clean.
> - When tosend is set to apply_bytes, as in line 417, and (ret < 0), we may
> miss uncharging (msg->sg.size - apply_bytes) bytes.
> 
> 415 tosend = msg->sg.size;
> 416 if (psock->apply_bytes && psock->apply_bytes < tosend)
> 417   tosend = psock->apply_bytes;
> ...
> 443 sk_msg_return(sk, msg, tosend);
> 444 release_sock(sk);
> 446 origsize = msg->sg.size;
> 447 ret = tcp_bpf_sendmsg_redir(sk_redir, redir_ingress,
> 448                             msg, tosend, flags);
> 449 sent = origsize - msg->sg.size;
> ...
> 454 lock_sock(sk);
> 455 if (unlikely(ret < 0)) {
> 456   int free = sk_msg_free_nocharge(sk, msg);
> 458   if (!cork)
> 459     *copied -= free;
> 460 }
> ...
> 487 if (eval == __SK_REDIRECT)
> 488   sk_mem_charge(sk, tosend - sent);
> 
> When running the selftest test_txmsg_redir_wait_sndmem with txmsg_apply,
> the following warning will be reported,
> ------------[ cut here ]------------
> WARNING: CPU: 6 PID: 57 at net/ipv4/af_inet.c:156 inet_sock_destruct+0x190/0x1a0
> Modules linked in:
> CPU: 6 UID: 0 PID: 57 Comm: kworker/6:0 Not tainted 6.12.0-rc1.bm.1-amd64+ #43
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> Workqueue: events sk_psock_destroy
> RIP: 0010:inet_sock_destruct+0x190/0x1a0
> RSP: 0018:ffffad0a8021fe08 EFLAGS: 00010206
> RAX: 0000000000000011 RBX: ffff9aab4475b900 RCX: ffff9aab481a0800
> RDX: 0000000000000303 RSI: 0000000000000011 RDI: ffff9aab4475b900
> RBP: ffff9aab4475b990 R08: 0000000000000000 R09: ffff9aab40050ec0
> R10: 0000000000000000 R11: ffff9aae6fdb1d01 R12: ffff9aab49c60400
> R13: ffff9aab49c60598 R14: ffff9aab49c60598 R15: dead000000000100
> FS:  0000000000000000(0000) GS:ffff9aae6fd80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffec7e47bd8 CR3: 00000001a1a1c004 CR4: 0000000000770ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
> <TASK>
> ? __warn+0x89/0x130
> ? inet_sock_destruct+0x190/0x1a0
> ? report_bug+0xfc/0x1e0
> ? handle_bug+0x5c/0xa0
> ? exc_invalid_op+0x17/0x70
> ? asm_exc_invalid_op+0x1a/0x20
> ? inet_sock_destruct+0x190/0x1a0
> __sk_destruct+0x25/0x220
> sk_psock_destroy+0x2b2/0x310
> process_scheduled_works+0xa3/0x3e0
> worker_thread+0x117/0x240
> ? __pfx_worker_thread+0x10/0x10
> kthread+0xcf/0x100
> ? __pfx_kthread+0x10/0x10
> ret_from_fork+0x31/0x40
> ? __pfx_kthread+0x10/0x10
> ret_from_fork_asm+0x1a/0x30
> </TASK>
> ---[ end trace 0000000000000000 ]---
> 
> In __SK_REDIRECT, a more concise way is delaying the uncharging after sent
> bytes are finalized, and uncharge this value. When (ret < 0), we shall
> invoke sk_msg_free.
> 
> Same thing happens in case __SK_DROP, when tosend is set to apply_bytes,
> we may miss uncharging (msg->sg.size - apply_bytes) bytes. The same
> warning will be reported in selftest.
> 
> 468 case __SK_DROP:
> 469 default:
> 470 sk_msg_free_partial(sk, msg, tosend);
> 471 sk_msg_apply_bytes(psock, tosend);
> 472 *copied -= (tosend + delta);
> 473 return -EACCES;
> 
> So instead of sk_msg_free_partial we can do sk_msg_free here.
> 
> Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
> Fixes: 8ec95b94716a ("bpf, sockmap: Fix the sk->sk_forward_alloc warning of sk_stream_kill_queues")
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> ---

Agree thanks.

Acked-by: John Fastabend <john.fastabend@gmail.com>

