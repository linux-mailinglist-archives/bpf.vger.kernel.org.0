Return-Path: <bpf+bounces-35043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0BA93725D
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 04:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E0D81F21D89
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 02:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1C34EB45;
	Fri, 19 Jul 2024 02:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TOdu95Uj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDB9AD5B
	for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 02:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721354891; cv=none; b=WAqDfj7ZR0JTtkL5IDjhEBjRduuogx8VEa7s9iPFDREhfpUV5hwvMukAnsAeK0O6JvTReLp0oRaSLydk9NKQGIybAjRsqbHo55i/GisL5Y4fYw5xayZP0dH7AeEtyjfL95B5iOhxdpdhPbSxraJVfklc7TWisiEHiL6IDq78nFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721354891; c=relaxed/simple;
	bh=VmKDvFgpz/E83Ibzf8dU/pBFko/O1qd4sreAXbduhsc=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=YPenTeYOnwBcNUtEBgl/71fWFIjpnmfV4ckzQVIURve3lUh5vaVJS8MUdj95ygqWBVJKttpFxrvzkB85r/JxHOw/vXveycGGndLHBxkJwxP67fsJwsvaG3/qrc6jl2Jfl8eoC5BSWhXHyVC1B5zeq7eUVksxJQPtd4AsGi7PnE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TOdu95Uj; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-48ff8aa6081so471833137.1
        for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 19:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1721354888; x=1721959688; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7WJIAU9I1siplxW26ihrUPrlbSZPb9UDEgIONz1gVMM=;
        b=TOdu95UjVwn4OZ5EVBmq3u8ej6E779CltdzldQHRbLERFOmqzi/yFkJySUkDo8Q02S
         MmucwBK1/1SuoKkSRBdsKjSIMKhWdeSiaycI+cPxmECXQfvR2aKbY5BqsDOmsa9reAiT
         yZ7bvOVdN44uSSjzR3r+AK3FuhKiXFlE7LBF+eoO2hM8dKX3JPrYRO1Tt76HeIppxIJO
         YL9vaEz9ychYf25oJ7bS2x1fcHAkxjGl+OFJpJnLe10FyE3LnpoKpRsAb+U0+VJFPg7E
         YO22VimpGBJG0zZfGZkh7vMaKtbE/8Y1Bo6vXm1EeU0MNoLkSYueNMQn4LdZP9hfWwq8
         qoBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721354888; x=1721959688;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7WJIAU9I1siplxW26ihrUPrlbSZPb9UDEgIONz1gVMM=;
        b=ElbcfPq1cvNRjZuHP7bP61cnZ8WJ0CU5Di2q0sHOVS06AqvgB3l/FhO1SURoDL9BF/
         G47skz4zjfKBAihRkqJq5Yp13U77g9xEwb/FDjJATbUR9JcF2HOPxNCgHcpBTjOBFlAf
         LNWXyy9aNs1f/mNZNeBuwwM//g8onEOkmnKlndFob4Mi9MIJ1U/EUaDqjVKHCqaAvrHS
         k6l3eI3oFO4u5GVQTNBhBQWyK6jihzyxhtP7ErT5SlWjouALMerL917NEZsNDll4ED14
         RVo4/Dma2XEyQ6G/OPnGIEoOV6qlSOPJcqrmL6NQdEXwydfLgkeuBo28xxpuMBujBWcy
         t/hg==
X-Forwarded-Encrypted: i=1; AJvYcCVVUGDEErw4nchv/jkvZJ4VJshIvgqdrf51ItmaN0h15fjNySh2NRYSrCwUPHa/exmHD6sIEKKWWRYHGqjCm69bEGt1
X-Gm-Message-State: AOJu0YzcLEJ8lI3iJ+QU507MW/qUF1sbDR24THWifrdmtsa9TRoPUd5s
	XrA5Qwr9Dz1zRXWN2eGXfeBEiMh6nMLFP5ztHFf5jicrveRn3itEkcbHNiNSxg==
X-Google-Smtp-Source: AGHT+IEfFmWT5d1hhUBnOOZYB8cD3VARfyIizd2JvZZpXpXUEgCBoIWvB9rnP0zsX/VlF1HVVridVA==
X-Received: by 2002:a05:6102:5687:b0:48f:c031:3fa9 with SMTP id ada2fe7eead31-4915987763amr8039245137.12.1721354888569;
        Thu, 18 Jul 2024 19:08:08 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7acb0a15bsm1723896d6.138.2024.07.18.19.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 19:08:08 -0700 (PDT)
Date: Thu, 18 Jul 2024 22:08:07 -0400
Message-ID: <94a3b82a1e3e1fec77d676fa382105d4@paul-moore.com>
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
Subject: Re: [PATCH v4 9/20] lsm: Refactor return value of LSM hook  key_getsecurity
References: <20240711111908.3817636-10-xukuohai@huaweicloud.com>
In-Reply-To: <20240711111908.3817636-10-xukuohai@huaweicloud.com>

