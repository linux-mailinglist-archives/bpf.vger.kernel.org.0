Return-Path: <bpf+bounces-14596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 080F77E6E59
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 17:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C646A2810DC
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 16:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C87210F0;
	Thu,  9 Nov 2023 16:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLfJMm1F"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6D5208BC
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 16:13:59 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734DD3588
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 08:13:58 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32da4ffd7e5so671611f8f.0
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 08:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699546437; x=1700151237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBQbwBN6eVXGoj/XFHPs4Z2lptQwpGNXBxT8HtDoEl4=;
        b=mLfJMm1FD0xgN397SFD5uaAr2UnhKTuPjg+CkTLtW2V7vHs5dyTJMf9LbeDOXbC2KC
         RcXZWTmV+lF5B+6S/xUcXQTUQ5Bg8LLQXRj8UA5buYqDZ5/var/AYtfD0SsvbnvkN5qI
         sDAt3g+MlF3BobF8tbaK86gKXvoy993HIsLSRQJT690SIrX4x26kBlg1/mllB4dK+Xoa
         bYLv8yAoCNLKamWHeZIvlogHXRwqepGU5bAqv/Uipyg9LkVI+ZuojGP298ZWNxn13DSd
         fHilU5Qk8Hu5psHHAfKwBy6uy6SJ+WWYvzREOHJ5J+e0avLf7C5oHbnbGOLZ3wFnHiN9
         Uc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699546437; x=1700151237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eBQbwBN6eVXGoj/XFHPs4Z2lptQwpGNXBxT8HtDoEl4=;
        b=vsPGKUY6MJ5lcdxfO8ygKET/eqClnwtZPZrdY823cLQ5geKmnCS6Vo7lpo7AsMMzA6
         TrQ6dMjdM2IScEGHmoEMoSXbc5RNjvD6MeptJnlJjZOWjcXRIBx13vWWrX9f88AsccV7
         VYtU3Gv1pQ/HdVvLq8aUh+OKPr7SYPXfHi5TCAgPfaXInrLgagN6TNYi2oLQ+Y65bOIe
         5qfJRclnU/gNdSFwZWpfvK2qf1xTlK5ffmFAsSibaEpDYjQGQL+vpZhQBl+pJ6YWMvOu
         k6W739DBXLRCkQJ8BvrHiRpNsQELb716QsU184dWgzgiOSCe7pNDZLNNhvaDYqXF3/tK
         GJCw==
X-Gm-Message-State: AOJu0YyOqbx6L4lZCk8Q8lGL0cmLeDModiyNA60wmORhaB79kHTXlKZb
	GuY9Qx34bjrC0/xRJHwnvO8KuoC0AG0tTjLjJL8=
X-Google-Smtp-Source: AGHT+IENZHK99U/xHOlaq4y+C/Ol4oZAZy+fUM3cbjxntv4AJ8rNFAyLOUk3sob3o25z+cGSVJq/hhlybXd5EOdozg8=
X-Received: by 2002:a05:6000:4022:b0:32d:9d03:29e6 with SMTP id
 cp34-20020a056000402200b0032d9d0329e6mr6578332wrb.27.1699546436473; Thu, 09
 Nov 2023 08:13:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031050324.1107444-1-andrii@kernel.org> <20231031050324.1107444-2-andrii@kernel.org>
 <43f0d9f7219b74bfaff14b6496902f1056847de7.camel@gmail.com>
In-Reply-To: <43f0d9f7219b74bfaff14b6496902f1056847de7.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Nov 2023 08:13:45 -0800
Message-ID: <CAADnVQL6_o9z3z1=8o7qGNzAD8vKMZ+OetcYYy-1huxGfCJToA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/7] bpf: use common jump (instruction) history
 across all states
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 7:20=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2023-10-30 at 22:03 -0700, Andrii Nakryiko wrote:
> > Instead of allocating and copying jump history each time we enqueue
> > child verifier state, switch to a model where we use one common
> > dynamically sized array of instruction jumps across all states.
> >
> > The key observation for proving this is correct is that jmp_history is
> > only relevant while state is active, which means it either is a current
> > state (and thus we are actively modifying jump history and no other
> > state can interfere with us) or we are checkpointed state with some
> > children still active (either enqueued or being current).
> >
> > In the latter case our portion of jump history is finalized and won't
> > change or grow, so as long as we keep it immutable until the state is
> > finalized, we are good.
> >
> > Now, when state is finalized and is put into state hash for potentially
> > future pruning lookups, jump history is not used anymore. This is
> > because jump history is only used by precision marking logic, and we
> > never modify precision markings for finalized states.
> >
> > So, instead of each state having its own small jump history, we keep
> > a global dynamically-sized jump history, where each state in current DF=
S
> > path from root to active state remembers its portion of jump history.
> > Current state can append to this history, but cannot modify any of its
> > parent histories.
> >
> > Because the jmp_history array can be grown through realloc, states don'=
t
> > keep pointers, they instead maintain two indexes [start, end) into
> > global jump history array. End is exclusive index, so start =3D=3D end =
means
> > there is no relevant jump history.
> >
> > This should eliminate a lot of allocations and minimize overall memory
> > usage (but I haven't benchmarked on real hardware, and QEMU benchmarkin=
g
> > is too noisy).
> >
> > Also, in the next patch we'll extend jump history to maintain additiona=
l
> > markings for some instructions even if there was no jump, so in
> > preparation for that call this thing a more generic "instruction histor=
y".
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Nitpick: could you please add a comment somewhere in the code
> (is_state_visited? pop_stack?) saying something like this:
>
>   states in the env->head happen to be sorted by insn_hist_end in
>   descending order, so popping next state for verification poses no
>   risk of overwriting history relevant for states remaining in
>   env->head.
>
> Side note: this change would make it harder to change states traversal
> order to something other than DFS, should we chose to do so.

I have the same concern.

When we discussed different algorithms to solve open-coded-iters/bpf_loop
issue non-DFS ideas came up multiple times.
To be fair I didn't like them, because I wanted to preserve DFS property :)
but I feel sooner or later we will be forced to explore non-DFS.
So I think this patch is no go. There is really no need to rely on DFS here=
.
Let instruction history consume more memory. It's a better long term trade =
off.
We don't do strict DFS today.
The speculative execution analysis is DFS, but it visits paths
multiple times, so it's not a canonical DFS.
It probably doesn't break this particular insn_hist approach,
but still feels too fragile to rely on DFS assumption long term.

