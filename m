Return-Path: <bpf+bounces-46531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00759EB8B9
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 18:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E643283544
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 17:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7A7204698;
	Tue, 10 Dec 2024 17:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTMsIiC9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB5C19F436;
	Tue, 10 Dec 2024 17:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733853155; cv=none; b=roWeEVFM+NeMNiUUp5HpEr04J1G95CGrWz+5pe4ULtoG9BpOkSj33TNXZyqtkEeEiFMAvaYx0HnyR93LAdiVsEBtiH3peA/RQHT9FTBeif/eLqewzRun7F+IonXsOx5Hpu+B7QDgxDCqaA+DwlCTpoybs+RsdHsrO4cMGq2gETY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733853155; c=relaxed/simple;
	bh=AfHqTxfppYa4zmqsSk3YfhyXd9srhWABrl/8mQKprZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z8fKTcEsdz+58bEtpXlRwtshYH21XZvzSRU1rSIZdt7fioAdU3tMLEAFrjWfV1xH2NKlUcx8Cg9nqzFSYO0yNxtd86S13eFkF/Y/oAmUmig0I3zqOjuyQenlofC6h948bg+Kb5uxYgWwBdHFkkHLKxNgzrFuILn1OkbIKW5BVEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTMsIiC9; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7fd51285746so1696044a12.3;
        Tue, 10 Dec 2024 09:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733853153; x=1734457953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUnM3sY1ce/bdNNMF99TPKIzNqRwIqpuFiC6o4V0bfk=;
        b=cTMsIiC9EOBi/gwnNtEAysQSDFJybG0xn4M2lykW8q13KIUOQORzR05YYMXohAg9bb
         uEO7+R47K0LXVttOvXh52Yx+cqPhG6tppKyqb0llGOg6YVeLpiCkr626VI70zO2EW5yj
         uVY1Flvvog1cyWjfC7e2kCIy33SBd6EPS9DXGwSPyk+UCynpYuH0bB82ZcpjPosKXsaO
         qN4BESB+X/cvYObpCHcDouSi0aGJ5wqst2ukDkuNvum4XuwVhJzcpzRdCN1iqRxv4suk
         r6iU1CWMgFzM2QlAWxDTricdkb+WU9WMyHFF6b8XD5kFSPJ5ZnJprWXywlY1zD2Rd9Jo
         tA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733853153; x=1734457953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUnM3sY1ce/bdNNMF99TPKIzNqRwIqpuFiC6o4V0bfk=;
        b=AlzKJLNpRpKID4Z+RIII1yJ6i6GbmPeRxqIBsjV6/F8QQVnfFw70/ZvVM+VByePeNC
         BPXdsoQFEMivkrFeB4xuiYvgmBSC1ZcX49iG3miDrl84HyxSieSxjWYo8QSfVu5EDCCh
         8F2l8JENZylLtXlb5+O4GPTbNc2lASFfhSIwFc1dDt3YjnmjDSYNZdvwwJX6nKdOW8Ws
         +wHm7uQ447ih3DZAJz/641bs8FgkjJrxFFrpuRJt0Aytx8Ltlq5xf9P8O64/tdHr0sq4
         0cRA6s11tTjvzi1OEZiG7MZTP67goP8drjNtTuimm0asyJb00loDIkc2x+7sz03d2f2K
         ky0A==
X-Forwarded-Encrypted: i=1; AJvYcCUHZ0lM0Bj91nX+zOEKY+aRALLXMwOZtnkazA3Hzsk2YC4Ng5d/vxMqYoTS+KZ3jQ9ZpZKH4Rb8tzN90NfRavAwsHr4@vger.kernel.org, AJvYcCVW8GMnN6GEtS6DsHQ6tQACAWK6GRYAHh5/yD3uAWk81MGyP3rFQlaYVtAk+lcUg6EvXW+p1rDOO5tKwf1+@vger.kernel.org, AJvYcCW6UjC9CZkz8woUmhkUdzPJ8J57o/6Y0tP1+0zDY0Zlof1HO9ONuGINgMFzKfrDUAzdCSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVjc2XHbNudreHUu6NRx22d+amznlbZnZOox2x9y3TizDLZ27A
	i8UXt5nvn6AeHn1VUxMeTMpwrvrhcvcSukmJGX02AlNAC5fyyJChNw8inqW8Xs+0/ojNXN5eITt
	CV4xUD26+vu3/PLZ9shIRyNzHCvh18j8e
X-Gm-Gg: ASbGncv7nNmL/un9RVI43Rxk0nEZV6912ZsmR5vpxBZ62UYoyqQ9IjKtQwn0Bh2JYPs
	RgQDV1Q47sA2xIhKtOnykoMycYTNEKMzhmvw5BCwODgra1tPAmK4=
X-Google-Smtp-Source: AGHT+IEfxxJW+7Lq0duKX7dP656zkxMXlKv4FFyC5HB3obQeznxck94Z3DfV+j+jRkhCcbtUZQ8IuCMLuUf2l2LySyM=
X-Received: by 2002:a17:90b:3143:b0:2ee:3cc1:793a with SMTP id
 98e67ed59e1d1-2ef6aad12d2mr25630092a91.29.1733853153081; Tue, 10 Dec 2024
 09:52:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210-bpf-fix-uprobe-uaf-v3-1-ce50ae2a2f0f@google.com>
