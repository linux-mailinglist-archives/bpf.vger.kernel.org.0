Return-Path: <bpf+bounces-70196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E32BB4149
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 15:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35D0A19C7654
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 13:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20865464D;
	Thu,  2 Oct 2025 13:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWYIx6hv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CF21758B
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 13:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759412927; cv=none; b=AAWwSeY1Rsheymiv0qtDwV7Kb24/cpefYFfozW852PdE8vOMQt/qkOialA2/YV2FLpR/Uh+GAbOiU+cREUupTCH0G1bWBECyovgyRTIP0AYFDqtnK96XeOLTZIww9cYzFuqNrszp8BKQFwiReOFUz/PkYHLO4VFfswItTvqkkdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759412927; c=relaxed/simple;
	bh=9Ff1IwWNy93oXu64Q4BiN1QZkpj+h3I9ouZGA9yoNJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pT70nGyYc/o5NtwGvtpZIIspsJMGE9blPFsiTk4xwAc0Q0a3gbz1g9TvaPbwSAbJfgiCIyFdmqVY93ApgzSlq8FMh1eCrshdwOr9XugyS+1dss70mwZQdpllFN10ke2BV0YEzNTzbnQbM5CyA1xJ3vgvrF8MlMrFvjGN1554xI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWYIx6hv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E930BC4CEFC
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 13:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759412926;
	bh=9Ff1IwWNy93oXu64Q4BiN1QZkpj+h3I9ouZGA9yoNJk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HWYIx6hv+6bv6+XSqF0VcT7RqGGvbPKi4HR2E6YnW+zeG4ZGZFdFWqUApKTzoDAFa
	 t8InPyvdiFlaopiLoAZ0ezfnI7nh1fsrvRPdrmOpyvJcz0E2KhAPZstGYFYppIQeg+
	 7mh08uqMDYP0xjdFwb3XiwmkEKJqDHBI2xodSdN9abJCpz6uBRHFFzjNaDvxQYW/Yk
	 zLoEXKdY07ulP4phJW+B+nThS9KsEeZmdcEhuK69ht3t5L4ioTfAjmFdqTeBCZdJ4s
	 7lUVKdvFGurmzMwt2UiWtadVLx5SxAMfUrC4Rb+KjlDssLYMx05i/czH+qbosrjLX8
	 M2uxiu/Sjcadg==
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e2e363118so9551315e9.0
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 06:48:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqdeDWSV5WNk67+4JI7B740j6NLCRoBpmFHvfNa4fp5e0lv+OfUYiyPIqfaYv3ZWTlMls=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvzE5k5ORVN4BB/Oznb+oH4Ayr5WNU8MtY2e81rDplsOQtMRWP
	xgyxDpsWUJ5IRcmT8g850SnPI0fvG8fl4IHrEL+cHDITAzEumirmLJx+dnmZpNoi+IFfGppuEa+
	zDBTB0yVLOvgPBnCcOysxyE/M4hY8wI73Ha5daQhM
X-Google-Smtp-Source: AGHT+IH1dN6IDmrUwxgIXsG+8PYYgV0rG7YIPLOGWpG/qZ3dQdD71//Cu/PMbo3C2ZiClVnk4i+mbNj3u2mLy9E2ZJw=
X-Received: by 2002:a05:6000:2909:b0:411:3c14:3ac9 with SMTP id
 ffacd0b85a97d-42557820099mr4926287f8f.59.1759412925413; Thu, 02 Oct 2025
 06:48:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929213520.1821223-1-bboscaccy@linux.microsoft.com> <CAHC9VhTQ_DR=ANzoDBjcCtrimV7XcCZVUsANPt=TjcvM4d-vjg@mail.gmail.com>
In-Reply-To: <CAHC9VhTQ_DR=ANzoDBjcCtrimV7XcCZVUsANPt=TjcvM4d-vjg@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Thu, 2 Oct 2025 15:48:34 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4yG1d8ujZ8PVzsRr_PWpyr6goD9DezQTu8ydaf-skn6g@mail.gmail.com>
X-Gm-Features: AS18NWDR2V32kHl6e06nyB7JdSmw2OjmHo0LVJsbfsChvLGWcEDxe_YY0pjHE_c
Message-ID: <CACYkzJ4yG1d8ujZ8PVzsRr_PWpyr6goD9DezQTu8ydaf-skn6g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] BPF signature hash chains
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, ast@kernel.org, 
	james.bottomley@hansenpartnership.com, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kys@microsoft.com, 
	daniel@iogearbox.net, andrii@kernel.org, wufan@linux.microsoft.com, 
	qmo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 11:37=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>

[...]

> With the lack of engagement from the BPF devs, I'm now at the point
> where I'm asking Linus to comment on the current situation around

The lack of engagement is because Blaise has repeatedly sent patches
and ignored maintainer feedback and continued pushing a broken
approach. The community, in fact, prioritized the signing work to
unblock your use-case.

