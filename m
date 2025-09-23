Return-Path: <bpf+bounces-69310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1943B93D6F
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 03:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CC64442397
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 01:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32FB242D99;
	Tue, 23 Sep 2025 01:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CXP16esa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AD3242D80
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 01:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758590825; cv=none; b=XqqsgZ+SgUQLs42RBNR8oIKntwgWswGMU7ddT+mF4oLW+s+h/tIrGnG1e9Qnao/OgWzhX2DZm6ttTMTIx0znxdSK049ulYkrv4S56n6ptYCaz30NruKlqORhY7urK28jbk1YpdsUAmXY2BGKqF/ymSa+5suQzMt5G3iPvv/hWe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758590825; c=relaxed/simple;
	bh=/yTK6Wyn7S+cC9ZuMCyCbCLvMuzpeiKg15N/mIeh2Lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EZ24aYtz7ZQWe8Mm2WjijaQogUTwaSWcSk4kSWmnMo/29p9VPh9Ck0nezJa3PUwQOWOOqW1CzuXULY/bt+6aDGofH5ZvslEsVI1v6GKoXq6Obe7jcTr5g5kIstbDtnAl9+LlWNQL+aj3uYFmfi453DXQ/zw/PZc1tZnQ/aevZm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CXP16esa; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b555ed30c1cso447062a12.1
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 18:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758590823; x=1759195623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqjdOORSGFD7FvIcZ0JXH7SgphifcM2Ag/xxYoTRY5A=;
        b=CXP16esapDC7TdI8kWZFZ2uWezmbiNRclVtPGBK5sJ4dLhZwklPmvml47X3iRKMWlK
         8/HXYnbvt0X00N9l5MbYFZIZSDQklNZ3d+p4pWStHoVaKfgiwi/HkQe+B+CzjXTt+HkI
         ePcedy5G4KW4i8hT8yWKiNW3X005JPvVKK1L7WEYPfJJBIjplZZAQnCcaB7W2mb/wfzD
         iJwzDPy38QrcGlpqjS/6C8sBt/YrLQTbGlPSDQTMYHbspOaPSWrMnhtzjWlJ0PzmNUC+
         k1m3WaXQ0G0efOtTywNL0GOtx8Rb40ix0sfiITgWRvga9ZKlzibeNTdJxOK70FijLpVv
         fmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758590823; x=1759195623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oqjdOORSGFD7FvIcZ0JXH7SgphifcM2Ag/xxYoTRY5A=;
        b=i0sHCCWpFMYbw5XVOHc5+w58dwtx3XmGMXnCA7pZw+Ib5KECoJPnymtLONK0rN4/zX
         cgzMOBOtm091qqpeCwkFtizFTzlln474ZrA7gpHVqlx5N+04ieFkF4UKOo+CG82dx0t0
         1jEWd3RqivMStsHWxiilUu9SSKWLhIRKAusVrnmlFB6g3XXpR2T/2dlBVXOGJqFTYQQL
         ZBDySnfU3mj7MXdXcZrCrP5s7DPWcbw47YKfjug6M1465m39v37DYNu+JykO+2oM+x+U
         0eqfYy71AQ75j0N3aLcsLsAG6GheoNxlKiX9jw2ocYiDWESIKy4LVrxzPCSBBCKP7kbd
         mucg==
X-Gm-Message-State: AOJu0Yzg8UJZfSANeL7ioPYXkWm2++BExfZTtewJgWM/xq7GSnjSJFdJ
	n+lNa2Gr6M30be5wOL0jFvIDvuaKuivfF3W9Byisy7Fz1OvGyoSKiOQgnzUiLf535h0aZWz3hNm
	ezlTvKnTpaG/TswggmtuiB+Jp3yWrRswFKHu/vU78
X-Gm-Gg: ASbGncvywei8Y8hbkM/un4zuTQfr4ubDXwODnbJQRVRiFwpbJtjYkwzEQcsqdhbnYfX
	AT2u1h6eNRmZmEud2mZdMbL+TZUHeZetdGYCnxFZpNuIvDlf4wlF5tcYhQPTsqObNq1YDkZ1dmW
	64KhRN6zlHS5cOI07Yeyo+YAI7XaM/A3v0accJIO5BmUZNmKRowLxyFYM8bffqzFkF14SYWsEbe
	6ozW+Q=
