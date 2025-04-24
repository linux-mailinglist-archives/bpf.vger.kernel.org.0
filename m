Return-Path: <bpf+bounces-56566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BACA99D14
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 02:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BE255A5C60
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 00:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09E51BC3C;
	Thu, 24 Apr 2025 00:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDIfHpCM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F9F1CD1F;
	Thu, 24 Apr 2025 00:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745455248; cv=none; b=BibqhrXVswa/v86pvbl/tX2pLzYXbrm1UxQUPpj6zgrenL5+vhwrjeGmpK8RIT59RgN+J5IL23zRBDinj9Ny1MXTfgHUNFDysE19yv1ZzdeI3cmLRfkEgA41N4sCQv/+mLNJ6dVNekVn3Xi3knL5r9uXLIIMhj/EiSaMgVmGLAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745455248; c=relaxed/simple;
	bh=t9r+BKbLzQR963A7of64wreoQ9Wz+pGE+SkT/2nF8jA=;
	h=Date:From:To:Cc:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=btWh2luCxWvu1y/7vUCFd+1ptvCYnFtMFQqtAg33QcOwKkHuhfoczE1uHuaXgco8J7/yDux9uGK3uWuslidgwBLjzhX6OOkuo1Kk7aVeMTljyZUMY9litmAel7zrpys4QMHvCPRjddYaiWhYu/hccZYj7UDSSomQ0UGf6F7THU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDIfHpCM; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-af589091049so251844a12.1;
        Wed, 23 Apr 2025 17:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745455245; x=1746060045; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SLOaPFL8XjxqhGOEemNflsE1lEuAslNpnkEp7HRmcEs=;
        b=kDIfHpCMspNHrzOumpLTUy7+kwyxrJdr2BfP2PBmdiXE4sndy51+ZbsDi0I1CKSka0
         plYcFGKK8QCQ7CbQd5H1RE7xpgY+NK605fW2FuQa3PuJU9hLS+YOe5ZWU73gPy+cmyUn
         b5FdZ+x+sCxhq17VvFuy5aia2a4tFYrKFXtxvs/KfTR+tqjkn/QSqXKCNoRtuhZew5zG
         32vtMa/5hnyFIZJGpb9YvJLrEIy1PZWKw9wZeBYSz4PC8ob24RJG9TELge3+OgcnB6zi
         s+vxrU5cpNjWYkIJOQU2pJKjo+AjCXh+VGURHfZ9h3W+RTFgXce3TRNjkgAbPupfPqKU
         2ynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745455245; x=1746060045;
        h=content-disposition:mime-version:message-id:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SLOaPFL8XjxqhGOEemNflsE1lEuAslNpnkEp7HRmcEs=;
        b=hKepM7HuZXKbLOMmLkKclKABMyyfPNJH+8hn9iI4C+ahF8zKSWAICbync//b9O/nwH
         4fEpIZh8p0+QIZco50UkykctluhQGGueaLAkJeyT2V0AJ65kXPYEA3JP0WzakY24+hci
         CpAbvwtwUtMVCkUVeQv7QxW5uBvIgjaxlbrGbWOmylE+ExETpsXK874o/fR8pCZ/9q4J
         F6+UOfM5dCvwXhG5eYFjqsP+gKvR4HxKfPInnoFLADSsCXZd+RYkQxwxoD/hB7zDQ+W9
         TCksSHDgtqfwO9KPKU7XBjjI06jrQ6jBMr2cHqPXlSn9AoGYjbrzsBnmGeanBfhwfk+s
         Z7mA==
X-Forwarded-Encrypted: i=1; AJvYcCVHHVpa5sKrqCsBmIjYk4CIQ/Zv7FYl2zkoYBGsrETG22OuLTxNBzHG5hdrpa7fIz6Z7Pc=@vger.kernel.org, AJvYcCVOUy894i61ACFkaejfDjWYBC1FAbVRBsuXoS7zv9hh609c87k3SzbvZlM3Oj7fV0RSp4P/gt1t@vger.kernel.org
X-Gm-Message-State: AOJu0YyW1hN6aTYWTvEc8WewX3BiQdJqClO/nRWggXpqWfoC2azuDUdb
	9h/HvcVKMzu+l3eO/SyVZ+fJumdabo6KDp0A68TjeuO2eRbahubO
X-Gm-Gg: ASbGncuD/CP5LkAzzDbcZAdSIfII6jBvOw/suHCN3H4MYaXA7QPrUQTuJwpTMGRXbgj
	d8R/DF0a3aSKrRCgtH5EKt7GrGPjRqA8fzRsvljbTauMCxEY0LTe8Woll4ukzJw37NkhRIzIm1o
	NENuvBBFZq3agJexQ3RcJPFxl3brXLqlZM02SXKsfkTOxwSelQafjqjYgTxH6nQRaadbtmz9kDY
	hFk/gU1JhenEUf+xUcYICL+Pg4BP58Arc9c/9E6XI9DCRpy3m6YpV4BETiRvkty05RnJ3QwRmNb
	iRk/ngvZlrSOoBF68dzOIDqGO9gj61Wt7v36uSTQrJ4P
