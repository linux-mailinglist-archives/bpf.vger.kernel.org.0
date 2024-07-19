Return-Path: <bpf+bounces-35037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 002E193723A
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 04:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CFFB1F21CA5
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 02:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8588C8494;
	Fri, 19 Jul 2024 02:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Z5IJkzsp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FEE9475
	for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 02:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721354885; cv=none; b=eImciDY3/wMskMc6R5COTc9nTwjdkQdTdSuZRxQeqTESQhKUJRWOwGExi46xnPCfs6DV7pXdeBONrZCoFQ4r+WiIwrFuApTKmgZ0xD0FW0wbKjPyWIDeAyJSPqba1qI9SW60c2UBel3Qv4QPaRyuKW5VHpcS+3Ys8KIB15f72XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721354885; c=relaxed/simple;
	bh=+jANaNZ1uHYDfjV0wEeG5sQYqdgRrNtGRZ39cOP++f4=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=bWAZ/50Q31QsUxsFfVB2+pbQ3DFRqoZjr9zwiAcbDQV+9tseInLjo35rIoG3Lv4PuL8IhRpBLsnbUmj5AYnULQBM6rrTA5oCM0OWxJJ364OP7ZSB1uMxsf+y0VaSCa3Alc9VwdRc7rJOQwLMfEvvXHhcgr5O2z8eE5mIYiYFqvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Z5IJkzsp; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6b7a36f26f3so8355176d6.1
        for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 19:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1721354882; x=1721959682; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qpUClzeR8WUAL/85YFkQrfnDMzFYM1Y27FAQCvWcN9Q=;
        b=Z5IJkzspjONUQy+7giNPV4aDWSsOissdYpbaeSMvt0Z/gCiSH7XXZjWpGE6JtjVHDQ
         UWA6acGP/+mktE1QmyJqL5Y9preDcRLimxsfvVDUkxmjkc/nTDhoE8f5LX3KLJn8HebB
         HARxX68tUmx5EX8lYQovIn7tJtMfuEyiUgBz4BDCSxCAwXvhURj7i/nl4f+rYh8N1B0E
         yT59fE6qtA54t9YB3eHlxtNWRTPqJ863KpWtFN1mdy9A+jrPCxnUCfKCN/0+bhKlbxpv
         ucrPHMb9WWtz9ZxV/OdXnzovCs5FnzUOXGNX7a0dJ+9agEioXNbHaC556heDk/9kBafW
         tr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721354882; x=1721959682;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qpUClzeR8WUAL/85YFkQrfnDMzFYM1Y27FAQCvWcN9Q=;
        b=WpMCzkg8osWyo3R9i8PdgZ2K9vyU3EQNdm3Zum0UgWDteU6Vc4QNWPrOZ7W5UEP79Y
         QnzaAKJ5rSEBBhI7y7Cz0nEHZKJLrZDDpGddnPnwU0KP4XqYyL1ZxFM+vokVxHr7ogt2
         ufk24krNWGj7O3tGoJGW3ztgt+RR5CGPz2vZWVM8DEaCMEcvbWxp8XDduFfoqvhP0YSO
         CmSZhwj7CaAr0waTeI7qRlKwjYMP4SJGLfVLsft1lsEepsSsMBvjFslZmZpn6MbDGHRX
         GlZKuUtm4YMz2j4VvG/QUtVJvPj0OWQEFrRV1RYx953UbqycxvtbUFnIAyxP7aMPiGgZ
         uxfg==
X-Forwarded-Encrypted: i=1; AJvYcCXdhxTqMzPe3jH5GoQqfKMP8CqtEZAOCEB03olVH+YmVqkPGGn2aELqXD3JcNzsgyHI67QjsP/XTgZY9uv1GU0dBeQA
X-Gm-Message-State: AOJu0YwAyS6CIUY/hw3d9DMzhZijRo0qdXStsPs1dNsKwii7dx++mV8S
	LJ1H2ssY73D0pteOey+Xj7RI6WUnqxt10iMgnoW6hvAERsm+RkQ106BSj6QjAQ==
