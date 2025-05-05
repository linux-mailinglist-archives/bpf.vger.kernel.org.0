Return-Path: <bpf+bounces-57439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 633C5AAB128
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 05:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BE174E42FE
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 03:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734A9333869;
	Tue,  6 May 2025 00:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKFhJfPL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1D0278143;
	Mon,  5 May 2025 22:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485393; cv=none; b=hD5FZfj98mNniZ4BnkeNq8Nspals2jl4Ok7kOVOC6OWrnNpCWlwxlntM7uDygPTf9ANMJqe/tH33KgH3rh1Lm0KjC5J/Tar8SgGoUnCR9wim3awV1cdza1w+EXUWDM5dLbGSyEI3iUziewE/KwLuVvI7adcPv1wyDtCIpsGn6x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485393; c=relaxed/simple;
	bh=Jb32TIgImYtyTkDhQA+NiUfj4Vwhynv6jJRm4300tUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0BkofFVOQqwdkL7SHEOXhH5SN2TJUEtIONuxCJ/HPDcntL2wbFquroU2ByG/41zFJI0vZTLGxGkA7Q+kJA//zOOCTY+XwLecJJ8lv0stQnNhwMvgTR+MIS6nYQx9bPYdyXBfYAI2bZP++Rk1ZuSJACdgHnzAlzsF79hHCCZp/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKFhJfPL; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-5fb7717b02dso373859a12.2;
        Mon, 05 May 2025 15:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746485389; x=1747090189; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VyV0B285sp2Hjp/CoWJ5CaFH+EWiecTO5yXbRw+SsDY=;
        b=VKFhJfPLqEq28rcHjsPX+/0xeoUG/N6u3CtSg3Wsv+v+owDMA08OXzFa0owKFuF74o
         c4/cOS7BIrUeehA+PcV/UJOIM8VEqb9DJhMXDp6G/uLj73NCcOzSKykFcAXQoA0P56zq
         3mdaqCd/VWeCFnFdji0m5+SUncVuHr458kMDBII9tnnoP0MaeWngu9PBP8amBt8Ehqtl
         OsQpIqtmekZlD+WxGMkUimrErhKpDGCHJs7rpFD34Qn/+o9yHiFx5mx85ERJakEdgVrp
         Uuk8Z3jSEOqqM5nYsoa06mRuVIjebEWDewFYvlmfGTxuEfUjRa6+SjFb2Rw6ygOxF5vZ
         V6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746485389; x=1747090189;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VyV0B285sp2Hjp/CoWJ5CaFH+EWiecTO5yXbRw+SsDY=;
        b=B52YGyJvanM1k9DhOMKZkyXng3kYiYTxDNd6hW1O7LEuICwjyyULTLW14ep/UZQleq
         fZm4xvUONsyEvfum13xlF2MytYEM4DwfJpKegF79jmRv8fQCP90fHFBIAI4iomYcjYkX
         1B3Pxs733jW4nfEZBrKTAdAP7GHB3FnzU+jJeGOIsGJwUaDmc1uf/PcgBggrr0F5nXcx
         u3BMKv7t318t+LEUEo8FWAWwXp9/wg91XZS+m9Ttp7L0J+L98Sxv6tqg6M2rj2JhSv9x
         E7DULc3epUcxB7BA8lNTTeSiZf403ThGvZ8+vLrCXC3MGWOpx4WDrTWjVVSqC498C+ch
         Tp1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQwK8zrZGtu2zBf/joBrlKskSLJUfw9bmaZrWxlh6LYtKA5u97UyrUW9blowTMwSPjkmsL3tQ455/vPd4Eo60dm2oWZid1@vger.kernel.org, AJvYcCUiDulTpPwclIOA0K3Q4xa7k+0QUYgSEo99f/6nuw1tDvOkXwZXYgGVCgkZVMyIzf12dnDrqBu1Tw==@vger.kernel.org, AJvYcCW0L/2KOgfVAOH3NuC82kPkacp+0jiKiuoXuKVorWy/eJZGsH+t0XVtBNWvjZ+vdqxSmD4=@vger.kernel.org, AJvYcCXA3oTXdoV9Zu0WlKkbh6CCy1UXOq01V+Hk+z/r1CVB0wrjWjZoVgKHIZtVp3gQA9rDv42QzY65@vger.kernel.org
X-Gm-Message-State: AOJu0YwjzrUa/YpddpcIjvw25WlU/NaPgpO9yFJ6s/dyzI3OKVU8QVjt
	Jo3//d7oEyKG4oxWFTjIH4mZkkkBqcxrzbvq/aCi0j729AJoWNT2YYAI/CFWZMJbkEkGHNVyB/l
	E7QcoWb+EIWJF+rlbf1G5xeX1518=
X-Gm-Gg: ASbGncuOaS4NorDbsIXu+Lw9nWlU42JTPMELdc6kAJgeNP4issPA9b5vimZLr9/TT8U
	EYWm8AA5kpaUeKzX5VeLvc6aISXn4BMTRt3QMqGMt7ykDvKzZwyoUPZ3Aw6mkBqkQgZgjf36g2V
	2cWrU1CUOMu9E9HN6qyuMnMiolizyNc+qo7eBHBrZNll9jnXmFFvQAwIfK
X-Google-Smtp-Source: AGHT+IGsHegAHfsKUMsUJ65jENYoIdxTNE0BZj8vVp6rezv8Hy03obq1kM4DL3MhojS18Ul7cyFuTWl+ANmhHwHYvrE=
X-Received: by 2002:a17:906:99cc:b0:ac7:391a:e158 with SMTP id
 a640c23a62f3a-ad1d355ab91mr97084966b.59.1746485388395; Mon, 05 May 2025
 15:49:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505215802.48449-1-kuniyu@amazon.com>
In-Reply-To: <20250505215802.48449-1-kuniyu@amazon.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 6 May 2025 00:49:11 +0200
X-Gm-Features: ATxdqUG1rAv1CbCQ4YaC1iKTSjKWgD4kvy1BCT18Aj0ih1HaL6mkE7Nn2MUOpxE
Message-ID: <CAP01T77STmncrPt=BsFfEY6SX1+oYNXhPeZ1HC9J=S2jhOwQoQ@mail.gmail.com>
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
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Christian Brauner <brauner@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 May 2025 at 23:58, Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
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
>
> Link: https://uapi-group.org/kernel-features/#disabling-reception-of-scm_rights-for-af_unix-sockets #[0]
> Link: https://github.com/systemd/systemd/blob/v257.5/src/basic/fd-util.c#L612-L628 #[1]
>

This sounds pretty useful!

I think you should mention the cases of possible DoS on close() or
flooding, e.g. with FUSE controlled fd/NFS hangs in the commit log
itself.
I think it's been an open problem for a while now with no good solution.
Currently systemd's FDSTORE=1 for PID 1 is susceptible to the same
problem, even if the underlying service isn't root.

I think it is also useful for restricting what individual file
descriptors can be passed around by a process.
Say restricting usage of an fd to a process and its children, but not
allowing it to be shared with others.
Send side hook is the right point to enforce it.

Therefore exercising scm_fp_list would be a good idea.
We should provide some more examples of the filtering policy in the selftests.
Maybe a simple example, e.g. only memfd or a pipe fd can be passed,
and nothing else.
It would require checking file->f_ops.
I don't think "scrub all file descriptors" is the only possible usage scenario.
In the case of FDSTORE=1, it might be "everything except fuse or NFS fds" etc.

Eventually if file local storage happens, more interesting policies
may be possible.

> [...]

