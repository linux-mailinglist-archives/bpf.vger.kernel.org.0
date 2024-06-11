Return-Path: <bpf+bounces-31763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A255C902DDE
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 03:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCDC81C21A88
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 01:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670C8BA42;
	Tue, 11 Jun 2024 01:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AAXMqafQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F5BB66F
	for <bpf@vger.kernel.org>; Tue, 11 Jun 2024 01:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718067952; cv=none; b=BLk9nrf8G7H62oBS+aYZdrio03HgrZGyVksIer07MnMePJ4y2CaH+kNkjCelzEstoDV0BdvEvqQTKN3+lhAYUSn3YyAay6LWusRh+x7ea+/siJyb09Vmm5Gt6OIeUlpJ9lZG+rpzfbBR5NB/A9RbEl7BcJt1ltvba2lTD3InoT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718067952; c=relaxed/simple;
	bh=1ZwDkZMh5wK7KEbCm2y7rfR5RAxqwyRhu58ZhZipeVQ=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=OAtvmooM1kcHeIuk4G8PsJP5u34yPoyZFR3DSCpH88znp0FzrBLzzXBJbsfADVpZdO6gvUBhQg9eyaHjBEAvaNAJQ01AQ+quVa8kK8j5PSailSzAgpVJsPPaFPgnVO2wUZ8NTRDLdrYwylLG2JogDAOwGDVYXef+lg+hWxqt6Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AAXMqafQ; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3d220039bc6so1339782b6e.2
        for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 18:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718067949; x=1718672749; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yZ4JDG+dJaoWCaYO977Z1LKOPgYLIz36cfcgnvADTfA=;
        b=AAXMqafQhrW6XWQnz8wS9LV3Z90TqFB3oNX7o4sAEeQO+zuQEzuNnLe+kf6R8pvoLm
         DWZ1WPvBaa8wjkyQmElmXJEIG0Ftjd6In5heppa/XlV7p6piiNiwQdaG1Kmx23wi0TxJ
         1MFTyVsG3oZJ3ugq4ihZ+WgtLinL2ruEpulDzPdyllWeUXL1yGqLnnF95r8bHun9OYwk
         brg08Dr5n3vzwjWoNAk/R2Dgj79HcY+UyVDr384d9r5DX/YcA3Sl5fjIQu2jDZkgjtNK
         O5BxyKFuT4CxfBf+4rDhrqKbpTQAVWA5Nxt6i3MKWxwVPly3ZnBbur+k0HaVHWf+oIuE
         E/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718067949; x=1718672749;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yZ4JDG+dJaoWCaYO977Z1LKOPgYLIz36cfcgnvADTfA=;
        b=wZ8Ehy8A3Ap9gWNHyoac+wU/K/w2kyq526nP0tQQKMBpiwKnG0ERDo2PjXlY4hBD5Y
         vMO2M+9dRJLfFnLrN3yQpGnVSYP/tN+n2624dbab1O2Ouly9LXWLGeQpHSnnSK3+1cgG
         LcCOpxknauGPLKJ+HsQ2ivnrQV4JW7dN/kS11L7P1VnKRBzenpFAhpJ8YpSE20Ww0bwM
         boW3JfiTXr3/muIHCrAOeO/WrcVgHR+qXmzHOjrjh2Ba4oCNuY7kHl7XTeH0iE44kaFR
         xnFnJxjkkm9bgpIQHnjQAfPLVk9lmGJtSPlrbOiLNJuMqNb0XCLb7tMpekTWQXHPBga0
         jooA==
X-Forwarded-Encrypted: i=1; AJvYcCWGd8x7bApCVyC/WqL0pG7iiIyLt3zB+DpTVCC8WVUnR6Xn/UMj4vYlmD/9uBw7hoIbELBP+g6Om/NXDyzQcsXrptOY
X-Gm-Message-State: AOJu0Yw2Ni9P7poJ3ew7aT7HRNcDiABuc7vGBvVLKUPn1GA0brD9iNWV
	kETB9WlnYx626Hb++eoSUhxLvrsZ42zs5H07w91N7xhIA3iuuImvYb6orsRvfg==
X-Google-Smtp-Source: AGHT+IHbEqXBLO2Hne6cvXvXI7Jk/mxqNCvkIh6oXm2zZK2/y+ysC+4BLi5/GWzLIe/6agFFO8Me6g==
X-Received: by 2002:a05:6808:bd2:b0:3d2:15a5:99ff with SMTP id 5614622812f47-3d215a59ab5mr12107086b6e.32.1718067948753;
        Mon, 10 Jun 2024 18:05:48 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79785665e38sm106079785a.64.2024.06.10.18.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 18:05:48 -0700 (PDT)
Date: Mon, 10 Jun 2024 21:05:47 -0400
Message-ID: <03c6f35485d622d8121fa0d7a7e3d0b2@paul-moore.com>
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
To: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, casey@schaufler-ca.com, andrii@kernel.org, keescook@chromium.org, daniel@iogearbox.net, renauld@google.com, revest@chromium.org, song@kernel.org, KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH v12 5/5] bpf: Only enable BPF LSM hooks when an LSM program  is attached
References: <20240516003524.143243-6-kpsingh@kernel.org>
In-Reply-To: <20240516003524.143243-6-kpsingh@kernel.org>

