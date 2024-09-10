Return-Path: <bpf+bounces-39484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA428973DB8
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 18:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 627C4287E37
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 16:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6CC1A0B1A;
	Tue, 10 Sep 2024 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muZULz8h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ACE1755C
	for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 16:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725987019; cv=none; b=Xck/CefmIsyOpmhjKUeP03H0L4gpv8kNpMX8Fqe8A3xlGivtGh1mPz6Lyj+eQgURzVJdBdUyE2wNummlasss6VUZC+StCUO3mlgbh2oRQVC86421Mvf98LoZzvqGnU62Pn6++/KQqvbREnwF8g5tXaCgk4NcGvZR7TiEUrAsHzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725987019; c=relaxed/simple;
	bh=c7t024PgeN7gkge8kn5x8zfDtzM4Uft0+SfIptbevig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fus1KH0iKhKA4qE20rG0I+2DIRnnTGBPKFbtRT+BFYxx+ZKDauvtdjA9wI7WkcjEw+OBavgme9LACujR7A523FZugv1v9Z1cfKf8VidAbU654wX2C0OlffxklQB1Y3Tgi17gU6R2DStufvNizdyQuJDHZU5Wq2PhKw9RMom2ZAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=muZULz8h; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-718f28f77f4so951590b3a.1
        for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 09:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725987017; x=1726591817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvpo0mZSQm60y6SR0A4vHyLf3g2SPJ7H4f/ISe2Ssxk=;
        b=muZULz8hzVacoEkVIt+ERnMXoFnVlOz1iO1G8LQ3tXjzv6RwYfpblRO6xISaPXK/pE
         GKjhbIW8YOSUiwnQ2kQ8aLyd6KqPeeaNRat9QPykNEaEBbS3ykH82LEpDsuXsd4+L0VW
         9pmjdcXbs7FNTjsXp+RlLwIUYghWbiuAADqiZcFtm6hiEFlchn7DAmaGpF7FnswLp97a
         uiQNTyNivr0iNew8Tz0v2ak/Gpjqtr5yAPR5RBKVZupN14PzL5EmTiUwCpQvW/eo0ULf
         9qE9NOkN04HOyN9D8yPRLM3c5d3Iq5i5PpN95U9odTz2bZI7fdpRPkodTEZLP/KKEXFB
         qVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725987017; x=1726591817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dvpo0mZSQm60y6SR0A4vHyLf3g2SPJ7H4f/ISe2Ssxk=;
        b=S+F22uOgn9DjBXZH95uCnGSIi9LDsxvxlD3/NyNc+8l+iENmcnI+5pS0cRRAbMUy4S
         4pTqEbJ5B73xzfJND0j2X1/IpLefQ12ARjwwXbSHmhbbytEAsoDLcwA4enTlK6RgLeui
         giPO7a7YAmRmDUXjecjfXuc3lHq1hJdxY6QS6dF+1XmfWQH3bLLcuQ6fOaeHGVdUr0A5
         +cPXOGkTlAjVmnyO41FwruOo30Hae0QJXxYS0ZE3hFesskkMH/wd5qBDQPK6P3qg0T5K
         FdcskumpgixcygUFb4cascagJ+cdIXgL8LAi/Zn0vRu5LZyXCljRzURBTUn5DCEyGBWh
         Fpbw==
X-Gm-Message-State: AOJu0YyfZxt+KSgZs68Vq6r24JUN54KN3xjP+gApCMFuNqwojTekfKBz
	TJzO1OA7/7ECRht8V4rmP3l953PxQi/KWGm62X2iUM8w7XPqz/W0YZMckcCB5QAVDpLRE5xJGE2
	SA+RshrIXwY86LKrUxGioi4jmMYc=
X-Google-Smtp-Source: AGHT+IGdXUrBi+Pcpdh3JCuZOOdWoXPjq0vbFUlh3a4Q+ie/8R/xyifO06osbQpseEn2zCQ7CpfsWmp+yQktxl9gDu0=
X-Received: by 2002:a05:6a20:d526:b0:1cc:df27:54e8 with SMTP id
 adf61e73a8af0-1cf62932ffcmr586057637.0.1725987016590; Tue, 10 Sep 2024
 09:50:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910034306.3122378-1-yonghong.song@linux.dev>
 <CAEf4BzbsYn-b7YiKZ0MPW9_VLzDq38Jv8UkocfMLVje_SAmENA@mail.gmail.com>
 <CAEf4BzZC3FyP06p-H8JhQVJqOTRfjLSfNpHBZn3hN2WRfypDsw@mail.gmail.com> <84f2c314-980c-4e01-bcaa-dafb62a934f3@linux.dev>
