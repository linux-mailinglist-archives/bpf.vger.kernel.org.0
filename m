Return-Path: <bpf+bounces-41321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABF3995CA2
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 03:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F17E3285D70
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 01:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2F91A288;
	Wed,  9 Oct 2024 01:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIOd5pSv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533931362;
	Wed,  9 Oct 2024 01:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728435961; cv=none; b=P4jidluW0TJJaJiGI1Gk512umqhQsLLAYUnfDYs9MRdGlxI0NiWQZ6Yf0YZr0Yzv3EKVLWWMAHlZj83FEEhgPU7Rnone7Mgw/5TLNYr3ammIYHOiEIvq9qu1phzYFBaqJQY0bDyT3d+tsH6KybhWhgtEfG7NPRZ7HChfdmSNJY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728435961; c=relaxed/simple;
	bh=Cd1YEYsbMmI9vBiiCy/3x9OeMb85KmOiEz8S3LB946U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZClJ4qNNF4sCmqxlBR8DZvKgjD0grcbNDasjywfIhz7KN6epFcStYnkuG8GDKvHMVj/d1tWz5Xr6XK0J6s/UkVIwxU3I3k9Ur69jb1BFccgaHuiD6chFIl2i7gGZTySanqxSIbXM9NeV3boxTpn+LIP1zbR+AJDTSqA7IlVUo5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIOd5pSv; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a34460a45eso33155245ab.3;
        Tue, 08 Oct 2024 18:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728435959; x=1729040759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yYxwbyU4ogYZkSctyKQJtOUt8bZmYLETK2TUgeUSno=;
        b=fIOd5pSvBvJ9pnNGcXTpI5vmbe8LppH+hQJrOPlLU/IW89Tuak6zV7gETdyJA8WEMZ
         3sT0skua4WVOoHvJ8YmBvTinYNvXnNuXB7B3LCiUFDJ13sKnaR/QD5rKkULsrXmRL5Mi
         bT1jCK2rQFWxvwxVGopz6HUF5uiPYbvQ2z8WdOZXziEGQoAGcByUkr/WcNTkU9RJCY2u
         Bwry9j1Jri+wVU5woZOFe5y4TghooQveABnNnWXxiUbZsUNJKS0lR4oIti/wu4HR01zt
         BAEp91JnNwTNUL1mGCnjGACXuPhjoJSyrS3zirApul5YqM+mDpd+2Rua8wOswHtgJyHe
         XJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728435959; x=1729040759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1yYxwbyU4ogYZkSctyKQJtOUt8bZmYLETK2TUgeUSno=;
        b=HT8Me+XLlnlfkAVGJNUHmyBVclwFbFHRQQzF6VDaIVHWSi1oGLERTa921R0kIq3uQm
         gFb3CAkmfpZ0Wk3sozy1nztXww9UWd0Ee0hSXxW7KHdQ1+0rpFqzQ4gXK271gDDA1mgc
         aIxZdR/QGOzaZaTfMcob2xNxAWrmsCRvIQqqkh1qfXmLSpQfDgJYuFuYjXHJvkF9Rdu9
         Jv1maEd/bSCQDRBqPtfPdHKbsPautu7ibf+InpJU3WX6vAG5ZH3D6zR7Hl2doW1bb3K0
         DXSVmvpn0zJS4XoCvl1qzCP31t9iLBEYgMb0k8ayBdk+LC713XWyFsDC1CcBKRACiHDd
         nw3g==
X-Forwarded-Encrypted: i=1; AJvYcCWJt3kDA9w9ldk1+ZXyucTV8WiCuGd3fFCRHxy5L/o6M82k+yRFn6XfVBSCCY1+U+y11DQ=@vger.kernel.org, AJvYcCWa9h/ZEv68cfxD8hK0dwLksp+h/o4zfoDir55/KqfasLI0gAWBQxBGbRnaZWqnNMGYWYK6phaC@vger.kernel.org
X-Gm-Message-State: AOJu0YxvkXUt7kiKqgyk/pdCp1vG7HdUzwm0jww+sN0jTEXX3SZ/CC5v
	m0N3OZb89jXA5IjwtU/bSh2mTwKDhE1GuoNAsxRX0NiE8qEwpLx263ONW7n2SEv8Nu/ufBuhLiJ
	BzTK2K6gFALDKcqI3pZkYw8eehMQ=
