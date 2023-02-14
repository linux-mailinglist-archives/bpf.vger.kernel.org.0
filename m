Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F18696006
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 10:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjBNJ7J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 04:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjBNJ6d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 04:58:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4776A5D
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 01:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676368637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=69KpFQyCjgw2OEYcbmmUaqcuWN5XyKc6nXg6RgwzN1o=;
        b=SFU6VpGJG+qi0XynhqyTv+D71QgRUV7Zd/vONKpO5633aQg0QhwsSw79W/qtkP6GXKJIij
        Ncll/p11GD+G2WEYfqiLA9nnyGMSlyTpnmkYm0hl5Sr9RBZs07OzqOoax74Fj0DNLMTmj8
        pnr/+nL9Krp193o0FAdRDS7RQXRy/6w=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-217-YiH22UQmNuGHr2EmvlypYA-1; Tue, 14 Feb 2023 04:57:15 -0500
X-MC-Unique: YiH22UQmNuGHr2EmvlypYA-1
Received: by mail-ej1-f70.google.com with SMTP id jo5-20020a170906f6c500b008b133fc52e9so483164ejb.22
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 01:57:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=69KpFQyCjgw2OEYcbmmUaqcuWN5XyKc6nXg6RgwzN1o=;
        b=y7+4yVuppT5qfIo/3KNEgAT57abItSflijtxeshe2R4VfTgOA7VB8didyZkGRkFdvJ
         MldRP9hVYkcBbAPj1K05LnDcRGes6xYsMk7QPsrY4HgBNkmrd0Onqp8803eLVDuTNklB
         vL6wLtqmhksUefVK03SuiIz4oqd3Pt+1zR3WwGw2S8FL3sCJVkCsEiY0FuqY6jowBt7P
         MmGJQLcf9sxYIk9rolKmtgN03cJjqI286YvDvu3l1xDFg9saTgcejeYfIydDftvkiFIO
         pSDSmifAGYBKwZFz3VRbcXmUouiSS4CVafjpdiAuej6TmHaXkc0b5pIsoFxOuP03JTTi
         Cn4g==
X-Gm-Message-State: AO0yUKUpuQuuQe0tG9DN18TcdTi9ST2CfsXPhJNt/vLVKZzwt2Z2dDAK
        d8idWq0Nmizahh12tKKyWykPTkUBJphvyYXqje/cmwi7uYU3fXn5cdjL7SxkEgU5mo6yDKRS0uE
        j3pdVBC8sRvs=
X-Received: by 2002:a50:9fcc:0:b0:4ac:d2cd:cba9 with SMTP id c70-20020a509fcc000000b004acd2cdcba9mr1156546edf.9.1676368634834;
        Tue, 14 Feb 2023 01:57:14 -0800 (PST)
X-Google-Smtp-Source: AK7set8jgWy5SiKILabNDz7cxPNUPio6a492qq2ZAvLMIzGyF1tzoOyNIkX86JgmEbwf1vgkXAnHlQ==
X-Received: by 2002:a50:9fcc:0:b0:4ac:d2cd:cba9 with SMTP id c70-20020a509fcc000000b004acd2cdcba9mr1156528edf.9.1676368634665;
        Tue, 14 Feb 2023 01:57:14 -0800 (PST)
Received: from [192.168.0.159] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id cx20-20020a05640222b400b004ace62d6eaesm115162edb.57.2023.02.14.01.57.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 01:57:14 -0800 (PST)
Message-ID: <80283a5e-c723-7580-9c8d-3c882f23c92c@redhat.com>
Date:   Tue, 14 Feb 2023 10:57:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH bpf-next v5 1/2] bpf: Fix attaching
 fentry/fexit/fmod_ret/lsm to modules
Content-Language: en-US
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>
References: <cover.1676302508.git.vmalik@redhat.com>
 <14feaab32b06bd76b1689ade6f4709e246a77bbe.1676302508.git.vmalik@redhat.com>
 <Y+qCXoh+HcV5U5S/@krava>
From:   Viktor Malik <vmalik@redhat.com>
In-Reply-To: <Y+qCXoh+HcV5U5S/@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/13/23 19:33, Jiri Olsa wrote:
> On Mon, Feb 13, 2023 at 04:59:58PM +0100, Viktor Malik wrote:
> 
> SNIP
> 
>> @@ -248,8 +223,6 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
>>   		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, NULL, new_addr);
>>   	}
>>   
>> -	if (ret)
>> -		bpf_trampoline_module_put(tr);
>>   	return ret;
>>   }
>>   
>> @@ -719,8 +692,11 @@ int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
>>   
>>   	bpf_lsm_find_cgroup_shim(prog, &bpf_func);
>>   	tr = bpf_trampoline_get(key, &tgt_info);
>> -	if (!tr)
>> +	if (!tr) {
>> +		if (tgt_info.tgt_mod)
>> +			module_put(tgt_info.tgt_mod);
>>   		return  -ENOMEM;
>> +	}
>>   
>>   	mutex_lock(&tr->mutex);
>>   
>> @@ -800,6 +776,14 @@ struct bpf_trampoline *bpf_trampoline_get(u64 key,
>>   		return NULL;
>>   
>>   	mutex_lock(&tr->mutex);
>> +	if (tgt_info->tgt_mod) {
>> +		if (tr->mod)
>> +			/* we already have the module reference, release tgt_info reference */
>> +			module_put(tgt_info->tgt_mod);
>> +		else
>> +			/* take ownership of the module reference */
>> +			tr->mod = tgt_info->tgt_mod;
> 
> this seems tricky, should we take and save module reference in bpf_prog
> struct and release it when the program goes out? IIUC the module for
> which the program was verified for should stay as long as the program
> is loaded

You're right, it makes more sense that the module is associated with the
program, not with the trampoline. So we just save the mod reference into
prog->aux (in bpf_check_attach_target) and release it on bpf_prog_put,
just before the program is freed.

Does that make sense? Anything else to be aware of comes to mind?

Thanks!

Viktor

> 
> jirka
> 
>> +	}
>>   	if (tr->func.addr)
>>   		goto out;
>>   
>> @@ -819,6 +803,10 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
>>   	mutex_lock(&trampoline_mutex);
>>   	if (!refcount_dec_and_test(&tr->refcnt))
>>   		goto out;
>> +	if (tr->mod) {
>> +		module_put(tr->mod);
>> +		tr->mod = NULL;
>> +	}
>>   	WARN_ON_ONCE(mutex_is_locked(&tr->mutex));
>>   
>>   	for (i = 0; i < BPF_TRAMP_MAX; i++)
> 
> SNIP
> 

