Return-Path: <bpf+bounces-53285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71831A4F568
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 04:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B86013AAA0A
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 03:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBE017B401;
	Wed,  5 Mar 2025 03:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9l84r44"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493AC2E336F;
	Wed,  5 Mar 2025 03:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741145538; cv=none; b=mnnVqLdEi+VUJQlygFCh/I07Y4bMGVxa6KfenGQwPIqd+mhvwLsiQygSkeopextwl6D/sXUTtnMKhScEOxoAHwaTrGQgB2UCE0ZyNRsrUAxCfF/XlJj3Ei105qlJu4a0KaI2f1rChAcIGTqL0W0FVfgu2xBETxUvf14iz6SY2RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741145538; c=relaxed/simple;
	bh=kaI2BVUhINYk4BdEgl++NddAmElmr4QujrUOFdMOkak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XF9Ucjli7pJaFvHSyhtf1uyjL0Kei3dQyofVzA4ssurWq5a2EFmozV5GB2pzkR4uUVvyt5Ht2vXj2dj7V8/TcKTI1t58lq/xbei1hPwgt0o6plURcg9shdPKkQBr3lzbQRafOTiwgIGTrafq+N8rJ0pHCNPam2dqpnWuHIXFtWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9l84r44; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09ACDC4CEF0;
	Wed,  5 Mar 2025 03:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741145538;
	bh=kaI2BVUhINYk4BdEgl++NddAmElmr4QujrUOFdMOkak=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B9l84r44Wsq2yEmyzrYB+dzzSta324wsaXDS4wjRQFT7wwkdl8CtxFkJm/SGrtWMf
	 lCb4xzZCxf6Z/7SynSMZEzxOMey198P1zoyPtMdjiAuszCmMmkOa2cw2PRtqJqe6p3
	 HUfICiwdQCa5IVfxQakx7zCht0G3xK/9b0/nDrxRfWUGE2VgzOniaR9xD8m3RSN6MY
	 50wrb2kGyMSh8XqwUG+lI7vbRJg6lBjAdDFhP3d/kEf4ZkI1eSykCwzCm88ATeG+1Z
	 o8sggsRnyGjYqfRJKcK0t6YbVHTQgodUl8bKNnsS7OcJAm3K4v8dMsPK2eSUxSQPzh
	 9p8DuoYPqagOw==
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3d3cb06d947so1476195ab.0;
        Tue, 04 Mar 2025 19:32:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWEk7WBmARBIfHHJiNYq7T9nrQKskFNjHd+OfZ7m0VVsciM8kO5KsbvcYjhwS/ZVmzm+eo=@vger.kernel.org, AJvYcCWr4oHGzrHHufmqpraCCR6mjPaq7xkFECnboTvqyI6LH5vkFDVDlxnr2K4Q1SRFL1yjBZ1bSd5ZCg==@vger.kernel.org, AJvYcCWw4GD2alGvn+3eZKAQxiKvrQJ4LvrnuqcdjEp7ims1xE+VMGy9uxPolJ6fiupdue2NrkVA1SjDWCLCUYWRu1Kkyj6LHlhK@vger.kernel.org, AJvYcCXUM7ep86J2JjDIkw7IQmp0kk5yezp8pZhn8p8BWukdFlfRLSkcmOSF7Py8xD/OjqQyboxvGgUQaklFuX7Y@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq6Cg7BfcHOvMhLh5IfcsJACPf6ttyvD0gS2POdljDFPyhsfMg
	Cbkn7lTZcso6e8/O2IRnXanvQT5U6z4rWW6g0Vk5SMeAK6Z5WF7UCwpuIjc4Y5sPO6Ir4t2wnM4
	eOgiOqkxirsGbjfxVyo26qFC0k8k=
