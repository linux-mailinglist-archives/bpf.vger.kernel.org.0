Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DF66B6FF8
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 08:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjCMHRa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 03:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjCMHRa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 03:17:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C58135
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 00:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678691793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZS47TiD/MGgVp/mbScCggZptTv/f6Vp5N1B2fdXqpIQ=;
        b=eLUJ0ydeadcAJnt9H4mZqFc4UmOIVVUvkhHgyx4D3u7/Of+05xTvEIFFFRu2i7yOdFhMmp
        D94Sqn4TTEzHr2J58EiGCMqqqVyAIzOlXXX5WK5NlJL1uHGw8Jd2zodUBQ2ZfSRVhJJwvR
        5EByXVZoEDGHhWk1qEvE8/6csjS3TPM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-E0hgzBwUPfa0iw1aYyt3_A-1; Mon, 13 Mar 2023 03:16:32 -0400
X-MC-Unique: E0hgzBwUPfa0iw1aYyt3_A-1
Received: by mail-ed1-f70.google.com with SMTP id e18-20020a056402191200b004fa702d64b3so6069072edz.23
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 00:16:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678691791;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZS47TiD/MGgVp/mbScCggZptTv/f6Vp5N1B2fdXqpIQ=;
        b=D+5FeQL1yZaptP3CvGW8KSMgyE0GgZIMukdTDZXcGyukqrtCE7P54LZZyRtOMQz5kC
         +1Y7PN4y8u5+DvdEEZq58asH7TP1JynOFVcVjFhc+5arw85OPZI0i4BmqGJcwA2SyyTa
         CniNXE6ecHSU0VsLt21OoIXZ9madSq6Ia+pIe7IMj1r/aa2+G0PgtRnT2cKRB8TTw2o+
         9ARU4+wfNedalugcS5mZhWW7DhO6tmQ5vWjY+G89Fi4y+8diqCKc1E2fk8nUnAzeoTjO
         TJtNOOBHleOQFL4ec33Ws4foOjoE6Iq4fegeRZcXTKe2XL1LzxAuet9YuqlIre1aNcjj
         F2oQ==
X-Gm-Message-State: AO0yUKXXjPvUyrVTtW3rCHom9dCyy5K83ZVJ09ixTVZVGCdykWrAQhlt
        f4mvJguS1QHf9Yxwnj3AMTCLcZPkSIrAubsq/MnaH+77e9YK1f0noVPbNWPPUDruJf8qUlELopd
        RVBv41ZlkIWA=
X-Received: by 2002:a17:906:3044:b0:8af:2f5e:93e3 with SMTP id d4-20020a170906304400b008af2f5e93e3mr10186590ejd.29.1678691791612;
        Mon, 13 Mar 2023 00:16:31 -0700 (PDT)
X-Google-Smtp-Source: AK7set90kZRAgbUuuodrlErpD1jVyGtOjnJwjnuEStRA9ZVXVURvGGzZzx24xJhbJzi6gHgZIaqNzw==
X-Received: by 2002:a17:906:3044:b0:8af:2f5e:93e3 with SMTP id d4-20020a170906304400b008af2f5e93e3mr10186564ejd.29.1678691791329;
        Mon, 13 Mar 2023 00:16:31 -0700 (PDT)
Received: from [192.168.0.159] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id hv14-20020a17090760ce00b0092973e209f2sm884816ejc.109.2023.03.13.00.16.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 00:16:31 -0700 (PDT)
Message-ID: <70b77670-43d5-ff38-abfe-3379cc54a82e@redhat.com>
Date:   Mon, 13 Mar 2023 08:16:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next v10 1/2] bpf: Fix attaching
 fentry/fexit/fmod_ret/lsm to modules
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        linux-modules@vger.kernel.org,
        Nick Alcock <nick.alcock@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>
References: <cover.1678432753.git.vmalik@redhat.com>
 <3f6a9d8ae850532b5ef864ef16327b0f7a669063.1678432753.git.vmalik@redhat.com>
 <ZAuB/cnEsPt0f0vb@bombadil.infradead.org>
From:   Viktor Malik <vmalik@redhat.com>
In-Reply-To: <ZAuB/cnEsPt0f0vb@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/10/23 20:16, Luis Chamberlain wrote:
> Please add linux-modules in the future. My review below.

Sorry for missing that, I'll add it next time.

> 
> On Fri, Mar 10, 2023 at 08:40:59AM +0100, Viktor Malik wrote:

[snip]

> My review of the critical part below.
> 
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 45a082284464..3905bb20b9a1 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -18432,8 +18434,17 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>>   			else
>>   				addr = (long) tgt_prog->aux->func[subprog]->bpf_func;
>>   		} else {
>> -			addr = kallsyms_lookup_name(tname);
>> +			if (btf_is_module(btf)) {
>> +				mod = btf_try_get_module(btf);
>> +				if (mod)
>> +					addr = find_kallsyms_symbol_value(mod, tname);
>> +				else
>> +					addr = 0;
>> +			} else {
>> +				addr = kallsyms_lookup_name(tname);
>> +			}
>>   			if (!addr) {
>> +				module_put(mod);
>>   				bpf_log(log,
>>   					"The address of function %s cannot be found\n",
>>   					tname);
> 
> If btf_modules linked list is ensured to not remove the btf module
> during this operation, sure this is safe, as per the new guidelines I've
> posted for try_module_get() this seems to be using try_module_get()
> using the implied protection.

I believe that is the case. btf_try_get_module checks the
BTF_F_MODULE_LIVE flag before calling try_module_get and the flag is set
only when the module notifier callback is called with MODULE_STATE_LIVE.
In addition, all BTF module operations are called under the same mutex,
so the module cannot be removed in-between.

> 
> Please review the docs. *If* it respects that usage then feel free to
> add:
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

Thanks for the review. Unless there are more change requests, I'll leave
it up to the maintainers to add the tag.

Viktor

> 
>    Luis
> 

