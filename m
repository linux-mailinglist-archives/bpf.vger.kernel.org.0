Return-Path: <bpf+bounces-60336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AB9AD5B43
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 17:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1429F17B028
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 15:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B2B1DFE20;
	Wed, 11 Jun 2025 15:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTnfmwYh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD0A1BEF77;
	Wed, 11 Jun 2025 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749657530; cv=none; b=G4qDvXUz1J1RMT21D7RoVmazpMlPzKCXcUxLbP5B0OyUfHLo2GRQlAwjsy1cv8eeC3KP4D0/LP6idXkUp8lE+bjU4l6Z1E0Lr7Xx9kEA3NBRvNpopaxAV71Guoktw0e97HSc4MYT9yqdjfwkXQp53crcKOkyWeAoptlBvxT+X2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749657530; c=relaxed/simple;
	bh=+/YRa0wYW2XQycJf9G9n8i2I2YEgSld3UVEyRw8s7iQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nr0ZNmiSOz+Tf5U72pBXM+SPnz8LrvEm188qHst6MfjBwbU9NNyxMOR/T3qlfb4zTtrM3kE6IO2aHS07n5uj+1L/bEa1sXc9z3jk8WgJa8xMLJkh3KvBIHiubMDRR4BOKZm5QxLqk1auyAlr+2il4+2ikzZCOdwQ8Hc9b5JUY7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTnfmwYh; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a35c894313so35165f8f.2;
        Wed, 11 Jun 2025 08:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749657527; x=1750262327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqvSrdo/59RzPZSWugP8CS5Vm3+/F5kf6kB2XqXUuHc=;
        b=GTnfmwYhbNLsuC7C2Gja6CQ6ichzUVuDWjJoJLuElXdahHidQy6L+5M63OX7CY5aro
         rLYZ6X+DyNlf73cpPQ4gGbW7OxX8JmccKuxiGpqjYxtF7GX6umeh7rrfL5KspxP9xzkN
         6N6lmstgzNDy/oUQMmGZYNOqsqBdhQ3YGZ2JypVEqUFAWTP/Ux10dLuLQA+M6i2vDIUL
         XOUg/u6UxTghog/tpnxLseFt5jTJ/O8W+lL2F9I4CMJ49kAolY/2fcSOtRIy8S9pgW5j
         wN2N01gO0TgJ2ZeW3YuY18SjWowcRcgdw+zprAQkG6vmKRwNOxGo6CzIyI172kmQBrxT
         X3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749657527; x=1750262327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aqvSrdo/59RzPZSWugP8CS5Vm3+/F5kf6kB2XqXUuHc=;
        b=fKwnIK5pZ8yzr1bqCMLXtKPY6FEkU56nRuHDvPq4ezXuk12yVnSiVW3m2y3AVuTLUh
         hCI7mA6NELs84Q6FyUij+9Yd8rLXKKQOv19j5qVywHa19hz8X7Lb+Ul+XT54hu9imORo
         amt1SlnlpQ0Y7WFrOcvq+AehGq4WMwTd3fDzBO8cQ/dCWLvn3eFyjY2Gniaqf0B6AYgi
         pCKlCE1TZCoujCeOSxgxk5dspUD7x11P13jpyTYjT6DrIz+G3/JuM1mr/rsjTf5i6wsX
         76HI8B4+FVkWYd8eWmIO/BdS9xcQlF0CUtlWX2v71NBkZ5OtTNw0CzqEyyFuTlB0PLhb
         P7eA==
X-Forwarded-Encrypted: i=1; AJvYcCV89SyM1EyTbcrd/CTmGI7v+ARAWBbZbcZgYvyJR+oKgxIybUJSlMajzNlrPkoiX6GAIMFAdzto@vger.kernel.org, AJvYcCVJq7JB/pCXHOW/s+8Rfv9pC4TUgqDDE1PP6Fa/b/Lqst8oTvUTO1vRQNmXiCls+dmYfQ17apWbau2bliuy@vger.kernel.org, AJvYcCWCSqmJ3A/POoRjLze2i/M0nJBurI12MHPJyeZC5eHxf69zUDDJn6un9aufAR/zKXVznLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxolEfA/DyP3BiHaLNnuM9KOj0t4DUS35C2J9YHUz0LINSnf5vD
	P0HsasEm6RbY2oWcB2bhHq26d+Q/qMciWT01B81FvdIDVrC+yxDKLrI2NavNaoTSfmNyp4Hyosr
	3uMjB8Hlmew7D9POjU4XplDR8sxOiH6Q=
