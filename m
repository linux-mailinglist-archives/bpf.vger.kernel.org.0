Return-Path: <bpf+bounces-75510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CACC87775
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 00:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 05C614E3D20
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 23:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289E42ED17C;
	Tue, 25 Nov 2025 23:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfiHuEvc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E292586C2
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 23:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764113544; cv=none; b=QiQdVDj2rxnzqfM9tiPKJPDcYXn8bVEH5wB0Ucss+B5dTZhqaoodNqM1XlTEygcvrxuRuKZZGbKjz2vxRKNtqZYcQcIwL7sZ9RvEsD/f3qte8SqJX2EUdXnnCZ5LGgPmlcDn/2a9DJD2VfWKeZ7eBQD3ArgklvekUVV3I+HO49o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764113544; c=relaxed/simple;
	bh=uixRbDv1kGALghM30hjMsHQ5zIk0iDXcZw9eSeumYZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NMlhTTmzRt8O7K9oNZgrjuM7JWaXiREzPRN2RXBVS9XkoHRf8IsjpaJQL5q41R6qwH8E76OKNlcs5KyXc774UuZSXLFJmz40kYmnyJ6MMIDkDINQGn1HZ9rnMsuxOb1Ajst8TqgGIQezp1SuilGxNjlSAzMrSm9IatONAQOYebc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfiHuEvc; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-341988c720aso5160729a91.3
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 15:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764113542; x=1764718342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPtseTgrU/dQhg5zVqpjcUjeAtrr2+ySKimC4QiGcT0=;
        b=OfiHuEvcPv8XFtTtdaMz69AOIqmojpKKCgvbB2mvt8FFxrjKAbZtZrI4x4COJ8EwZy
         GazLTqqvYtiTl/I02o+jkY/5NCMH/4OaputQz/ptJcKmry+cUS1gJl/KvUWbRh9GdGrZ
         vDqav+vTDpIlEGSKxgbANReFvtqvECM6S562jgfmp+uc3JiS6P3nC/+a5RgEfmfNY21P
         a0Gkf5fIyzWzGF8HZgtJN3hY2kpGYJsVoNq7KH8a2rbGsdqhoM+7McnyLaT3HR47CAaY
         W27ECrKplF9kXmOVzRbRb6IRJi5b+IiABQ9VcQV/KLMc7giv5lYu+/DeziyG+z3Vb3OU
         yIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764113542; x=1764718342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LPtseTgrU/dQhg5zVqpjcUjeAtrr2+ySKimC4QiGcT0=;
        b=TVYGFMwx+pp/eDczcoP2TDygkdrWiyAYIWVJZ6pHGj4fUt6tHOriyj33teffgVTybC
         H80xdBR5/03Hilegks9oaUbBM0yWSvLbEt1eqnNOlRuSVdT83/m0VjEEMArapjKGMTFS
         J/oS6lEDlVHe85SSwWOGuWoX2jZYROO69osyJgAGLWDxTxzfEGbkurWgrSYjqabIORcc
         /0T3GyTjwQfd9XWvVCOa0OPgfJ0RPvtkGGWSQiPxyqk8X+YXIgYSLbNvmSFP7k+85+8M
         Eqrs4lWE2bE3FkVUaJiuIaoebizqLJYUgiF/L33Y1AT9UU/wMe0gew8DoyQH3rLuWGJm
         iDQA==
X-Forwarded-Encrypted: i=1; AJvYcCXAI+Y8MBB/b0hESecb9+8XvRM139LU+Vnqo+5d2ya0DZzaGcf75571BUaG1rco9y+3NPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiOBm2F9qyFUr5vflksHXDW/uUdI357s2bagIf76MrAR2NWFQC
	VUzuzaJh5ns3i+lG/QxWzDKt5u4UiXC4v8XqF1oPxDsHHNqXngX1TXEQhqP+ujfJuaFeH/jS5jg
	D61ihd4GbH0ZGbV5eBJ1qMXDbpjYoFuw=
