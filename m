Return-Path: <bpf+bounces-57540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 318BEAACA7E
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 18:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FBB21C434CB
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 16:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D9428467B;
	Tue,  6 May 2025 16:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8j5wrUm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71F0283C9D;
	Tue,  6 May 2025 16:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746547743; cv=none; b=Yrs2WIatso8r/g0st3iZ1pEWt4bq7WMXYAhBIesMJcByU6Gy+DF92kNPliz0sETTAH+uH3AVk6FlyU7jMtxYDyqkrF1Xd9rv2ocJx7RaUFigpQy0YIsjqO/B7l1URBwaErB/mVVU4i64AU/HmRjDq24OqeMVCosRFKeDm8QDULQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746547743; c=relaxed/simple;
	bh=ng5VPCsZAqFI8EuwZilSqi6BhAC4gNiufgc30faGWAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DyP598ucXgTHfnMlXTqDgk0LvTOIRZPmdvtv5hwOfP1H/tyvypHoJmjEuNpt/DYtM61/RZQpXOES7afjz728jFgrtTeqkng6Xv8B7j9C2UhTzc5EllzRNAj4wHyMYG0icTfxPbSK6nL8WLtQcRlz1yHMeBb/ibyCv8pDW9s24po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8j5wrUm; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5f62d3ed994so5052883a12.2;
        Tue, 06 May 2025 09:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746547740; x=1747152540; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jasQjLHL4hFJEEmf++QBk4R01tjaJ/ZdaFQ8aStjbqQ=;
        b=f8j5wrUmtMfCIlYgTl5ay6SDgtikqJGX8oLbrgHTebK7UTA7yQ25B9v/F3npEfLaS/
         MNV6YiTEQZ2oE0VUrQxaIDPuZe+VIuAVBUy3etYmvmvoRNgWRgvnf6Gq4Fy49m9rYqiA
         RmPFGDwSLGOKxwFG7kCXeh0Lt4RfGB7+xQKJmBgWd+20T7R2EvYmbDxhWIJdcXI4nvF/
         MghIKz05N7UVZN/MAfx2H5p70kgGHGDXdbAcHt4XJYqNg6AoUB/kJSEao7LUUPdhhbC+
         j3WaMuS/ibhHKls5A7LNQ2ktYSIlt5dRTgkm8tVbs1ZBwU+Iu7TWPOOmVGrFxgx5NVKh
         ij4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746547740; x=1747152540;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jasQjLHL4hFJEEmf++QBk4R01tjaJ/ZdaFQ8aStjbqQ=;
        b=MM3T7zmBNCJO4ptRGuSg64+9KylXHyI7652Wy8ZozE2Cnk+yyHwU0xnwR10KtNycYz
         txk/5bRSDUmTDjkNvyTkBzMh+5oG3w1KYj66HdMsiwtD6NY+Znt5X2Jhk/o86olg8cDz
         iLk0uYVr8C9amD9DMJoI1nTJf2UINfhqlr6/NmNQJKzbyFAj3yX5jx3tH6LVjqvZ93tc
         rPQi5MLh4R0/90lDabE8+idWZ1Kbh2w5G40zKXyiyCQp9k7Pugf5AmoTGSPERZdeadUb
         1VL1QkUoQGhwNufwQHbZjFBDqEnY57pPMd8EL+miTqqw2hpNLZQ1O1E7oWWnXZVkx24M
         qLqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0kaN16TCnrkS8769CZuaEVq6o2fvpveGmVYom+U3+0WkzLQdVaX8Xw1FI1HoXYlEX4XI=@vger.kernel.org, AJvYcCVAAYDYty/LnGH8zETd10HIxRVXdw3m4mwHZJGRUT/7qoijCgjHkOZ8Q6SjOLfvcaUp3DbN/wXSoWWckpAiE+38KSRhgi6Q@vger.kernel.org, AJvYcCXADz8ig9FTzT5rQhmvItvMmf3dh/webdK+xd5WLAndcYdzP+hTQDbXQhP9tFTsLTK4vHCWUyUVzA==@vger.kernel.org, AJvYcCXSSUvBwQnr4iGN+Ktn1mvbBG7yBLp/OsxlSzENz9qDoZWVAJ6EvzI+x6Y1WQ2x8JS+ONuSFUPT@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4NBQxe84nWVEea7LtwdosGaaYHL9yhRJ7n230u9rer2C4dQzj
	CwFZczvyiQKF+IcbuzrD+qFKrrrhzdcfC+YzxFXJZ8HnmswVRBviO1kZO31azFNLhtcUuPpV7io
	nNGEKom7kzIyKCLdkl7FUewb9avY=
