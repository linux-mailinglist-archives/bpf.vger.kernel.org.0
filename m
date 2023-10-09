Return-Path: <bpf+bounces-11695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C22E77BD835
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 12:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F312F1C20C0E
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 10:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FA21805D;
	Mon,  9 Oct 2023 10:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYse4GJB"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ED615AFF
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 10:11:34 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C424A3;
	Mon,  9 Oct 2023 03:11:28 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53b962f09e0so2490255a12.0;
        Mon, 09 Oct 2023 03:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696846287; x=1697451087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VK2n1agOr8eZYdCQ0u7RzEERl6DLK/2StuInLyfvlaY=;
        b=OYse4GJB3vHlv2LFPfGqhhquBIZ5Lv5K3xWoBDfJKcUbBc0DEY8EV1UXW2ArAg1dKQ
         9jo2+oWs8VHzy9C+Vy+KG7jKQCnj5Xbwo+BKl/QVgtEqL/M621PI3JmUGvmTHwlzIZqX
         UG8ok9ZzDwFL0fQq29+etjPWAzvBzz5aKSiolkOoeFbRhBYCG/bDveIB10DsG2jxbFz3
         3y1XuloiCqsokCGgDnqLUzL7ZGoGSvZ3rWQmWm/ybr+JKSnccZOr33V1kQ+KdPd5tUa5
         Hf73ECEvRWWAqDllei8m/CpPu1p/hnN7+zokum6tcxRWHGkvkWqQntcWeZdVeorFHYnu
         Nu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696846287; x=1697451087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VK2n1agOr8eZYdCQ0u7RzEERl6DLK/2StuInLyfvlaY=;
        b=MCzHx4h7shswy/xkRDWfKzhKZIzO61XTTldOeV1Ka49ghak7qb3Dqnu4NnGrcRJvD6
         IxJiLDYSwaP7TcFDAWmOBzRucI9wFfwXoW6B5yxbAeUJyk0eid6Qu0iSfqaUa5vx5mSy
         Ps9UG02fwKRR4VeYhohepM9rcDmY5JPsSIkwTo7VP05e16nE2z+uN6iCP6gQ47b7trEZ
         A6n8WT9RSZogedzi/qEx2PrS40drN2kF3472JQPFh3bOsHfzf8IaOLJ8AROVe6LsbhPl
         gzWBr83MF0Rc/OO9GbDUboLFbFBhpye2xH9VIpZW29PZ/oRYWSVR9ky36u92VKzOlkVI
         t5Sg==
X-Gm-Message-State: AOJu0YyXHjX6KXO9DhAC9/2EKTOa0zuFcYqj1pEvVdJgGIe92AsUv1YZ
	8erLsPjV8DDV1X2GowinvIw=
X-Google-Smtp-Source: AGHT+IHAp5DeOhEwkJOPpWgWDk6QV0eN/dk4ic76QGVBOPvdjCNneebstLrePvGTGdkxRqByrrntuQ==
X-Received: by 2002:a17:906:53d4:b0:9ae:5bd7:d2b4 with SMTP id p20-20020a17090653d400b009ae5bd7d2b4mr14179387ejo.68.1696846286506;
        Mon, 09 Oct 2023 03:11:26 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id w18-20020a17090652d200b0099d798a6bb5sm6578605ejn.67.2023.10.09.03.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 03:11:25 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 9 Oct 2023 12:10:54 +0200
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com,
	song@kernel.org, daniel@iogearbox.net, ast@kernel.org,
	renauld@google.com, pabeni@redhat.com
Subject: Re: [PATCH v6 4/5] bpf: Only enable BPF LSM hooks when an LSM
 program is attached
Message-ID: <ZSPRrtkKtf9WyBOy@krava>
References: <20231006204701.549230-1-kpsingh@kernel.org>
 <20231006204701.549230-5-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006204701.549230-5-kpsingh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 06, 2023 at 10:47:00PM +0200, KP Singh wrote:
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
> Signed-off-by: KP Singh <kpsingh@kernel.org>

small nit, but looks good

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka


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

nit, this could be static, unless there are future plans ;-)

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
> index c77a1859214d..57ffe4eb6d30 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -97,11 +97,14 @@ struct lsm_static_calls_table {
>   * @scalls: The beginning of the array of static calls assigned to this hook.
>   * @hook: The callback for the hook.
>   * @lsm: The name of the lsm that owns this hook.
> + * @default_state: The state of the LSM hook when initialized. If set to false,
> + * the static key guarding the hook will be set to disabled.
>   */
>  struct security_hook_list {
>  	struct lsm_static_call	*scalls;
>  	union security_list_options	hook;
>  	const char			*lsm;
> +	bool				default_state;
>  } __randomize_layout;
>  
>  /*
> @@ -151,7 +154,15 @@ static inline struct xattr *lsm_get_xattr_slot(struct xattr *xattrs,
>  #define LSM_HOOK_INIT(NAME, CALLBACK)			\
>  	{						\
>  		.scalls = static_calls_table.NAME,	\
> -		.hook = { .NAME = CALLBACK }		\
> +		.hook = { .NAME = CALLBACK },		\
> +		.default_state = true			\
> +	}
> +
> +#define LSM_HOOK_INIT_DISABLED(NAME, CALLBACK)		\
> +	{						\
> +		.scalls = static_calls_table.NAME,	\
> +		.hook = { .NAME = CALLBACK },		\
> +		.default_state = false			\
>  	}
>  
>  extern char *lsm_names;
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index e97aeda3a86b..44788e2eaa1b 100644
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
> @@ -510,6 +511,21 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
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
> @@ -549,6 +565,10 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_tr
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
> @@ -582,6 +602,10 @@ static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_
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
> index cfaf1d0e6a5f..47e1a4777ec9 100644
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
> +		if (h->hook.lsm_callback != addr)
> +			continue;
> +
> +		for (j = 0; j < MAX_LSM_COUNT; j++) {
> +			scalls = &h->scalls[j];
> +			if (scalls->hl != &bpf_lsm_hooks[i])
> +				continue;
> +			if (value)
> +				static_branch_enable(scalls->active);
> +			else
> +				static_branch_disable(scalls->active);
> +		}
> +	}
> +}
> diff --git a/security/security.c b/security/security.c
> index ce4c0a9107ea..f45e875b6d93 100644
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
> 2.42.0.609.gbb76f46606-goog
> 
> 

