Return-Path: <bpf+bounces-58162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B286CAB6110
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 05:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BD3E4A0ED9
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 03:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494BA1EB197;
	Wed, 14 May 2025 03:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FNhhNUjr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E224786342
	for <bpf@vger.kernel.org>; Wed, 14 May 2025 03:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747191992; cv=none; b=RcvbyIJM7q40YYSBUg3t1Ndin3LFiL7D8fwsF9T4Wk5UbLc5FWg5KQJhgZpkVGUKOZizGmTW/z3wZYqdZuiFTd4wYYGCVYgyY2ZmS6Sfy37i3t4q6hjHyKUtz4HhHmnxBDQY5tAFKJcVtHXlc2J9aChsrP6EZIDx9skL9uE0+vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747191992; c=relaxed/simple;
	bh=QJlpMcodJFABVCXdqNlhN3+5p9vJ34o3HcUPNXekMzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hnTVcnDlH5rUPv0f5ympKhr/UycStaq1HM3f2qHYYlHBtUPqhA/ZENA4xxsCGpwKPh9fUIHL6BhzJyYECcUzQO2mGnKeX6+CiEURfBbkeNaVMvtSILmN8nOy2vcCX3B4+CdD3o6FunDxvdvD+z5/NIRl3Cw+IhLOdV7TG9I9zGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FNhhNUjr; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7099bc957d9so55243767b3.0
        for <bpf@vger.kernel.org>; Tue, 13 May 2025 20:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747191990; x=1747796790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmR0DV4kjICn6tOrrkeV1rJdypEVd85y6xmhHZSq2oM=;
        b=FNhhNUjrSx+AJS72l115atQjxUP4IWUNhyviHRegB2IcJIe4ENlgd2ir+F7sS/piRz
         6e+NeTRDx6lOapnzX4Zpni2YEQzz4b1YsLz5AGv6NG8kvi1gsisFfac9XCbpKYD+B8Xn
         W+XwhJEW044rXo85B1YBqQ3ZLzafj225fXZeNWrx1UF7eoeLmqfySND+MaaIHgfjzUtF
         1TDK8NdtQS9lFZgCzFtWiF8sZmDVI6nqVrtfjLTzjt+t2PcaHQvDvqceqC2SUrMMMJzU
         IpSiBdeW4UNGs+UcG9+JpSjTEZvkuGWBuTvOzmkgvlfjLEVEGUJLq3L0kW1S0ZofGX0J
         zzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747191990; x=1747796790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tmR0DV4kjICn6tOrrkeV1rJdypEVd85y6xmhHZSq2oM=;
        b=nfKJoT5gvc04V197E+mWfOu0DQZhThem83v95SDAEX5/KlWxcKwTkeh0qurQ4mspDM
         /GEUU+6NXBdro3AuNeqhhLmEY+Ldg6GXHnirEsGXlNa2zIPWW8Qg1OWmqi2qPuwarqr1
         k/gcIybHjOvU3NbBKEoo38iRcKkQyv+P2pdK4CiXMFI+zoNMVOvIk7DK579RiYTSsqdM
         Q2PZ3pj4N+VObgpRNEToF0MfpM3qxnaYnafUqxCRRgFVmtfJRlHqKi7UXoyttQcfywZA
         /jb/M2c/xI7eJEgnLYtcSMQe1Yle8kJaAnN03F7s2Dni2Q89kunLfDbdZ5Sx/Dwl4PCB
         0okg==
X-Forwarded-Encrypted: i=1; AJvYcCU5Xft2engxgkmCxgPZMyL/2OVt8us/oXw1S28WJXRVNKwMfWYAWYfAqvsZOHw7PFia2V4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyky47Jcx9MBgfMYkBYadFCS7rjWHaY9TFrM2CRBrqjEWBmSmNR
	Px4PR8Tj05t92de/H13jQpJbYS42VXhHEqKFeOQ4SN2tExzhOHKzVfHxAbTrRaHZBiNx9HdeCO6
	u/QVhoeeX095bj7aBETlKdmUK0gornKzsISO9
X-Gm-Gg: ASbGnctOt7lC1QDopj/JpOwplae2DWMIwn7DCVJZ2cvDn3Rl2pimGVPB7uQ40DTnFta
	3uGWQ3ZpiP4r9iM1J8uULFeGP5C8BmWzPQOG5usTJYEq2NKbHWGcO8q/gL2qCae/76mf7pFSal9
	+TaHI/aa+SK1uBl1gr8ONb4yFcZUDbD3gz
