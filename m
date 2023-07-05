Return-Path: <bpf+bounces-4030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3D574800F
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 10:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 290D01C20B02
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 08:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85DC46B2;
	Wed,  5 Jul 2023 08:47:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768A920E8
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 08:47:11 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9516619B;
	Wed,  5 Jul 2023 01:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=P42wwHonOeNmijkop+LjqtHf8Oqrn/eB1I3wK02DieA=; b=ZWvzb7exe2CcHIHzT56b0jcyFz
	e8wMahmH3SwDVf0HI6+NBL0eqDGJVkvApPWClx6Lmo+KYpMkUZU1toKbjcRPDj5yamPAzt0qQKNCV
	quRQ6sbQYFzeZoywAixt2QQg2udhjCb59lNxPn/zL44C/BdvpT4wIMxZNxvq5wQfdcWassMTsh3dF
	hKEf6iOgzqaS4n/8Z5F9iwtVryhsisXdIhUryKMuGH4AxJ9uGOvnTU0e7Ib9n2DZmDD86jdtHGJjG
	Z5X9ECxjm4GwmPJfbwrpGOEQ+2zEFqbj2/YOsl57UmMMNoe8gYILXjuX2wGAza9Dj6tfSuIE8PPqj
	AYTAC2UQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qGyA8-000Oyo-J2; Wed, 05 Jul 2023 10:47:00 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qGyA8-00098z-11; Wed, 05 Jul 2023 10:47:00 +0200
Subject: Re: [PATCH v6 bpf-next 09/11] bpf: Support ->fill_link_info for
 perf_event
To: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, quentin@isovalent.com,
 rostedt@goodmis.org, mhiramat@kernel.org
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230628115329.248450-1-laoar.shao@gmail.com>
 <20230628115329.248450-10-laoar.shao@gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <e06b149e-2bcc-6a83-ef23-6216c7267632@iogearbox.net>
Date: Wed, 5 Jul 2023 10:46:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230628115329.248450-10-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26960/Wed Jul  5 09:29:05 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/28/23 1:53 PM, Yafang Shao wrote:
> By introducing support for ->fill_link_info to the perf_event link, users
> gain the ability to inspect it using `bpftool link show`. While the current
> approach involves accessing this information via `bpftool perf show`,
> consolidating link information for all link types in one place offers
> greater convenience. Additionally, this patch extends support to the
> generic perf event, which is not currently accommodated by
> `bpftool perf show`. While only the perf type and config are exposed to
> userspace, other attributes such as sample_period and sample_freq are
> ignored. It's important to note that if kptr_restrict is not permitted, the
> probed address will not be exposed, maintaining security measures.
> 
> A new enum bpf_perf_event_type is introduced to help the user understand
> which struct is relevant.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>   include/uapi/linux/bpf.h       |  35 ++++++++++
>   kernel/bpf/syscall.c           | 117 +++++++++++++++++++++++++++++++++
>   tools/include/uapi/linux/bpf.h |  35 ++++++++++
>   3 files changed, 187 insertions(+)

