Return-Path: <bpf+bounces-4078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFFF74891B
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 18:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBFF41C20B4F
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 16:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC7512B84;
	Wed,  5 Jul 2023 16:20:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B4611CA4;
	Wed,  5 Jul 2023 16:20:31 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA461700;
	Wed,  5 Jul 2023 09:20:29 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-666e916b880so3018834b3a.2;
        Wed, 05 Jul 2023 09:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688574029; x=1691166029;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cF+yis7yxPKnaAXbJ+bxdy624uSwxEb99+pHc9ujqFc=;
        b=RHa7XiKnO52jTHy72nkrFJ3HgR4vwGIyTx8lMuIiAMfUiBuaSQJ31J72+AtqHHdmYu
         1QEDEoepKM0lka/qLaD5mg2W16YFQuxl6YoM4ncDdIZ/XBVJNctVvh7GlIf9Cc2TJ6yS
         8qGbBcHzaqC4zQPLjfYG9U+gpzpGfLXc8KOW5SZZb3cMb9fosIY4m7tmRsVL+IKvtN+x
         OEPDcoy5OeOX4qLBJIBO2hojDzHbNun43tlW2WBN5TzC422NyuTnSp9rgw+rtQwfjakX
         2jf8VYxenz6oTyoDtJstOFakOHHm83rfROhme4A1YwtoHErSl5u6nR1wwbicEr4T/0zD
         jXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688574029; x=1691166029;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cF+yis7yxPKnaAXbJ+bxdy624uSwxEb99+pHc9ujqFc=;
        b=Bjt+4NQxIUdrmVh7Toxk/iUGi66OzQR5pvF6Bz4I4ID/c7vASycWVp8R8R0mZQ9ITM
         k74x9gB8IVOx3xXvLCq+v2dEH8V7F/bq8xW+VHFxV4m3GWrfII5KIi9J1wQ7nj6VJZ/3
         Vmc8jzQ1H6GiPjniQhaP6B9kCIQTV4qrR0/tgggmC58MHNjaubeZC1Yv/GK3iNhGb9M6
         M0S1nopNCyCJsCUzS2NnNc4jmqdSz7WzYJyvSKceze7gRa8IjANpgxuHjalzehMkvLz6
         SlcJ8QqmUNjxvhljIwJgjb8vWxImjLHWXu+0l/VJloB6gNdn5qgLjZs7AMDSURIXviIx
         Fkig==
X-Gm-Message-State: ABy/qLaj/CpmPA/gBSkfZ840RVCRP6v/n1GwwMAYdq0Qy4jrEIjw3LYv
	cVS8uHWYlEGhGPOfH9+D2zg=
X-Google-Smtp-Source: APBJJlHYx2lweNznynNGTWl7DWUeJ367azd31Q7crJ8MBXmCTR5DijQxCkeqS8tnpkmlHx2Wc3lbtQ==
X-Received: by 2002:a05:6a00:1791:b0:681:d5c4:4973 with SMTP id s17-20020a056a00179100b00681d5c44973mr17062486pfg.22.1688574028666;
        Wed, 05 Jul 2023 09:20:28 -0700 (PDT)
Received: from [192.168.1.12] (bb219-74-209-211.singnet.com.sg. [219.74.209.211])
        by smtp.gmail.com with ESMTPSA id q136-20020a632a8e000000b0055b0c330b30sm13608029pgq.84.2023.07.05.09.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 09:20:28 -0700 (PDT)
Message-ID: <a42c246a-01e1-9e7e-8260-57835c6351ae@gmail.com>
Date: Thu, 6 Jul 2023 00:20:22 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH bpf-next] bpf: Introduce bpf generic log
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org
Cc: john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, hawk@kernel.org,
 tangyeechou@gmail.com, kernel-patches-bot@fb.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20230705132058.46194-1-hffilwlqm@gmail.com>
 <1a205a85-ebf2-6d90-468d-4fd63ce3dd0f@iogearbox.net>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <1a205a85-ebf2-6d90-468d-4fd63ce3dd0f@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/7/5 22:39, Daniel Borkmann wrote:
