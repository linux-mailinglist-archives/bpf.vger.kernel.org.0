Return-Path: <bpf+bounces-17004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A8F8088F0
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 14:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC1C51F21391
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 13:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E253EA9D;
	Thu,  7 Dec 2023 13:15:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C248310CF
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 05:15:23 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Vy.vyrt_1701954920;
Received: from 30.221.128.95(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0Vy.vyrt_1701954920)
          by smtp.aliyun-inc.com;
          Thu, 07 Dec 2023 21:15:21 +0800
Message-ID: <3dd9114c-599f-46b2-84b9-abcfd2dcbe33@linux.alibaba.com>
Date: Thu, 7 Dec 2023 21:15:18 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: bpf@vger.kernel.org
Cc: song@kernel.org, andrii@kernel.org, ast@kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>, xuanzhuo@linux.alibaba.com,
 dust.li@linux.alibaba.com, guwen@linux.alibaba.com,
 alibuda@linux.alibaba.com, hengqi@linux.alibaba.com
From: Philo Lu <lulie@linux.alibaba.com>
Subject: Question about bpf perfbuf/ringbuf: pinned in backend with
 overwriting
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all. I have a question when using perfbuf/ringbuf in bpf. I will 
appreciate it if you give me any advice.

Imagine a simple case: the bpf program output a log (some tcp 
statistics) to user every time a packet is received, and the user 
actively read the logs if he wants. I do not want to keep a user process 
alive, waiting for outputs of the buffer. User can read the buffer as 
need. BTW, the order does not matter.

To conclude, I hope the buffer performs like relayfs: (1) no need for 
user process to receive logs, and the user may read at any time (and no 
wakeup would be better); (2) old data can be overwritten by new ones.

Currently, it seems that perfbuf and ringbuf cannot satisfy both: (i) 
ringbuf: only satisfies (1). However, if data arrive when the buffer is 
full, the new data will be lost, until the buffer is consumed. (ii) 
perfbuf: only satisfies (2). But user cannot access the buffer after the 
process who creates it (including perf_event.rb via mmap) exits. 
Specifically, I can use BPF_F_PRESERVE_ELEMS flag to keep the 
perf_events, but I do not know how to get the buffer again in a new process.

In my opinion, this can be solved by either of the following: (a) add 
overwrite support in ringbuf (maybe a new flag for reserve), but we have 
to address synchronization between kernel and user, especially under 
variable data size, because when overwriting occurs, kernel has to 
update the consumer posi too; (b) implement map_fd_sys_lookup_elem for 
perfbuf to expose fds to user via map_lookup_elem syscall, and a 
mechanism is need to preserve perf_event->rb when process exits 
(otherwise the buffer will be freed by perf_mmap_close). I am not sure 
if they are feasible, and which is better. If not, perhaps we can 
develop another mechanism to achieve this?

