Return-Path: <bpf+bounces-69274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C39C6B937EE
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 00:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B899019066E3
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 22:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C5F2FB98D;
	Mon, 22 Sep 2025 22:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nq/FQxzu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20D619A288
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 22:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758580748; cv=none; b=QWP3ne/Dig6jX0AHph9XseMWyvFjA42Vm01vG+oujkCT8yoe8vPIKh5gikp5oIoQpyNJGD40MdvXzkk2AySmabmlgvDEpJc6e6NNB9PhugdNzQszYahoTP1CNV1S1GMo+OGqK0b8JzFxx9HZeKAscEjLx4PNR6kZUfzGApielnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758580748; c=relaxed/simple;
	bh=FsBsmxfLMJqVVW0VQXb6jjSJe4OaHrZWZOJ4uZZLIBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bo//8KKvxfP02GiTheXk7P/phNFQ4+4c524AbtRmYKKrz2XxpF2qy/vF7zDK+QolK3mawf6dxpCQf24zgc7IWlBK6KR1lZTstq75QTyDH3FMiCIZLhoFuvylnzgZ0sBX6p4OdnXr8CLxeQycBeAPbIqBELSltLnvFA1JT/XAI0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nq/FQxzu; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32eb45ab7a0so4679991a91.0
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 15:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758580746; x=1759185546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+s5oZ3yBKJeDuiH/x5f/bGcLal1TcIyLLUBiRn2ranc=;
        b=nq/FQxzu22db5XnLmJnfliX9xTA3KJB+dnvViZWmASPEmwm8qSeE1lQ+I3kARqCZHz
         HYXldbpxuGgqO9d9IueW2jcOGIL6D3AKVujFqxW4lxYhz1bN0t5FwOcKFM3swMFv/Hf8
         JunaiEVkC4YqCu80VpwIG2hLvdZVGIxnFLO3QLRMcBjEWC5LjKFEz8JLEuEc2rhkzzMe
         nRhnditsCJagoS59K34Pi3REWP+eZ+2qSmG4xNP1igBOk60I4DMrii3vOLe6jRnBMqAp
         f6jjacUc31+j8uZbPUoQmakvSDyC05P/IZCyWtIiqyZ3VQOuxBadxt6gbEB0GmJ2smx9
         iz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758580746; x=1759185546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+s5oZ3yBKJeDuiH/x5f/bGcLal1TcIyLLUBiRn2ranc=;
        b=TNPrXRI3OLaPsI+beGKWSLtoByxAaMVztj26L8GB0XlNgKhJEvwE1Ao/ZAAqbggG7j
         Y5zd8uR1+AYvQwAq0YVHHE041awFk6PvYw7bNCBk6YKlvaoemQfpZ4E3tcrkGpJ7kKET
         h60pesGHtQ60IiSoF8HLRRcc+BxqMqcCq7Zyjghuj0B58ryyu+yuVogsytPau6hhbPBi
         2fgiaPPpBZ92LVq03gJA7QCyXy3+Zd2H0iQeLmuA1eSmRYam7YrbGvvxJDwLKncL4bW6
         MnB5qZFiBOKNlEEHh+2obyU8NehQ+OR3B5ObjgZJzB9u0x3a7sYfwZHmNag5yPjiZSG3
         xyAA==
X-Forwarded-Encrypted: i=1; AJvYcCWBl02EYqkw3Gzrgh3Pqj4ZG2gk2ilypNvlUg7Fth1pcm6Up6YPa3nYm7gADxNAMTtw/0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww/u/3FS5JtCEWfrXWdwFgD4OTFLVdZays04cAjZ3NwVMb54qR
	87Cjrk51SZ6mGNCfGU6nSzDOOeRFZUmRJbQ346rtjpQErTPr24F0SdNJ30LgnR7NLOnO1MEeA/T
	4UOfYWtcMx64z4H+4tX8+3SUXkV6WDJ8=
X-Gm-Gg: ASbGncv1w37AOf2zcDMhvxXuxHTruvfuETYzlzA96LSJxGY3qolPZXRQPsLyyPX6UMm
	IntHdwVuvql5CYBsbRRG28L/MKexqrE12yiIx7tI3VoPGCsRPJqCKa0uxoPA9OHSuKNiNwdix17
	dgJ10LV+a5IdPxT92FhD9mLBGq67gARN98hbyjQPPyg72EHjgVlspqEpcy2JxZjngWR5cqDX6Br
	0gmDFU3ZfWStTLqra+8Nlo=
