Return-Path: <bpf+bounces-4062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA081748688
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 16:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80B14281058
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 14:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F6311193;
	Wed,  5 Jul 2023 14:39:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712C23233;
	Wed,  5 Jul 2023 14:39:44 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7A9113;
	Wed,  5 Jul 2023 07:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=a3Rf4+roGcyzICjP/y+mzVOY5fi2qEb4QAdDmwYjSrY=; b=aX26S1+S9ndT/vzQo02Vq2zdDI
	I4us3iH1FQtMqBOG3NELuDdA0BgZ09qftjKvCJGWMrEA9O3B9EXoue6iuiLiUVTGDLaGqWfu2/O4P
	V5UrbWTffRe0hcrmWUaXEVBesPRuoUmNpSkFqfcymn3vdLfhLzl0KdjbBwW5GqQde8U5EdAQ5mocw
	gs7C2U3udmVDnzsnVcPsF/0Ku4yB5ZAIsPl+GHDYHJc/luD8Fefdbz+LXLr/0hzWm0n315ly9CNwt
	S3u8GDF3jlGxuFYXKwBKuU2fP1DLWXBztGs/ABsJ7btY7lA+Kg/v7RFWMVV/1wtOF5tjGHGdnC78T
	a37xe0Sw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qH3fD-000Db4-9D; Wed, 05 Jul 2023 16:39:27 +0200
Received: from [178.197.249.31] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qH3fC-000GRN-EA; Wed, 05 Jul 2023 16:39:26 +0200
Subject: Re: [PATCH bpf-next] bpf: Introduce bpf generic log
To: Leon Hwang <hffilwlqm@gmail.com>, ast@kernel.org
Cc: john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, hawk@kernel.org,
 tangyeechou@gmail.com, kernel-patches-bot@fb.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20230705132058.46194-1-hffilwlqm@gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <1a205a85-ebf2-6d90-468d-4fd63ce3dd0f@iogearbox.net>
Date: Wed, 5 Jul 2023 16:39:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230705132058.46194-1-hffilwlqm@gmail.com>
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

On 7/5/23 3:20 PM, Leon Hwang wrote:
> Currently, excluding verifier, users are unable to obtain detailed error
> information when issues occur in BPF syscall.
> 
> To overcome this limitation, bpf generic log is introduced to provide
> error details similar to the verifier. This enhancement will enable the
> reporting of error details along with the corresponding errno in BPF
> syscall.
> 
> Essentially, bpf generic log functions as a mechanism similar to netlink,
> enabling the transmission of error messages to user space. This
> mechanism greatly enhances the usability of BPF syscall by allowing
> users to access comprehensive error messages instead of relying solely
> on errno.
> 
> This patch specifically addresses the error reporting in dev_xdp_attach()
> . With this patch, the error messages will be transferred to user space
> like the netlink approach. Hence, users will be able to check the error
> message along with the errno.
> 
> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
> ---
>   include/linux/bpf.h            | 30 ++++++++++++++++++++++++++++++
>   include/uapi/linux/bpf.h       |  6 ++++++
>   kernel/bpf/log.c               | 33 +++++++++++++++++++++++++++++++++
>   net/core/dev.c                 | 11 ++++++++++-
>   tools/include/uapi/linux/bpf.h |  6 ++++++
>   5 files changed, 85 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index f58895830..fd63f4a76 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3077,4 +3077,34 @@ static inline gfp_t bpf_memcg_flags(gfp_t flags)
>   	return flags;
>   }
>   
> +#define BPF_GENERIC_TMP_LOG_SIZE	256
> +
> +struct bpf_generic_log {
> +	char		kbuf[BPF_GENERIC_TMP_LOG_SIZE];
> +	char __user	*ubuf;
> +	u32		len_used;
> +	u32		len_total;
> +};
> +
> +__printf(2, 3) void bpf_generic_log_write(struct bpf_generic_log *log,
> +			const char *fmt, ...);
> +static inline void bpf_generic_log_init(struct bpf_generic_log *log,
> +			const struct bpf_generic_user_log *ulog)
> +{
> +	log->ubuf = (char __user *) (unsigned long) ulog->log_buf;
> +	log->len_total = ulog->log_size;
> +	log->len_used = 0;
> +}
> +
> +#define BPF_GENERIC_LOG_WRITE(log, ulog, fmt, ...)	do {	\
> +	const char *____fmt = (fmt);				\
> +	bpf_generic_log_init(log, ulog);			\
> +	bpf_generic_log_write(log, ____fmt, ##__VA_ARGS__);	\
> +} while (0)
> +
> +#define BPF_GENERIC_ULOG_WRITE(ulog, fmt, ...)	do {			\
> +	struct bpf_generic_log ____log;					\
> +	BPF_GENERIC_LOG_WRITE(&____log, ulog, fmt, ##__VA_ARGS__);	\
> +} while (0)
> +

