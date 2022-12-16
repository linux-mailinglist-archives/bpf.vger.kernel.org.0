Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281EF64F078
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 18:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbiLPRke (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 12:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiLPRkd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 12:40:33 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2174D5CF
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 09:40:30 -0800 (PST)
Message-ID: <6a4f2605-958f-a7f7-ead5-aabb2d775424@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1671212429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kanj4Ejwcrta2/OC9P6waYMJNu4WDIb2Vnbfq2SoI88=;
        b=xaLlIpqkwBrMx2u5BFzzRRQjtYt6t3tD7eAOqk0AOojpyNXW4f/WcMPmQGNOYTbgKR+8L3
        dTzcdzGuJPhniOLV0ZHM0L03KTpKzSsBMikILJUkkpUF13iDHH1ATnhXr4vntRxClhh4vR
        lkCXPUiAlw4hfCddO1EFHXzootlbtPk=
Date:   Fri, 16 Dec 2022 09:40:26 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/9] bpf: Allow read access to addr_len from
 cgroup sockaddr programs
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     Daan De Meyer <daan.j.demeyer@gmail.com>
Cc:     kernel-team@meta.com, bpf@vger.kernel.org
References: <20221210193559.371515-1-daan.j.demeyer@gmail.com>
 <20221210193559.371515-3-daan.j.demeyer@gmail.com>
 <74fde08a-56d7-0567-4e68-abe2a6fe3ae0@linux.dev>
