Return-Path: <bpf+bounces-13430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5368A7D9EA5
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 19:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64E4EB21349
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 17:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14ACFC2FE;
	Fri, 27 Oct 2023 17:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fjIX1UlL"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFD839855
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 17:13:27 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE2C8263
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 10:13:25 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so695a12.0
        for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 10:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698426804; x=1699031604; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uflhsKfvfbwjHaS6RjFEsCiPUfIOoxhNzB+wL9eWIuk=;
        b=fjIX1UlL8G6KBtvFdvkO5QILXtQk2lTF2ge4R3FmTkR1vyYEseFolQrPhMt6GHGSmR
         vLEcltcmduKsB64xN8ZtDm+hiS5lbog6jusQ/7R9rMT6K1pf096wtNbqMXnqE2fA+OfY
         EELkoo0g2pWDpvk5v+Y6n4ibBP74ircVleDP+O8qXDLpAu6K19NCIDp8NuR0eNnNQ98C
         5z6rBMxLFoSgud7lTbAmOarmqn16sLP3XNMmOQsYPbL9rLTNLpNIOA+5RcXJG2II3BBE
         ScvfFmId1KbK1+/xVgsRQ0+fcvG25zI12C2rTEAtNVSzd6rwR+TqvmIqoC/iHYzyyqeE
         mhzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698426804; x=1699031604;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uflhsKfvfbwjHaS6RjFEsCiPUfIOoxhNzB+wL9eWIuk=;
        b=SDFpsON691bO8iYf3a+iq45WpOO39wW/slGbNqCaLVVRNHNPgTyS3dKlC1tX4+rMtK
         pnHUp7u3hQxN+6w/LmfCECA5c15R01lqXyTpRIU66NvJJbtFgAFDoZoVRAScxAO6B7fr
         rragL2MBcgJnfQbYk8i3jcbYjWQo+FCd9InyJHQiROAD2pm4Xf15mUWpxpsvvLfqLCmu
         qpQojPGwVbaFAV2j9ipqSRxLqqgzrrlIZT46xnp6gOKKHERpAk2IXQR5Q58D9iLwyzPU
         3dc+MPJIyt1q0LfrZRWNTAIF0vC/ypuYozTZPpfRHKtMe4QZgq4Hiza0J2nOv1pBVgsT
         rLOA==
X-Gm-Message-State: AOJu0YxvXEvuQZuDQUJz8nwrowcnSEhVXzuY4/QPImiDPRTD+HlAJRNg
	1DL8GwZtva6si8Rf+Tmg+9bCLs1tQ50Sx95bPIpmdw==
X-Google-Smtp-Source: AGHT+IHOvFL9mA8YBWOthCUpt1ZhxYvIdt/6fYMiYEU9KLiquQGWtbEsl36bprL2FV1Qgbf78c900cT1sfmkon2Wajg=
X-Received: by 2002:a50:c101:0:b0:540:e46c:5c7e with SMTP id
 l1-20020a50c101000000b00540e46c5c7emr12155edf.0.1698426804082; Fri, 27 Oct
 2023 10:13:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jann Horn <jannh@google.com>
Date: Fri, 27 Oct 2023 19:12:46 +0200
Message-ID: <CAG48ez0ppjcT=QxU-jtCUfb5xQb3mLr=5FcwddF_VKfEBPs_Dg@mail.gmail.com>
Subject: BPF: bpf_d_path() can be invoked on "struct path" not holding proper
 references, resulting in kernel memory corruption
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, KP Singh <kpsingh@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, bpf <bpf@vger.kernel.org>, 
	kernel list <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

Hi!

bpf_d_path() can be invoked on a "struct path" that results from
following a pointer chain involving pointers that can concurrently
change; this can lead to stuff like use-after-free in d_path().

For example, the BPF verifier permits stuff like
bpf_d_path(&current->mm->exe_file->f_path, ...), which is not actually
safe in many contexts:

current->mm->exe_file can concurrently change; so by the time
bpf_d_path() is called, the file's refcount might have gone to zero,
and __fput() may have already mostly torn down the file. "struct file"
currently has some limited RCU lifetime, but that is supposed to be an
implementation detail that BPF shouldn't be relying on, and "struct
file" will soon have even less RCU lifetime than before (see
<https://lore.kernel.org/all/20230930-glitzer-errungenschaft-b86880c177c4@brauner/>).

When __fput() tears down a file, it drops the references held by
file->f_path.mnt and file->f_path.dentry. "struct vfsmount" has some
kind of RCU lifetime, but "struct dentry" will be freed directly in
dentry_free() if it has DCACHE_NORCU set, which is the case if it was
allocated via d_alloc_pseudo(), which is how memfd files are
allocated.

So the following race is possible, if we start in a situation where
current->mm->exe_file points to a memfd:

thread A            thread B
========            ========
begin RCU section
begin BPF program
compute path = &current->mm->exe_file->f_path

                    prctl(PR_SET_MM, PR_SET_MM_MAP, ...)
                      updates current->mm->exe_file
                      calls fput() on old ->exe_file
                    __fput() runs
                      dput(dentry);
                      mntput(mnt)

invoke helper bpf_d_path(path, ...)
  d_path()
    reads path->dentry->d_op  *** UAF read ***
    reads path->dentry->d_op->d_dname  *** read through wild pointer ***
    path->dentry->d_op->d_dname(...) *** wild pointer call ***

So if an attacker managed to reallocate the old "struct dentry" with
attacker-controlled data, they could probably get the kernel to call
an attacker-provided function pointer, eventually letting an attacker
gain kernel privileges.

Obviously this is not a bug an unprivileged attacker can just hit
directly on a system where no legitimate BPF programs are already
running, because loading tracing BPF programs requires privileges; but
if a privileged process loads a tracing BPF program that does
something unsafe like "bpf_d_path(&current->mm->exe_file->f_path,
...)", an attacker might be able to leverage that.


If BPF wants to be able to promise that buggy BPF code can't crash the
kernel (or, worse, introduce privilege escalation vulnerabilities in
the kernel), then I think BPF programs must not be allowed to follow
any pointer chain and pass the object at the end of it into BPF
helpers.

