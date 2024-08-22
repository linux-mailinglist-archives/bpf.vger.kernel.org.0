Return-Path: <bpf+bounces-37875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F0E95BBE8
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 18:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33F6D1F28801
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 16:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F84E1CCEEC;
	Thu, 22 Aug 2024 16:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BRCM2yBX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3CF1CCECF
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 16:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724344058; cv=none; b=hPoS+KWTncF6hN49ON7e36S3ag0JRZpBMs+URcz+bnGeDCsURQQC3QxFfXynKeK4K0BLHQD83hv/FiYodYStNiO/uP0GUtFfJ73R6N9pXOt0kc8v/dsSlS8uMKk88xVMyFdyI1JuswtorZWuEobmrv/SRbczg9tJ9TX0pukYphM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724344058; c=relaxed/simple;
	bh=/r98ROwev/jnRYgKVKK60ItlcEsAtB6Ak/Bqy+2sao8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nyh91xRjua3mV2cdVXFVfO+TItyH8KCzz9XCWSoDyZhHRfQAb3ALw17I04w4/ixcRZ3aX9TpngFADpaFt9LKjCJ2h4NV7XkjsxXjpZivjxhFhm0Q5kb7kcx0wRVrDSi3JK1kEnKhQ+lt37GwtrRBCxVs1U+JdkMa5Gt0lIg0yIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BRCM2yBX; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e13c23dbabdso963878276.3
        for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 09:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724344055; x=1724948855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z179nEdp6MHIRUAsTk7YI6gwzjTXq2xOdFVOnRR/ORg=;
        b=BRCM2yBXUAqJC76G7+HrqsSIa3tKtWepyfldqt3Sej9qxfq+ZuAFRRR7K9D4zA9pVG
         Djl1tDlKcJ6SBANTc7c5+RCeGS3h7KYnNR6wxpcLjp1cO6vYvcRsShF7/XDj47MGSlM4
         tmCEQKB/nHZzTGW8gy4Y8BzhEQYWxcJ3XwF76quxkangxjS4JzUF7HWK+M41T8IQpcX3
         ZP7nP+YYdqvcCa8d29w7VrMraYVHUsGUKkOpYB6us6TOrLbZ9TYjuuOCiUEYqq/Vf+4/
         esnWapl20LmiMfTscO+WsU7wRa2ZSwCaLSTcBQs2/VXCNDdRC/DXk+D2IHOUbjdW2doP
         B5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724344055; x=1724948855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z179nEdp6MHIRUAsTk7YI6gwzjTXq2xOdFVOnRR/ORg=;
        b=rEC3mI0p4wYz2zZFbvAc47N5kJxKb8lu01R8ghJ15jn7EbTbUsGeMbNSWRAyvc6zn3
         Rcsk56IbvX8OiQE6R1zYrH+FfHe4AzXgZyqHnm7imgOOVSZifmKrkSaha/uXTbmxkAhM
         hh4KOIBVp0LXjbbkXbyT6jOok52L5YD3cIYGiGBZ67w5nyKCrvjbdznIxUmfWgv/jmjb
         v+oJi1TAnkW547OH+m/D5UQqh0ODwBRHBRgamqVJA9G6cUP4kG5fm8YlExu5dvYgRCnY
         D78G/UNWfhSO3qA5TUu2L/POBRaHEBk7Iz2QIZZgys8de4gQi3WHg8MNI8+uEVaCvowH
         7dWw==
X-Forwarded-Encrypted: i=1; AJvYcCV4v67wd4+8A5pl3Rj2rTBNR8rr2PatZsrLbbgk8dskoAEshrUvO/FDM1s2H9FMPoQBTrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCKucjvu7noNSbWwq+HtrD4SxVu9ZNlgiEHG+a5QLiC+a3GCMF
	h8mb6tq8a+1LdJNazjLZJEfBZpuTCQZfQTQ85AR+skNCp0wPddkgZrwtHd4DKcNg1kn3nEm1gSq
	Vax4/sm85KFnwF7ShibpXIVQO6clvHlfrQuk2
