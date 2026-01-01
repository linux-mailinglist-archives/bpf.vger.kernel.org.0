Return-Path: <bpf+bounces-77660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46770CECB85
	for <lists+bpf@lfdr.de>; Thu, 01 Jan 2026 01:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A67D93019B8E
	for <lists+bpf@lfdr.de>; Thu,  1 Jan 2026 00:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D185424E4C3;
	Thu,  1 Jan 2026 00:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="amjdY8FL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD71024469E
	for <bpf@vger.kernel.org>; Thu,  1 Jan 2026 00:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767229055; cv=pass; b=jeXT3qHc1hSDnvrTZs/Pt+9obyb4IGd4SoybELEmB7S123Ir3yR7uBUAMqu+CjXlAgpApoGMDCXCldDfy5aE1YaON2h6k+ZnKPcVbYdeUgbpkfPFNcNVdjWUHQ7kP78+bIOf9LW4WSIrm4KCmajuy1UVeYIU8zlPN83YH1idqeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767229055; c=relaxed/simple;
	bh=emxm9F4PEs7twMpgwWsBAp/Ckd0EfI6WSs7yozL7W/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pt/NnpU+t3cP86ZR09FQxxqqQHKt8P2dKAX7Vkx9CUYj+0aKYVWVRdK/w8aoMn9m2mgRptNi+2iwv/dGmidEKQeN0d4ea/rX3uTCChiKhyKBQHZ9J7c5jtd0OhFZj5xFwSnvirrjtZxJ6xF2grp8bjuKdEnWVuc3fnLEus9v1xU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=amjdY8FL; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4f34f257a1bso469611cf.0
        for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 16:57:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767229053; cv=none;
        d=google.com; s=arc-20240605;
        b=LG8sl6IhwlsmAlyF+kXf5B375cD4xKSzKR4EByUmdusF7YJOd8VjOptdqh/MaOt3DZ
         kP0+2/z3J3nRdXTTesg4RZ5GUBNrMFl2hM5n4VOiAbehqAnp05Eqb4C+C0lzyIuenjWx
         FlbePr2AoHCRvHL8Xv6uCZPxslC/aL6cgkZ+t6DZJ3jMmPMsypBqdLDMO1gV18YvGyrJ
         y+NOE5B6u9MjuA7KcF3frCQwAtqfV2FmCQLcksZrc+tPsDWJ30GidFNVsZvzsZRjZb6R
         d+aVNWyq2T2YbZftO4UzjbNW7zeUiujl81CNzg2YB+vvW1rxMwyMsxG6GSPf7oHPRniQ
         8EZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cm1BL2ERrg3kCh6F6FAnwWgqfYK5vc0iS8vU9VA7hbs=;
        fh=6PNVSEuAIaWrTF06leIjl3itOw3wkCOSBAyAOmvtIcU=;
        b=gRnigVyx05oRz7JrQaGnbGx8uciSsN3+HxuXbWFd7Ba+m+wndryq8mvJZINwmk40kB
         klVHrNp8alQpK7Sf01TCDc+PL9we8/jyq1bWSCpKj7bUdfSBT2Rfhs8vuqb19s1ecgcI
         u1mvxaCYL4r9oJRFn/q0B/B1Ki2Vg53pRLqUlEbdGNfMraC9XeGePBtsWQ/yZLrmTgC0
         6D3OUzfbHDRhB97IDXoDTsMAKB5P1tvV3dvJO6Gj3WrHulaYbchIRNRvTUeDv5gVCIBs
         R4oXOuB/JglbQCfDS6XHU/w8k2+omTDSfuMqVejZxhHhcrorgKcuk1kRFDABfPZ6K4PC
         bETw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767229053; x=1767833853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cm1BL2ERrg3kCh6F6FAnwWgqfYK5vc0iS8vU9VA7hbs=;
        b=amjdY8FLeAN+ZPHh9RDcMADBERszkJ4kfQaOgKlHdUtCNSFcLaBQ2e/s21aYebAlJE
         vFBrpdjYlU2anp7XbCcvUDtNNxbwCPWJJXyvavH2Ck0TFajWB4Yw3aytRJjY+UXhxAlL
         8jW9KHaEfLdfljD2vzQ0u66CEoGxeZVF3C6iTX3zVCjJepnkg/3wrtQKIBgOvXdQKlX8
         n2bF1Y6QvNRMjnw40TtANR+jsXinOTIX95rrXHzAvY+pbyaSqVJOyfNN868wl76KDX2N
         yvxUqI1ID85yPwF4QuDKhb8QYn6jxfErcUt0JoMyQ+8yU/g3nae7Sjr+ZV2s3DqgC6Vg
         wWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767229053; x=1767833853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cm1BL2ERrg3kCh6F6FAnwWgqfYK5vc0iS8vU9VA7hbs=;
        b=SUmDB5uGT/jYitHPKvXthQmYhnYdWR0oxN3HBX/y3WnEeL4USQ8XRM15COj7cIaOY4
         GJgbHlEfri+V5pZjlT4FV0G1eIuoM0SbgwIpNdS4Zx7qMaCl7RBSQWhINxRYR9yeDcTS
         RVAMXFd53X7mG3LIND2FX1QtY+TKi5X8gVRvuwD/X80jDWMKDuNo51iocjKdKZCVImMI
         jpHdk8pqE4fEqSebdCXHzlf6Mv5G7JP9QC4l41aVETWVinvHyEh04mzGZBggCGprOADQ
         nmrP++3vCRyUHyYGPjwy+mGtLPh2BLfor1/k5Whao2rysQVDSF6QBGgvSykbHtDC0Hyi
         kYSg==
