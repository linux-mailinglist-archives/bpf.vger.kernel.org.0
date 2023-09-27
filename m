Return-Path: <bpf+bounces-10918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A69B7AFA23
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 07:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 268351C20959
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 05:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DF51429A;
	Wed, 27 Sep 2023 05:32:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E734115CF
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 05:32:47 +0000 (UTC)
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910731F16
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 22:32:44 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-7ab9f1efecfso2900793241.3
        for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 22:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci-edu.20230601.gappssmtp.com; s=20230601; t=1695792763; x=1696397563; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VNpdlwxDq0MADrmcUjQipE21akByQsXpYdgRgyiCtXI=;
        b=HYUeCKGihCtVNASP9YkkmXDWzpoP9cF8xacL1viTc3pobTJXGeSGxenKCUw9CpdLhD
         JAAuNdm0fiJbBTP4SyjefGBGwu9p8SKrXCcBYxoLdFwV5ZRP5SABbwph0qJSiwDZZf9J
         oI7/zyhbXPFuV97aLNTxk7rikYqU04il5Zx7sgOCUriaS4QIo65k5rCfnEP3Hdpm5Do0
         S2NVeaBvIbsA0jF0JTcB/w80M164GlhmkB1Zk7o13y0h8n82hg/ElLHtGG3DvQhqevJa
         uxa6cLE9zF+TeBB2D4ArfAbRlHqlywjPzNB6Q4Q7iJZRhDugSNgO2PhbLw2CNqN962RR
         oj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695792763; x=1696397563;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VNpdlwxDq0MADrmcUjQipE21akByQsXpYdgRgyiCtXI=;
        b=i2QxjRkSqHiqYQUzxYO8dCdHdQ8VqfE2M+xoYVTl1F95ymNCZjcSDxZdOItkrOk0TH
         rwNfZgsqr4F0ZDbRCecMlH2xtibq5UcAXWg63q5JFaTqTDxL/k09bodyQg9Tq+ub5JO2
         9KNTOwE0pVSOJbSdZMcreAzzvGgip41kYGUVwxUV7ag/KhOBbAVvped3sdqzK4nOtdxk
         L+ZyLcYRzL9ivc8cVRPPik4abkA//Pe7CBH/Qie71Zmrt/cNqmNCOW51ARgnpXxYYiDD
         UYPXxl39wDH25lZ5o/U7Zi0q3MPDbcBNE5LfdQi3lRg9wHXlG0XXE3RdgL/zhbinlHot
         +1kA==
X-Gm-Message-State: AOJu0YxzDO+jTFkS/xtAS30ZupiIlpGGDYBhh0AT+F5QjQj7FhOBbrSk
	ohaQ8/dypLxGFkpgk7ZMd+PZ7if0XZes4xhkTsw6Sg==
X-Google-Smtp-Source: AGHT+IHp+OV+deroVNewqaJpLo2I1PI7MiF5N3n1R9zYhw0xH2iYsGie2bdAShVuDbs6pKbbOQ7ZyBp6UNbUgD3M954=
X-Received: by 2002:a05:6102:91:b0:452:658b:295e with SMTP id
 t17-20020a056102009100b00452658b295emr1015410vsp.12.1695792763190; Tue, 26
 Sep 2023 22:32:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hsin-Wei Hung <hsinweih@uci.edu>
Date: Tue, 26 Sep 2023 22:32:07 -0700
Message-ID: <CABcoxUaT2k9hWsS1tNgXyoU3E-=PuOgMn737qK984fbFmfYixQ@mail.gmail.com>
Subject: Possible kernel memory leak in bpf_timer
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

We found a potential memory leak in bpf_timer in v5.15.26 using a
customized syzkaller for fuzzing bpf runtime. It can happen when
an arraymap is being released. An entry that has been checked by
bpf_timer_cancel_and_free() can again be initialized by bpf_timer_init().
Since both paths are almost identical between v5.15 and net-next,
I suspect this problem still exists. Below are kmemleak report and
some additional printks I inserted.

[ 1364.081694] array_map_free_timers map:0xffffc900005a9000
[ 1364.081730] ____bpf_timer_init map:0xffffc900005a9000
timer:0xffff888001ab4080

*no bpf_timer_cancel_and_free that will kfree struct bpf_hrtimer*
at 0xffff888001ab4080 is called

[ 1383.907869] kmemleak: 1 new suspected memory leaks (see
/sys/kernel/debug/kmemleak)
BUG: memory leak
unreferenced object 0xffff888001ab4080 (size 96):
  comm "sshd", pid 279, jiffies 4295233126 (age 29.952s)
  hex dump (first 32 bytes):
    80 40 ab 01 80 88 ff ff 00 00 00 00 00 00 00 00  .@..............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000009d018da0>] bpf_map_kmalloc_node+0x89/0x1a0
    [<00000000ebcb33fc>] bpf_timer_init+0x177/0x320
    [<00000000fb7e90bf>] 0xffffffffc02a0358
    [<000000000c89ec4f>] __cgroup_bpf_run_filter_skb+0xcbf/0x1110
    [<00000000fd663fc0>] ip_finish_output+0x13d/0x1f0
    [<00000000acb3205c>] ip_output+0x19b/0x310
    [<000000006b584375>] __ip_queue_xmit+0x182e/0x1ed0
    [<00000000b921b07e>] __tcp_transmit_skb+0x2b65/0x37f0
    [<0000000026104b23>] tcp_write_xmit+0xf19/0x6290
    [<000000006dc71bc5>] __tcp_push_pending_frames+0xaf/0x390
    [<00000000251b364a>] tcp_push+0x452/0x6d0
    [<000000008522b7d3>] tcp_sendmsg_locked+0x2567/0x3030
    [<0000000038c644d2>] tcp_sendmsg+0x30/0x50
    [<000000009fe3413f>] inet_sendmsg+0xba/0x140
    [<0000000034d78039>] sock_sendmsg+0x13d/0x190
    [<00000000f55b8db6>] sock_write_iter+0x296/0x3d0


Thanks,
Hsin-Wei (Amery)