> Blaise's patchset.  I recognize that Alexei and KP have a strong
> affinity for the signature scheme implemented in KP's patchset, which
> is fine, but if we are going to be serious about implementing BPF
> signature verification that can be used by a number of different user
> groups, we also need to support the signature scheme that Blaise is
> proposing[6].
>

Blaise's implementation fails on any modern BPF programs since
programs use more than one map, BTF information and kernel functions.

> To make it clear at the start, Blaise's patchset does not change,
> block, or otherwise prevent the BPF program signature scheme
> implemented in KP's patchset.  Blaise intentionally designed his
> patches such that the two signature schemes can coexist together in

We cannot have multiple signature schemes, this is not the experience
we want for BPF users.

> the same kernel, allowing users to select which scheme to use on each
> BPF program load, enabling the kernel to support policy to selectively
> enforce rules around which signature scheme is permitted for each BPF
> program load.
>
> Blaise's patch implements an alternate BPF program signature scheme,
> using the same basic concepts as KP's design (light skeletons, hash
> chaining, etc.), but does so in such a way that the kernel verifies
> all relevant parts of the BPF program load prior to calling the
> security_bpf_prog_load() LSM hook.  KP's signature scheme only
> verifies the light skeleton prior to calling the LSM hook and relies

You are confusing a light skeleton from a loader program. Loader
programs are independent of light skeletons.

> on the BPF code in the light skeleton to verify the original BPF
> program.
>
> Relying on a light skeleton to verify the BPF program means that any
> verification failures in the light skeleton will be "lost" as there is
> no way to convey an error code back to the user who is attempting the

This is not correct, the error is propagated back if the loader program fai=
ls.

> BPF program load.  Blaise's approach to verifying the full signature
> in the kernel, and not relying on the light skeleton for verification,
> means that verification failures can be returned to the user; there
> are no silent signature verification failures like one can experience
> with KP's verification scheme.
>
> KP's signature verification scheme is a two-part scheme with the
> security_bpf_prog_load() LSM hook being called after the light
> skeleton signature has been verified, but before the light skeleton
> verifies the BPF program.  Aside from breaking with typical

Again you mean, loader BPF program. Skeletons are just for
convenience. You don't have to use them. libbpf provides an
implementation to easily generate loader programs, but you don't have
to use that either.

> conventions around the placement of LSM hooks, this "halfway" approach
> makes it difficult for LSMs to log anything about the signature status
> of a BPF program being loaded, or use the signature status in any type
> of access decision.  This is important for a number of user groups
> that use LSM based security policies as a way to help reason about the
> security properties of a system, as KP's scheme would require the
> users to analyze the signature verification code in every BPF light
> skeleton they authorize as well as the LSM policy in order to reason
> about the security mechanisms involved in BPF program loading.
>
> Blaise's signature scheme also has the nice property that BPF ELF
> objects created using his scheme are backwards compatible with
> existing released kernels that do not support any BPF signature
> verification schemes, of course without any signature verification.
> Loading a BPF ELF object using KP's signature scheme will likely fail
> when loaded on existing released kernels.

This does not make any sense. The ELF format and the way loaders like
libbpf interpret it, has nothing to do with the kernel or UAPI.

I had given detailed feedback to Blaise in
https://lore.kernel.org/bpf/CACYkzJ6yNjFOTzC04uOuCmFn=3D+51_ie2tB9_x-u2xbcO=
=3DyobTw@mail.gmail.com/
mentions also why we don't want any additional UAPI.

You keep mentioning having visibility  in the LSM code and I again
ask, to implement what specific security policy and there is no clear
answer? On a system where you would like to only allow signed BPF
programs, you can purely deny any programs where the signature is not
provided and this can be implemented today.

Stable programs work as it is, programs that require runtime
relocation work with loader programs. We don't want to add more UAPI
as, in the future, it's quite possible that we can make the
instruction buffer stable.

- KP

>
> [1] https://lore.kernel.org/linux-security-module/CAADnVQ+C2KNR1ryRtBGOZT=
Nk961pF+30FnU9n3dt3QjaQu_N6Q@mail.gmail.com/
> [2] https://lore.kernel.org/linux-security-module/CAHC9VhRjKV4AbSgqb4J_-x=
hkWAp_VAcKDfLJ4GwhBNPOr+cvpg@mail.gmail.com/
> [3] https://lore.kernel.org/linux-security-module/87sei58vy3.fsf@microsof=
t.com/
> [4] https://lore.kernel.org/linux-security-module/20250909162345.569889-2=
-bboscaccy@linux.microsoft.com/
> [5] https://lore.kernel.org/linux-security-module/20250926203111.1305999-=
1-bboscaccy@linux.microsoft.com/
> [6] https://lore.kernel.org/linux-security-module/20250929213520.1821223-=
1-bboscaccy@linux.microsoft.com/
>
> --
> paul-moore.com

