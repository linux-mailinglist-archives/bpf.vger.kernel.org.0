Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CD1698304
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 19:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjBOSP6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 13:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjBOSP5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 13:15:57 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A254F3B678
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 10:15:55 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id oa11-20020a17090b1bcb00b002341a2656e5so2666956pjb.1
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 10:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nd6PxmqQtzS2pAu/RzoQORoITkcjoq+50YX0cbCLcGI=;
        b=BgjdwhM0TE/oJ81QCfQ08jeZzmEampoAQxabmMt9IydjeKQcM++JSi08DFhnfdiAro
         SmI5aFI7fZmHmWSzkDZGOW6pwkyeJl+WBE4oYqIoMkjWaDx+e+CCptXqHaZGJVyqDX23
         +CsLnvrUb/AElYXdcYlD8NGP4EEAztB/qY15GxEvesZR6FdhXRvGQLaMolY4fCzMf9E9
         q2fF/vpVs4ou2GVvIQ3CwxQrwBZ4B7i+kShXtpshQLAgdtw97z24f9dxqZUZvWFvYtuX
         S57D6ndrdRlTlXdmaGLvxnwG1zGOQ6T5mjIDeznDFR5IMYL2GOJNDWwUJ9PV5wkZ2YBX
         OAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nd6PxmqQtzS2pAu/RzoQORoITkcjoq+50YX0cbCLcGI=;
        b=JsNlBvijEDZI4pCBWzFPI4GMkYR8kDPKjwI6oOFWstJIlDnjLlnPZS2FKtnA+6ue2t
         bQjg+bzr4aQPK3VSuhx3rpXUsMjf8HhT6jrp7Pjj0VOdhgPWaWoxTYU+Vd3i7KqO2TFa
         Rob8pVPaaYMriiDy0SUowypxKlSbN+kVuy8IPuXsrjRKDx202if8hIpIdh30KH3RIoW8
         QKD5lVllaG2jJB3dNpJL3cyyqApqnq57RAXbkhoisqlFYjHb6OuIZleXMWMP8Uw2sPVi
         0v1+uFnBrg9b0MFhspI9SBD0ZSwMx6FcVUkLlzwZtwghnltlUPZy6wPrKIltF13CBn1B
         zrNw==
X-Gm-Message-State: AO0yUKX+o6kpAwt65GnWdvqcfRJGSc/c+m+oWxLEmFlF8pdRo3vi2nC9
        F2OZ+Q5YDSTbEdHJgSQBrlA=
X-Google-Smtp-Source: AK7set+ORk2ctVkF1gYOc+/N1qc6KQvFKCQ5+64T067SzZi+6OVfMRdXT9U7g1gEg4dY9SmRADUTUg==
X-Received: by 2002:a17:902:d48f:b0:196:5f75:66f9 with SMTP id c15-20020a170902d48f00b001965f7566f9mr3942300plg.63.1676484955082;
        Wed, 15 Feb 2023 10:15:55 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21e8::1452? ([2620:10d:c090:400::5:1af8])
        by smtp.gmail.com with ESMTPSA id ix17-20020a170902f81100b0019a91895cdfsm7671821plb.50.2023.02.15.10.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 10:15:54 -0800 (PST)
Message-ID: <91c8b5e3-ac55-3b01-9904-43587bedd319@gmail.com>
Date:   Wed, 15 Feb 2023 10:15:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH bpf-next 2/7] net: Update an existing TCP congestion
 control algorithm.
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org
References: <20230214221718.503964-1-kuifeng@meta.com>
 <20230214221718.503964-3-kuifeng@meta.com> <Y+xG2DNzFt2Uq+8F@google.com>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <Y+xG2DNzFt2Uq+8F@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 2/14/23 18:43, Stanislav Fomichev wrote:
