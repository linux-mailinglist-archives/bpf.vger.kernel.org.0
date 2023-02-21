Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3697769E32F
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 16:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbjBUPRU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 10:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbjBUPRU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 10:17:20 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7D32A9AE
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 07:17:18 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id b12so18552446edd.4
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 07:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BirKcUPaoEZP4j3IE8EVYnH1uKMvuZFg7dvD3Be4BDU=;
        b=fI34mOjC6DMmYRHuupmT4xgPvMSnXy5IkyWG1U55l2KUgx/qF5Is6F5gjmT8Il+W2V
         kW32M4Q5iwjio7Cb+m/w001JYVhBr3h0nCxVGDhio0sFMnkk188LZ0pORg4h55rARU3Q
         Jj8kJWDJnrXCNPiZVZ7EeVyQ4af89Qwa6obm+a5nbKpkZgKuSmvycW7XbB+UUcbVUtTM
         Dg+d3e7Bg4mIV31LDBn+C09GxfwqNnG0xgkrZVOi4rV6iIwh6doUq8dvmMpfGv3/JhEO
         JFCPaQpkJs6f7lIp2gXhnDP5+SsalxgIS3kCQ5QuuD8vXBLJ30JjwGkIdDUFSjLWafCw
         nwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BirKcUPaoEZP4j3IE8EVYnH1uKMvuZFg7dvD3Be4BDU=;
        b=eR6albL0QgJc8WeTk0T+lwzZnLynnXB3c1hzbVIxjxKOrWUDEHA4DXvu3yKuXN4xQH
         yUOZ0bswEBQUbYyHK+5dpRvkEoKqn2t0aTvTW/wUVcJE8fsW+vGVKvsa7OAld34QelTa
         6tDOHwJltIRYGmXGHB7MbAsXN9CBBA+5R2gB6xjT5TjmY9aFw+Y3p8x0cHlq0BBlZjiS
         Miw8dBJK2UKQ+AGc8lCxpUnoiyTA2Qun19AFP5BijawEV3eRaIvINpd8qxFLygS5MExo
         uhu+itBvp58Nr17mw8L+RRIrNux5Eu2OeLXaruJqXjOvm7YZiKFXCfJAnn7fisLMb/Om
         6/qg==
X-Gm-Message-State: AO0yUKXNOMi69vDMQKA/kZZjT3CGClHkAi08897OLxavWP7HQnHsxdhU
        aRD/rWQ6ToeDYzxdfnWGHL4=
X-Google-Smtp-Source: AK7set9yjD9uS05uGrq/seHm8QtQLUcjbbI467I2nGuySn3mJavYipO9qlDTfnSOdeTI3lkrA+1v/w==
X-Received: by 2002:a17:906:261b:b0:8aa:c105:f0bf with SMTP id h27-20020a170906261b00b008aac105f0bfmr13459538ejc.17.1676992637271;
        Tue, 21 Feb 2023 07:17:17 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id g13-20020a056402090d00b004acbda55f6bsm1374576edz.27.2023.02.21.07.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 07:17:16 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 21 Feb 2023 16:17:14 +0100
To:     Viktor Malik <vmalik@redhat.com>
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
Subject: Re: [PATCH bpf-next v7 1/2] bpf: Fix attaching
 fentry/fexit/fmod_ret/lsm to modules
Message-ID: <Y/TgeuA579/zzikg@krava>
References: <cover.1676888953.git.vmalik@redhat.com>
 <ea9d4a1d140a78b2216f41020375fda604107162.1676888953.git.vmalik@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea9d4a1d140a78b2216f41020375fda604107162.1676888953.git.vmalik@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 20, 2023 at 11:42:52AM +0100, Viktor Malik wrote:

SNIP

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 388245e8826e..6da830df3ea5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -24,6 +24,7 @@
>  #include <linux/bpf_lsm.h>
>  #include <linux/btf_ids.h>
>  #include <linux/poison.h>
> +#include "../module/internal.h"
>  
>  #include "disasm.h"
>  
> @@ -16868,6 +16869,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  	const char *tname;
>  	struct btf *btf;
>  	long addr = 0;
> +	struct module *mod = NULL;
>  
>  	if (!btf_id) {
>  		bpf_log(log, "Tracing programs must provide btf_id\n");
> @@ -17041,7 +17043,15 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  			else
>  				addr = (long) tgt_prog->aux->func[subprog]->bpf_func;
>  		} else {
> -			addr = kallsyms_lookup_name(tname);
> +			if (btf_is_module(btf)) {
> +				mod = btf_try_get_module(btf);
> +				if (mod)
> +					addr = find_kallsyms_symbol_value(mod, tname);
> +				else
> +					addr = 0;
> +			} else {
> +				addr = kallsyms_lookup_name(tname);
> +			}

there are some error paths below this point which I think we could
hit also for module id/address, so we need to put the mod ref

also there's bpf_trampoline_link_cgroup_shim caller of
bpf_check_attach_target, but I'm not sure that could endup with
id/address in module code

jirka

>  			if (!addr) {
>  				bpf_log(log,
>  					"The address of function %s cannot be found\n",
> @@ -17105,6 +17115,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  	tgt_info->tgt_addr = addr;
>  	tgt_info->tgt_name = tname;
>  	tgt_info->tgt_type = t;
> +	tgt_info->tgt_mod = mod;
>  	return 0;
>  }
>  
> @@ -17184,6 +17195,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
>  	/* store info about the attachment target that will be used later */
>  	prog->aux->attach_func_proto = tgt_info.tgt_type;
>  	prog->aux->attach_func_name = tgt_info.tgt_name;
> +	prog->aux->mod = tgt_info.tgt_mod;
>  
>  	if (tgt_prog) {
>  		prog->aux->saved_dst_prog_type = tgt_prog->type;
> diff --git a/kernel/module/internal.h b/kernel/module/internal.h
> index 2e2bf236f558..5cb103a46018 100644
> --- a/kernel/module/internal.h
> +++ b/kernel/module/internal.h
> @@ -256,6 +256,11 @@ static inline bool sect_empty(const Elf_Shdr *sect)
>  static inline void init_build_id(struct module *mod, const struct load_info *info) { }
>  static inline void layout_symtab(struct module *mod, struct load_info *info) { }
>  static inline void add_kallsyms(struct module *mod, const struct load_info *info) { }
> +static inline unsigned long find_kallsyms_symbol_value(struct module *mod
> +						       const char *name)
> +{
> +	return 0;
> +}
>  #endif /* CONFIG_KALLSYMS */
>  
>  #ifdef CONFIG_SYSFS
> -- 
> 2.39.1
> 
