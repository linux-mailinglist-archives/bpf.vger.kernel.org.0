Return-Path: <bpf+bounces-49313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5A1A175A6
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 02:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E80887A2593
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 01:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE65F56B81;
	Tue, 21 Jan 2025 01:26:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC72A2581;
	Tue, 21 Jan 2025 01:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737422812; cv=none; b=IIZFDueD3iFNYrl3YJdjN3Lj/JqxmHxCKgMMwBt6DEsD25tik6wxfyOTykgY5oERCDXg0MMi7FQnszEN1H6lwme9WwffVKS7uXS34yr48B5rehBWsrekRrOeSmry4UDWwO9o/xeDZ0ZIiQJKMzYtQtfU28SG2NGZI8HERrOzVHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737422812; c=relaxed/simple;
	bh=Nx4jccfRDswWRZSfbDtQKeQF5DlQKprL7SnQJjpQIIo=;
	h=Subject:To:References:From:Cc:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Ld49loJxeh0CI5Ol0xEccroyc4Bube4b+iE7aMbC9d0iDDXXMkg2UTdd+EtLyUi0/FMKMXdmYcgESuTp3knDShhdBn+NcNWOMf+uY3mP+ZbvuB9W+BkoymtEM5/Yht4KuJlNxbcY5kPSV0zOfggzEjn27IvWLu27CEbPGDftOpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YcV0Z49mTz4f3kvM;
	Tue, 21 Jan 2025 09:26:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 689C01A0ABB;
	Tue, 21 Jan 2025 09:26:44 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgC3GnvO945npYIVBg--.26251S2;
	Tue, 21 Jan 2025 09:26:42 +0800 (CST)
Subject: Re: [PATCH bpf] bpf: trace: send signals asynchronously if
 !preemptible
To: Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 bpf@vger.kernel.org
References: <20250115103647.38487-1-puranjay@kernel.org>
From: Hou Tao <houtao@huaweicloud.com>
Cc: Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 puranjay12@gmail.com
Message-ID: <94fcfa71-51c1-2130-3452-ec58aaef94d0@huaweicloud.com>
Date: Tue, 21 Jan 2025 09:26:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250115103647.38487-1-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgC3GnvO945npYIVBg--.26251S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KryUKFWDtrWUZrWfXF1UWrg_yoW8XF17pF
	ZxXrZ2krWkXFsYqa1Uta4xWryUW398J3yxGFnxJFWfXrnrZwn5Wrn29r45XF1Fvry5C397
	XFs2vrWYqw4xu37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUxo7KDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 1/15/2025 6:36 PM, Puranjay Mohan wrote:
> BPF programs can execute in all kinds of contexts and when a program
> running in a non-preemptible context uses the bpf_send_signal() kfunc,
> it will cause issues because this kfunc can sleep.
>
> So change `irqs_disabled()` to `!preemptible()` that covers all edge
> cases: preempt_count() == 0 and irqs_disabled()
>
> Reported-by: syzbot+97da3d7e0112d59971de@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/67486b09.050a0220.253251.0084.GAE@google.com/
> Fixes: 1bc7896e9ef4 ("bpf: Fix deadlock with rq_lock in bpf_send_signal()")
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/trace/bpf_trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 1b8db5aee9d3..d162c87e09a8 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -853,7 +853,7 @@ static int bpf_send_signal_common(u32 sig, enum pid_type type, struct task_struc
>  	if (unlikely(is_global_init(task)))
>  		return -EPERM;
>  
> -	if (irqs_disabled()) {
> +	if (!preemptible()) {

Should we unfold preemptible() to "preempt_count() == 0 &&
!irqs_disabled()" instead, because when preemption is disabled,
preemptible() will evaluate as 0 and the irq_disabled() case will be
skipped ?


>  		/* Do an early check on signal validity. Otherwise,
>  		 * the error is lost in deferred irq_work.
>  		 */


