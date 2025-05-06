Return-Path: <bpf+bounces-57536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 183F8AAC8EB
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 16:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0540A1BC0D8B
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 14:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF9D283CA7;
	Tue,  6 May 2025 14:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="b2bQIJ1i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BF32836A5
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 14:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746543439; cv=none; b=EaO/P2dhlnbmKX63/79UUayingovSri8IbDEp5G79lOeC3DDfzLzIYJZv+kWHHo337GIvOYrGGS9tp+9CfRrO3qja31RPFlzZ0vdF9He7J9rYGcGud8PUtpHCDAXnfOuBlSEv+i+gN8SBWpyZLAZ4Cz1o06poJmVA2V8i3789o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746543439; c=relaxed/simple;
	bh=YplBmVb1Delb5mL7pEaZiodrLvZ2IOKYjJp7SEdrmfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d/kIzxN56vlN/svvF1tax7yLYceWCsHQ13Wg3e+THsP/8EEltT1N5JdjLeS4hIyS05or9FhnlwNjbmUGpqcLIycamKyPyIS//uU9o751u4GK4bteE9bZcqWrsfCWUS11DAH4OsFMdGTyW886pSE2aY13IO6IOV4q4m8rxnSyUCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=b2bQIJ1i; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e730ea57804so5977042276.1
        for <bpf@vger.kernel.org>; Tue, 06 May 2025 07:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1746543437; x=1747148237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLs31GAnh8meNVNPFC4TC/kBV0263rRQzZRQGkUn8Pg=;
        b=b2bQIJ1i/6RT4w5NB75jWAYY0pv/gZyPMltOhgawg8yI43HVENnU48ZKzorNXENPAE
         qeo2wOneaOrHxn0e8AY+nzLSpA8T/jqEwAVMvIo86QHC2nhxkMd9SLI0hvtUTRC522U/
         p1dQMPhhMQUQz3KBt+u7Crzr2C1BQyb/O0nNR/BDA5DzEX2f2BK536n3cKKhT3bqiFwT
         j1IZ0avNvCqrNyByyk/j0EwbQJxi20j8PQgfdXetpSbbJX42xpb0J3azYgM1VqbLvg9N
         704wEZMKLaS2CGS8Hbk0rj1Lfmq8q2RgorzrEucdpzoMyE9K6Qhx/UNJofrqLlHpn14G
         0Okg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746543437; x=1747148237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLs31GAnh8meNVNPFC4TC/kBV0263rRQzZRQGkUn8Pg=;
        b=L36zIVr4DAVyJBnCFtYX4lxqfkTcjiN+pv4ldgYtVeKuDvBb6hS9kusHpuVKKXSOA8
         /mWW+oLcINWKDil9uAqyeMDujNDDrkf5JZQODGNlw6VPU6xPfBJ3TZrjPPWHOIOdCa7k
         Pe22U5ir5Kdy+UXwTj4HOu7xneLfvoaZbLWt5ZQaqkjKBpakCoU1Jk9+a2GxBf7D8tj8
         pNGf3j7xkWYFLWy8ww6VsUEdYCVFQjOWGqptfDBafwpetpJFF3HJm/CxA15yD4BmFOLN
         GgpQOXsRHcGdP2e66Ar2EIqWSiqkS74FIdKaIZuZfLzFAMhZpuHCqbhpsyaMERhG/YVf
         5kjA==
X-Forwarded-Encrypted: i=1; AJvYcCV8SQHTMwrEYoQZ+J24xxWVrpCRgOD2+5dQErzxu4n3uXpq4vmALppLOlDVFQaN6bDLhoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiCgaKtS27uVkv3IPCW7OqBio+PfgfRHvzy+Iis7m8yIJRxTGw
	NXpOyP6fw0wcdSug44e2a85VcBlbb8lkrHg1h7TbGl7Juo5KNypwYUlVyRaAm26mQLhTQcSMThr
	OnRa591zvtXFxhPYnab5dY9TdheF2CgqhNBr1
X-Gm-Gg: ASbGncsiguFdmU7ap+7Azvsvqu/aaF1gXv8eVPz1ABOStkvKnK5yCJMUa0RH1MtkAu0
	yaVLXXjepgKypVj2/gFi2FYfnLszf90U0EY7lqMKiXUx1s2Qg9NoBlMXy9eefgOuXDg2MFSNTo1
	sA5s5rJNlMDh3JQgmD+Wet6A==
