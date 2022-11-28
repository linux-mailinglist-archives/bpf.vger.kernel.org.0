Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F5C63A443
	for <lists+bpf@lfdr.de>; Mon, 28 Nov 2022 10:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiK1JIY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Nov 2022 04:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiK1JII (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Nov 2022 04:08:08 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEAFB845
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 01:07:53 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id e13so14500826edj.7
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 01:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yYpJHsRbtr7pm/4cfusSWyhMSbxQehLo9ZBnDLAHTIc=;
        b=q2KuzV+k30RMto/MxruejOc1CDe9bBX0CziQIrQIZtXdzpmQCjNYOBV5SprO4slUnM
         3E/DQuDqy8lwe94+Jq3nj+VaGuyDC2bqSpZonUtMopDvDlnNPsSpmal0VLM053J4emLx
         y/RP7GcXgYhxItN6CI4KTPbQKkgbBJKfzUF2zHXWo7ZKnvyiTdHa1b8tCvuI4LSSKKYH
         SU1L7yuM1cfqYdVvPROGBuVRc5fI4Xvi4XdPSyqRCLnyCEVAbF7/IEyaGYoOYBE30BgF
         pZEMcW61LGNXb+m1m+3VLGASQHALv4Lg2GmkqpBFsfptlQ9RnoKr/1YasjpFoFYXRYnx
         jiEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYpJHsRbtr7pm/4cfusSWyhMSbxQehLo9ZBnDLAHTIc=;
        b=aKCOfo06pvOU2EUlkXEK2H4uS6l50uYjor8iF4P/bELlFdSWlspVxcKtpoYGNXJC7h
         5sJMN5wl/G443rEI5u1NLebyn37PTucmXw8UUg9S1OgBZD6S2AIB9Zaz87MsOdn0BjWi
         CN6CjuoDzGuohsFizUq3xZnmUigkMvzki0H80BSG5HuKMrc65BO3b2M5Z38EQaBNT5Vi
         Uh4kMbJNLKptZCaeUWugciWp8jK6gQ7uFgFXUHkRuV0taFMLcsHxrTPZ9K9/fqbOQtw4
         KO01c1EIt2qrip3wWuaVe5wdhIc4/C+1ulMX+r9L5NuylsrcdPcYGgCPrg35pgR3Zxup
         Ot9A==
X-Gm-Message-State: ANoB5pkpPrmGi5l9c7xWVz6KhpDj1X6WNI64SBVmI1oD74gU47x7nYRj
        JhdpVqpEaWh9eQTICkRejQQ=
X-Google-Smtp-Source: AA0mqf4yuPs9/XlpwWLwZ0ojSsMcjuV34ULLZQtDPp1IAHSYzHLf45GZGiRYGj7n3n5UGfn3krW7Nw==
X-Received: by 2002:a05:6402:691:b0:46b:c11:9f59 with SMTP id f17-20020a056402069100b0046b0c119f59mr6329527edy.407.1669626471605;
        Mon, 28 Nov 2022 01:07:51 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090629d000b007bee745759bsm1826306eje.20.2022.11.28.01.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 01:07:51 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 28 Nov 2022 10:07:49 +0100
To:     Viktor Malik <vmalik@redhat.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix attaching
 fentry/fexit/fmod_ret/lsm to modules
Message-ID: <Y4R6ZfrhVxsHBD22@krava>
References: <cover.1669216157.git.vmalik@redhat.com>
 <2ec861621e283ba2a54f7e939eafed1c29f77bf4.1669216157.git.vmalik@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ec861621e283ba2a54f7e939eafed1c29f77bf4.1669216157.git.vmalik@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 28, 2022 at 08:26:29AM +0100, Viktor Malik wrote:
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
> we may extract the module name from it (if the attach target is a
> module) and search for the function address in the correct module.
> 
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
>  include/linux/btf.h   | 1 +
>  kernel/bpf/btf.c      | 5 +++++
>  kernel/bpf/verifier.c | 9 ++++++++-
>  3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 9ed00077db6e..bdbf3eb7083d 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -187,6 +187,7 @@ u32 btf_obj_id(const struct btf *btf);
>  bool btf_is_kernel(const struct btf *btf);
>  bool btf_is_module(const struct btf *btf);
>  struct module *btf_try_get_module(const struct btf *btf);
> +const char *btf_module_name(const struct btf *btf);
>  u32 btf_nr_types(const struct btf *btf);
>  bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
>  			   const struct btf_member *m,
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 1a59cc7ad730..211fcbb7649d 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7192,6 +7192,11 @@ bool btf_is_module(const struct btf *btf)
>  	return btf->kernel_btf && strcmp(btf->name, "vmlinux") != 0;
>  }
>  
> +const char *btf_module_name(const struct btf *btf)
> +{
> +	return btf->name;
> +}
> +
>  enum {
>  	BTF_MODULE_F_LIVE = (1 << 0),
>  };
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9528a066cfa5..acbe62a73559 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16343,7 +16343,14 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  			else
>  				addr = (long) tgt_prog->aux->func[subprog]->bpf_func;
>  		} else {
> -			addr = kallsyms_lookup_name(tname);
> +			if (btf_is_module(btf)) {
> +				char tmodname[MODULE_NAME_LEN + KSYM_NAME_LEN + 1];

looks good.. would be nice to have module_kallsyms lookup function that
takes module name and symbol separately so we won't waste stack on that..

especially when module_kallsyms_lookup_name just separates it back again
and does module lookup.. but not sure how much pain it'd be

jirka

> +				snprintf(tmodname, sizeof(tmodname), "%s:%s",
> +					 btf_module_name(btf), tname);
> +				addr = module_kallsyms_lookup_name(tmodname);
> +			}
> +			else
> +				addr = kallsyms_lookup_name(tname);
>  			if (!addr) {
>  				bpf_log(log,
>  					"The address of function %s cannot be found\n",
> -- 
> 2.38.1
> 
