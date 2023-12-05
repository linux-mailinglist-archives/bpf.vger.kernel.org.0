Return-Path: <bpf+bounces-16820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 788168062DA
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 00:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30D79281EDE
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 23:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734AD41204;
	Tue,  5 Dec 2023 23:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAXnoi5o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE5B122
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 15:20:54 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a19ce1404e1so24919966b.3
        for <bpf@vger.kernel.org>; Tue, 05 Dec 2023 15:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701818453; x=1702423253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbCHyU0oVlhTTs42jDkdQgpCv09NwfXdCFyrLr9gjlo=;
        b=aAXnoi5oyTe5yBes0WG9FA9gvU+9ksnuds1052q4oAtbCyz9+31Rnr7+Es5gna5MPd
         YCq/p/US64UC8e7rHIrwLpQDVDxPHV2u50MM/e5NeQccoRhBmtQRnIFSrTkrAWPb0KUT
         fu3cvqQYd1TqVUGFEGSX0maSoGlA4xNI92gN4ZU+vujSo42MvCnyCUsxoj7vnwNSrJqs
         bInhMj7U1kUQAYK9aXjhtwh8Zw69II3OkSiVGW7OtuI8RRsh3m9CLw4u+KS2i5yYjwu9
         ZZtiLRtMsgBkgQ1T8hadn+F+VUTlfCYsKIRdPpmXi7voSo3v+2oGAgSCEopQEzr+mZnu
         OtZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701818453; x=1702423253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QbCHyU0oVlhTTs42jDkdQgpCv09NwfXdCFyrLr9gjlo=;
        b=m++At8TzxxbBVILdb5eJGUbFPTXVXoMNVNV06uCAD2hU9mA0DUleT5wnzaPMBQAwzA
         20aH47C3rA4C0JL8TzkzUCzuYA1nwrKF4s0ERkkAITKjy4CRqOs+82LwXss1plzwUuS1
         QIY1mgp3qujqFfbGaq3F94SyHUrZpjW+R89VNiUvw3WMy5DE7wL92garySyNC2Qa1Z5N
         GMDmwsdLzUun4lkGPh/LG4XbIOBqA0C0LKtzCux3gtM/eJjhmevzBi5wDLKkAq4j1ZkU
         rUgRk0ybXdQJHFtA3zMxPj4XB6qDH0JncPpTA4AH1CYo0QOv8Zc/mMdpROYhG/a5Z40j
         EPaA==
X-Gm-Message-State: AOJu0YzqdOFSC0rmr1QNBgi7YOCQ11tGNVwVTQNeuEZ4Cr/peSWnQ/Dl
	s9+OX/A1svRBH8lTso9ySmwtvnr/jeJCcztTHGMu8CJ3
X-Google-Smtp-Source: AGHT+IHX+gw/BeF/RdztaN6LJywai9q/jm7h1Tf0zd2rRZ5iTmA7tke9TDtl/Zhx8rmKVZDagLD53KErnETmDVOyGdI=
X-Received: by 2002:a17:906:fa9a:b0:a01:811c:ce9 with SMTP id
 lt26-20020a170906fa9a00b00a01811c0ce9mr25832ejb.0.1701818452891; Tue, 05 Dec
 2023 15:20:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205184248.1502704-1-andrii@kernel.org> <20231205184248.1502704-11-andrii@kernel.org>
 <CAADnVQJQU6_16nc1PHUnMH3AK9NRLSfaXZwiueKG-ROK_Km-2g@mail.gmail.com>
In-Reply-To: <CAADnVQJQU6_16nc1PHUnMH3AK9NRLSfaXZwiueKG-ROK_Km-2g@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 5 Dec 2023 15:20:40 -0800
Message-ID: <CAEf4BzatLqKviHZ1+Q3xeJxOpPTUhaasw0wo_n0m8tqE6O=KXQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 10/10] bpf: use common instruction history
 across all states
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 2:01=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Dec 5, 2023 at 10:43=E2=80=AFAM Andrii Nakryiko <andrii@kernel.or=
g> wrote:
> >
> > Instead of allocating and copying instruction history each time we
> > enqueue child verifier state, switch to a model where we use one common
> > dynamically sized array of instruction history entries across all state=
s.
> >
> > The key observation for proving this is correct is that instruction
> > history is only relevant while state is active, which means it either i=
s
> > a current state (and thus we are actively modifying instruction history
> > and no other state can interfere with us) or we are checkpointed state
> > with some children still active (either enqueued or being current).
> >
> > In the latter case our portion of instruction history is finalized and
> > won't change or grow, so as long as we keep it immutable until the stat=
e
> > is finalized, we are good.
> >
> > Now, when state is finalized and is put into state hash for potentially
> > future pruning lookups, instruction history is not used anymore. This i=
s
> > because instruction history is only used by precision marking logic, an=
d
> > we never modify precision markings for finalized states.
> >
> > So, instead of each state having its own small instruction history, we
> > keep a global dynamically-sized instruction history, where each state i=
n
> > current DFS path from root to active state remembers its portion of
> > instruction history.  Current state can append to this history, but
> > cannot modify any of its parent histories.
> >
> > Because the insn_hist array can be grown through realloc, states don't
> > keep pointers, they instead maintain two indices, [start, end), into
> > global instruction history array. End is exclusive index, so
> > `start =3D=3D end` means there is no relevant instruction history.
> >
> > This eliminates a lot of allocations and minimizes overall memory usage=
.
>
> I still think it's too dangerous to rely on DFS here.
> The algo would certainly save allocs, but to save memory we can simply do=
:
>
> @@ -16128,6 +16128,7 @@ static void clean_verifier_state(struct
> bpf_verifier_env *env,
>                 /* all regs in this state in all frames were already mark=
ed */
>                 return;
>
> +       clear_jmp_history(st);
>         for (i =3D 0; i <=3D st->curframe; i++)
>                 clean_func_state(env, st->frame[i]);
>  }
>
> to achieve the same effect (it seems to work fine in tests).
> I'm not sure how much memory it actually saves
> (both above hack and this algo).
> We probably need to augment veristat with cgroup memory.peak numbers
> the way benchs/bench_htab_mem.c does.

yep, would definitely be useful to know overall memory usage for verificati=
on

> This will give us a clear signal whether we're saving any memory or not.
>
> Reusing the jmp history array this way also has a negative effect on kasa=
n.
> When arrays are separate any UAF or out-of-bounds are easier to catch.
>
> So I pushed the first 9 patches to bpf-next.

thanks. I'll keep the patch around, and if/when we add memory stats to
veristat, I'd be curious to measure the difference