X-Google-Smtp-Source: AGHT+IG6xFvMic0ADEs29IQoHHk8yx7S2z5OPPSGG9x1jnr6FqkiMMaTePQc4L33m2RS4aoEj/y9I9lZh5J1KZwGRg8=
X-Received: by 2002:a05:690c:74c8:b0:6fb:9474:7b4f with SMTP id
 00721157ae682-70a1c9d951emr1476887b3.6.1746543437066; Tue, 06 May 2025
 07:57:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhSWS2L3qwu_r_1Fr3eLp-9KRz3_20EPwy=FFu7_eSiN7g@mail.gmail.com>
 <20250506003514.66821-1-kuniyu@amazon.com>
In-Reply-To: <20250506003514.66821-1-kuniyu@amazon.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 6 May 2025 10:57:06 -0400
X-Gm-Features: ATxdqUE9hUHlsLlxH60gL-ZM58XVaHc4ms5YTdwWD4KTgo3dCqcbQ5j61SIFQWQ
Message-ID: <CAHC9VhRhW=QT9O6qLaVfJd9XMV1se6EooVmYKb76+iATyG2vAA@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 0/5] af_unix: Allow BPF LSM to scrub
 SCM_RIGHTS at sendmsg().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, brauner@kernel.org, 
	casey@schaufler-ca.com, daniel@iogearbox.net, eddyz87@gmail.com, 
	gnoack@google.com, haoluo@google.com, jmorris@namei.org, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	kuni1840@gmail.com, linux-security-module@vger.kernel.org, 
	martin.lau@linux.dev, mic@digikod.net, netdev@vger.kernel.org, 
	omosnace@redhat.com, sdf@fomichev.me, selinux@vger.kernel.org, 
	serge@hallyn.com, song@kernel.org, stephen.smalley.work@gmail.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 8:35=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
> From: Paul Moore <paul@paul-moore.com>
> Date: Mon, 5 May 2025 19:21:25 -0400
> > On Mon, May 5, 2025 at 5:58=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon=
.com> wrote:
> > >
> > > As long as recvmsg() or recvmmsg() is used with cmsg, it is not
> > > possible to avoid receiving file descriptors via SCM_RIGHTS.
> > >
> > > This behaviour has occasionally been flagged as problematic.
> > >
> > > For instance, as noted on the uAPI Group page [0], an untrusted peer
> > > could send a file descriptor pointing to a hung NFS mount and then
> > > close it.  Once the receiver calls recvmsg() with msg_control, the
> > > descriptor is automatically installed, and then the responsibility
> > > for the final close() now falls on the receiver, which may result
> > > in blocking the process for a long time.
> > >
> > > systemd calls cmsg_close_all() [1] after each recvmsg() to close()
> > > unwanted file descriptors sent via SCM_RIGHTS.
> > >
> > > However, this cannot work around the issue because the last fput()
> > > could occur on the receiver side once sendmsg() with SCM_RIGHTS
> > > succeeds.  Also, even filtering by LSM at recvmsg() does not work
> > > for the same reason.
> > >
> > > Thus, we need a better way to filter SCM_RIGHTS on the sender side.
> > >
> > > This series allows BPF LSM to inspect skb at sendmsg() and scrub
> > > SCM_RIGHTS fds by kfunc.
> >
> > I'll take a closer look later this week, but generally speaking LSM
> > hooks are intended for observability and access control, not data
> > modification, which means what you are trying to accomplish may not be
> > a good fit for a LSM hook.  Have you considered simply inspecting the
> > skb at sendmsg() and rejecting the send in the LSM hook if a
> > SCM_RIGHTS cmsg is present that doesn't fit within the security policy
> > implemented in your BPF program?
>
> I think the simple inspection (accept all or deny) does not cover
> a real use case and is not that helpful.
>
> I don't like to add another hook point in AF_UNIX code just because
> of it and rather want to reuse the exisiting hook as we have a nice
> place.

Reading quickly through the other replies, I'm guessing you are going
to be moving away from the LSM scrubbing proposed here (which I
believe is a good idea), so I won't bother you with more feedback
here.  However, if for some reason you still decide that you want to
pursue the LSM scrubbing approach please let me know so we can discuss
this further (on-list).

> Also, passing skb makes it possible to build much more flexible
> policy as it allows bpf prog to inspect the skb payload with
> existing bpf helpers.

--=20
paul-moore.com

