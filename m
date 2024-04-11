Return-Path: <bpf+bounces-26465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2508A04DB
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 02:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5A0E28902E
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 00:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFDE9449;
	Thu, 11 Apr 2024 00:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="d0JIbdvT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5693879DC
	for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 00:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712795922; cv=none; b=GUTZz0FzQoyzxdMtm+d08x7HWieYOIRZpUEVd6wkf3SztuIrHWXTN/bM9VL1W3oEh0NBE2Ileu0awOkm9CPMg8oavsJROWDlyFnkiZptMu+MEV1PgZT4iFAjaEaCHxefs4Zr6JcPThSxg2GoR5L04DaKqh+Oz1QVL7cQLkw3xTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712795922; c=relaxed/simple;
	bh=94WC6EGkdKDLwRmmXd/34rbDcwDimUjU7i4aTeoVZ2s=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=oeRhsu/YEJFX7gMzrHItdDn//ntpDYTuky0pmxo9uN9GrkAHQEWtkhR0Pju6zOFAGZUnSXBYXIjWA9WvFZ6v/Lsafs2f0zfa/KIBQsqBu6wUdselUlDN4KFfPBJ9mIJcpr7CgOGHxiUH3l+3QMKrQTQHITOtwEhUclaOQYeCPvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=d0JIbdvT; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6164d7a02d2so79445977b3.3
        for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 17:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1712795918; x=1713400718; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EXib2fHnFWUHQ8UCjCJaXOWcFMngq2N0HQiePqOlmhU=;
        b=d0JIbdvTDLfsPa5gYB9vWpjoun37ZpAd61n9lytzaEoDSEFEu6y+myk+nHAxEV/BIJ
         fWI+cO8dlNgBk4HUIdo4DCcmafMely/EY/ZMqdxtCYwLMK9x9GbHXbVtOCnLXhijxgA5
         eoco6nseQbFL2kKbdsL/Hz1StO/veNFdrtB8dtEhlrqwlbG22Xl0JAZM7kwmjuCci8z1
         kaFjB8zeZkFWI5WfTJcK0eZTTJ7cBkLDrGeNwcbLSkrpLUrr+Anw/51k9ktjwyOjjMCo
         uUHRfIhRuL9raWYJV/W3l3TjiJF83uCrE/h5iaaSU3laT6w67lpDvhSg8zzSWDa1hw9x
         B+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712795918; x=1713400718;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EXib2fHnFWUHQ8UCjCJaXOWcFMngq2N0HQiePqOlmhU=;
        b=UiQlRtK3RMxr5kwgwo1noLl84tNnAxHs9Zr1mWVpSdahUwta/XE0UtuIQ9LcHYx8JG
         Rm5pFwpvWLike8dzgryG4f2W0wcVEby8aF7jaCCTcvgmhZ/WNV8kTbr8IXJhAIBZdilp
         NFjLrLQOqe4we8kuWdNrOf3VlhR8pAtK1mILJg2N6n4+Je0t3ogfrOe63fDELEVr1pjt
         CmWw54nA5EsjZbjoXFxbbIbzcpm2IX8qdi/wYVRvkF8LZbZ29XmvaG160W/WutmWGwzC
         bnBAyzVDKlSN72Vkr8Nt2nZ+JsIIskdLozBv5oNRKZkL/m2/nGQ7j0eKXNW9n7nv1Cj8
         tNIA==
X-Forwarded-Encrypted: i=1; AJvYcCVozezn0hE5+9usakyheEcLjZGiSafjhKzp67x6HphJ+0DAo5f+n2a2zwqYAshX0QE2AiTkFMoMF8Kor+Zr+uCbMjmL
X-Gm-Message-State: AOJu0YxBFDbrRgdeO0Eneh9dZu4SPV3VBLigXw4JMVprjwdQ1lc6A6S8
	JnguQW+2bRf7CDmMlOR/txotRxTlj9j0jzrBbfgNQkai6x4wR+AQxWfah7rjuivfTq4kISr9r0s
	=
