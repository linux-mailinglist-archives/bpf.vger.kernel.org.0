Return-Path: <bpf+bounces-67599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C214DB46287
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 20:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D4F77ADE63
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 18:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D678277C8B;
	Fri,  5 Sep 2025 18:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FK8X93N+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABEABA42;
	Fri,  5 Sep 2025 18:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757097864; cv=none; b=kQctZ2OXUSQs2cTrQ7/PO+1ZrJrQTuhMKucM15XbmPPhwSKtZuYrEe3JoeeshOPFMP+YrvhDVTqADT0or71MAd9NVTUS2bpmGm/kq9exwRu89/rJFoLnd1MTUo2GgmroYx4bOFqfzMxA1iX7u8VMg26zWzkqO6nUL1EKGwINpyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757097864; c=relaxed/simple;
	bh=ZQNgERA0y4yQFBZbBynTp7jtf+lJH6n/7LZjm0mmzOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8sncBoMb1zmFK4YIK5Q/N233Qnweg783S2T4qsV4XhsxnSugfxUvQpohCNR3N0213HWAairfPaczBZ1rvkNghWUFePZ00bQnrz6SlqswLHx/CI47HmvGKcdf7AqyL6MmEX/3xRkIUOJRgfA7edUVeIh59CurcpTDxBMTFJClXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FK8X93N+; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b4df220483fso1621657a12.2;
        Fri, 05 Sep 2025 11:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757097861; x=1757702661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHnUDrUWgejp0WjuEKozA0AnSyb+zQSK0hfAp9o2nHQ=;
        b=FK8X93N+BvmfBAzp2S4w/cDKHLBxIFsZ5WZypb2tfaE2azTES1HWo4PMxNKTLenzKB
         XMQjqUb1b6xSXm8q7253+Wbn0kj/cFWu89nc32/JxSnXWDW8/rtVeqtgJsIOzNJ18hjv
         +UJtRjcIenJSQFGGElXfQzws0zwS9aD/b4/qx9t3/vSU9vSPuDrX/CeTHiLiDkgRi+mZ
         Oo9dZh/0aGhxRGLaOC6sb63LZ/PYo84aXnKLmLfaKSk48KhnNhadIpvFZJJvhm+0DXiE
         mpMTTnqG8h3WY8E829V6adgnu4O8mp4MwZlXPvpDKns80HVGH4b5gc223mnAh14GhQYz
         VeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757097861; x=1757702661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nHnUDrUWgejp0WjuEKozA0AnSyb+zQSK0hfAp9o2nHQ=;
        b=LSJpc2WUbzJ/kk404NE27appYtkbkgkc6Fnc9Hrq8taj0ZcuCHp0Raa5L9DWSCTjf8
         6J0uTsU/GOsnVdY5kjsMPpXewZqZUo8xlTNwXJJCvWSsz+YhLpIZYsmCX6cgd8KeSb0t
         OGV0xu3rZINRmAzpZyPg6rIyUkOL6ZnmI+iZZ3NjXcTn8CFpouYhD81bf0nsw4+cD0vl
         olLzBU6JYqynWs7ZtmtK9xH1S3qjRLrhJialw00CrJ1NN6tiF5fDzafPdv/qJ+NpPBvs
         q7ZlvXW36DoNXeqglzEXzbmfhSAadBevkNdzkCx2dNYKysi8sb+gu0wVoLpYn4UF50a2
         mZrw==
X-Forwarded-Encrypted: i=1; AJvYcCVC0GG2lLyfRugKEA3TJt6OpB0dTYdnHDLx4S8Q4DWyqoPln9ft6Z1h2OCJceCOeymjBHw=@vger.kernel.org, AJvYcCVrlISdudx+QPYWH2gqmJ/uTpK2B/+wUYDTDdGzeWOknYQLYcRVS6/WwS4+517PzuyLu7bP20HcBkMwCnNOvkOyvGFb@vger.kernel.org, AJvYcCXP683AMAXNmtb5u0fY+rzjMJlG0sCQ4A5US8VfK9hkSOFHJMfABdImYSD3sSmZX0Mw5DJ9gttyugssEY9n@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr2A5Irr4o39G8Ygwd3+SW4TX/61tnGj2haalcbpunSGCsXZCs
	8GxGmKrZOBxAp7CHeCWa19uTIRDYTA82h4ejoWRB2p3YdNEHNWT9TjsNVa+GYVH+HX7y7+JT5fR
	nr0AzBDBAcQ7/1SYU85oGpRvNoHruPIU=
X-Gm-Gg: ASbGncuih//iRMwP2FGy4Zc6Iw/lgG3hkDdq8/NAjGlSgNUic7YWwZRGyLIBJ0KLwX5
	1FStRr+vk89SCdr/mq3aelf4gPU1q2BKcJrYTWqQuF4+xiyyYepsC5OILahiXNu18FX4HkLNbSD
	fxjmFEz54L+rY/TiVU5PpCtv+20ULQxb9fnJj5OzwK0y+AKSVdaXuu5Sprt4f3QhrbDTmqzfmCo
	ABnga0X4I0AiT/s3dIVs7/WJA==
