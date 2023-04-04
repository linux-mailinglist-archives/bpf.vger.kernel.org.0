Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD946D5909
	for <lists+bpf@lfdr.de>; Tue,  4 Apr 2023 08:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjDDG5x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Apr 2023 02:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjDDG5w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 02:57:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357E1213E
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 23:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680591428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LSRkfOPeLraZ1digkXy1EqUeeZ7Fh1tnyaIa8yiX/LA=;
        b=aNZQu1smRv/Gv3xb/VTVO5+2ZU6NevsSOJD9KNCYM933TkRtnGiESOYsuCnKGm+fldb4Q3
        zld4fooUfo52wuiD3MLCL16Q197OEUcEJCimysiYV81MWR/QitJjmOLb3xLm3sSnC0UNC2
        vhcR4eEOj34WDeNSyOikUMUheNXpNh0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-UxXSv8agMdOeKsvCztLYdQ-1; Tue, 04 Apr 2023 02:57:05 -0400
X-MC-Unique: UxXSv8agMdOeKsvCztLYdQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41824185A78F;
        Tue,  4 Apr 2023 06:57:04 +0000 (UTC)
Received: from samus.usersys.redhat.com (unknown [10.43.17.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B9ED4492C13;
        Tue,  4 Apr 2023 06:57:01 +0000 (UTC)
Date:   Tue, 4 Apr 2023 08:56:59 +0200
From:   Artem Savkov <asavkov@redhat.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
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
Message-ID: <20230404065659.GA56712@samus.usersys.redhat.com>
References: <20230403220254.2191240-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230403220254.2191240-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Tested-by: Artem Savkov <asavkov@redhat.com>

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

-- 
 Artem