X-Gm-Gg: ASbGncvsPxHUY8sBVD/BNnCYXg61EnrnTb+287nTTazGIIImXJvgkEY2NC/bui7V0Jm
	3GFAjDQSYnwBRIk0xBXN1ejqK+Bii0mgeV4xO9nwElrwdoSuEo+IiqhXwC9kkQzrgc/k0rhEvHj
	BJq+Lu1pO6/4jYoNs8kAkqkw0nEnlmR7P17agfe20d92AYXct1wP5CAAow
X-Google-Smtp-Source: AGHT+IHA6oeW15Fus95IbDgLbX01ewgtEIghOTOyrm75aDX8HngvmpdKEclCp+7+UOS7lhcdAaKURP+zJ8GiMHm/DEw=
X-Received: by 2002:a05:6402:5211:b0:5fb:d4a5:a3c2 with SMTP id
 4fb4d7f45d1cf-5fbd4a5a41dmr1047221a12.10.1746547739812; Tue, 06 May 2025
 09:08:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505215802.48449-1-kuniyu@amazon.com> <CAP01T77STmncrPt=BsFfEY6SX1+oYNXhPeZ1HC9J=S2jhOwQoQ@mail.gmail.com>
 <20250506-eitel-gerede-7c8b5e556a2c@brauner>
In-Reply-To: <20250506-eitel-gerede-7c8b5e556a2c@brauner>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 6 May 2025 18:08:23 +0200
X-Gm-Features: ATxdqUFokplkdfYHA6EZmet2UHIM8-kWnpjox5-Z_LvYwMchKphtJEz-sDOkhcQ
Message-ID: <CAP01T750x5a9ATX56hV0p+Je2zFfm1unS3ZhCObXY-yt_ar=+w@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 0/5] af_unix: Allow BPF LSM to scrub
 SCM_RIGHTS at sendmsg().
To: Christian Brauner <brauner@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 May 2025 at 11:15, Christian Brauner <brauner@kernel.org> wrote:
>
> On Tue, May 06, 2025 at 12:49:11AM +0200, Kumar Kartikeya Dwivedi wrote:
> > On Mon, 5 May 2025 at 23:58, Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
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
> > >
> > > Link: https://uapi-group.org/kernel-features/#disabling-reception-of-scm_rights-for-af_unix-sockets #[0]
> > > Link: https://github.com/systemd/systemd/blob/v257.5/src/basic/fd-util.c#L612-L628 #[1]
> > >
> >
> > This sounds pretty useful!
> >
> > I think you should mention the cases of possible DoS on close() or
> > flooding, e.g. with FUSE controlled fd/NFS hangs in the commit log
> > itself.
> > I think it's been an open problem for a while now with no good solution.
> > Currently systemd's FDSTORE=1 for PID 1 is susceptible to the same
> > problem, even if the underlying service isn't root.
> >
> > I think it is also useful for restricting what individual file
> > descriptors can be passed around by a process.
> > Say restricting usage of an fd to a process and its children, but not
> > allowing it to be shared with others.
> > Send side hook is the right point to enforce it.
> >
> > Therefore exercising scm_fp_list would be a good idea.
>
> No, that's a terrible idea. If the receiver expects 10 file descriptors
> and suddenly some magically disappear or the order gets messed up that's
> terrible for security. It's either close all or nothing.

I was talking about exercising/reading it in the selftest, not
exposing anything new.

Yes, the policy should be close all or nothing, but it can still be
used to deny sendmsg when one of the descriptors being passed isn't in
the allowed set.
You just return 0 or an error. No need to scrub, no need to disappear
some fds and let the message pass, which can be problematic.

>
> > We should provide some more examples of the filtering policy in the selftests.
> > Maybe a simple example, e.g. only memfd or a pipe fd can be passed,
> > and nothing else.
> > It would require checking file->f_ops.
>
> There's not going to be poking around in file->f_ops for this.

I don't think any poking is required. There's no need to expose anything extra.

Really, all that is needed is for an LSM hook to exist and the program
to say success or failure.
Even the scrub fds stuff can be dropped.

The program can simply inspect the scm_fp_list and if it doesn't look
ok, deny the sendmsg.
It's already there inside unix_skb_parms.

It just means the program can look at the file (there's no helper
needed to be exposed) and make a decision, just like in the rest of
the BPF LSM hooks.
I think a socket option makes sense too, but ideally we can have both
the hook and the socket option.

The socket option has the advantage that user space can set it itself
conveniently, without having to load a BPF program.
Meanwhile the hook can be more fine grained in decision making and be
imposed by some central entity.

Does this sound reasonable? I don't think it requires anything beyond
simply defining the hook and letting a program run there.
No poking into VFS internals etc. or silently dropping file
descriptors and letting it succeed.

So mostly patch 1-2 and then another to add a setsockopt flag.

>
> [...]