X-Google-Smtp-Source: AGHT+IHa/AFZ5A9CSZsNzwQ5FS3bMQFVRd6JOBQxQshlk659zsVgBdB1d4ayWcmlcEOafi/x8H7reqf1OG4ZlE5pQWo=
X-Received: by 2002:a05:6e02:eca:b0:3d4:2306:fbb6 with SMTP id
 e9e14a558f8ab-3d42306fde0mr43980215ab.10.1741145537315; Tue, 04 Mar 2025
 19:32:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304203123.3935371-1-bboscaccy@linux.microsoft.com>
 <20250304203123.3935371-3-bboscaccy@linux.microsoft.com> <CAHC9VhS5Gnj98K4fBCq3hDXjmj1Zt9WWqoOiTrwH85CDSTGEYA@mail.gmail.com>
 <877c54jmjl.fsf@microsoft.com> <CAHC9VhQO_CVeg0sU_prvQ_Z8c9pSB02K3E5s84pngYN1RcxXGQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQO_CVeg0sU_prvQ_Z8c9pSB02K3E5s84pngYN1RcxXGQ@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 4 Mar 2025 19:32:06 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6RrUiXaQe1HBYOvwUx2GFaA-RKx22955A2StsP2erTeA@mail.gmail.com>
X-Gm-Features: AQ5f1JqaM5K5MwU1XON5P30qZGJCmC1zwPxswjHN82TpVqqjA9oZU_jj-70Kavs
Message-ID: <CAPhsuW6RrUiXaQe1HBYOvwUx2GFaA-RKx22955A2StsP2erTeA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/2] selftests/bpf: Add is_kernel parameter to
 LSM/bpf test programs
To: Paul Moore <paul@paul-moore.com>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 6:14=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Tue, Mar 4, 2025 at 8:26=E2=80=AFPM Blaise Boscaccy
> <bboscaccy@linux.microsoft.com> wrote:
> > Paul Moore <paul@paul-moore.com> writes:
> > > On Tue, Mar 4, 2025 at 3:31=E2=80=AFPM Blaise Boscaccy
> > > <bboscaccy@linux.microsoft.com> wrote:
> > >>
> > >> The security_bpf LSM hook now contains a boolean parameter specifyin=
g
> > >> whether an invocation of the bpf syscall originated from within the
> > >> kernel. Here, we update the function signature of relevant test
> > >> programs to include that new parameter.
> > >>
> > >> Signed-off-by: Blaise Boscaccy bboscaccy@linux.microsoft.com
> > >> ---
> > >>  tools/testing/selftests/bpf/progs/rcu_read_lock.c           | 3 ++-
> > >>  tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c  | 4 ++-=
-
> > >>  tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c | 6 +++=
---
> > >>  tools/testing/selftests/bpf/progs/test_lookup_key.c         | 2 +-
> > >>  tools/testing/selftests/bpf/progs/test_ptr_untrusted.c      | 2 +-
> > >>  tools/testing/selftests/bpf/progs/test_task_under_cgroup.c  | 2 +-
> > >>  tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c   | 2 +-
> > >>  7 files changed, 11 insertions(+), 10 deletions(-)
> > >
> > > I see that Song requested that the changes in this patch be split out
> > > back in the v3 revision, will that cause git bisect issues if patch
> > > 1/2 is applied but patch 2/2 is not, or is there some BPF magic that
> > > ensures that the selftests will still run properly?
> > >
> >
> > So there isn't any type checking in the bpf program's function
> > arguments against the LSM hook definitions, so it shouldn't cause any
> > build issues. To the best of my knowledge, the new is_kernel boolean
> > flag will end up living in r3. None of the current tests reference
> > that parameter, so if we bisected and ended up on the previous commit,
> > the bpf test programs would in a worst-case scenario simply clobber tha=
t
> > register, which shouldn't effect any test outcomes unless a test progra=
m
> > was somehow dependent on an uninitialized value in a scratch register.
>
> Esh.  With that in mind, I'd argue that the two patches really should
> just be one patch as you did before.  The patches are both pretty
> small and obviously related so it really shouldn't be an issue.
>
> However, since we need this patchset in order to properly implement
> BPF signature verification I'm not going to make a fuss if Song feels
> strongly that the selftest changes should be split into their own
> patch.

On second thought, I think it makes sense to merge the two patches.

Blasie, please update 1/2 based on Paul's comment, merge the two
patches, and resend. You can keep my Acked-by.

Do we need this in the LSM tree before the upcoming merge window?
If not, we would prefer to carry it in bpf-next.

Thanks,
Song

