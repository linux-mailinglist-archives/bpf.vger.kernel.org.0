Return-Path: <bpf+bounces-14530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6AA7E60DC
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 00:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8844281400
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 23:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D5037158;
	Wed,  8 Nov 2023 23:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XzcAwJ5O"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237862FE3A
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 23:11:45 +0000 (UTC)
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7F72593
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 15:11:44 -0800 (PST)
Message-ID: <fcca87f3-8a92-2220-5a4a-cfa2851eac02@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699485101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R382c0XDJR7dje3E6emnn6V+72FnVb0FvYJk9VxWZBE=;
	b=XzcAwJ5Oz12bx6xspzmVTl75p+m/5hfN6+u1VZdP02NITn2EVUc/O+cVtCHKuYj2rtMPqD
	LJVeTFMwAiW/+oc5+IGheau+Nzq/V431U9bFs5XnnpRxJtpglKEDRMK02KdTPlQYJQHTiX
	cttuNWBXLXC5LpvZqXOhiFnl7X3Ww88=
Date: Wed, 8 Nov 2023 15:11:33 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 01/11] bpf: Check rcu_read_lock_trace_held() before
 calling bpf map helpers
Content-Language: en-US
To: Hou Tao <houtao@huaweicloud.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com,
 bpf@vger.kernel.org
References: <20231107140702.1891778-1-houtao@huaweicloud.com>
 <20231107140702.1891778-2-houtao@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231107140702.1891778-2-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/7/23 6:06 AM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> These three bpf_map_{lookup,update,delete}_elem() helpers are also
> available for sleepable bpf program, so add the corresponding lock
> assertion for sleepable bpf program, otherwise the following warning
> will be reported when a sleepable bpf program manipulates bpf map under
> interpreter mode (aka bpf_jit_enable=0):
> 
>    WARNING: CPU: 3 PID: 4985 at kernel/bpf/helpers.c:40 ......
>    CPU: 3 PID: 4985 Comm: test_progs Not tainted 6.6.0+ #2
>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996) ......
>    RIP: 0010:bpf_map_lookup_elem+0x54/0x60
>    ......
>    Call Trace:
>     <TASK>
>     ? __warn+0xa5/0x240
>     ? bpf_map_lookup_elem+0x54/0x60
>     ? report_bug+0x1ba/0x1f0
>     ? handle_bug+0x40/0x80
>     ? exc_invalid_op+0x18/0x50
>     ? asm_exc_invalid_op+0x1b/0x20
>     ? __pfx_bpf_map_lookup_elem+0x10/0x10
>     ? rcu_lockdep_current_cpu_online+0x65/0xb0
>     ? rcu_is_watching+0x23/0x50
>     ? bpf_map_lookup_elem+0x54/0x60
>     ? __pfx_bpf_map_lookup_elem+0x10/0x10
>     ___bpf_prog_run+0x513/0x3b70
>     __bpf_prog_run32+0x9d/0xd0
>     ? __bpf_prog_enter_sleepable_recur+0xad/0x120
>     ? __bpf_prog_enter_sleepable_recur+0x3e/0x120
>     bpf_trampoline_6442580665+0x4d/0x1000
>     __x64_sys_getpgid+0x5/0x30
>     ? do_syscall_64+0x36/0xb0
>     entry_SYSCALL_64_after_hwframe+0x6e/0x76
>     </TASK>
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>   kernel/bpf/helpers.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 56b0c1f678ee7..f43038931935e 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -32,12 +32,13 @@
>    *
>    * Different map implementations will rely on rcu in map methods
>    * lookup/update/delete, therefore eBPF programs must run under rcu lock
> - * if program is allowed to access maps, so check rcu_read_lock_held in
> - * all three functions.
> + * if program is allowed to access maps, so check rcu_read_lock_held() or
> + * rcu_read_lock_trace_held() in all three functions.
>    */
>   BPF_CALL_2(bpf_map_lookup_elem, struct bpf_map *, map, void *, key)
>   {
> -	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_bh_held());
> +	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
> +		     !rcu_read_lock_bh_held());
>   	return (unsigned long) map->ops->map_lookup_elem(map, key);
>   }
>   
> @@ -53,7 +54,8 @@ const struct bpf_func_proto bpf_map_lookup_elem_proto = {
>   BPF_CALL_4(bpf_map_update_elem, struct bpf_map *, map, void *, key,
>   	   void *, value, u64, flags)
>   {
> -	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_bh_held());
> +	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
> +		     !rcu_read_lock_bh_held());
>   	return map->ops->map_update_elem(map, key, value, flags);
>   }
>   
> @@ -70,7 +72,8 @@ const struct bpf_func_proto bpf_map_update_elem_proto = {
>   
>   BPF_CALL_2(bpf_map_delete_elem, struct bpf_map *, map, void *, key)
>   {
> -	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_bh_held());
> +	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
> +		     !rcu_read_lock_bh_held());

Should these WARN_ON_ONCE be removed from the helpers instead?

For catching error purpose, the ops->map_{lookup,update,delete}_elem are inlined 
  for the jitted case which I believe is the bpf-CI setting also. Meaning the 
above change won't help to catch error in the common normal case.

>   	return map->ops->map_delete_elem(map, key);
>   }
>   


