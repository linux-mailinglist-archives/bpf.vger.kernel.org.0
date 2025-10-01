Return-Path: <bpf+bounces-70158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B83F0BB1DD4
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 23:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C9EA2A11F2
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 21:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C417828643C;
	Wed,  1 Oct 2025 21:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="b0irXLLk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CC231194C
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 21:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759354648; cv=none; b=UAlPJOKFwzBchGNX/874Rf3LyNAc4dQxOJx1nlqLg2fR7RSQkgJRWxE8hxljFKgRKXoUN3MkBrKlN0w0QkK4RaAPPiOq4ltVl1U/3zCCzfI/fkZqE02yFsCx5MqWkr/yPoysOzVVo+Tl0MFxY5iODQgx3vbtce1PMFp0RagTlHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759354648; c=relaxed/simple;
	bh=iFyDmrTpJPn3O5Jm0DiFlsoGIjiYcQ0eix8rULOQfqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NguEIRjXH9AC7f9/r6vZYhcFtcXcNr3DUMniJhI0PgnGdJ/v5YHociQV2n3zrJogMlPUdt312eB75ehZVfKw4o1OPUNpSSeGudK8VPoTa/2I3hj/FBBanlDU4n4j6IXFOy73RxzRRgAmJjpdYqR3GOxrhAKbjbYPnCUVMot+Doo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=b0irXLLk; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-78af9ebe337so321322b3a.1
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 14:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1759354645; x=1759959445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxC2SRILcIhvhYJSacG5k45JmWXFy5mn/GYdj9KKCzs=;
        b=b0irXLLkWNeUv0EUcBJHIe0dQaKvWHGyNwiashlrFjOjkRCgBozSmlo/M3TKjh1d0Z
         nA4LWYDOVTR8ICWjH7kX1LKKerFSAEtwipWyuAqCJMkgHak0PVxYUnFWP40y9eLNt1h4
         1z3Wy80fmc5VFKv12B242HuCi8SUK+EUqB1NngMAyvYkwAXQBj92xZu17LTRpA7D+Ids
         pGhssmbbflmmtMMXMrlKdCgXrPVPn7GNVEMHdfHum6N17LUb5+59BmEjgkP3Pnf6MmnM
         R3jsV2MtMC9GFkY7yTXLcDWrUQteU1oPr+TOpR4/sDReEpVnUZEj7Af+YfiLu/p41IBS
         Fuiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759354645; x=1759959445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oxC2SRILcIhvhYJSacG5k45JmWXFy5mn/GYdj9KKCzs=;
        b=HU2t27fkdQjt0zxbt/3jk9GT9emISbNa26XGki0llMXbUTlZ93Asbv/rj7bdLIzdi/
         JLHsk+Lhaw+WC/cHJnESuT1xhYlHF/2PEUbIGskqMG+rAcZUpQwHPBnKnQEbMCmmt1Xp
         XfZwT6uNsYX1vzyJ7eWNqK7K6kowmxaZucR5zSA6NDMwdBqo12TtNC8QWE12TwLj0TgC
         IeR403fRY4gSnUHQK5mAzLpOIu00RDUICiEOtCAttqP8MknqyYDr4L0b+F81tsFRdw/F
         hwZZXxXEdsXaAfL6j4gi2xrze5wkQZUrZyY8R0piwk7ubpB4wHtIMxynvg9oM4WMTK4l
         dM8A==
X-Gm-Message-State: AOJu0YzXyLZTjlge4PQFyX6PYtB4FsUgPgqBlpFZR9eRxdT/PRUOKDKN
	hG8Onf/CV0tm5eHb0EZZd5Qx8X6SvqNE6FB+IGMbgH8BMInEE3rEi5l4zeUKzUeQcqoaWnSrgWS
	rqRT6IWMYRZqdWEaX/583ATZc0I9cAhV8Eh4oDSr7
X-Gm-Gg: ASbGncvx0KAg6i9e4cAI7bwrQ0RAydS033/83uPxEifbu2h5c5neHLNsI/9uOunueyC
	tdboxDzt1Bf2NTKLwKzZgqIsf0IoXVwUai0HTjh98aHFITasckg9KJ5+cQPCla12+GFmG4LCXwb
	ax6E5sVp6WfS0Xp8UO9ZBepGgSkzpikPgHZszIAtSbjYLbiwxKJx6ffAYb6G/T0UvrkNO1QO6FX
	VzJgm1+TsGLf0I4GNp4Xcdwkf3RIhUyXzwlerK7wQ==
