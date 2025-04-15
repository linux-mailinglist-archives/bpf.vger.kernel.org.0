Return-Path: <bpf+bounces-55916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 140EBA89179
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 03:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C6FB189C0F3
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 01:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75C41F30B3;
	Tue, 15 Apr 2025 01:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UyGPpseq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD9919DF7D
	for <bpf@vger.kernel.org>; Tue, 15 Apr 2025 01:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744681081; cv=none; b=DNcnXeobFjikpnY5mEXFQyxOtulgZ8nAjA3jbiIjHdzqAa8Xh8tAdm7NtPPTPsnpEFQPds/+UpJdF3ChOlUKj0KE/YznTGqhozuB7vOIPfN/ey51L/PcBuIGUoEcTQ37kFdp2PiYfdvdZt6HXLv7E3HyhODtNT9JBpypDryGO+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744681081; c=relaxed/simple;
	bh=nnSwVQEmzGQiBeSzekmrr/5D5+/Kj5ljs92bYT66phg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MZyIk5r7qxcWAP2sMgW/HIn2NTfnlZsB7OMlJRoJvXbJxHFCN2kuULPoI10cpchBWZ+G0AE2NJXj8AGCJS209KN24JpX0DkaozxJzRZ7pKhM4KWZ7zDWLoAAEJ+lZsLMnWG/cTl32n1eWdxx//DYcPp6M9qFxzd7qFRfi+vcFpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UyGPpseq; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e573136107bso4463741276.3
        for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 18:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744681077; x=1745285877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmvfG1SQQQWNnAFrc4eRr2gOVcRDAxX6JXskDgWSkhk=;
        b=UyGPpseqMIr5FWt1t8/fTweMybHb8ICvimkGcv7SqUidNJyoA1rE3eqyyK4rkCYVAt
         JuesuxZderCvCHLu7J/wy2+5dgy5Ds/VAm3691Pem68xwhSqciezzHRCT8A6mBt+nPRx
         KBU41Gfl3MKy52eXSCr10GEQZyuvHKx1FrWdGUbeuIIvt6Rlh9DH1hxztlLec+ExxLQQ
         PWJNsQ9Gy3ZxwfmuMVRMar8Gamz+e0SX/blsUEDoet5FzTVA8Dh0GIZu6oSeIgvaReA8
         UUbjCMDY4uJ8kZrkDXv8HIhVc6jL5tzSHyeubtilCFb/H+91BY2/saK3ti2PvlqIXW1w
         H1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744681077; x=1745285877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmvfG1SQQQWNnAFrc4eRr2gOVcRDAxX6JXskDgWSkhk=;
        b=ERBD0QYe86eQv6498V0GwmlvlEfENMSOpe0FxwZedSU/V4Ge4n1Z/wVJk7GGFuYw5n
         Ip5s391oD0kyC+Oq7syJComLOKZXff1ujkightqSWPZ9K2zBvsKojoLtT3JtPwXOOR7s
         Ysm6QIiNyGnjilxSsoH352x97Vkiv/AdRaOSJPd9RE3JXKKhw4QaqSrhnQcLavKhX7nG
         8Yg1nwAyUCdpN3951ljV5hQLg9qQsr0ah5SKBhu7fbsV3G1/24PRQaCdL7/PeCfpxx7R
         uK+8dNS2q0vWbxUvOxm80WU+h0OoV0tqDvK+4auvTc6xgyLAQ9zreSGkgXsRBxEbUBC0
         3ivQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP+VRTEAP+wME/AEsBAZPoBGHBXs8YB61hSLj6CctkpW0bOlh2Qvay0s25yI7dTVTgnv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQhVzBMhT3j2DAgLSEYq20AXfZniXwF5euW+AXUkMhwHFxwkXF
	3bj53Lsh/DO/7h8r48zdgJjPeunDYoARpT88ZE6pXh8LvJWdvx4fYSUxLsNSya/tZQ0bJWmBe8y
	7mJEb3xXJJHclQbZmfeBr+CkM/+yaPxWnbOdU