For ease of review this should be squashed with the prior one which adds
bpf_perf_link_fill_common().

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 512ba3ba2ed3..7efe51672c15 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1057,6 +1057,16 @@ enum bpf_link_type {
>   	MAX_BPF_LINK_TYPE,
>   };
>   
> +enum bpf_perf_event_type {
> +	BPF_PERF_EVENT_UNSPEC = 0,
> +	BPF_PERF_EVENT_UPROBE = 1,
> +	BPF_PERF_EVENT_URETPROBE = 2,
> +	BPF_PERF_EVENT_KPROBE = 3,
> +	BPF_PERF_EVENT_KRETPROBE = 4,
> +	BPF_PERF_EVENT_TRACEPOINT = 5,
> +	BPF_PERF_EVENT_EVENT = 6,

Why explicitly defining the values of the enum?

> +};
> +
>   /* cgroup-bpf attach flags used in BPF_PROG_ATTACH command
>    *
>    * NONE(default): No further bpf programs allowed in the subtree.
> @@ -6444,6 +6454,31 @@ struct bpf_link_info {
>   			__u32 count;
>   			__u32 flags;
>   		} kprobe_multi;
> +		struct {
> +			__u32 type; /* enum bpf_perf_event_type */
> +			__u32 :32;
> +			union {
> +				struct {
> +					__aligned_u64 file_name; /* in/out */
> +					__u32 name_len;
> +					__u32 offset;/* offset from file_name */

nit: spacing wrt comment, also same further below

> +				} uprobe; /* BPF_PERF_EVENT_UPROBE, BPF_PERF_EVENT_URETPROBE */
> +				struct {
> +					__aligned_u64 func_name; /* in/out */
> +					__u32 name_len;
> +					__u32 offset;/* offset from func_name */
> +					__u64 addr;
> +				} kprobe; /* BPF_PERF_EVENT_KPROBE, BPF_PERF_EVENT_KRETPROBE */
> +				struct {
> +					__aligned_u64 tp_name;   /* in/out */
> +					__u32 name_len;
> +				} tracepoint; /* BPF_PERF_EVENT_TRACEPOINT */
> +				struct {
> +					__u64 config;
> +					__u32 type;
> +				} event; /* BPF_PERF_EVENT_EVENT */
> +			};
> +		} perf_event;
>   	};
>   } __attribute__((aligned(8)));
>   
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 72de91beabbc..05ff0a560f1a 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3398,9 +3398,126 @@ static int bpf_perf_link_fill_common(const struct perf_event *event,
>   	return 0;
>   }
>   
> +#ifdef CONFIG_KPROBE_EVENTS
> +static int bpf_perf_link_fill_kprobe(const struct perf_event *event,
> +				     struct bpf_link_info *info)
> +{
> +	char __user *uname;
> +	u64 addr, offset;
> +	u32 ulen, type;
> +	int err;
> +
> +	uname = u64_to_user_ptr(info->perf_event.kprobe.func_name);
> +	ulen = info->perf_event.kprobe.name_len;
> +	err = bpf_perf_link_fill_common(event, uname, ulen, &offset, &addr,
> +					&type);
> +	if (err)
> +		return err;
> +	if (type == BPF_FD_TYPE_KRETPROBE)
> +		info->perf_event.type = BPF_PERF_EVENT_KRETPROBE;
> +	else
> +		info->perf_event.type = BPF_PERF_EVENT_KPROBE;
> +
> +	info->perf_event.kprobe.offset = offset;
> +	if (!kallsyms_show_value(current_cred()))
> +		addr = 0;
> +	info->perf_event.kprobe.addr = addr;
> +	return 0;
> +}
> +#endif
> +
> +#ifdef CONFIG_UPROBE_EVENTS
> +static int bpf_perf_link_fill_uprobe(const struct perf_event *event,
> +				     struct bpf_link_info *info)
> +{
> +	char __user *uname;
> +	u64 addr, offset;
> +	u32 ulen, type;
> +	int err;
> +
> +	uname = u64_to_user_ptr(info->perf_event.uprobe.file_name);
> +	ulen = info->perf_event.uprobe.name_len;
> +	err = bpf_perf_link_fill_common(event, uname, ulen, &offset, &addr,
> +					&type);
> +	if (err)
> +		return err;
> +
> +	if (type == BPF_FD_TYPE_URETPROBE)
> +		info->perf_event.type = BPF_PERF_EVENT_URETPROBE;
> +	else
> +		info->perf_event.type = BPF_PERF_EVENT_UPROBE;
> +	info->perf_event.uprobe.offset = offset;
> +	return 0;
> +}
> +#endif
> +
> +static int bpf_perf_link_fill_probe(const struct perf_event *event,
> +				    struct bpf_link_info *info)
> +{
> +#ifdef CONFIG_KPROBE_EVENTS
> +	if (event->tp_event->flags & TRACE_EVENT_FL_KPROBE)
> +		return bpf_perf_link_fill_kprobe(event, info);
> +#endif
> +#ifdef CONFIG_UPROBE_EVENTS
> +	if (event->tp_event->flags & TRACE_EVENT_FL_UPROBE)
> +		return bpf_perf_link_fill_uprobe(event, info);
> +#endif
> +	return -EOPNOTSUPP;
> +}
> +
> +static int bpf_perf_link_fill_tracepoint(const struct perf_event *event,
> +					 struct bpf_link_info *info)
> +{
> +	char __user *uname;
> +	u64 addr, offset;
> +	u32 ulen, type;
> +
> +	uname = u64_to_user_ptr(info->perf_event.tracepoint.tp_name);
> +	ulen = info->perf_event.tracepoint.name_len;
> +	info->perf_event.type = BPF_PERF_EVENT_TRACEPOINT;
> +	return bpf_perf_link_fill_common(event, uname, ulen, &offset, &addr,
> +					 &type);

Perhaps for data we don't care about in these cases, passing NULL would be
more obvious and letting bpf_perf_link_fill_common() handle NULL inputs.

> +}
> +
> +static int bpf_perf_link_fill_perf_event(const struct perf_event *event,
> +					 struct bpf_link_info *info)
> +{
> +	info->perf_event.event.type = event->attr.type;
> +	info->perf_event.event.config = event->attr.config;
> +	info->perf_event.type = BPF_PERF_EVENT_EVENT;
> +	return 0;
> +}
> +
> +static int bpf_perf_link_fill_link_info(const struct bpf_link *link,
> +					struct bpf_link_info *info)
> +{
> +	struct bpf_perf_link *perf_link;
> +	const struct perf_event *event;
> +
> +	perf_link = container_of(link, struct bpf_perf_link, link);
> +	event = perf_get_event(perf_link->perf_file);
> +	if (IS_ERR(event))
> +		return PTR_ERR(event);
> +
> +	if (!event->prog)
> +		return -EINVAL;

nit: In which situations do we run into this, would ENOENT be better error code
here given it's not an invalid arg that user passed to kernel for filling link
info.

> +	switch (event->prog->type) {
> +	case BPF_PROG_TYPE_PERF_EVENT:
> +		return bpf_perf_link_fill_perf_event(event, info);
> +	case BPF_PROG_TYPE_TRACEPOINT:
> +		return bpf_perf_link_fill_tracepoint(event, info);
> +	case BPF_PROG_TYPE_KPROBE:
> +		return bpf_perf_link_fill_probe(event, info);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
>   static const struct bpf_link_ops bpf_perf_link_lops = {
>   	.release = bpf_perf_link_release,
>   	.dealloc = bpf_perf_link_dealloc,
> +	.fill_link_info = bpf_perf_link_fill_link_info,
>   };
>   
>   static int bpf_perf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 512ba3ba2ed3..7efe51672c15 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1057,6 +1057,16 @@ enum bpf_link_type {
>   	MAX_BPF_LINK_TYPE,
>   };
>   
> +enum bpf_perf_event_type {
> +	BPF_PERF_EVENT_UNSPEC = 0,
> +	BPF_PERF_EVENT_UPROBE = 1,
> +	BPF_PERF_EVENT_URETPROBE = 2,
> +	BPF_PERF_EVENT_KPROBE = 3,
> +	BPF_PERF_EVENT_KRETPROBE = 4,
> +	BPF_PERF_EVENT_TRACEPOINT = 5,
> +	BPF_PERF_EVENT_EVENT = 6,
> +};
> +
>   /* cgroup-bpf attach flags used in BPF_PROG_ATTACH command
>    *
>    * NONE(default): No further bpf programs allowed in the subtree.
> @@ -6444,6 +6454,31 @@ struct bpf_link_info {
>   			__u32 count;
>   			__u32 flags;
>   		} kprobe_multi;
> +		struct {
> +			__u32 type; /* enum bpf_perf_event_type */
> +			__u32 :32;
> +			union {
> +				struct {
> +					__aligned_u64 file_name; /* in/out */
> +					__u32 name_len;
> +					__u32 offset;/* offset from file_name */
> +				} uprobe; /* BPF_PERF_EVENT_UPROBE, BPF_PERF_EVENT_URETPROBE */
> +				struct {
> +					__aligned_u64 func_name; /* in/out */
> +					__u32 name_len;
> +					__u32 offset;/* offset from func_name */
> +					__u64 addr;
> +				} kprobe; /* BPF_PERF_EVENT_KPROBE, BPF_PERF_EVENT_KRETPROBE */
> +				struct {
> +					__aligned_u64 tp_name;   /* in/out */
> +					__u32 name_len;
> +				} tracepoint; /* BPF_PERF_EVENT_TRACEPOINT */
> +				struct {
> +					__u64 config;
> +					__u32 type;
> +				} event; /* BPF_PERF_EVENT_EVENT */
> +			};
> +		} perf_event;
>   	};
>   } __attribute__((aligned(8)));
>   
> 


