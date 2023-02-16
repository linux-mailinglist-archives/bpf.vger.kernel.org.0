Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557296997C3
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 15:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjBPOqM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Feb 2023 09:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjBPOqL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 09:46:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2A64BE95
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 06:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676558717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gPevt4h5dMGsd65+VqluT51B69o57J1tfbl8D6j6XwE=;
        b=U2mOpwGkDEXwskkHiIkjFt7WjOlPXrB22n9uglki9m25M/LMvNUTLftrkQXxxo8vCmbbbv
        uZnpVPKeYLhivv7c0azVqZQTrjEI5UvFJREeTdMvuO2ccLhxvqUhvX4gHQb+nsYB1VXTMJ
        6tiCAQh9UHWp0jNMu7OHPFsT/fFDW6o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-544-kDK4wO0JPf2PoeP-EwuWqQ-1; Thu, 16 Feb 2023 09:45:15 -0500
X-MC-Unique: kDK4wO0JPf2PoeP-EwuWqQ-1
Received: by mail-wm1-f71.google.com with SMTP id k17-20020a05600c1c9100b003dd41ad974bso1237198wms.3
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 06:45:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gPevt4h5dMGsd65+VqluT51B69o57J1tfbl8D6j6XwE=;
        b=zDv/c490NRKAjQkgv/c/l/2siB4PrWxE8YsqIz/Hm8Y7hM0m367bTflkXvBHXC1/9K
         mSUKaFkwODd2GhC1IYZZ4LA5uMaga1CHvpsHqz48ha3cS1Wz4R+izwTnHseR4zZUW2nN
         jaZWNKZ37/Tk+xOik5olFKQxBuAHjrmbKI5jC/Gv6B8T3gbjuHtiFZj8OHsxKI4HZoL6
         sPRjpuPbaY0ppOq9k/LvUHPEnXoyM798e31c+eaXIRs08/3H5tauZOmbUJv9eM93am5x
         71TEiY091pEGpE6Sy0HyMuNCHVyAid9DL0BWeI4F7763ouSpP0DMtq9twRpahSBmaGwh
         9GKw==
X-Gm-Message-State: AO0yUKVJM6XU+WDQXbMZW4pgIF3Xz6q8MiaExNlR7c5HvEzXeBMRAcdk
        3LNveFZnJBSlrkMUif3ixNZBucoBGNuPdGEFbK/zcanbCC2GclWFeYRDsFpOTy5wG4YN430l/xV
        XFTIFTP89Vud9oQxaOdQ=
X-Received: by 2002:a05:600c:2e89:b0:3e0:6c4:6a38 with SMTP id p9-20020a05600c2e8900b003e006c46a38mr5332992wmn.33.1676558713520;
        Thu, 16 Feb 2023 06:45:13 -0800 (PST)
X-Google-Smtp-Source: AK7set/1iIBsy5gPvLRp9df3lH6sxKdfvUfOzrdAAMzVWf9lUQVPaER6nYOlR1yC+TCItcAVVX8jTg==
X-Received: by 2002:a05:600c:2e89:b0:3e0:6c4:6a38 with SMTP id p9-20020a05600c2e8900b003e006c46a38mr5332972wmn.33.1676558713188;
        Thu, 16 Feb 2023 06:45:13 -0800 (PST)
Received: from [192.168.0.159] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id k22-20020a05600c0b5600b003e21ba8684dsm547669wmr.26.2023.02.16.06.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 06:45:12 -0800 (PST)
Message-ID: <1992d09a-0ef8-66e3-1da0-5d13c2fecc3d@redhat.com>
Date:   Thu, 16 Feb 2023 15:45:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH bpf-next v6 1/2] bpf: Fix attaching
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
References: <cover.1676542796.git.vmalik@redhat.com>
 <e627742ab86ed28632bc9b6c56ef65d7f98eadbc.1676542796.git.vmalik@redhat.com>
 <Y+40os27pQ8det/o@krava>
From:   Viktor Malik <vmalik@redhat.com>
In-Reply-To: <Y+40os27pQ8det/o@krava>
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

