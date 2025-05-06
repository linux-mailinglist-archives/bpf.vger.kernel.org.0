Return-Path: <bpf+bounces-57543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A93AACADE
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 18:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DBE33BDB96
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 16:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294C5284B33;
	Tue,  6 May 2025 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDQYJ09E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A11283FD9;
	Tue,  6 May 2025 16:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746548755; cv=none; b=cF8Wjq/Ny8zzB2kJ22UYxYbPeX5Cu1q5jJR6LddhmCXZDnPStdBdBrpfBZPU+Ao4FgkDCNe7ueSScwmENXiWifIk2IxId+L5NtfuJBW+yrEJAzoIdLNk5tZfzJsyXKHMBmgo1DUex4gcydYr9MeEQlr0utSnRzAMc4oo6ulMjKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746548755; c=relaxed/simple;
	bh=sDMOdCp6B5rslspGUDpgs8jxGgHx0Qdk3hW014558mU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m2RyU3aZPvuRFstUfspnCdc6CdTnshWVpyKWqMjZDy8HkYKqj8kSGz9/qTFAtWj3hqxngTIhiiO6cDbEg+bbMsw8XrrtPJv17TJ9xmW6O7DDyWo4e3o+oudXsiPUbTVhNuTsTXLp/0M/zz8Vs2HR7MIK0FNeeUEQ7HnzVREmC8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDQYJ09E; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5fbcd9088a7so89495a12.0;
        Tue, 06 May 2025 09:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746548752; x=1747153552; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6nLiE63xxnb717pCI1F+dlyigK57mmM8h2s+Nep5D6E=;
        b=MDQYJ09EuiudaMJICEUs4LAe27v/Y3ONqIdlrLthDkerUXrkzQ7nR3IFcMzq5pnmBS
         ElfE8/9Dpie/cKiFCX/LW8JU/iPOk1W9dl77Y54B1cvEKMKicsJ1V16T4JpYP4zDeVzO
         RU/PO7PtKtclXLHXt+8qux25cHe6dAv2ELJDjUy4L8D4zBDF3Fon6jp/ncQJThv97VT9
         OrHPEj5OYmYaBQTOzKMCi8/qNvtelI8H+c/FhTQeA9PFbM0aBuupRlxVGlItEX5Y3uvn
         5Bp2iQPuRY20ZBgB7F4KIvUMloJOZ+PSQwKIwW8eNEhKGRgf+ueIXH4u1QQwxnTJ2ZCB
         Wk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746548752; x=1747153552;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6nLiE63xxnb717pCI1F+dlyigK57mmM8h2s+Nep5D6E=;
        b=UR3XtNRKb9wrnH9zG8z6yct7u35kpn1X6ROv3SmNUf7MdEfcj+n1+8GMTplEvKWJwR
         luMRJ3FqWlhn6vwUez8o8up+THS2e3Dr65g3f+0bohCPrg3u4OPYsoJOpEVom2DjFwsp
         bvKlooWzcK7fZCs8Iu1PMbpmhgdkH7BLg2BfulIJHB94Yy+e4fPB9eUDuCIxFE9zrJwS
         XaSArQvGUVASzrfZUooaNQono+ovSybFFnAp+/oPFtR99iYg6y5KIdTrdnV+uJw/vTLR
         v5k6XSJTS+ribzgzM9F49hIYmMcFx3vNQ0mvmyaiv60stM5ucclDi+lOgxiZjTkhy5ow
         UG8A==
X-Forwarded-Encrypted: i=1; AJvYcCUJwjzAAugb0wxEH7Oa94KikQA+0ytxhWbz1OTrmKoNfk7CW6h3VUL0kMmcEoqFkVSBIuRHYDFnMU6eWxRaRlPWxF9w99bo@vger.kernel.org, AJvYcCVpNmdFh7lizT1TV/ibygKjbMikGp0sg+3jRzivDIbJn7mPOO2NwNvU8bTK17gmXo1lo9fYcuEq+Q==@vger.kernel.org, AJvYcCXpU03+wManeNMDI2MRV292MAJ2vpOP4pvr4e6GRXtvnzIEeCgeEeLw6zMPs0AzT2ML/pg=@vger.kernel.org, AJvYcCXtteET7wABFj9x3J2k1nPc9cseUzg1wnReOYBR0l6cGc/n3CsguK3ZF3/ED4dWxRJYG5GMnaea@vger.kernel.org
X-Gm-Message-State: AOJu0YxeHLJFuDhzE8FsX2F20YF+6mVfrYJ34kCE4//y9aNVbf5/smV9
	91pGbseG0qQq+SlmPCLicSa3sj1mSI6+HlxbDmQK52VRFzjNSIhojJ0lELy/JmC3hhn5xFEKI3q
	0QKDeWSzB/NW7z0YpIZYfIygHpQA=
