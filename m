Return-Path: <bpf+bounces-57435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE65AAB034
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 05:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B75B4C58B7
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 03:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CA528E586;
	Mon,  5 May 2025 23:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IPdAXIgp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A5B3B7A98
	for <bpf@vger.kernel.org>; Mon,  5 May 2025 23:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487300; cv=none; b=W8CcjkGP7pLfexqoMe2xNVt+xuR0rbkbm/WbAPBFM+yhONUMiknR3yih5EvHwQBHQ1Dj+08zNKHIy0dbvzqXbzTj99yj/8Fyeg8YBK2Pyc9wpnviKifLeCm/l9oUBVT3N3CxG7XTRlq6ZgCFDmYdPsi69D33P15/LTWDF3m8EuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487300; c=relaxed/simple;
	bh=M1rNvi5IBqtAIocwGPm1o4C7y6mmduk4IFovIptv03Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dmtCPC+yulWb5hb3+E9LeheUvP2Y2Ko1snB9CGORuGscz/JnnYMcUlE0e3YeW6JYhHuMEkO5uYPY3/Rt6OeuD8o1NdYr6U4EFQVHAQnf75vIrHpgwgMI+B6tRQ4gPQCbxrZv6ebM0SZN4XThXTcwvtaI4tHtTFDH/zcmYeZ9Dnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IPdAXIgp; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7082ce1e47cso37793217b3.2
        for <bpf@vger.kernel.org>; Mon, 05 May 2025 16:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1746487297; x=1747092097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0G1FbKrQzDvE2zFQ4OGF86gQA4uigjBt52shV4GCsH4=;
        b=IPdAXIgpIXOjwIi3qpyJiZvobbi/B5lZPls4T3SyZ349IT5rBlGbgLYfIyNKAQOIbB
         dpPvH6aFkaFpqvI8V+oEZF1JHKytlcg5Jz6KlStGpOc5O27vhH24y/ie/DxO131N/MPs
         zjeQ/YajlNY6R8WDHsuyZ3tfgNTVh99MYqbgROy/P486E3UcrK7/wW0dwp6vG0jCmoRR
         zzR6j+4G8WY/Wju41FpOn16XoVqGBZ31w6fEf/SDhZkbRXHDCXI6X+RRGIL0W2VR5WPo
         ob3GTLJ9l0jJbvz52FSGM6/0DCfm17YasWvsr4ykhHZF3J0+G3Wx0uwoejjFExnLCLYQ
         y4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746487297; x=1747092097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0G1FbKrQzDvE2zFQ4OGF86gQA4uigjBt52shV4GCsH4=;
        b=VAhtgcIKcxMav434aGlht4+NUC2I53FjxHR6otbWOCFtQnvAxCoB++DgNe6bXgEG4a
         sQ63qoMcil4YMgJw8L74t0JFEtvMtthNtDV3IijO6blq0qDz3Gx97eKOyel3ecBoaE8/
         m5XJLr5B+2pFLwJLOLLXBIz4SaJxeXbsNn9L/h1LZZUx0MFoSNN8d3Rdy8TGWuwXCE4Q
         DeyVaXhFVyJzaA0kxipnMeFNkFRlU4rrXX1ogIra5xfI7RBeHVXfFYb+D5IxK78T3A1f
         5jV9uCuPxOdRSGQLOdmmJowEo2+fEgpM1V70cgPaU7QLxdV1NlXBUt9fSdQVcEUmy0ca
         +HeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmTkx2JXIwnXniM7CC/RoLJ2AtWqFWgfVMslSiA5NOqHHz//FZEjWSsOjLEpxrRxKx1TM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzhP5s4pkKJaKChHa59XdkHQKsYJ7nhxzc4VlAJsr4mKRuiK5k
	mPyunl/AtxifWdJlenIzWRVgH7a9mtU57tmo4RL22dvyA3FS3pOL/o4r0E1Xq3B0wZ1ZWuu66yW
	F3h6aXtJnCSWqEa2Se2yR4KJ2R+3uRBmfvOaO
X-Gm-Gg: ASbGncukMdbuHCR905CgbdmwrrXixe9Vki4dMjO1kIQfP0geUJfh8DiKAnlWUf42gRb
	8302UwUnY7zjZiRsqa7MwPYcxcoQU0v2oMt3wfY5BrSDZOBLDjFZ7XI/H4o9cyzBvMSvoPO0v4z
	zFhzIXFgp+7TpikTgT0DtLVw==
