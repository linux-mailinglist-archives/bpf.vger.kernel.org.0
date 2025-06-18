Return-Path: <bpf+bounces-60983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FC1ADF577
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 20:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3103AA7F7
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 18:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF4D3085C7;
	Wed, 18 Jun 2025 18:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EarxRzCM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AC53085A0;
	Wed, 18 Jun 2025 18:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750270025; cv=none; b=ABfdWOjHI4wi5jSc4J/me/ojB4LscYFNTHUYrVFkktmbaMTAHCSOgqM18xfMCa3CM+cT9J1ynpOr/Ft/pf0NM4odZE43G4xo2if8ZP8aaEG4pMRrJGtaNLZkqVMAd4CM2RvseRF+o83s7QOaONYhPEroxpyvSdSi9lQjC/oqZ7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750270025; c=relaxed/simple;
	bh=Qdw8zeY3GA+djfTuXJjKxV5sQMptidtAP6C+KmtPsoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IvU5/4KCM7JxhhkSv72axJ6zFbyQtKPgS8YF4yaTTHabIfdy8sDILMUi14uIpqpPZX9gRUAcnMeqTPGKVY7zt+08B9PjjZzI8DcpUIp7c+dCmJ67H2jPcCarAt5t8FRCe3fgqdaxIgBjccnuRF0MFDuzMY9MagSrvaLDidgWmyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EarxRzCM; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so91588195e9.1;
        Wed, 18 Jun 2025 11:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750270021; x=1750874821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p71W0Av8dwoo16CmtTw6P1WrIYm7Y1T0/pktKY7S1zM=;
        b=EarxRzCMKF9jaslqLR7D9Ssur0tn1zvTzXTmX8qLJ3FQJn2pjGEYMBeSnpXCI6nozi
         O13bSfTfOSSYKmWPZKWNzmlys8RLEVPbaNmN6iWrQZegHClp02nQIGRlGCYUAWZAE8Ip
         qQ2ARMp//PXIwPPK4TNBLQOmYKnEe5exaZ1Zsk17CkXJTDCt0nRQJEW2qM8XSR1ajoo0
         t5WKscnv4TzY44eDnCYaZFJ4M2VmCSyBjUpF63RFbQgswE4KIP/o+2bk4v1xl+6i0WAW
         vC8nHkteYxHBB7VJ3Kor1JinWMzmkNjoRkj5+tV99Q+TwjyECNZ65cYNn2bEKEf4Yw5X
         qgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750270021; x=1750874821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p71W0Av8dwoo16CmtTw6P1WrIYm7Y1T0/pktKY7S1zM=;
        b=xA4ySHcXEA7Ct5mFq4N/FZw+sWlEi0mcpGXTOalbBRePTptmYliIg7dBzXYcyH1cvG
         aS64hkZ8RkAzjTc3WbTzYq9mUTOk0MWSl8Vcr5Pre2cm3O6h9HD3sQCZAW/598biv5GP
         NrAfri3nxlN6ytfzqU5mXelixQJ0xqsgonbXXuzXGsNO9gLRUoTPW3oHbSBMy80wLJNn
         8T+tDXAaY4JQGAeeG9H3+CveEIKSqm6LCgrjT+mFxHMQFQdo/Ej7Iiw3a3WweJgDyiZQ
         fqrf6PHcOFubZxBONfqn8YTD36POhj685LtchrxvNNj+q1/zPd3uMqWkFabuyyXAI751
         1DNA==
X-Forwarded-Encrypted: i=1; AJvYcCUZIjS7hkMRjzaj7AlxSQ6GFnYwKqYuB3E7I69yFnyDZlJ0ausOvVjTvOK7/0n3bvs/Syg=@vger.kernel.org, AJvYcCX01VQwePQj/0yvzp1iQ6Q3QevUHWKF5/bFby/LR1nd5aJSz0HL/WXVqSddHdhJxZJHYck40y0VljBETuvA@vger.kernel.org
X-Gm-Message-State: AOJu0YxKCAl3VPuOqZp/UUA/DZFRZ8SnK/w/NQclEWYwOkmVEohGQjZ5
	lBYZEWKT3oLEWL52C02ngBqD6fyjDmw/TiIPNRXsmqP+1+nTozJV22e7ixun8aE+b1WoapvH+t9
	JrTwaIhN6/y5BxLOP/jtv8zqZkkZePB4=
