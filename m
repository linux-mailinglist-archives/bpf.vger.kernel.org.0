Return-Path: <bpf+bounces-46330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9F39E7B8A
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 23:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2C2418835BD
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 22:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4181EE010;
	Fri,  6 Dec 2024 22:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4AKS1TX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7AD22C6C1;
	Fri,  6 Dec 2024 22:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733523345; cv=none; b=CBQqCwsAyulCL22Zc8o5E9dETCRromNm3sYMhdkSuBxfQXP2w/G1LWi1QTBzbOQ6gy2yv9klAYvc+5tkAk9lmUSVb9lt+CEQHD0sW7wIJ46o3rIRdb2SQXC3TmmTrvpOm6iw8+NRMGTOJr4489bfX4NWQoL5FVutbwfJI/dGs6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733523345; c=relaxed/simple;
	bh=pJNboDSrtAtEPyh4PwQKsGQAa4ood0d1G62be8rKVfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EO4XSSP/ttP899IroiTQWFJBzTVBBE7JfV36bYRTkQjkoq4v4aQaJoOqHDg9N5mjUKpgDiiuGP2NlftTCJBRZjEyZ6wRlJsLUZ7461itaoAisLJhCOZfPhNgLchYEfNxdlzds+rREwjf/JIfQoSN1LMiW7rfPlmQUZuMTuBFjwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4AKS1TX; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ee8aa26415so2215235a91.1;
        Fri, 06 Dec 2024 14:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733523342; x=1734128142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8e7YM4si5YOg3jr9H5Y9Db0TtNXgw9XX76Nlg+F5uY=;
        b=N4AKS1TXrdLgn3Q0Fw8l9MSS4o+G4V8VE2+/gj/LmEV1hKM/ErdnNOALwxoi8F95Wx
         ZoNaYGA33YNDD/g87f8lRwiPrmETJ3KBaAh54UMnr+Ry8g+Nywpctb1l6W9ljm2xow15
         OkWLgfaXaNhgCkTEGHDLP0D7GvcnBtfxbWLu1c9JlSeap68SSILuiHD+bJ4OL8JvJ7UW
         zXSY5lAxmVSeVG+pPFfodpNdmf6wJHLOb6dq9xoe8iJgmEoFpPruC4DsFe68oHHrYS9N
         XHhKfHQbB6vAtuA46CZEuEzBEEgekrefH4DzSqgJf1jZBOIUwHxf99sgdPC/qYKMizX4
         3UfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733523342; x=1734128142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8e7YM4si5YOg3jr9H5Y9Db0TtNXgw9XX76Nlg+F5uY=;
        b=UE7HnWXmok3uIFOdQRoUx4ww63IPwKQow7ib4hx6iYld0hziN4hH+3qj4hFAFXDvXz
         EsNH9DHK0UhJO55DaFTEeBSxWwBFM2bHBZp9KyiT9X3ETfqDhrIrAq6jwz8Mi4CMTKGQ
         cQvOkxCKd9X/bZ72xl+r/oH50l5hHwbvBajLXCUHqEHPviis87wHp6Jefgj1jYc8WZ0S
         sOrK4/splEN/RpHq66GRZ6EuSApsx2Z0qrMb/abaMoVubFsY1LlCYWwmY1tQEP71R4Kq
         xRZPBcjq1YwppcUAMwphkJKFhTYrFXU5o2T7JbusTdQBEimgnKGZlrMeK/HWPSQ8gbR1
         nywQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4Rx4sYQn4WIx59SV7gXU43JXSdtkvA3fLzftr7Yp5zUK9CJA7wiR/4BEtQfiPw/YKJ7A=@vger.kernel.org, AJvYcCVC4ME9b7k/Z45ZeAP5OZYoBDThY5/979HXH/lTD6E0Et9KRo1n1yOW/D+idtP2bPxDtHuNBq3F@vger.kernel.org, AJvYcCVKe1VAOQ967NKG8zQ3TW4DewNUeFwq+4KkF0x1x8/WoGx/4KU0Mrg7xCyA6AzCjw5iodJJaqCe0iCTEwrm@vger.kernel.org, AJvYcCXJ+Y1ymv3KUs9XUv86z8rk2V6SS9nUaj9CUmXo0UlaqIuy8GQyqwhkgyMASDqtuPjuy/fmxzcoqyGQWB4r4n/DXYOW@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/tM4TR+k5FP9Wn/oZ+c2+NF5HAQ5YEwXQX8iHRkcembOdad4U
	BF/Lcx9ho4KF1apr+0o4zAtWZCNjqr8dSN1N+mp5GYRnaYHpKypmnWGKGFOHcL49pBrtEHblp39
	EUQ7FMy9lVDnTiizsHybWKK3lumo=