> On 7/5/23 3:20 PM, Leon Hwang wrote:
>> Currently, excluding verifier, users are unable to obtain detailed error
>> information when issues occur in BPF syscall.
>>
>> To overcome this limitation, bpf generic log is introduced to provide
>> error details similar to the verifier. This enhancement will enable the
>> reporting of error details along with the corresponding errno in BPF
>> syscall.
>>
>> Essentially, bpf generic log functions as a mechanism similar to 
>> netlink,
>> enabling the transmission of error messages to user space. This
>> mechanism greatly enhances the usability of BPF syscall by allowing
>> users to access comprehensive error messages instead of relying solely
>> on errno.
>>
>> This patch specifically addresses the error reporting in 
>> dev_xdp_attach()
>> . With this patch, the error messages will be transferred to user space
>> like the netlink approach. Hence, users will be able to check the error
>> message along with the errno.
>>
>> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
>> ---
>>   include/linux/bpf.h            | 30 ++++++++++++++++++++++++++++++
>>   include/uapi/linux/bpf.h       |  6 ++++++
>>   kernel/bpf/log.c               | 33 +++++++++++++++++++++++++++++++++
>>   net/core/dev.c                 | 11 ++++++++++-
>>   tools/include/uapi/linux/bpf.h |  6 ++++++
>>   5 files changed, 85 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index f58895830..fd63f4a76 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -3077,4 +3077,34 @@ static inline gfp_t bpf_memcg_flags(gfp_t flags)
>>       return flags;
>>   }
>>   +#define BPF_GENERIC_TMP_LOG_SIZE    256
>> +
>> +struct bpf_generic_log {
>> +    char        kbuf[BPF_GENERIC_TMP_LOG_SIZE];
>> +    char __user    *ubuf;
>> +    u32        len_used;
>> +    u32        len_total;
>> +};
>> +
>> +__printf(2, 3) void bpf_generic_log_write(struct bpf_generic_log *log,
>> +            const char *fmt, ...);
>> +static inline void bpf_generic_log_init(struct bpf_generic_log *log,
>> +            const struct bpf_generic_user_log *ulog)
>> +{
>> +    log->ubuf = (char __user *) (unsigned long) ulog->log_buf;
>> +    log->len_total = ulog->log_size;
>> +    log->len_used = 0;
>> +}
>> +
>> +#define BPF_GENERIC_LOG_WRITE(log, ulog, fmt, ...)    do {    \
>> +    const char *____fmt = (fmt);                \
>> +    bpf_generic_log_init(log, ulog);            \
>> +    bpf_generic_log_write(log, ____fmt, ##__VA_ARGS__);    \
>> +} while (0)
>> +
>> +#define BPF_GENERIC_ULOG_WRITE(ulog, fmt, ...)    do {            \
>> +    struct bpf_generic_log ____log;                    \
>> +    BPF_GENERIC_LOG_WRITE(&____log, ulog, fmt, ##__VA_ARGS__);    \
>> +} while (0)
>> +
>
> Could we generalize the bpf_verifier_log infra and reuse bpf_log() helper
> instead of adding something new?


Yes. It's possible to reuse the bpf_verifier_log infra and reuse bpf_log()
helper. I'll try this way:

#define BPF_LOG_USER  BPF_LOG_LEVEL1     /* user log flag */

#define BPF_ULOG_WRITE(log_buf, log_size, fmt, ...) do {               \
        const char *____fmt = (fmt);                                    \
        struct bpf_verifier_log ____vlog;                               \
        bpf_vlog_init(&____vlog, BPF_LOG_USER, log_buf, log_size);      \
        bpf_log(&____vlog, ____fmt, 
##__VA_ARGS__);                         \
} while (0)


