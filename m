Return-Path: <bpf+bounces-16813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1370180613B
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 23:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD312281E42
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 22:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5646FCF0;
	Tue,  5 Dec 2023 22:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XI6BBLn6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75808135
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 14:01:34 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40c0a03eb87so32263735e9.3
        for <bpf@vger.kernel.org>; Tue, 05 Dec 2023 14:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701813693; x=1702418493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1dbQTWwDH2AoFj8uWpKt1ZbAw0032lt6FUtZ046X2xQ=;
        b=XI6BBLn6xcDuSX4TCHRYnYwZo0DBNXHMTrFLtPQN/h6T03ZHevdqI1AxsZi33hopGk
         Imtiyr0DTiGpV6UVcJ9xvstQV6t9PjNItHzPO+ZN82ETfZa2cOka6RtruM6v+Hj6WsrD
         rx6nKo+JOfZ3REIPqaUhmy8rBcvCrzqwC2suYLYGi9yJ90wSBOs2wH8HF9ZOyaqhnw37
         c+DgezBlyAFa/p2Gryml2UyYNaSfuy6cYy1f4sNXGR7cPGBObvGBLHP2RoX+V4aNXCIE
         n0KQPDDPA0VwybPd4Gxm/+DHiODLHCkKxhV+4w1WVPWDAKfHfe0bqx2eKOX1woNmH8Rb
         j7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701813693; x=1702418493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1dbQTWwDH2AoFj8uWpKt1ZbAw0032lt6FUtZ046X2xQ=;
        b=ruy8s/OhVjaUEnHHEh+oQGHdsq8kw0da1GNQAZuOu51z5u3t3ULgv7ndiOLBRSzYYK
         f1YXtW92qIdrLvj1zdU5mawiS/x78FjuXaV5zdLr11vRlF71q2VaEqvnu+RF9Du5+lSX
         Od/qbSSHL3NGAs24tS52I3gZ1k+od3Px2E6cnwsmmc9Btwrnz+jCpJlzN6keQUu5IG7O
         k13Q40NRtmjv3ailp/9nYKi306C133HGxcAbJu9dovTiihLKgM384SsA3qfoP2vULxDv
         Un5MwLI4mpW+rsajyG5tXMUEwjdttZ9sXl+Zi+8Yy5kY/8dWnA8yH37GENKFPJzr9T0e
         Qpjw==
X-Gm-Message-State: AOJu0Yznou6ACmu7/hefTxtWUB/aSMK8izZyCbopevpRnodQnqKSFkeZ
	h71IXWI7CmjqYgHu7Kw7wNMcuiTPRMTCA7tnMP4=
X-Google-Smtp-Source: AGHT+IE33Mg5b/HQvqwngBhWfXBJFDw60TfDLwSF2QRDLB41//BD+357XmqFLfyBljGIPB6ODP7HlBmadofjotyJaNA=
X-Received: by 2002:a05:600c:1586:b0:40c:877:5230 with SMTP id
 r6-20020a05600c158600b0040c08775230mr1391wmf.365.1701813692761; Tue, 05 Dec
 2023 14:01:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205184248.1502704-1-andrii@kernel.org> <20231205184248.1502704-11-andrii@kernel.org>
In-Reply-To: <20231205184248.1502704-11-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 5 Dec 2023 14:01:21 -0800
Message-ID: <CAADnVQJQU6_16nc1PHUnMH3AK9NRLSfaXZwiueKG-ROK_Km-2g@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 10/10] bpf: use common instruction history
 across all states
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 10:43=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> Instead of allocating and copying instruction history each time we
> enqueue child verifier state, switch to a model where we use one common
> dynamically sized array of instruction history entries across all states.
>
> The key observation for proving this is correct is that instruction
> history is only relevant while state is active, which means it either is
> a current state (and thus we are actively modifying instruction history
> and no other state can interfere with us) or we are checkpointed state
> with some children still active (either enqueued or being current).
>
> In the latter case our portion of instruction history is finalized and
> won't change or grow, so as long as we keep it immutable until the state
> is finalized, we are good.
>
> Now, when state is finalized and is put into state hash for potentially
> future pruning lookups, instruction history is not used anymore. This is
> because instruction history is only used by precision marking logic, and
> we never modify precision markings for finalized states.
>
> So, instead of each state having its own small instruction history, we
> keep a global dynamically-sized instruction history, where each state in
> current DFS path from root to active state remembers its portion of
> instruction history.  Current state can append to this history, but
> cannot modify any of its parent histories.
>
> Because the insn_hist array can be grown through realloc, states don't
> keep pointers, they instead maintain two indices, [start, end), into
> global instruction history array. End is exclusive index, so
> `start =3D=3D end` means there is no relevant instruction history.
>
> This eliminates a lot of allocations and minimizes overall memory usage.

I still think it's too dangerous to rely on DFS here.
The algo would certainly save allocs, but to save memory we can simply do:

@@ -16128,6 +16128,7 @@ static void clean_verifier_state(struct
bpf_verifier_env *env,
                /* all regs in this state in all frames were already marked=
 */
                return;

+       clear_jmp_history(st);
        for (i =3D 0; i <=3D st->curframe; i++)
                clean_func_state(env, st->frame[i]);
 }

to achieve the same effect (it seems to work fine in tests).
I'm not sure how much memory it actually saves
(both above hack and this algo).
We probably need to augment veristat with cgroup memory.peak numbers
the way benchs/bench_htab_mem.c does.
This will give us a clear signal whether we're saving any memory or not.

Reusing the jmp history array this way also has a negative effect on kasan.
When arrays are separate any UAF or out-of-bounds are easier to catch.

So I pushed the first 9 patches to bpf-next.