In-Reply-To: <74fde08a-56d7-0567-4e68-abe2a6fe3ae0@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/15/22 11:28 PM, Martin KaFai Lau wrote:
> On 12/10/22 11:35 AM, Daan De Meyer wrote:
>> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
>> index 57e9e109257e..3ab2f06ddc8a 100644
>> --- a/include/linux/bpf-cgroup.h
>> +++ b/include/linux/bpf-cgroup.h
>> @@ -120,6 +120,7 @@ int __cgroup_bpf_run_filter_sk(struct sock *sk,
>>   int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
>>                         struct sockaddr *uaddr,
>> +                      int *uaddrlen,
>>                         enum cgroup_bpf_attach_type atype,
>>                         void *t_ctx,
>>                         u32 *flags);
>> @@ -230,75 +231,76 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
>>   #define BPF_CGROUP_RUN_PROG_INET6_POST_BIND(sk)                       \
>>       BPF_CGROUP_RUN_SK_PROG(sk, CGROUP_INET6_POST_BIND)
>> -#define BPF_CGROUP_RUN_SA_PROG(sk, uaddr, atype)                       \
>> -({                                           \
>> -    int __ret = 0;                                   \
>> -    if (cgroup_bpf_enabled(atype))                           \
>> -        __ret = __cgroup_bpf_run_filter_sock_addr(sk, uaddr, atype,     \
>> -                              NULL, NULL);           \
>> -    __ret;                                       \
>> -})
>> -
>> -#define BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, atype, t_ctx)               \
>> -({                                           \
>> -    int __ret = 0;                                   \
>> -    if (cgroup_bpf_enabled(atype))    {                       \
>> -        lock_sock(sk);                               \
>> -        __ret = __cgroup_bpf_run_filter_sock_addr(sk, uaddr, atype,     \
>> -                              t_ctx, NULL);           \
>> -        release_sock(sk);                           \
>> -    }                                       \
>> -    __ret;                                       \
>> -})
>> +#define BPF_CGROUP_RUN_SA_PROG(sk, uaddr, uaddrlen, atype)               \
>> +    ({                                                               \
>> +        int __ret = 0;                                           \
>> +        if (cgroup_bpf_enabled(atype))                           \
>> +            __ret = __cgroup_bpf_run_filter_sock_addr(       \
>> +                sk, uaddr, uaddrlen, atype, NULL, NULL); \
>> +        __ret;                                                   \
>> +    })
>> +
>> +#define BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, atype, t_ctx)    \
>> +    ({                                                                \
>> +        int __ret = 0;                                            \
>> +        if (cgroup_bpf_enabled(atype)) {                          \
>> +            lock_sock(sk);                                    \
>> +            __ret = __cgroup_bpf_run_filter_sock_addr(        \
>> +                sk, uaddr, uaddrlen, atype, t_ctx, NULL); \
>> +            release_sock(sk);                                 \
>> +        }                                                         \
>> +        __ret;                                                    \
>> +    } >
>>   /* BPF_CGROUP_INET4_BIND and BPF_CGROUP_INET6_BIND can return extra flags
>>    * via upper bits of return code. The only flag that is supported
>>    * (at bit position 0) is to indicate CAP_NET_BIND_SERVICE capability check
>>    * should be bypassed (BPF_RET_BIND_NO_CAP_NET_BIND_SERVICE).
>>    */
>> -#define BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr, atype, 
>> bind_flags)           \
>> -({                                           \
>> -    u32 __flags = 0;                               \
>> -    int __ret = 0;                                   \
>> -    if (cgroup_bpf_enabled(atype))    {                       \
>> -        lock_sock(sk);                               \
>> -        __ret = __cgroup_bpf_run_filter_sock_addr(sk, uaddr, atype,     \
>> -                              NULL, &__flags);     \
>> -        release_sock(sk);                           \
>> -        if (__flags & BPF_RET_BIND_NO_CAP_NET_BIND_SERVICE)           \
>> -            *bind_flags |= BIND_NO_CAP_NET_BIND_SERVICE;           \
>> -    }                                       \
>> -    __ret;                                       \
>> -})
>> +#define BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr, uaddrlen, atype,       \
>> +                       bind_flags)                       \
>> +    ({                                                                   \
>> +        u32 __flags = 0;                                             \
>> +        int __ret = 0;                                               \
>> +        if (cgroup_bpf_enabled(atype)) {                             \
>> +            lock_sock(sk);                                       \
>> +            __ret = __cgroup_bpf_run_filter_sock_addr(           \
>> +                sk, uaddr, uaddrlen, atype, NULL, &__flags); \
>> +            release_sock(sk);                                    \
>> +            if (__flags & BPF_RET_BIND_NO_CAP_NET_BIND_SERVICE)  \
>> +                *bind_flags |= BIND_NO_CAP_NET_BIND_SERVICE; \
>> +        }                                                            \
>> +        __ret;                                                       \
>> +    })
> 
> 
> Some comments on review logistics:
> 
> 1. Other than empty commit message, please add 'Sign-off-by:'.
> It is likely one of the red ERROR that the ./script/checkpatch.pl script will 
> complain.  This patch set was quickly put into 'Changes Requested' status:
> https://patchwork.kernel.org/project/netdevbpf/patch/20221210193559.371515-2-daan.j.demeyer@gmail.com/
> 
> Documentation/process/submitting-patches.rst
> and Documentation/bpf/bpf_devel_QA.rst have useful details.
> 
> 
> 2. Please avoid unnecessary indentation changes like the above 
> BPF_CGROUP_RUN_XXX macros.  It makes the review much harder, eg. which line has 
> the real change?
> 
>>   #define BPF_CGROUP_PRE_CONNECT_ENABLED(sk)                       \
>>       ((cgroup_bpf_enabled(CGROUP_INET4_CONNECT) ||               \
>>         cgroup_bpf_enabled(CGROUP_INET6_CONNECT)) &&               \
>>        (sk)->sk_prot->pre_connect)
>> -#define BPF_CGROUP_RUN_PROG_INET4_CONNECT(sk, uaddr)                   \
>> -    BPF_CGROUP_RUN_SA_PROG(sk, uaddr, CGROUP_INET4_CONNECT)
>> +#define BPF_CGROUP_RUN_PROG_INET4_CONNECT(sk, uaddr, uaddrlen)               \
>> +    BPF_CGROUP_RUN_SA_PROG(sk, uaddr, uaddrlen, CGROUP_INET4_CONNECT)
>> -#define BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr)                   \
>> -    BPF_CGROUP_RUN_SA_PROG(sk, uaddr, CGROUP_INET6_CONNECT)
>> +#define BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr, uaddrlen)               \
>> +    BPF_CGROUP_RUN_SA_PROG(sk, uaddr, uaddrlen, CGROUP_INET6_CONNECT)
>> -#define BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr)               \
>> -    BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, CGROUP_INET4_CONNECT, NULL)
>> +#define BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr, uaddrlen)           \
>> +    BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_INET4_CONNECT, NULL)
>> -#define BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr)               \
>> -    BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, CGROUP_INET6_CONNECT, NULL)
>> +#define BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr, uaddrlen)           \
>> +    BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_INET6_CONNECT, NULL)
>> -#define BPF_CGROUP_RUN_PROG_UDP4_SENDMSG_LOCK(sk, uaddr, t_ctx)               \
>> -    BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, CGROUP_UDP4_SENDMSG, t_ctx)
>> +#define BPF_CGROUP_RUN_PROG_UDP4_SENDMSG_LOCK(sk, uaddr, uaddrlen, 
>> t_ctx)       \
>> +    BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UDP4_SENDMSG, t_ctx)
>> -#define BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk, uaddr, t_ctx)               \
>> -    BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, CGROUP_UDP6_SENDMSG, t_ctx)
>> +#define BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk, uaddr, uaddrlen, 
>> t_ctx)       \
>> +    BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UDP6_SENDMSG, t_ctx)
>> -#define BPF_CGROUP_RUN_PROG_UDP4_RECVMSG_LOCK(sk, uaddr)            \
>> -    BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, CGROUP_UDP4_RECVMSG, NULL)
>> +#define BPF_CGROUP_RUN_PROG_UDP4_RECVMSG_LOCK(sk, uaddr, uaddrlen)        \
>> +    BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UDP4_RECVMSG, NULL)
>> -#define BPF_CGROUP_RUN_PROG_UDP6_RECVMSG_LOCK(sk, uaddr)            \
>> -    BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, CGROUP_UDP6_RECVMSG, NULL)
>> +#define BPF_CGROUP_RUN_PROG_UDP6_RECVMSG_LOCK(sk, uaddr, uaddrlen)        \
>> +    BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UDP6_RECVMSG, NULL)
> 
> Can the above changes to the INET[4|6] macro be avoided?  If I read the patch 
> set correctly, the uaddrlen is not useful for INET.
> 
> [ ... ]
> 
>> diff --git a/include/linux/filter.h b/include/linux/filter.h
>> index bf701976056e..510cf4042f8b 100644
>> --- a/include/linux/filter.h
>> +++ b/include/linux/filter.h
>> @@ -1294,6 +1294,7 @@ struct bpf_sock_addr_kern {
>>        */
>>       u64 tmp_reg;
>>       void *t_ctx;    /* Attach type specific context. */
>> +    int *uaddrlen;
> 
> If I read this patch 2, 3, and 5 right, the newly added "int *uaddrlen" allows 
> the bpf prog to specify the length of the kernel address "struct sockaddr 
> *uaddr" in bpf_sock_addr_kern.  This feels a bit unease for potential memory 
> related issue.  I saw patch 5 added some new unix_validate_addr(sunaddr, 
> addr_len) in a few places after the prog is run.  How about the existing INET 
> cases?  It doesn't make sense to allow the prog changing the INET[4|6] addrlen. 
> Ignoring the change for INET in the kernel also feels wrong.  Checking in the 
> kernel after the bpf prog run also seems too late and there are many grounds to 
> audit for the INET[4|6] alone.  I think all of these seems crying for a new 
> kfunc to set the uaddr and uaddrlen together.  The kfunc can check for incorrect 
> addrlen and directly return error to the bpf prog.  Something like this:
> 
> int bpf_sock_addr_set(struct bpf_sock_addr_kern *sa_kern,
>          const struct sockaddr *addr, u32 addrlen__sz);
> 
> This kfunc should work for INET also.  Documentation/bpf/kfuncs.rst has some 
> details and net/netfilter/nf_conntrack_bpf.c has some kfunc examples that use a 
> similar "__sz" arg.
> 
> Also, there are some recent advancements in bpf. Instead of adding a "int *" 
> pointer, I would suggest to directly add the value "u32 uaddrlen" to the struct 
> bpf_sock_addr"_kern" instead.  Then
> 
> SEC("cgroup/bindun")
> int bind_un_prog(struct bpf_sock_addr *ctx)
> {
>      struct bpf_sock_addr_kern *sa_kern;
>      struct sockaddr_un *unaddr;
>      u32 unaddrlen;
> 
>      sa_kern = bpf_cast_to_kern_ctx(ctx);
>      unaddrlen = sa_kern->uaddrlen;
>      unaddr = bpf_rdonly_cast(sa_kern->uaddr,
>                  bpf_core_type_id_kernel(struct sockaddr_un));
> 
>      /* Read unaddr->sun_path here */
> }
> 
> 
> In above, sa_kern and unaddr are read only. Let the CO-RE do the job instead and 
> no need to do the conversion in convert_ctx_access().  Together with the 
> bpf_sock_addr_set() kfunc which takes care of the WRITE, the changes in 
> convert_ctx_access() and is_valid_access() should not be needed.   There is also 
> no need to add new field "user_path[108]" and "user_addrlen" to the uapi's 
> "struct bpf_sock_addr".

I just noticed patch 5 has checked on INET for writing to "user_addrlen", my bad 
for overlook.  However, the other points still stand for kfunc, 
bpf_cast_to_kern_ctx(), and bpf_rdonly_cast(). eg. a kfunc interface that works 
for INET, UNIX and potentially other AF_* in the future, check incorrect addrlen 
at the kfunc, no changes to convert_ctx_access() and the uapi.

