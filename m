Return-Path: <bpf+bounces-21644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2549F84FCA8
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 20:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A09B1C24144
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 19:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D1F80C16;
	Fri,  9 Feb 2024 19:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntcucril"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E832E3F7
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 19:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707505783; cv=none; b=u608GAd8aMcuACume1hTn5eRcyxGbg7Pe2tpyRKyvUyhScqb3JrbHJYaXJn3Juuc/FMjBcywMwHi045ZGQXvTDTdT3pRokexdLRsbyFNXW2IlQvQvD2QTkVqlktfMR82brD81Ji5DrRB13TGBTFo0oi1aGsyN7tZBRh1PlixwmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707505783; c=relaxed/simple;
	bh=Zyaco228qd0OCddanYx1aQmz2bo6wZ4tCOeM2TRCABY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zd5xoOLsmEu0M8Wlk3NRsSHnvxiCUIHrR9gSombaWiZvc0QRZxArjDlY5ZCXL10noHDwlBgS2VuvgnaQjbdkB8evaFCEn32Mbxp+4K3wYAyfik5ZmHe4m4BAhHLCxpEaF0GriNIrWqxFzHfIhLtJ/1VVWdlWFS7bUbAjyGzp5e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntcucril; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d9bd8fa49eso10578755ad.1
        for <bpf@vger.kernel.org>; Fri, 09 Feb 2024 11:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707505781; x=1708110581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gfi9NXSP27W7xzdgjy1gcdrDzfjGK7X9xfN2JFwj2uk=;
        b=ntcucrilKyjcJ6/BufhE+7TMY+X3U/rkxZwsAFg2kGgDxMWOHGGAcfYXeHKsS3wQiy
         uCbTmCZFJGEXs7oZk4yUxSMsHIpm+Ab4ftYT0tgMpLq0+i6d1GjNvBva85AzBmUJkwB1
         XlyoRETnG7poOJ/ptxZBUoOi6DqVBZ2v7tBu+IIsSrneOYreY3b/nKJz73jA6KaMlyjX
         RT0xiNU+kyik9YMQTn6kiq5juOA+OsVVt4H4UMkcWG++91MdUrCt6EAh7YcWsXZ0XC60
         ViHh0Ouu2CcBkzGsUu/s4vbXx1b/rWIoFuG+DEtkRqEC/ftYN3DvNACj5yyKUgMlxrWI
         8fAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707505781; x=1708110581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gfi9NXSP27W7xzdgjy1gcdrDzfjGK7X9xfN2JFwj2uk=;
        b=n8TjyWbLOBrDcIdvKtyOkveBPcaQ8Rbyu6PEhz60GhIO+VzBOBuayaNH2w4jfyE8XK
         cz8I24n4r76miZMFuuiU1ouZ5hsu0JjXEB6qrnASvfn4gMQQoCoR4vGm40y39tyYckSF
         x9HrDkFUv0ZKbpcR0bmieh1bzms4xohsoS+PAjcD/0fYwS5PxblX5RdKhhKRH92gfTkc
         P39kiBztpHZpnLHq73oFCgc0bb07+RbgyGPxn34412iJClSSKwcnTtvBF9/CeScrRDEX
         U6rLxB8Zvo50OjNTtqgO3Bxc6wtiwpU89dYxLyZEQD7ufBe2ZKgoZIsG8Th9b1Lo9HkQ
         mcww==
X-Gm-Message-State: AOJu0YxxbERXwEkQbwlkyw6kb7Rwjft9f+k5cJgFRGPNI6e6RA2l9YYt
	A+jLgK+f7mseiSOfn354O6ulGwyPPc5SiDYh4F5WGRWhlhjgKYFVbD9jquzuzaVZGXHd7E5TC6V
	9LfYkY7Rix2iDHFH6T7SVSpYq4Ag=
X-Google-Smtp-Source: AGHT+IFzmz8WoILBUQoONQ4F3W0O90FWBRmiPit92qs2VqwRYgnsWDmtrGAlcAIgOGvVUbEQ36BzA3+t0iLnDzpcCvc=
X-Received: by 2002:a17:90a:b111:b0:297:bb2:b25 with SMTP id
 z17-20020a17090ab11100b002970bb20b25mr2130537pjq.16.1707505781473; Fri, 09
 Feb 2024 11:09:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
 <20240206220441.38311-2-alexei.starovoitov@gmail.com> <CAEf4BzYBjzHL20NU_yuj+en-YF0dJmHuvB1SOPGZc=tnbhjZhQ@mail.gmail.com>
 <CAADnVQLTt5S8HPcLv1hHWZFBXeU7HJNyocg7rE3rGrpnOuwxTQ@mail.gmail.com>
In-Reply-To: <CAADnVQLTt5S8HPcLv1hHWZFBXeU7HJNyocg7rE3rGrpnOuwxTQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Feb 2024 11:09:29 -0800
Message-ID: <CAEf4BzZVgtZc0EfJaHJ1hVQUECV0W+ytXgjKTySBwC9ZkdqogQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 01/16] bpf: Allow kfuncs return 'void *'
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 4:09=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Feb 8, 2024 at 11:40=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Feb 6, 2024 at 2:04=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > Recognize return of 'void *' from kfunc as returning unknown scalar.
> > >
> > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > ---
> > >  kernel/bpf/verifier.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index ddaf09db1175..d9c2dbb3939f 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -12353,6 +12353,9 @@ static int check_kfunc_call(struct bpf_verifi=
er_env *env, struct bpf_insn *insn,
> > >                                         meta.func_name);
> > >                                 return -EFAULT;
> > >                         }
> > > +               } else if (btf_type_is_void(ptr_type)) {
> > > +                       /* kfunc returning 'void *' is equivalent to =
returning scalar */
> > > +                       mark_reg_unknown(env, regs, BPF_REG_0);
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > I think we should do a similar extension when passing `void *` into
> > global funcs. It's best to treat it as SCALAR instead of rejecting it
> > because we can't calculate the size. Currently users in practice just
> > have to define it as `uintptr_t` and then cast (or create static
> > wrappers doing the casting). Anyways, my point is that it makes sense
> > to treat `void *` as non-pointer.
>
> Makes sense. Will add it to my todo list.
>
> On that note I've been thinking how to get rid of __arg_arena
> that I'm adding in this series.
>
> How about the following algorithm?
> do_check_main() sees that scalar or ptr_to_arena is passed
> into global subprog that has BTF 'struct foo *'
> and today would require ptr_to_mem.
> Instead of rejecting the prog the verifier would override
> (only once and in one direction)
> that arg of that global func from ptr_to_mem into scalar.
> And will proceed as usual.
> do_check_common() of that global subprog will pick up scalar
> for that arg, since args are cached.
> And verification will proceed successfully without special __arg_arena
> .

Can we pass PTR_TO_MEM (e.g., map value pointer) to something that is
expecting PTR_TO_ARENA? Because there are few problems with the above
algorithm, I think.

First, this check won't be just in do_check_main(), the same global
function can be called from another function.

And second, what if you have the first few calls that pass PTR_TO_MEM.
Verifier sees that, allows it, assumes global func will take
PTR_TO_MEM. Then we get to a call that passes PTR_TO_ARENA or scalar,
we change the argument expectation to be __arg_arena-like and
subsequent checks will assume arena stuff. But the first few calls
already assumed correctness based on PTR_TO_MEM.


In short, it seems like this introduces more subtleness and
potentially unexpected interactions. I don't really see explicit
__arg_arena as a bad thing, I find that explicit annotations for
"special things" help in practice as they bring specialness into
attention. And also allow people to ask/google more specific
questions.

