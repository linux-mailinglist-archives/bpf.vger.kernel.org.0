Return-Path: <bpf+bounces-53284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEC9A4F560
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 04:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7793A3AAB0D
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 03:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2E5178CC8;
	Wed,  5 Mar 2025 03:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byv92Paf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC5615ADB4;
	Wed,  5 Mar 2025 03:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741145241; cv=none; b=dzrGtJID98UoetlwAXRQmXmNpr0od+7QX8yoN+mUPNmkfGeqiqVeBQQG/Jj8z9FQVm081Ik8aFSLreMSNjFO6lL5EGinw/8XXHRvvAWqoRbmDvz4NKvZhrm0UxabVUX9/8jTOcGsy7/uwej4VyhDxN662UOm0UsrsTbA+4/TgTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741145241; c=relaxed/simple;
	bh=WBgSF4UBZQyZjZW3u3Cq7JSWapQYwqNCP5nk3gjjiYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bs/r9IgThnzewbUquimxUSc9+qz/3EDe0bHOvYEBT8DN6AdSc8QrakePpHI+qF2huM0k4pXO8mU4pN6ZoYfgeXCBZ/3lD7ZP537rLuTtSdIUKELtgSM4b1zFCNrxplflDKemCl6uD1aDv81OZwP7HN3OfA6WEdbyzc+Blu96GEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byv92Paf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E3CC4CEEA;
	Wed,  5 Mar 2025 03:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741145240;
	bh=WBgSF4UBZQyZjZW3u3Cq7JSWapQYwqNCP5nk3gjjiYw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=byv92PafIfFYDcTnfanRVxyhE5a2y/G8/OsJmXy5x3ZC86p/RuRN7lfEMeT2doJ+y
	 boLrZI8D+atx0vFCKjbsj1kXBl0wdkTWijKYzGszaH/OTIRSAnQJ/Ctc3Vl/2KA9Zq
	 1reiEsh9xWmS4gqNU81uyllj+xsHdpBkwtNWn683Si5TT4JwpKYo8atNiB0kd5ig47
	 PwU4DUPFi4ISnYU1WrYKBeZY7le/YguWnX8RxR9yvLcFKtFbRz1YuyZKLjUIsb3srn
	 A3ZVPUuZvai4wUJ9T8liaDCIXf/V01WX7CHoQYDrRsThctYlTj5sXD/KhyZXZ2iRXz
	 AGTwOJgboRF+w==
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-855fc51bdfcso14386439f.0;
        Tue, 04 Mar 2025 19:27:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUjy6Ovqd4YyDY5u6w5Qn7GlMV5HfxAa34FED1WfUzJXh46KxJjBHdXkvOEz2igxIUbr6BbFkLisw==@vger.kernel.org, AJvYcCV6KlpVHkvuQtKUtxeNCtH7S1ze5ZDFs7Mf9k3A9S9JfPM00GKcITwSie7ntr+LgYbjh+dGbjwk79lP2Fr73aPfXrNLET8k@vger.kernel.org, AJvYcCVPNKvSGlSRqyGhKQeTX0MOK/Do1nk2qtB2WR0R7XxoOSBh4PbZm21Pn+kACnyB8J7VTrLdsAeHZMs4iR5x@vger.kernel.org, AJvYcCVbKo54AbMOypnEHMMydPb7Cn4rhwV/nt9vLT8U8YyvlXJpG6LiylFRJM19jiaNdnPk5oY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNxfvj37yNBnAkdk/Fw8XwgbULxkpRUxht+4OL63LcoDP5bRij
	BAHLnOsEnlcf29BuD8VKifPgXDMaIyI5fXVm4zi2rYFUSwrQj8NWDQM8kLVQdFv31rAl08pjQX6
	o6hFjcqJ50mOQCYNUD64VEhdAaz8=
X-Google-Smtp-Source: AGHT+IHn6wMp+M46MuU+WD/XHhz/bc9tkmv0qmpjdIsOMxu6p4rRCfKMk+gSv53uXz9LW9XURyM5j+m53mcZk7+IsUY=
X-Received: by 2002:a05:6e02:eca:b0:3d4:2306:fbb6 with SMTP id
 e9e14a558f8ab-3d42306fde0mr43856365ab.10.1741145240129; Tue, 04 Mar 2025
 19:27:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304203123.3935371-1-bboscaccy@linux.microsoft.com>
 <20250304203123.3935371-3-bboscaccy@linux.microsoft.com> <CAPhsuW5HJuRYPucfvDbs25un7_D8JJnt=7zNUJ1utY3O_VMeSw@mail.gmail.com>
 <87a5a0jotf.fsf@microsoft.com>
