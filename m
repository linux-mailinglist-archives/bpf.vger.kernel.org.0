Return-Path: <bpf+bounces-67894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F4FB502E3
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 18:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C25391C64CFB
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 16:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0401352FED;
	Tue,  9 Sep 2025 16:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOHsNYKM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E63350D5B;
	Tue,  9 Sep 2025 16:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757436111; cv=none; b=SJYOpkcN9Vr16gHrjtW2VYFJJo9qvrClrVEwsx6ytvdszt5ARHDuODPo5hQapYCWuRi6Lne6TXQze/wfiY2aWCys3xkkO0cJ13x60vhkeVN6qyA1k7K176Zm7jLLmqj31B72hWyYUpvMZHkZf87v+U1VJWMx0ABodjUSfcg/fH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757436111; c=relaxed/simple;
	bh=DCfMUte54i2AHOFKz487gvz/KHi649gUt9FLd5HDDzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f/QChEDCmj/Fu+N3FXXFH+udjW8h9FLt7C4JwC+Y2t9KGDeTerjbiL6DAf0UzsORprhzggsURk+xAfKxEPovs4HBLRHYnI2THbadj9vGavtsLIRYVldl2FjF3LQFR6HbWF3hcHrGenzF/MrbZtjqRfIwXcEe0k3T5iRW8Z1VP1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOHsNYKM; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4ee87cc81eso5285212a12.1;
        Tue, 09 Sep 2025 09:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757436109; x=1758040909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3MwAS9mfPNRhr3pJzl8rJNuLhL2fMOs1cy6gWpgOkk=;
        b=SOHsNYKM8ljwcfnF7fZ5hguYQHfOHIUvkivuJizzBHwxi1eq2LkBV+mQL/LbC7Aclv
         m0fCfex3ssb9SRHft1gNWfWVy6WQYeCKR4Rk7axme3MY/PML/lbeFJPWsToUY98H8jK6
         Nu6kNSzm9IEYJrZFcuE/CibUCyPjNOsAYG5wJH1gupjFab1dzvLe91L4PCuHqoeImh7e
         8Br6wetWDitdp9qaqLdxybwjxKJMHxylESalLYdpD4O0CN8ZaXL3CPvwTjcG7WYMaHDO
         DuRx5VEI04in3MQke1WmT/MX8wCKjVI6H8ZtQ/bNtqQkMQNF4PSgJeeEp7ISFPDy5dDW
         kg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757436109; x=1758040909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3MwAS9mfPNRhr3pJzl8rJNuLhL2fMOs1cy6gWpgOkk=;
        b=odZJKQ5Wol9Z/P2V/I5Tianma5/gjo8kW2jk1Mnkgs1XlIeVFBF3pPfeK0/aj71gJe
         I3457ykQ3wqCxiYNfz/gz2qKveQPv8LXaXCKg7+2P09gtM54n1EWpXqlpoZCA4D51SJ4
         EEEowmw6Cwg99JIteWso1s5cuXadcAZ8Y+7jH78KGEZbIdl6fEi8vMZ4VcLQYEXL6zEY
         tXqeoxVd5FE7QTQLCwH4k7Hebfo43mJEEXtCtp55egqri/nskgS+5XHgygyUk4Ams5Q6
         4FaWgvsc6XfuHrBEeSsWsKJktW7fcqTG7VtDH19kEkbxdjf778b4zMdXNr2XbapopAsR
         j+qA==
X-Forwarded-Encrypted: i=1; AJvYcCVnE5/UNRPr2FJCmRfHaf07i+jICR+u9gUHwi2aHT/bdjVTHNAAzIR33khijl8VPcwYYbU=@vger.kernel.org, AJvYcCX1lzTbsS7ymS0s9XFsTNCeJzS4Bo+QBOUzSKgDxWNE0n0bmqOxY8lUnJ6vyKB/bNLizhBBHGMblmT/Nn9U@vger.kernel.org, AJvYcCXRnVnOftpSpqt4wSfsJ4EIxkNFVd9jTj9hlYKf6JhtV/efluCI3rRCNSdb2E6fqeGWG/VQJtAtjDu49kQjDPJ38obt@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ5NlJxSQu4lQO12vy3nfcmSJZVPdd7dycSQiUvdP9RacMmR0T
	jvEA35vNqYKkZBLT6GmlptMXg8due+J7HSLwgmmJdZLH5BlWp2H1Uxpv250JVCEUsFFrVt3jVgN
	SfA0qC7pzK/0IByF+DpQqJJJGxXeTNaI=
