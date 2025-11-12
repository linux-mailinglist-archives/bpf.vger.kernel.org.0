Return-Path: <bpf+bounces-74318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3346AC53E1E
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 19:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 36A5E34473B
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 18:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A5D340287;
	Wed, 12 Nov 2025 18:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhgxlQH2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B2B23EAAA
	for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 18:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971539; cv=none; b=hqx4+07iSO3zpcxxusRAhI3VPLTR0K9m6ivnYRVozHST6sFw+L7+NVv5Ps/apHHRFZTdRIeSMbM0YeirCK17XVWCOnTDgdaParZdxruOdgEkq6a+SUZ5fQggZpZQCFP2nC9SdE+sFlBfVzDYFKY/pCpSCwl1wQ88WQieBAl1XjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971539; c=relaxed/simple;
	bh=7/tYpPd0j0N2wRwE0SWyhsLEXU6+r7GUlcnFR8iNwkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2XinRlweIzGGNmH8XoIlGDTPf+LrvxoBdQBmQiL7ABZDFcgoXKe74KBm6+YZJ3UGi+cQdNWadnlVC8d42Htr9rhbD9aq3Zkn7EQ7o3dpO4Xdv/M0SeoALs9c2xx1J2KKWQd7z13BoIWytaJ4ktJtnR/tRXxJ6dlsPyaClgqzYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhgxlQH2; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-71d71bcab6fso11381047b3.0
        for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 10:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762971537; x=1763576337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEXHFyhU31FY99mc3YpyMkWSjlHniDhx4vitcXTnXhk=;
        b=QhgxlQH2uv0w1cGiewIq+bg3TB59Zt2kNGl8Se+TAOYBLUPtIAbWfrjvpQWZuu8ymo
         17Bzr41P0Pn9rWDRqfD4ElOBNsrNOQmP4Ps/MZ/o2tQTzcoobPwuU/VNJdZD/Y9ylsn/
         cM9TVaSSr7qS8uPQOLbknkFEYS8qdkU7kaHi/6ZJi4rhAMvaxhTDrdMwQjMYa7Vp+ucJ
         46r9PSFvAg17w8cvtiQp+jHfxtMpbberAUf2XuC6HgBAQu+q8g5C4uLfSUatp986BD7v
         2KRarrzjjnmc/PE07NMj0bm1UBIVf3HG76B6+q/KF10xcSs0ywr1eDdtfViGbCLnyn1/
         oYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762971537; x=1763576337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HEXHFyhU31FY99mc3YpyMkWSjlHniDhx4vitcXTnXhk=;
        b=tlxy5TSNhHyVPT31B1dSF2pFksPGca7hIQMb3BlXtZwjAs4TJJ0Qcie7hI2yZsGFS7
         7LQEuJAcmYSzgNlExVpY9IxH5U9Y4aNXCJhXtXtR9RjYrUvQPBL38dfieCqZwM9opYAU
         V/mJHY1fixg9TIJJJ8n6TP8OsyjQzoily/FVph18qLKMwELFEbywOAZGVV6rTQTfzAGB
         dgonOXva72NLalWPDIhc0/6954TeCcFiWli1RKCeXSPqMWuKe7fDWjKIawo0CAbwvHjX
         JCM4qW/tP11MCd0OcBlMmxMZYl82lBjJ2GMXI9bmRJfq7AtayhJ2+qqIqpPMJtHkNwun
         VudQ==
X-Gm-Message-State: AOJu0YxZhHM2feG73zivJrn7Y3vs7ChiWJW37AgauMyYJjtJmzRex6+4
	2gBpt7wtHXeeleNbDHSkhBe51X/HTfht3sAie5GdnWQ+1Mm90mohKqhNb30DMCPWeI7gmgGnE34
	3kkKDylPiTU1JupM0rC71p24ZsUE9D/k=
X-Gm-Gg: ASbGncuJ5kPtlOKir7DsELbAyi2x+3xIVEd4ye0WetKh/ViU3wSFBMyauSFIKEWZlEZ
	88FtttebCSgODsw5XSznr0ZU3/caApCDHUtuorAt2OW+gWBMnmxTadOaarwAVZynlcZHjmgJ9QQ
	o+GqDBSuWWXn3jcYRasd4JSepnIb93EEAbWUsf9A8pvT6IbrOEsau2TAvqa0AYMdDHYn0C/4Sza
	gftHYqr4z8/7dLTNdk8i3uikcFcJHvLj9Ud2gDcweb27p2EVJ5EzwJZezdn
X-Google-Smtp-Source: AGHT+IHvaDpKLiKBoSh75kcOD2cNJBFHYX28oZqv2eIyt82WulaX6/pmEx0g5L5DSgMv/NOknpFUsqEiI/P9mg7Etdw=
X-Received: by 2002:a05:690c:6206:b0:786:59d3:49b7 with SMTP id
 00721157ae682-78813614ba2mr34063167b3.13.1762971537297; Wed, 12 Nov 2025
 10:18:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111013827.1853484-1-memxor@gmail.com>
In-Reply-To: <20251111013827.1853484-1-memxor@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 12 Nov 2025 10:18:46 -0800
X-Gm-Features: AWmQ_blhNosimboeG5v-KivaYM_jtrIUPHLSn6MeFQUcTcDdtqfvUBnmuujy5OI
Message-ID: <CAMB2axN7-Q6NpdOzuBjUaEK55bU+5kzgxggeWC4=PCy3MMV=iA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] rqspinlock: Adjust return value for queue destruction
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 5:49=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Return -ETIMEDOUT whenever non-head waiters are signalled by head, and fi=
x
> oversight in commit 7bd6e5ce5be6 ("rqspinlock: Disable queue destruction =
for
> deadlocks"). We no longer signal on deadlocks.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/rqspinlock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
> index b94e258bf2b9..3cc23d79a9fc 100644
> --- a/kernel/bpf/rqspinlock.c
> +++ b/kernel/bpf/rqspinlock.c
> @@ -537,7 +537,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rq=
spinlock_t *lock, u32 val)
>
>                 val =3D arch_mcs_spin_lock_contended(&node->locked);
>                 if (val =3D=3D RES_TIMEOUT_VAL) {
> -                       ret =3D -EDEADLK;
> +                       ret =3D -ETIMEDOUT;

Make sense.

Reviewed-by: Amery Hung <ameryhung@gmail.com>

>                         goto waitq_timeout;
>                 }
>
> --
> 2.51.0
>
>

