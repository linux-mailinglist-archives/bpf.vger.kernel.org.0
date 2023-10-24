Return-Path: <bpf+bounces-13127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7F27D4F49
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 13:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B7C2819D0
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 11:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D596266C7;
	Tue, 24 Oct 2023 11:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnLKppln"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FB6266BE
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 11:57:37 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F491128
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 04:57:35 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9c603e235d1so668040866b.3
        for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 04:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698148654; x=1698753454; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m4LeC00/S+EYTDtV9tfzaKOyYSJS2b0GbP02QDZLd7E=;
        b=YnLKpplnG5lzv1PD0F54yiBbBq//tTOJJSTHZ0v1XbMxTO/DtxI5/LrNg7PXX/IT8y
         UAnJBd0Cv2EMCSAOMgO0dOjyJw+fCfKVUptO5vo6jJwS/ZNUWl+5AkdGWUR1ixJCi9LN
         vH+EFU1FzD2NLPlk1ae5kiG5Laz+N7oL4TYZCsJBaXzHTar2oQkepASFK1/M1AXRnUU/
         RNTdx7g4nHlGG8gwWUirz5JniLAarMRaORRIwHhUhgJ3iBamyTrrrGhP4gutRlrCoYo+
         2q5mTp+9zBFkHqtDzG46NVAPNWijgcJ/hRMBI6/EbS+uvUpkuFeeae0zRDsBCRYL81kL
         hblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698148654; x=1698753454;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m4LeC00/S+EYTDtV9tfzaKOyYSJS2b0GbP02QDZLd7E=;
        b=aHBDtkIkhZ3VLFLpCM/nmozMBgHSf9j76CXk/aRHRhsTAVmO/AxLqMUcF9yldLoSk9
         NzUjcBX2oWNlM7vshC6v3YkeqPzNvCbCmvUX7FYPMoAUqhi/7fCxb80PZaefz1h/0rVK
         /00ocfvnazOeYcyLfPPf8BLw3Y73hPbO3XGiSDRzB2dCzJJsRT4mm4KJhJ8+7vZ57Ndi
         ++fOUJHNN9tq9oG/xB9GFRZmlcn9bTTVDsnB973i5GfrnvcJBpnP4Zn778LBDUlKAfgQ
         0RcBQ+U+R854t3dIpGwtfKuESEcVlGB0O7VJynpyjuf6HUldFFTH8a9G075oBYtlG3Gm
         5c1A==
X-Gm-Message-State: AOJu0YzjSk2Xjsy37N2yMbJc5+apiU/Z+CyrGhTRMpTvrUjalrw3XvtE
	zFJAnbcQ1dLpa6QP3o13Hd4=
X-Google-Smtp-Source: AGHT+IEnhru6v0UHwk151kXPXAtlWrTRI9hMIB3J22IJY3BWHBAx+ckUxTJyeVFKDa4g5tHNhWGDVg==
X-Received: by 2002:a17:907:7e8b:b0:9a1:aea2:d18d with SMTP id qb11-20020a1709077e8b00b009a1aea2d18dmr9419857ejc.48.1698148653655;
        Tue, 24 Oct 2023 04:57:33 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id sd26-20020a170906ce3a00b009a5f1d15644sm8122081ejb.119.2023.10.24.04.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 04:57:33 -0700 (PDT)
Message-ID: <8be57ef5f403c123296cde2af81492a7cc18fd72.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 0/7] exact states comparison for iterator
 convergence checks
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  memxor@gmail.com, awerner32@gmail.com,
 john.fastabend@gmail.com
Date: Tue, 24 Oct 2023 14:57:31 +0300
In-Reply-To: <CAEf4BzZKBq+nJdcUyD4_UcU1joojzuaHDaVp1Tb=MfXyUu-MLg@mail.gmail.com>
References: <20231024000917.12153-1-eddyz87@gmail.com>
	 <CAEf4BzZKBq+nJdcUyD4_UcU1joojzuaHDaVp1Tb=MfXyUu-MLg@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-10-23 at 22:58 -0700, Andrii Nakryiko wrote:
