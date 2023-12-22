Return-Path: <bpf+bounces-18607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 300F181C9E5
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 13:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD431F25F37
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 12:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFC8179B3;
	Fri, 22 Dec 2023 12:25:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797991803D
	for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 12:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0Vz-mRMi_1703247922;
Received: from 30.221.128.103(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0Vz-mRMi_1703247922)
          by smtp.aliyun-inc.com;
          Fri, 22 Dec 2023 20:25:23 +0800
Message-ID: <34d790e0-d820-4d24-abe9-89c7a41879cd@linux.alibaba.com>
Date: Fri, 22 Dec 2023 20:25:22 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question about bpf perfbuf/ringbuf: pinned in backend with
 overwriting
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf@vger.kernel.org, song@kernel.org,
 andrii@kernel.org, ast@kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com,
 guwen@linux.alibaba.com, alibuda@linux.alibaba.com,
 hengqi@linux.alibaba.com, Nathan Slingerland <slinger@meta.com>,
 "rihams@meta.com" <rihams@meta.com>, Alan Maguire <alan.maguire@oracle.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
References: <3dd9114c-599f-46b2-84b9-abcfd2dcbe33@linux.alibaba.com>
 <c3c47250-2923-c376-4f5e-ddaf148bbf32@oracle.com>
 <CAEf4BzZOBdV9vxV6Gr9b5pQ8+M6tPVnHdmELWqOd5jdcL=KpiA@mail.gmail.com>
 <23691bb5-9688-4e93-a98c-1024e8a8fc62@linux.alibaba.com>
 <CAEf4BzaQv23wzgmmoSFBja7Syp3m3fRrfzWkFobQ4NNisDTEyA@mail.gmail.com>
 <qdiw6a7acgvepckv6uts5iusp74m7ud4i4lpniu3mgq6jdrs6s@mnttkagth64k>
 <20231219083851.0ec83349@gandalf.local.home>
 <cde8a134-8185-4387-a2f5-db2f1173b31b@linux.alibaba.com>
 <20231221094917.20718e9b@gandalf.local.home>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <20231221094917.20718e9b@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thank you very much for your reply, making me understand ftrace buffer 
better.

I think it feasible to implement a new type of bpf map based on ftrace 
buffer. As for user interface, perhaps representing as files is still a 
good choice (like tracefs for ftrace)? But we should make sure that each 
map use a exclusive directory.

Also, I have tried relay map and submitted the patches [0], and any 
comment is welcome. Its behavior is exactly what I describe above. The 
buffer is represented as files in debugfs (`/sys/kernel/debug/`), one 
directory for one map. Users can get data with read or mmap interfaces.

The relay interface is also designed as a sub-buffer structure. It is 
light-weighted and provides users with much flexibility to formulate and 
process the data. Meanwhile, ftrace buffer provides thorough 
consideration for various use cases, so that users just care about the 
data entry by entry. It seems that ftrace buffer could be a better 
alternative of perfbuf. Therefore, I think it possible that relay and 
ftrace buffer coexist as bpf maps.

Wish you all happy holidays :)

[0]
https://lore.kernel.org/all/20231222122146.65519-1-lulie@linux.alibaba.com/

