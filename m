Return-Path: <bpf+bounces-13615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3A87DBE85
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 18:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 243B32811A9
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 17:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CA819457;
	Mon, 30 Oct 2023 17:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KScjAMMf"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F421D1945A
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 17:11:15 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06534D9;
	Mon, 30 Oct 2023 10:11:14 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32f7c44f6a7so1408295f8f.1;
        Mon, 30 Oct 2023 10:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698685872; x=1699290672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ry3Aypoe5JPo+tRS+yvTNFBsfgQ4Fm63F5zsO3uosT0=;
        b=KScjAMMfWRUBxYBDzV0AKyprR9mOVil9nTMUSmA15jwsKTA5sJD8iqik2rAYO7AQAa
         6F4NzYsbMvWZY5sibLG9cC+noocISccLjlxdCNhp5M+ivyzResmy/mdahGFUlQETrvP4
         5bWHZ684h8I5FUlLba1iW4XEq169s83PwezDMB8SxyvVr8qZUmcnCrSO/19DjeT3bA7p
         nHUk08WFcKTsRqvdr1J8ub/31OoLYOChWNAUZA9r3uAsoVtWHRnfsD2Fexcn4fjBq5Ia
         5RWYe9Ey//quQONeXfuiPRkwLdiv2bTJM5W51ROKkEqGY4cA8Ma3RdxYyDskfRgNjOO/
         o39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698685872; x=1699290672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ry3Aypoe5JPo+tRS+yvTNFBsfgQ4Fm63F5zsO3uosT0=;
        b=MnVfK8WsAQMIF8I9jk45HkgIw176DZEhhxkiOptT8ir1wLGY+2VPxEbZLHbKrOXI/Q
         VcmUTNWT76gPlu5xYrXO8HxG0mm9D8gosr7YI2O2+vlfwp5qDaRcW1UBiaK9u8IiJeZO
         mLJ5cWm4ZnTjq1vDvpgoSgg+O8rdfbrKR8QVrYwedPfYuTqzJOwpLgKYHVhSbUo9z6gU
         eUs72xh+clnC9ilm1ImbbZMjC+u8UAt2u90nuzYnWtq9kqS4YHhVxiChmI2BmbrQjsOm
         Iv/pWlkcKGkygfOylREvA+7IMgT+nRTAg4kiWLVlbdJ3kylFeACwsLgITueKA0a04VYx
         n7wA==
X-Gm-Message-State: AOJu0Yz6UdArhuso9VUOQjwp9ETf8SCa+5uChn/zQE68ZiwIx/Wud7V/
	hPYQuAumnHFToMXtYd0FMYqes1uXvd+W4oy6nT8=
X-Google-Smtp-Source: AGHT+IFFA8HajvEcs6Z39LGJi+lHKvMiO49+MSFy94JzgZ7XQhe36VP3AUafTfu9BuF3gzqgnemmWWhG2VTzuhaLUz0=
X-Received: by 2002:adf:f605:0:b0:32d:89b5:7fd9 with SMTP id
 t5-20020adff605000000b0032d89b57fd9mr7973222wrp.56.1698685872109; Mon, 30 Oct
 2023 10:11:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG48ez0ppjcT=QxU-jtCUfb5xQb3mLr=5FcwddF_VKfEBPs_Dg@mail.gmail.com>
In-Reply-To: <CAG48ez0ppjcT=QxU-jtCUfb5xQb3mLr=5FcwddF_VKfEBPs_Dg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 30 Oct 2023 10:11:00 -0700
Message-ID: <CAADnVQKm3u+XbMoRxXSwg_d+Q80jPdqgzO6Yz+6JXvYATyMEZw@mail.gmail.com>
Subject: Re: BPF: bpf_d_path() can be invoked on "struct path" not holding
 proper references, resulting in kernel memory corruption
To: Jann Horn <jannh@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, KP Singh <kpsingh@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, bpf <bpf@vger.kernel.org>, 
	kernel list <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 10:13=E2=80=AFAM Jann Horn <jannh@google.com> wrote=