X-Gm-Gg: ASbGncv5WjdA45NsnzlkzXbxZFfylYuSU9IgDZ62VTqz+dgkZAPxYrJnkB3ZojLfP9D
	NvHV6YbsX5XY0kN6SvnV8J2Bq48uVkFdi2qUzsRPgsczUMk5vBcnNBhhpuTw+aX6Un5CkgsFRcI
	Lyp+9KOOMVd78H6v0FAmajrVpVZ+eomt/FS1OrgP3MKrWK7e+wisEKYwxOXR2IzgpIMbwuBAd2u
	LgWBSPdgGHTGHVYXvVZOWc1p8SoWaZH6Kl/2mOjRI7G8uD3l4D1JMwcM7e1MH6l6nx7oaK8JQV2
	5l34eRiqD1U=
X-Google-Smtp-Source: AGHT+IEsx8zFOOIlNrgCNY0o1v6vGnfF3nJhWnvGuLTzd53z2WsPHkeSzGxVwlaxV98trkWk9lLkSnKDMlJQJJyp+aE=
X-Received: by 2002:a17:90a:dfcd:b0:340:a961:80c9 with SMTP id
 98e67ed59e1d1-34733f495ffmr14624216a91.30.1764113542470; Tue, 25 Nov 2025
 15:32:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118125802.385503-1-chen.dylane@linux.dev> <CAADnVQJ0MDMwrmsUoM1xt_1bMQ2d-Eer7ynD3GVSCuwcpZouLg@mail.gmail.com>
In-Reply-To: <CAADnVQJ0MDMwrmsUoM1xt_1bMQ2d-Eer7ynD3GVSCuwcpZouLg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 25 Nov 2025 15:32:09 -0800
X-Gm-Features: AWmQ_bndgc7_ST1zWTW873HwRXDkzRro_6gEZGhITI5zr86wSXFZ04qdFIa1jBA
Message-ID: <CAEf4BzaXozVSTsC7XZ8Ojkju1szk65nAg8Zc5Y_2OVewKV4heA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add bpf_get_task_cmdline kfunc
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Tao Chen <chen.dylane@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 5:17=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Nov 18, 2025 at 4:58=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> =
wrote:
> >
> > Add the bpf_get_task_cmdline kfunc. One use case is as follows: In
> > production environments, there are often short-lived script tasks execu=
ted,
> > and sometimes these tasks may cause stability issues. It is desirable t=
o
> > detect these script tasks via eBPF. The common approach is to check
> > the process name, but it can be difficult to distinguish specific
> > tasks in some cases. Take the shell as an example: some tasks are
> > started via bash xxx.sh =E2=80=93 their process name is bash, but the s=
cript
> > name of the task can be obtained through the cmdline. Additionally,
> > myabe this is helpful for security auditing purposes.
>
> maybe
>
> >
> > Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> > ---
> >  kernel/bpf/helpers.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 865b0dae38d..7cac17d58d5 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -2685,6 +2685,27 @@ __bpf_kfunc struct task_struct *bpf_task_from_pi=
d(s32 pid)
> >         return p;
> >  }
> >
> > +/*
> > + * bpf_get_task_cmdline - Get the cmdline to a buffer
> > + *
> > + * @task: The task whose cmdline to get.
> > + * @buffer: The buffer to save cmdline info.
> > + * @len: The length of the buffer.
> > + *
> > + * Return: the size of the cmdline field copied. Note that the copy do=
es
> > + * not guarantee an ending NULL byte. A negative error code on failure=
.
> > + */
> > +__bpf_kfunc int bpf_get_task_cmdline(struct task_struct *task, char *b=
uffer, size_t len)
>
> 'size_t len' doesn't make the verifier track the size of the buffer.
> while 'char *buffer' tells the verifier to check that _one_ byte is avail=
able.
> So this is buggy.
>
> In general the kfunc seems useful, but selftest in patch 2 is just bad
>

Besides that mm->arg_lock spinlock (which I don't think matters all
that much for BPF programs), is there anything special in
get_cmdline() that BPF program cannot just implemented? Ultimately,
it's just copying mm->arg_start and mm->env_start zero-separated
strings, no? We have bpf_copy_from_user_task_str() and also
dynptr-based equivalent of it for even more variable-length
flexibility. That should be all one needs, no?

> + ret =3D bpf_get_task_cmdline(task, buf, sizeof(buf));
> + if (ret < 0)
> +    err =3D 1;
> +
> + return 0;
> +}
>
> it's not testing much.
>
> Also you must explain the true motivation for the kfunc.
> "maybe helpful for security" is too vague.
> Do you have a proprietary bpf-lsm that needs it?
> What is the exact use case?
>
> pw-bot: cr