X-Gm-Gg: ASbGncsw3H8uSKUTPhRybeZkIMrkyI/ztdNfxOWenoK6ri3exE51rDwp5AEme/Hk0C3
	M7M5QDpCs1+NhTuHLTp2HH4nAJkQilhmIlAtkp+7c4KRWQQUSCk6EV1vG72G9FVod7npEZOs80S
	BLakrmgCEl2yJ+5YY2k+W1fLVHHaAbWKYyvV9VbQ6ZU+PW+Q+0fOSS+y/b
X-Google-Smtp-Source: AGHT+IGw/ovuqDMWYeYn2R9BTkYuEqR0Bs9rM5flJw/d0nMPjtFq8fNhesk1LIiD37+Ud+23nKlUAT/vHtZyvUd++nw=
X-Received: by 2002:a05:6402:270a:b0:5e4:d52b:78a2 with SMTP id
 4fb4d7f45d1cf-5fbe76df46amr409595a12.15.1746548751964; Tue, 06 May 2025
 09:25:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP01T77STmncrPt=BsFfEY6SX1+oYNXhPeZ1HC9J=S2jhOwQoQ@mail.gmail.com>
 <20250506002813.65225-1-kuniyu@amazon.com>
In-Reply-To: <20250506002813.65225-1-kuniyu@amazon.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 6 May 2025 18:25:14 +0200
X-Gm-Features: ATxdqUG3RPQkGL6wTstcUKvEvMmWZqpmx5BpDN-JHBmkVbpzp41yBME2GA8lDvU
Message-ID: <CAP01T74osG0y2LPY1uhmZtf4ag==RZ1OjLU3wQu_c-z5Wr2ZbA@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 0/5] af_unix: Allow BPF LSM to scrub
 SCM_RIGHTS at sendmsg().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, brauner@kernel.org, 
	casey@schaufler-ca.com, daniel@iogearbox.net, eddyz87@gmail.com, 
	gnoack@google.com, haoluo@google.com, jmorris@namei.org, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	kuni1840@gmail.com, linux-security-module@vger.kernel.org, 
	martin.lau@linux.dev, mic@digikod.net, netdev@vger.kernel.org, 
	omosnace@redhat.com, paul@paul-moore.com, sdf@fomichev.me, 
	selinux@vger.kernel.org, serge@hallyn.com, song@kernel.org, 
	stephen.smalley.work@gmail.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 May 2025 at 02:28, Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
>
> From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Date: Tue, 6 May 2025 00:49:11 +0200
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
>
> Good point, will add the description in v2.
>
>
> >
> > I think it is also useful for restricting what individual file
> > descriptors can be passed around by a process.
> > Say restricting usage of an fd to a process and its children, but not
> > allowing it to be shared with others.
> > Send side hook is the right point to enforce it.
>
> Agreed.
>
> Actually, I tried per-fd filtering first and failed somehow so
> wanted some advice from BPF folks :)
>
> For example, I implemented kfunc like:
>
> __bpf_kfunc int bpf_unix_scrub_file(struct sk_buff *skb, struct file *filp)
> {
>         /* scrub fd matching file if exists */
> }
>
> and tried filp == NULL -> scrub all so that I can gradually extend
> the functionality, but verifier didn't allow passing NULL.
>
> Also, once a fd is scrubbed, I do not want to leave the array entry
> empty to avoid adding unnecessary "if (fpl->fp[i] == -1)" test in
> other places.
>
>        struct scm_fp_list *fpl = UNIXCB(skb).fp;
>
>        /* scrubbed fpl->fp[i] here. */
>
>        fpl->fp[i] = fpl->fp[fpl->count - 1];
>        fpl->count--;
>
> But this could confuse BPF prog if it was iterating fpl->fp[] in for
> loop and I was wondering how the interface should be like.
>
>   * Keep the empty index and ignore at core code ?
>   * Provide a fd iterator ?
>   * Scrub based on index ? matching fd ? or struct file ?
>     * -1 works as ALL_INDEX or ALL_FDS but NULL doesn't
>   * Invoke BPF LSM per-fd ?
>     * Maybe no as sender/receiver pair is always same for the same skb
>
> I guess keeping the empty index as is and index based scrubbing
> would be simpler and cleaner ?
>
>
> >
> > Therefore exercising scm_fp_list would be a good idea.
> > We should provide some more examples of the filtering policy in the selftests.
> > Maybe a simple example, e.g. only memfd or a pipe fd can be passed,
> > and nothing else.
> > It would require checking file->f_ops.
>
> Yes, and I thought we need fd-to-file kfunc or BPF helper, but I was
> not sure which would be better as both functionality should be stable.
> But given the user needs to inspect the raw scm_fp_list, kfunc is better ?
>
> * bpf_fd_to_file()
> or
> * bpf_unix_get_scm_rights() -> return struct file ?
>
> plus
>
> * bpf_unix_scrub_scm_rights() -> scrub based on fd or file ?
>
>

Given you're probably going to drop scrubbing, all you'd need is to
pass the pointer to file to inspect is f = bpf_core_cast(&fpl->fp[i],
struct file).
Then just find out the type of file using f->f_ops == something and if
a disallowed file type is seen, return the verdict.

> [...]