X-Gm-Gg: ASbGnctkHiBLKl8DVVW0a8zvLfnC4WqbgPFlpe/J2RPKmkB/vDdOX2tNcSTUxcGdH5T
	Nuns7zHf9YLmBAseIMzVC3fNnZRDCMivMqkKuYlT96S/1SL4=
X-Google-Smtp-Source: AGHT+IFQDKX0xPfjy+1GV5DC2GEOe3O925IO0wivqwkD37VEAblMUzZqPiXYvt8JvyDgF5rSVBQzPfDgL3+j53X/Nbw=
X-Received: by 2002:a17:90b:5405:b0:2ee:c291:765a with SMTP id
 98e67ed59e1d1-2ef6955fa47mr6403143a91.8.1733523342534; Fri, 06 Dec 2024
 14:15:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206-bpf-fix-uprobe-uaf-v2-1-4c75c54fe424@google.com>
In-Reply-To: <20241206-bpf-fix-uprobe-uaf-v2-1-4c75c54fe424@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Dec 2024 14:15:30 -0800
Message-ID: <CAEf4BzYxaKd8Gv5g8PBY6zaQukYKSjjtaSgYMjJxL-PZ0dLrbQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: Fix prog_array UAF in __uprobe_perf_func()
To: Jann Horn <jannh@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Delyan Kratunov <delyank@fb.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 12:45=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> Currently, the pointer stored in call->prog_array is loaded in
> __uprobe_perf_func(), with no RCU annotation and no RCU protection, so th=
e
> loaded pointer can immediately be dangling. Later,
> bpf_prog_run_array_uprobe() starts a RCU-trace read-side critical section=
,
> but this is too late. It then uses rcu_dereference_check(), but this use =
of
> rcu_dereference_check() does not actually dereference anything.
>
> It looks like the intention was to pass a pointer to the member
> call->prog_array into bpf_prog_run_array_uprobe() and actually dereferenc=
e
> the pointer in there. Fix the issue by actually doing that.
>
> Fixes: 8c7dcb84e3b7 ("bpf: implement sleepable uprobes by chaining gps")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> To reproduce, in include/linux/bpf.h, patch in a mdelay(10000) directly
> before the might_fault() in bpf_prog_run_array_uprobe() and add an
> include of linux/delay.h.
>
> Build this userspace program:
>
> ```
> $ cat dummy.c
> #include <stdio.h>
> int main(void) {
>   printf("hello world\n");
> }
> $ gcc -o dummy dummy.c
> ```
>
> Then build this BPF program and load it (change the path to point to
> the "dummy" binary you built):
>
> ```
> $ cat bpf-uprobe-kern.c
> #include <linux/bpf.h>
> #include <bpf/bpf_helpers.h>
> #include <bpf/bpf_tracing.h>
> char _license[] SEC("license") =3D "GPL";
>
> SEC("uprobe//home/user/bpf-uprobe-uaf/dummy:main")
> int BPF_UPROBE(main_uprobe) {
>   bpf_printk("main uprobe triggered\n");
>   return 0;
> }
> $ clang -O2 -g -target bpf -c -o bpf-uprobe-kern.o bpf-uprobe-kern.c
> $ sudo bpftool prog loadall bpf-uprobe-kern.o uprobe-test autoattach
> ```
>
> Then run ./dummy in one terminal, and after launching it, run
> `sudo umount uprobe-test` in another terminal. Once the 10-second
> mdelay() is over, a use-after-free should occur, which may or may
> not crash your kernel at the `prog->sleepable` check in
> bpf_prog_run_array_uprobe() depending on your luck.
> ---
> Changes in v2:
> - remove diff chunk in patch notes that confuses git
> - Link to v1: https://lore.kernel.org/r/20241206-bpf-fix-uprobe-uaf-v1-1-=
6869c8a17258@google.com
> ---
>  include/linux/bpf.h         | 4 ++--
>  kernel/trace/trace_uprobe.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>

