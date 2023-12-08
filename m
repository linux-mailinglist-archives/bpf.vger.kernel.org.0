Return-Path: <bpf+bounces-17099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3BB809A87
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 04:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F30F1C20CE1
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 03:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAE93C2B;
	Fri,  8 Dec 2023 03:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IQUkbecT"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [IPv6:2001:41d0:203:375::b9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724EC10DF
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 19:36:14 -0800 (PST)
Message-ID: <6ea56936-1aca-4bcc-9a63-c61f8bcfabb9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702006571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wd0h1N8Mc7Vs6+y5DuBj15yiJfniqx26blgIvU0VS20=;
	b=IQUkbecTV8mDWmazpiYxIGUAWeD0c1Lloy8rvnELHoq4Fj2nXCrdLZwf48aJ7ahbxCjBdC
	bBYACs0JReek0podbiIB9bElF6fs/epE+zAkKazguti/dIevHCjh7fFORA96qFI8HRYP1C
	sP7mJ5QCp8mFxlT/HOlSPKQ2JpFrlSs=
Date: Thu, 7 Dec 2023 19:36:04 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/1] bpf: Mark virtual BPF context structures as
 preserve_static_offset
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, jose.marchesi@oracle.com
References: <20231208000531.19179-1-eddyz87@gmail.com>
 <20231208000531.19179-2-eddyz87@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231208000531.19179-2-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 12/7/23 4:05 PM, Eduard Zingerman wrote:
