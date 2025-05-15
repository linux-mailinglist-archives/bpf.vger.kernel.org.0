Return-Path: <bpf+bounces-58334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 991D7AB8DA0
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 19:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24B90168F8A
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 17:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E76258CED;
	Thu, 15 May 2025 17:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNaRDQHJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E758B1DDD1;
	Thu, 15 May 2025 17:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747329786; cv=none; b=To4Wi/EClFzPibPnt8aVzmTtY4sJpPNnr7hWjUnhX7Uk2t99nG5F9YSZP2uQf+0CnvrDRw4MtJ2qEz19v5vUT/qjP+weXV+Tu7K8bJaDvgiKmwZcdRsQcHeRcKdPgLrGpgqBUTqX0YRPkqPP2yL0IqpG6M9SGm2MUWPCWcDN2S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747329786; c=relaxed/simple;
	bh=fOFezqkmxEnnFkyHkpcNC7nimpg8wel6A4pWdT4HtKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JqoGgP2g6MQN56et2p823mfL3L3fnSRHHd7vTtS1fCCvYRTGZap0fr6Fmr+ZcyyARMPnVBAHfO+MKDFEYMIu8rFBSK6OIc+omLqv6Oy71XFdOFY+edmN0wzyHc0VRowDblwIZy9zaLr2aIrS6LOJfpES+FZXzzvNaeqAtec0Z6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNaRDQHJ; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b0b2d1f2845so861520a12.3;
        Thu, 15 May 2025 10:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747329784; x=1747934584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POmpsww8fxP51+rFGGUrmySpy0YfhbsPMfnLTURJaa8=;
        b=cNaRDQHJbIhgvHiaYo6mfeEVa8T/Tzw4O02iDY1vZVQ6b7EOx6WnmE/+raNbqqNVGX
         sbAGk5gTHrhYW25j8xpkoiDdMLPtelNxpQ+9yLy9CCrfP+9FT1j5gB/JYUwaXUfMlWfY
         jNfnRZsOgF4BFrUj2qOXZ1tt0WZEe8q4iHcZdFAY19QNRasw6NfEO6tmotk0Pr1VlFEx
         3fj3MUigf8emGBb14o3iLKM/feRpgj7kLAe8n4j+AERNaOt6G/uNM3k4lHmnEML3uL10
         pRPBk+1ipgTwsdjm2CUzftsQ/QbIqxUrLDLieLYYgHctHYAMXyTgM0v38UdUteQ58+9W
         Thgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747329784; x=1747934584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POmpsww8fxP51+rFGGUrmySpy0YfhbsPMfnLTURJaa8=;
        b=Ul4eZV7pvng1f+JESw1k1JUmutAUJnEXMKfjv7MHe5Sn0cbpWlq5QE71ZWJ0CbL+Fg
         0XQ1xYQ5G8vmFGLEXrxOS/Vb06fWqkqJP74Nk1sqSJtXDwxfO+pM9rkRHm3Y9YN/CQke
         j80d61pMlIOD2wGTuG2toPjxklymwUO6HJi7vq7taazjz9DVMqZnVzchNpp/gVmoc6Er
         pSF+hPGKLppD5nYz5PH8j2CdWLnzHdq5LhJGsukdkcC8U5DhjA9H+P4dFYHgYpIrCGsH
         2mfSbvMriDSC06tnlcA2uTm9tDcsFDtOsHzaNPG+nuaVUj1TM+yCgglVIPZ/8/jE2+U9
         zlsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUG7cznTTQGuI8H5gP/zBmHY/G3gjWpOlVy6xbBGiRSrdQzsWG6uobjUbpy+CmS1CakDqoyt6swXWzbuQ60mE3wENxB@vger.kernel.org, AJvYcCVSwsN1KYn6AaaqPetrCOf1K90h5tsgztSzPwFhFUtobP6TS6zEoJBkiGFlch9OpjI3EhlvEWGDpRcSIVpi@vger.kernel.org, AJvYcCWEo1M9Gs8tH12sH0MbPBEe0x1NWCncSfMaQo61XRR0Ui03kpk1k7wHonZzJDaq2Sialos=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsvonfvCXjYYNxZKCFBpdwwXJ/8l1Rldh/Xc/+MT5AymrUoAoF
	uGC6AHlO4NhBwTOvkYgh7fKhFUfANnhePduSv1ox49G6rA6XgjZf7z1wgiVNNhwucbs/WfdTx16
	7t2AOwS64XhIgWffdxmNCjkFL/BJ4DuCUhlV7
