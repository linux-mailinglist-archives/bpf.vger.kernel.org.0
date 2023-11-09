Return-Path: <bpf+bounces-14601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2257E7047
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 18:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F582815E8
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 17:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F040225D4;
	Thu,  9 Nov 2023 17:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DppvuRrB"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E700225CF
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 17:28:56 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D37A9
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 09:28:55 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9bf86b77a2aso194163866b.0
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 09:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699550934; x=1700155734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z71e3nDpEyz6onUwp1ZJOijdrqO4hFhfMEnK5BteKTI=;
        b=DppvuRrB+NHJwJOnM2CX4MpGKIIrebxGxB8/H0pxtZMATlklBSfc1rSObwMydlguZu
         mWhWVvwAHNG959D8YzKEy8RZe2j17lZgPC1MKhiuKAquY6xGf3CJgfM028dW/bOslJt/
         B2JvhpUNq1UJgO5LSWzL5lJbQGGNmxs1ddcBVwFnw0c/YigczWiu/vYLQKvDRb8OHoBR
         MgUtLS4jZw8oZTbDg5gkBT4QJsE62655eDHKOMqaZplHxThmuEjat1dD5sa2AXoZfiyC
         WvkXus2/o++XakpTLw7dpbKgHV7MT1InM8yOv+b0hUgKxuHMk7gUMSLulSP6KBy4nCAt
         S+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699550934; x=1700155734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z71e3nDpEyz6onUwp1ZJOijdrqO4hFhfMEnK5BteKTI=;
        b=msxy4fpYsCZ2kARWB7ixvdYsDFxk0P3S4PnQ1u9rOoThBxl6sU74RawG01iZ3dLNO8
         p8W8l7cWo7tkxbMCsY+u5D4XkT5OUDpXohlhp6r6Cci7hESVTezJVVjjY7KmDpG1tJhX
         GzefzHGwMTd80IC6U7bVaoNVZTjyMjxrlKXALH++Y8PADQZto0Ggc5TzK+m5DwEWEjqz
         O8adbilfax+9AwgRDvUBlDKKbOw9BiyTwStXmwnHAxsyLbKleEGD5njBmzoRWIb7e/Kd
         eyNth3buOCebue/z42ObljoDQ5kopLpHkaX+GEjhCKk/DUKrp0D1BfSXbPLHRr7mTLrP
         QWVA==
X-Gm-Message-State: AOJu0YwTEVmzIsk58sJetfPkSaR0QdldX+EBPkY8jC1HDT1L+b6FLqzB
	Bb+rzK288xVIiEoHg86VacCL1qp87sP7wBdKCuw=
X-Google-Smtp-Source: AGHT+IH6C+Y1skZ2XFkOyfI0uT/p3MMUBcC9jlpVOZLFzv30boZfx0ulv1/5oV0dcQ1f44cgLTURHJshpNNxt0yFkrU=
X-Received: by 2002:a17:907:2cc2:b0:9be:3c7e:7f38 with SMTP id
 hg2-20020a1709072cc200b009be3c7e7f38mr4673102ejc.10.1699550933902; Thu, 09
 Nov 2023 09:28:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031050324.1107444-1-andrii@kernel.org> <20231031050324.1107444-2-andrii@kernel.org>
 <43f0d9f7219b74bfaff14b6496902f1056847de7.camel@gmail.com> <CAADnVQL6_o9z3z1=8o7qGNzAD8vKMZ+OetcYYy-1huxGfCJToA@mail.gmail.com>
In-Reply-To: <CAADnVQL6_o9z3z1=8o7qGNzAD8vKMZ+OetcYYy-1huxGfCJToA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 9 Nov 2023 09:28:42 -0800
Message-ID: <CAEf4BzaA12xjXm8KZNB1mkVDOTtVDQDDWF4nYQtQ2qRYoTip3A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/7] bpf: use common jump (instruction) history
 across all states
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 8:14=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Nov 9, 2023 at 7:20=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >
> > On Mon, 2023-10-30 at 22:03 -0700, Andrii Nakryiko wrote:
> > > Instead of allocating and copying jump history each time we enqueue
> > > child verifier state, switch to a model where we use one common
> > > dynamically sized array of instruction jumps across all states.
> > >
> > > The key observation for proving this is correct is that jmp_history i=
s
> > > only relevant while state is active, which means it either is a curre=
nt
> > > state (and thus we are actively modifying jump history and no other
> > > state can interfere with us) or we are checkpointed state with some
> > > children still active (either enqueued or being current).
> > >
> > > In the latter case our portion of jump history is finalized and won't
> > > change or grow, so as long as we keep it immutable until the state is
> > > finalized, we are good.
> > >
> > > Now, when state is finalized and is put into state hash for potential=
ly
> > > future pruning lookups, jump history is not used anymore. This is
> > > because jump history is only used by precision marking logic, and we
> > > never modify precision markings for finalized states.
> > >
> > > So, instead of each state having its own small jump history, we keep
> > > a global dynamically-sized jump history, where each state in current =
DFS
> > > path from root to active state remembers its portion of jump history.
> > > Current state can append to this history, but cannot modify any of it=
s
> > > parent histories.
> > >
> > > Because the jmp_history array can be grown through realloc, states do=
n't
> > > keep pointers, they instead maintain two indexes [start, end) into
> > > global jump history array. End is exclusive index, so start =3D=3D en=
d means
> > > there is no relevant jump history.
> > >
> > > This should eliminate a lot of allocations and minimize overall memor=
y
> > > usage (but I haven't benchmarked on real hardware, and QEMU benchmark=
ing
> > > is too noisy).
> > >
> > > Also, in the next patch we'll extend jump history to maintain additio=
nal
> > > markings for some instructions even if there was no jump, so in
> > > preparation for that call this thing a more generic "instruction hist=
ory".
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > Nitpick: could you please add a comment somewhere in the code
> > (is_state_visited? pop_stack?) saying something like this:
> >
> >   states in the env->head happen to be sorted by insn_hist_end in
> >   descending order, so popping next state for verification poses no
> >   risk of overwriting history relevant for states remaining in
> >   env->head.
> >
> > Side note: this change would make it harder to change states traversal
> > order to something other than DFS, should we chose to do so.
>
> I have the same concern.
>
> When we discussed different algorithms to solve open-coded-iters/bpf_loop
> issue non-DFS ideas came up multiple times.
> To be fair I didn't like them, because I wanted to preserve DFS property =
:)
> but I feel sooner or later we will be forced to explore non-DFS.
> So I think this patch is no go. There is really no need to rely on DFS he=
re.

If we ever break DFS property, we can easily change this. Or we can
even have a hybrid: as long as traversal preserves DFS property, we
use global shared history, but we can also optionally clone and have
our own history if necessary. It's a matter of adding optional
potentially NULL pointer to "local history". All this is very nicely
hidden away from "normal" code.

> Let instruction history consume more memory. It's a better long term trad=
e off.

Before we decide this, let me collect stats on how much memory we use
for jmp_history with and without my change. I'll need to add a bit of
temporary code to veristat and verifier to collect this, but it
shouldn't take much effort. OK?

> We don't do strict DFS today.
> The speculative execution analysis is DFS, but it visits paths
> multiple times, so it's not a canonical DFS.

Not sure I follow. It's still a DFS, we just branch out more.

But again, let's look at data first. I'll get back with numbers soon.

> It probably doesn't break this particular insn_hist approach,
> but still feels too fragile to rely on DFS assumption long term.

