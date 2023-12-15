Return-Path: <bpf+bounces-18050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0A28153BA
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 23:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9514287421
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 22:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFB9D266;
	Fri, 15 Dec 2023 22:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="auwRW8vf"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2362B13B120
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 22:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=g0wYx3/xM2TZ/nXqp823en+/RVdFuLUiNMUkzmRmKeM=; b=auwRW8vfZvnbznwppsVqf781Nv
	g3WpMwa+4uHAfG6bdbnGY4E2GzauOKngYSovCcRQz1ML4CXJX0+tLITUXliAojG4wnisNfb2kelcQ
	oKWD/pH0D0tj2Syy2xNqF814c2Bw35wUWtXRpRW71Tj8hK+kzuVSM4Nk4K5bPLgeX7PIfEh0F+FS3
	ElpW3J0Yn8gXrk5eXgaoC4/z4iK4pwKGgiWSFgBscZDhnBZBH3wH/TE0o3T+yLlSw935z+fL86Gm5
	c0/JDmHT3n6wVEaMkT5li5xcZ/23w458mG5OR8QHqWaVoixg22dMZDC8G5VbvY4hvYIm0CPRNzP5W
	pq+m04AQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rEGXZ-0006XE-78; Fri, 15 Dec 2023 23:20:17 +0100
Received: from [178.197.248.25] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rEGXY-0005eg-GZ; Fri, 15 Dec 2023 23:20:16 +0100
Subject: Re: [PATCH bpf-next v3] bpf: Include pid, uid and comm in audit
 output
To: Dave Tucker <dave@dtucker.co.uk>, bpf@vger.kernel.org
Cc: Dave Tucker <datucker@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Yafang Shao <laoar.shao@gmail.com>
References: <3636f52d-f343-45e5-88c6-3c7e28e87a45@linux.dev>
 <20231215174639.1034164-1-dave@dtucker.co.uk>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <96e41142-1c86-f7ab-67dc-47e6d9da362b@iogearbox.net>
Date: Fri, 15 Dec 2023 23:20:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231215174639.1034164-1-dave@dtucker.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27124/Fri Dec 15 10:58:28 2023)

On 12/15/23 6:46 PM, Dave Tucker wrote:
> Current output from auditd is as follows:
> 
> time->Wed Dec 13 21:39:24 2023
> type=BPF msg=audit(1702503564.519:11241): prog-id=439 op=LOAD
> 
> This only tells you that a BPF program was loaded, but without
> any context. If we include the prog-name, pid, uid and comm we get
> output as follows:
> 
> time->Wed Dec 13 21:59:59 2023
> type=BPF msg=audit(1702504799.156:99528): op=UNLOAD prog-id=50092
> 	prog-name="test" pid=27279 uid=0 comm="new_name"
> 
> With pid, uid a system administrator has much better context
> over which processes and user loaded which eBPF programs.
> comm is useful since processes may be short-lived.
> 
> Signed-off-by: Dave Tucker <dave@dtucker.co.uk>
> ---
> 
> Changes:
> 
> v2->v3:
>    - Revert replacing in_irq() with in_hardirq()
>    - Revert removal of in_irq() check from bpf_audit_prog since it may
>      also be called in the sofirq or nmi contexts
> 
> v1->v2:
>    - Move 'op' to the front of the audit messages
>    - Add 'prog-name' to the audit messages
>    - Replace deprecated in_irq() with in_hardirq()
>    - Remove in_irq() check from bpf_audit_prog since it's always called
>      from the task context
>    - Only populate pid, uid and comm if not in a kthread
> 

Aside from what Alexei mentioned, looking back at commit bae141f54be83
("bpf: Emit audit messages upon successful prog load and unload"), don't
you already have this information at hand? Quote from commit msg:

Raw example output:

       # auditctl -D
       # auditctl -a always,exit -F arch=x86_64 -S bpf
       # ausearch --start recent -m 1334
       ...
       ----
       time->Wed Nov 27 16:04:13 2019
       type=PROCTITLE msg=audit(1574867053.120:84664): proctitle="./bpf"
       type=SYSCALL msg=audit(1574867053.120:84664): arch=c000003e syscall=321   \
         success=yes exit=3 a0=5 a1=7ffea484fbe0 a2=70 a3=0 items=0 ppid=7477    \
         pid=12698 auid=1001 uid=1001 gid=1001 euid=1001 suid=1001 fsuid=1001    \
         egid=1001 sgid=1001 fsgid=1001 tty=pts2 ses=4 comm="bpf"                \
         exe="/home/jolsa/auditd/audit-testsuite/tests/bpf/bpf"                  \
         subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
       type=UNKNOWN[1334] msg=audit(1574867053.120:84664): prog-id=76 op=LOAD
       ----
       time->Wed Nov 27 16:04:13 2019
       type=UNKNOWN[1334] msg=audit(1574867053.120:84665): prog-id=76 op=UNLOAD
       ...

Thanks,
Daniel

