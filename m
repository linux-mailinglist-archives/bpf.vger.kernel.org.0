Return-Path: <bpf+bounces-18003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26835814BB1
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 16:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59C621C2292B
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 15:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC123381C8;
	Fri, 15 Dec 2023 15:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bvIHdT5F"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCEA36AE7
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 15:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <db4e55b7-83e1-4ec8-b10d-cfc9be3771c7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702653891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uFkzUy/8KAC7BziKdr5V07XPjDHNiFHryyXhDHjtZyE=;
	b=bvIHdT5F4OMKQ8eiSuHjTCxzmyc7YkcfMNUYpn4f2nwIxJRPvxUmPd6KuobbStO4tma4qc
	hofrmaGJ58ygTu3NOC/b31NOoIc3/kUFylC/B4Tt/5+gsbv+w1HDnCbMFgpW3YVuvwIpvP
	wV+RYzYfGL+g/QSSs5LHKoyKfNpxF6k=
Date: Fri, 15 Dec 2023 07:24:44 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/1] bpf: Include pid, uid and comm in audit
 output
Content-Language: en-GB
To: Dave Tucker <dave@dtucker.co.uk>, bpf@vger.kernel.org
Cc: Dave Tucker <datucker@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Yafang Shao <laoar.shao@gmail.com>
References: <CAADnVQJi1mezWL6BKn=Vw4quev3pgLOW9q3Yz9GF=LjzZoHp6g@mail.gmail.com>
 <20231215143836.993858-1-dave@dtucker.co.uk>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231215143836.993858-1-dave@dtucker.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 12/15/23 6:38 AM, Dave Tucker wrote:
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
> v1->v2:
>    - Move 'op' to the front of the audit messages
>    - Add 'prog-name' to the audit messages
>    - Replace deprecated in_irq() with in_hardirq()
>    - Remove in_irq() check from bpf_audit_prog since it's always called
>      from the task context

Is this true? For condition '(in_hardirq() || irqs_disabled())
', the context will be the task context. But what about nmi and
softirq? The context maynot be the task context, right?

Not sure whether this is relevant or not. There was a discussion
in the past about the above condition. See
   https://lore.kernel.org/bpf/a93079f2-fcd4-e3ef-3b92-92d443b8e8c6@meta.com/

The recommended change was

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c index 
a75c54b6f8a3..11df562e481b 100644 --- a/kernel/bpf/syscall.c +++ 
b/kernel/bpf/syscall.c @@ -2147,7 +2147,7 @@ static void 
__bpf_prog_put(struct bpf_prog *prog)           struct bpf_prog_aux *aux = prog->aux;

          if (atomic64_dec_and_test(&aux->refcnt)) {
- if (in_irq() || irqs_disabled()) { + if (!in_interrupt()) {                           INIT_WORK(&aux->work, bpf_prog_put_deferred);
                          schedule_work(&aux->work);
                  } else {

If the above change was true, then audit will not be able to
get any meaning task specific information, you might need to
gather such informaiton before hand.


>    - Only populate pid, uid and comm if not in a kthread
>
>   kernel/bpf/syscall.c | 27 ++++++++++++++++++++++-----
>   1 file changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 06320d9abf33..fbbaf3b8ad48 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -35,6 +35,7 @@
>   #include <linux/rcupdate_trace.h>
>   #include <linux/memcontrol.h>
>   #include <linux/trace_events.h>
> +#include <linux/uidgid.h>
>   
>   #include <net/netfilter/nf_bpf_link.h>
>   #include <net/netkit.h>
> @@ -2110,18 +2111,34 @@ static void bpf_audit_prog(const struct bpf_prog *prog, unsigned int op)
>   {
>   	struct audit_context *ctx = NULL;
>   	struct audit_buffer *ab;
> +	const struct cred *cred;
> +	char comm[sizeof(current->comm)];
>   
>   	if (WARN_ON_ONCE(op >= BPF_AUDIT_MAX))
>   		return;
>   	if (audit_enabled == AUDIT_OFF)
>   		return;
> -	if (!in_irq() && !irqs_disabled())
> -		ctx = audit_context();
> +
> +	ctx = audit_context();
>   	ab = audit_log_start(ctx, GFP_ATOMIC, AUDIT_BPF);
>   	if (unlikely(!ab))
>   		return;
> -	audit_log_format(ab, "prog-id=%u op=%s",
> -			 prog->aux->id, bpf_audit_str[op]);
> +
> +	audit_log_format(ab, "op=%s prog-id=%u",
> +			 bpf_audit_str[op], prog->aux->id);
> +	audit_log_format(ab, " prog-name=");
> +	audit_log_untrustedstring(ab, prog->aux->name ?: "(none)");
> +
> +	if (current->mm) {
> +		cred = current_cred();
> +		audit_log_format(ab, " pid=%u uid=%u",
> +				 task_pid_nr(current),
> +				 from_kuid(&init_user_ns, cred->uid));
> +		audit_log_format(ab, " comm=");
> +		audit_log_untrustedstring(ab, get_task_comm(comm, current));
> +	} else {
> +		audit_log_format(ab, " pid=? uid=? comm=?");
> +	}
>   	audit_log_end(ab);
>   }
>   
> @@ -2212,7 +2229,7 @@ static void __bpf_prog_put(struct bpf_prog *prog)
>   	struct bpf_prog_aux *aux = prog->aux;
>   
>   	if (atomic64_dec_and_test(&aux->refcnt)) {
> -		if (in_irq() || irqs_disabled()) {
> +		if (in_hardirq() || irqs_disabled()) {
>   			INIT_WORK(&aux->work, bpf_prog_put_deferred);
>   			schedule_work(&aux->work);
>   		} else {

