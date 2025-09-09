Return-Path: <bpf+bounces-67818-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BD7B49E5C
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 02:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790824E57D8
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 00:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8D921255B;
	Tue,  9 Sep 2025 00:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IXVUmUd4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35071D514E
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 00:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757379351; cv=none; b=VhP+PjaTMbX8O73CfKLESSakyH2s9WH51q9ZwdPyyx8zHK6XgyR93lr+jwtUlMWLVMkWa8pjj98dmlH2xR+ZpB1Dvem6DKWz/VgGg7fBU1Hyqin1sfblK49q63pM9xRLLbBkNCFmD7LBkx3cAn3uLfPU9mEv+Yak3nq7p1D3CuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757379351; c=relaxed/simple;
	bh=yYo7IzJbU6Z6mx7RODDFYoPjW98xKDBaTEKzFt7LVPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uRckSZySvp9aaopzLLXd/eg2eZT8ukbJMgaxkA1/mnFURlwMrN3jowf1Z7rn5uWaPjRJWmXJ3jerlophoKUWoiAz38co/Ru8C7QG2BnNgd7EGbXwksqh4KcL7+NwR3nB4siQB3Mi6sNqiGfe30mtCYLXHF5rd2eyZWgA/aNc0LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IXVUmUd4; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4fb8d3a2dbso3133400a12.3
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 17:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757379349; x=1757984149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cJBxAEvachaOK44sfQK1ayR3C7n/EK/ryGUnykQsow=;
        b=IXVUmUd4Iv6z53FbCOFMvuE5jBVFJmay2QylI8V4LvX8LUNySQijxt4QjeG38NDC3O
         1T+VOH8efBS3piyReglAWKgf67Yw+mDUNvaDTOBd+i74g8170AxFCSHe2CwKgHnUOmMK
         xO7kAieCAJLR8VfaxQlE5W17RT3zT/0IGrn/EKspulk3xyPB8PEbwBGDouj1v96Sffd1
         avlXwKp0ZQ9f5XYP9eCkKzg/xFNoXN39Q+hx6z4WcVvZjW2h6SF4v6c0K4sqjYq+Uvx3
         sN78BBjlQpgJjGxgPRKDBanGl6Jz2/LyuAwCsZe3+XJXn16hFUOisZokWyTWNfkKAKLi
         dGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757379349; x=1757984149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/cJBxAEvachaOK44sfQK1ayR3C7n/EK/ryGUnykQsow=;
        b=ADrEfsi3+u5nRVwxe8drVTjJxaLMNbh2tOIIVXzgyNCTLKcaNxKncHgMdVvXA4yH+U
         xrXBhBD3HVh5JAbtFRpDq0xe18D7INT0f5on18DZciTX300rpdY/WDQjTgmCe5QKLvGs
         Pjy3WWrHEWTNyVpm7PL9r6Q4YqMPJvk/qOZR65/jHIASSUnNsg1pfZsS7cEyMYrO0J9f
         nxvYcm6UJwmrcDbwBN0IKIaQGIHEKdsZk+FKMe7XwtLbsCw09UGrJHUUkTIy/XeBugR9
         Lf8yM6dnnj3GLzLcPQQq7ejZWPLRy6NpXzf8zID+Abl9Sbg5j1O20eeMeQEo3TEnz7Px
         nUQg==
X-Forwarded-Encrypted: i=1; AJvYcCVs107QCpEyNVxqswTrAwpBP63nmrawuS2ZpivlzHQJ2qjeHSsR1cWna5f8V3UiQXR9wm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqKoSUX2zbKdmyxRUQeVpTUsNNZP65UnAg5uAm03IQ8Y6N4QZA
	HGP2fnfHIomoyVANCt61v1tsyg6n/YkOgAMaAD4b9wzGvxvcg4sx2wo8uiSVo+AfpOvrygopS25
	aBf3kPGvuXPLSQtns45vN7Edx6n9lz09ELyeZh72z
