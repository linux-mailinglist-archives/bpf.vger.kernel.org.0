Return-Path: <bpf+bounces-11430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B581F7B9BBB
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 10:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id AFBF2281BEF
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 08:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6259663B1;
	Thu,  5 Oct 2023 08:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifxXrmyM"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436BF63A
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 08:09:53 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEF28693;
	Thu,  5 Oct 2023 01:09:51 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40566f89f6eso6271165e9.3;
        Thu, 05 Oct 2023 01:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696493390; x=1697098190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vac1cc2NhqqKLkLLqOWp/M2Xk8kK7YsIhEZC7x4c1VE=;
        b=ifxXrmyMYXHjcpSGaFKIgeQotHSKfSy5PDv2NeErW+QuINbwTDPPthQY9ge6UjkvqN
         SdR/RMTwtvSzLsGxO4FrJRIMm2HbQuWoRcc/2Wrn9/JjQgUbRCeMdng4N62/JemSG8G5
         dqjj34jnlTLGAry+8qwAq4KJXYx+Di5xsP1JGpVYALs8MFBsQwltpyVqZxD6kkS4USzg
         Nx02WxzNoDD/DL1liaBN/qmzcdwl7ZaFeDJ5YFDOSrm258/3VddP285dhAEq12YJ12nv
         J6CGzrKVOQdeiy1hPCVfZJfAqHdzevVbtOkm1scaZW7pDbWhwvVHQWKq0qwyc7B6evwi
         oU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696493390; x=1697098190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vac1cc2NhqqKLkLLqOWp/M2Xk8kK7YsIhEZC7x4c1VE=;
        b=ZNqJZ8iv/ZSPCDc4ddPW/WwHppgM1sMSuUlTdUKG0hZFeIkA/MYjG4SpOJ8/h0479r
         h6OdwwpFYg4SGNdgBc/2lf9RZOb0OF0HqNfWCn9Eeu1QhAOFqLixO2uH73pBm3XcZ3p3
         HWmEMsBNIvk5C7VkrUsxcbOaI9Rysh0/DT2C3wR+iFQkh1TKh3jWtkku7xrfucA7/e6w
         bLI58gIdjjbdY43cA8z48fUWrztilwTEc1oEvxJ7NdjIF+AhYfpy2B3KS9o9vb+QkSoP
         lH3yIumHK3Vo+fhw7YsyUjICEYJ+4YWOsyA7ZoMcyh5r8qbPSlNUvYUOKHGge/i7Krwg
         pdjg==
X-Gm-Message-State: AOJu0Yy6lirmVtyVpQGQRGOj4EO13FlllqmvRVhb7XOjX5ZT7n+gto4P
	yMIQYSiPLfjjERe8poIdgoQ=
X-Google-Smtp-Source: AGHT+IGgFchs9lATe9wTJNhW991KYQ9SWvuqIs9rt0eFGO2Eyw1PAmzzNgwHsXi/uGf+PI9L6DTL0A==
X-Received: by 2002:a05:600c:220b:b0:406:7029:c4f2 with SMTP id z11-20020a05600c220b00b004067029c4f2mr4051867wml.26.1696493389528;
        Thu, 05 Oct 2023 01:09:49 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id y6-20020a1c4b06000000b00405588aa40asm923957wma.24.2023.10.05.01.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 01:09:49 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 5 Oct 2023 10:09:47 +0200
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com,
	song@kernel.org, daniel@iogearbox.net, ast@kernel.org,
	renauld@google.com
Subject: Re: [PATCH v5 4/5] bpf: Only enable BPF LSM hooks when an LSM
 program is attached
Message-ID: <ZR5vSyyNGBb8TvNH@krava>
References: <20230928202410.3765062-1-kpsingh@kernel.org>
 <20230928202410.3765062-5-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928202410.3765062-5-kpsingh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 28, 2023 at 10:24:09PM +0200, KP Singh wrote:

