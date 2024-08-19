Return-Path: <bpf+bounces-37525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9380E95701F
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 18:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AC1C281FBA
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 16:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB1C171E40;
	Mon, 19 Aug 2024 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1o0cYsj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C5516B723;
	Mon, 19 Aug 2024 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724084658; cv=none; b=W5X2qAG+/6NyDuJBxJ9T6Tl6cZ77HjGHhthKnFwUsAIFwPsQq0eZ+JDqzVco7iQV3sqsNShVXJQtbvS85sgbOXe7GBK9x1ZRYSfUPihDqBe/c27uwOR9F9qSUgd8trDlm10iw080uFrlkChbNgA76KduMLnmQCvmi2li5xvQJ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724084658; c=relaxed/simple;
	bh=FUr6q176nyRJP1JzJZFCsStqLKXdonS6tpz1AatdB5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hpHhwHLmzaN3VKRUVi6VkHP+T30aW0EC1l5u3Y4mITQW3eMBmcllJOwJrOzQIvHawXS1jDynxb6Ig9hQ1WoiGIhpZlCtciFMFNpc00qiC0VZs/ZuAcx4aoOp+rtSUaMk5CB/m3MZppuE7eRDabonYB+9ErYIqkZw0IMOsYaJkAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1o0cYsj; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7a1be7b7bb5so3139246a12.0;
        Mon, 19 Aug 2024 09:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724084657; x=1724689457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rccIFvcICyWq3i8QX08SQKeL7MjWBM3NpnoMSo0S9Y=;
        b=B1o0cYsjolU3g6Pr/Aa5tFh3CFlMBE/8A72EUKeTSLU4qABj0khMJ1Kc/OzesfcGQb
         EB+rJq3zxN3TotSHiS14Wdp28DjQv/ksbC39UrH1p4yC9tMLVoJV+ZG3T3mzA7XrrBus
         5q5jjIrlRnperKhiUZ8/ffF/9C+K912uyuLnNQKNxPdWoL15OgwEe/V1eMhKZ2YfQ0Mt
         Yv5Hea5p49hfoi4Lf7mCVNV5E98iSg/c8NqTl98Px2rQGuK+OaJ6mI/CeBYT1J4g/5Qh
         Bb4Fb7YJJw02iAT/VZ7N67K8MCrov9pisTsimZZY2ZnNue2w2IId8HhfC3kdMCXHweb8
         2CgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724084657; x=1724689457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rccIFvcICyWq3i8QX08SQKeL7MjWBM3NpnoMSo0S9Y=;
        b=ik5cpUlI5uflwVAOELzoFz209k0plw7OngRn0FMzJ+/b5eAqajVDdpH7ubsJ6Dx2kB
         5IP3s5mQdTirJmxilijXFJlCUoSG6K2yn6tXZK2wMtbYI77PotykZaa6XeBIO1ub4l2x
         DDacESJT3JNomCqgQCpz4fbSDN+Yw3n0Z8lvCx6Va1ondhRwo5hFqVyJDSdidFzndPFC
         8y5uXU3ztBR7j86FFN1LYbThjKcjnFFgLJLnKKG36rL5IooCMs+99JDkXYrk7p9toId0
         CHYIIIYO7eUYSFv/LYleOFN+uWIZEOt42/V2KJ4D3y00+oRW60wulq9FtSrVGa652aFs
         kPPg==
X-Forwarded-Encrypted: i=1; AJvYcCW8vXreZzIgc2/aN9LrICAMfPGSVXC1jz5nIs3zXiwCZPwSkKL42Vw9lJzZTGLIxLfdZuBvA9cbKpR2QV52Ad5VELWZ6t2ia9TwNYBnUZgAHf0SLfeIPlcZjOR9i4ucXJwK
X-Gm-Message-State: AOJu0Yw+Ge+khZAy8pzRgkT31jLx9PlN/s4TnlVUfr4t4DG4Gqpw2Beq
	5q3wFg5BuJFexaHKngmUJlakP3KIxNl0NqeRHUFaZ/qRMAOUhyRPSW5auTlkJYJ2SnmkzaljLyN
	gING5tcxOeMx0gF4I+JFh124lteg=
X-Google-Smtp-Source: AGHT+IHIl1OO2vL9sH/QNMZs8/rRzuJnV4NaqaDEVA9OFQsbG9DHn5qshP0fORQs5pOUy53I4CWpeKJgL7PzzHkttSM=
X-Received: by 2002:a17:90a:ca0f:b0:2cb:4bed:ed35 with SMTP id
 98e67ed59e1d1-2d3e00f3a00mr11594631a91.41.1724084656688; Mon, 19 Aug 2024
 09:24:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB58489794C158C438B04FD0E599802@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <CAEf4Bzb3XbGx+N5yrYELNAkaABP9fyifAQhTP1VHSvVycG36TQ@mail.gmail.com>
 <AM6PR03MB584807BFB29105F1D7FDC89E99812@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <CAADnVQKvt2uUsvFbYnEmApj9ZzeL0on1zM4zKBJEFmzuoTtzhg@mail.gmail.com>