X-Google-Smtp-Source: AGHT+IGk55n67nvdF5H9WDAnmQzjLuubvNZPSSXOyJoe/oFJDGVfHrkafTJCSWt65p+AC3QkUld/UJ3aBwDda9Rv30E=
X-Received: by 2002:a17:90b:4a87:b0:32e:d600:4fdb with SMTP id
 98e67ed59e1d1-339a6f37ce0mr5541188a91.18.1759354645111; Wed, 01 Oct 2025
 14:37:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929213520.1821223-1-bboscaccy@linux.microsoft.com>
In-Reply-To: <20250929213520.1821223-1-bboscaccy@linux.microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 1 Oct 2025 17:37:13 -0400
X-Gm-Features: AS18NWCqxt9xU6eK1mny_V1J2q-UmT1yVLsEnrMcuGdYWYeMFG2BEOGlK06TRJk
Message-ID: <CAHC9VhTQ_DR=ANzoDBjcCtrimV7XcCZVUsANPt=TjcvM4d-vjg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] BPF signature hash chains
To: Linus Torvalds <torvalds@linux-foundation.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, ast@kernel.org, kpsingh@kernel.org, 
	james.bottomley@hansenpartnership.com
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kys@microsoft.com, daniel@iogearbox.net, andrii@kernel.org, 
	wufan@linux.microsoft.com, qmo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 5:35=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> This patchset extends the currently proposed signature verification
> patchset
> https://lore.kernel.org/linux-security-module/20250813205526.2992911-1-kp=
singh@kernel.org/
> with hash-chain functionality to verify the contents of arbitrary
> maps.
>
> The currently proposed loader + map signature verification
> scheme=E2=80=94requested by Alexei and KP=E2=80=94is simple to implement =
and
> acceptable if users/admins are satisfied with it. However, verifying
> both the loader and the maps offers additional benefits beyond just
> verifying the loader:
>
> 1. Simplified Loader Logic: The lskel loader becomes simpler since it
>    doesn=E2=80=99t need to verify program maps=E2=80=94this is already ha=
ndled by
>    bpf_check_signature().
>
> 2. Security and Audit Integrity: A key advantage is that the LSM
>   (Linux Security Module) hook for authorizing BPF program loads can
>   operate after signature verification. This ensures:
>
>   * Access control decisions can be based on verified signature
>   * status.  Accurate system state measurement and logging.  Log
>   * events claiming a verified signature are fully truthful, avoiding
>   * misleading entries that only the loader was verified while the
>   * actual BPF program verification happens later without logging.
>
> This approach addresses concerns from users who require strict audit
> trails and verification guarantees, especially in security-sensitive
> environments.
>
> A working tree with this patchset is being maintained at
> https://github.com/blaiseboscaccy/linux/tree/bpf-hash-chains
>
> bpf CI tests passed as well
> https://github.com/kernel-patches/bpf/actions/runs/18110352925
>
> v2 -> v1:
>    - Fix regression found by syzkaller
>    - Add bash auto-complete support for new command line switch
>
> Blaise Boscaccy (3):
>   bpf: Add hash chain signature support for arbitrary maps
>   selftests/bpf: Enable map verification for some lskel tests
>   bpftool: Add support for signing program and map hash chains
>
>  include/uapi/linux/bpf.h                      |  6 ++
>  kernel/bpf/syscall.c                          | 73 ++++++++++++++++++-
>  .../bpf/bpftool/Documentation/bpftool-gen.rst |  7 +-
>  tools/bpf/bpftool/bash-completion/bpftool     |  2 +-
>  tools/bpf/bpftool/gen.c                       | 27 ++++++-
>  tools/bpf/bpftool/main.c                      |  9 ++-
>  tools/bpf/bpftool/main.h                      |  1 +
>  tools/bpf/bpftool/sign.c                      | 16 +++-
>  tools/include/uapi/linux/bpf.h                |  6 ++
>  tools/lib/bpf/libbpf.h                        |  3 +-
>  tools/lib/bpf/skel_internal.h                 |  6 +-
>  tools/testing/selftests/bpf/Makefile          | 18 ++++-
>  12 files changed, 159 insertions(+), 15 deletions(-)