In-Reply-To: <84f2c314-980c-4e01-bcaa-dafb62a934f3@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 10 Sep 2024 09:50:04 -0700
Message-ID: <CAEf4BzahXi9t+Y883iCTDrAkcr2DEy0he-NW+jg9yT3TXH6NUA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Use fake pt_regs when doing bpf syscall
 tracepoint tracing
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Salvatore Benedetto <salvabenedetto@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 8:25=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 9/9/24 10:42 PM, Andrii Nakryiko wrote:
> > On Mon, Sep 9, 2024 at 10:34=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >> On Mon, Sep 9, 2024 at 8:43=E2=80=AFPM Yonghong Song <yonghong.song@li=
nux.dev> wrote:
> >>> Salvatore Benedetto reported an issue that when doing syscall tracepo=
int
> >>> tracing the kernel stack is empty. For example, using the following
> >>> command line
> >>>    bpftrace -e 'tracepoint:syscalls:sys_enter_read { print("Kernel St=
ack\n"); print(kstack()); }'
> >>> the output will be
> >>> =3D=3D=3D
> >>>    Kernel Stack
> >>> =3D=3D=3D
> >>>
> >>> Further analysis shows that pt_regs used for bpf syscall tracepoint
> >>> tracing is from the one constructed during user->kernel transition.
> >>> The call stack looks like
> >>>    perf_syscall_enter+0x88/0x7c0
> >>>    trace_sys_enter+0x41/0x80
> >>>    syscall_trace_enter+0x100/0x160
> >>>    do_syscall_64+0x38/0xf0
> >>>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >>>
> >>> The ip address stored in pt_regs is from user space hence no kernel
> >>> stack is printed.
> >>>
> >>> To fix the issue, we need to use kernel address from pt_regs.
> >>> In kernel repo, there are already a few cases like this. For example,
> >>> in kernel/trace/bpf_trace.c, several perf_fetch_caller_regs(fake_regs=
_ptr)
> >>> instances are used to supply ip address or use ip address to construc=
t
> >>> call stack.
> >>>
> >>> The patch follows the above example by using a fake pt_regs.
> >>> The pt_regs is stored in local stack since the syscall tracepoint
> >>> tracing is in process context and there are no possibility that
> >>> different concurrent syscall tracepoint tracing could mess up with ea=
ch
> >>> other. This is similar to a perf_fetch_caller_regs() use case in
> >>> kernel/trace/trace_event_perf.c with function perf_ftrace_function_ca=
ll()
> >>> where a local pt_regs is used.
> >>>
> >>> With this patch, for the above bpftrace script, I got the following o=
utput
> >>> =3D=3D=3D
> >>>    Kernel Stack
> >>>
> >>>          syscall_trace_enter+407
> >>>          syscall_trace_enter+407
> >>>          do_syscall_64+74
> >>>          entry_SYSCALL_64_after_hwframe+75
> >>> =3D=3D=3D
> >>>
> >>> Reported-by: Salvatore Benedetto <salvabenedetto@meta.com>
> >>> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> >>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> >>> ---
> >>>   kernel/trace/trace_syscalls.c | 5 ++++-
> >>>   1 file changed, 4 insertions(+), 1 deletion(-)
> >>>
> >> Note, we need to solve the same for perf_call_bpf_exit().
> >>
> >> pw-bot: cr
> >>
> > BTW, we lived with this bug for years, so I suggest basing your fix on
> > top of bpf-next/master, no bpf/master, which will give people a bit of
> > time to validate that the fix works as expected and doesn't produce
> > any undesirable side effects, before this makes it into the final
> > Linux release.
>
> Yes, I did. See I indeed use 'bpf-next' in subject above.

Huh, strange, I actually tried to apply your patch to bpf-next/master
and it didn't apply cleanly. It did apply to bpf/master, though, which
is why I assumed you based it off of bpf/master.

>
> >
> >>> diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_sysca=
lls.c
> >>> index 9c581d6da843..063f51952d49 100644
> >>> --- a/kernel/trace/trace_syscalls.c
> >>> +++ b/kernel/trace/trace_syscalls.c
> >>> @@ -559,12 +559,15 @@ static int perf_call_bpf_enter(struct trace_eve=
nt_call *call, struct pt_regs *re
> >> let's also drop struct pt_regs * argument into
> >> perf_call_bpf_{enter,exit}(), they are not actually used anymore
> >>
> >>>                  int syscall_nr;
> >>>                  unsigned long args[SYSCALL_DEFINE_MAXARGS];
> >>>          } __aligned(8) param;
> >>> +       struct pt_regs fake_regs;
> >>>          int i;
> >>>
> >>>          BUILD_BUG_ON(sizeof(param.ent) < sizeof(void *));
> >>>
> >>>          /* bpf prog requires 'regs' to be the first member in the ct=
x (a.k.a. &param) */
> >>> -       *(struct pt_regs **)&param =3D regs;
> >>> +       memset(&fake_regs, 0, sizeof(fake_regs));
> >> sizeof(struct pt_regs) =3D=3D 168 on x86-64, and on arm64 it's a whopp=
ing
> >> 336 bytes, so these memset(0) calls are not free for sure.
> >>
> >> But we don't need to do this unnecessary work all the time.
> >>
> >> I initially was going to suggest to use get_bpf_raw_tp_regs() from
> >> kernel/trace/bpf_trace.c to get a temporary pt_regs that was already
> >> memset(0) and used to initialize these minimal "fake regs".
> >>
> >> But, it turns out we don't need to do even that. Note
> >> perf_trace_buf_alloc(), it has `struct pt_regs **` second argument,
> >> and if you pass a valid pointer there, it will return "fake regs"
> >> struct to be used. We already use that functionality in
> >> perf_trace_##call in include/trace/perf.h (i.e., non-syscall
> >> tracepoints), so this seems to be a perfect fit.
> >>
> >>> +       perf_fetch_caller_regs(&fake_regs);
> >>> +       *(struct pt_regs **)&param =3D &fake_regs;
> >>>          param.syscall_nr =3D rec->nr;
> >>>          for (i =3D 0; i < sys_data->nb_args; i++)
> >>>                  param.args[i] =3D rec->args[i];
> >>> --
> >>> 2.43.5
> >>>