X-Google-Smtp-Source: AGHT+IHEUtiYsL4YugJiIyZ94uYFP7Pn9ZMTuclQ82/x8BDKHK0utglqJt/CxhW41ZG/NKpa0e+C4Q==
X-Received: by 2002:a0c:eb83:0:b0:6b2:a68e:6cf5 with SMTP id 6a1803df08f44-6b79cbe7860mr83634476d6.5.1721354882351;
        Thu, 18 Jul 2024 19:08:02 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7acaf3bc3sm1717036d6.125.2024.07.18.19.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 19:08:01 -0700 (PDT)
Date: Thu, 18 Jul 2024 22:08:01 -0400
Message-ID: <bae9304f6fd9ac9536f709a990085119@paul-moore.com>
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
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-integrity@vger.kernel.org, apparmor@lists.ubuntu.com, selinux@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Brendan Jackman <jackmanb@chromium.org>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Khadija Kamran <kamrankhadijadj@gmail.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Kees Cook <keescook@chromium.org>, John Johansen <john.johansen@canonical.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, Edward Cree <ecree.xilinx@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v4 3/20] lsm: Refactor return value of LSM hook  inode_getsecurity
References: <20240711111908.3817636-4-xukuohai@huaweicloud.com>
In-Reply-To: <20240711111908.3817636-4-xukuohai@huaweicloud.com>

On Jul 11, 2024 Xu Kuohai <xukuohai@huaweicloud.com> wrote:
> 
> To be consistent with most LSM hooks, convert the return value of
> hook inode_getsecurity to 0 or a negative error code.
> 
> Before:
> - Hook inode_getsecurity returns size of buffer on success or a
>   negative error code on failure.
> 
> After:
> - Hook inode_getsecurity returns 0 on success or a negative error
>   code on failure. An output parameter @len is introduced to hold
>   the buffer size on success.
> 
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  fs/xattr.c                    | 19 ++++++++++---------
>  include/linux/lsm_hook_defs.h |  3 ++-
>  include/linux/security.h      | 12 ++++++------
>  security/commoncap.c          |  9 ++++++---
>  security/security.c           | 11 ++++++-----
>  security/selinux/hooks.c      | 16 ++++++----------
>  security/smack/smack_lsm.c    | 14 +++++++-------
>  7 files changed, 43 insertions(+), 41 deletions(-)

Aside from Simon's concern over variable types, I saw a few other issues
when looking at this patch (below).

> diff --git a/security/commoncap.c b/security/commoncap.c
> index 17d6188d22cf..ff82e2ab6f8f 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -485,7 +485,10 @@ int cap_inode_getsecurity(struct mnt_idmap *idmap,
>  	}
>  out_free:
>  	kfree(tmpbuf);
> -	return size;
> +	if (size < 0)
> +		return size;
> +	*len = size;
> +	return 0;
>  }

We should do a better job converting cap_inode_getsecurity(), create a
new local variable, e.g. 'int error', and use it to store and return the
error code instead of reusing @size.  I understand that what you've done
is easier, but I'd prefer to see it done properly.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 9cd5a8f1f6a3..70792bba24d9 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3407,7 +3407,7 @@ static int selinux_path_notify(const struct path *path, u64 mask,
>   */
>  static int selinux_inode_getsecurity(struct mnt_idmap *idmap,
>  				     struct inode *inode, const char *name,
> -				     void **buffer, bool alloc)
> +				     bool alloc, void **buffer, u32 *len)
>  {
>  	u32 size;
>  	int error;
> @@ -3440,14 +3440,14 @@ static int selinux_inode_getsecurity(struct mnt_idmap *idmap,
>  						&context, &size);
>  	if (error)
>  		return error;
> -	error = size;
> +	*len = size;

Depending on how you choose to resolve the variable type issue, you may
be able to pass @len directly to security_sid_to_context().

>  	if (alloc) {
>  		*buffer = context;
>  		goto out_nofree;
>  	}
>  	kfree(context);
>  out_nofree:
> -	return error;
> +	return 0;
>  }


--
paul-moore.com