X-Google-Smtp-Source: AGHT+IEeSW9eXhOzqwgIxKu1Sg8gHX7O7Kl89y/+j8/ODZNSQZvRiiteecPHa8MK2WLwmvUISfs/IRuIn1g7SLY2SQw=
X-Received: by 2002:a17:90b:1fd0:b0:32e:f1c:e778 with SMTP id
 98e67ed59e1d1-332a95445d8mr1090948a91.3.1758590822705; Mon, 22 Sep 2025
 18:27:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250921160120.9711-1-kpsingh@kernel.org>
In-Reply-To: <20250921160120.9711-1-kpsingh@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 22 Sep 2025 21:26:49 -0400
X-Gm-Features: AS18NWCpAdZ5ZGSx3Cngxh2izSuRjhhwIO5s13DS6QhO8MBfyMUCK-TS5SSShFM
Message-ID: <CAHC9VhRSs=6rd7fwMGQ1Zyj5PX1aSGtxEMgoS4T4gzD3e7nv9g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 0/5] Signed BPF programs
To: KP Singh <kpsingh@kernel.org>, bboscaccy@linux.microsoft.com, ast@kernel.org
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kys@microsoft.com, daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 21, 2025 at 12:01=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrot=
e:
>
> BPF Signing has gone over multiple discussions in various conferences wit=
h the
> kernel and BPF community ...

In addition to the signature scheme KP has proposed, if we want to
increase adoption of BPF to those who currently disable it due to
strict code provenance and integrity concerns, we need to merge
Blaise's optional signature scheme as described most recently in the
patch posting linked below:

https://lore.kernel.org/linux-security-module/20250909162345.569889-1-bbosc=
accy@linux.microsoft.com/

It is important to note that Blaise's patch allows both signature
schemes to coexist together in the same kernel, allowing users to
select which scheme to use on each program load, and enables the
kernel to support policy to selectively enforce rules around which
signature scheme is permitted for each load.

While we've discussed this in the past, Blaise's signature scheme is
important as it satisfies requirements that aren't otherwise met:

* Both the lskel and original BPF program are verified for provenance
and integrity prior to the security_bpf_prog_load() hook.  This allows
LSMs, including BPF LSMs, to make access control decisions on the
entirety of the verification, not just the verification of the lskel.
For those users who have very strict security requirements which
require analysis of the system's security policy as part of their
vetting, this limits the scope of the BPF signature verification
policy analysis to just the LSM's policy.  This approach is in keeping
with most every other security significant operation in the kernel,
and is also seen as a best practice, since it significantly simplifies
the analysis of the system's security properties.  KP's signature
scheme, while it does verify the original program, it offloads the
digest verification of the original BPF program to the lskel.  Aside
from breaking with most other kernel-based access control approaches,
this means that analysis of only the LSM's policy is no longer
sufficient, security officers must vet both the LSM's policy as well
as the digest verification code in every lskel used on the system.

* Verification of both the lskel and the original BPF program prior to
the security_bpf_prog_load() hook also makes it possible for
observability, measurement, and attestation focused LSMs to more
easily audit, measure, and attest the verified lskel and original BPF,
as all of the components have passed provenance and integrity
verification while the measurements/digests still remain stable as
none of the lskel based transforms have yet to take place.  Using KP's
signature scheme this isn't quite possible as the original BPF program
is verified during the execution of the lskel which potentially
mutates the original BPF program.

As an aside, Blaise's signature scheme also has the nice property that
BPF ELF objects using Blaise's signature scheme are backwards
compatible with existing kernels, allowing the signed BPF to be loaded
on older kernels, albeit without signature verification for obvious
reasons.  While this may not be important to some users, BPF ELF
objects using KP's signature scheme will likely fail when loaded on
older kernels.

Taken individually, KP's and Blaise's signature schemes may not
satisfy all of the use cases and requirements for BPF signing that
have been discussed over the years, but I believe that the two schemes
together can satisfy everyone's needs.

--=20
paul-moore.com

