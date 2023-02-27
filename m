Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A166A421A
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 13:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjB0M6a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 07:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjB0M63 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 07:58:29 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6278A6599
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 04:58:28 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id i34so25379442eda.7
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 04:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UQDF+9Bj4qliXG/LhkBTdb8Pm83umkk3FQ3gpgYW4ng=;
        b=DiXu4ULPLtONEHT1Fo8o5zbhADFPEzPd0Ae1ikI+IBpr1USLO7IK7G7hrmuJFxcD5x
         IUB2F+rY9ZG72gYilcubGPAVDJEXLKvc95gMWwjF/Nuw7n8MtUgrZZmvjuO/fDIIFBqP
         +tQ9OmjkejVjF+cQRsiNAX7+bkgtN8H+vq/VkIot/mUvduV2el0LH1Lb56q6hAS60plA
         FSSAIp10eKcRBF4zhvf2VdTZb97NrRua8uCyzkagdsGwbtxtAJ4gyji5Ou0S5V4L0YFF
         loa7U4hTUdHll5ksil+68j1RxL83rnkhJWHuUPOus0mBjZlVCp7qcxSIDbWMwkLrU1S+
         OlXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQDF+9Bj4qliXG/LhkBTdb8Pm83umkk3FQ3gpgYW4ng=;
        b=Qdj1i9sbKui99BJ5rGZXYKZNYrWbhHVbexXIYhm9VThTdICrunJ09iDl8d25yyk/b4
         c+0e4c/Vm4jRUVx8ub5IJ9lQ4ubNOK/54Kk/BOOv7eRWvVctfGl2J6epXOwJnrcC/R4m
         SauiVTujFHJdK7zDw8sP9zwObcE7fwFM7N2+8twrkm4guwTns5P2kxAklE5JzjrAWKZv
         7dF1bjVPCa69GD3EuvNEI/18tWcqoxOhxMQV1+prP/FIeF91JGM2Zftz44QZejD9xXf3
         2lHa75+5a0UWeFHm8wD3aij2MGXf/XK6KTLcOl7S4wUOOomdnvUGiv5Ust/yHJZXKLPL
         DZyw==
X-Gm-Message-State: AO0yUKXULB8E10Vn2o45suoz9uhtpt+vJqA2GU7WPPQV5eDqRdYVRI2k
        24GAv9ip/tdQc0kWo5p1XwI=
X-Google-Smtp-Source: AK7set/XMDBk8ZUgQv3yX/xM273PI2bUBaaOP/yuNyPW37yXuEwB88+LYvVe5hDUs6FER+fFIVRniQ==
X-Received: by 2002:a05:6402:1653:b0:4ae:eab6:9ff8 with SMTP id s19-20020a056402165300b004aeeab69ff8mr33275788edx.13.1677502706702;
        Mon, 27 Feb 2023 04:58:26 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 13-20020a508e0d000000b004af6e957b22sm3129989edw.6.2023.02.27.04.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 04:58:26 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 27 Feb 2023 13:58:23 +0100
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
Subject: Re: [PATCH bpf-next v8 1/2] bpf: Fix attaching
 fentry/fexit/fmod_ret/lsm to modules
Message-ID: <Y/yo76xKRju4y6s3@krava>
References: <cover.1677075137.git.vmalik@redhat.com>
 <56870b3b449a20872dcff09541967a5a46284c0e.1677075137.git.vmalik@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56870b3b449a20872dcff09541967a5a46284c0e.1677075137.git.vmalik@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 22, 2023 at 03:35:28PM +0100, Viktor Malik wrote:

SNIP

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index d0ed7d6f5eec..ebb20bf252c7 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -172,26 +172,6 @@ static struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
>  	return tr;
>  }
>  

nit, I think we can now remove linux/module.h include

jirka

> -static int bpf_trampoline_module_get(struct bpf_trampoline *tr)
> -{
> -	struct module *mod;
> -	int err = 0;
> -
> -	preempt_disable();
> -	mod = __module_text_address((unsigned long) tr->func.addr);
> -	if (mod && !try_module_get(mod))
> -		err = -ENOENT;
> -	preempt_enable();
> -	tr->mod = mod;
> -	return err;
> -}
> -
> -static void bpf_trampoline_module_put(struct bpf_trampoline *tr)
> -{
> -	module_put(tr->mod);
> -	tr->mod = NULL;
> -}
> -
>  static int unregister_fentry(struct bpf_trampoline *tr, void *old_addr)
>  {
>  	void *ip = tr->func.addr;
> @@ -202,8 +182,6 @@ static int unregister_fentry(struct bpf_trampoline *tr, void *old_addr)
>  	else
>  		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, old_addr, NULL);
>  
> -	if (!ret)
> -		bpf_trampoline_module_put(tr);
>  	return ret;
>  }
>  
> @@ -238,9 +216,6 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
>  		tr->func.ftrace_managed = true;
>  	}
>  
> -	if (bpf_trampoline_module_get(tr))
> -		return -ENOENT;
> -
>  	if (tr->func.ftrace_managed) {
>  		ftrace_set_filter_ip(tr->fops, (unsigned long)ip, 0, 1);
>  		ret = register_ftrace_direct_multi(tr->fops, (long)new_addr);
> @@ -248,8 +223,6 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
>  		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, NULL, new_addr);
>  	}
>  
> -	if (ret)
> -		bpf_trampoline_module_put(tr);
>  	return ret;
>  }
>  

SNIP