Could we generalize the bpf_verifier_log infra and reuse bpf_log() helper
instead of adding something new?

>   #endif /* _LINUX_BPF_H */
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 60a9d59be..34fa33493 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1318,6 +1318,11 @@ struct bpf_stack_build_id {
>   	};
>   };
>   
> +struct bpf_generic_user_log {
> +	__aligned_u64	log_buf;    /* user supplied buffer */
> +	__u32		log_size;   /* size of user buffer */
> +};
> +
>   #define BPF_OBJ_NAME_LEN 16U
>   
>   union bpf_attr {
> @@ -1544,6 +1549,7 @@ union bpf_attr {
>   		};
>   		__u32		attach_type;	/* attach type */
>   		__u32		flags;		/* extra flags */
> +		struct bpf_generic_user_log log; /* user log */

You cannot add this here, this breaks user space, you would have to
ad this under a xdp specific section inside the union.

>   		union {
>   			__u32		target_btf_id;	/* btf_id of target to attach to */
>   			struct {
> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index 850494423..be56b153b 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
> @@ -325,3 +325,36 @@ __printf(2, 3) void bpf_log(struct bpf_verifier_log *log,
>   	va_end(args);
>   }
>   EXPORT_SYMBOL_GPL(bpf_log);
> +
> +static inline void __bpf_generic_log_write(struct bpf_generic_log *log, const char *fmt,
> +				      va_list args)
> +{
> +	unsigned int n;
> +
> +	n = vscnprintf(log->kbuf, BPF_GENERIC_TMP_LOG_SIZE, fmt, args);
> +
> +	WARN_ONCE(n >= BPF_GENERIC_TMP_LOG_SIZE - 1,
> +		  "bpf generic log truncated - local buffer too short\n");
> +
> +	n = min(log->len_total - log->len_used - 1, n);
> +	log->kbuf[n] = '\0';
> +
> +	if (!copy_to_user(log->ubuf + log->len_used, log->kbuf, n + 1))
> +		log->len_used += n;
> +	else
> +		log->ubuf = NULL;
> +}
> +
> +__printf(2, 3) void bpf_generic_log_write(struct bpf_generic_log *log,
> +				     const char *fmt, ...)
> +{
> +	va_list args;
> +
> +	if (!log->ubuf || !log->len_total)
> +		return;
> +
> +	va_start(args, fmt);
> +	__bpf_generic_log_write(log, fmt, args);
> +	va_end(args);
> +}
> +EXPORT_SYMBOL_GPL(bpf_generic_log_write);
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 69a3e5446..e933809c0 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -9409,12 +9409,20 @@ static const struct bpf_link_ops bpf_xdp_link_lops = {
>   	.update_prog = bpf_xdp_link_update,
>   };
>   
> +static inline void bpf_xdp_link_log(const union bpf_attr *attr, struct netlink_ext_ack *extack)
> +{
> +	const struct bpf_generic_user_log *ulog = &attr->link_create.log;
> +
> +	BPF_GENERIC_ULOG_WRITE(ulog, extack->_msg);
> +}
> +
>   int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
>   {
>   	struct net *net = current->nsproxy->net_ns;
>   	struct bpf_link_primer link_primer;
>   	struct bpf_xdp_link *link;
>   	struct net_device *dev;
> +	struct netlink_ext_ack extack;
>   	int err, fd;
>   
>   	rtnl_lock();
> @@ -9440,12 +9448,13 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
>   		goto unlock;
>   	}
>   
> -	err = dev_xdp_attach_link(dev, NULL, link);
> +	err = dev_xdp_attach_link(dev, &extack, link);
>   	rtnl_unlock();
>   
>   	if (err) {
>   		link->dev = NULL;
>   		bpf_link_cleanup(&link_primer);
> +		bpf_xdp_link_log(attr, &extack);
>   		goto out_put_dev;
>   	}

Agree that this is a useful facility to have and propagate back here.

> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 60a9d59be..34fa33493 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1318,6 +1318,11 @@ struct bpf_stack_build_id {
>   	};
>   };
>   
> +struct bpf_generic_user_log {
> +	__aligned_u64	log_buf;    /* user supplied buffer */
> +	__u32		log_size;   /* size of user buffer */
> +};
> +
>   #define BPF_OBJ_NAME_LEN 16U
>   
>   union bpf_attr {
> @@ -1544,6 +1549,7 @@ union bpf_attr {
>   		};
>   		__u32		attach_type;	/* attach type */
>   		__u32		flags;		/* extra flags */
> +		struct bpf_generic_user_log log; /* user log */
>   		union {
>   			__u32		target_btf_id;	/* btf_id of target to attach to */
>   			struct {
> 