Looking at how similar in spirit bpf_prog_run_array() is meant to be
used, it seems like it is the caller's responsibility to
RCU-dereference array and keep RCU critical section before calling
into bpf_prog_run_array(). So I wonder if it's best to do this instead
(Gmail will butcher the diff, but it's about the idea):

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index eaee2a819f4c..4b8a9edd3727 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2193,26 +2193,25 @@ bpf_prog_run_array(const struct bpf_prog_array *arr=
ay,
  * rcu-protected dynamically sized maps.
  */
 static __always_inline u32
-bpf_prog_run_array_uprobe(const struct bpf_prog_array __rcu *array_rcu,
+bpf_prog_run_array_uprobe(const struct bpf_prog_array *array,
                          const void *ctx, bpf_prog_run_fn run_prog)
 {
        const struct bpf_prog_array_item *item;
        const struct bpf_prog *prog;
-       const struct bpf_prog_array *array;
        struct bpf_run_ctx *old_run_ctx;
        struct bpf_trace_run_ctx run_ctx;
        u32 ret =3D 1;

        might_fault();
+       RCU_LOCKDEP_WARN(!rcu_read_lock_trace_held(), "no rcu lock held");
+
+       if (unlikely(!array))
+               goto out;

-       rcu_read_lock_trace();
        migrate_disable();

        run_ctx.is_uprobe =3D true;

-       array =3D rcu_dereference_check(array_rcu, rcu_read_lock_trace_held=
());
-       if (unlikely(!array))
-               goto out;
        old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
        item =3D &array->items[0];
        while ((prog =3D READ_ONCE(item->prog))) {
@@ -2229,7 +2228,6 @@ bpf_prog_run_array_uprobe(const struct
bpf_prog_array __rcu *array_rcu,
        bpf_reset_run_ctx(old_run_ctx);
 out:
        migrate_enable();
-       rcu_read_unlock_trace();
        return ret;
 }

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index fed382b7881b..87a2b8fefa90 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1404,7 +1404,9 @@ static void __uprobe_perf_func(struct trace_uprobe *t=
u,
        if (bpf_prog_array_valid(call)) {
                u32 ret;

+               rcu_read_lock_trace();
                ret =3D bpf_prog_run_array_uprobe(call->prog_array,
regs, bpf_prog_run);
+               rcu_read_unlock_trace();
                if (!ret)
                        return;
        }


> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index eaee2a819f4c150a34a7b1075584711609682e4c..00b3c5b197df75a0386233b98=
85b480b2ce72f5f 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2193,7 +2193,7 @@ bpf_prog_run_array(const struct bpf_prog_array *arr=
ay,
>   * rcu-protected dynamically sized maps.
>   */
>  static __always_inline u32
> -bpf_prog_run_array_uprobe(const struct bpf_prog_array __rcu *array_rcu,
> +bpf_prog_run_array_uprobe(struct bpf_prog_array __rcu **array_rcu,
>                           const void *ctx, bpf_prog_run_fn run_prog)
>  {
>         const struct bpf_prog_array_item *item;
> @@ -2210,7 +2210,7 @@ bpf_prog_run_array_uprobe(const struct bpf_prog_arr=
ay __rcu *array_rcu,
>
>         run_ctx.is_uprobe =3D true;
>
> -       array =3D rcu_dereference_check(array_rcu, rcu_read_lock_trace_he=
ld());
> +       array =3D rcu_dereference_check(*array_rcu, rcu_read_lock_trace_h=
eld());
>         if (unlikely(!array))
>                 goto out;
>         old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index fed382b7881b82ee3c334ea77860cce77581a74d..c4eef1eb5ddb3c65205aa9d64=
af1c72d62fab87f 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -1404,7 +1404,7 @@ static void __uprobe_perf_func(struct trace_uprobe =
*tu,
>         if (bpf_prog_array_valid(call)) {
>                 u32 ret;
>
> -               ret =3D bpf_prog_run_array_uprobe(call->prog_array, regs,=
 bpf_prog_run);
> +               ret =3D bpf_prog_run_array_uprobe(&call->prog_array, regs=
, bpf_prog_run);
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
>