X-Forwarded-Encrypted: i=1; AJvYcCXk+Qo+BJfBrrMh1wP60G8f21FJOPn5U/huWNYILTVUg2rcm1/DHla9taLiBH26zSe/QhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZVrAJLd081VOyMhF9Dcqf9jvJ4Y4fWV5BcVc6/YTLL//l6SAj
	OZqgqpaJ/Gyg2w6erTABBvVVJaW5fKcAEyqfZV6r0Ks7Ka3atoE/Y0YFiP9lqCAtRxDrvfgXt3D
	kkytMj8TdI0Xcn4WxZLKhoJ/EiLfcMul1UrDUJYgg
X-Gm-Gg: AY/fxX5RpyrOMqteVDF8oN0xN8beyQR4TMHRz4LoyXJP5E3E4KlJ0ZFZfZMStX6cncp
	CiypW+hgr4O5AMgZSKrN+2iV2UdrrkZh1rBdmQdxQxQhdca4uq2bzLRfE5AOIryz26Nao+TFgKX
	A8Qro+WCUzCnt9UmjaEVpMXlIOHuyrfQ1mlzXBC2iHC+oW5b4TLsKGvBbujXV9vq3cCIxnbod/B
	rU9inTlrjZKPxJOfu29VbKWTAw7DlWctvkHFHhp6L59wawnkD92kwrYJTPlQaajsaHH3oXShZ4F
	vhsLT99fk67k5E/NvMFkgTaLrly4XCg4aND5RXM=
X-Google-Smtp-Source: AGHT+IE5OfZJ0/hIzhA8mBhbLh4j/deDnJBAW7Dn9FJZWDt+5ezAN6a04NmIQZHYNVZNn2qTdMcz9MSn3BadTm1/mm8=
X-Received: by 2002:ac8:7f06:0:b0:4f4:b46e:34a0 with SMTP id
 d75a77b69052e-4fbd6096b15mr8909641cf.5.1767229052434; Wed, 31 Dec 2025
 16:57:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231232048.2860014-1-maze@google.com> <CAADnVQL4ZPaiwuXtB7b9nrVVMg0eDiT6gnnNGrU5Ys61UWdgCA@mail.gmail.com>
In-Reply-To: <CAADnVQL4ZPaiwuXtB7b9nrVVMg0eDiT6gnnNGrU5Ys61UWdgCA@mail.gmail.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Thu, 1 Jan 2026 01:57:20 +0100
X-Gm-Features: AQt7F2qicWjCRjlu-6jL-eYQFIqmteU4y56SOln4I4mG55D8dWPVyDkjxlYOTGw
Message-ID: <CANP3RGdFdAf9gP5G6NaqvoGm7QZkVvow9V1OfZrCPBzyvVDoGg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: 'fix' for undefined future potential exploits of BPF_PROG_LOAD
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, BPF Mailing List <bpf@vger.kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 1, 2026 at 1:07=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Dec 31, 2025 at 3:21=E2=80=AFPM Maciej =C5=BBenczykowski <maze@go=
ogle.com> wrote:
> >
> > Over the years there's been a number of issues with the eBPF
> > verifier/jit/codegen (incl. both code bugs & spectre related stuff).
> >
> > It's an amazing but very complex piece of logic, and I don't think
> > it's realistic to expect it to ever be (or become) 100% secure.
> >
> > For example we currently have KASAN reporting buffer length violation
> > issues on 6.18 (which may or may not be due to eBPF subsystem, but are
> > worrying none-the-less)
> >
> > Blocking bpf(BPF_PROG_LOAD, ...) is the only sure fire way to guarantee
> > the inability to exploit the eBPF subsystem.
> > In comparison other eBPF operations are pretty benign.
> > Even map creation is usually at most a memory DoS, furthermore it
> > remains useful (even with prog load disabled) due to inner maps.
> >
> > This new sysctl is designed primarily for verified boot systems,
> > where (while the system is booting from trusted/signed media)
> > BPF_PROG_LOAD can be enabled, but before untrusted user
> > media is mounted or networking is enabled, BPF_PROG_LOAD
> > can be outright disabled.
> >
> > This provides for a very simple way to limit eBPF programs to only
> > those signed programs that are part of the verified boot chain,
> > which has always been a requirement of eBPF use in Android.
> >
> > I can think of two other ways to accomplish this:
> > (a) via sepolicy with booleans, but it ends up being pretty complex
> >     (especially wrt verifying the correctness of the resulting policies=
)
> > (b) via BPF_LSM bpf_prog_load hook, which requires enabling additional
> >     kernel options which aren't necessarily worth the bother,
> >     and requires dynamically patching the kernel (frowned upon by
> >     security folks).
> >
> > This approach appears to simply be the most trivial.
>
> You seem to ignore the existence of sysctl_unprivileged_bpf_disabled.
> And with that the CAP_BPF is the only way to prog_load to work.

I am actually aware of it, but we cannot use sysctl_unprivileged_bpf_disabl=
ed,
because (last I checked) it disables map creation as well, which we do
want to function
as less privileged (though still partially priv) daemons/users (for
inner map creation)...

Additionally the problem is there is no way to globally block CAP_BPF...
because CAP_SYS_ADMIN (per documentation, and backwards compatibility)
implies it, and that has valid users.

> I suspect you're targeting some old kernels.

I don't believe so.  How are you suggesting we globally block BPF_PROG_LOAD=
,
while there will still be some CAP_SYS_ADMIN processes out of necessity,
and without blocking map creation?