X-Google-Smtp-Source: AGHT+IE44Le1wqETGN6PLQEBfU45g/Rd2TNGJSruccfJLtkK7B0GmqnWICjAUKyeeo3IePvArhM05iwms89uJE+mRBw=
X-Received: by 2002:a17:90b:3a50:b0:329:f110:fe9e with SMTP id
 98e67ed59e1d1-329f110ff48mr20394878a91.17.1757097861274; Fri, 05 Sep 2025
 11:44:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720112133.244369-1-jolsa@kernel.org> <20250720112133.244369-10-jolsa@kernel.org>
 <CAEf4BzaxtW_W1M94e3q0Qw4vM_heHqU7zFeH-fFHOQBwy5+7LQ@mail.gmail.com>
 <aLirakTXlr4p2Z7K@krava> <20250903210112.GS4067720@noisy.programming.kicks-ass.net>
 <CAEf4Bza-5u1j75YjvMdfgsEexv2W8nwikMaOUYpScie6ZWDOsg@mail.gmail.com>
 <aLlGHSgTR5T17dma@krava> <CAG48ez2BBTiDGT1NNK2dfZLiYMF-C75EAcufcVKWtP+Y4v-Utw@mail.gmail.com>
 <aLmcFp4Ya7SL6FxU@krava> <CAEf4BzbPSTEKs2ya6-d5ecR=wdsRtxRwLJO0r+oEm-_R-B2_yQ@mail.gmail.com>
 <aLq_geGpgBKKfI7e@krava>