On Jul 11, 2024 Xu Kuohai <xukuohai@huaweicloud.com> wrote:
> 
> To be consistent with most LSM hooks, convert the return value of
> hook key_getsecurity to 0 or a negative error code.
> 
> Before:
> - Hook key_getsecurity returns length of value on success or a
>   negative error code on failure.
> 
> After:
> - Hook key_getsecurity returns 0 on success or a negative error
>   code on failure. An output parameter @len is introduced to hold
>   the length of value on success.
> 
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  include/linux/lsm_hook_defs.h |  3 ++-
>  include/linux/security.h      |  6 ++++--
>  security/keys/keyctl.c        | 11 ++++++++---
>  security/security.c           | 26 +++++++++++++++++++++-----
>  security/selinux/hooks.c      | 11 +++++------
>  security/smack/smack_lsm.c    | 21 +++++++++++----------
>  6 files changed, 51 insertions(+), 27 deletions(-)

...

> diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> index 4bc3e9398ee3..e9f857620f28 100644
> --- a/security/keys/keyctl.c
> +++ b/security/keys/keyctl.c
> @@ -1565,6 +1565,7 @@ long keyctl_get_security(key_serial_t keyid,
>  	struct key *key, *instkey;
>  	key_ref_t key_ref;
>  	char *context;
> +	size_t len;
>  	long ret;
>  
>  	key_ref = lookup_user_key(keyid, KEY_LOOKUP_PARTIAL, KEY_NEED_VIEW);
> @@ -1586,15 +1587,18 @@ long keyctl_get_security(key_serial_t keyid,
>  	}
>  
>  	key = key_ref_to_ptr(key_ref);
> -	ret = security_key_getsecurity(key, &context);
> -	if (ret == 0) {
> +	ret = security_key_getsecurity(key, &context, &len);
> +	if (ret < 0)
> +		goto error;

Since there is already an if-else pattern here you might as well stick
with that, for example:

  if (ret == 0) {
    ...
  } else if (ret > 0) {
    ...
  }

... you should probably add a comment that @ret is -ERRNO on failure,
but it doesn't look like you need an explicit test here since the error
case will normally fall through to the 'error' label (which you shouldn't
need anymore either).

> +	if (len == 0) {
>  		/* if no information was returned, give userspace an empty
>  		 * string */
>  		ret = 1;
>  		if (buffer && buflen > 0 &&
>  		    copy_to_user(buffer, "", 1) != 0)
>  			ret = -EFAULT;
> -	} else if (ret > 0) {
> +	} else {
> +		ret = len;
>  		/* return as much data as there's room for */
>  		if (buffer && buflen > 0) {
>  			if (buflen > ret)
> @@ -1607,6 +1611,7 @@ long keyctl_get_security(key_serial_t keyid,
>  		kfree(context);
>  	}
>  
> +error:
>  	key_ref_put(key_ref);
>  	return ret;
>  }
> diff --git a/security/security.c b/security/security.c
> index 9dd2ae6cf763..2c161101074d 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -5338,19 +5338,35 @@ int security_key_permission(key_ref_t key_ref, const struct cred *cred,
>   * security_key_getsecurity() - Get the key's security label
>   * @key: key
>   * @buffer: security label buffer
> + * @len: the length of @buffer (including terminating NULL) on success
>   *
>   * Get a textual representation of the security context attached to a key for
>   * the purposes of honouring KEYCTL_GETSECURITY.  This function allocates the
>   * storage for the NUL-terminated string and the caller should free it.
>   *
> - * Return: Returns the length of @buffer (including terminating NUL) or -ve if
> - *         an error occurs.  May also return 0 (and a NULL buffer pointer) if
> - *         there is no security label assigned to the key.
> + * Return: Returns 0 on success or -ve if an error occurs. May also return 0
> + *         (and a NULL buffer pointer) if there is no security label assigned
> + *         to the key.
>   */
> -int security_key_getsecurity(struct key *key, char **buffer)
> +int security_key_getsecurity(struct key *key, char **buffer, size_t *len)
>  {
> +	int rc;
> +	size_t n = 0;
> +	struct security_hook_list *hp;
> +
>  	*buffer = NULL;
> -	return call_int_hook(key_getsecurity, key, buffer);
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.key_getsecurity, list) {
> +		rc = hp->hook.key_getsecurity(key, buffer, &n);
> +		if (rc < 0)
> +			return rc;
> +		if (n)
> +			break;
> +	}
> +
> +	*len = n;
> +
> +	return 0;
>  }

Help me understand why we can't continue to use the call_int_hook()
macro here?

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 16cd336aab3d..747ec602dec0 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6737,18 +6737,17 @@ static int selinux_key_permission(key_ref_t key_ref,
>  	return avc_has_perm(sid, ksec->sid, SECCLASS_KEY, perm, NULL);
>  }
>  
> -static int selinux_key_getsecurity(struct key *key, char **_buffer)
> +static int selinux_key_getsecurity(struct key *key, char **_buffer,
> +				   size_t *_len)
>  {
>  	struct key_security_struct *ksec = key->security;
>  	char *context = NULL;
> -	unsigned len;
> +	u32 context_len;

Since @len doesn't collide with the parameter, you might as well just
stick with @len as the local variable name.

>  	int rc;
>  
> -	rc = security_sid_to_context(ksec->sid,
> -				     &context, &len);
> -	if (!rc)
> -		rc = len;
> +	rc = security_sid_to_context(ksec->sid, &context, &context_len);
>  	*_buffer = context;
> +	*_len = context_len;
>  	return rc;
>  }

--
paul-moore.com

