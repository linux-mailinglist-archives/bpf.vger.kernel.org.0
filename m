Return-Path: <bpf+bounces-21191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D49849286
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 03:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64360282F4A
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 02:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B367493;
	Mon,  5 Feb 2024 02:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoSgYULR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984ADB64C
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 02:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707101466; cv=none; b=FotN+auxG7u+ZvIznSrjGf0GajompBNCunKmIKRQw/yrcuGM+UvmI8xQDEc9xU5+zhfEauDxAk/rxFP+81h2nJIqUfdMvCWq6OOuvSlvO3nCc5fj1lF66eXGKW5WKeRm7FS6hPHQQ42QXdy3rGucI3TzH3xl5l+hwmciecWvRhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707101466; c=relaxed/simple;
	bh=f6mrSaUmdjliVzD5kw4Kv+EkLZIvj+D4iDX2hsC2zPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=We6Fs6kkpPnplOsRKi6xPxJauofp64RBawhMSYtWOBHPBQyYZFYcbJFMKqwbM1xviaQUxNtxxGE6+QCSVvI/953uSxO6G2na1170CQkSyiitz+EyosjyGW7lguAh9QIIKO/EIYNMYHeSKqBSl10UoumZJveDw9c++MukcEdQrhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JoSgYULR; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-783f3d27bfbso224228085a.2
        for <bpf@vger.kernel.org>; Sun, 04 Feb 2024 18:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707101463; x=1707706263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvOthK12Ebj9eXjHAk7r3nw7OS5Dc6Mm6ae1WT+pFLM=;
        b=JoSgYULR9QrIY3xQ3xrKuk0RRRKaoDqpXGOOF7vwJMhZVJwhj8mKOcEivZ07OAfEmM
         GUnLkBhDQxm67ONZqWRWUDUdWZ6PsEGjnfuzS9cuijBfLpQ8cWvYvbvdeYYHsVXfGTv+
         mmPZUSQJNdu3gbJUsuiRUuZ3KOPMAbeHTUBdbLgdzlu+ybNRPxBk0UkzupYYzmwgTKjn
         mJiXzM1T1cCE5KTpTB+Nj5IVt72740flNmBd/P4jfWlVeYqenVdOztpen4V4k4loecV2
         go+UWBKWnxzI5j0t7HDp9byi89HXfRUSOkLR1ZUUl0ngTixYFJVRjtBjuRnQLVhkQEd0
         aAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707101463; x=1707706263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rvOthK12Ebj9eXjHAk7r3nw7OS5Dc6Mm6ae1WT+pFLM=;
        b=jkfayUzKRE+o9R67ncPGUMLZNUnm5fpqFDFm+RoX4kZhNnyWBXwqNDGtBQeSPi5gBx
         hLVNlcjsQO43bbAvO07Uv6F9L0LK37u+KUSJQppj0P6l4c0j5ynhRIwf2qjgtYKc04kW
         w5xhDxBa8VLCDzuAamBVeU7qCsP1e2W3d1EW9XqbbUT+7ZbjQqMLtIDInm6nfGOb4Q9T
         3ldpsq6vdxZQ3Pb/NDAbECUSKSjLqValXGGej/sMYb6ISdAzhMR/Xj9ke7/trFK52Mfk
         MOlSx2XL1R1dYdRAtXUZCaJKOjq4Wegog6STaO07m0JMrLl1Mh0N5qz/5RdV9UikGHas
         TIgg==
X-Gm-Message-State: AOJu0YyjzHzKDwiYlaPou0sSYofEKX9Wtfcv/QU0lfBosnlnD2YMnzzv
	rpG30Mg4lyfcgsFFDj0ND3ILAilKh7haGqCu/lNnIZ1lcUhJ40bKxHcxWZnnWMxSD2bYHlBFX9n
	8TBWEKiBTiHvYhGIaQxxFjWg9lGY=
X-Google-Smtp-Source: AGHT+IGNfjvKwidk6P19W1P2V6DP8oHRvVXjc3NbXrkHWcoFmLU5aHVDy60a0nBGKylSwE5Wj071zKlql9xduDREAmo=
X-Received: by 2002:a05:6214:5199:b0:68c:9d40:d1c with SMTP id
 kl25-20020a056214519900b0068c9d400d1cmr4276476qvb.0.1707101463456; Sun, 04
 Feb 2024 18:51:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204230231.1013964-1-memxor@gmail.com> <20240204230231.1013964-2-memxor@gmail.com>
In-Reply-To: <20240204230231.1013964-2-memxor@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 5 Feb 2024 10:50:27 +0800
Message-ID: <CALOAHbDZJCyB+jEA7ahnUywwptMAMBn7K+SZ-4KHqkaD467tOA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Transfer RCU lock state between
 subprog calls
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, David Vernet <void@manifault.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 7:02=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> Allow transferring an imbalanced RCU lock state between subprog calls
> during verification. This allows patterns where a subprog call returns
> with an RCU lock held, or a subprog call releases an RCU lock held by
> the caller. Currently, the verifier would end up complaining if the RCU
> lock is not released when processing an exit from a subprog, which is
> non-ideal if its execution is supposed to be enclosed in an RCU read
> section of the caller.
>
> Instead, simply only check whether we are processing exit for frame#0
> and do not complain on an active RCU lock otherwise. We only need to
> update the check when processing BPF_EXIT insn, as copy_verifier_state
> is already set up to do the right thing.
>
> Suggested-by: David Vernet <void@manifault.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Tested-by: Yafang Shao <laoar.shao@gmail.com>

> ---
>  kernel/bpf/verifier.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 64fa188d00ad..993712b9996b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17698,8 +17698,7 @@ static int do_check(struct bpf_verifier_env *env)
>                                         return -EINVAL;
>                                 }
>
> -                               if (env->cur_state->active_rcu_lock &&
> -                                   !in_rbtree_lock_required_cb(env)) {
> +                               if (env->cur_state->active_rcu_lock && !e=
nv->cur_state->curframe) {
>                                         verbose(env, "bpf_rcu_read_unlock=
 is missing\n");
>                                         return -EINVAL;
>                                 }
> --
> 2.40.1
>
>


--=20
Regards
Yafang

