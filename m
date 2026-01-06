Return-Path: <bpf+bounces-77901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F587CF61D2
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 01:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A0D8306C773
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 00:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7A01E9B12;
	Tue,  6 Jan 2026 00:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBZyW95V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FDB4A33
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 00:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767660723; cv=none; b=gNpl0JmhkgSrMIH6fZxjmCWkzXx+ViUzbfkvDHs2ayI5jmJRgQNKJdmCWUNENSyXcf0/TwANPcmV6Qf2Bm6whE1D3cSy32AS06Zz+kZYPgJoaSKeFWdNTAVD16OhaEO6vdTzBBpU/P1oVIpq3H2BHrjCoytsub89PJuWzWknFnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767660723; c=relaxed/simple;
	bh=121YepIIPK3mdJqqn2NtkzokqFn0EteVfZ0Rhg8h070=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VKlNYTIt0CVQydjn8dFI49IAoigH7hp6CaetYZy7tM5dSGlOxQmlAa+yKscwv3cQSZC+hBL7D2gM9kYM1QoYufn1rT0xRhCO4v6PXEkGP1Pl6b4ZFQ5srqsBFqZwdMhpTUk+EjyXeNAF1wRJ/D4bmD64ulDRD9XPTKScGz2QSMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBZyW95V; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34c363eb612so561716a91.0
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 16:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767660721; x=1768265521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAD6YtZZBHQIK4oM5dCNs2iuqj3Y+7DXU4uKX2S0GE4=;
        b=NBZyW95VecLft/W80maeDo6q4A2+a8cSGZgYzHikTq3bnTwjIJgpouJrlnZBm86OfB
         ttF0Gs7DJqB4pkRd95tBCYphrLG70YeZNAKd4TNJj1veagU/kZJAm8njj0IY65OmE42V
         wuFW1nS9gNvnEO0qFuiUWx/R4zTmRgwKnJ7nNiB1hjNZGKnrxX/ojTXC+xn9bnG17zvl
         NixOzD1xfJO1u+krWRal5RmZe8a/ep1CSe7p8/obY0rHdpjtrOh3VaShXz5p5myA+HiV
         li9entmLOtuYnDQVm9z1qbk6AdR679Z3P8G4PGZOWht/G4kXcW7KStVApjG2PQUXULll
         L5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767660721; x=1768265521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qAD6YtZZBHQIK4oM5dCNs2iuqj3Y+7DXU4uKX2S0GE4=;
        b=oJxWUNigtFc8DWnQGNkrZ0b53solWiUl5YNeYL3FlqQMFuRVyfEA72oitt60pfFe3i
         ZR4cj8H2GG2Yb14coNl4FEEEKFnw/bQLUrz1us0tWpH2Yt4+X97/upT4kGeLJ+v37T7C
         d9Pd0vKD4VQ5j2ONwJaArlX6MQu5qiT6y3qEAPVm4XlSvD1YYkLUBjE6uBq1UvkbxfiL
         9lLDW+L7a0PzNV38c3Q0W6TENKaqxYg/hIOonRSsQ2pD0b2O41VBd65qFUi+ao44YvjF
         0t2k5QY/IqfmeLuqFHEsdN9ECvK/ntMa6Ac+aRzZDsO2rNYCV//OyD975oOZEyDWo6WU
         PKRg==
X-Forwarded-Encrypted: i=1; AJvYcCVp4KZaZH2vhLKq9sA/Ot5iuX5qNeNvyoYoj6z9A+aUAeqZfo/HtJ3GDKOUWwSPaiVzGyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUTb7ay+Li7Ct8kKj3M6EaQeOIId/pcnrYBUd1nuD0DjMXV+bG
	sZMVkbjEvFfriBVyUpomZj2Zwdmt6fg62o3kuHVIpbrJ4/VSp8yJAFmo5Bng7fmOaxKkrB2LPN0
	CAj+K9h+773yHieH5yX8avdhiRWZ2IA4=
