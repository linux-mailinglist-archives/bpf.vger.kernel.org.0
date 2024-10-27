Return-Path: <bpf+bounces-43252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF3C9B1C8B
	for <lists+bpf@lfdr.de>; Sun, 27 Oct 2024 09:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E28281DC2
	for <lists+bpf@lfdr.de>; Sun, 27 Oct 2024 08:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150B257C9F;
	Sun, 27 Oct 2024 08:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/eZ/xrb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA36917BA6;
	Sun, 27 Oct 2024 08:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730019010; cv=none; b=fdwuVVf2muEvjcn9IOPCBeuB8BBLr5KoEGm2oT47DGIBl44HF9bT57xVI7wCeVQz3j7RTOSYgSBwl5RVjAuoxwvtBSI61NGVWrA12pZ69CgBKtR7e7vC58vFelsXbd3e0LTSxh/R3zTim+ITxOtjhoAncRkM1PhDymyjtUtj8U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730019010; c=relaxed/simple;
	bh=S/ictX+ATqsv0Y7ayYtph846aC6YU8IxoN4tJYh75X4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c46rp1MXsFWvzh6pWuhjp9daFGbW8q9/hEhT6RvaijjqXCaF/L1+zLu+b1VeK+n8tTy7kePHe4MF/u0NLBmoMDgvF1LQVoqO8KjnWLG76UNTFQdQXY4OTpRjmZo0wxeUboS4op3+YkCyFrQR7XAsxKbcw1I5Gt3AYpbsgm2XuvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/eZ/xrb; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6e314136467so30541327b3.0;
        Sun, 27 Oct 2024 01:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730019007; x=1730623807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rp71bNijwv9lCHfBZe/MgLr7AbbyQ7KKNxx/7WbExbE=;
        b=k/eZ/xrbI/ybZh8RXKdtlCPUnG1FxWi/crDAnxKCf49fw/+wAnvUUnXYN4cVnA/bVX
         hI6R4knOGmNSUgQFT+WxwpBfIe2dTPUE8BZgusS7I8SM8XR05wBIZSoPFi4OjL4VStJp
         iX9YJcquWGDGH+EXW9iSFdARU1FxaIJLHhDSyZRHXKnW86+gm2uWgMJ8l+8bkvMWAttF
         k/BZPpqlffNgs3oZWY8YoIp4E6WBJFWbG9JkS0AiGQ60UNJY0l9n5lh1VvmoN9NNP8Wv
         C9RwzFBBiKmo78QkxRD8XJi9/a2Q7FRD55pgdhPXrzbI9GFH1wHIuJJCl5bHHLLRzpHM
         CBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730019007; x=1730623807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rp71bNijwv9lCHfBZe/MgLr7AbbyQ7KKNxx/7WbExbE=;
        b=icbW4YZMoCP6UpYGLPIpSoqkr7xScPJldChFv6/aKMpz3Li2W5RBmMy/kvQEGV1zpN
         92YenEoEvuim+eTnQN9M7uZ4uhVrgD7luM4s0QL/83kXH5MmbHQbgYG9XN+DsRMPjpjO
         JnnGhRLd9c0/XZkuE2Dz6VeLm6ayXCAWo4jjOFYWN4dY/Tj7mmZm7R5jqi6a2UIby9Su
         2hVC92Pbv1CsZ9z/cNyNyrzfM8qgmHo56+gbZbN8KXw7sMNxGAjS6tfVpjL6SpVtKrZ6
         tADgnjah80V/rgABE5eX00XgVWpFjD4bP2DCC1HXHtP/3v3LTrNABFrQtbWPf7EJ+O1O
         bc9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUJDqbt0/5iae42f52B39tcwMHfYj2XMLRIOEPJ0wkkEyki425O/p2PJLW8Q19792AFWc=@vger.kernel.org, AJvYcCWLs7jlasIcL3j1MPpm9V5At+KB9SqKQv/6Ck+J+A2SFyM8gymoUUAm1Y3hMHVYrF0mZMoVLKzK@vger.kernel.org, AJvYcCXF7d2g33vQ4gMOvxgrQAy8n+R+qz6Wjj9F6IF5E6Og/hnrP76rKQqIcNyLMpvlbi7RFGOcT8FsveqeLzzT@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+a2hm5MJdEMdkK3lmCge7QDzG7px8G0nfxhmPZGurzNlIZBQ0
	5Mo6sp1Fu95+EEtVFsHpn6STJoWaM21beEcu22rlXk9E3Hjhd58E2VQ2e0CsK01y8Dca0gqp43S
	obVHD1dAz8ciHJ1SFuJ25yIs0ae0=