In-Reply-To: <aLq_geGpgBKKfI7e@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 Sep 2025 11:44:09 -0700
X-Gm-Features: Ac12FXz5drT-M1y1Zd0gBL7XliEZ-Yzb35NoflktN0p-5TQ9knOeeI-BMj3-Kac
Message-ID: <CAEf4BzaXoyUCfDgy55FCvR_qCSoyAc51mSpMphWt4p9+t_60kg@mail.gmail.com>
Subject: Re: [PATCHv6 perf/core 09/22] uprobes/x86: Add uprobe syscall to
 speed up uprobe
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Jann Horn <jannh@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	x86@kernel.org, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 3:46=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Thu, Sep 04, 2025 at 11:32:06AM -0700, Andrii Nakryiko wrote:
> > On Thu, Sep 4, 2025 at 7:03=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> w=
rote:
> > >
> > > On Thu, Sep 04, 2025 at 11:39:33AM +0200, Jann Horn wrote:
> > > > On Thu, Sep 4, 2025 at 9:56=E2=80=AFAM Jiri Olsa <olsajiri@gmail.co=
m> wrote:
> > > > > On Wed, Sep 03, 2025 at 04:12:37PM -0700, Andrii Nakryiko wrote:
> > > > > > On Wed, Sep 3, 2025 at 2:01=E2=80=AFPM Peter Zijlstra <peterz@i=
nfradead.org> wrote:
> > > > > > >
> > > > > > > On Wed, Sep 03, 2025 at 10:56:10PM +0200, Jiri Olsa wrote:
> > > > > > >
> > > > > > > > > > +SYSCALL_DEFINE0(uprobe)
> > > > > > > > > > +{
> > > > > > > > > > +       struct pt_regs *regs =3D task_pt_regs(current);
> > > > > > > > > > +       struct uprobe_syscall_args args;
> > > > > > > > > > +       unsigned long ip, sp;
> > > > > > > > > > +       int err;
> > > > > > > > > > +
> > > > > > > > > > +       /* Allow execution only from uprobe trampolines=
. */
> > > > > > > > > > +       if (!in_uprobe_trampoline(regs->ip))
> > > > > > > > > > +               goto sigill;
> > > > > > > > >
> > > > > > > > > Hey Jiri,
> > > > > > > > >
> > > > > > > > > So I've been thinking what's the simplest and most reliab=
le way to
> > > > > > > > > feature-detect support for this sys_uprobe (e.g., for lib=
bpf to know
> > > > > > > > > whether we should attach at nop5 vs nop1), and clearly th=
at would be
> > > > > > > > > to try to call uprobe() syscall not from trampoline, and =
expect some
> > > > > > > > > error code.
> > > > > > > > >
> > > > > > > > > How bad would it be to change this part to return some un=
ique-enough
> > > > > > > > > error code (-ENXIO, -EDOM, whatever).
> > > > > > > > >
> > > > > > > > > Is there any reason not to do this? Security-wise it will=
 be just fine, right?
> > > > > > > >
> > > > > > > > good question.. maybe :) the sys_uprobe sigill error path f=
ollowed the
> > > > > > > > uprobe logic when things go bad, seem like good idea to be =
strict
> > > > > > > >
> > > > > > > > I understand it'd make the detection code simpler, but it c=
ould just
> > > > > > > > just fork and check for sigill, right?
> > > > > > >
> > > > > > > Can't you simply uprobe your own nop5 and read back the text =
to see what
> > > > > > > it turns into?
> > > > > >
> > > > > > Sure, but none of that is neither fast, nor cheap, nor that sim=
ple...
> > > > > > (and requires elevated permissions just to detect)
> > > > > >
> > > > > > Forking is also resource-intensive. (think from libbpf's perspe=
ctive,
> > > > > > it's not cool for library to fork some application just to chec=
k such
> > > > > > a seemingly simple thing as whether to
> > > > > >
> > > > > > The question is why all that? That SIGILL when !in_uprobe_tramp=
oline()
> > > > > > is just paranoid. I understand killing an application if it tri=
es to
> > > > > > screw up "protocol" in all the subsequent checks. But here it's
> > > > > > equally secure to just fail that syscall with normal error, ins=
tead of
> > > > > > punishing by death.
> > > > >
> > > > > adding Jann to the loop, any thoughts on this ^^^ ?
> > > >
> > > > If I understand correctly, the main reason for the SIGILL is that i=
f
> > > > you hit an error in here when coming from an actual uprobe, and if =
the
> > > > syscall were to just return an error, then you'd end up not restori=
ng
> > > > registers as expected which would probably end up crashing the proc=
ess
> > > > in a pretty ugly way?
> > >
> > > for some cases yes, for the initial checks I think we could just skip
> > > the uprobe and process would continue just fine
> > >
> >
> > For non-buggy kernel implementation in_uprobe_trampoline(regs->ip)
> > will (should) always be true when triggered for kernel-installed
> > uprobe. So this check can fail only for cases when someone
> > intentionally called sys_uprobe not from kernel-generated and
> > kernel-controlled trampoline.
> >
> > At which point it's totally fine to just return an error and do nothing=
.
> >
> > > we use sigill because the trap code paths use it for errors and to be
> > > paranoid about the !in_uprobe_trampoline check
> >
> > Yeah, and it should be totally fine to keep doing that.
> >
> > It's just about that entry in_uprobe_trampoline() check. And that's
> > sufficient to make all this nicely integrated with USDT use cases.
> >
> > (I'd say it would be nice to also amend this into original patch to
> > avoid someone cherry picking original commit and forgetting/missing
> > the follow up change. But that's up to Peter.)
> >
> > Jiri, can you please send a quick patch and see how that goes? Thanks!
>
> seems like it's as easy as the change below, I'll send formal patches
> later if I don't hear otherwise.. we will also need man page change
>
> jirka
>
>
> ---
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 0a8c0a4a5423..845aeaf36b8d 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -810,7 +810,7 @@ SYSCALL_DEFINE0(uprobe)
>
>         /* Allow execution only from uprobe trampolines. */
>         if (!in_uprobe_trampoline(regs->ip))
> -               goto sigill;
> +               return -ENXIO;
>

thanks!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>         err =3D copy_from_user(&args, (void __user *)regs->sp, sizeof(arg=
s));
>         if (err)
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/to=
ols/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> index 5da0b49eeaca..6d75ede16e7c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> @@ -757,34 +757,12 @@ static void test_uprobe_race(void)
>  #define __NR_uprobe 336
>  #endif
>
> -static void test_uprobe_sigill(void)
> +static void test_uprobe_error(void)
>  {
> -       int status, err, pid;
> +       long err =3D syscall(__NR_uprobe);
>
> -       pid =3D fork();
> -       if (!ASSERT_GE(pid, 0, "fork"))
> -               return;
> -       /* child */
> -       if (pid =3D=3D 0) {
> -               asm volatile (
> -                       "pushq %rax\n"
> -                       "pushq %rcx\n"
> -                       "pushq %r11\n"
> -                       "movq $" __stringify(__NR_uprobe) ", %rax\n"
> -                       "syscall\n"
> -                       "popq %r11\n"
> -                       "popq %rcx\n"
> -                       "retq\n"
> -               );
> -               exit(0);
> -       }
> -
> -       err =3D waitpid(pid, &status, 0);
> -       ASSERT_EQ(err, pid, "waitpid");
> -
> -       /* verify the child got killed with SIGILL */
> -       ASSERT_EQ(WIFSIGNALED(status), 1, "WIFSIGNALED");
> -       ASSERT_EQ(WTERMSIG(status), SIGILL, "WTERMSIG");
> +       ASSERT_EQ(err, -1, "error");
> +       ASSERT_EQ(errno, ENXIO, "errno");
>  }
>
>  static void __test_uprobe_syscall(void)
> @@ -805,8 +783,8 @@ static void __test_uprobe_syscall(void)
>                 test_uprobe_usdt();
>         if (test__start_subtest("uprobe_race"))
>                 test_uprobe_race();
> -       if (test__start_subtest("uprobe_sigill"))
> -               test_uprobe_sigill();
> +       if (test__start_subtest("uprobe_error"))
> +               test_uprobe_error();
>         if (test__start_subtest("uprobe_regs_equal"))
>                 test_uprobe_regs_equal(false);
>         if (test__start_subtest("regs_change"))