:
>
> Hi!
>
> bpf_d_path() can be invoked on a "struct path" that results from
> following a pointer chain involving pointers that can concurrently
> change; this can lead to stuff like use-after-free in d_path().
>
> For example, the BPF verifier permits stuff like
> bpf_d_path(&current->mm->exe_file->f_path, ...), which is not actually
> safe in many contexts:
>
> current->mm->exe_file can concurrently change; so by the time
> bpf_d_path() is called, the file's refcount might have gone to zero,
> and __fput() may have already mostly torn down the file. "struct file"
> currently has some limited RCU lifetime, but that is supposed to be an
> implementation detail that BPF shouldn't be relying on, and "struct
> file" will soon have even less RCU lifetime than before (see
> <https://lore.kernel.org/all/20230930-glitzer-errungenschaft-b86880c177c4=
@brauner/>).
>
> When __fput() tears down a file, it drops the references held by
> file->f_path.mnt and file->f_path.dentry. "struct vfsmount" has some
> kind of RCU lifetime, but "struct dentry" will be freed directly in
> dentry_free() if it has DCACHE_NORCU set, which is the case if it was
> allocated via d_alloc_pseudo(), which is how memfd files are
> allocated.
>
> So the following race is possible, if we start in a situation where
> current->mm->exe_file points to a memfd:
>
> thread A            thread B
> =3D=3D=3D=3D=3D=3D=3D=3D            =3D=3D=3D=3D=3D=3D=3D=3D
> begin RCU section
> begin BPF program
> compute path =3D &current->mm->exe_file->f_path
>
>                     prctl(PR_SET_MM, PR_SET_MM_MAP, ...)
>                       updates current->mm->exe_file
>                       calls fput() on old ->exe_file
>                     __fput() runs
>                       dput(dentry);
>                       mntput(mnt)
>
> invoke helper bpf_d_path(path, ...)
>   d_path()
>     reads path->dentry->d_op  *** UAF read ***
>     reads path->dentry->d_op->d_dname  *** read through wild pointer ***
>     path->dentry->d_op->d_dname(...) *** wild pointer call ***
>
> So if an attacker managed to reallocate the old "struct dentry" with
> attacker-controlled data, they could probably get the kernel to call
> an attacker-provided function pointer, eventually letting an attacker
> gain kernel privileges.
>
> Obviously this is not a bug an unprivileged attacker can just hit
> directly on a system where no legitimate BPF programs are already
> running, because loading tracing BPF programs requires privileges; but
> if a privileged process loads a tracing BPF program that does
> something unsafe like "bpf_d_path(&current->mm->exe_file->f_path,
> ...)", an attacker might be able to leverage that.

Thanks for the report. That's a verifier bug indeed.
Curious, did you actually see such broken bpf program or this is
theoretical issue in case somebody will write such thing ?

>
> If BPF wants to be able to promise that buggy BPF code can't crash the
> kernel (or, worse, introduce privilege escalation vulnerabilities in
> the kernel),

Only the former. The verifier cannot possibly guarantee that the bpf-lsm
program or tracing bpf prog is not leaking addresses or acting maliciously.
Same in networking. XDP prog might be doing firewalling incorrectly,
dropping wrong packets, disabling ssh when it shouldn't, etc.
We cannot validate semantics. The verifier tries to guarantee non-crash onl=
y.
Hence loading bpf prog is a privileged operation.

But back to the verifier bug... I suspect it will be very hard to
craft a test that does prctl(PR_SET_MM) and goes all the way through
the delayed fput logic on one cpu while bpf prog under rcu_read_lock
calls bpf_d_path on the other cpu. I can see this happening in theory
and we need to close this verification gap, but we need to be realistic
in assessing the severity of it.
To fix it we need to make bpf_d_path KF_TRUSTED_ARGS. All new kfuncs
are done this way already. They don't allow unrestricted pointer walks.