During a discussion of one of Blaise's earlier BPF signature
verification proposals Alexei mentioned that it sounded like I was
looking for Linus' opinion on our debate[1].  At the time I replied
that I was more interested in trying to find out what the BPF devs
wanted for a BPF program signing solution, and working towards making
sure we had something that worked for everyone[2].  That was almost
five months ago, and while Alexei and KP have provided an example of
their ideal solution, it can now be found in Linus' tree, they have
ignored the larger issues brought up by the LSM community and have
refused to review or comment on Blaise's many attempts[3][4][5][6] to
reconcile the needs of the two communities.

With the lack of engagement from the BPF devs, I'm now at the point
where I'm asking Linus to comment on the current situation around
Blaise's patchset.  I recognize that Alexei and KP have a strong
affinity for the signature scheme implemented in KP's patchset, which
is fine, but if we are going to be serious about implementing BPF
signature verification that can be used by a number of different user
groups, we also need to support the signature scheme that Blaise is
proposing[6].

To make it clear at the start, Blaise's patchset does not change,
block, or otherwise prevent the BPF program signature scheme
implemented in KP's patchset.  Blaise intentionally designed his
patches such that the two signature schemes can coexist together in
the same kernel, allowing users to select which scheme to use on each
BPF program load, enabling the kernel to support policy to selectively
enforce rules around which signature scheme is permitted for each BPF
program load.

Blaise's patch implements an alternate BPF program signature scheme,
using the same basic concepts as KP's design (light skeletons, hash
chaining, etc.), but does so in such a way that the kernel verifies
all relevant parts of the BPF program load prior to calling the
security_bpf_prog_load() LSM hook.  KP's signature scheme only
verifies the light skeleton prior to calling the LSM hook and relies
on the BPF code in the light skeleton to verify the original BPF
program.

Relying on a light skeleton to verify the BPF program means that any
verification failures in the light skeleton will be "lost" as there is
no way to convey an error code back to the user who is attempting the
BPF program load.  Blaise's approach to verifying the full signature
in the kernel, and not relying on the light skeleton for verification,
means that verification failures can be returned to the user; there
are no silent signature verification failures like one can experience
with KP's verification scheme.

KP's signature verification scheme is a two-part scheme with the
security_bpf_prog_load() LSM hook being called after the light
skeleton signature has been verified, but before the light skeleton
verifies the BPF program.  Aside from breaking with typical
conventions around the placement of LSM hooks, this "halfway" approach
makes it difficult for LSMs to log anything about the signature status
of a BPF program being loaded, or use the signature status in any type
of access decision.  This is important for a number of user groups
that use LSM based security policies as a way to help reason about the
security properties of a system, as KP's scheme would require the
users to analyze the signature verification code in every BPF light
skeleton they authorize as well as the LSM policy in order to reason
about the security mechanisms involved in BPF program loading.

Blaise's signature scheme also has the nice property that BPF ELF
objects created using his scheme are backwards compatible with
existing released kernels that do not support any BPF signature
verification schemes, of course without any signature verification.
Loading a BPF ELF object using KP's signature scheme will likely fail
when loaded on existing released kernels.

[1] https://lore.kernel.org/linux-security-module/CAADnVQ+C2KNR1ryRtBGOZTNk=
961pF+30FnU9n3dt3QjaQu_N6Q@mail.gmail.com/
[2] https://lore.kernel.org/linux-security-module/CAHC9VhRjKV4AbSgqb4J_-xhk=
WAp_VAcKDfLJ4GwhBNPOr+cvpg@mail.gmail.com/
[3] https://lore.kernel.org/linux-security-module/87sei58vy3.fsf@microsoft.=
com/
[4] https://lore.kernel.org/linux-security-module/20250909162345.569889-2-b=
boscaccy@linux.microsoft.com/
[5] https://lore.kernel.org/linux-security-module/20250926203111.1305999-1-=
bboscaccy@linux.microsoft.com/
[6] https://lore.kernel.org/linux-security-module/20250929213520.1821223-1-=
bboscaccy@linux.microsoft.com/

--=20
paul-moore.com