X-Google-Smtp-Source: AGHT+IGjEgppN7G6fYO1LK7LTzhJNQ42OewN6u2JsRtG2cmXhUoGZCg3CYT8MCetd8kVr0h5oRb/n4T+/fHRCAPHfyE=
X-Received: by 2002:a05:690c:6f0b:b0:6e3:2bbd:cd08 with SMTP id
 00721157ae682-6e842f88314mr85751807b3.3.1730019007598; Sun, 27 Oct 2024
 01:50:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241019071149.81696-1-danielyangkang@gmail.com>
 <c7d0503b-e20d-4a6d-aecf-2bd7e1c7a450@linux.dev> <CAGiJo8R2PhpOitTjdqZ-jbng0Yg=Lxu6L+6FkYuUC1M_d10U2Q@mail.gmail.com>
 <5c8fb835-b0cb-428b-ab07-e20f905eb19f@linux.dev>
In-Reply-To: <5c8fb835-b0cb-428b-ab07-e20f905eb19f@linux.dev>
From: Daniel Yang <danielyangkang@gmail.com>
Date: Sun, 27 Oct 2024 01:49:31 -0700
Message-ID: <CAGiJo8RJ+0K-JYtCq4ZLg_4eq7HDkib9iwE-UTnimgEQE8rgtg@mail.gmail.com>
Subject: Re: [PATCH net] Drop packets with invalid headers to prevent KMSAN infoleak
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:BPF [NETWORKING] (tcx & tc BPF, sock_addr)" <bpf@vger.kernel.org>, 
	"open list:BPF [NETWORKING] (tcx & tc BPF, sock_addr)" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 11:14=E2=80=AFAM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> On 10/21/24 6:37 PM, Daniel Yang wrote:
> >> A test in selftests/bpf is needed to reproduce and better understand t=
his.
> > I don't know much about self tests but I've just been using the syzbot
> > repro and #syz test at the link in the patch:
> > https://syzkaller.appspot.com/bug?extid=3D346474e3bf0b26bd3090. Testing
> > the patch showed that the uninitialized memory was not getting written
> > to memory.
> >
> >> Only bpf_clone_redirect() is needed to reproduce or other bpf_skb_*() =
helpers calls
> >> are needed to reproduce?
>
> If only bpf_clone_redirect() is needed, it should be simple to write a se=
lftest
> to reproduce it. It also helps to catch future regression.
>
> Please tag the next respin as "bpf" also.

I have a problem. I can't seem to build the bpf kselftests for some
reason. There is always a struct definition error:
In file included from progs/profiler1.c:5:
progs/profiler.inc.h:599:49: error: declaration of 'struct
syscall_trace_enter' will not be visible outside of t]
  599 | int tracepoint__syscalls__sys_enter_kill(struct
syscall_trace_enter* ctx)
      |                                                 ^
progs/profiler.inc.h:604:15: error: incomplete definition of type
'struct syscall_trace_enter'
  604 |         int pid =3D ctx->args[0];
      |                   ~~~^
progs/profiler.inc.h:599:49: note: forward declaration of 'struct
syscall_trace_enter'
  599 | int tracepoint__syscalls__sys_enter_kill(struct
syscall_trace_enter* ctx)
      |                                                 ^
progs/profiler.inc.h:605:15: error: incomplete definition of type
'struct syscall_trace_enter'
  605 |         int sig =3D ctx->args[1];
      |                   ~~~^
progs/profiler.inc.h:599:49: note: forward declaration of 'struct
syscall_trace_enter'
  599 | int tracepoint__syscalls__sys_enter_kill(struct
syscall_trace_enter* ctx)

I just run the following to build:
$ cd tools/testing/selftests/bpf/
$ make

I can't find anyone else encountering the same error.

