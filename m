Return-Path: <bpf+bounces-4079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5952F74898F
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 18:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 292FB1C20B5F
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 16:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9C912B6D;
	Wed,  5 Jul 2023 16:54:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C059E2C80;
	Wed,  5 Jul 2023 16:54:28 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33DA10C3;
	Wed,  5 Jul 2023 09:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=NaF5ODUhgDcBSbTY5pdKmE/ptdlDITp5mTjsd0ABD2E=; b=OG0Q8LZi7U5ttEb1YIf7uOywzf
	I+QYRZjLDRvAUSAGp1UxIbnTRn9N7wxtxArmSkuF0+0yTz5fjN1LdpiqgI7p2JaE/WdcScjGxYI4c
	Fs3tozpzqVPlIjqJLLoSo1gtSWaV1Z4RIi3A3gr9mKjSgwcanoUPmBDofd1KwyMRsu5Wbl+Y8zsDH
	sqw0RiiRGACtK+puZlwzScOE4qAcEuWW5oTQdIoaIvzUwBEav5xIEKoWhD2zL+bhjC4BO90mNk+YW
	woQrxtxQCU0doqWG+KclkVvTivM3+JHleVUjT4obVkWvqk1JgwrBzQ4P/avWMi3zQeqx7tZda0j/o
	524G2Z3w==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qH5ld-0009nC-1W; Wed, 05 Jul 2023 18:54:13 +0200
Received: from [178.197.249.31] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qH5lc-000Nft-8y; Wed, 05 Jul 2023 18:54:12 +0200
Subject: Re: [PATCH bpf-next] bpf: Introduce bpf generic log
To: Leon Hwang <hffilwlqm@gmail.com>, ast@kernel.org
Cc: john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, hawk@kernel.org,
 tangyeechou@gmail.com, kernel-patches-bot@fb.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20230705132058.46194-1-hffilwlqm@gmail.com>
 <1a205a85-ebf2-6d90-468d-4fd63ce3dd0f@iogearbox.net>
 <a42c246a-01e1-9e7e-8260-57835c6351ae@gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <688cbc7b-b23e-7edd-4603-b5734eaa9bd7@iogearbox.net>
Date: Wed, 5 Jul 2023 18:54:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a42c246a-01e1-9e7e-8260-57835c6351ae@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26960/Wed Jul  5 09:29:05 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/5/23 6:20 PM, Leon Hwang wrote:
> On 2023/7/5 22:39, Daniel Borkmann wrote:
>> On 7/5/23 3:20 PM, Leon Hwang wrote:
>>> Currently, excluding verifier, users are unable to obtain detailed error
>>> information when issues occur in BPF syscall.
>>>
>>> To overcome this limitation, bpf generic log is introduced to provide
>>> error details similar to the verifier. This enhancement will enable the
>>> reporting of error details along with the corresponding errno in BPF
>>> syscall.
>>>
>>> Essentially, bpf generic log functions as a mechanism similar to netlink,
>>> enabling the transmission of error messages to user space. This
>>> mechanism greatly enhances the usability of BPF syscall by allowing
>>> users to access comprehensive error messages instead of relying solely
>>> on errno.
>>>
>>> This patch specifically addresses the error reporting in dev_xdp_attach()
>>> . With this patch, the error messages will be transferred to user space
>>> like the netlink approach. Hence, users will be able to check the error
>>> message along with the errno.
>>>
>>> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
>>> ---
>>>   include/linux/bpf.h            | 30 ++++++++++++++++++++++++++++++
>>>   include/uapi/linux/bpf.h       |  6 ++++++
>>>   kernel/bpf/log.c               | 33 +++++++++++++++++++++++++++++++++
>>>   net/core/dev.c                 | 11 ++++++++++-
>>>   tools/include/uapi/linux/bpf.h |  6 ++++++
>>>   5 files changed, 85 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>> index f58895830..fd63f4a76 100644
>>> --- a/include/linux/bpf.h
>>> +++ b/include/linux/bpf.h
>>> @@ -3077,4 +3077,34 @@ static inline gfp_t bpf_memcg_flags(gfp_t flags)
>>>       return flags;
>>>   }
>>>   +#define BPF_GENERIC_TMP_LOG_SIZE    256
>>> +
>>> +struct bpf_generic_log {
>>> +    char        kbuf[BPF_GENERIC_TMP_LOG_SIZE];
>>> +    char __user    *ubuf;
>>> +    u32        len_used;
>>> +    u32        len_total;
>>> +};
>>> +
>>> +__printf(2, 3) void bpf_generic_log_write(struct bpf_generic_log *log,
>>> +            const char *fmt, ...);
>>> +static inline void bpf_generic_log_init(struct bpf_generic_log *log,
>>> +            const struct bpf_generic_user_log *ulog)
>>> +{
>>> +    log->ubuf = (char __user *) (unsigned long) ulog->log_buf;
>>> +    log->len_total = ulog->log_size;
>>> +    log->len_used = 0;
>>> +}
>>> +
>>> +#define BPF_GENERIC_LOG_WRITE(log, ulog, fmt, ...)    do {    \
>>> +    const char *____fmt = (fmt);                \
>>> +    bpf_generic_log_init(log, ulog);            \
>>> +    bpf_generic_log_write(log, ____fmt, ##__VA_ARGS__);    \
>>> +} while (0)
>>> +
>>> +#define BPF_GENERIC_ULOG_WRITE(ulog, fmt, ...)    do {            \
>>> +    struct bpf_generic_log ____log;                    \
>>> +    BPF_GENERIC_LOG_WRITE(&____log, ulog, fmt, ##__VA_ARGS__);    \
>>> +} while (0)
>>> +
>>
>> Could we generalize the bpf_verifier_log infra and reuse bpf_log() helper
>> instead of adding something new?
> 
> 
> Yes. It's possible to reuse the bpf_verifier_log infra and reuse bpf_log()
> helper. I'll try this way:
> 
> #define BPF_LOG_USER  BPF_LOG_LEVEL1     /* user log flag */
> 
> #define BPF_ULOG_WRITE(log_buf, log_size, fmt, ...) do {               \
>         const char *____fmt = (fmt);                                    \
>         struct bpf_verifier_log ____vlog;                               \
>         bpf_vlog_init(&____vlog, BPF_LOG_USER, log_buf, log_size);      \
>         bpf_log(&____vlog, ____fmt, ##__VA_ARGS__);                         \
> } while (0)

Could we hide all of this inside bpf_log() or better create a new bpf_log_once() wrapper,
passing in attr so we only need to use the latter w/o the extra macros?

Essentially what your bpf_xdp_link_log() is doing, just that bpf_log_once(attr, extack._msg)
would be generic and sufficient.

Thanks,
Daniel