X-Gm-Gg: ASbGncunaTmDwI+pvSqH2g+Jk5+3gOi4R/r2aJHdXuVo7c/l3DVATNjPuV1yR4Ig4tb
	Ps4Z0vxoZlgHgQyWwUeyqNM8136ejwhD2asywPMrXKAecjKeSWDyhevbyne2A1ZKZfAvQME4GcC
	KEIqhyT8mpX8Ekwh/bNPFI44+V7+5SCLfhbCvLAR7/7DcVyd7ElrNdFbIeVOXEuBd1Zhz73XbTK
	3PkjxfUH+dIkWIrllBFqCUheOPc0fYHCd6fQhPAsMc9gwrVhdg=
X-Google-Smtp-Source: AGHT+IEe5vFzXTZoRUvMqOuRmHzLn12OaUZoPOT/hwkLqob1mpYmqc43GujGhTWLgDwZw16W77b5Y8QtWA5EWP21sJE=
X-Received: by 2002:a17:903:1a30:b0:24e:2b3d:bb08 with SMTP id
 d9443c01a7336-2516fbdd4c2mr119092605ad.20.1757379348947; Mon, 08 Sep 2025
 17:55:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908223750.3375376-1-kuniyu@google.com> <hlxtpscuxjjzgsiom4yh6r7zj4vpiuibqod7mkvceqzabhqeba@zsybr6aadn3c>
In-Reply-To: <hlxtpscuxjjzgsiom4yh6r7zj4vpiuibqod7mkvceqzabhqeba@zsybr6aadn3c>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 8 Sep 2025 17:55:37 -0700
X-Gm-Features: Ac12FXyqQhG5nuTIx8tfds3pQmQ2VcQBVbSOrZvKYPalpd022CkZjOvgHEHN60A
Message-ID: <CAAVpQUC1tm+rYE07_5ur+x8eh0x7RZ2sR1PGHG9oRhdeAGBdrQ@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next/net 0/5] bpf: Allow decoupling memcg from sk->sk_prot->memory_allocated.
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 4:47=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.dev=
> wrote:
>
> Let me quickly give couple of high level comments.
>
> On Mon, Sep 08, 2025 at 10:34:34PM +0000, Kuniyuki Iwashima wrote:
> > Some protocols (e.g., TCP, UDP) have their own memory accounting for
> > socket buffers and charge memory to global per-protocol counters such
> > as /proc/net/ipv4/tcp_mem.
> >
> > When running under a non-root cgroup,
>
> Remove this non-root cgroup as we may change in future to also associate
> with root memcg for stat purpose. In addition, we may switch sk pointing
> to objcg instead of memcg.

Makes sense.  Will remove the part.

>
> > this memory is also charged to
> > the memcg as sock in memory.stat.
> >
> > We do not need to pay costs for two orthogonal memory accounting
> > mechanisms.
> >
> > This series allows decoupling memcg from the global memory accounting
> > (memcg + tcp_mem -> memcg) if socket is configured as such by BPF prog.
> >
>
> I understand that you need fine grained control but I see more users
> interested in system level settings i.e. either through config, boot
> param or sysctl, let the user/admin disable protocol specific accounting
> if memcg is enabled.

Considering tcp/udp/sctp sockets are not created in the early
boot stage, I think sysctl would be enough and we don't need to
control the default value with a boot param (sysctl.conf would be
early enough).


>
> Please rename SK_BPF_MEMCG_SOCK_ISOLATED to something more appropriate.
> The isolated word is giving wrong impression. We want something which
> specify that the kernel is only doing memcg accounting and not protocol
> specific accounting for this socket. So, something like
> SK_BPF_MEMCG_ONLY make more sense.

Maybe _EXCLUSIVE would be a bit clearer ?

net.core.memcg_exclusive (sysctl)
SK_BPF_MEMCG_EXCLUSIVE

or much clearer but lengthy ones ?

net.core.memcg_no_per_protocol_account
SK_BPF_MEMCG_NO_PER_PROTOCOL_ACCOUNT

net.core.memcg_no_global_account
SK_BPF_MEMCG_NO_GLOBAL_ACCOUNT

I'm bad at naming.  Do you have any preference ?

