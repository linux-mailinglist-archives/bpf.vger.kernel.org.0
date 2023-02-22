Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DF569EF1B
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 08:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjBVHIc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 02:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjBVHIb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 02:08:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE88F2122
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 23:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677049668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nbKsdZx6cyQMcUZLX1wAuD7vcttcYvZxCKvh2HJTynQ=;
        b=Zq29TvIPKFlVX5dnbtXyveqC1D2gtGderm6e+d4r5vviIdRfDu1cCpn2+7QKdNM9utsOF4
        xEXIWUCKk66JkUwKEI5w1pEpNvQYFoGaiUxwHSdXCVDV5cRGcRUDkLKJfoh0gNd4KPPzZ1
        pwjFn5aeS/rKIDa5dYlECmGJJtMKB5E=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-106-kor_y-_aM_S8hFumyToh3Q-1; Wed, 22 Feb 2023 02:07:47 -0500
X-MC-Unique: kor_y-_aM_S8hFumyToh3Q-1
Received: by mail-ed1-f69.google.com with SMTP id h13-20020a0564020e8d00b004a26ef05c34so8938732eda.16
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 23:07:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nbKsdZx6cyQMcUZLX1wAuD7vcttcYvZxCKvh2HJTynQ=;
        b=trYscj55YIN6GvgmFr6cKe/fyCvViTWtwfWtoQ12hAOrOewdfDpUIYB7nExokP5Ss2
         NjrkgyTi25APwnxu7YXILOoya/rBafrWYOpkTQUM9y87fSDq13/i9Fl5slvGKeoREbbK
         4LhSl8uoVVLZ8tkUl7WgdwfiiWMVBIceN1Y6ERjUgK3eR+T9QIqZRaZKPEqhG0rEdXYP
         KUZDUN/gIFbz9REywu5q+ANbGSIA9/w0NuprDIHE54oFAdgrkxXhlP+8cp74w6LMcJI3
         0lWXVLy/wHDrxwJWszjzI0CQ/rlGAA9b4mijEyZrPKuzPLM7AUCb2s78ZlFy0TPhSgy2
         3Q9g==
X-Gm-Message-State: AO0yUKVjtz2TEJH9XIrFXuiJClAYvs7VDdNSctZE4rdtG4Xog0V9M41/
        J/wpMm6ivPthLB8aCfof14Er3RcmrJVwGvmAQfmDu4ExzOui2N+hZA/XEJgzmL6zvM82FmVXdos
        3rw95EHOFPwnkz2Bigi0=
X-Received: by 2002:aa7:c518:0:b0:4ad:1e35:771f with SMTP id o24-20020aa7c518000000b004ad1e35771fmr7936820edq.35.1677049666355;
        Tue, 21 Feb 2023 23:07:46 -0800 (PST)
X-Google-Smtp-Source: AK7set8QQ+yjK0oMUA4FAV4rJkFgNq0A+VEHn40AzygNIJqov7uhaumfAvS8MGJUDfP2lauKIB9T7g==
X-Received: by 2002:aa7:c518:0:b0:4ad:1e35:771f with SMTP id o24-20020aa7c518000000b004ad1e35771fmr7936808edq.35.1677049665995;
        Tue, 21 Feb 2023 23:07:45 -0800 (PST)
Received: from ?IPV6:2001:67c:1220:8b4:fc:5b35:3b22:9bb9? ([2001:67c:1220:8b4:fc:5b35:3b22:9bb9])
        by smtp.gmail.com with ESMTPSA id jx14-20020a170907760e00b008cc920469b5sm4277459ejc.18.2023.02.21.23.07.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 23:07:45 -0800 (PST)
Message-ID: <8f4c902a-8dd2-1a5b-bc4f-f527b4f1c5f5@redhat.com>
Date:   Wed, 22 Feb 2023 08:07:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next v7 1/2] bpf: Fix attaching
 fentry/fexit/fmod_ret/lsm to modules
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
References: <cover.1676888953.git.vmalik@redhat.com>
 <ea9d4a1d140a78b2216f41020375fda604107162.1676888953.git.vmalik@redhat.com>
 <Y/TgeuA579/zzikg@krava>
Content-Language: en-US
From:   Viktor Malik <vmalik@redhat.com>
In-Reply-To: <Y/TgeuA579/zzikg@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/21/23 16:17, Jiri Olsa wrote:
> On Mon, Feb 20, 2023 at 11:42:52AM +0100, Viktor Malik wrote:
> 
> SNIP
> 
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 388245e8826e..6da830df3ea5 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -24,6 +24,7 @@
>>   #include <linux/bpf_lsm.h>
>>   #include <linux/btf_ids.h>
>>   #include <linux/poison.h>
>> +#include "../module/internal.h"
>>   
>>   #include "disasm.h"
>>   
>> @@ -16868,6 +16869,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>>   	const char *tname;
>>   	struct btf *btf;
>>   	long addr = 0;
>> +	struct module *mod = NULL;
>>   
>>   	if (!btf_id) {
>>   		bpf_log(log, "Tracing programs must provide btf_id\n");
>> @@ -17041,7 +17043,15 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
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
> 
> there are some error paths below this point which I think we could
> hit also for module id/address, so we need to put the mod ref

Right, I didn't notice those, thanks. I'll fix that.

> 
> also there's bpf_trampoline_link_cgroup_shim caller of
> bpf_check_attach_target, but I'm not sure that could endup with
> id/address in module code

I did check this and IIUC, this is for BPF_LSM_CGROUP programs and
bpf_lsm_* hooks are always placed in vmlinux, so this shouldn't occur.

Viktor

> 
> jirka
> 
>>   			if (!addr) {
>>   				bpf_log(log,
>>   					"The address of function %s cannot be found\n",
>> @@ -17105,6 +17115,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>>   	tgt_info->tgt_addr = addr;
>>   	tgt_info->tgt_name = tname;
>>   	tgt_info->tgt_type = t;
>> +	tgt_info->tgt_mod = mod;
>>   	return 0;
>>   }
>>   
>> @@ -17184,6 +17195,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
>>   	/* store info about the attachment target that will be used later */
>>   	prog->aux->attach_func_proto = tgt_info.tgt_type;
>>   	prog->aux->attach_func_name = tgt_info.tgt_name;
>> +	prog->aux->mod = tgt_info.tgt_mod;
>>   
>>   	if (tgt_prog) {
>>   		prog->aux->saved_dst_prog_type = tgt_prog->type;
>> diff --git a/kernel/module/internal.h b/kernel/module/internal.h
>> index 2e2bf236f558..5cb103a46018 100644
>> --- a/kernel/module/internal.h
>> +++ b/kernel/module/internal.h
>> @@ -256,6 +256,11 @@ static inline bool sect_empty(const Elf_Shdr *sect)
>>   static inline void init_build_id(struct module *mod, const struct load_info *info) { }
>>   static inline void layout_symtab(struct module *mod, struct load_info *info) { }
>>   static inline void add_kallsyms(struct module *mod, const struct load_info *info) { }
>> +static inline unsigned long find_kallsyms_symbol_value(struct module *mod
>> +						       const char *name)
>> +{
>> +	return 0;
>> +}
>>   #endif /* CONFIG_KALLSYMS */
>>   
>>   #ifdef CONFIG_SYSFS
>> -- 
>> 2.39.1
>>
> 

