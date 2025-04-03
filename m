Return-Path: <bpf+bounces-55198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D61A7995F
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 02:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C3E07A3AF2
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 00:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF4FE56A;
	Thu,  3 Apr 2025 00:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDL4sk2d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7580018024;
	Thu,  3 Apr 2025 00:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743639786; cv=none; b=EUunslcKfgw6wTW7XjRzBEkjSgH6WYy385QmelZ3lIEQXwp7KyZdszQZhsgpdgd2xCZw9Aer6vFd9JXQi6aKqE14NqpeygqnAIfiuJ1YPZN0E00JNokRAy1MqXPh0Wl1+hNzEwpmKWNyaNBVeii4lo/xyEBNq0apyLAt5bikVS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743639786; c=relaxed/simple;
	bh=9JPrInwMSgx78qDa5AnuxWMtZoCJgiCx6RPmWtVh0M0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o00SLSlDEmZODm+2y/u8spLprquos87GHH4lDhX3uHIB6FYj+gwKid0vOulVrjTUMYvU1XLesaMfbYA3K853pMNeCOzPDuZOQNjQTC2oPFPl4zFL6p70VvciaN6iSm3Yr8/CbJ5M6BC0TSDc1wkfxUGLU04Yx8hmT6CaQPsPTw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDL4sk2d; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39c1ee0fd43so314422f8f.0;
        Wed, 02 Apr 2025 17:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743639783; x=1744244583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGELDGnQYr3hKRzP813UaYd/cH2T/S4uNmGRNWE+0h0=;
        b=NDL4sk2d6I6H7PLofFlnaDpw9KsK62NO6ztA7rtCOw1Om6ETHUeKJOlpMlWyg2rGeD
         yKfxHOMcyw3OJ3xWuuRvZJQBBerNkQ9Kg5PBgpHyvsFEIUuxJjKDftqU/cdIZfXKCkdV
         l652ijx1/qbUkovMz+59+MjhI/jWZYYfHkqifjH5WMysLyayy9EQYy8bTmakwj9VXsoW
         xFZDL2NxEvDV3bPzEAkYrFHxoG6L+YXQ5C/YZv4U4qnlb63kI4rqvoBwTwN7Jd+YA5jM
         GAsPa8aYoJ8Nj9RyrcT96L5zNyS2G/pknNfjtK2aMMz7JRfXcNgKrP0uUysMtgdMU19w
         LggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743639783; x=1744244583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VGELDGnQYr3hKRzP813UaYd/cH2T/S4uNmGRNWE+0h0=;
        b=wA/wRujaAW3UyFJPX8zu3JtZU0NfnNpskzJDPS8j1Tk1mp7bup42UDVZ6iCPAumvS5
         qsoplaYeI24CiHJIWWtVrAij6UGM5uXPi029PGhkoI/7Z3NdfqpsrwXDOb6v5jjDZvdL
         6ICU0gw+LhOrcn7lUm0UocOV3DvzW0BWEntXA5CKTsY8ipL+m4wn/Jozor/Bi5gDpJ1/
         Bl9BXpbJ9oVwM4IZAvIrkA8X90634/Yh6dnfmV4A9vz3haUskQEXTfaJW1gNYLVtke2i
         CY/dqoAv3oOG5GONKC1khBdavr4a8cWHFEj7V97eSt6f86vYGxqVK8fBVkpzKYf6IM0S
         F1fw==
X-Forwarded-Encrypted: i=1; AJvYcCU1MNQBTZ3bsWb7EkQ/usCBDxhKRjKJS1CUDA8gOWz0gbfLgFJNlL7smJSmSLuKC+YPNfD+xrQgZcPWgQVG@vger.kernel.org, AJvYcCUqDa8zpYEzJ9FMpTlunXevIAWXaqwuGTEh6v8zNvJf4OlbsCvdCGq0jpdsSb9VXwPgdZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/u0h642uLYZL68HR0Mnxnz3TNYyNFJwkcsnFfikOQia7SVmxV
	jylodogZDVmd/VR25tLzP4lBXVzS3ev+GTOl7rH4V9UzDz072fmrfoqiUtYNH7NVfR+7vaDqOzc
	Q5e0vr4qUMECx0KEnuGVlORfzxHg=
X-Gm-Gg: ASbGnctL56/WuKdG4oTt5zv0QHc7IB31XvZm0u/6HGKGnz9U5bLjV0EAbyTxArVqDKw
	2TrtH04SALANdspbWfwL0fUeLJhcIq3+BgJ4qdk5+ewZwP+0+Dslqih3y4g8O5AZzFM1V14JRy8
	lLzGUcGA2KM5NIF81CdcWhHyNkvDaiv89csUoTaUMMBA==