X-Google-Smtp-Source: AGHT+IHCG6i/n6p2fgZWREtVheMfV4kQdQss9ThmR8U+7M//YH33KZrNR1sUj2ggcXTc+tEJ860wCw==
X-Received: by 2002:a0d:d851:0:b0:618:5bf2:1c48 with SMTP id a78-20020a0dd851000000b006185bf21c48mr2016100ywe.38.1712795918163;
        Wed, 10 Apr 2024 17:38:38 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id z8-20020ac84548000000b004349bb95e01sm219515qtn.26.2024.04.10.17.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 17:38:37 -0700 (PDT)
Date: Wed, 10 Apr 2024 20:38:37 -0400
Message-ID: <f7e8a16b0815d9d901e019934d684c5f@paul-moore.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: keescook@chromium.org, casey@schaufler-ca.com, song@kernel.org, daniel@iogearbox.net, ast@kernel.org, pabeni@redhat.com, andrii@kernel.org, kpsingh@kernel.org, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v9 4/4] bpf: Only enable BPF LSM hooks when an LSM program  is attached
References: <20240207124918.3498756-5-kpsingh@kernel.org>
In-Reply-To: <20240207124918.3498756-5-kpsingh@kernel.org>

On Feb  7, 2024 KP Singh <kpsingh@kernel.org> wrote:
> 
> BPF LSM hooks have side-effects (even when a default value is returned),
> as some hooks end up behaving differently due to the very presence of
> the hook.
> 
> The static keys guarding the BPF LSM hooks are disabled by default and
> enabled only when a BPF program is attached implementing the hook
> logic. This avoids the issue of the side-effects and also the minor
> overhead associated with the empty callback.
> 
> security_file_ioctl:
>    0xffffffff818f0e30 <+0>:	endbr64
>    0xffffffff818f0e34 <+4>:	nopl   0x0(%rax,%rax,1)
>    0xffffffff818f0e39 <+9>:	push   %rbp
>    0xffffffff818f0e3a <+10>:	push   %r14
>    0xffffffff818f0e3c <+12>:	push   %rbx
>    0xffffffff818f0e3d <+13>:	mov    %rdx,%rbx
>    0xffffffff818f0e40 <+16>:	mov    %esi,%ebp
>    0xffffffff818f0e42 <+18>:	mov    %rdi,%r14
>    0xffffffff818f0e45 <+21>:	jmp    0xffffffff818f0e57 <security_file_ioctl+39>
>    				^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
>    Static key enabled for SELinux
> 
>    0xffffffff818f0e47 <+23>:	xchg   %ax,%ax
>    				^^^^^^^^^^^^^^
> 
>    Static key disabled for BPF. This gets patched when a BPF LSM program
>    is attached
> 
>    0xffffffff818f0e49 <+25>:	xor    %eax,%eax
>    0xffffffff818f0e4b <+27>:	xchg   %ax,%ax
>    0xffffffff818f0e4d <+29>:	pop    %rbx
>    0xffffffff818f0e4e <+30>:	pop    %r14
>    0xffffffff818f0e50 <+32>:	pop    %rbp
>    0xffffffff818f0e51 <+33>:	cs jmp 0xffffffff82c00000 <__x86_return_thunk>
>    0xffffffff818f0e57 <+39>:	endbr64
>    0xffffffff818f0e5b <+43>:	mov    %r14,%rdi
>    0xffffffff818f0e5e <+46>:	mov    %ebp,%esi
>    0xffffffff818f0e60 <+48>:	mov    %rbx,%rdx
>    0xffffffff818f0e63 <+51>:	call   0xffffffff819033c0 <selinux_file_ioctl>
>    0xffffffff818f0e68 <+56>:	test   %eax,%eax
>    0xffffffff818f0e6a <+58>:	jne    0xffffffff818f0e4d <security_file_ioctl+29>
>    0xffffffff818f0e6c <+60>:	jmp    0xffffffff818f0e47 <security_file_ioctl+23>
>    0xffffffff818f0e6e <+62>:	endbr64
>    0xffffffff818f0e72 <+66>:	mov    %r14,%rdi
>    0xffffffff818f0e75 <+69>:	mov    %ebp,%esi
>    0xffffffff818f0e77 <+71>:	mov    %rbx,%rdx
>    0xffffffff818f0e7a <+74>:	call   0xffffffff8141e3b0 <bpf_lsm_file_ioctl>
>    0xffffffff818f0e7f <+79>:	test   %eax,%eax
>    0xffffffff818f0e81 <+81>:	jne    0xffffffff818f0e4d <security_file_ioctl+29>
>    0xffffffff818f0e83 <+83>:	jmp    0xffffffff818f0e49 <security_file_ioctl+25>
>    0xffffffff818f0e85 <+85>:	endbr64
>    0xffffffff818f0e89 <+89>:	mov    %r14,%rdi
>    0xffffffff818f0e8c <+92>:	mov    %ebp,%esi
>    0xffffffff818f0e8e <+94>:	mov    %rbx,%rdx
>    0xffffffff818f0e91 <+97>:	pop    %rbx
>    0xffffffff818f0e92 <+98>:	pop    %r14
>    0xffffffff818f0e94 <+100>:	pop    %rbp
>    0xffffffff818f0e95 <+101>:	ret
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Acked-by: Song Liu <song@kernel.org>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  include/linux/bpf_lsm.h   |  5 +++++
>  include/linux/lsm_hooks.h | 13 ++++++++++++-
>  kernel/bpf/trampoline.c   | 24 ++++++++++++++++++++++++
>  security/bpf/hooks.c      | 25 ++++++++++++++++++++++++-
>  security/security.c       |  3 ++-
>  5 files changed, 67 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> index 1de7ece5d36d..5bbc31ac948c 100644
> --- a/include/linux/bpf_lsm.h
> +++ b/include/linux/bpf_lsm.h
> @@ -29,6 +29,7 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
>  
>  bool bpf_lsm_is_sleepable_hook(u32 btf_id);
>  bool bpf_lsm_is_trusted(const struct bpf_prog *prog);
> +void bpf_lsm_toggle_hook(void *addr, bool value);
>  
>  static inline struct bpf_storage_blob *bpf_inode(
>  	const struct inode *inode)
> @@ -78,6 +79,10 @@ static inline void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog,
>  {
>  }
>  
> +static inline void bpf_lsm_toggle_hook(void *addr, bool value)
> +{
> +}
> +
>  #endif /* CONFIG_BPF_LSM */
>  
>  #endif /* _LINUX_BPF_LSM_H */
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index ba63d8b54448..e95f0a5cb409 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -110,11 +110,14 @@ struct lsm_id {
>   * @scalls: The beginning of the array of static calls assigned to this hook.
>   * @hook: The callback for the hook.
>   * @lsm: The name of the lsm that owns this hook.
> + * @default_state: The state of the LSM hook when initialized. If set to false,
> + * the static key guarding the hook will be set to disabled.
>   */
>  struct security_hook_list {
>  	struct lsm_static_call	*scalls;
>  	union security_list_options	hook;
>  	const struct lsm_id		*lsmid;
> +	bool				default_enabled;

Ugh.  We've already got an lsm_static_call::active field, I don't want
to see another enable/active/etc. flag unless there is absolutely no way
this works otherwise.

>  } __randomize_layout;
>  
>  /*
> @@ -164,7 +167,15 @@ static inline struct xattr *lsm_get_xattr_slot(struct xattr *xattrs,
>  #define LSM_HOOK_INIT(NAME, CALLBACK)			\
>  	{						\
>  		.scalls = static_calls_table.NAME,	\
> -		.hook = { .NAME = CALLBACK }		\
> +		.hook = { .NAME = CALLBACK },		\
> +		.default_enabled = true			\
> +	}
> +
> +#define LSM_HOOK_INIT_DISABLED(NAME, CALLBACK)		\
> +	{						\
> +		.scalls = static_calls_table.NAME,	\
> +		.hook = { .NAME = CALLBACK },		\
> +		.default_enabled = false		\
>  	}
>  
>  extern char *lsm_names;
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index d382f5ebe06c..5281c3338e19 100644
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
> @@ -521,6 +522,21 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
>  	}
>  }
>  
> +static void bpf_trampoline_toggle_lsm(struct bpf_trampoline *tr,
> +				      enum bpf_tramp_prog_type kind)
> +{
> +	struct bpf_tramp_link *link;
> +	bool found = false;
> +
> +	hlist_for_each_entry(link, &tr->progs_hlist[kind], tramp_hlist) {
> +		if (link->link.prog->type == BPF_PROG_TYPE_LSM) {
> +			found  = true;
> +			break;
> +		}
> +	}
> +	bpf_lsm_toggle_hook(tr->func.addr, found);
> +}
> +
>  static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr)
>  {
>  	enum bpf_tramp_prog_type kind;
> @@ -560,6 +576,10 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_tr
>  
>  	hlist_add_head(&link->tramp_hlist, &tr->progs_hlist[kind]);
>  	tr->progs_cnt[kind]++;
> +
> +	if (link->link.prog->type == BPF_PROG_TYPE_LSM)
> +		bpf_trampoline_toggle_lsm(tr, kind);
> +
>  	err = bpf_trampoline_update(tr, true /* lock_direct_mutex */);
>  	if (err) {
>  		hlist_del_init(&link->tramp_hlist);
> @@ -593,6 +613,10 @@ static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_
>  	}
>  	hlist_del_init(&link->tramp_hlist);
>  	tr->progs_cnt[kind]--;
> +
> +	if (link->link.prog->type == BPF_PROG_TYPE_LSM)
> +		bpf_trampoline_toggle_lsm(tr, kind);
> +
>  	return bpf_trampoline_update(tr, true /* lock_direct_mutex */);
>  }
>  
> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> index 57b9ffd53c98..38bedab2b4f9 100644
> --- a/security/bpf/hooks.c
> +++ b/security/bpf/hooks.c
> @@ -9,7 +9,7 @@
>  
>  static struct security_hook_list bpf_lsm_hooks[] __ro_after_init = {
>  	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
> -	LSM_HOOK_INIT(NAME, bpf_lsm_##NAME),
> +	LSM_HOOK_INIT_DISABLED(NAME, bpf_lsm_##NAME),
>  	#include <linux/lsm_hook_defs.h>
>  	#undef LSM_HOOK
>  	LSM_HOOK_INIT(inode_free_security, bpf_inode_storage_free),
> @@ -39,3 +39,26 @@ DEFINE_LSM(bpf) = {
>  	.init = bpf_lsm_init,
>  	.blobs = &bpf_lsm_blob_sizes
>  };
> +
> +void bpf_lsm_toggle_hook(void *addr, bool enable)
> +{
> +	struct lsm_static_call *scalls;
> +	struct security_hook_list *h;
> +	int i, j;
> +
> +	for (i = 0; i < ARRAY_SIZE(bpf_lsm_hooks); i++) {
> +		h = &bpf_lsm_hooks[i];
> +		if (h->hook.lsm_callback != addr)
> +			continue;
> +
> +		for (j = 0; j < MAX_LSM_COUNT; j++) {
> +			scalls = &h->scalls[j];
> +			if (scalls->hl != &bpf_lsm_hooks[i])
> +				continue;
> +			if (enable)
> +				static_branch_enable(scalls->active);
> +			else
> +				static_branch_disable(scalls->active);
> +		}
> +	}
> +}

More ugh.  If we're going to solve things this way, let's make it a
proper LSM interface and not a BPF LSM specific hack; I *really* don't
want to see individual LSMs managing the lsm_static_call or
security_hook_list entries.

> diff --git a/security/security.c b/security/security.c
> index e05d2157c95a..40d83da87f68 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -406,7 +406,8 @@ static void __init lsm_static_call_init(struct security_hook_list *hl)
>  			__static_call_update(scall->key, scall->trampoline,
>  					     hl->hook.lsm_callback);
>  			scall->hl = hl;
> -			static_branch_enable(scall->active);
> +			if (hl->default_enabled)
> +				static_branch_enable(scall->active);
>  			return;
>  		}
>  		scall++;
> -- 
> 2.43.0.594.gd9cf4e227d-goog

--
paul-moore.com