X-Google-Smtp-Source: AGHT+IHkT+ZMltMRX0T37yaa83vWDp3M2bG5LvDGqkQichW4IqC6OvHQsQsKXYixsS1STnKtpjxvjjcpPoD4ihlj7Mg=
X-Received: by 2002:a17:90b:2fcb:b0:32e:5646:d448 with SMTP id
 98e67ed59e1d1-332a95bd2abmr592010a91.21.1758580746034; Mon, 22 Sep 2025
 15:39:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912233409.74900-1-contact@arnaud-lcm.com>
 <CAEf4BzZ-ovqXqLJ5oJ95n9prFnXsLOkO1UvdycUcON77=Akv-w@mail.gmail.com> <60553783-125a-4628-bd17-a7c40841d0ae@arnaud-lcm.com>
In-Reply-To: <60553783-125a-4628-bd17-a7c40841d0ae@arnaud-lcm.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 22 Sep 2025 15:38:51 -0700
X-Gm-Features: AS18NWDn28zltALLQs8oa-d2CjxK2qomkUDc0-AL3-bDjaHRyji-NvS5KjLsAhA
Message-ID: <CAEf4BzbBR7GBnWCA4E-RuEkbYJ7bUEfmJ5nd0g8G_bV0MG5tAA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 1/3] bpf: refactor max_depth computation in bpf_get_stack()
To: "Lecomte, Arnaud" <contact@arnaud-lcm.com>
Cc: alexei.starovoitov@gmail.com, yonghong.song@linux.dev, song@kernel.org, 
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, sdf@fomichev.me, 
	syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 12:32=E2=80=AFPM Lecomte, Arnaud <contact@arnaud-lc=