In-Reply-To: <87a5a0jotf.fsf@microsoft.com>
From: Song Liu <song@kernel.org>
Date: Tue, 4 Mar 2025 19:27:09 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6+vrRG57=7sxTjv0J1njJ-H0usx18xx_sWA+U2oZBtDA@mail.gmail.com>
X-Gm-Features: AQ5f1JpXurhnuKJL8LDxjijcgu3abQTLRKE5g0E4JhCketpuBCOzyM_KnN0EAlI
Message-ID: <CAPhsuW6+vrRG57=7sxTjv0J1njJ-H0usx18xx_sWA+U2oZBtDA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/2] selftests/bpf: Add is_kernel parameter to
 LSM/bpf test programs
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
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

On Tue, Mar 4, 2025 at 4:36=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> Song Liu <song@kernel.org> writes:
>
> > On Tue, Mar 4, 2025 at 12:31=E2=80=AFPM Blaise Boscaccy
> > <bboscaccy@linux.microsoft.com> wrote:
> >>
> >> The security_bpf LSM hook now contains a boolean parameter specifying
> >> whether an invocation of the bpf syscall originated from within the
> >> kernel. Here, we update the function signature of relevant test
> >> programs to include that new parameter.
> >>
> >> Signed-off-by: Blaise Boscaccy bboscaccy@linux.microsoft.com
> > ^^^ The email address is broken.
> >
>
> Whoops, appologies, will get that fixed.
>
> >> ---
> >>  tools/testing/selftests/bpf/progs/rcu_read_lock.c           | 3 ++-
> >>  tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c  | 4 ++--
> >>  tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c | 6 +++--=
-
> >>  tools/testing/selftests/bpf/progs/test_lookup_key.c         | 2 +-
> >>  tools/testing/selftests/bpf/progs/test_ptr_untrusted.c      | 2 +-
> >>  tools/testing/selftests/bpf/progs/test_task_under_cgroup.c  | 2 +-
> >>  tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c   | 2 +-
> >>  7 files changed, 11 insertions(+), 10 deletions(-)
> >
> > It appears you missed a few of these?
> >
>
> Some of these don't require any changes. I ran into this as well while do=
ing a
> search.
>
> These are all accounted for in the patch.
> > tools/testing/selftests/bpf/progs/rcu_read_lock.c:SEC("?lsm.s/bpf")
> > tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c:SEC("lsm/bpf=
")
> > tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c:SEC("lsm.s/b=
pf")
> > tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c:SEC("?lsm.s=
/bpf")
> > tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c:SEC("?lsm.s=
/bpf")
> > tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c:SEC("lsm.s/=
bpf")
>
> security_bpf_map wasn't altered, it can't be called from the kernel. No
> changes needed.
> > tools/testing/selftests/bpf/progs/test_libbpf_get_fd_by_id_opts.c:SEC("=
lsm/bpf_map")
>
> These are also all accounted for in the patch.
> > tools/testing/selftests/bpf/progs/test_lookup_key.c:SEC("lsm.s/bpf")
> > tools/testing/selftests/bpf/progs/test_ptr_untrusted.c:SEC("lsm.s/bpf")
> > tools/testing/selftests/bpf/progs/test_task_under_cgroup.c:SEC("lsm.s/b=
pf")
> > tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c:SEC("lsm.s/bp=
f")
>
> bpf_token_cmd and bpf_token_capabable aren't callable from the kernel,
> no changes to that hook either currently.
>
> > tools/testing/selftests/bpf/progs/token_lsm.c:SEC("lsm/bpf_token_capabl=
e")
> > tools/testing/selftests/bpf/progs/token_lsm.c:SEC("lsm/bpf_token_cmd")
>
>
> This program doesn't take any parameters currently.
> > tools/testing/selftests/bpf/progs/verifier_global_subprogs.c:SEC("?lsm/=
bpf")
>
> These are all naked calls that don't take any explicit parameters.
> > tools/testing/selftests/bpf/progs/verifier_ref_tracking.c:SEC("lsm.s/bp=
f")
> > tools/testing/selftests/bpf/progs/verifier_ref_tracking.c:SEC("lsm.s/bp=
f")
> > tools/testing/selftests/bpf/progs/verifier_ref_tracking.c:SEC("lsm.s/bp=
f")
> > tools/testing/selftests/bpf/progs/verifier_ref_tracking.c:SEC("lsm.s/bp=
f")
> > tools/testing/selftests/bpf/progs/verifier_ref_tracking.c:SEC("lsm.s/bp=
f")
> > tools/testing/selftests/bpf/progs/verifier_ref_tracking.c:SEC("lsm.s/bp=
f")
> > tools/testing/selftests/bpf/progs/verifier_ref_tracking.c:SEC("lsm.s/bp=
f")

Thanks for the explanation. I think we can keep this part as-is.

Song