>
>>   #endif /* _LINUX_BPF_H */
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 60a9d59be..34fa33493 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -1318,6 +1318,11 @@ struct bpf_stack_build_id {
>>       };
>>   };
>>   +struct bpf_generic_user_log {
>> +    __aligned_u64    log_buf;    /* user supplied buffer */
>> +    __u32        log_size;   /* size of user buffer */
>> +};
>> +
>>   #define BPF_OBJ_NAME_LEN 16U
>>     union bpf_attr {
>> @@ -1544,6 +1549,7 @@ union bpf_attr {
>>           };
>>           __u32        attach_type;    /* attach type */
>>           __u32        flags;        /* extra flags */
>> +        struct bpf_generic_user_log log; /* user log */
>
> You cannot add this here, this breaks user space, you would have to
> ad this under a xdp specific section inside the union.


Got it. I'll change it to avoid breaking user space.


>
>>           union {
>>               __u32        target_btf_id;    /* btf_id of target to 
>> attach to */
>>               struct {
>> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
>> index 850494423..be56b153b 100644
>> --- a/kernel/bpf/log.c
>> +++ b/kernel/bpf/log.c
>> @@ -325,3 +325,36 @@ __printf(2, 3) void bpf_log(struct 
>> bpf_verifier_log *log,
>>       va_end(args);
>>   }
>>   EXPORT_SYMBOL_GPL(bpf_log);
>> +
>> +static inline void __bpf_generic_log_write(struct bpf_generic_log 
>> *log, const char *fmt,
>> +                      va_list args)
>> +{
>> +    unsigned int n;
>> +
>> +    n = vscnprintf(log->kbuf, BPF_GENERIC_TMP_LOG_SIZE, fmt, args);
>> +
>> +    WARN_ONCE(n >= BPF_GENERIC_TMP_LOG_SIZE - 1,
>> +          "bpf generic log truncated - local buffer too short\n");
>> +
>> +    n = min(log->len_total - log->len_used - 1, n);
>> +    log->kbuf[n] = '\0';
>> +
>> +    if (!copy_to_user(log->ubuf + log->len_used, log->kbuf, n + 1))
>> +        log->len_used += n;
>> +    else
>> +        log->ubuf = NULL;
>> +}
>> +
>> +__printf(2, 3) void bpf_generic_log_write(struct bpf_generic_log *log,
>> +                     const char *fmt, ...)
>> +{
>> +    va_list args;
>> +
>> +    if (!log->ubuf || !log->len_total)
>> +        return;
>> +
>> +    va_start(args, fmt);
>> +    __bpf_generic_log_write(log, fmt, args);
>> +    va_end(args);
>> +}
>> +EXPORT_SYMBOL_GPL(bpf_generic_log_write);
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index 69a3e5446..e933809c0 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -9409,12 +9409,20 @@ static const struct bpf_link_ops 
>> bpf_xdp_link_lops = {
>>       .update_prog = bpf_xdp_link_update,
>>   };
>>   +static inline void bpf_xdp_link_log(const union bpf_attr *attr, 
>> struct netlink_ext_ack *extack)
>> +{
>> +    const struct bpf_generic_user_log *ulog = &attr->link_create.log;
>> +
>> +    BPF_GENERIC_ULOG_WRITE(ulog, extack->_msg);
>> +}
>> +
>>   int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog 
>> *prog)
>>   {
>>       struct net *net = current->nsproxy->net_ns;
>>       struct bpf_link_primer link_primer;
>>       struct bpf_xdp_link *link;
>>       struct net_device *dev;
>> +    struct netlink_ext_ack extack;
>>       int err, fd;
>>         rtnl_lock();
>> @@ -9440,12 +9448,13 @@ int bpf_xdp_link_attach(const union bpf_attr 
>> *attr, struct bpf_prog *prog)
>>           goto unlock;
>>       }
>>   -    err = dev_xdp_attach_link(dev, NULL, link);
>> +    err = dev_xdp_attach_link(dev, &extack, link);
>>       rtnl_unlock();
>>         if (err) {
>>           link->dev = NULL;
>>           bpf_link_cleanup(&link_primer);
>> +        bpf_xdp_link_log(attr, &extack);
>>           goto out_put_dev;
>>       }
>
> Agree that this is a useful facility to have and propagate back here.
>
>> diff --git a/tools/include/uapi/linux/bpf.h 
>> b/tools/include/uapi/linux/bpf.h
>> index 60a9d59be..34fa33493 100644
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
>> @@ -1318,6 +1318,11 @@ struct bpf_stack_build_id {
>>       };
>>   };
>>   +struct bpf_generic_user_log {
>> +    __aligned_u64    log_buf;    /* user supplied buffer */
>> +    __u32        log_size;   /* size of user buffer */
>> +};
>> +
>>   #define BPF_OBJ_NAME_LEN 16U
>>     union bpf_attr {
>> @@ -1544,6 +1549,7 @@ union bpf_attr {
>>           };
>>           __u32        attach_type;    /* attach type */
>>           __u32        flags;        /* extra flags */
>> +        struct bpf_generic_user_log log; /* user log */
>>           union {
>>               __u32        target_btf_id;    /* btf_id of target to 
>> attach to */
>>               struct {
>>
>

