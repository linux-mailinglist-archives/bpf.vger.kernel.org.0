Return-Path: <bpf+bounces-4712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB0C74E521
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 05:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0386E28164C
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 03:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59FE3C2F;
	Tue, 11 Jul 2023 03:10:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8591120FF;
	Tue, 11 Jul 2023 03:10:18 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B2E99;
	Mon, 10 Jul 2023 20:10:17 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-666edfc50deso3315740b3a.0;
        Mon, 10 Jul 2023 20:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689045016; x=1691637016;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NZVM+p4dtDzeWed2hrP0zGCZR3Oi08U6VSgDxI3H1Gc=;
        b=pOuUENkmwGdwqTRRnx5GS6K4mDJAsJLyVvrev3z1gD83mC+25I6FT6T2oGP4mhNYaH
         PngSpddHal6jowyURyMZlDeMT9bzQuWltJoEEDw2yAMPboEM4aQh7d3mi74hko8VRYGV
         /M13rFbTsKAKkYWqyfDT4Bkncrf2tBbGiVZd/feZvt7TdESXUHTZ0qokNu/k5XBVIpGz
         huIhewFehHxS6DGm5W+DmPz8pOwQXnYpJfEWuxOypaEiC2NYyVW3YTCDxhnxR1uTolmU
         IKzYbUDyR1qJbBYM+1tKm+ZHefVD8ZyVN/22kIzXYRw45l/ybV6xlMxilRAOodw9ZCTq
         EF2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689045016; x=1691637016;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NZVM+p4dtDzeWed2hrP0zGCZR3Oi08U6VSgDxI3H1Gc=;
        b=WP1hNJ/GE/ZKz1bejUQ4Sr1F4D633jemQGZzF13Usuao3OeGhZeWVK2OIRkIUKRavo
         ZfJNjfrr6CbvBWtC9HgjFyiI0AsUhOGTW0Oq823KOzFNjrQLrtH+tyd03dPUlVSrJw1+
         1R13kG/5FwzaD08S8UD7cMHRXIVzbdJQdvFgpcjTyeui98Wexmvr2/O4PUSJoJYXbQXY
         KO0g4XpG1fTBhD8gMxdBmscSRUyikKaphJu2SFiBmn8fZp0CXEJlX8dpzBUgw6SLXpiJ
         lM0IVirIrSc5Fznf+pFddm9xHcz5uYRt1DCN/z1mJ16Woz4HskHWs6mITniVvzATl1+D
         xJ1w==
X-Gm-Message-State: ABy/qLZSxDx4A2RRbow+oaWRpn0SIK3cmAVPi87SZss6MZAMumLk8M5V
	CWyIYGnZw5FmIg2ywWCSWfUDMsrU0nhvQzf1
X-Google-Smtp-Source: APBJJlFTIQyMHdTmyStN1X5n1vpOEttR7Rinz8Gzmf4KeOGpqinZ7xEaXQQYcFn0R2d1uEG0rtB3vg==
X-Received: by 2002:a05:6a00:10c4:b0:66f:7076:a5b4 with SMTP id d4-20020a056a0010c400b0066f7076a5b4mr19381348pfu.7.1689045016274;
        Mon, 10 Jul 2023 20:10:16 -0700 (PDT)
Received: from [10.22.68.146] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id 22-20020aa79216000000b006765cb3255asm511187pfo.68.2023.07.10.20.10.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 20:10:15 -0700 (PDT)
Message-ID: <e173d607-a3fa-5b8b-33b0-221079d62bad@gmail.com>
Date: Tue, 11 Jul 2023 11:10:10 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Introduce bpf generic log
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, hawk@kernel.org, tangyeechou@gmail.com,
 kernel-patches-bot@fb.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20230708040750.72570-1-hffilwlqm@gmail.com>
 <20230708040750.72570-2-hffilwlqm@gmail.com>
 <CAEf4BzZxS8sxr47GoXU0ZrwgZtp7drc5cehCOFrbx3-=n-1aFg@mail.gmail.com>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <CAEf4BzZxS8sxr47GoXU0ZrwgZtp7drc5cehCOFrbx3-=n-1aFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 11/7/23 06:23, Andrii Nakryiko wrote:
> On Fri, Jul 7, 2023 at 9:08 PM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>
>> Currently, excluding verifier, users are unable to obtain detailed error
>> information when issues occur in BPF syscall.
>>
>> To overcome this limitation, bpf generic log is introduced to provide
>> error details similar to the verifier. This enhancement will enable the
>> reporting of error details along with the corresponding errno in BPF
>> syscall.
>>
>> Essentially, bpf generic log functions as a mechanism similar to netlink,
>> enabling the transmission of error messages to user space. This
>> mechanism greatly enhances the usability of BPF syscall by allowing
>> users to access comprehensive error messages instead of relying solely
>> on errno.
>>
>> This patch specifically addresses the error reporting in dev_xdp_attach()
>> . With this patch, the error messages will be transferred to user space
>> like the netlink approach. Hence, users will be able to check the error
>> message along with the errno.
>>
>> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
>> ---
>>  include/linux/bpf.h            | 30 ++++++++++++++++++++++++++++++
>>  include/uapi/linux/bpf.h       |  6 ++++++
>>  kernel/bpf/log.c               | 33 +++++++++++++++++++++++++++++++++
>>  net/core/dev.c                 | 11 ++++++++++-
>>  tools/include/uapi/linux/bpf.h |  6 ++++++
>>  5 files changed, 85 insertions(+), 1 deletion(-)
>>
> 
> Just curious, what's wrong with struct bpf_verifier_log for
> implementing "generic log"? bpf_log, bpf_vlog_reset, bpf_vlog_finalize
> are quite generic, I think. Why invent yet another structure? Existing
> code and struct support rotating log, if necessary.
> 