X-Google-Smtp-Source: AGHT+IHoF4lWdSffdXGrv/OfRi9mN4zsQKU0Wx09452hnzxCArs6kDfkdHSQP63wj5stxfEFYGHGU4RZ0y2yDDB9wL0=
X-Received: by 2002:a05:690c:6809:b0:708:b7c4:89d9 with SMTP id
 00721157ae682-70c7f12b587mr29661517b3.11.1747191989825; Tue, 13 May 2025
 20:06:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502184421.1424368-1-bboscaccy@linux.microsoft.com>
 <20250502210034.284051-1-kpsingh@kernel.org> <CAHC9VhS5Vevcq90OxTmAp2=XtR1qOiDDe5sSXReX5oXzf+siVQ@mail.gmail.com>
 <CACYkzJ5jsWFiXMRDwoGib5t+Xje6STTuJGRZM9Vg2dFz7uPa-g@mail.gmail.com> <CACYkzJ6VQUExfyt0=-FmXz46GHJh3d=FXh5j4KfexcEFbHV-vg@mail.gmail.com>
In-Reply-To: <CACYkzJ6VQUExfyt0=-FmXz46GHJh3d=FXh5j4KfexcEFbHV-vg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 13 May 2025 23:06:18 -0400
X-Gm-Features: AX0GCFtmtl8iZvt0__SZY16ZDtDEOONW5PvqEMj_YT203ANGlWr4B8M9PmCIO_o
Message-ID: <CAHC9VhQL_FkUH8F1fvFZmC-8UwZh3zkwjomCo1PiWNW0EGYUPw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Introducing Hornet LSM
To: KP Singh <kpsingh@kernel.org>
Cc: bboscaccy@linux.microsoft.com, James.Bottomley@hansenpartnership.com, 
	bpf@vger.kernel.org, code@tyhicks.com, corbet@lwn.net, davem@davemloft.net, 
	dhowells@redhat.com, gnoack@google.com, herbert@gondor.apana.org.au, 
	jarkko@kernel.org, jmorris@namei.org, jstancek@redhat.com, 
	justinstitt@google.com, keyrings@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-security-module@vger.kernel.org, 
	llvm@lists.linux.dev, masahiroy@kernel.org, mic@digikod.net, morbo@google.com, 
	nathan@kernel.org, neal@gompa.dev, nick.desaulniers+lkml@gmail.com, 
	nicolas@fjasle.eu, nkapron@google.com, roberto.sassu@huawei.com, 
	serge@hallyn.com, shuah@kernel.org, teknoraver@meta.com, 
	xiyou.wangcong@gmail.com, kysrinivasan@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 10, 2025 at 10:01=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrot=
e:
>

...

> The signature check in the verifier (during BPF_PROG_LOAD):
>
>     verify_pkcs7_signature(prog->aux->sha, sizeof(prog->aux->sha),
> sig_from_bpf_attr, =E2=80=A6);

I think we still need to clarify the authorization aspect of your
proposed design.

Working under the assumption that the core BPF kernel code doesn't
want to enforce any restrictions, or at least as few as possible, I'm
expecting that the BPF kernel code would want to adopt an "allow all"
policy when it comes to authorizing signed and unsigned BPF programs,
delegating any additional restrictions to the LSM.  With that in mind
I think we need to agree on a way for the BPF verifier to indicate
that it has verified the signature is correct to the LSM, and we need
a new LSM hook which runs *after* the verifier so that it can inspect
the results of the signature verification.  While it might be tempting
to relocate the existing security_bpf_prog_load() hook, I believe it
makes sense to leave that hook before the verifier for those LSMs that
wish control access prior to the verifier's inspection using criteria
other than signatures.

With respect to the LSM hook, since it appears that the signature is
going to be included in the bpf_attr struct, and I'm *guessing* the
best way for the verifier to indicate the result of the signature
verification is via a field inside bpf_prog_aux, this means the hook
could look something like this:

  int security_bpf_prog_verified(bpf_prog, bpf_attr);

... and be called immediately after bpf_check() in bpf_prog_load().
As far as the new field in bpf_prog_aux is concerned, I think we can
probably start off with a simple bool to indicate whether a signature
was verified or not, with an understanding that we can move to a
richer construct in the future if we find it necessary.  Neither of
these are directly visible to userspace so we have the ability to
start simple and modify as needed.

Does this sound reasonable to everyone?  Does anyone have any other
thoughts on the authorization aspect of BPF signature verification?

--=20
paul-moore.com