X-Gm-Gg: ASbGncsIUhhCyFkwupT1aHMKY9e0CoCP9qt7VuUY3KFKIWHV3UMRGDTvWuzcxgPZvE3
	HYErUHqE7f6rbYjbkBJYbX8oAUP8vNpMMobIgdxjfyCuUfZ7cr+HdJUeihIIgcbPycSup4PzoEQ
	UOA1XTEIhGz0vC1hX39T2LTHgDsaxTnxwT
X-Google-Smtp-Source: AGHT+IGVFpWpZi+wTlwkHFutHe8bqQ5rjA+H2o0mhaXEz1HFA8h8I8OEvnDz+zZIg9Hq6o5FyhzxVV34XBFz3VTMiPA=
X-Received: by 2002:a05:6902:d43:b0:e63:ebbf:7ea with SMTP id
 3f1490d57ef6-e704df842b4mr23249055276.39.1744681077563; Mon, 14 Apr 2025
 18:37:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404215527.1563146-2-bboscaccy@linux.microsoft.com>
 <d3ad9a7bb9eb68a3ae5dd18bf091825d@paul-moore.com> <87ikn6jwt2.fsf@microsoft.com>
In-Reply-To: <87ikn6jwt2.fsf@microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 14 Apr 2025 21:37:46 -0400
X-Gm-Features: ATxdqUFeWe8YQ9KNwKtLxVB-kJkAnedXLrtL9lJ0sVjc8DBpxOzeoo2ai7wuYBI
Message-ID: <CAHC9VhTugESMrL8=+b45j3rTKykypZN31in0-cq_FcQF+3nYCg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] security: Hornet LSM
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Jonathan Corbet <corbet@lwn.net>, David Howells <dhowells@redhat.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Jan Stancek <jstancek@redhat.com>, Neal Gompa <neal@gompa.dev>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, llvm@lists.linux.dev, nkapron@google.com, 
	teknoraver@meta.com, roberto.sassu@huawei.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 4:46=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
> Paul Moore <paul@paul-moore.com> writes:
> > On Apr  4, 2025 Blaise Boscaccy <bboscaccy@linux.microsoft.com> wrote:

...

> >> +static int hornet_check_binary(struct bpf_prog *prog, union bpf_attr =
*attr,
> >> +                           struct hornet_maps *maps)
> >> +{
> >> +    struct file *file =3D get_task_exe_file(current);
> >> +    const unsigned long markerlen =3D sizeof(EBPF_SIG_STRING) - 1;
> >> +    void *buf =3D NULL;
> >> +    size_t sz =3D 0, sig_len, prog_len, buf_sz;
> >> +    int err =3D 0;
> >> +    struct module_signature sig;
> >> +>> +        buf_sz =3D kernel_read_file(file, 0, &buf, INT_MAX, &sz, =
READING_EBPF);
> >> +    fput(file);
> >> +    if (!buf_sz)
> >> +            return -1;
> >
> > I'm pretty sure I asked you about this already off-list, but I can't
> > remember the answer so I'm going to bring this up again :)
> >
> > This file read makes me a bit nervous about a mismatch between the
> > program copy operation done in the main BPF code and the copy we do
> > here in kernel_read_file().  Is there not some way to build up the
> > buffer with the BPF program from the attr passed into this function
> > (e.g. attr.insns?)?
> >
>
> There is. That would require modifying the BPF_PROG_LOAD subcommand
> along with modifying the skeletobn generator to use it. I don't know if
> there is enough buy-in from the ebpf developers to do that
> currently. Tacking the signature to the end of of the light-skeleton
> binary allows Hornet to operate without modifying the bpf subsystem and
> is very similar to how module signing currently works. Modules have the
> advantage of having a working in-kernel loader, which makes all of this
> a non-issue with modules.
>
> > If there is some clever reason why all of this isn't an issue, it might
> > be a good idea to put a small comment above the kernel_read_file()
> > explaining why it is both safe and good.
> >
>
> Will do. I don't see this being an issue ...

My mistake, I spaced out a bit when looking at this and for some
reason thought it was reading the BPF program/lskel itself and not the
signature, meaning that the BPF that was being checked by Hornet was
not necessarily the same BPF that was actually loaded.  However,
that's not the case here, as you rightly point out it is just the
signature that is being read by the kernel_read_file() which shouldn't
be an issue.

Thanks for the correction and sorry for the noise :)

--=20
paul-moore.com