m.com> wrote:
>
>
> On 19/09/2025 23:50, Andrii Nakryiko wrote:
>
> On Fri, Sep 12, 2025 at 4:34=E2=80=AFPM Arnaud Lecomte <contact@arnaud-lc=
m.com> wrote:
>
> A new helper function stack_map_calculate_max_depth() that
> computes the max depth for a stackmap.
>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Acked-by: Song Liu <song@kernel.org>
> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
> ---
> Changes in v2:
>  - Removed the checking 'map_size % map_elem_size' from
>    stack_map_calculate_max_depth
>  - Changed stack_map_calculate_max_depth params name to be more generic
>
> Changes in v3:
>  - Changed map size param to size in max depth helper
>
> Changes in v4:
>  - Fixed indentation in max depth helper for args
>
> Changes in v5:
>  - Bound back trace_nr to num_elem in __bpf_get_stack
>  - Make a copy of sysctl_perf_event_max_stack
>    in stack_map_calculate_max_depth
>
> Changes in v6:
>  - Restrained max_depth computation only when required
>  - Additional cleanup from Song in __bpf_get_stack
>
> Changes in v7:
>  - Removed additional cleanup from v6
>
> Changes in v9:
>  - Fixed incorrect removal of num_elem in get stack
>
> Link to v8: https://lore.kernel.org/all/20250905134625.26531-1-contact@ar=
naud-lcm.com/
> ---
> ---
>  kernel/bpf/stackmap.c | 39 +++++++++++++++++++++++++++------------
>  1 file changed, 27 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 3615c06b7dfa..a794e04f5ae9 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -42,6 +42,28 @@ static inline int stack_map_data_size(struct bpf_map *=
map)
>                 sizeof(struct bpf_stack_build_id) : sizeof(u64);
>  }
>
> +/**
> + * stack_map_calculate_max_depth - Calculate maximum allowed stack trace=
 depth
> + * @size:  Size of the buffer/map value in bytes
> + * @elem_size:  Size of each stack trace element
> + * @flags:  BPF stack trace flags (BPF_F_USER_STACK, BPF_F_USER_BUILD_ID=
, ...)
> + *
> + * Return: Maximum number of stack trace entries that can be safely stor=
ed
> + */
> +static u32 stack_map_calculate_max_depth(u32 size, u32 elem_size, u64 fl=
ags)
> +{
> +       u32 skip =3D flags & BPF_F_SKIP_FIELD_MASK;
> +       u32 max_depth;
> +       u32 curr_sysctl_max_stack =3D READ_ONCE(sysctl_perf_event_max_sta=
ck);
> +
> +       max_depth =3D size / elem_size;
> +       max_depth +=3D skip;
> +       if (max_depth > curr_sysctl_max_stack)
> +               return curr_sysctl_max_stack;
> +
> +       return max_depth;
> +}
> +
>  static int prealloc_elems_and_freelist(struct bpf_stack_map *smap)
>  {
>         u64 elem_size =3D sizeof(struct stack_map_bucket) +
> @@ -300,20 +322,17 @@ static long __bpf_get_stackid(struct bpf_map *map,
>  BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, ma=
p,
>            u64, flags)
>  {
> -       u32 max_depth =3D map->value_size / stack_map_data_size(map);
> -       u32 skip =3D flags & BPF_F_SKIP_FIELD_MASK;
> +       u32 elem_size =3D stack_map_data_size(map);
>         bool user =3D flags & BPF_F_USER_STACK;
>         struct perf_callchain_entry *trace;
>         bool kernel =3D !user;
> +       u32 max_depth;
>
>         if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
>                                BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID=
)))
>                 return -EINVAL;
>
> -       max_depth +=3D skip;
> -       if (max_depth > sysctl_perf_event_max_stack)
> -               max_depth =3D sysctl_perf_event_max_stack;
> -
> +       max_depth =3D stack_map_calculate_max_depth(map->value_size, elem=
_size, flags);
>         trace =3D get_perf_callchain(regs, 0, kernel, user, max_depth,
>                                    false, false);
>
> @@ -406,7 +425,7 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
>                             struct perf_callchain_entry *trace_in,
>                             void *buf, u32 size, u64 flags, bool may_faul=
t)
>  {
> -       u32 trace_nr, copy_len, elem_size, num_elem, max_depth;
> +       u32 trace_nr, copy_len, elem_size, max_depth;
>         bool user_build_id =3D flags & BPF_F_USER_BUILD_ID;
>         bool crosstask =3D task && task !=3D current;
>         u32 skip =3D flags & BPF_F_SKIP_FIELD_MASK;
> @@ -438,10 +457,7 @@ static long __bpf_get_stack(struct pt_regs *regs, st=
ruct task_struct *task,
>                 goto clear;
>         }
>
> -       num_elem =3D size / elem_size;
> -       max_depth =3D num_elem + skip;
> -       if (sysctl_perf_event_max_stack < max_depth)
> -               max_depth =3D sysctl_perf_event_max_stack;
> +       max_depth =3D stack_map_calculate_max_depth(size, elem_size, flag=
s);
>
>         if (may_fault)
>                 rcu_read_lock(); /* need RCU for perf's callchain below *=
/
> @@ -461,7 +477,6 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
>         }
>
>         trace_nr =3D trace->nr - skip;
> -       trace_nr =3D (trace_nr <=3D num_elem) ? trace_nr : num_elem;
>
> Is this also part of refactoring? If yes, it deserves a mention on why
> it's ok to just drop this.
>
> pw-bot: cr
>
> Yes it is also part of the refactoring as stack_map_calculate_max_depth n=
ow already curtains the trace->nr to the max possible number of elements, t=
here is no need to do the clamping twice. This is valid assuming that get_p=
erf_callchain and get_callchain_entry_for_task correctly set this limit.
>

What about that third case:

if (trace_in)
    trace =3D trace_in;

Did you analyze if that gets its trace->nr set properly as well (as of
this patch, without taking into account changes in the follow up
patches). Because it looks like this removal belongs in patch #2, no?

In either case, all the other changes in this patch except the removal
of this line is refactoring and as far as I can tell don't change the
logic. This line removal does (potentially) change the logic, so it
would be good to do it separately, explaining why you think it's the
correct thing to do.



>         copy_len =3D trace_nr * elem_size;
>
>         ips =3D trace->ip + skip;
> --
> 2.43.0
>
> Thanks,
> Arnaud