In-Reply-To: <CAADnVQKvt2uUsvFbYnEmApj9ZzeL0on1zM4zKBJEFmzuoTtzhg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 19 Aug 2024 09:24:04 -0700
Message-ID: <CAEf4BzYWLFUtTx2obdBunaJ2qUdX+Nvv5w=VAwBTutxvYvR0PA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Make the pointer returned by iter next
 method valid
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Juntong Deng <juntong.deng@outlook.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 8:39=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Aug 16, 2024 at 3:43=E2=80=AFPM Juntong Deng <juntong.deng@outloo=
k.com> wrote:
> >
> > On 8/15/24 18:15, Andrii Nakryiko wrote:
> > > On Thu, Aug 15, 2024 at 9:11=E2=80=AFAM Juntong Deng <juntong.deng@ou=
tlook.com> wrote:
> > >>
> > >> Currently we cannot pass the pointer returned by iter next method as
> > >> argument to KF_TRUSTED_ARGS kfuncs, because the pointer returned by
> > >> iter next method is not "valid".
> > >>
> > >> This patch sets the pointer returned by iter next method to be valid=
.
> > >>
> > >> This is based on the fact that if the iterator is implemented correc=
tly,
> > >> then the pointer returned from the iter next method should be valid.
> > >>
> > >> This does not make NULL pointer valid. If the iter next method has
> > >> KF_RET_NULL flag, then the verifier will ask the ebpf program to
> > >> check NULL pointer.
> > >>
> > >> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> > >> ---
> > >>   kernel/bpf/verifier.c | 4 ++++
> > >>   1 file changed, 4 insertions(+)
> > >>
> > >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > >> index ebec74c28ae3..35a7b7c6679c 100644
> > >> --- a/kernel/bpf/verifier.c
> > >> +++ b/kernel/bpf/verifier.c
> > >> @@ -12832,6 +12832,10 @@ static int check_kfunc_call(struct bpf_veri=
fier_env *env, struct bpf_insn *insn,
> > >>                          /* For mark_ptr_or_null_reg, see 93c230e3f5=
bd6 */
> > >>                          regs[BPF_REG_0].id =3D ++env->id_gen;
> > >>                  }
> > >> +
> > >> +               if (is_iter_next_kfunc(&meta))
> > >> +                       regs[BPF_REG_0].type |=3D PTR_TRUSTED;
> > >> +
> > >
> > > It seems a bit too generic to always assign PTR_TRUSTED to anything
> > > returned from any iterator. Let's maybe add KF_RET_TRUSTED or
> > > KF_ITER_TRUSTED or something along those lines to mark such iter_next
> > > kfuncs explicitly?
> > >
> > > For the numbers iterator, for instance, this PTR_TRUSTED makes no sen=
se.
> > >
> >
> > I had the same idea (KF_RET_TRUSTED) before, but Kumar thought it shoul=
d
> > be avoided and pointers returned by iter next method should be trusted
> > by default [0].
> >
> > The following are previous related discussions:
> >
> >  >> For iter_next(), I currently have an idea to add new flags to allow
> >  >> iter_next() to decide whether the return value is trusted or not,
> >  >> such as KF_RET_TRUSTED.
> >  >>
> >  >> What do you think?
> >  >
> >  > Why shouldn't the return value always be trusted?
> >  > We eventually want to switch over to trusted by default everywhere.
> >  > It would be nice not to go further in the opposite direction (i.e.
> >  > having to manually annotate trusted) if we can avoid it.
> >
> > [0]:
> > https://lore.kernel.org/bpf/CAP01T75na=3Dfz7EhrP4Aw0WZ33R7jTbZ4BcmY56S1=
xTWczxHXWw@mail.gmail.com/
> >
> > Maybe we can have more discussion?
> >
> > (This email has been CC Kumar)
>
> +1
> pointer from iterator should always be trusted except
> the case of KF_RCU_PROTECTED iterators.
> Those iters clear iter itself outside of RCU CS,
> so a pointer returned from iter_next should probably be
> PTR_TO_BTF_ID | MEM_RCU | PTR_MAYBE_NULL.
>
> For all other iters it should be safe to return
> PTR_TO_BTF_ID | PTR_TRUSTED | PTR_MAYBE_NULL
>

Ok, but we at some point might need to return a non-RCU/non-trusted
pointer, so I guess we'll have to add yet another flag to opt-out of
"trustedness"?

> > For the numbers iterator, for instance, this PTR_TRUSTED makes no sense
>
> I see no conflict. It's a trusted pointer to u32.

