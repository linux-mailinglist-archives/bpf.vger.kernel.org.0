Return-Path: <bpf+bounces-43659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0DD9B7FD0
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 17:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC38F2815AD
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 16:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2CE1BD034;
	Thu, 31 Oct 2024 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pt5sVmV2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B4D1BBBDA
	for <bpf@vger.kernel.org>; Thu, 31 Oct 2024 16:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730391476; cv=none; b=LSRkr03f/rTdSmyXfpKaY2qUhMOOyWAepehUM4OO333g/kHrwz8XXk4t1uANJr46cMiFrXnl7+JzRMhUaRNoAxCZlmkRoBuYVH1fS2+OQfPfJf91GsLqJSqNCxuc0AOby9ojOzKOgPcyzTU+Pfa8lX3OITAJjsHUQPeCppuykuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730391476; c=relaxed/simple;
	bh=y2IsLyxoEKNnYtvowVlcI8ThZYqvYvSbPjW89cG/dkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c42p7GHu9kP8X3JJzvZBxOibcZwnXHQCf9696AWHTHO7RLgCb3tTJsuICjaWVJjCZhYihOfoP5/XNHzNuwK6QXhPBWctsIO4VmM5IKUy01H3nAgDosa9Hza6ykB+uKG2vO6Lu3XGieuQT4xDeRLtvAcCl5I21Y05DkM1Uj6SL1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Pt5sVmV2; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2da8529e1so136240a91.1
        for <bpf@vger.kernel.org>; Thu, 31 Oct 2024 09:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730391474; x=1730996274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPfyBMQZSoHiMisSRJWvTqEvvGUVXWxSu17kcRJj79k=;
        b=Pt5sVmV2ACBwf2qBc2iIP8HGg+dagSbgoTw7qQCpdR3zXmjf7EpgL86w8JojQjDWu7
         iFFfKJdbM9BecWnz1iaozr8UY/w3u+y6G7uUYGTI/JnZ5cAPvUkgHQoHbspoDDeChKY+
         Qb1tr26a+crmrWFw6m8mw8oHTUbMD9X89XpCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730391474; x=1730996274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPfyBMQZSoHiMisSRJWvTqEvvGUVXWxSu17kcRJj79k=;
        b=oGnS4W/N4AYzH+ukHSZUYEALt/3G4h7RuQcL+6XcAMxHlmdsSR2KNfeoecoptAdu9l
         i3PkC8rkK8kfhrNlIdNLycoWovMofn8lsRyuz9nsoH++B56T/u/FMhzHZvkS2DeyJPhs
         LFKisQTwJgZLXSM3HbFX2jrR/JVgmJjDCwUNF0/A++B+86kvbsWSF83ZXeTU0SRbXWna
         mAZEJVkV6HR8bJkIw8YKCNGGksbXFXkyUFRi5KvT6mM6r4O/lVfFMgM9iJmvahSk8q4G
         gCBY42VF/CwWv88Oj1ZLBzzXWUk3KjVL1ogscOFGCgFzbK7IfxD0sRno8PCEDZ1t/Znm
         etCw==
X-Forwarded-Encrypted: i=1; AJvYcCUjQ6xDiH1RKK7j6CvWdPfQUF1yQ7lfanbgk2kAg00InEpblvZoi1hgU3I1w6tlASfZ7Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDsxxjwPieQSNWOnwHVWW7uQEoBrnD2hCWuJqmU1R1jDtJ8sJB
	h97+b8Fcv+lMS3JjyYc8b1+dtjYZo3q9iASAwYznStOXyV1ee1XgKV4EPjgp/usNCLfwhrkdIrx
	NrIwfzm61fHN3MxsmEtBAKhoXHHzsVU3dnyvr