X-Google-Smtp-Source: AGHT+IFkJx88WwtV+AqoSeJJ+DDXRLvAEmfSFZdVvBrlBGNAIO2KONa60JLluP5aWummzABPkW1PI63r6ltyqci17fk=
X-Received: by 2002:a05:6e02:1fca:b0:3a0:8d60:8ba4 with SMTP id
 e9e14a558f8ab-3a397d11004mr7208105ab.16.1728435959435; Tue, 08 Oct 2024
 18:05:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008095109.99918-1-kerneljasonxing@gmail.com>
 <67057d89796b_1a41992944c@willemb.c.googlers.com.notmuch> <CAL+tcoBGQZWZr3PU4Chn1YiN8XO_2UXGOh3yxbvymvojH3r13g@mail.gmail.com>
In-Reply-To: <CAL+tcoBGQZWZr3PU4Chn1YiN8XO_2UXGOh3yxbvymvojH3r13g@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 9 Oct 2024 09:05:23 +0800
Message-ID: <CAL+tcoC48XCmc3G7Xpb_0=maD1Gi0OLkNbUp4ugwtj69ANPaAw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/9] net-timestamp: bpf extension to equip
 applications transparently
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 7:22=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> On Wed, Oct 9, 2024 at 2:44=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > A few weeks ago, I planned to extend SO_TIMESTMAMPING feature by usin=
g
> > > tracepoint to print information (say, tstamp) so that we can
> > > transparently equip applications with this feature and require no
> > > modification in user side.
> > >
> > > Later, we discussed at netconf and agreed that we can use bpf for bet=
ter
> > > extension, which is mainly suggested by John Fastabend and Willem de
> > > Bruijn. Many thanks here! So I post this series to see if we have a
> > > better solution to extend.
> > >
> > > This approach relies on existing SO_TIMESTAMPING feature, for tx path=
,
> > > users only needs to pass certain flags through bpf program to make su=
re
> > > the last skb from each sendmsg() has timestamp related controlled fla=
g.
> > > For rx path, we have to use bpf_setsockopt() to set the sk->sk_tsflag=
s
> > > and wait for the moment when recvmsg() is called.
> >
> > As you mention, overall I am very supportive of having a way to add
> > timestamping by adminstrators, without having to rebuild applications.
> > BPF hooks seem to be the right place for this.
> >
> > There is existing kprobe/kretprobe/kfunc support. Supporting
> > SO_TIMESTAMPING directly may be useful due to its targeted feature
> > set, and correlation between measurements for the same data in the
> > stream.
> >
> > > After this series, we could step by step implement more advanced
> > > functions/flags already in SO_TIMESTAMPING feature for bpf extension.
> >
> > My main implementation concern is where this API overlaps with the
> > existing user API, and how they might conflict. A few questions in the
> > patches.
>
> Agreed. That's also what I'm concerned about. So I decided to ask for
> related experts' help.
>
> How to deal with it without interfering with the existing apps in the
> right way is the key problem.

What I try to implement is let the bpf program have the highest
precedence. It's similar to RTO min, see the commit as an example:

commit f086edef71be7174a16c1ed67ac65a085cda28b1
Author: Kevin Yang <yyd@google.com>
Date:   Mon Jun 3 21:30:54 2024 +0000

    tcp: add sysctl_tcp_rto_min_us

    Adding a sysctl knob to allow user to specify a default
    rto_min at socket init time, other than using the hard
    coded 200ms default rto_min.

    Note that the rto_min route option has the highest precedence
    for configuring this setting, followed by the TCP_BPF_RTO_MIN
    socket option, followed by the tcp_rto_min_us sysctl.

It includes three cases, 1) route option, 2) bpf option, 3) sysctl.
The first priority can override others. It doesn't have a good
chance/point to restore the icsk_rto_min field if users want to
shutdown the bpf program because it is set in
bpf_sol_tcp_setsockopt().

