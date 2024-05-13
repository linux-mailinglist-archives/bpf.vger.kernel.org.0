Return-Path: <bpf+bounces-29661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCDE8C4755
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 21:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7543B281D81
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 19:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8EA44366;
	Mon, 13 May 2024 19:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jHp4LqHU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127EC2EAF9
	for <bpf@vger.kernel.org>; Mon, 13 May 2024 19:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715626957; cv=none; b=pnqp03+yL6VA4+CCJgTmeKnJ8X8CshsKi6MDDxwPP8Vy6rzaiYeenGOUT/Se6fRtZr1aAJyDqe9KvE7dVo5GgjHxPYEkIwrHSz1HysKdEERCKTmoB5LL10zTZZ6lMJ8WO0ozIL5pP0tQm7odXJabnWyHE3fXarZFzilDvPin3Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715626957; c=relaxed/simple;
	bh=1bc2nSMcFkHfg9wu7cCSnxuXsBRRHcbEfRBQ4Jq3j88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWXpG6nvBdWaDYQTF1c7c7bWKBlcfGW2b8LtnEJh8Y5a1KMp5WYiOLqBx7VQf2Xa15klQgXLq/sDfTW9PrkEhiQYiTkiuTFWxWhA0vjxGBNbL4gVGPlLtNQaEo78j0ANge+9vVGcckIl5EL1MUAN7CEi2CbKMWR03G2aKrEAHqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jHp4LqHU; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f489e64eb3so3381575b3a.1
        for <bpf@vger.kernel.org>; Mon, 13 May 2024 12:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715626955; x=1716231755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4uMHnpzuIbH7oFJ6h2bfKBE1eRpq/9DfRH3XLrVt75Q=;
        b=jHp4LqHU00a9ya27Qxom19rii6XD/QPtdL7C3NB3DNIDuQBeCseGq8bmnonQbm5+gC
         ztSceP3bWxtUdXVrqmpPG+2XG/sFKCm2azZkgvJ6aVzkfsfW2i9KBbOkdoXhMVXzW5cI
         OzKkN508/NdAXD8Y6ioSBXf+wtQbhZKREqdFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715626955; x=1716231755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uMHnpzuIbH7oFJ6h2bfKBE1eRpq/9DfRH3XLrVt75Q=;
        b=XT4DcODvAiRkUCHzTW+Gmlyqe4pdrCEo24NWO8OUy3cFfYy2tIX62fg4XKRVU6zazy
         OQ0QEb/eC71/1rygDmR6IqeXQ231dGIxvZ+LIYJ2PKTFjzZ050jqBL6e0QBHzJH2CrO3
         y16E+AcV6BfECXWx9BT84uQhAyVKFTsAa9vLHRD7Zky7+Q4dlfAQU+Wt/jbcOPTJjN22
         QPWY3btOCjpg9+J82S9V2IBpaadZ4tlGlzLXiFl/PXuWuGaNTFhq/v4Q0oJS0NeuKdYC
         iR6nBpzRaNs0eViMGxJOdbkrVUlIXAlGHyC2wXzFuzGsvvLOlgPJnM2SM5wQaAFbVYc6
         FFlg==
X-Forwarded-Encrypted: i=1; AJvYcCWmn+nmFxFiibWJRvSsFVxoGcxgLUy+mT/Ml3OjDwoVtSPSGg93ww/7UJlHnixCtkr+AhWm8jf42uBCfNY5uZfO1Mrc
X-Gm-Message-State: AOJu0YyH+t4UC6Ph6eLfOt4RVk8Av7jrmI5O11MxDqNktsqv90XfDDe6
	/GYSzq6OyfaUMmo6MINFpVhd/tmZh9sR7dGzwtNrjtl8iGnOS+Vn6J32PiCvdQ==
X-Google-Smtp-Source: AGHT+IHiVW2wIHzjlmmJtP3/8G2y0eAeWGzeOSVRJCk7AUFLF2+0i3BmDdDWU8tZCnuPI18ookxGLA==
X-Received: by 2002:a05:6a20:7348:b0:1af:baf9:feee with SMTP id adf61e73a8af0-1afde0fba34mr10664628637.26.1715626955376;
        Mon, 13 May 2024 12:02:35 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-63411346db2sm7058480a12.82.2024.05.13.12.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 12:02:34 -0700 (PDT)
Date: Mon, 13 May 2024 12:02:34 -0700
From: Kees Cook <keescook@chromium.org>
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	ast@kernel.org, paul@paul-moore.com, casey@schaufler-ca.com,
	andrii@kernel.org, daniel@iogearbox.net, renauld@google.com,
	revest@chromium.org, song@kernel.org
Subject: Re: [PATCH v11 5/5] bpf: Only enable BPF LSM hooks when an LSM
 program is attached
Message-ID: <202405131202.D31DB2D@keescook>
References: <20240509201421.905965-1-kpsingh@kernel.org>
 <20240509201421.905965-6-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509201421.905965-6-kpsingh@kernel.org>

On Thu, May 09, 2024 at 10:14:21PM +0200, KP Singh wrote:
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
> This patch enables this by providing a LSM_HOOK_INIT_TOGGLEABLE
> variant which allows the LSMs to opt-in to toggleable hooks which can
> be toggled on/off with security_toogle_hook.
> 
> Signed-off-by: KP Singh <kpsingh@kernel.org>

With the issue Tetsuo noted fixed:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