X-Gm-Gg: ASbGncviKgVYw8ptX+33I1uGjESOMhKPN/YDAH0KX5d4cadQaLSvwP4/HJrczI4IhyF
	NJivz88eEFM4TdBY/gvJHQoxuCKxhQ86VxCLSfC/wAxumKqp5VsK3E99Z27QUJgpS7+ffPbVc1N
	pkp/1TPJrXMFaIZWJ+StxOhqQ/UG0ceZb++AH8/zUhBir+65vbLMbtIEB9vCyl0iWIsH2BAf0r
X-Google-Smtp-Source: AGHT+IGPS8K8GNyX/6UnB1uEzod3Lc04vSYuWv3a920aB/M8fGU/7SmDEump+pqDrZX201HGtQCKEUux5Z9HHbsgVwE=
X-Received: by 2002:a05:600c:354e:b0:43c:ea1a:720c with SMTP id
 5b1f17b1804b1-4533e55a9bdmr179234465e9.18.1750270020832; Wed, 18 Jun 2025
 11:07:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618085609.1876111-1-dongml2@chinatelecom.cn>
In-Reply-To: <20250618085609.1876111-1-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 18 Jun 2025 11:06:49 -0700
X-Gm-Features: Ac12FXxkMsOnLi2mWHKK7oQEiU7wa6zwiA2ga7-aQYehp6EJVio6ShEFqhJOFGE
Message-ID: <CAADnVQ+5HOFu=bwQekwZOmOe+FKk26UJW=S1wZY3bSye_7C23w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: make update_prog_stats always_inline
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Menglong Dong <dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 1:58=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> The function update_prog_stats() will be called in the bpf trampoline.
> Make it always_inline to reduce the overhead.

What kind of difference did you measure ?

> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  kernel/bpf/trampoline.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index c4b1a98ff726..134bcfd00b15 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -911,8 +911,8 @@ static u64 notrace __bpf_prog_enter_recur(struct bpf_=
prog *prog, struct bpf_tram
>         return bpf_prog_start_time();
>  }
>
> -static void notrace update_prog_stats(struct bpf_prog *prog,
> -                                     u64 start)
> +static __always_inline void notrace update_prog_stats(struct bpf_prog *p=
rog,
> +                                                     u64 start)
>  {

How about the following instead:
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index c4b1a98ff726..728bb2845f41 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -911,28 +911,23 @@ static u64 notrace __bpf_prog_enter_recur(struct
bpf_prog *prog, struct bpf_tram
     return bpf_prog_start_time();
 }

-static void notrace update_prog_stats(struct bpf_prog *prog,
-                      u64 start)
+static noinline void notrace __update_prog_stats(struct bpf_prog *prog,
+                         u64 start)
 {
     struct bpf_prog_stats *stats;
-
-    if (static_branch_unlikely(&bpf_stats_enabled_key) &&
-        /* static_key could be enabled in __bpf_prog_enter*
-         * and disabled in __bpf_prog_exit*.
-         * And vice versa.
-         * Hence check that 'start' is valid.
-         */
-        start > NO_START_TIME) {
-        u64 duration =3D sched_clock() - start;
-        unsigned long flags;
-
-        stats =3D this_cpu_ptr(prog->stats);
-        flags =3D u64_stats_update_begin_irqsave(&stats->syncp);
-        u64_stats_inc(&stats->cnt);
-        u64_stats_add(&stats->nsecs, duration);
-        u64_stats_update_end_irqrestore(&stats->syncp, flags);
-    }
+    u64 duration =3D sched_clock() - start;
+    unsigned long flags;
+
+    stats =3D this_cpu_ptr(prog->stats);
+    flags =3D u64_stats_update_begin_irqsave(&stats->syncp);
+    u64_stats_inc(&stats->cnt);
+    u64_stats_add(&stats->nsecs, duration);
+    u64_stats_update_end_irqrestore(&stats->syncp, flags);
 }
+#define update_prog_stats(prog, start) \
+    if (static_branch_unlikely(&bpf_stats_enabled_key) && \
+        start > NO_START_TIME) \
+        __update_prog_stats(prog, start)

 static void notrace __bpf_prog_exit_recur(struct bpf_prog *prog, u64 start=
,
                       struct bpf_tramp_run_ctx *run_ctx)


Maybe
if (start > NO_START_TIME)
should stay within __update_prog_stats().

pls run a few experiments.