X-Google-Smtp-Source: AGHT+IHQOMo347a6zYohDR79O85jMWIxjxFPQ6AUAZc5+R+zHxd/Y3AKeAPgzu5rSE9m00wex3yeLnDqHQMXJ+x2qVA=
X-Received: by 2002:a17:90a:cb8b:b0:2d8:be3b:4785 with SMTP id
 98e67ed59e1d1-2e8f11beea7mr9539636a91.6.1730391473687; Thu, 31 Oct 2024
 09:17:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028195343.2104-1-rabbelkin@mail.ru> <20241028195343.2104-2-rabbelkin@mail.ru>
 <f4c533a8-0d5e-476a-96cb-e76b67a4d62c@linux.dev>
In-Reply-To: <f4c533a8-0d5e-476a-96cb-e76b67a4d62c@linux.dev>
From: Florent Revest <revest@chromium.org>
Date: Thu, 31 Oct 2024 17:17:42 +0100
Message-ID: <CABRcYm+fR0qRk1FS8edB0zNFtg+GXt3vp025HU4eq-vCR52rRg@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: fix %p% runtime check in bpf_bprintf_prepare
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Ilya Shchipletsov <rabbelkin@mail.ru>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Nikita Marushkin <hfggklm@gmail.com>, lvc-project@linuxtesting.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Florent Revest <revest@chromium.org>

On Tue, Oct 29, 2024 at 7:18=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 10/28/24 12:53 PM, Ilya Shchipletsov wrote:
> > Fuzzing reports a warning in format_decode()
> >
> > Please remove unsupported %=EF=BF=BD in format string
> > WARNING: CPU: 0 PID: 5091 at lib/vsprintf.c:2680 format_decode+0x1193/0=
x1bb0 lib/vsprintf.c:2680
> > Modules linked in:
> > CPU: 0 PID: 5091 Comm: syz-executor879 Not tainted 6.10.0-rc1-syzkaller=
-00021-ge0cce98fe279 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 04/02/2024
> > RIP: 0010:format_decode+0x1193/0x1bb0 lib/vsprintf.c:2680
> > Call Trace:
> >   <TASK>
> >   bstr_printf+0x137/0x1210 lib/vsprintf.c:3253
> >   ____bpf_trace_printk kernel/trace/bpf_trace.c:390 [inline]
> >   bpf_trace_printk+0x1a1/0x230 kernel/trace/bpf_trace.c:375
> >   bpf_prog_21da1b68f62e1237+0x36/0x41
> >   bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
> >   __bpf_prog_run include/linux/filter.h:691 [inline]
> >   bpf_prog_run include/linux/filter.h:698 [inline]
> >   bpf_test_run+0x40b/0x910 net/bpf/test_run.c:425
> >   bpf_prog_test_run_skb+0xafa/0x13a0 net/bpf/test_run.c:1066
> >   bpf_prog_test_run+0x33c/0x3b0 kernel/bpf/syscall.c:4291
> >   __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5705
> >   __do_sys_bpf kernel/bpf/syscall.c:5794 [inline]
> >   __se_sys_bpf kernel/bpf/syscall.c:5792 [inline]
> >   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5792
> >   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > The problem occurs when trying to pass %p% at the end of format string,
> > which would result in skipping last % and passing invalid format string
> > down to format_decode() that would cause warning because of invalid
> > character after %.
> >
> > Fix issue by advancing pointer only if next char is format modifier.
> > If next char is null/space/punct, then just accept formatting as is,
> > without advancing the pointer.
> >
> > Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> >
> > Reported-by: syzbot+e2c932aec5c8a6e1d31c@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3De2c932aec5c8a6e1d31c
> > Fixes: 48cac3f4a96d ("bpf: Implement formatted output helpers with bstr=
_printf")
> > Co-developed-by: Nikita Marushkin <hfggklm@gmail.com>
> > Signed-off-by: Nikita Marushkin <hfggklm@gmail.com>
> > Signed-off-by: Ilya Shchipletsov <rabbelkin@mail.ru>
>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>

