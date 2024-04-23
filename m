Return-Path: <bpf+bounces-27570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD30C8AF3C6
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 18:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F56283EC6
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 16:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EB213CF90;
	Tue, 23 Apr 2024 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4LTMydu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD3413BACF
	for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713889297; cv=none; b=LNIigxQbijKLc/K0laRAimYeqAhmQ2i7TrfnkResz0Fj1pDNQisXcnMhsw4Q95hEmmHpEY17lnYO4ezFDust7WjZ6CfaF1qIjkKqlLw/OFyELyL4jafxeyyk+yw7L2uy6j4mgC6wg/L0TA5zUCOGb6qGVft03BKWvLYfDzKv6CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713889297; c=relaxed/simple;
	bh=KiIN8rH4fbdPrH06YZj0+Ne0pZ36x3CbDL1JOrCUaYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LQNPXPJ0HIl7H+u0RfAkju+h4RE2OgYaGZT0+7fZw+oynnl7GTslasksFUvjWS5mNzAOcLm02nML4ACs5G/x3MTvzDU3ZqI+etDIlQoBiwNaBD3OMMDtSLgJNdh/QIf2DvUBFrxFeSCH2LdYXvif0TSvEIhHexwd/OxV7mWFs60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4LTMydu; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-56e136cbcecso8103273a12.3
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 09:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713889294; x=1714494094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wjUAYiNTgEa5RiozxtONCPteoSw7s59qUcNv4GAjuw=;
        b=k4LTMyduab6KyGwj8ORE/AHguFUPWkE3/zDVb161sN5OusbbVLxgL9JyE13j0Cjvvj
         cOST31wcFGjj7SSzI4BnerVwKZjgQNnvA0Bq0fb5+SLGQTPmQ2YsKJi5HEIquMA0BDsr
         KVDWrA5NlxpTI2bx81wiTIDuN1dzn49yfPEQMgfjhpz7ZfaXi6QJqXHk2oSM/A2uF36s
         qg7J4osOr9j6k87edUe8St2SPp3C9DObt5mJyU0V9q3KXswTc3OgKQKZuAluCma9I1ND
         T2IurITRETbisgXWzpDmphdX0t5x0oziROQF+UoE4tMvP6L813R8a4hIikyImyOwcyOc
         CY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713889294; x=1714494094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wjUAYiNTgEa5RiozxtONCPteoSw7s59qUcNv4GAjuw=;
        b=sQJ0tMNWghZzqPQLyR3uuVN5/hTzWbiHvp4nF5XRUOnfjYBHd3zS5YyV4zRIO2SVcT
         1ql8j+eJmA86YhXay6G3ym1CGKDeUWEf0864QkLzdh+h0jCu8AwQeS9C/w5Y4HL/PaEX
         87nLFnzz2fWg6YgyOwaOjjWd0Fq7BkdDPlSN/u3u0/1e0wy0E38dDORclbW6noqApWhx
         IlctaL73SUQiJSSivusstFmIfjfLCWUwOxdqVcEkeONYJxX22OBEDKveDvkkAMkiMsWk
         7MhvpFF0knASbVUxKqbA1G8Kg9J14gvzTK4WuHZP+HJn0p0bTA3IWNSM13EXxUTXSp5b
         F5vw==
X-Forwarded-Encrypted: i=1; AJvYcCVXtnQGgf9squBZ7nSrO/0BS6EZkvxSfJaxSiAP4Z1DDY0w9RU+aNWePS0opGkNdgEkuHX7aAj3TeZ3te/X9D6DpjOY
X-Gm-Message-State: AOJu0Yy47QCGK7za6M/KjAYnhlXQNzu0oLegLW4GXsIOi2ltA+WrXUPh
	m+c20mEtgcCHRAA6725TbJWsR8q78u6K05kP6K6Y8jRcVdcKXxNGX9SSGYi3jEV87TbR2T8T/ow
	y1bm4kutvl8jvtxgflpF2zhxX8co=