On 2/16/23 14:50, Jiri Olsa wrote:
> On Thu, Feb 16, 2023 at 11:32:41AM +0100, Viktor Malik wrote:
>> This resolves two problems with attachment of fentry/fexit/fmod_ret/lsm
>> to functions located in modules:
>>
>> 1. The verifier tries to find the address to attach to in kallsyms. This
>>     is always done by searching the entire kallsyms, not respecting the
>>     module in which the function is located. Such approach causes an
>>     incorrect attachment address to be computed if the function to attach
>>     to is shadowed by a function of the same name located earlier in
>>     kallsyms.
>>
>> 2. If the address to attach to is located in a module, the module
>>     reference is only acquired in register_fentry. If the module is
>>     unloaded between the place where the address is found
>>     (bpf_check_attach_target in the verifier) and register_fentry, it is
>>     possible that another module is loaded to the same address which may
>>     lead to potential errors.
>>
>> Since the attachment must contain the BTF of the program to attach to,
>> we extract the module from it and search for the function address in the
>> correct module (resolving problem no. 1). Then, the module reference is
>> taken directly in bpf_check_attach_target and stored in the bpf program
>> (in bpf_prog_aux). The reference is only released when the program is
>> unloaded (resolving problem no. 2).
>>
>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>> ---
>>   include/linux/bpf.h      |  1 +
>>   kernel/bpf/syscall.c     |  2 ++
>>   kernel/bpf/trampoline.c  | 27 ---------------------------
>>   kernel/bpf/verifier.c    | 20 +++++++++++++++++++-
>>   kernel/module/internal.h |  5 +++++
>>   5 files changed, 27 insertions(+), 28 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 4385418118f6..2aadc78fe3c1 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1330,6 +1330,7 @@ struct bpf_prog_aux {
>>   	 * main prog always has linfo_idx == 0
>>   	 */
>>   	u32 linfo_idx;
>> +	struct module *mod;
>>   	u32 num_exentries;
>>   	struct exception_table_entry *extable;
>>   	union {
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index cda8d00f3762..5b8227e08182 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -2064,6 +2064,8 @@ static void bpf_prog_put_deferred(struct work_struct *work)
>>   	prog = aux->prog;
>>   	perf_event_bpf_event(prog, PERF_BPF_EVENT_PROG_UNLOAD, 0);
>>   	bpf_audit_prog(prog, BPF_AUDIT_UNLOAD);
>> +	if (aux->mod)
>> +		module_put(aux->mod);
> 
> you can call just module_put, there's != NULL check inside
> 
> also should we call it from __bpf_prog_put_noref instead
> to cover bpf_prog_load error path?

Yes, good point, will do that.

> 
>>   	bpf_prog_free_id(prog);
>>   	__bpf_prog_put_noref(prog, true);
>>   }
>> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
>> index d0ed7d6f5eec..ebb20bf252c7 100644
>> --- a/kernel/bpf/trampoline.c
>> +++ b/kernel/bpf/trampoline.c
>> @@ -172,26 +172,6 @@ static struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
>>   	return tr;
>>   }
>>   
>> -static int bpf_trampoline_module_get(struct bpf_trampoline *tr)
>> -{
>> -	struct module *mod;
>> -	int err = 0;
>> -
>> -	preempt_disable();
>> -	mod = __module_text_address((unsigned long) tr->func.addr);
>> -	if (mod && !try_module_get(mod))
>> -		err = -ENOENT;
>> -	preempt_enable();
>> -	tr->mod = mod;
>> -	return err;
>> -}
>> -
>> -static void bpf_trampoline_module_put(struct bpf_trampoline *tr)
>> -{
>> -	module_put(tr->mod);
>> -	tr->mod = NULL;
>> -}
>> -
>>   static int unregister_fentry(struct bpf_trampoline *tr, void *old_addr)
>>   {
>>   	void *ip = tr->func.addr;
>> @@ -202,8 +182,6 @@ static int unregister_fentry(struct bpf_trampoline *tr, void *old_addr)
>>   	else
>>   		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, old_addr, NULL);
>>   
>> -	if (!ret)
>> -		bpf_trampoline_module_put(tr);
>>   	return ret;
>>   }
>>   
>> @@ -238,9 +216,6 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
>>   		tr->func.ftrace_managed = true;
>>   	}
>>   
>> -	if (bpf_trampoline_module_get(tr))
>> -		return -ENOENT;
>> -
>>   	if (tr->func.ftrace_managed) {
>>   		ftrace_set_filter_ip(tr->fops, (unsigned long)ip, 0, 1);
>>   		ret = register_ftrace_direct_multi(tr->fops, (long)new_addr);
>> @@ -248,8 +223,6 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
>>   		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, NULL, new_addr);
>>   	}
>>   
>> -	if (ret)
>> -		bpf_trampoline_module_put(tr);
>>   	return ret;
>>   }
>>   
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 388245e8826e..6a19bd450558 100644
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
>> @@ -17041,7 +17043,17 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>>   			else
>>   				addr = (long) tgt_prog->aux->func[subprog]->bpf_func;
>>   		} else {
>> -			addr = kallsyms_lookup_name(tname);
>> +			if (btf_is_module(btf)) {
>> +				preempt_disable();
> 
> btf_try_get_module takes mutex, so you can't preempt_disable in here,
> I got this when running the test:
> 
> [  691.916989][ T2585] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:580
> 

Hm, do we even need to preempt_disable? IIUC, preempt_disable is used
in module kallsyms to prevent taking the module lock b/c kallsyms are
used in the oops path. That shouldn't be an issue here, is that correct?

>> +				mod = btf_try_get_module(btf);
>> +				if (mod)
>> +					addr = find_kallsyms_symbol_value(mod, tname);
>> +				else
>> +					addr = 0;
>> +				preempt_enable();
>> +			} else {
>> +				addr = kallsyms_lookup_name(tname);
>> +			}
>>   			if (!addr) {
>>   				bpf_log(log,
>>   					"The address of function %s cannot be found\n",
>> @@ -17105,6 +17117,12 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>>   	tgt_info->tgt_addr = addr;
>>   	tgt_info->tgt_name = tname;
>>   	tgt_info->tgt_type = t;
>> +	if (mod) {
>> +		if (!prog->aux->mod)
>> +			prog->aux->mod = mod;
> 
> can this actually happen? would it be better to have bpf_check_attach_target
> just to take take the module ref and return it in tgt_info->tgt_mod and it'd
> be up to caller to decide what to do with that

Ok, I'll try to do it that way.

Thanks for the review!
Viktor

> 
> thanks,
> jirka
> 
>> +		else
>> +			module_put(mod);
>> +	}
>>   	return 0;
>>   }
>>   
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