X-Gm-Gg: ASbGncsk53OPduf8/9bYlGAFOKQR4uRwfdTKxPbqjtv51ObuCbullyDNOa4n89SSdlV
	d9nWXx+ToFRIRhzxqfkbqzPomikDXYt1xgDIMOHizJ5ioaEmDw//Ba5qCYMpSkbmGXDsD6SdbXM
	oeYZ7lg8nFPdujZEcAw34ELAnzlyjN91VFqimHYpqoUKN3eKeMK5333cMrCD4ghFVYz6odnNgg
X-Google-Smtp-Source: AGHT+IHSt+/THqHxhgz827jHJko2BKpI8+bIByOu4nG7vw0qyRbYM4ZzDDA4culSWmIwZsXkz9mnMVne/6J48SeBfws=
X-Received: by 2002:a05:6000:2c11:b0:3a5:2694:d75f with SMTP id
 ffacd0b85a97d-3a558a27355mr3302299f8f.52.1749657527027; Wed, 11 Jun 2025
 08:58:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611-rcu-fix-task_cls_state-v2-1-1a7fc248232a@posteo.net>
In-Reply-To: <20250611-rcu-fix-task_cls_state-v2-1-1a7fc248232a@posteo.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Jun 2025 08:58:35 -0700
X-Gm-Features: AX0GCFtxfPHbu8laTtgXcPRa4SllbCu8OCyANjPGc6H3zzfi2xMc1cA263W5PUA
Message-ID: <CAADnVQJu3fYTfdRTWxeB5hraqe3_Esm7cgKfO38nxodknABeHg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] net: Fix RCU usage in task_cls_state() for
 BPF programs
To: Charalampos Mitrodimas <charmitro@posteo.net>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Feng Yang <yangfeng@kylinos.cn>, Tejun Heo <tj@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, syzbot+b4169a1cfb945d2ed0ec@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 2:04=E2=80=AFAM Charalampos Mitrodimas
<charmitro@posteo.net> wrote:
>
> The commit ee971630f20f ("bpf: Allow some trace helpers for all prog
> types") made bpf_get_cgroup_classid_curr helper available to all BPF
> program types, not just networking programs.
>
> This helper calls __task_get_classid() which internally calls
> task_cls_state() requiring rcu_read_lock_bh_held(). This works in
> networking/tc context where RCU BH is held, but triggers an RCU
> warning when called from other contexts like BPF syscall programs that
> run under rcu_read_lock_trace():
>
>   WARNING: suspicious RCU usage
>   6.15.0-rc4-syzkaller-g079e5c56a5c4 #0 Not tainted
>   -----------------------------
>   net/core/netclassid_cgroup.c:24 suspicious rcu_dereference_check() usag=
e!
>
> Fix this by also accepting rcu_read_lock_trace_held() as a valid RCU
> context in the task_cls_state() function. This is safe because BPF
> programs are non-sleepable and task_cls_state() is only doing an RCU
> dereference to get the classid.
>
> Reported-by: syzbot+b4169a1cfb945d2ed0ec@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Db4169a1cfb945d2ed0ec
> Fixes: ee971630f20f ("bpf: Allow some trace helpers for all prog types")
> Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
> ---
> Changes in v2:
> - Fix RCU usage in task_cls_state() instead of BPF helper
> - Add rcu_read_lock_trace_held() check to accept trace RCU as valdi
>   context
> - Drop the approach of using task_cls_classid() which has in_interrupt()
>   check
> - Link to v1: https://lore.kernel.org/r/20250608-rcu-fix-task_cls_state-v=
1-1-2a2025b4603b@posteo.net
> ---
>  net/core/netclassid_cgroup.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/netclassid_cgroup.c b/net/core/netclassid_cgroup.c
> index d22f0919821e931fbdedf5a8a7a2998d59d73978..df86f82d747ac40e99597d6f2=
d921e8cc2834e64 100644
> --- a/net/core/netclassid_cgroup.c
> +++ b/net/core/netclassid_cgroup.c
> @@ -21,7 +21,8 @@ static inline struct cgroup_cls_state *css_cls_state(st=
ruct cgroup_subsys_state
>  struct cgroup_cls_state *task_cls_state(struct task_struct *p)
>  {
>         return css_cls_state(task_css_check(p, net_cls_cgrp_id,
> -                                           rcu_read_lock_bh_held()));
> +                                           rcu_read_lock_bh_held() ||
> +                                           rcu_read_lock_trace_held()));

This is incomplete. It only addresses one particular syzbot report.
It needs to include rcu_read_lock_held() as well.

pw-bot: cr