On May 15, 2024 KP Singh <kpsingh@kernel.org> wrote:
> 
> BPF LSM hooks have side-effects (even when a default value's returned)
> as some hooks end up behaving differently due to the very presence of
> the hook.
> 
> The static keys guarding the BPF LSM hooks are disabled by default and
> enabled only when a BPF program is attached implementing the hook
> logic. This avoids the issue of the side-effects and also the minor
> overhead associated with the empty callback.
> 
> security_file_ioctl:
>    0xff...0e30 <+0>:	endbr64
>    0xff...0e34 <+4>:	nopl   0x0(%rax,%rax,1)
>    0xff...0e39 <+9>:	push   %rbp
>    0xff...0e3a <+10>:	push   %r14
>    0xff...0e3c <+12>:	push   %rbx
>    0xff...0e3d <+13>:	mov    %rdx,%rbx
>    0xff...0e40 <+16>:	mov    %esi,%ebp
>    0xff...0e42 <+18>:	mov    %rdi,%r14
>    0xff...0e45 <+21>:	jmp    0xff...0e57 <security_file_ioctl+39>
>    				^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
>    Static key enabled for SELinux
> 
>    0xff...0e47 <+23>:	xchg   %ax,%ax
>    			^^^^^^^^^^^^^^
> 
>    Static key disabled for BPF. This gets patched when a BPF LSM
>    program is attached
> 
>    0xff...0e49 <+25>:	xor    %eax,%eax
>    0xff...0e4b <+27>:	xchg   %ax,%ax
>    0xff...0e4d <+29>:	pop    %rbx
>    0xff...0e4e <+30>:	pop    %r14
>    0xff...0e50 <+32>:	pop    %rbp
>    0xff...0e51 <+33>:	cs jmp 0xff...0000 <__x86_return_thunk>
>    0xff...0e57 <+39>:	endbr64
>    0xff...0e5b <+43>:	mov    %r14,%rdi
>    0xff...0e5e <+46>:	mov    %ebp,%esi
>    0xff...0e60 <+48>:	mov    %rbx,%rdx
>    0xff...0e63 <+51>:	call   0xff...33c0 <selinux_file_ioctl>
>    0xff...0e68 <+56>:	test   %eax,%eax
>    0xff...0e6a <+58>:	jne    0xff...0e4d <security_file_ioctl+29>
>    0xff...0e6c <+60>:	jmp    0xff...0e47 <security_file_ioctl+23>
>    0xff...0e6e <+62>:	endbr64
>    0xff...0e72 <+66>:	mov    %r14,%rdi
>    0xff...0e75 <+69>:	mov    %ebp,%esi
>    0xff...0e77 <+71>:	mov    %rbx,%rdx
>    0xff...0e7a <+74>:	call   0xff...e3b0 <bpf_lsm_file_ioctl>
>    0xff...0e7f <+79>:	test   %eax,%eax
>    0xff...0e81 <+81>:	jne    0xff...0e4d <security_file_ioctl+29>
>    0xff...0e83 <+83>:	jmp    0xff...0e49 <security_file_ioctl+25>
>    0xff...0e85 <+85>:	endbr64
>    0xff...0e89 <+89>:	mov    %r14,%rdi
>    0xff...0e8c <+92>:	mov    %ebp,%esi
>    0xff...0e8e <+94>:	mov    %rbx,%rdx
>    0xff...0e91 <+97>:	pop    %rbx
>    0xff...0e92 <+98>:	pop    %r14
>    0xff...0e94 <+100>:	pop    %rbp
>    0xff...0e95 <+101>:	ret
> 
> This patch enables this by providing a LSM_HOOK_INIT_RUNTIME variant
> that allows the LSMs to opt-in to hooks which can be toggled at runtime
> which with security_toogle_hook.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  include/linux/lsm_hooks.h | 30 ++++++++++++++++++++++++++++-
>  kernel/bpf/trampoline.c   | 40 +++++++++++++++++++++++++++++++++++----
>  security/bpf/hooks.c      |  2 +-
>  security/security.c       | 35 +++++++++++++++++++++++++++++++++-
>  4 files changed, 100 insertions(+), 7 deletions(-)

...

> diff --git a/security/security.c b/security/security.c
> index 9654ca074aed..2f8bcacf1fb4 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -885,6 +887,37 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, u32 *uctx_len,
>  	return rc;
>  }
>  
> +/**
> + * security_toggle_hook - Toggle the state of the LSM hook.
> + * @hook_addr: The address of the hook to be toggled.
> + * @state: Whether to enable for disable the hook.
> + *
> + * Returns 0 on success, -EINVAL if the address is not found.
> + */
> +int security_toggle_hook(void *hook_addr, bool state)
> +{
> +	struct lsm_static_call *scalls = ((void *)&static_calls_table);

GCC (v14.1.1 if that matters) is complaining about casting randomized
structs.  Looking quickly at the two structs, lsm_static_call and
lsm_static_calls_table, I suspect the cast is harmless even if the
randstruct case, but I would like to see some sort of fix for this so
I don't get spammed by GCC every time I do a build.  On the other hand,
if this cast really is a problem in the randstruct case we obviously
need to fix that.

Either way, resolve this and make sure you test with GCC/randstruct
enabled.

> +	unsigned long num_entries =
> +		(sizeof(static_calls_table) / sizeof(struct lsm_static_call));
> +	int i;
> +
> +	for (i = 0; i < num_entries; i++) {
> +
> +		if (!scalls[i].hl || !scalls[i].hl->runtime)
> +			continue;
> +
> +		if (scalls[i].hl->hook.lsm_func_addr != hook_addr)
> +			continue;
> +
> +		if (state)
> +			static_branch_enable(scalls[i].active);
> +		else
> +			static_branch_disable(scalls[i].active);
> +		return 0;
> +	}
> +	return -EINVAL;
> +}
> +
>  /*
>   * The default value of the LSM hook is defined in linux/lsm_hook_defs.h and
>   * can be accessed with:
> -- 
> 2.45.0.rc1.225.g2a3ae87e7f-goog

--
paul-moore.com

