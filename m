Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8315E64B33F
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 11:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbiLMK2t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 05:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235174AbiLMK2J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 05:28:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66D31CB10
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 02:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670927236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/RnrIONfcBSB+Ffxxn20F/KkXlSqJsKbYrRuUDkO6bc=;
        b=cZfUlhCy0RQs/lGad1WMuMhygZojd3XMarYLLfPIWpBf+tCoIl+uaYO0f08zyVel2ollvo
        q2Ft35TlDmYWAGRUL5kw7ji5BIQCM6muu9cFYEzE2LgxhpWznuNQegyEabN1yqR64qlpyi
        /UgwF944zXELwOyjiIcp6V6Ca7Vcl4A=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-250-jZBzqAIaNzynCeAi8m2zgw-1; Tue, 13 Dec 2022 05:27:14 -0500
X-MC-Unique: jZBzqAIaNzynCeAi8m2zgw-1
Received: by mail-ed1-f72.google.com with SMTP id j11-20020aa7c40b000000b0046b45e2ff83so6890806edq.12
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 02:27:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/RnrIONfcBSB+Ffxxn20F/KkXlSqJsKbYrRuUDkO6bc=;
        b=ezvYTx2+lZMmb1UsS7HNjxsQ4pNpn2Bxs5elUFkSHKekMxk4ncIp0iYIbo5u1H3Gd7
         w3gmjRmCkMpZRyKlC6vHynVneY7xwFVj6INq5gifnG5s5J7lV+TJsi82RGntVh584cx5
         OKAV/7y71j3A6xZcz2ZsARVHE4kt5m+2hCrn4cAzDrlSzgqUcUljtwQrDRT2O88lqEbb
         +ADPCM15W0JC5F/P65V4jhMnidcimv9hvhByY/xclBaCdNjCN+bK4U29H4D51X46Q4NH
         DxqOt+pRbz9/DO+S463RYAendfsewRJw7K+glf+0xeih5gIAzKlSXCSDKAMJ+ifahJ0f
         qtWw==
X-Gm-Message-State: ANoB5pmeXOiOHdVNbkh4vJXhs4/CnaVbPnmP0La+9CJG/ZBKqZNTByJe
        +lXQT92biL25ZzhE76VdXMk7TJBE+Dw8iwWP0buzDM532e3b7mHGmEHpa++UzkeOyXYhpDVmgai
        NOJq0gwgFhjKFcC8pmeOJTuBrIgkbkXJmES/Ms6ubK7mFyx9G+R733QpwWR+D
X-Received: by 2002:a17:906:84a:b0:7c1:7145:5b3c with SMTP id f10-20020a170906084a00b007c171455b3cmr6236769ejd.46.1670927233603;
        Tue, 13 Dec 2022 02:27:13 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6uIcCX7ZSR439R7ad3/NTnWYJ6D8fBXEoOKPYRkyQbobATUUpc4l1IlWnwlKcbF6YqUhuHkg==
X-Received: by 2002:a17:906:84a:b0:7c1:7145:5b3c with SMTP id f10-20020a170906084a00b007c171455b3cmr6236741ejd.46.1670927233298;
        Tue, 13 Dec 2022 02:27:13 -0800 (PST)
Received: from [172.20.10.11] (78-80-28-214.customers.tmcz.cz. [78.80.28.214])
        by smtp.gmail.com with ESMTPSA id 4-20020a170906328400b007aed2057ea1sm4339849ejw.167.2022.12.13.02.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 02:27:12 -0800 (PST)
Message-ID: <3df56cb1-6565-2618-b9cc-be33bf9e9fa4@redhat.com>
Date:   Tue, 13 Dec 2022 11:27:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Fix attaching
 fentry/fexit/fmod_ret/lsm to modules
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <cover.1670847888.git.vmalik@redhat.com>
 <d4a7235586e3ca1b667f220de7b4835a1382397c.1670847888.git.vmalik@redhat.com>
Content-Language: en-US
From:   Viktor Malik <vmalik@redhat.com>
In-Reply-To: <d4a7235586e3ca1b667f220de7b4835a1382397c.1670847888.git.vmalik@redhat.com>
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

On 12/12/22 13:59, Viktor Malik wrote:
> When attaching fentry/fexit/fmod_ret/lsm to a function located in a
> module without specifying the target program, the verifier tries to find
> the address to attach to in kallsyms. This is always done by searching
> the entire kallsyms, not respecting the module in which the function is
> located.
> 
> This approach causes an incorrect attachment address to be computed if
> the function to attach to is shadowed by a function of the same name
> located earlier in kallsyms.
> 
> Since the attachment must contain the BTF of the program to attach to,
> we may extract the module from it and search for the function address in
> the module.
> 
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
>   kernel/bpf/verifier.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a5255a0dcbb6..d646c5263bc5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -24,6 +24,7 @@
>   #include <linux/bpf_lsm.h>
>   #include <linux/btf_ids.h>
>   #include <linux/poison.h>
> +#include "../module/internal.h"

Looks like there's a number of errors reported by test robot due to
including "../module/internal.h" (mostly unrelated to this patchset).
I'm not sure how to approach those - move find_kallsyms_symbol_value to
include/linux/module.h or just ignore the errors?

For both cases, a trivial find_kallsyms_symbol_value for
!CONFIG_KALLSYMS will be necessary.

>   
>   #include "disasm.h"
>   
> @@ -16478,6 +16479,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>   	const char *tname;
>   	struct btf *btf;
>   	long addr = 0;
> +	struct module *mod;
>   
>   	if (!btf_id) {
>   		bpf_log(log, "Tracing programs must provide btf_id\n");
> @@ -16645,7 +16647,19 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>   			else
>   				addr = (long) tgt_prog->aux->func[subprog]->bpf_func;
>   		} else {
> -			addr = kallsyms_lookup_name(tname);
> +			if (btf_is_module(btf)) {
> +				preempt_disable();
> +				mod = btf_try_get_module(btf);
> +				if (mod) {
> +					addr = find_kallsyms_symbol_value(mod, tname);
> +					module_put(mod);
> +				} else {
> +					addr = 0;
> +				}
> +				preempt_enable();
> +			} else {
> +				addr = kallsyms_lookup_name(tname);
> +			}
>   			if (!addr) {
>   				bpf_log(log,
>   					"The address of function %s cannot be found\n",

