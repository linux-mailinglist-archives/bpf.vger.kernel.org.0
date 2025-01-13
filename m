Return-Path: <bpf+bounces-48719-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 281ECA0C5BF
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 00:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5BA13A1E79
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 23:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A2E1FA14A;
	Mon, 13 Jan 2025 23:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fp3xagMd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13951F9A83
	for <bpf@vger.kernel.org>; Mon, 13 Jan 2025 23:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736811192; cv=none; b=lBNNNa7AVk0nWF2zsbhnZMSwllo6dXJFxVHqP6Yod7AWIRWHXQ068O0B8DGmfxq9qbEf4A/Sah7qQsBSPSzY4nrZMDXGMQDsbZxsk3RymhQUS8luD5sUwKkl0yONc1bK+W3D1nXbdk4qMm7O+t20pkXe39rMs/WACO8kr0sDx3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736811192; c=relaxed/simple;
	bh=D6OnElAxUq5fUNVdQFXkMQug90oVeA6uJOQCg0cT1GI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pAfMaV8Ch30WFgmkAtCyQ1EcMHO+oMbPLyCF9wtn8Blk4sTQ443MNNi7G9c68g+6ij6SOzVa7ITYeNU9EMmPbkwlJeJkDNxGoOvx6s00kotfSRkaYqjFdS2BRAfxeXIA3ZC8rSEf3sbmqwWAA2Lt6h8HGwtppG8gNxFXGLxV/8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fp3xagMd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F2DC4CEE3
	for <bpf@vger.kernel.org>; Mon, 13 Jan 2025 23:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736811191;
	bh=D6OnElAxUq5fUNVdQFXkMQug90oVeA6uJOQCg0cT1GI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Fp3xagMdPL+qA4kLSa4P05OBKLFI8wjNVtNW+6b+nidhYCBn95vn9DoxnCSZOQEv2
	 ngeDXFLcSS+8/HtPSyNxwRdAfnu2Oc3ZqBEdSqx1mPREl3MH47eXyZCZ0JVNaa9+Xx
	 zXrzvFGAwjIVoKdrGAXbPXDEurUOD99ct5UkKefDBgdbxNmkKje8XymhTa1Nd7jS1d
	 D22hYqGpMJTreGL0vVXojUxcdVD7yIgoqtNuqZCOqumaYu8W3uSbeHbnfHojKnFQsX
	 UKxU/GbpyZ5Xe6OYf+J2JObPrMBI7ueeBLWMGrFyaFErrRB+fd8UddRna38GrMWnHC
	 LZdjfDthZQd/Q==
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-844cd85f5ebso390807739f.3
        for <bpf@vger.kernel.org>; Mon, 13 Jan 2025 15:33:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWHBUpkbTLuX2ppd5MoJqxw0UiOR64NCyYfqq6sxYwr0DupgsTnHAJfGgx/5A4/4XfCc7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzneMQERbVf2QS5ny01J77BhA0/O549Ot2touASSXAQvjsazwOo
	ae26F0r1wMR0lEOisf4B5jT3gDMJY8gF5qUuxNt/WKuW8/yWHDH0U1ziW0wLkdNz51a8ARWOZT+
	NP42vr27ITZYXxGe8kU7q4mexITY=
X-Google-Smtp-Source: AGHT+IHV3QrY8zXcYz23dGJJH8S6thOZsBUp0cTfKsTJnQqKnyDKYldNtZL9uyuOXzSGnF/Zz566+I7YaPDgP0/wKZE=
X-Received: by 2002:a05:6e02:1488:b0:3a7:a2c6:e6d1 with SMTP id
 e9e14a558f8ab-3ce3a93a83emr192966305ab.16.1736811190851; Mon, 13 Jan 2025
 15:33:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <nahst74z46ov7ii3vmriyhk25zo6tkf2f3hsulzjzselvobbbu@pqn6wfdibwqb>
In-Reply-To: <nahst74z46ov7ii3vmriyhk25zo6tkf2f3hsulzjzselvobbbu@pqn6wfdibwqb>
From: Song Liu <song@kernel.org>
Date: Mon, 13 Jan 2025 15:32:59 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5cLXSjQetTrcEFMAwnjjd1pGR3rLwVBuHkHMuK6xqwMA@mail.gmail.com>
X-Gm-Features: AbW1kvaYa4Dgondt7l2PNzbrPBuNr3fZa64LmNqHOmTLFS3O6yg1R5ptTZZYuKU
Message-ID: <CAPhsuW5cLXSjQetTrcEFMAwnjjd1pGR3rLwVBuHkHMuK6xqwMA@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Modular BPF verifier
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: lsf-pc@lists.linux-foundation.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 1:23=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Hi folks,
>
> I'd like to propose modular BPF verifier as a discussion topic.

Interesting idea!

I was thinking about "modular verifier" these days, but in a different
way, i.e., how to divide the verifier into smaller modules (logical
modules, not necessarily kernel modules). We currently support
loading kfuncs in kernel modules, so it is natural to put the checks
of kfuncs into modules (via btf_kfunc_id_set.filter function).

> =3D=3D=3D Motivation =3D=3D=3D
>
> A decade of production experience with BPF has shown that the desire for
> feature availability outpaces the ability to deliver new kernels into the=
 field
> [0]. Therefore, the idea of modularizing the BPF subsystem into a loadabl=
e
> kernel module (LKM) has started to look appealing, as this would allow lo=
ading
> newer versions of the BPF subsystem onto older versions of the kernel wit=
hout a
> reboot.
>

[...]

>
> For forward compatibility, the idea is to implement a facade built into e=
ach
> kernel that exposes a stable-enough (non-UAPI) interface such that the ve=
rifier
> can remain portable and =E2=80=9Cplug in=E2=80=9D to the running kernel. =
While I expect the
> facade to be necessary, it will not be sufficient. There will eventually =
be
> details the facade cannot hide, for example an unavoidable ABI break. To =
solve
> for this, I/we [2] will maintain a continuously exported copy of the veri=
fier
> code in a separate repository. From there we can develop branching, patch=
ing,
> or backport strategies to mitigate breaks. The exact details are TBD and =
will
> become more clear as work progresses.

Maintaining out-of-tree kernel modules is a lot of work. I wonder whether
the benefit would justify this extra work. There are other ways to make
small changes to the built-in verifier, i.e. kernel live patch.

>
> On top of delivering newer verifiers to older kernels, the facade opens t=
he
> door to running the verifier in userspace. If the verifier becomes suffic=
iently
> portable, we can implement a userspace facade and plug the verifier in. A
> possible use case could be integrating the verifier into Clang [3] for ti=
ghtly
> integrated verifier feedback. This would address a long running pain poin=
t with
> BPF development. This is a lot easier said than done, so consider this hi=
ghly
> speculative.

I think we don't need the verifier to be a LKM to do verification in user
space. Instead, we just need a mechanism to bypass (some logic of)
the verifier. Would this work?

Thanks,
Song

[...]