> Add __attribute__((preserve_static_offset)) for the following BPF
> related structures:
> - __sk_buff
> - bpf_cgroup_dev_ctx
> - bpf_perf_event_data
> - bpf_sk_lookup
> - bpf_sock
> - bpf_sock_addr
> - bpf_sock_ops
> - bpf_sockopt
> - bpf_sysctl
> - sk_msg_md
> - sk_reuseport_md
> - xdp_md
>
> Access to these structures is rewritten by BPF verifier.
> (See verifier.c:convert_ctx_access).
> The rewrite requires that offsets used in access to fields of these
> structures are constant values. __attribute__((preserve_static_offset))
> is a hint to clang that ensures that constant offsets are used.
> (See https://reviews.llvm.org/D133361 for details).
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>   include/uapi/linux/bpf.h                  | 28 ++++++++++++++---------
>   include/uapi/linux/bpf_perf_event.h       |  8 ++++++-
>   tools/include/uapi/linux/bpf.h            | 28 ++++++++++++++---------
>   tools/include/uapi/linux/bpf_perf_event.h |  8 ++++++-
>   4 files changed, 48 insertions(+), 24 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index e0545201b55f..75eee56ed732 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -69,6 +69,12 @@ enum {
>   /* BPF has 10 general purpose 64-bit registers and stack frame. */
>   #define MAX_BPF_REG	__MAX_BPF_REG
>   
> +#if __has_attribute(preserve_static_offset) && defined(__bpf__)
> +#define __bpf_ctx __attribute__((preserve_static_offset))
> +#else
> +#define __bpf_ctx
> +#endif
> +
>   struct bpf_insn {
>   	__u8	code;		/* opcode */
>   	__u8	dst_reg:4;	/* dest register */
> @@ -6190,7 +6196,7 @@ struct __sk_buff {
>   	__u8  tstamp_type;
>   	__u32 :24;		/* Padding, future use. */
>   	__u64 hwtstamp;
> -};
> +} __bpf_ctx;
>   
>   struct bpf_tunnel_key {
>   	__u32 tunnel_id;
> @@ -6271,7 +6277,7 @@ struct bpf_sock {
>   	__u32 dst_ip6[4];
>   	__u32 state;
>   	__s32 rx_queue_mapping;
> -};
> +} __bpf_ctx;
>   
>   struct bpf_tcp_sock {
>   	__u32 snd_cwnd;		/* Sending congestion window		*/
> @@ -6379,7 +6385,7 @@ struct xdp_md {
>   	__u32 rx_queue_index;  /* rxq->queue_index  */
>   
>   	__u32 egress_ifindex;  /* txq->dev->ifindex */
> -};
> +} __bpf_ctx;
>   
>   /* DEVMAP map-value layout
>    *
> @@ -6429,7 +6435,7 @@ struct sk_msg_md {
>   	__u32 size;		/* Total size of sk_msg */
>   
>   	__bpf_md_ptr(struct bpf_sock *, sk); /* current socket */
> -};
> +} __bpf_ctx;
>   
>   struct sk_reuseport_md {
>   	/*
> @@ -6468,7 +6474,7 @@ struct sk_reuseport_md {
>   	 */
>   	__bpf_md_ptr(struct bpf_sock *, sk);
>   	__bpf_md_ptr(struct bpf_sock *, migrating_sk);
> -};
> +} __bpf_ctx;
>   
>   #define BPF_TAG_SIZE	8
>   
> @@ -6678,7 +6684,7 @@ struct bpf_sock_addr {
>   				 * Stored in network byte order.
>   				 */
>   	__bpf_md_ptr(struct bpf_sock *, sk);
> -};
> +} __bpf_ctx;
>   
>   /* User bpf_sock_ops struct to access socket values and specify request ops
>    * and their replies.
> @@ -6761,7 +6767,7 @@ struct bpf_sock_ops {
>   				 * been written yet.
>   				 */
>   	__u64 skb_hwtstamp;
> -};
> +} __bpf_ctx;
>   
>   /* Definitions for bpf_sock_ops_cb_flags */
>   enum {
> @@ -7034,7 +7040,7 @@ struct bpf_cgroup_dev_ctx {
>   	__u32 access_type;
>   	__u32 major;
>   	__u32 minor;
> -};
> +} __bpf_ctx;
>   
>   struct bpf_raw_tracepoint_args {
>   	__u64 args[0];
> @@ -7245,7 +7251,7 @@ struct bpf_sysctl {
>   	__u32	file_pos;	/* Sysctl file position to read from, write to.
>   				 * Allows 1,2,4-byte read an 4-byte write.
>   				 */
> -};
> +} __bpf_ctx;
>   
>   struct bpf_sockopt {
>   	__bpf_md_ptr(struct bpf_sock *, sk);
> @@ -7256,7 +7262,7 @@ struct bpf_sockopt {
>   	__s32	optname;
>   	__s32	optlen;
>   	__s32	retval;
> -};
> +} __bpf_ctx;
>   
>   struct bpf_pidns_info {
>   	__u32 pid;
> @@ -7280,7 +7286,7 @@ struct bpf_sk_lookup {
>   	__u32 local_ip6[4];	/* Network byte order */
>   	__u32 local_port;	/* Host byte order */
>   	__u32 ingress_ifindex;		/* The arriving interface. Determined by inet_iif. */
> -};
> +} __bpf_ctx;

should we undef __bpf_ctx at the end of the file?
The same for below bpf_perf_event.h file.

>   
>   /*
>    * struct btf_ptr is used for typed pointer representation; the
> diff --git a/include/uapi/linux/bpf_perf_event.h b/include/uapi/linux/bpf_perf_event.h
> index eb1b9d21250c..cf614ddf0381 100644
> --- a/include/uapi/linux/bpf_perf_event.h
> +++ b/include/uapi/linux/bpf_perf_event.h
> @@ -10,10 +10,16 @@
>   
>   #include <asm/bpf_perf_event.h>
>   
> +#if __has_attribute(preserve_static_offset) && defined(__bpf__)
> +#define __bpf_ctx __attribute__((preserve_static_offset))
> +#else
> +#define __bpf_ctx
> +#endif
> +
>   struct bpf_perf_event_data {
>   	bpf_user_pt_regs_t regs;
>   	__u64 sample_period;
>   	__u64 addr;
> -};
> +} __bpf_ctx;
>   
>   #endif /* _UAPI__LINUX_BPF_PERF_EVENT_H__ */
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index e0545201b55f..75eee56ed732 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h

[...]


