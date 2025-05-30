Return-Path: <bpf+bounces-59356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060B2AC93C6
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 18:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 354C7165B2A
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 16:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3421C6FE8;
	Fri, 30 May 2025 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XG6B+NN/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7255B1D5150
	for <bpf@vger.kernel.org>; Fri, 30 May 2025 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748623339; cv=none; b=h7zyuSTWg4QnaBN3BO8XLSi4dNvee/+5oVaLCTyB0QAOAU3yfxKzK/YQ0lB7Unqs/NFhIcivNPAecTXwYdpw+qYvy+8qMfuqRTisw48zdPdnyesBIWsc0s0xNxQ1+RiiqaF1lynwITyX8zzgfJK5+/oEoHV3CvI4sAyhO4Nv9kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748623339; c=relaxed/simple;
	bh=6IpXsTCAiLKJWps9H8u+WyFNAUSFFMG0gHMOiyUtGhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=usyCXoLPjoyp2i0+Zc9hDnnRQBr+Bi7JlJ71nMNVlrjgzB1ZIlh0pJb8YNY+V97b78RyA0C9aAYCU626s114SQnNeeSDSu49F2cL3Thh2/vjoBJ75gGlWBRTxVsGpKIiZaXYXla7rp/p9eXczg50CpJkZMjNkVgs8wDbJKjNHpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XG6B+NN/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253A8C4AF0B
	for <bpf@vger.kernel.org>; Fri, 30 May 2025 16:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748623339;
	bh=6IpXsTCAiLKJWps9H8u+WyFNAUSFFMG0gHMOiyUtGhA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XG6B+NN/QJtpZyHenAGFWr311twH4kXCQ4IYLnZfgBCPnl1Lf8lCgkq/gU1x/hn0M
	 T5RQYIWPz0YWVPLHlLUPiTbBmBStzARmh2HklwELAubSPIPh0Q38wSuAqrgPbyV2se
	 bX2gJ4qhHlzP2UD3ey7ufLMJas+Dk+6/w2tsGomJzqqYLsoq2lsRcGiRylRujJfSgG
	 pkffiG2zxky6WA77s+WrMD7N7iRg5ZZ9BTvx4PCzhVR6Rl3oIPqv8JDdnMAZysYKru
	 aO3XllYbqtxVQXjJGHQOXf02fDv8Zx6re6yTozHptJI4gXun4yq0b+alPApvyRCTI0
	 IUIbxKZQUpBsA==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-602c3f113bbso4188687a12.0
        for <bpf@vger.kernel.org>; Fri, 30 May 2025 09:42:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVzFII/LJkpQI+/0ECKru7v/la3IL8y7IEskXE7rhbyoa4mq2BiP79Z2ZXzt16BRU1+XHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjJduX8tShQiDn3ednJvHfj5y9UkSDlvxcaTA2Hd85DMTemCIp
	AWZ9r/a9oTZ9T0HFFuvsiZN/1YO3I9p2rm+bitWFHVnbMuZCwdEPvChqwfHbn2wvveH9jcsBySO
	QIYKfXJfUMEtTvsaSuPjQxaXJKOeDjRlBnmDuqULn
X-Google-Smtp-Source: AGHT+IF2FYqfEVWekW2bGIEEdeuqDw988e+H+6pMRWdod3exqVv2+/w3XumjYUA5HTJg6yynsg8WDmm2FjVwvBVk7yM=
X-Received: by 2002:a05:6402:234d:b0:605:310a:7668 with SMTP id
 4fb4d7f45d1cf-6056e15e067mr3642169a12.22.1748623337297; Fri, 30 May 2025
 09:42:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528215037.2081066-1-bboscaccy@linux.microsoft.com>
In-Reply-To: <20250528215037.2081066-1-bboscaccy@linux.microsoft.com>
From: KP Singh <kpsingh@kernel.org>
Date: Fri, 30 May 2025 18:42:05 +0200
X-Gmail-Original-Message-ID: <CACYkzJ5oJASZ43B531gY8mESqAF3WYFKez-H5vKxnk8r48Ouxg@mail.gmail.com>
X-Gm-Features: AX0GCFs-bIfXeMrte4iZc7juw786873JPtM7-P-E2EMKVgLQje7MKvpFUlnxFlU
Message-ID: <CACYkzJ5oJASZ43B531gY8mESqAF3WYFKez-H5vKxnk8r48Ouxg@mail.gmail.com>
Subject: Re: [PATCH 0/3] BPF signature verification
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Paul Moore <paul@paul-moore.com>, jarkko@kernel.org, zeffron@riotgames.com, 
	xiyou.wangcong@gmail.com, kysrinivasan@gmail.com, code@tyhicks.com, 
	linux-security-module@vger.kernel.org, roberto.sassu@huawei.com, 
	James.Bottomley@hansenpartnership.com, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>, 
	Ignat Korchagin <ignat@cloudflare.com>, Quentin Monnet <qmo@kernel.org>, 
	Jason Xing <kerneljasonxing@gmail.com>, Willem de Bruijn <willemb@google.com>, 
	Anton Protopopov <aspsk@isovalent.com>, Jordan Rome <linux@jordanrome.com>, 
	Martin Kelly <martin.kelly@crowdstrike.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Matteo Croce <teknoraver@meta.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 11:50=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> As suggested or mandated by KP Singh