X-Gm-Gg: ASbGnctmZ2g+zuF9CLN/TvJcNAd/5ZkgOocIBnJqS7LLQ0GivjJEl/0ud2/GW9HEJAu
	zLBOCDlG3R6PryEckXBxBxuhD0ij9kLJ7NJWglY9PtrYU880199PgZkYl/u9FmyA60/y2SUz+TS
	ifGX9/N81Epmcjir3zGqBfYWmBoqVsTY1rqVW0PFIWXs7tN3BexLp1PQWstst2ItnI2+OOsQstO
	WjtDa8SBjOHnk4v3CO4DcTqMBWJKxNs8A==
X-Google-Smtp-Source: AGHT+IF7nTcChSNOg3jKmBy4rr6ORW0Cr8Y0KddpqW35AjYb1eEwdirokGehMFj0Fri8ChN9kPGP+dpnz/TXXSO+Muk=
X-Received: by 2002:a17:902:f644:b0:250:5ff5:3f30 with SMTP id
 d9443c01a7336-2516e4b071bmr184042435ad.19.1757436109114; Tue, 09 Sep 2025
 09:41:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909123857.315599-1-jolsa@kernel.org> <20250909123857.315599-2-jolsa@kernel.org>
In-Reply-To: <20250909123857.315599-2-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 9 Sep 2025 12:41:36 -0400
X-Gm-Features: Ac12FXxsABAPnj3WvC0PZYWkwuCM0X0efkpH9gaDyenI80oBWdUI_apAujQyV_U
Message-ID: <CAEf4Bzbw0uvfNgUHQM9iG2YRtnVbgdh_GgFGy4Q7eQiPPJ==dA@mail.gmail.com>
Subject: Re: [PATCHv3 perf/core 1/6] bpf: Allow uprobe program to change
 context registers
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	x86@kernel.org, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 8:39=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Currently uprobe (BPF_PROG_TYPE_KPROBE) program can't write to the
> context registers data. While this makes sense for kprobe attachments,
> for uprobe attachment it might make sense to be able to change user
> space registers to alter application execution.
>
> Since uprobe and kprobe programs share the same type (BPF_PROG_TYPE_KPROB=
E),
> we can't deny write access to context during the program load. We need
> to check on it during program attachment to see if it's going to be
> kprobe or uprobe.
>
> Storing the program's write attempt to context and checking on it
> during the attachment.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/bpf.h      | 1 +
>  kernel/events/core.c     | 4 ++++
>  kernel/trace/bpf_trace.c | 7 +++++--
>  3 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index cc700925b802..404a30cde84e 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1619,6 +1619,7 @@ struct bpf_prog_aux {
>         bool priv_stack_requested;
>         bool changes_pkt_data;
>         bool might_sleep;
> +       bool kprobe_write_ctx;
>         u64 prog_array_member_cnt; /* counts how many times as member of =
prog_array */
>         struct mutex ext_mutex; /* mutex for is_extended and prog_array_m=
ember_cnt */
>         struct bpf_arena *arena;
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 28de3baff792..c3f37b266fc4 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -11238,6 +11238,10 @@ static int __perf_event_set_bpf_prog(struct perf=
_event *event,
>         if (prog->kprobe_override && !is_kprobe)
>                 return -EINVAL;
>
> +       /* Writing to context allowed only for uprobes. */
> +       if (prog->aux->kprobe_write_ctx && !is_uprobe)
> +               return -EINVAL;
> +
>         if (is_tracepoint || is_syscall_tp) {
>                 int off =3D trace_event_get_offsets(event->tp_event);
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 3ae52978cae6..dfb19e773afa 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1521,8 +1521,6 @@ static bool kprobe_prog_is_valid_access(int off, in=
t size, enum bpf_access_type
>  {
>         if (off < 0 || off >=3D sizeof(struct pt_regs))
>                 return false;
> -       if (type !=3D BPF_READ)
> -               return false;
>         if (off % size !=3D 0)
>                 return false;
>         /*
> @@ -1532,6 +1530,7 @@ static bool kprobe_prog_is_valid_access(int off, in=
t size, enum bpf_access_type
>         if (off + size > sizeof(struct pt_regs))
>                 return false;
>
> +       prog->aux->kprobe_write_ctx |=3D type =3D=3D BPF_WRITE;

nit: minor preference for

if (type =3D=3D BPF_WRITE)
    prog->aux->kprobe_write_ctx =3D true;


>         return true;
>  }
>
> @@ -2913,6 +2912,10 @@ int bpf_kprobe_multi_link_attach(const union bpf_a=
ttr *attr, struct bpf_prog *pr
>         if (!is_kprobe_multi(prog))
>                 return -EINVAL;
>
> +       /* Writing to context is not allowed for kprobes. */
> +       if (prog->aux->kprobe_write_ctx)
> +               return -EINVAL;
> +
>         flags =3D attr->link_create.kprobe_multi.flags;
>         if (flags & ~BPF_F_KPROBE_MULTI_RETURN)
>                 return -EINVAL;
> --
> 2.51.0
>