X-Google-Smtp-Source: AGHT+IH3f6ZJya3mmIHyzV4YUmhRJvWAOjWwO6SA1BAMoWdxn0dnF+6sEHH5X3aFTJH90zuB+zhgdA==
X-Received: by 2002:a17:90b:17d1:b0:2ff:6ac2:c5a6 with SMTP id 98e67ed59e1d1-309ed36e3e8mr967210a91.31.1745455245019;
        Wed, 23 Apr 2025 17:40:45 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ee799aa3sm96277a91.9.2025.04.23.17.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 17:40:44 -0700 (PDT)
Date: Wed, 23 Apr 2025 17:40:43 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: jiayuan.chen@linux.dev
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Message-ID: <aAmIi0vlycHtbXeb@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

netdev@vger.kernel.org, bpf@vger.kernel.org
Bcc: 
Subject: test_sockmap failures on the latest bpf-next
Reply-To: 

Hi all,

The latest bpf-next failed on test_sockmap tests, I got the following
failures (including 1 kernel warning). It is 100% reproducible here.

I don't have time to look into them, a quick glance at the changelog
shows quite some changes from Jiayuan. So please take a look, Jiayuan.

Meanwhile, please let me know if you need more information from me.

Thanks!

--------------->

[root@localhost bpf]# ./test_sockmap 
# 1/ 6  sockmap::txmsg test passthrough:OK
# 2/ 6  sockmap::txmsg test redirect:OK
# 3/ 2  sockmap::txmsg test redirect wait send mem:OK
# 4/ 6  sockmap::txmsg test drop:OK
[  182.498017] perf: interrupt took too long (3406 > 3238), lowering kernel.perf_event_max_sample_rate to 58500
# 5/ 6  sockmap::txmsg test ingress redirect:OK
# 6/ 7  sockmap::txmsg test skb:OK
# 7/12  sockmap::txmsg test apply:OK
# 8/12  sockmap::txmsg test cork:OK
# 9/ 3  sockmap::txmsg test hanging corks:OK
#10/11  sockmap::txmsg test push_data:OK
#11/17  sockmap::txmsg test pull-data:OK
#12/ 9  sockmap::txmsg test pop-data:OK
#13/ 6  sockmap::txmsg test push/pop data:OK
#14/ 1  sockmap::txmsg test ingress parser:OK
#15/ 1  sockmap::txmsg test ingress parser2:OK
#16/ 6 sockhash::txmsg test passthrough:OK
#17/ 6 sockhash::txmsg test redirect:OK
#18/ 2 sockhash::txmsg test redirect wait send mem:OK
#19/ 6 sockhash::txmsg test drop:OK
#20/ 6 sockhash::txmsg test ingress redirect:OK
#21/ 7 sockhash::txmsg test skb:OK
#22/12 sockhash::txmsg test apply:OK
#23/12 sockhash::txmsg test cork:OK
#24/ 3 sockhash::txmsg test hanging corks:OK
#25/11 sockhash::txmsg test push_data:OK
#26/17 sockhash::txmsg test pull-data:OK
#27/ 9 sockhash::txmsg test pop-data:OK
#28/ 6 sockhash::txmsg test push/pop data:OK
#29/ 1 sockhash::txmsg test ingress parser:OK
#30/ 1 sockhash::txmsg test ingress parser2:OK
#31/ 6 sockhash:ktls:txmsg test passthrough:OK
#32/ 6 sockhash:ktls:txmsg test redirect:OK
#33/ 2 sockhash:ktls:txmsg test redirect wait send mem:OK
[  263.509707] ------------[ cut here ]------------
[  263.510439] WARNING: CPU: 1 PID: 40 at net/ipv4/af_inet.c:156 inet_sock_destruct+0x173/0x1d5
[  263.511450] CPU: 1 UID: 0 PID: 40 Comm: kworker/1:1 Tainted: G        W           6.15.0-rc3+ #238 PREEMPT(voluntary) 
[  263.512683] Tainted: [W]=WARN
[  263.513062] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
[  263.514763] Workqueue: events sk_psock_destroy
[  263.515332] RIP: 0010:inet_sock_destruct+0x173/0x1d5
[  263.515916] Code: e8 dc dc 3f ff 41 83 bc 24 c0 02 00 00 00 74 02 0f 0b 49 8d bc 24 ac 02 00 00 e8 c2 dc 3f ff 41 83 bc 24 ac 02 00 00 00 74 02 <0f> 0b e8 c7 95 3d 00 49 8d bc 24 b0 05 00 00 e8 c0 dd 3f ff 49 8b
[  263.518899] RSP: 0018:ffff8880085cfc18 EFLAGS: 00010202
[  263.519596] RAX: 1ffff11003dbfc00 RBX: ffff88801edfe3e8 RCX: ffffffff822f5af4
[  263.520502] RDX: 0000000000000007 RSI: dffffc0000000000 RDI: ffff88801edfe16c
[  263.522128] RBP: ffff88801edfe184 R08: ffffed1003dbfc31 R09: 0000000000000000
[  263.523008] R10: ffffffff822f5ab7 R11: ffff88801edfe187 R12: ffff88801edfdec0
[  263.523822] R13: ffff888020376ac0 R14: ffff888020376ac0 R15: ffff888020376a60
[  263.524682] FS:  0000000000000000(0000) GS:ffff8880b0e88000(0000) knlGS:0000000000000000
[  263.525999] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  263.526765] CR2: 0000556365155830 CR3: 000000001d6aa000 CR4: 0000000000350ef0
[  263.527700] Call Trace:
[  263.528037]  <TASK>
[  263.528339]  __sk_destruct+0x46/0x222
[  263.528856]  sk_psock_destroy+0x22f/0x242
[  263.529471]  process_one_work+0x504/0x8a8
[  263.530029]  ? process_one_work+0x39d/0x8a8
[  263.530587]  ? __pfx_process_one_work+0x10/0x10
[  263.531195]  ? worker_thread+0x44/0x2ae
[  263.531721]  ? __list_add_valid_or_report+0x83/0xea
[  263.532395]  ? srso_return_thunk+0x5/0x5f
[  263.532929]  ? __list_add+0x45/0x52
[  263.533482]  process_scheduled_works+0x73/0x82
[  263.534079]  worker_thread+0x1ce/0x2ae
[  263.534582]  ? _raw_spin_unlock_irqrestore+0x2e/0x44
[  263.535243]  ? __pfx_worker_thread+0x10/0x10
[  263.535822]  kthread+0x32a/0x33c
[  263.536278]  ? kthread+0x13c/0x33c
[  263.536724]  ? __pfx_kthread+0x10/0x10
[  263.537225]  ? srso_return_thunk+0x5/0x5f
[  263.537869]  ? find_held_lock+0x2b/0x75
[  263.538388]  ? __pfx_kthread+0x10/0x10
[  263.538866]  ? srso_return_thunk+0x5/0x5f
[  263.539523]  ? local_clock_noinstr+0x32/0x9c
[  263.540128]  ? srso_return_thunk+0x5/0x5f
[  263.540677]  ? srso_return_thunk+0x5/0x5f
[  263.541228]  ? __lock_release+0xd3/0x1ad
[  263.541890]  ? srso_return_thunk+0x5/0x5f
[  263.542442]  ? tracer_hardirqs_on+0x17/0x149
[  263.543047]  ? _raw_spin_unlock_irq+0x24/0x39
[  263.543589]  ? __pfx_kthread+0x10/0x10
[  263.544069]  ? __pfx_kthread+0x10/0x10
[  263.544543]  ret_from_fork+0x21/0x41
[  263.545000]  ? __pfx_kthread+0x10/0x10
[  263.545557]  ret_from_fork_asm+0x1a/0x30
[  263.546095]  </TASK>
[  263.546374] irq event stamp: 1094079
[  263.546798] hardirqs last  enabled at (1094089): [<ffffffff813be0f6>] __up_console_sem+0x47/0x4e
[  263.547762] hardirqs last disabled at (1094098): [<ffffffff813be0d6>] __up_console_sem+0x27/0x4e
[  263.548817] softirqs last  enabled at (1093692): [<ffffffff812f2906>] handle_softirqs+0x48c/0x4de
[  263.550127] softirqs last disabled at (1094117): [<ffffffff812f29b3>] __irq_exit_rcu+0x4b/0xc3
[  263.551104] ---[ end trace 0000000000000000 ]---
#34/ 6 sockhash:ktls:txmsg test drop:OK
#35/ 6 sockhash:ktls:txmsg test ingress redirect:OK
#36/ 7 sockhash:ktls:txmsg test skb:OK
#37/12 sockhash:ktls:txmsg test apply:OK
[  278.915147] perf: interrupt took too long (4331 > 4257), lowering kernel.perf_event_max_sample_rate to 46000
[  282.974989] test_sockmap (1077) used greatest stack depth: 25072 bytes left
#38/12 sockhash:ktls:txmsg test cork:OK
#39/ 3 sockhash:ktls:txmsg test hanging corks:OK
#40/11 sockhash:ktls:txmsg test push_data:OK
#41/17 sockhash:ktls:txmsg test pull-data:OK
recv failed(): Invalid argument
rx thread exited with err 1.
recv failed(): Invalid argument
rx thread exited with err 1.
recv failed(): Bad message
rx thread exited with err 1.
#42/ 9 sockhash:ktls:txmsg test pop-data:FAIL
recv failed(): Bad message
rx thread exited with err 1.
recv failed(): Message too long
rx thread exited with err 1.
#43/ 6 sockhash:ktls:txmsg test push/pop data:FAIL
#44/ 1 sockhash:ktls:txmsg test ingress parser:OK
#45/ 0 sockhash:ktls:txmsg test ingress parser2:OK
Pass: 43 Fail: 5



