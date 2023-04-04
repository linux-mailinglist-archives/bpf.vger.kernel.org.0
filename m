Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F456D5636
	for <lists+bpf@lfdr.de>; Tue,  4 Apr 2023 03:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjDDBnj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Apr 2023 21:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjDDBni (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 21:43:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929FDA2;
        Mon,  3 Apr 2023 18:43:37 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Pr9Rq4XSGzSmM3;
        Tue,  4 Apr 2023 09:39:51 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 4 Apr 2023 09:43:34 +0800
Subject: Re: [PATCH bpf-next] kallsyms: Disable preemption for
 find_kallsyms_symbol_value
To:     Jiri Olsa <jolsa@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
CC:     Artem Savkov <asavkov@redhat.com>, <bpf@vger.kernel.org>,
        <linux-modules@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Petr Mladek <pmladek@suse.com>,
        Viktor Malik <vmalik@redhat.com>
References: <20230403220254.2191240-1-jolsa@kernel.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <0ae28022-42fb-b0fd-50e3-63a6d76c8c10@huawei.com>
Date:   Tue, 4 Apr 2023 09:43:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20230403220254.2191240-1-jolsa@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.6 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2023/4/4 6:02, Jiri Olsa wrote:
> Artem reported suspicious RCU usage [1]. The reason is that verifier
> calls find_kallsyms_symbol_value with preemption enabled which will
> trigger suspicious RCU usage warning in rcu_dereference_sched call.
> 
> Disabling preemption in find_kallsyms_symbol_value and adding
> __find_kallsyms_symbol_value function.

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
> Fixes: 31bf1dbccfb0 ("bpf: Fix attaching fentry/fexit/fmod_ret/lsm to modules")
> [1] https://lore.kernel.org/bpf/ZBrPMkv8YVRiWwCR@samus.usersys.redhat.com/
> Reported-by: Artem Savkov <asavkov@redhat.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/module/kallsyms.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
> index ab2376a1be88..bdc911dbcde5 100644
> --- a/kernel/module/kallsyms.c
> +++ b/kernel/module/kallsyms.c
> @@ -442,7 +442,7 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
>  }
>  
>  /* Given a module and name of symbol, find and return the symbol's value */
> -unsigned long find_kallsyms_symbol_value(struct module *mod, const char *name)
> +static unsigned long __find_kallsyms_symbol_value(struct module *mod, const char *name)
>  {
>  	unsigned int i;
>  	struct mod_kallsyms *kallsyms = rcu_dereference_sched(mod->kallsyms);
> @@ -466,7 +466,7 @@ static unsigned long __module_kallsyms_lookup_name(const char *name)
>  	if (colon) {
>  		mod = find_module_all(name, colon - name, false);
>  		if (mod)
> -			return find_kallsyms_symbol_value(mod, colon + 1);
> +			return __find_kallsyms_symbol_value(mod, colon + 1);
>  		return 0;
>  	}
>  
> @@ -475,7 +475,7 @@ static unsigned long __module_kallsyms_lookup_name(const char *name)
>  
>  		if (mod->state == MODULE_STATE_UNFORMED)
>  			continue;
> -		ret = find_kallsyms_symbol_value(mod, name);
> +		ret = __find_kallsyms_symbol_value(mod, name);
>  		if (ret)
>  			return ret;
>  	}
> @@ -494,6 +494,16 @@ unsigned long module_kallsyms_lookup_name(const char *name)
>  	return ret;
>  }
>  
> +unsigned long find_kallsyms_symbol_value(struct module *mod, const char *name)
> +{
> +	unsigned long ret;
> +
> +	preempt_disable();
> +	ret = __find_kallsyms_symbol_value(mod, name);
> +	preempt_enable();
> +	return ret;
> +}
> +
>  int module_kallsyms_on_each_symbol(const char *modname,
>  				   int (*fn)(void *, const char *,
>  					     struct module *, unsigned long),
> 

-- 
Regards,
  Zhen Lei