> https://lore.kernel.org/linux-security-module/CACYkzJ6VQUExfyt0=3D-FmXz46=
GHJh3d=3DFXh5j4KfexcEFbHV-vg@mail.gmail.com/,
> this patchset proposes and implements an alternative hash-chain
> algorithm for signature verification of BPF programs.
>
>
>
> This design diverges in two key ways:
>
> 1. Signature Strategy
>
> Two different signature strategies are
> implemented. One verifies only the signature of the loader program in
> the kernel, as described in the link above. The other verifies the
> program=E2=80=99s maps in-kernel via a hash chain.  The original design
> required loader programs to be =E2=80=9Cself-aborting=E2=80=9D and embedd=
ed the
> terminal hash verification logic as metaprogramming code generation
> routines inside libbpf. While this patchset supports that scheme, it
> is considered undesirable in certain environments due to the potential
> for supply-chain attack vectors and the lack of visibility for the LSM

The loader program is signed by a trusted entity, If you trust the
signature, then you trust it to do the signature verification. This is
a fairly common pattern in security and a pattern that we will be
using in other signed bpf use-cases which can choose to depend on
signed loaders.

If your build environment that signs the BPF program is compromised
and can inject arbitrary code, then signing does not help.  Can you
explain what a supply chain attack would look like here?

> subsystem.  Additionally, it is impossible to verify the code
> performing the signature verification, as it is uniquely regenerated

The LSM needs to ensure that it allows trusted LOADER programs i.e.
with signatures and potentially trusted signed user-space binaries
with unsigned or delegated signing (this will be needed for Cilium and
bpftrace that dynamically generate BPF programs), that's a more
important aspect of the LSM policy from a BPF perspective.

MAP_EXCLUSIVE is missing and is required which prevents maps from
being accessed by other programs as explained in the proposal.

Please hold off on further iterations, I am working on a series and
will share these patches based on the design that was proposed.

>
> for every program.
>
>
>
> 2. Timing of Signature Check
>
> This patchset moves the signature check to a point before
> security_bpf_prog_load is invoked, due to an unresolved discussion
> here:

This is fine and what I had in mind, signature verification does not
need to happen in the verifier and the existing hooks are good enough.
I did not reply to Paul's comment since this is a fairly trivial
detail and would be obvious in the implementation that the verifier is
not the right place to check the signature anyways as the instruction
buffer is only stable pre-verification.

> https://lore.kernel.org/linux-security-module/CAHC9VhTj3=3DZXgrYMNA+G64zs=
OyZO+78uDs1g=3Dkh91=3DGR5KypYg@mail.gmail.com/
> This change allows the LSM subsystem to be informed of the signature
> verification result=E2=80=94if it occurred=E2=80=94and the method used, a=
ll without
> introducing a new hook. It improves visibility and auditability,
> reducing the =E2=80=9Ctrust me, friend=E2=80=9D aspect of the original de=
sign.


On Wed, May 28, 2025 at 11:50=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> As suggested or mandated by KP Singh
> https://lore.kernel.org/linux-security-module/CACYkzJ6VQUExfyt0=3D-FmXz46=
GHJh3d=3DFXh5j4KfexcEFbHV-vg@mail.gmail.com/,
> this patchset proposes and implements an alternative hash-chain
> algorithm for signature verification of BPF programs.
>
> This design diverges in two key ways:
>
> 1. Signature Strategy
>
> Two different signature strategies are
> implemented. One verifies only the signature of the loader program in
> the kernel, as described in the link above. The other verifies the
> program=E2=80=99s maps in-kernel via a hash chain.  The original design
> required loader programs to be =E2=80=9Cself-aborting=E2=80=9D and embedd=
ed the
> terminal hash verification logic as metaprogramming code generation
> routines inside libbpf. While this patchset supports that scheme, it
> is considered undesirable in certain environments due to the potential
> for supply-chain attack vectors and the lack of visibility for the LSM
> subsystem.  Additionally, it is impossible to verify the code
> performing the signature verification, as it is uniquely regenerated
> for every program.
>
> 2. Timing of Signature Check
>
> This patchset moves the signature check to a point before
> security_bpf_prog_load is invoked, due to an unresolved discussion
> here:
> https://lore.kernel.org/linux-security-module/CAHC9VhTj3=3DZXgrYMNA+G64zs=
OyZO+78uDs1g=3Dkh91=3DGR5KypYg@mail.gmail.com/
> This change allows the LSM subsystem to be informed of the signature
> verification result=E2=80=94if it occurred=E2=80=94and the method used, a=
ll without
> introducing a new hook. It improves visibility and auditability,
> reducing the =E2=80=9Ctrust me, friend=E2=80=9D aspect of the original de=
sign.
>
>
> Blaise Boscaccy (3):
>   bpf: Add bpf_check_signature
>   bpf: Support light-skeleton signatures in autogenerated code
>   bpftool: Allow signing of light-skeleton programs
>
>  include/linux/bpf.h            |   2 +
>  include/linux/verification.h   |   1 +
>  include/uapi/linux/bpf.h       |   4 +
>  kernel/bpf/arraymap.c          |  11 +-
>  kernel/bpf/syscall.c           | 123 +++++++++++++++++++-
>  tools/bpf/bpftool/Makefile     |   4 +-
>  tools/bpf/bpftool/common.c     | 204 +++++++++++++++++++++++++++++++++
>  tools/bpf/bpftool/gen.c        |  66 ++++++++++-
>  tools/bpf/bpftool/main.c       |  24 +++-
>  tools/bpf/bpftool/main.h       |  23 ++++
>  tools/include/uapi/linux/bpf.h |   4 +
>  tools/lib/bpf/libbpf.h         |   4 +
>  tools/lib/bpf/skel_internal.h  |  28 ++++-
>  13 files changed, 491 insertions(+), 7 deletions(-)
>
> --
> 2.48.1
>

