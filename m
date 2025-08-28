Return-Path: <bpf+bounces-66759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DC6B38FBD
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 02:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 676281B27699
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 00:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C5416F288;
	Thu, 28 Aug 2025 00:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cUvc3an0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD56153BE8
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 00:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756340768; cv=none; b=iWz7ZgAySG5bQdU/Exg6CPiNeCnoqN9ssdnFzaTBQWcXHvr474DQ+X/2ADHanV0iA6vIgOSLBgXuPLdv/F41qsvpJ/e+CSWWYBxrauZPPzWbXblNv/AEXVjnpEc5svEa2B1DDoVARaw3HpejwieTeTQ+5Mx9AjhwDpaJGHGUx58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756340768; c=relaxed/simple;
	bh=fYriN/eS/BJvu5nAuooQ51vzV9rumoWWO8rvVfFGc/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1ZeEEmbWHkaDEe61MVxR56kIAtGwXxpenC+qAVdNydaLkZ2UZSKRlbaLnzutsjc96iOGQuJaOGN75J9ErgUmD0orvqh0yN7aLAYQnFNhgsjGX8GEl9LvKSMArfAMIU8zptD7P/++t9qEkZ/pCkdeyBH7eUaT7egGPFd6i9YfSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cUvc3an0; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-244580523a0so4028965ad.1
        for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 17:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756340767; x=1756945567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u20ZRFzbGoAnlWu6SqOAzaVBCg+i0tR6sdtsICKHTkY=;
        b=cUvc3an0dfy9PNjkCcK2Xb2S96SI5qNqjbPRuU050Lp7HJSQgnA299mFtOEOsSUNjC
         XC7/hoL6CYqvNRmkzzNxv5g3WP+G3KytlaZVvzmE65OzyVGucrANTKY2dlcAAZkhpRxG
         uTYG7yzzoa799j6JVcTyJhv4xi3XQINstIbCE/+lSQSs85Bs9QEhD65hXISOk5ogUjG3
         0qYNtm4UqwQJg/zxkgsBZ+vTNL4T3eg/m5pA3Bw3TarBtast/zBTZCk/wOZrRym7Q4JU
         JKFf3vzhO37py9BqeQzf9E9V7ofMO027e1XxSbsVNx57JL64hYvhr+GQ2OTTp9WS8qfN
         YcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756340767; x=1756945567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u20ZRFzbGoAnlWu6SqOAzaVBCg+i0tR6sdtsICKHTkY=;
        b=H4TSzvKLCxbz2uvGLSXDSakaVl3zuD/tvuFQYowpUOJhrZYHSm8OhR8EjO+NhTppFV
         JipexJyP9OQ7CnPzTEQ2hlOmEe3COzzgAt+YI1ogup/0pMy3QwfpKWABoNkyEqLNlfGT
         XJyWCdN19tAGDf3tnhhnPSRu0LTtFJOmtVMVAP9D5mpaymJC6PSVg0MSye68kwRHNuOi
         /vVJ8tSljDEpIzisdEIZev1/B51q4qBD46MjTTLOpp9ZtjeRBPrahH8dp8INDuY2EqTU
         /Z6ZMHGcyu2jx89er2ulDXhKaq9I489VV5+fFVX52zQoC69c4ClZBjfIYrFfgYQpM4zY
         /RKQ==
X-Forwarded-Encrypted: i=1; AJvYcCW97jyor4A5efD81idNeWvExTL6jUzpKo8OcCWoEIi8P07t1zgedz/ZE1Cwwpgifkkew58=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAMaBUtnUgV6sUEPb83BMXQ4yqsY7TCh4r3ZeGQ255wdpilhEB
	HEcF+Z3x2wuKM0S9fzYaPTb8vbSc/QoAK7+wxyUDUFh9ccUCpEbccgZguseOvKfgckPZvfSwYSm
	kSSji9FPlvCMecoZx2vYVVETWAeh+3ZVaUVI3TxYz
X-Gm-Gg: ASbGncsJlTSQ3/uEfczWJ2ruQmBupWIAL8wWjRFeH9NBCH+ZpknK/5WUYGak2T02AG0
	nb7wzHj28IllNBtmL7+XDk8gi36n0QKw0F7PChUOyDthJ//oIWtqQvVDSt8jQ10uBmaUoRGzGHI
	gLTeJL0jMkYDdTESxyT25osxBP4jzP74Fl9aM1tbKWvbiPiY0oztdofbsfz/WdzUPNpGlF1nuoh
	8kZFCNEfpqh3BdQKrHorrDkMXyN6kmvXU+/Fg2NU3fGw/GZ5fkmROZuUIIGQVEpDe837HcZjpRS
	/eO0MmmRGdi7+A==
X-Google-Smtp-Source: AGHT+IFvFyq9wJjV0E4vHzXrSBBTGOb3f5sWbfYRnIfXeaWI7huFj1R36mzc+ccaW7Be4EzbQHxY2eBWkT4E9d+3MBw=
X-Received: by 2002:a17:902:e786:b0:246:80b1:8c87 with SMTP id
 d9443c01a7336-24680b190famr210695215ad.43.1756340766628; Wed, 27 Aug 2025
 17:26:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826183940.3310118-1-kuniyu@google.com> <20250826183940.3310118-6-kuniyu@google.com>
 <ab07a893-d27d-447e-931a-6014f55132d2@linux.dev>
In-Reply-To: <ab07a893-d27d-447e-931a-6014f55132d2@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 27 Aug 2025 17:25:53 -0700
X-Gm-Features: Ac12FXzHYDoUPkUg-gwnLJeJ9P7Rhlz_1XDQC5p0y_VYo33-H5adIDSO4FZUCew
Message-ID: <CAAVpQUCNVfXek9cO5ZO579=pWXV5aqRjseNxdRVE-Yp8pcCZZw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next/net 5/5] selftest: bpf: Add test for SK_BPF_MEMCG_SOCK_ISOLATED.
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 5:14=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 8/26/25 11:38 AM, Kuniyuki Iwashima wrote:
> > The test does the following for IPv4/IPv6 x TCP/UDP sockets
> > with/without BPF prog.
> >
> >    1. Create socket pairs
> >    2. Send a bunch of data that require more than 1000 pages
> >    3. Read memory_allocated from the 3rd column in /proc/net/protocols
> >    4. Check if unread data is charged to memory_allocated
> >
> > If BPF prog is attached, memory_allocated should not be changed,
> > but we allow a small error (up to 10 pages) in case the test is ran
> > concurrently with other tests using TCP/UDP sockets.
>
> hmm... there is a "./test_progs -j" that multiple tests can run in parall=
el.
> Will it be reliable enough or it needs the "serial_" prefix in the test
> function?

Didn't know the prefix, sounds useful :)


> Beside, the test took ~20s in my qemu. Is it feasible to shorten the test=
?

Same on my qemu setup, and I think it's feasible with serial_.

Currently, the test consumes 2000> pages for each TCP/UDP
case, but this was just to make it more reliable on uncertain env.

