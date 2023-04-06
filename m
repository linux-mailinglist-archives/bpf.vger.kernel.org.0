Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70686D9B64
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 16:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238806AbjDFO6w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 10:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238037AbjDFO6u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 10:58:50 -0400
X-Greylist: delayed 135 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Apr 2023 07:58:48 PDT
Received: from p3plsmtpa12-05.prod.phx3.secureserver.net (p3plsmtpa12-05.prod.phx3.secureserver.net [68.178.252.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A93FF
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 07:58:48 -0700 (PDT)
Received: from localhost ([82.17.115.212])
        by :SMTPAUTH: with ESMTPA
        id kR2NpiH84M4D0kR2Opjo4C; Thu, 06 Apr 2023 07:56:33 -0700
X-CMAE-Analysis: v=2.4 cv=e/XAC4l/ c=1 sm=1 tr=0 ts=642edda1
 a=9gipVNR6X1CoIeAWHwLoWw==:117 a=9gipVNR6X1CoIeAWHwLoWw==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=j-LfP5YGAAAA:8
 a=vbO1sXcANRiWXQ8qYCMA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=pci6KG57UX3UzFLC8IW4:22
X-SECURESERVER-ACCT: atomlin@atomlin.com
Date:   Thu, 6 Apr 2023 15:56:31 +0100
From:   Aaron Tomlin <atomlin@atomlin.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Artem Savkov <asavkov@redhat.com>, bpf@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Petr Mladek <pmladek@suse.com>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH bpf-next] kallsyms: Disable preemption for
 find_kallsyms_symbol_value
Message-ID: <20230406145631.tzvl27gpue57vwjb@atomlin.usersys.com>
References: <20230403220254.2191240-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230403220254.2191240-1-jolsa@kernel.org>
X-CMAE-Envelope: MS4xfKXuEsFlUg8+zj72Fy94LPDUM+G7/GcUo0VUyGeiHB0huBcYa6+8YIde67+ybixPDk7nQzUNufBvZ0A/UuHsMW3KGQ3JutfWwPIVU/98WPe+0VlLEduI
 vMU/vDrIeJ7z3OJkUjOP5K1HF0Y8TThmTi6mx6Kwxy4OvAexQ9h0B7eKkpBmi8VJc8rJ2kxAVO1iWawzocwQF3Yuk+0E9E33v/nyrA1x7Hmp988VAaPuP1pZ
 +69qm9ZK3M3VgeZFvdlInoabupObPoHVVwifDEWjSbHgSul7O/fuasI2zPD1Nw0ufCd502gH+YyZBfXPpm7BwyCBkHuWTxJcwE+gaHFhj4K8WTGo1S2OE6+y
 bkH3Rk2aD2IQzdkaYOr7tzejQwCr53e2Y6w10yuFmHRLNMT3WFFGL5xCDFUQ0IggJqwyR7HhfkoVfCrAh3UErh0kQxArP3GfDwTfiNLOmbDh8wXkgUEgafim
 XnmSr+Ay80BLqDLWlr0ldmlodYzxs086dyGnncooWmCAKJLTxA9LNDizxtjpZ4OQ9SIqbu2CIokjRdVNC8Ii/vEOSzzEYwSKXUZOQxPWL3bcB7Er4F3ifFTb
 IYaayEXBSU1j8E6IxufqqN6mkX5ahQg/8JwsWsSyztGf6rM/usRBgHmjUVc0QjN+CGwy7mFNFfShIvsYcuHOc+fLJxge++LvGck4ZyCQqBct4fYMqSMHvdt1
 RCSafaj4EBM=
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 04, 2023 at 12:02:54AM +0200, Jiri Olsa wrote:
> Artem reported suspicious RCU usage [1]. The reason is that verifier
> calls find_kallsyms_symbol_value with preemption enabled which will
> trigger suspicious RCU usage warning in rcu_dereference_sched call.
> 
> Disabling preemption in find_kallsyms_symbol_value and adding
> __find_kallsyms_symbol_value function.
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
> -- 
> 2.39.2
> 

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin
