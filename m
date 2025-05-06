Return-Path: <bpf+bounces-57466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB120AAB91F
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 08:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 473C53B0DE6
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 06:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D18332B2BC;
	Tue,  6 May 2025 03:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWPsFDxv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB719350156;
	Tue,  6 May 2025 00:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746493024; cv=none; b=ClXDU069teHgpXzffefqYCX8IMPHXldQ0QNTG9PatTC917fW24yDrElDlu/R9cv45VD7JWmti0IL/u4LXw9aK1lojVKs72166Npa8rfMiiOUineIDcDtYJQhv2Fih+T0MpG9YzD3QOtNZRb0Thz9OJucfChZ7P8u4hu/mfklx/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746493024; c=relaxed/simple;
	bh=WJ5N3hpgmYKXtAvoAQtuBt6dpWd9vR5puNnmvUo5hIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lA9OVbxUiKdHGusdK5dL3PUHnnWuDh2a3F8J4syFAGDDSzdR31c2W6EFjWSXJuIlCWmOEBAxQysOQsywXMrFlezOsNM6v8GFNfCPd6tE8W3CwX8iCA03KBybZqx8iCGsFTsmmOPpudZ9OzIYgHrMZ9tNJDzkmM1/EoFZj2LnCnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWPsFDxv; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39bf44be22fso3389146f8f.0;
        Mon, 05 May 2025 17:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746493020; x=1747097820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NG56sgydZqZDSI93ssWFt8es69R/8NDv+wgZ7H1Zg5M=;
        b=NWPsFDxvwAAbihX7mz9EpN5XcLam1G2od3qcy2QZS9vdDgaQ+Y78UvcyWg/hBYjt0q
         gIcqyTxQ9FeNucPcagNVXHBV+rc8AM5sZ0b+kpc7AG4sov4FeZPoPJnFiVKP/NAHGFdA
         FB/H0Zf7UfoJuE3cu0nS6jhEzXjq54BE3t6J/xvFDzIv7E2SYqfwH7qRgbvvlTy+sB4k
         Lwt8AiEZ1+RY8TmDa966crOHew617mt5vOsI8dui7dNIYAQyjdaHVZD+xNDwMmn78F26
         6EbKYSDi6q6uZbIItsNiwbGhiIwk0JPh+GLF1fAbVz4N5uRk57aWadBOaoSq/DTHuov9
         0gWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746493020; x=1747097820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NG56sgydZqZDSI93ssWFt8es69R/8NDv+wgZ7H1Zg5M=;
        b=WIdjygJ8gPQO8WxeOFahqkFDd6aCME0VOgxdzRuo5p7FQTwMEhH/ZW1DlyrtYX2s2/
         CXkoCYV7bVgnCRXkxR0l5yyhw32jLnI1ge9qnQgLVy5qC5Q9LhxV7EOMPCjCAYkIW1PJ
         +zch4K7VYfm5WltxwHHABIY/cPpHuYSo/gGMysnhbFKeSMJbPL32zw58+LfLCTfVnkYY
         3H4XsD9x62V/YOb7OlEbk6toD4kNdTqIjhqLT56VXdaiiSuk6Ad4yh7YAKbn9UDnsS7r
         LTAKgKv4PYs56vP5Xlq01I7OGJXYgROmaqKLGyebjdw8qhB3VMaypMlvY0YOlX/WXkT7
         syTw==
X-Forwarded-Encrypted: i=1; AJvYcCVMaL4CAZp0gDTJVo8pOJYx7BTMTFsW3ABWfpLVpD5ksnhccHDiohlpN+wUX4T9m3gPTD5C1tRnCA==@vger.kernel.org, AJvYcCWJhZYUTzxPiS9e7oOeUrsAe0mhGt2YSw5UP3LxAnVKHGYByX8BABZPcnBSzSYgy+aSFvw=@vger.kernel.org, AJvYcCXjh61v2fcrjhYaimWg0iruAngTV1uIAgmHKg3Vhmwsn8Iuf0Nlxt9iZnCGX3rmuuO3uO6syZPS@vger.kernel.org, AJvYcCXlorQzWl74yOvMjyfxIkWtAccmU+htrkgz/P9zYV8mZHRSLhrTMYZ9JHBQvffCimsBvieXyloKG/vOLzgjq/jZEeOO1Jp7@vger.kernel.org
X-Gm-Message-State: AOJu0YxfpF007L7xBDWrTBAtn0ovSFwxfAw+U8hmRtBNZ3wfwy8maVWn
	TlXsdTYflyhHFt/zIeIE5qy+bMCvhIHMmTo4PHxJQ5sTa9sPGdG8lwsAghKdhUUfbT4MrpaF7Tt
	ow/DO77UEbvpHLBb1rzX+ScIkdu8=
X-Gm-Gg: ASbGnctTXiu/ErsJKHU5OWThKfRjytp9OHK/e/oNt2W4BuBodpoTfxIpiflDJACwfWQ
	X1ZcAHxbfWEvScuRADiRADp3rk903S/3exDgNVfV39m8hYmLKz851lFvHdH0Sk5/ojfSoAbHUDM
	we9iKHfveUVtLdI7su0MAgY8cqb5kI5YPDxeNmFDkpujyPlsVijU8Q+kF29Pq1
X-Google-Smtp-Source: AGHT+IFmq92gXDyJ4tG7YRwzhLFbPsIymRx1JYkBfkuzkB8bzfB0NsMIXg9vTiXFzK0daiHD2Viir2BOAVh6NAVWprM=
X-Received: by 2002:a05:6000:18af:b0:39c:30f9:339c with SMTP id
 ffacd0b85a97d-3a0ac0ec442mr710518f8f.28.1746493019898; Mon, 05 May 2025
 17:56:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQK1t3ZqERODdHJM_HaZDMm+JH4OFvwTsLNqZG0=4SQQcA@mail.gmail.com.txt>
 <20250506004550.67917-1-kuniyu@amazon.com>
In-Reply-To: <20250506004550.67917-1-kuniyu@amazon.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 5 May 2025 17:56:49 -0700
X-Gm-Features: ATxdqUE--sGACWHpoTDfN6Z19YjKVfIMpJPMpn9rpWA5hJnc1H25_PoxJfzy7Ls
Message-ID: <CAADnVQ+bk8Qt=Zo4S2MZxB+O4G4q_EXB4P0BtJ3LjgbJuY_9_w@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 4/5] bpf: Add kfunc to scrub SCM_RIGHTS at security_unix_may_send().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Hao Luo <haoluo@google.com>, James Morris <jmorris@namei.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Network Development <netdev@vger.kernel.org>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Paul Moore <paul@paul-moore.com>, Stanislav Fomichev <sdf@fomichev.me>, selinux@vger.kernel.org, 
	"Serge E . Hallyn" <serge@hallyn.com>, Song Liu <song@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 5:46=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Date: Mon, 5 May 2025 17:13:32 -0700
> > On Mon, May 5, 2025 at 3:00=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon=
.com> wrote:
> > >
> > > As Christian Brauner said [0], systemd calls cmsg_close_all() [1] aft=
er
> > > each recvmsg() to close() unwanted file descriptors sent via SCM_RIGH=
TS.
> > >
> > > However, this cannot work around the issue that close() for unwanted =
file
> > > descriptors could block longer because the last fput() could occur on
> > > the receiver side once sendmsg() with SCM_RIGHTS succeeds.
> > >
> > > Also, even filtering by LSM at recvmsg() does not work for the same r=
eason.
> > >
> > > Thus, we need a better way to filter SCM_RIGHTS on the sender side.
> > >
> > > Let's add a new kfunc to scrub all file descriptors from skb in
> > > sendmsg().
> > >
> > > This allows the receiver to keep recv()ing the bare data and disallow=
s
> > > the sender to impose the potential slowness of the last fput().
> > >
> > > If necessary, we can add more granular filtering per file descriptor
> > > after refactoring GC code and adding some fd-to-file helpers for BPF.
> > >
> > > Sample:
> > >
> > > SEC("lsm/unix_may_send")
> > > int BPF_PROG(unix_scrub_scm_rights,
> > >              struct socket *sock, struct socket *other, struct sk_buf=
f *skb)
> > > {
> > >         struct unix_skb_parms *cb;
> > >
> > >         if (skb && bpf_unix_scrub_fds(skb))
> > >                 return -EPERM;
> > >
> > >         return 0;
> > > }
> >
> > Any other programmability do you need there?
>
> This is kind of PoC, and as Kumar mentioned, per-fd scrubbing
> is ideal to cover the real use cases.
>
> https://lore.kernel.org/netdev/CAP01T77STmncrPt=3DBsFfEY6SX1+oYNXhPeZ1HC9=
J=3DS2jhOwQoQ@mail.gmail.com/
>
> for example:
> https://uapi-group.org/kernel-features/#filtering-on-received-file-descri=
ptors

Fair enough.
Would be great to have them as selftests to make sure that advanced
use cases are actually working.