X-Google-Smtp-Source: AGHT+IHLXLx91/FbEJt5yJ1gpflouu1LHjSpq+W5xEkf3fbXAPgGT1qcMH0TY3xngEgXpN4NAVmxqiTFxj/qTbkAJSQ=
X-Received: by 2002:a05:690c:600b:b0:708:cc77:8c31 with SMTP id
 00721157ae682-709197c6e00mr17569947b3.10.1746487296655; Mon, 05 May 2025
 16:21:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505215802.48449-1-kuniyu@amazon.com>
In-Reply-To: <20250505215802.48449-1-kuniyu@amazon.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 5 May 2025 19:21:25 -0400
X-Gm-Features: ATxdqUHN1aQ5sN5xgMfe_tU3NdrBy8rWAl_E8NdG3Ln9Hdp4hd4BbKVFegZ9Jhs
Message-ID: <CAHC9VhSWS2L3qwu_r_1Fr3eLp-9KRz3_20EPwy=FFu7_eSiN7g@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 0/5] af_unix: Allow BPF LSM to scrub
 SCM_RIGHTS at sendmsg().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Brauner <brauner@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 5:58=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> As long as recvmsg() or recvmmsg() is used with cmsg, it is not
> possible to avoid receiving file descriptors via SCM_RIGHTS.
>
> This behaviour has occasionally been flagged as problematic.
>
> For instance, as noted on the uAPI Group page [0], an untrusted peer
> could send a file descriptor pointing to a hung NFS mount and then
> close it.  Once the receiver calls recvmsg() with msg_control, the
> descriptor is automatically installed, and then the responsibility
> for the final close() now falls on the receiver, which may result
> in blocking the process for a long time.
>
> systemd calls cmsg_close_all() [1] after each recvmsg() to close()
> unwanted file descriptors sent via SCM_RIGHTS.
>
> However, this cannot work around the issue because the last fput()
> could occur on the receiver side once sendmsg() with SCM_RIGHTS
> succeeds.  Also, even filtering by LSM at recvmsg() does not work
> for the same reason.
>
> Thus, we need a better way to filter SCM_RIGHTS on the sender side.
>
> This series allows BPF LSM to inspect skb at sendmsg() and scrub
> SCM_RIGHTS fds by kfunc.

I'll take a closer look later this week, but generally speaking LSM
hooks are intended for observability and access control, not data
modification, which means what you are trying to accomplish may not be
a good fit for a LSM hook.  Have you considered simply inspecting the
skb at sendmsg() and rejecting the send in the LSM hook if a
SCM_RIGHTS cmsg is present that doesn't fit within the security policy
implemented in your BPF program?

> Link: https://uapi-group.org/kernel-features/#disabling-reception-of-scm_=
rights-for-af_unix-sockets #[0]
> Link: https://github.com/systemd/systemd/blob/v257.5/src/basic/fd-util.c#=
L612-L628 #[1]
>
>
> Kuniyuki Iwashima (5):
>   af_unix: Call security_unix_may_send() in sendmsg() for all socket
>     types
>   af_unix: Pass skb to security_unix_may_send().
>   af_unix: Remove redundant scm->fp check in __scm_destroy().
>   bpf: Add kfunc to scrub SCM_RIGHTS at security_unix_may_send().
>   selftest: bpf: Add test for bpf_unix_scrub_fds().
>
>  include/linux/lsm_hook_defs.h                 |   3 +-
>  include/linux/security.h                      |   5 +-
>  include/net/af_unix.h                         |   1 +
>  include/net/scm.h                             |   5 +-
>  net/compat.c                                  |   2 +-
>  net/core/filter.c                             |  19 ++-
>  net/core/scm.c                                |  19 +--
>  net/unix/af_unix.c                            |  48 ++++--
>  security/landlock/task.c                      |   6 +-
>  security/security.c                           |   5 +-
>  security/selinux/hooks.c                      |   6 +-
>  security/smack/smack_lsm.c                    |   6 +-
>  .../bpf/prog_tests/lsm_unix_may_send.c        | 160 ++++++++++++++++++
>  .../selftests/bpf/progs/lsm_unix_may_send.c   |  30 ++++
>  14 files changed, 282 insertions(+), 33 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_unix_may_s=
end.c
>  create mode 100644 tools/testing/selftests/bpf/progs/lsm_unix_may_send.c
>
> --
> 2.49.0

--
paul-moore.com