In-Reply-To: <20241210-bpf-fix-uprobe-uaf-v3-1-ce50ae2a2f0f@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 10 Dec 2024 09:52:21 -0800
Message-ID: <CAEf4BzacBUdttSi9d0Ecud7XEgdMrzsbZa0wmpFceLRwjQ-=dg@mail.gmail.com>
Subject: Re: [PATCH bpf v3] bpf: Fix theoretical prog_array UAF in __uprobe_perf_func()
To: Jann Horn <jannh@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Delyan Kratunov <delyank@fb.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 7:34=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> Currently, the pointer stored in call->prog_array is loaded in
> __uprobe_perf_func(), with no RCU annotation and no immediately visible
> RCU protection, so it looks as if the loaded pointer can immediately be
> dangling.
> Later, bpf_prog_run_array_uprobe() starts a RCU-trace read-side critical
> section, but this is too late. It then uses rcu_dereference_check(), but
> this use of rcu_dereference_check() does not actually dereference anythin=
g.
>
> Fix it by aligning the semantics to bpf_prog_run_array(): Let the caller
> provide rcu_read_lock_trace() protection and then load call->prog_array
> with rcu_dereference_check().
>
> This issue seems to be theoretical: I don't know of any way to reach this
> code without having handle_swbp() further up the stack, which is already
> holding a rcu_read_lock_trace() lock, so where we take
> rcu_read_lock_trace() in __uprobe_perf_func()/bpf_prog_run_array_uprobe()
> doesn't actually have any effect.
>
> Fixes: 8c7dcb84e3b7 ("bpf: implement sleepable uprobes by chaining gps")
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> Changes in v3:
> - align semantics with bpf_prog_run_array()
> - correct commit message: the issue is theoretical
> - remove stable CC
> - Link to v2: https://lore.kernel.org/r/20241206-bpf-fix-uprobe-uaf-v2-1-=
4c75c54fe424@google.com
>
> Changes in v2:
> - remove diff chunk in patch notes that confuses git
> - Link to v1: https://lore.kernel.org/r/20241206-bpf-fix-uprobe-uaf-v1-1-=
6869c8a17258@google.com
> ---
>  include/linux/bpf.h         | 11 +++--------
>  kernel/trace/trace_uprobe.c |  6 +++++-
>  2 files changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index eaee2a819f4c150a34a7b1075584711609682e4c..7fe5cf181511d543b1b100028=
db94ebb2a44da5d 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2193,26 +2193,22 @@ bpf_prog_run_array(const struct bpf_prog_array *a=
rray,
>   * rcu-protected dynamically sized maps.
>   */
>  static __always_inline u32
> -bpf_prog_run_array_uprobe(const struct bpf_prog_array __rcu *array_rcu,
> +bpf_prog_run_array_uprobe(const struct bpf_prog_array *array,
>                           const void *ctx, bpf_prog_run_fn run_prog)
>  {
>         const struct bpf_prog_array_item *item;
>         const struct bpf_prog *prog;
> -       const struct bpf_prog_array *array;
>         struct bpf_run_ctx *old_run_ctx;
>         struct bpf_trace_run_ctx run_ctx;
>         u32 ret =3D 1;
>
>         might_fault();
> +       RCU_LOCKDEP_WARN(!rcu_read_lock_trace_held(), "no rcu lock held")=
;
>
> -       rcu_read_lock_trace();
>         migrate_disable();
>
>         run_ctx.is_uprobe =3D true;
>
> -       array =3D rcu_dereference_check(array_rcu, rcu_read_lock_trace_he=
ld());
> -       if (unlikely(!array))
> -               goto out;

I think we should keep this unlikely(NULL) check, bpf_prog_run_array()
has it and see bpf_prog_array_valid() comment below

pw-bot: cr


>         old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
>         item =3D &array->items[0];
>         while ((prog =3D READ_ONCE(item->prog))) {
> @@ -2227,9 +2223,8 @@ bpf_prog_run_array_uprobe(const struct bpf_prog_arr=
ay __rcu *array_rcu,
>                         rcu_read_unlock();
>         }
>         bpf_reset_run_ctx(old_run_ctx);
> -out:
> +
>         migrate_enable();
> -       rcu_read_unlock_trace();
>         return ret;
>  }
>
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index fed382b7881b82ee3c334ea77860cce77581a74d..4875e7f5de3db249af34c539c=
079fbedd38f4107 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -1402,9 +1402,13 @@ static void __uprobe_perf_func(struct trace_uprobe=
 *tu,
>
>  #ifdef CONFIG_BPF_EVENTS
>         if (bpf_prog_array_valid(call)) {

bpf_prog_array_valid() explicitly calls out that it's just an
opportunistic check and bpf_prog_run_array*() should double check for
NULL

> +               const struct bpf_prog_array *array;
>                 u32 ret;
>
> -               ret =3D bpf_prog_run_array_uprobe(call->prog_array, regs,=
 bpf_prog_run);
> +               rcu_read_lock_trace();
> +               array =3D rcu_dereference_check(call->prog_array, rcu_rea=
d_lock_trace_held());
> +               ret =3D bpf_prog_run_array_uprobe(array, regs, bpf_prog_r=
un);
> +               rcu_read_unlock_trace();
>                 if (!ret)
>                         return;
>         }
>
> ---
> base-commit: 509df676c2d79c985ec2eaa3e3a3bbe557645861
> change-id: 20241206-bpf-fix-uprobe-uaf-53d928bab3d0
>
> --
> Jann Horn <jannh@google.com>
>

