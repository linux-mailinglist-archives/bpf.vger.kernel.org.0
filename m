Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5504C5EA0
	for <lists+bpf@lfdr.de>; Sun, 27 Feb 2022 21:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiB0Ue2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 27 Feb 2022 15:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiB0Ue1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 27 Feb 2022 15:34:27 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D5344778
        for <bpf@vger.kernel.org>; Sun, 27 Feb 2022 12:33:48 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id bn33so14752438ljb.6
        for <bpf@vger.kernel.org>; Sun, 27 Feb 2022 12:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=oAhYdonpuualCR4qUA0nagGOIcdHYWKjO8ATK/t2440=;
        b=xsD6970MYHbEisYJs+kszLzE5nxGlMDuojcnue8lYk0rzLR2AGB/ypwoWY7+WQclFF
         yNBLKS7CmCCSlX+/irB4HaCKQQao5arpiRp0Skscoc5uDDJcYXX9g1iTfWpfbycp3AB2
         Ezdrha4AG4waA80z45F75RWjc2Q3P6OIjyFew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=oAhYdonpuualCR4qUA0nagGOIcdHYWKjO8ATK/t2440=;
        b=ksQ+ZcK3AdG2jvz7uwEtHnuuaw5poP+S1XvUvrWsmgRsUausrqLOrAZGJGNTTG0/ug
         lHaW/1TL6Pieh7QSrLxysmdzNCK3J1HzoqvzpmDrrzY12C6O0XExiRy//mffONIwQBsr
         ju039rDMeC2NeqMrtVt5zunf2gd+iwsA5GIarccnPbQQVaZFeocM5OJl/pYhiUcKLiYF
         aKUKMR7Gz/rJK3RA22ggasvE6R8cg2VXu/hC8NjKXpmxA6lLtntkA6TMTguKDIweIkxs
         S061bIl7qNviRvSsGPrSliyLjR7L7xqSu7NqFO7pNwLtljqxAg9Agc6VKCvOx+LjbCuf
         cfXw==
X-Gm-Message-State: AOAM531u60KVlqnvL2BhXMfs3NmBI6UJDsJay8aqFA2pnG7m+5nw0VcF
        gZqDiko30pQ9LKo7zS19MAsjLQ==
X-Google-Smtp-Source: ABdhPJwp67YCtF3hp/hmbeNGbLxwnmL/2JjWuZRTqU1j3crnlxErTf1NOZuWx/Wo6XdKG4cKjM8Jlw==
X-Received: by 2002:a05:651c:b06:b0:246:6331:c34f with SMTP id b6-20020a05651c0b0600b002466331c34fmr12123757ljr.362.1645994027029;
        Sun, 27 Feb 2022 12:33:47 -0800 (PST)
Received: from cloudflare.com ([2a01:110f:4809:d800::f9c])
        by smtp.gmail.com with ESMTPSA id i31-20020a0565123e1f00b004437ea7d615sm735851lfv.41.2022.02.27.12.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 12:33:46 -0800 (PST)
References: <20220222182559.2865596-1-iii@linux.ibm.com>
 <20220222182559.2865596-3-iii@linux.ibm.com>
 <20220227024457.rv5zei6qk4d6wy6d@ast-mbp.dhcp.thefacebook.com>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH RFC bpf-next 2/3] bpf: Fix bpf_sk_lookup.remote_port on
 big-endian
Date:   Sun, 27 Feb 2022 21:30:01 +0100
In-reply-to: <20220227024457.rv5zei6qk4d6wy6d@ast-mbp.dhcp.thefacebook.com>
Message-ID: <87y21whwwl.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On Sat, Feb 26, 2022 at 06:44 PM -08, Alexei Starovoitov wrote:
> On Tue, Feb 22, 2022 at 07:25:58PM +0100, Ilya Leoshkevich wrote:
>> On big-endian, the port is available in the second __u16, not the first
>> one. Therefore, provide a big-endian-specific definition that reflects
>> that. Also, define remote_port_compat in order to have nicer
>> architecture-agnostic code in the verifier and in tests.
>> 
>> Fixes: 9a69e2b385f4 ("bpf: Make remote_port field in struct bpf_sk_lookup 16-bit wide")
>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>> ---
>>  include/uapi/linux/bpf.h       | 17 +++++++++++++++--
>>  net/core/filter.c              |  5 ++---
>>  tools/include/uapi/linux/bpf.h | 17 +++++++++++++++--
>>  3 files changed, 32 insertions(+), 7 deletions(-)
>> 
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index afe3d0d7f5f2..7b0e5efa58e0 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -10,6 +10,7 @@
>>  
>>  #include <linux/types.h>
>>  #include <linux/bpf_common.h>
>> +#include <asm/byteorder.h>
>>  
>>  /* Extended instruction set based on top of classic BPF */
>>  
>> @@ -6453,8 +6454,20 @@ struct bpf_sk_lookup {
>>  	__u32 protocol;		/* IP protocol (IPPROTO_TCP, IPPROTO_UDP) */
>>  	__u32 remote_ip4;	/* Network byte order */
>>  	__u32 remote_ip6[4];	/* Network byte order */
>> -	__be16 remote_port;	/* Network byte order */
>> -	__u16 :16;		/* Zero padding */
>> +	union {
>> +		struct {
>> +#if defined(__BYTE_ORDER) ? __BYTE_ORDER == __LITTLE_ENDIAN : defined(__LITTLE_ENDIAN)
>> +			__be16 remote_port;	/* Network byte order */
>> +			__u16 :16;		/* Zero padding */
>> +#elif defined(__BYTE_ORDER) ? __BYTE_ORDER == __BIG_ENDIAN : defined(__BIG_ENDIAN)
>> +			__u16 :16;		/* Zero padding */
>> +			__be16 remote_port;	/* Network byte order */
>> +#else
>> +#error unspecified endianness
>> +#endif
>> +		};
>> +		__u32 remote_port_compat;
>
> Sorry this hack is not an option.
> Don't have any suggestions at this point. Pls come up with something else.

I think we can keep the bpf_sk_lookup definition as is, if we leave the
4-byte load from remote_port offset quirky behavior on little-endian.

Please take a look at the test fix I've posted for 4-byte load from
bpf_sock dst_port that works for me on x86_64 and s390. It is exactly
the same case as we're dealing with here:

https://lore.kernel.org/bpf/20220227202757.519015-4-jakub@cloudflare.com/T/#u