Sorry for the misguiding patch. This patch should not be submitted in v2.

>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 360433f14496a..7d2124a537943 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -3107,4 +3107,34 @@ static inline gfp_t bpf_memcg_flags(gfp_t flags)
>>         return flags;
>>  }
>>
>> +#define BPF_GENERIC_TMP_LOG_SIZE       256
>> +
>> +struct bpf_generic_log {
>> +       char            kbuf[BPF_GENERIC_TMP_LOG_SIZE];
>> +       char __user     *ubuf;
>> +       u32             len_used;
>> +       u32             len_total;
>> +};
>> +
>> +__printf(2, 3) void bpf_generic_log_write(struct bpf_generic_log *log,
>> +                       const char *fmt, ...);
>> +static inline void bpf_generic_log_init(struct bpf_generic_log *log,
>> +                       const struct bpf_generic_user_log *ulog)
>> +{
>> +       log->ubuf = (char __user *) (unsigned long) ulog->log_buf;
>> +       log->len_total = ulog->log_size;
>> +       log->len_used = 0;
>> +}
>> +
>> +#define BPF_GENERIC_LOG_WRITE(log, ulog, fmt, ...)     do {    \
>> +       const char *____fmt = (fmt);                            \
>> +       bpf_generic_log_init(log, ulog);                        \
>> +       bpf_generic_log_write(log, ____fmt, ##__VA_ARGS__);     \
>> +} while (0)
>> +
>> +#define BPF_GENERIC_ULOG_WRITE(ulog, fmt, ...) do {                    \
>> +       struct bpf_generic_log ____log;                                 \
>> +       BPF_GENERIC_LOG_WRITE(&____log, ulog, fmt, ##__VA_ARGS__);      \
>> +} while (0)
>> +
>>  #endif /* _LINUX_BPF_H */
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 60a9d59beeabb..34fa334938ba5 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -1318,6 +1318,11 @@ struct bpf_stack_build_id {
>>         };
>>  };
>>
>> +struct bpf_generic_user_log {
>> +       __aligned_u64   log_buf;    /* user supplied buffer */
>> +       __u32           log_size;   /* size of user buffer */
>> +};
>> +
>>  #define BPF_OBJ_NAME_LEN 16U
>>
>>  union bpf_attr {
>> @@ -1544,6 +1549,7 @@ union bpf_attr {
>>                 };
>>                 __u32           attach_type;    /* attach type */
>>                 __u32           flags;          /* extra flags */
>> +               struct bpf_generic_user_log log; /* user log */
> 
> I think explicit triplet of log_level (should be log_flags, but too
> late, probably), log_size, and log_buf is less error prone and more in
> sync with other two commands that accept log (BPF_PROG_LOAD and
> BPF_BTF_LOAD).
> 

Better to keep same with BPF_PROG_LOAD and BPF_BTF_LOAD.

But considering the suggestion from Daniel Xu and Alexei Starovoitov,
it's better to add a tracepoint to expose the error message from
dev_xdp_attach(), without breaking uapi.

>>                 union {
>>                         __u32           target_btf_id;  /* btf_id of target to attach to */
>>                         struct {
>> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
>> index 850494423530e..be56b153bbf0b 100644
>> --- a/kernel/bpf/log.c
>> +++ b/kernel/bpf/log.c
>> @@ -325,3 +325,36 @@ __printf(2, 3) void bpf_log(struct bpf_verifier_log *log,
>>         va_end(args);
>>  }
>>  EXPORT_SYMBOL_GPL(bpf_log);
>> +
>> +static inline void __bpf_generic_log_write(struct bpf_generic_log *log, const char *fmt,
>> +                                     va_list args)
>> +{
>> +       unsigned int n;
>> +
>> +       n = vscnprintf(log->kbuf, BPF_GENERIC_TMP_LOG_SIZE, fmt, args);
>> +
>> +       WARN_ONCE(n >= BPF_GENERIC_TMP_LOG_SIZE - 1,
>> +                 "bpf generic log truncated - local buffer too short\n");
>> +
>> +       n = min(log->len_total - log->len_used - 1, n);
>> +       log->kbuf[n] = '\0';
>> +
>> +       if (!copy_to_user(log->ubuf + log->len_used, log->kbuf, n + 1))
>> +               log->len_used += n;
>> +       else
>> +               log->ubuf = NULL;
>> +}
>> +
> 
> please see bpf_verifier_vlog() in kernel/bpf/log.c. We don't want to
> maintain another (even if light) version of it.
> 

Agree with you, we should not maintain multiple versions of it.

However, it will be replaced with tracepoint patch.

Thanks,
Leon