> On Mon, Oct 23, 2023 at 5:09=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > Iterator convergence logic in is_state_visited() uses state_equals()
> > for states with branches counter > 0 to check if iterator based loop
> > converges. This is not fully correct because state_equals() relies on
> > presence of read and precision marks on registers. These marks are not
> > guaranteed to be finalized while state has branches.
> > Commit message for patch #3 describes a program that exhibits such
> > behavior.
> >=20
> > This patch-set aims to fix iterator convergence logic by adding notion
> > of exact states comparison. Exact comparison does not rely on presence
> > of read or precision marks and thus is more strict.
> > As explained in commit message for patch #3 exact comparisons require
> > addition of speculative register bounds widening. The end result for
> > BPF verifier users could be summarized as follows:
> >=20
> > (!) After this update verifier would reject programs that conjure an
> >     imprecise value on the first loop iteration and use it as precise
> >     on the second (for iterator based loops).
> >=20
> > I urge people to at least skim over the commit message for patch #3.
> >=20
> > Patches are organized as follows:
> > - patches #1,2: moving/extracting utility functions;
> > - patch #3: introduces exact mode for states comparison and adds
> >   widening heuristic;
> > - patch #4: adds test-cases that demonstrate why the series is
> >   necessary;
> > - patch #5: extends patch #3 with a notion of state loop entries,
> >   these entries have to be tracked to correctly identify that
> >   different verifier states belong to the same states loop;
> > - patch #6: adds a test-case that demonstrates a program
> >   which requires loop entry tracking for correct verification;
> > - patch #7: just adds a few debug prints.
> >=20
> > The following actions are planned as a followup for this patch-set:
> > - implementation has to be adapted for callbacks handling logic as a
> >   part of a fix for [1];
> > - it is necessary to explore ways to improve widening heuristic to
> >   handle iters_task_vma test w/o need to insert barrier_var() calls;
> > - explored states eviction logic on cache miss has to be extended
> >   to either:
> >   - allow eviction of checkpoint states -or-
> >   - be sped up in case if there are many active checkpoints associated
> >     with the same instruction.
> >=20
> > The patch-set is a followup for mailing list discussion [1].
> >=20
> > Changelog:
> > - V2 [3] -> V3:
> >   - correct check for stack spills in widen_imprecise_scalars(),
> >     added test case progs/iters.c:widen_spill to check the behavior
> >     (suggested by Andrii);
> >   - allow eviction of checkpoint states in is_state_visited() to avoid
> >     pathological verifier performance when iterator based loop does not
> >     converge (discussion with Alexei).
> > - V1 [2] -> V2, applied changes suggested by Alexei offlist:
> >   - __explored_state() function removed;
> >   - same_callsites() function is now used in clean_live_states();
> >   - patches #1,2 are added as preparatory code movement;
> >   - in process_iter_next_call() a safeguard is added to verify that
> >     cur_st->parent exists and has expected insn index / call sites.
> >=20
> > [1] https://lore.kernel.org/bpf/97a90da09404c65c8e810cf83c94ac703705dc0=
e.camel@gmail.com/
> > [2] https://lore.kernel.org/bpf/20231021005939.1041-1-eddyz87@gmail.com=
/
> > [3] https://lore.kernel.org/bpf/20231022010812.9201-1-eddyz87@gmail.com=
/
> >=20
> > Eduard Zingerman (7):
> >   bpf: move explored_state() closer to the beginning of verifier.c
> >   bpf: extract same_callsites() as utility function
> >   bpf: exact states comparison for iterator convergence checks
> >   selftests/bpf: tests with delayed read/precision makrs in loop body
> >   bpf: correct loop detection for iterators convergence
> >   selftests/bpf: test if state loops are detected in a tricky case
> >   bpf: print full verifier states on infinite loop detection
> >=20
> >  include/linux/bpf_verifier.h                  |  16 +
> >  kernel/bpf/verifier.c                         | 475 ++++++++++--
> >  tools/testing/selftests/bpf/progs/iters.c     | 695 ++++++++++++++++++
> >  .../selftests/bpf/progs/iters_task_vma.c      |   1 +
> >  4 files changed, 1133 insertions(+), 54 deletions(-)
> >=20
> > --
> > 2.42.0
> >=20
>=20
> Thanks a lot for working on this and getting it to the end despite
> many setbacks and ambiguity, great work!

Thank you and Alexei for working on it as well.
We'll see if this patch-set is good enough or the idea with
computing fixed point for read and precision marks has to be finalized.

