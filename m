Return-Path: <bpf+bounces-71031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F536BDFAF4
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 18:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8150E4FE674
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 16:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B018338F23;
	Wed, 15 Oct 2025 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0oNVvXQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3EA2EBBA4
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 16:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760546168; cv=none; b=j+A571RecVThgt/ZVF9eMwEx9lZkhwtpDmSojm2D53Ae/cyOTGYIqTwmBN3a3JuPFIvIjhxPR9rGokD9Fbg3JMC2M0pOKRO4tsTUJUlbhMBHlYzssty27vJkIHzqEt1qywR4OVKKHI6KEE9m9xyW4hjKfJhlPyDkmr4iYpLg78g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760546168; c=relaxed/simple;
	bh=xH40ds73k+2XlYhTO+MkHbE0jGwPWYCtKVwxkuUpaVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bkit8Cduik3RHnXjLQZtZjk5OoZGlFXSORNRWQmiZGGyF8wSRsO67Qo5vuYljVzn9o4ciHYf4GRauF/6IiMq4VAYv55b1DWoEEqUtotPuVck8OiE1iL8al56uvcC9C7twieU/ljG/Cr5hFN0Eyr9ZuiSBsR2fzMFl4Gwm+8nImg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0oNVvXQ; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-33b9df47d7dso350450a91.0
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 09:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760546165; x=1761150965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pkn+CqkssDx8H+vXeI6R3v2XcqWE9l2NOxynVDwDTlI=;
        b=k0oNVvXQLiHvQYjLFNQ87ElZq4C42/eyoPEuxcBR6dYuYolDFxM06MmV7EzetI92aE
         bduTm/PHLuBaHgPlua9d3yPKLt16KuGqSWDm4nCP929mIcpdAXHPD5crAZ2/PHtEhi66
         5AZXsaiLceqBPmWP1/oYB+yWpFGNQIZ+pTHasR+RUrWKBi/FTqF/gu/V02NBmVrRI24w
         7a9PguXhUpV0tCtjxfCHqSj9NXD1J1U2QG19S4FPvaVDAAmBX+ahJPX5BSpNrNiZ2ShN
         Wf0AZMy56hDiAQKR6xMbc+bTWn8MxQEBkM3Io1UiXL6Bp4nA7anwF9bGScAlf3ewLcaz
         h/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760546165; x=1761150965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pkn+CqkssDx8H+vXeI6R3v2XcqWE9l2NOxynVDwDTlI=;
        b=FSZXbAE5h8VJx1zGKjme4+2lfokn2BgGH0z0J5vnAMNCgrt1nL/AYg/Gww76ELcWD6
         XVIZ3LO/fCIfjhd+WhrgMYVnBbLzQ8SfxBO6Hy7nzEzLQrprmlKKl/auXHDEtV1E9Xsm
         QXLNVxP0EjZ78iN+5QX5MeXXi36DQ13vMUZa2U112gRCElAf6OcdlMvzNrWtvC2DHHbQ
         Jm/BppUiIEpROkpO+H4PFatSwL516NyHdzwauKccZ6IYt0ctDZwSu7I0ns/SonDHnlVA
         Kd/KWjuaO1mupkQXBoBxPgXucYp0IrQVDP+V1C7lXwnZWHwOucBose7bxano2nGNeIT6
         MU4w==
X-Forwarded-Encrypted: i=1; AJvYcCXTzY2VsAZbQDA9xW6gd/B4FsZBgz+S6Am53E2QdB8WrPxCz3Gf9T0FryDKmMsTdgCEyGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywro3mOHAWbhhVk/f4N13xtTqb5u/ZTtC1dggA9/4r5XppXNwzo
	aSzOR01szzeCoyjucL+kuU/5gOE42OWqRpI3L+uoso8j5ppfvqvtjHvVCD9iVojB4Lmj87LBB2x
	IOo78zG0Q+E6ySSTPbG4DMbJ5CXYWioo=
X-Gm-Gg: ASbGncu5+zwMaEyhLam3VVM3zPkXB5nCjHusNyR5e6slwzkG74JmgPwm+UGFrnaR8JI
	s3v0vOyBQGNoXmS3zosW5IPLSH+VSJeL7Ks2EnIOAa8Cd7nuyo053i9b5Y4U3swyzFIqSKtfIT3
	z9ufyRkiKeym4pXb7Zca2FSKtXKEeEoiwrIwvazrsWvcJ8LX/FBQCkl5aqxCtRPgSZ/t2RBY+EK
	hYbAQoYa4FgnBMr1OzL10SSDIgP5aAQ9vmsAo3DliDnKplfiqdoia5s82yU/eI=
X-Google-Smtp-Source: AGHT+IFGNrAI2dq3NSrRL0OcSYM4Z5okAFYQKhuh27ccqKymPLtZeC7L6zTwS+qJQzu1LIvsGty8JwB7F48ezlC7tv0=
X-Received: by 2002:a17:90b:3ec6:b0:339:ec9c:b26d with SMTP id
 98e67ed59e1d1-33b510f8488mr41389554a91.8.1760546165323; Wed, 15 Oct 2025
 09:36:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015141716.887-1-laoar.shao@gmail.com> <20251015141716.887-7-laoar.shao@gmail.com>
In-Reply-To: <20251015141716.887-7-laoar.shao@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 15 Oct 2025 09:35:52 -0700
X-Gm-Features: AS18NWADyZQhCWHApHI8yY-s9dj0g7hVHDNjJ__LLzs5iWjWLcNDNGLGYWesqlU
Message-ID: <CAEf4BzZYk+LyR0WTQ+TinEqC0Av8MuO-tKxqhEFbOw=Gu+D_gQ@mail.gmail.com>
Subject: Re: [RFC PATCH v10 mm-new 6/9] bpf: mark mm->owner as __safe_rcu_or_null
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com, 
	gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, ameryhung@gmail.com, 
	rientjes@google.com, corbet@lwn.net, 21cnbao@gmail.com, 
	shakeel.butt@linux.dev, tj@kernel.org, lance.yang@linux.dev, 
	rdunlap@infradead.org, bpf@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 7:18=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> When CONFIG_MEMCG is enabled, we can access mm->owner under RCU. The
> owner can be NULL. With this change, BPF helpers can safely access
> mm->owner to retrieve the associated task from the mm. We can then make
> policy decision based on the task attribute.
>
> The typical use case is as follows,
>
>   bpf_rcu_read_lock(); // rcu lock must be held for rcu trusted field
>   @owner =3D @mm->owner; // mm_struct::owner is rcu trusted or null
>   if (!@owner)
>       goto out;
>
>   /* Do something based on the task attribute */
>
> out:
>   bpf_rcu_read_unlock();
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  kernel/bpf/verifier.c | 3 +++
>  1 file changed, 3 insertions(+)
>

I thought you were going to send this and next patches outside of your
thp patch set to land them sooner, as they don't have dependency on
the rest of the patches and are useful on their own?

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c4f69a9e9af6..d400e18ee31e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7123,6 +7123,9 @@ BTF_TYPE_SAFE_RCU(struct cgroup_subsys_state) {
>  /* RCU trusted: these fields are trusted in RCU CS and can be NULL */
>  BTF_TYPE_SAFE_RCU_OR_NULL(struct mm_struct) {
>         struct file __rcu *exe_file;
> +#ifdef CONFIG_MEMCG
> +       struct task_struct __rcu *owner;
> +#endif
>  };
>
>  /* skb->sk, req->sk are not RCU protected, but we mark them as such
> --
> 2.47.3
>