X-Google-Smtp-Source: AGHT+IHKd5RDxqv01ttjKrNbPPmORqvp3dLkUjArsa0VK6F36HaF/uhY+1Q3ZCT8E7SGkkEG0BFtjxSlECoZ+K/ewmQ=
X-Received: by 2002:a05:6000:1845:b0:39c:dfa:d347 with SMTP id
 ffacd0b85a97d-39c2f8c674emr358515f8f.2.1743639782487; Wed, 02 Apr 2025
 17:23:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401005134.14433-1-alexei.starovoitov@gmail.com>
 <20250402073032.rqsmPfJs@linutronix.de> <62dd026d-1290-49cb-a411-897f4d5f6ca7@suse.cz>
 <CAADnVQLce4pH4DJW2WW6W2-ct-17OnQE7D8q7KiwdNougis2BQ@mail.gmail.com>
In-Reply-To: <CAADnVQLce4pH4DJW2WW6W2-ct-17OnQE7D8q7KiwdNougis2BQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 2 Apr 2025 17:22:51 -0700
X-Gm-Features: ATxdqUHSEULJuOw8smbh9_BWrm-y4sLi0DDUrNw09xcGN1TrBzOoxxiAHkh30EA
Message-ID: <CAADnVQKSL9Vp5ZjQ6k1ZH9Gs6ytj_PEbcDMu+Pa7AxXngF79Jg@mail.gmail.com>
Subject: Re: [PATCH] locking/local_lock, mm: Replace localtry_ helpers with
 local_trylock_t type
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, 
	bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 2:35=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Apr 2, 2025 at 2:02=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> w=
rote:
> >
> > On 4/2/25 09:30, Sebastian Andrzej Siewior wrote:
> > > On 2025-03-31 17:51:34 [-0700], Alexei Starovoitov wrote:
> > >> From: Alexei Starovoitov <ast@kernel.org>
> > >>
> > >> Partially revert commit 0aaddfb06882 ("locking/local_lock: Introduce=
 localtry_lock_t").
> > >> Remove localtry_*() helpers, since localtry_lock() name might
> > >> be misinterpreted as "try lock".
> > >
> > > So we back to what you suggested initially. I was more a fan of
> > > explicitly naming things but if this is misleading so be it. So
> > >
> > > Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > >
> > > While at it, could you look at the hunk below and check if it worth i=
t?
> > > The struct duplication and hoping that the first part remains the sam=
e,
> > > is hoping. This still relies that the first part remains the same but=
=E2=80=A6
> >
> > I've updated your fixups to v2
> > https://lore.kernel.org/all/20250401205245.70838-1-alexei.starovoitov@g=
mail.com/
>
> Sebastian, Vlastimil,
> Thanks for the fixups. Folded.

I was about to send v3, but decided to play with
my stress test a bit more and it caught this race:

[   18.114617] DEBUG_LOCKS_WARN_ON(l->owner)
[   18.114717] WARNING: CPU: 0 PID: 2159 at
include/linux/local_lock_internal.h:46 try_charge_memcg+0x73b/0x7b0
[   18.114733] RIP: 0010:try_charge_memcg+0x73b/0x7b0
[   18.114769]  <NMI>
[   18.114774]  __memcg_kmem_charge_page+0xbe/0x390
[   18.114778]  try_alloc_pages_noprof+0x11e/0x280
[   18.114782]  nmi_callback+0x55/0xc0 [bpf_testmod]
...
[   18.114820]  end_repeat_nmi+0xf/0x18
[   18.114822] RIP: 0010:refill_stock+0xef/0x1e0
[   18.114832]  ? refill_stock+0xef/0x1e0
[   18.114834]  </NMI>
[   18.114834]  <TASK>
[   18.114835]  obj_cgroup_uncharge_pages+0x44/0x170
[   18.114837]  __memcg_kmem_uncharge_page+0x52/0x180
[   18.114839]  __free_frozen_pages+0xce/0x6c0

The same issue is present in the __localtry_unlock*()...
these two should be done in the opposite order:
    WRITE_ONCE(lt->acquired, 0);
    local_lock_release(&lt->llock);

Though IRQs are still disabled at this point
the local_trylock() from NMI will succeed and
local_lock_acquire(l); will warn.

The following fix will be included in v3:

diff --git a/include/linux/local_lock_internal.h
b/include/linux/local_lock_internal.h
index e41ca62fadea..bf2bf40d7b18 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -169,13 +169,13 @@ do {
                 \
                                                                        \
                l =3D (local_lock_t *)this_cpu_ptr(lock);                 \
                tl =3D (local_trylock_t *)l;                              \
+               local_lock_release(l);                                  \
                _Generic((lock),                                        \
                        local_trylock_t *: ({                           \
                                lockdep_assert(tl->acquired =3D=3D 1);     =
 \
                                WRITE_ONCE(tl->acquired, 0);            \
                        }),                                             \
                        default:(void)0);                               \
-               local_lock_release(l);                                  \
        } while (0)

After that the stress tester runs cleanly.