X-Google-Smtp-Source: AGHT+IFhga9nkeGjbaIBPTkLo+lHcqVDHpe0kbXuXRlAZnqYi/DjPOVVx/U5t2ydvHl9wgXIagS/wnMUYJyV/6i6EwE=
X-Received: by 2002:a17:907:208c:b0:a58:866d:c9c0 with SMTP id
 pv12-20020a170907208c00b00a58866dc9c0mr755062ejb.76.1713889294131; Tue, 23
 Apr 2024 09:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423061922.2295517-1-memxor@gmail.com> <20240423061922.2295517-3-memxor@gmail.com>
 <ZieYvK0GXs4OkTy4@krava> <CAP01T74v0SCoCkg1gJnz4xPsBc5Q7bV0=-xXKfo00z1R5bz0Aw@mail.gmail.com>
 <CAADnVQKN=ABKTFmDvbmZK2RmYLA--Yn4KGqDU7ujZbuHgE311A@mail.gmail.com> <CAP01T75SgwQ2jRfX9FCxo0RrJxv4q5wO+Sf5Dz0_9F5a-4s-aw@mail.gmail.com>
In-Reply-To: <CAP01T75SgwQ2jRfX9FCxo0RrJxv4q5wO+Sf5Dz0_9F5a-4s-aw@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 23 Apr 2024 18:20:58 +0200
Message-ID: <CAP01T74WL57BhQ7ke5KUnb1FS1iLLvA628qi8wkmrO7AmyfecQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: Add tests for preempt kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Barret Rhoden <brho@google.com>, David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Apr 2024 at 18:17, Kumar Kartikeya Dwivedi <memxor@gmail.com> wr=
ote:
>
> On Tue, 23 Apr 2024 at 17:02, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Apr 23, 2024 at 5:06=E2=80=AFAM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Tue, 23 Apr 2024 at 13:17, Jiri Olsa <olsajiri@gmail.com> wrote:
> > > >
> > > > On Tue, Apr 23, 2024 at 06:19:22AM +0000, Kumar Kartikeya Dwivedi w=
rote:
> > > > > Add tests for nested cases, nested count preservation upon differ=
ent
> > > > > subprog calls that disable/enable preemption, and test sleepable =
helper
> > > > > call in non-preemptible regions.
> > > > >
> > > > > 181/1   preempt_lock/preempt_lock_missing_1:OK
> > > > > 181/2   preempt_lock/preempt_lock_missing_2:OK
> > > > > 181/3   preempt_lock/preempt_lock_missing_3:OK
> > > > > 181/4   preempt_lock/preempt_lock_missing_3_minus_2:OK
> > > > > 181/5   preempt_lock/preempt_lock_missing_1_subprog:OK
> > > > > 181/6   preempt_lock/preempt_lock_missing_2_subprog:OK
> > > > > 181/7   preempt_lock/preempt_lock_missing_2_minus_1_subprog:OK
> > > > > 181/8   preempt_lock/preempt_balance:OK
> > > > > 181/9   preempt_lock/preempt_balance_subprog_test:OK
> > > > > 181/10  preempt_lock/preempt_sleepable_helper:OK
> > > >
> > > > should we also check that the global function call is not allowed?
> > > >
> > >
> > > Good point, that is missing, I'll wait for more reviews and then
> > > respin with a failure test for this.
> >
> > I couldn't find the check in patch 1 that does:
> > "Global functions are disallowed from being called".
>
> See this part=EF=BC=9A
>
> + /* Only global subprogs cannot be called with preemption disabled. */
> + if (env->cur_state->active_preempt_lock) {
> + verbose(env, "global function calls are not allowed with preemption
> disabled,\n"
> +     "use static function instead\n");
> + return -EINVAL;
> + }
>
> >
> > And I agree that we need to allow global funcs in preempt disabled regi=
on.
> > Sounds like you're planning that in the follow up.
>
> Yeah, but it's not very simple. I noticed a few more problems with
> global functions before that can be done.
> They need to be marked !sleepable before do_check and only verified
> with !sleepable. Otherwise if that is done later in do_check the
> global function will be seen in the non-preemptible section but may
> have been already verified.
> We need some summarization pass for both preempt and rcu_read_lock kfuncs=
.

E.g. I also have in my TODO list (from hitting this a while ago):

+ * Global functions may clear packet pointers, but data, data_end
remain unclobbered in the caller.
They may call a helper on ctx that invalidates pkt pointers but the
caller may not see that during verification and continue accessing
them.
This needs to be known for the global function before their callers
are verified.

Similarly, the context they are called from is atomic or not
throughput the program needs to be known before their verification is
done.
Otherwise they are verified as sleepable for sleepable programs, while
they maybe called from non-preemptible region.

I will fix the latter first, but a summarization pass for them is
needed and useful to fix the former as well.