X-Google-Smtp-Source: AGHT+IHbuNlT8o2Tf3GmwDyhrC662qWbabqzb4WX4jdb3C79i3cJ+Vn+iCpk4YFIVj2gOREtdj/R4hx4Jmrpr7d6N8g=
X-Received: by 2002:a05:6902:2e0f:b0:e16:5177:7598 with SMTP id
 3f1490d57ef6-e17902d8038mr2700324276.16.1724344055212; Thu, 22 Aug 2024
 09:27:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816154307.3031838-1-kpsingh@kernel.org> <20240816154307.3031838-4-kpsingh@kernel.org>
In-Reply-To: <20240816154307.3031838-4-kpsingh@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 22 Aug 2024 12:27:24 -0400
Message-ID: <CAHC9VhTjasfP3YMP8xD1jgaY8KFsZuzRCzeVMK73DTxm538x_w@mail.gmail.com>
Subject: Re: [PATCH v15 3/4] lsm: count the LSMs enabled at compile time
To: KP Singh <kpsingh@kernel.org>, wufan@linux.microsoft.com
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	casey@schaufler-ca.com, andrii@kernel.org, keescook@chromium.org, 
	daniel@iogearbox.net, renauld@google.com, revest@chromium.org, 
	song@kernel.org, linux@roeck-us.net, Kui-Feng Lee <sinquersw@gmail.com>, 
	John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 11:43=E2=80=AFAM KP Singh <kpsingh@kernel.org> wrot=
e:
>
> These macros are a clever trick to determine a count of the number of
> LSMs that are enabled in the config to ascertain the maximum number of
> static calls that need to be configured per LSM hook.
>
> Without this one would need to generate static calls for the total
> number of LSMs in the kernel (even if they are not compiled) times the
> number of LSM hooks which ends up being quite wasteful.
>
> Suggested-by: Kui-Feng Lee <sinquersw@gmail.com>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Acked-by: Song Liu <song@kernel.org>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> [PM: subj tweaks]
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  include/linux/args.h      |   6 +-
>  include/linux/lsm_count.h | 128 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 131 insertions(+), 3 deletions(-)
>  create mode 100644 include/linux/lsm_count.h

...

> diff --git a/include/linux/lsm_count.h b/include/linux/lsm_count.h
> new file mode 100644
> index 000000000000..73c7cc81349b
> --- /dev/null
> +++ b/include/linux/lsm_count.h
> @@ -0,0 +1,128 @@

...

> +/*
> + *  There is a trailing comma that we need to be accounted for. This is =
done by
> + *  using a skipped argument in __COUNT_LSMS
> + */
> +#define __COUNT_LSMS(skipped_arg, args...) COUNT_ARGS(args...)
> +#define COUNT_LSMS(args...) __COUNT_LSMS(args)
> +
> +#define MAX_LSM_COUNT                  \
> +       COUNT_LSMS(                     \
> +               CAPABILITIES_ENABLED    \
> +               SELINUX_ENABLED         \
> +               SMACK_ENABLED           \
> +               APPARMOR_ENABLED        \
> +               TOMOYO_ENABLED          \
> +               YAMA_ENABLED            \
> +               LOADPIN_ENABLED         \
> +               LOCKDOWN_ENABLED        \
> +               SAFESETID_ENABLED       \
> +               BPF_LSM_ENABLED         \
> +               LANDLOCK_ENABLED        \
> +               IMA_ENABLED             \
> +               EVM_ENABLED)

The above is missing an entry for IPE; I missed this during the merge,
thanks to Fan for pointing it out.  As the IPE patchset was merged
into the lsm/dev tree only a few hours before this patchset, that
isn't your fault, it's mine :)

Regardless, it should be fixed in lsm/dev now.

--=20
paul-moore.com