X-Gm-Gg: ASbGncst+VyXOCidTnIU2X2/pgmlnwgKxv1yI1MHt/1jM/m0nw6+kv6q2+LPIYZ8HmD
	lwaUD8/LDgtmzSIsZVq68G96gWW3ELvNUmYYkrWsP99WkbgLyDwB/myjSltdszaFXVHsqhVoC4b
	A81jKr/bUk6r2Edi6MlYPSGetYDS6TOYQJhDT7jdTXJZg7H8dSDqpy7uSxjk0=
X-Google-Smtp-Source: AGHT+IHVykVjRMnBxJN+2i4pCXlgj1iHKicUGWbEr9t1tvrZiWCMZGYzwueQ0Lb5vWesMXQKdVHNYeUcFHKH6x1tlmk=
X-Received: by 2002:a17:90a:d005:b0:2f8:34df:5652 with SMTP id
 98e67ed59e1d1-30e7d563768mr303365a91.21.1747329784151; Thu, 15 May 2025
 10:23:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515121121.2332905-1-jolsa@kernel.org> <20250515121121.2332905-9-jolsa@kernel.org>
In-Reply-To: <20250515121121.2332905-9-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 May 2025 10:22:51 -0700
X-Gm-Features: AX0GCFtMXjsJ5mA4xD0VBoPILnMrP3GRnTnUwkOVLt0FdeO-C1FkuEUxLuueMDk
Message-ID: <CAEf4BzYbZ3f9E8mSwY+oppSwU-Luh=5=GBjLKetVA2TOFT+dWQ@mail.gmail.com>
Subject: Re: [PATCHv2 perf/core 08/22] uprobes/x86: Add mapping for optimized
 uprobe trampolines
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 5:13=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support to add special mapping for user space trampoline with
> following functions:
>
>   uprobe_trampoline_get - find or add uprobe_trampoline
>   uprobe_trampoline_put - remove or destroy uprobe_trampoline
>
> The user space trampoline is exported as arch specific user space special
> mapping through tramp_mapping, which is initialized in following changes
> with new uprobe syscall.
>
> The uprobe trampoline needs to be callable/reachable from the probed addr=
ess,
> so while searching for available address we use is_reachable_by_call func=
tion
> to decide if the uprobe trampoline is callable from the probe address.
>
> All uprobe_trampoline objects are stored in uprobes_state object and are
> cleaned up when the process mm_struct goes down. Adding new arch hooks
> for that, because this change is x86_64 specific.
>
> Locking is provided by callers in following changes.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/kernel/uprobes.c | 115 ++++++++++++++++++++++++++++++++++++++
>  include/linux/uprobes.h   |   6 ++
>  kernel/events/uprobes.c   |  10 ++++
>  kernel/fork.c             |   1 +
>  4 files changed, 132 insertions(+)
>

[...]

> +static unsigned long find_nearest_page(unsigned long vaddr)
> +{
> +       struct vm_unmapped_area_info info =3D {
> +               .length     =3D PAGE_SIZE,
> +               .align_mask =3D ~PAGE_MASK,
> +               .flags      =3D VM_UNMAPPED_AREA_TOPDOWN,
> +               .low_limit  =3D 0,

would this, technically, allow to allocate memory at NULL (0x0000)
address? should this start at PAGE_SIZE?

> +               .high_limit =3D ULONG_MAX,
> +       };
> +       unsigned long limit, call_end =3D vaddr + 5;
> +
> +       if (!check_add_overflow(call_end, INT_MIN, &limit))
> +               info.low_limit =3D limit;
> +       if (!check_add_overflow(call_end, INT_MAX, &limit))
> +               info.high_limit =3D limit;
> +       return vm_unmapped_area(&info);
> +}

[...]