> On 02/14, Kui-Feng Lee wrote:
>> This feature lets you immediately transition to another congestion
>> control algorithm or implementation with the same name.  Once a name
>> is updated, new connections will apply this new algorithm.
>
>> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
>> ---
>>   include/linux/bpf.h            |  1 +
>>   include/net/tcp.h              |  2 ++
>>   net/bpf/bpf_dummy_struct_ops.c |  6 ++++++
>>   net/ipv4/bpf_tcp_ca.c          |  6 ++++++
>>   net/ipv4/tcp_cong.c            | 39 ++++++++++++++++++++++++++++++++++
>>   5 files changed, 54 insertions(+)
>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 13683584b071..5fe39f56a760 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1450,6 +1450,7 @@ struct bpf_struct_ops {
>>                  void *kdata, const void *udata);
>>       int (*reg)(void *kdata);
>>       void (*unreg)(void *kdata);
>> +    int (*update)(void *kdata, void *old_kdata);
>>       const struct btf_type *type;
>>       const struct btf_type *value_type;
>>       const char *name;
>> diff --git a/include/net/tcp.h b/include/net/tcp.h
>> index db9f828e9d1e..239cc0e2639c 100644
>> --- a/include/net/tcp.h
>> +++ b/include/net/tcp.h
>> @@ -1117,6 +1117,8 @@ struct tcp_congestion_ops {
>
>>   int tcp_register_congestion_control(struct tcp_congestion_ops *type);
>>   void tcp_unregister_congestion_control(struct tcp_congestion_ops 
>> *type);
>> +int tcp_update_congestion_control(struct tcp_congestion_ops *type,
>> +                  struct tcp_congestion_ops *old_type);
>
>>   void tcp_assign_congestion_control(struct sock *sk);
>>   void tcp_init_congestion_control(struct sock *sk);
>> diff --git a/net/bpf/bpf_dummy_struct_ops.c 
>> b/net/bpf/bpf_dummy_struct_ops.c
>> index ff4f89a2b02a..158f14e240d0 100644
>> --- a/net/bpf/bpf_dummy_struct_ops.c
>> +++ b/net/bpf/bpf_dummy_struct_ops.c
>> @@ -222,12 +222,18 @@ static void bpf_dummy_unreg(void *kdata)
>>   {
>>   }
>
>> +static int bpf_dummy_update(void *kdata, void *old_kdata)
>> +{
>> +    return -EOPNOTSUPP;
>> +}
>> +
>>   struct bpf_struct_ops bpf_bpf_dummy_ops = {
>>       .verifier_ops = &bpf_dummy_verifier_ops,
>>       .init = bpf_dummy_init,
>>       .check_member = bpf_dummy_ops_check_member,
>>       .init_member = bpf_dummy_init_member,
>>       .reg = bpf_dummy_reg,
>> +    .update = bpf_dummy_update,
>>       .unreg = bpf_dummy_unreg,
>>       .name = "bpf_dummy_ops",
>>   };
>> diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
>> index 13fc0c185cd9..66ce5fadfe42 100644
>> --- a/net/ipv4/bpf_tcp_ca.c
>> +++ b/net/ipv4/bpf_tcp_ca.c
>> @@ -266,10 +266,16 @@ static void bpf_tcp_ca_unreg(void *kdata)
>>       tcp_unregister_congestion_control(kdata);
>>   }
>
>> +static int bpf_tcp_ca_update(void *kdata, void *old_kdata)
>> +{
>> +    return tcp_update_congestion_control(kdata, old_kdata);
>> +}
>> +
>>   struct bpf_struct_ops bpf_tcp_congestion_ops = {
>>       .verifier_ops = &bpf_tcp_ca_verifier_ops,
>>       .reg = bpf_tcp_ca_reg,
>>       .unreg = bpf_tcp_ca_unreg,
>> +    .update = bpf_tcp_ca_update,
>>       .check_member = bpf_tcp_ca_check_member,
>>       .init_member = bpf_tcp_ca_init_member,
>>       .init = bpf_tcp_ca_init,
>> diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
>> index db8b4b488c31..22fd7c12360e 100644
>> --- a/net/ipv4/tcp_cong.c
>> +++ b/net/ipv4/tcp_cong.c
>> @@ -130,6 +130,45 @@ void tcp_unregister_congestion_control(struct 
>> tcp_congestion_ops *ca)
>>   }
>>   EXPORT_SYMBOL_GPL(tcp_unregister_congestion_control);
>
>> +/* Replace a registered old ca with a new one.
>> + *
>> + * The new ca must have the same name as the old one, that has been
>> + * registered.
>> + */
>> +int tcp_update_congestion_control(struct tcp_congestion_ops *ca, 
>> struct tcp_congestion_ops *old_ca)
>> +{
>> +    struct tcp_congestion_ops *existing;
>> +    int ret = 0;
>> +
>
> [..]
>
>> +    /* all algorithms must implement these */
>> +    if (!ca->ssthresh || !ca->undo_cwnd ||
>> +        !(ca->cong_avoid || ca->cong_control)) {
>> +        pr_err("%s does not implement required ops\n", old_ca->name);
>> +        return -EINVAL;
>> +    }
>> +
>> +    ca->key = jhash(ca->name, sizeof(ca->name), strlen(ca->name));
>
> Can we have this as some common _validate method to avoid copy-paste
> from tcp_register_congestion_control.

Sure!


>
> Or, even better, can we can since function handle both cases?
>
> tcp_register_congestion_control(ca, old_ca);
>     - when old_ca == NULL -> register
>     - when old_ca != NULL -> try to update

We use this function in a lot of different places. To make it easier, I 
added a new function instead of changing the old one.


>
>> +
>> +    spin_lock(&tcp_cong_list_lock);
>> +    existing = tcp_ca_find_key(ca->key);
>> +    if (ca->key == TCP_CA_UNSPEC || !existing || 
>> strcmp(existing->name, ca->name)) {
>> +        pr_notice("%s not registered or non-unique key\n",
>> +              ca->name);
>> +        ret = -EINVAL;
>> +    } else if (existing != old_ca) {
>> +        pr_notice("invalid old congestion control algorithm to 
>> replace\n");
>> +        ret = -EINVAL;
>> +    } else {
>> +        list_del_rcu(&existing->list);
>> +        list_add_tail_rcu(&ca->list, &tcp_cong_list);
>> +        pr_debug("%s updated\n", ca->name);
>> +    }
>> +    spin_unlock(&tcp_cong_list_lock);
>> +
>> +    return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(tcp_update_congestion_control);
>> +
>>   u32 tcp_ca_get_key_by_name(struct net *net, const char *name, bool 
>> *ecn_ca)
>>   {
>>       const struct tcp_congestion_ops *ca;
>> -- 
>> 2.30.2
>