SNIP

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index e97aeda3a86b..df9699bce372 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -13,6 +13,7 @@
>  #include <linux/bpf_verifier.h>
>  #include <linux/bpf_lsm.h>
>  #include <linux/delay.h>
> +#include <linux/bpf_lsm.h>
>  
>  /* dummy _ops. The verifier will operate on target program's ops. */
>  const struct bpf_verifier_ops bpf_extension_verifier_ops = {
> @@ -514,7 +515,7 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_tr
>  {
>  	enum bpf_tramp_prog_type kind;
>  	struct bpf_tramp_link *link_exiting;
> -	int err = 0;
> +	int err = 0, num_lsm_progs = 0;
>  	int cnt = 0, i;
>  
>  	kind = bpf_attach_type_to_tramp(link->link.prog);
> @@ -545,8 +546,14 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_tr
>  			continue;
>  		/* prog already linked */
>  		return -EBUSY;
> +
> +		if (link_exiting->link.prog->type == BPF_PROG_TYPE_LSM)
> +			num_lsm_progs++;

this looks wrong, it's never reached.. seems like we should add separate
hlist_for_each_entry loop over trampoline's links for this check/init of
num_lsm_progs ?

jirka

>  	}
>  
> +	if (!num_lsm_progs && link->link.prog->type == BPF_PROG_TYPE_LSM)
> +		bpf_lsm_toggle_hook(tr->func.addr, true);
> +
>  	hlist_add_head(&link->tramp_hlist, &tr->progs_hlist[kind]);
>  	tr->progs_cnt[kind]++;
>  	err = bpf_trampoline_update(tr, true /* lock_direct_mutex */);
> @@ -569,8 +576,10 @@ int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_trampoline
>  
>  static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr)
>  {
> +	struct bpf_tramp_link *link_exiting;
>  	enum bpf_tramp_prog_type kind;
> -	int err;
> +	bool lsm_link_found = false;
> +	int err, num_lsm_progs = 0;
>  
>  	kind = bpf_attach_type_to_tramp(link->link.prog);
>  	if (kind == BPF_TRAMP_REPLACE) {
> @@ -580,8 +589,24 @@ static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_
>  		tr->extension_prog = NULL;
>  		return err;
>  	}
> +
> +	if (link->link.prog->type == BPF_PROG_TYPE_LSM) {
> +		hlist_for_each_entry(link_exiting, &tr->progs_hlist[kind],
> +				     tramp_hlist) {
> +			if (link_exiting->link.prog->type == BPF_PROG_TYPE_LSM)
> +				num_lsm_progs++;
> +
> +			if (link_exiting->link.prog == link->link.prog)
> +				lsm_link_found = true;
> +		}
> +	}
> +
>  	hlist_del_init(&link->tramp_hlist);
>  	tr->progs_cnt[kind]--;
> +
> +	if (lsm_link_found && num_lsm_progs == 1)
> +		bpf_lsm_toggle_hook(tr->func.addr, false);
> +
>  	return bpf_trampoline_update(tr, true /* lock_direct_mutex */);
>  }
>  
> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> index cfaf1d0e6a5f..1957244196d0 100644
> --- a/security/bpf/hooks.c
> +++ b/security/bpf/hooks.c
> @@ -8,7 +8,7 @@
>  
>  static struct security_hook_list bpf_lsm_hooks[] __ro_after_init = {
>  	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
> -	LSM_HOOK_INIT(NAME, bpf_lsm_##NAME),
> +	LSM_HOOK_INIT_DISABLED(NAME, bpf_lsm_##NAME),
>  	#include <linux/lsm_hook_defs.h>
>  	#undef LSM_HOOK
>  	LSM_HOOK_INIT(inode_free_security, bpf_inode_storage_free),
> @@ -32,3 +32,26 @@ DEFINE_LSM(bpf) = {
>  	.init = bpf_lsm_init,
>  	.blobs = &bpf_lsm_blob_sizes
>  };
> +
> +void bpf_lsm_toggle_hook(void *addr, bool value)
> +{
> +	struct lsm_static_call *scalls;
> +	struct security_hook_list *h;
> +	int i, j;
> +
> +	for (i = 0; i < ARRAY_SIZE(bpf_lsm_hooks); i++) {
> +		h = &bpf_lsm_hooks[i];
> +		scalls = h->scalls;
> +		if (h->hook.lsm_callback == addr)
> +			continue;
> +
> +		for (j = 0; j < MAX_LSM_COUNT; j++) {
> +			if (scalls[j].hl != h)
> +				continue;
> +			if (value)
> +				static_branch_enable(scalls[j].active);
> +			else
> +				static_branch_disable(scalls[j].active);
> +		}
> +	}
> +}
> diff --git a/security/security.c b/security/security.c
> index c2c2cf6b711f..d1ee72e563cc 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -382,7 +382,8 @@ static void __init lsm_static_call_init(struct security_hook_list *hl)
>  			__static_call_update(scall->key, scall->trampoline,
>  					     hl->hook.lsm_callback);
>  			scall->hl = hl;
> -			static_branch_enable(scall->active);
> +			if (hl->default_state)
> +				static_branch_enable(scall->active);
>  			return;
>  		}
>  		scall++;
> -- 
> 2.42.0.582.g8ccd20d70d-goog
> 
> 