X-Gm-Gg: AY/fxX7gU4RUOUdAsjbu6kLBkV6fichtvYsmFse4JKTUFtpkfIx0Op2s7bPK7Dz91ll
	/f+tAgqNaMlOacqMdov46ahS/CvVDAPmmTcQM0cu7Uqr4WN8yUqb6bggPdhQeHbPhTl3bAQDPlu
	WT9pa99bF64rOCU4O25QEVK5iessUB5PEbF+h2WpFK56E2Npfqv12MTMP3/Ex3IlCYcRZKSV2Nt
	36jh0r+tio0UO9OUqbC7K6aEdwYwKcTJCK0Fxuxr4DTa6nhIc+Hr0qUbKLNa1F8j3ej2aZ5B1Qt
	l5vW5dsw7R0=
X-Google-Smtp-Source: AGHT+IFv603VqYElE35SX3ELAvBCRGlQYtqXiilEa9Qkts21oLcu00Lv08iVpktL/hQ99CcCQkhb+hhuq/1eVssKoUg=
X-Received: by 2002:a17:90b:2d4d:b0:341:abdc:8ea2 with SMTP id
 98e67ed59e1d1-34f5f36e115mr904799a91.37.1767660720750; Mon, 05 Jan 2026
 16:52:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260104205220.980752-1-contact@arnaud-lcm.com>
In-Reply-To: <20260104205220.980752-1-contact@arnaud-lcm.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 5 Jan 2026 16:51:48 -0800
X-Gm-Features: AQt7F2pWBNs-OAi0pD2XDPRGnH3bUZqznbZCdhovb5g-fSH9tIlvDDzLKUS1k10
Message-ID: <CAEf4BzYakog+DLSfA6aiHCPW0QHR-=TC8pVi+jDVo27Ljk5uuA@mail.gmail.com>
Subject: Re: [PATCH] bpf-next: Prevent out of bound buffer write in __bpf_get_stack
To: Arnaud Lecomte <contact@arnaud-lcm.com>
Cc: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com, andrii@kernel.org, 
	ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev, 
	Brahmajit Das <listout@listout.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 4, 2026 at 12:52=E2=80=AFPM Arnaud Lecomte <contact@arnaud-lcm.=
com> wrote:
>
> Syzkaller reported a KASAN slab-out-of-bounds write in __bpf_get_stack()
> during stack trace copying.
>
> The issue occurs when: the callchain entry (stored as a per-cpu variable)
> grow between collection and buffer copy, causing it to exceed the initial=
ly
> calculated buffer size based on max_depth.
>
> The callchain collection intentionally avoids locking for performance
> reasons, but this creates a window where concurrent modifications can
> occur during the copy operation.
>
> To prevent this from happening, we clamp the trace len to the max
> depth initially calculated with the buffer size and the size of
> a trace.
>
> Reported-by: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/691231dc.a70a0220.22f260.0101.GAE@goo=
gle.com/T/
> Fixes: e17d62fedd10 ("bpf: Refactor stack map trace depth calculation int=
o helper function")
> Tested-by: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com
> Cc: Brahmajit Das <listout@listout.xyz>
> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
> ---
> Thanks Brahmajit Das for the initial fix he proposed that I tweaked
> with the correct justification and a better implementation in my
> opinion.
> ---
>  kernel/bpf/stackmap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index da3d328f5c15..e56752a9a891 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -465,7 +465,6 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
>
>         if (trace_in) {
>                 trace =3D trace_in;
> -               trace->nr =3D min_t(u32, trace->nr, max_depth);
>         } else if (kernel && task) {
>                 trace =3D get_callchain_entry_for_task(task, max_depth);
>         } else {
> @@ -479,7 +478,8 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
>                 goto err_fault;
>         }
>
> -       trace_nr =3D trace->nr - skip;
> +       trace_nr =3D min(trace->nr, max_depth);

there is `trace->nr < skip` check right above, should it be moved here
and done against adjusted trace_nr (but before we subtract skip, of
course)?

> +       trace_nr =3D trace_nr - skip;
>         copy_len =3D trace_nr * elem_size;
>
>         ips =3D trace->ip + skip;
> --
> 2.43.0
>

