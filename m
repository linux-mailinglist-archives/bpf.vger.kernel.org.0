Return-Path: <bpf+bounces-75766-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29963C94667
	for <lists+bpf@lfdr.de>; Sat, 29 Nov 2025 19:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D72153A798C
	for <lists+bpf@lfdr.de>; Sat, 29 Nov 2025 18:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25B7311961;
	Sat, 29 Nov 2025 18:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NF8LX/NQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B08311940
	for <bpf@vger.kernel.org>; Sat, 29 Nov 2025 18:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764440030; cv=none; b=oGrgJFARpWnjrtVvPiBVtuK7TkwNrpWo/ApFUrPU0362BnnD97fs9HvccJxdyOzlO67B+yjasP0Maw5NaD/FfRe9NqFOrD1T7BAyi7jZ00vv3pUAkuC4CVXBGSqC6p/9nC0u5UZEbegYbtZ9qPVdz3Pg6FQQ7FlWNoebnCLDqJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764440030; c=relaxed/simple;
	bh=hGmCiHMzDeM/mLMLgafbYnP9evti39YfoshNCcYNrvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CFleRyW2Es59y6+0wGnR2DpW78NwMU8fxoi1winUW9X9LE6ueEA/h6MASMV++GLOB1szfM+0j0vMFKcEBfvMTfpzVo1F96SfrqiBxMPjPJbBAKscDtSNtEXgEI/uCOC/IK+lQHzBkQvlPdx8VLZw1h+M4a3wicJTFYwIn0GEjrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NF8LX/NQ; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-42b3c965cc4so1259118f8f.0
        for <bpf@vger.kernel.org>; Sat, 29 Nov 2025 10:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764440026; x=1765044826; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=babwZtw4GoUOyWBJ6H7Xu7bCAkkgtcaKt38yzsSURxA=;
        b=NF8LX/NQv4G5lsnprw4MTWsSpdPRoAyhb+6WSfd98yG6eP0tOYSTIYx2YUbiWKxkZw
         2PesYUgepWd14TVEb6Mu1+olAlumfckagJ5pXgDyCbaeuBfLWK2M+viuDgswOSnzSK4e
         6YFRNuAJ/wy18UUyXtx1I7MinJQJ1+fWmCjSftYqXWvUp2uqyGAoBAdBr+rLtD+mleSD
         NwhcP/FCYaDReIbvFo7z8vwDPlEGAugpqnTVE7r1MBMV/5KbFA8T/lEcSnT/7riwsasz
         QUySBGac+BfD2itUuhHhUGZ6T2fK5WO9u8qxB7Z1Vgd5fjv0RWjC5HkjOzZ3MuewsWkH
         ZS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764440026; x=1765044826;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=babwZtw4GoUOyWBJ6H7Xu7bCAkkgtcaKt38yzsSURxA=;
        b=p2s7i36ah4Hv4xpEczyGDb4tmxbfhukrNEu6YXOordCqCQTdYX3UAsDnrsxnA3UdCA
         stbgcL7WmBuOUe6Y4aIznhbZIOnUCLe53yJe33gd/EzJnt/fYAyRqWY9KES+vbdWnvmX
         lyE3KS56Cz1ejnxus+7vOxlUuJIMRjCe7FHrotFxAo/FiuaFUKhgB+/QKKVcrV8lTvgN
         Fn8BsVlcm9Yw/ibqKvj0jYT9rg6gFXMxHZPlE86LcZc+s8ruYtgNqPJbC3WGDTOehWD3
         Obqia9ToWweyfGwPPM5EUnoWgZTAVTbTVj6FPSYqoHb2ilLmy1FL7VfSPClfZ8HCXiiC
         h/gA==
X-Gm-Message-State: AOJu0YyfbVE9ibvtmir93DIk3+Aze3Hu+F137kVGf0crdYH2SciK40Tx
	LBsgz+1R2oOPuCt1Rug1QdA1TQNRAsW33rPmyVvAyqJVd2jrxY5Ihxc6dvST5rGhnzs9l4JT6Tu
	/gh2XAedzwC1XXZVjvAkjVtZewBk0Lxs=
X-Gm-Gg: ASbGnctEwqt8pgu7EpDoB5zWfndPwZH0gZCI6mhL0H+BJime+ESmNW0m+c3I/5qTjgd
	qrpjDXoEUwaz4pVQRyVAByGVXEAZcUS59l59mvd5cJerMlayEtX+izLzhEkOPThHyRBiOU62UyG
	ZdU0nsti5gXaOdnBbnhuZwrGCX6iP0hEx0ARlT3G03Ogu2fLQFbaK1niRuLfCJcuvmyGoSPhrT6
	nx1NQGEEnXBGQwjXSRdVub4oDbSbZHyu31wPgrho4jWoGLh5BXSBgeLaOkp8lNl/MxKXnNvEN4W
	AA0glZRxCNsX3I8c5NguGBgcpIXKngRnaAH/i0WYlnPWoveFjaERogZhNaFJPQ==
X-Google-Smtp-Source: AGHT+IHN0RhbRhUZ3Q60MgUb/KbWSEGcPduihV1KlUtByjo4kFAC27hLnfhlZgDAxbF/HANYxFYKpXiO5LAAMo3J160=
X-Received: by 2002:a05:6000:4026:b0:425:7e33:b4a9 with SMTP id
 ffacd0b85a97d-42cc125247bmr41116204f8f.0.1764440026208; Sat, 29 Nov 2025
 10:13:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128232802.1031906-4-memxor@gmail.com> <6e191f28a7218efa8244704143b7ead2825210e3df003c7f025e0a5e94d82f8f@mail.kernel.org>
In-Reply-To: <6e191f28a7218efa8244704143b7ead2825210e3df003c7f025e0a5e94d82f8f@mail.kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 29 Nov 2025 19:13:10 +0100
X-Gm-Features: AWmQ_bkoDyw5IHXC0RqVIc6NpMg32DFXqtY2D1rVXpKujKcqAMV5p09GOcWK9ig
Message-ID: <CAP01T74YaASFYyp3ohN8pV3PJWHuoovcpJHGS9Kpyx_rU=SGLQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/6] rqspinlock: Use trylock fallback when
 per-CPU rqnode is busy
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ritesh@superluminal.eu, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	eddyz87@gmail.com, jelle@superluminal.eu, kkd@meta.com, kernel-team@meta.com, 
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Sat, 29 Nov 2025 at 02:12, <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
> > index d160123e2..e602cbbbd 100644
> > --- a/kernel/bpf/rqspinlock.c
> > +++ b/kernel/bpf/rqspinlock.c
> > @@ -440,10 +440,25 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
> >  queue:
> >       lockevent_inc(lock_slowpath);
> >       /* Deadlock detection entry already held after failing fast path. */
> >       node = this_cpu_ptr(&rqnodes[0].mcs);
> >       idx = node->count++;
>
> Can an NMI interrupt between the load and store operations of this
> non-atomic increment? If so, both the interrupted context and the NMI
> could read count=0, increment it, and both end up with idx=0.
>
> Looking at the structure definition in include/asm-generic/mcs_spinlock.h,
> the count field is a plain int, not atomic_t. The sequence for count++
> typically compiles to separate load/add/store instructions.
>
> If an NMI fires after the load but before the store completes:
>
>   Process context: loads count=0
>   << NMI interrupts >>
>   NMI context: loads count=0, stores count=1, gets idx=0
>   NMI: Checks (in_nmi() && 0 > 0) = false, proceeds to queue path
>   NMI: Uses rqnodes[0]
>   << Process resumes >>
>   Process: stores count=1, gets idx=0
>   Process: Also uses rqnodes[0]
>
> Both contexts would then call grab_mcs_node(node, 0) and corrupt the
> same queue node's locked and next fields.
>
> The old code had this race too, but it was harmless because in_nmi()
> was always true, forcing the fallback path. Now that NMIs with idx=0
> can enter the normal queue path, does this race become exploitable?

Great observation, but since the NMI (or any other interrupt)
concludes its usage of the node before it returns to the lower
context, the values it overwrote do not matter, and the lower context
will continue using things at idx=0. The key thing is for the store of
count=1 to be done before the lower context starts writing anything to
the node, which is why there is a compiler barrier() to prevent the
compiler from reordering any statements. If it initializes the node
before storing in count=1, then the values overwritten by the
NMI/interrupt could cause node corruption.

>
> >       tail = encode_tail(smp_processor_id(), idx);
> >
> >       trace_contention_begin(lock, LCB_F_SPIN);
> >
> >       /*
> >        * 4 nodes are allocated based on the assumption that there will
> >        * not be nested NMIs taking spinlocks. That may not be true in
> >        * some architectures even though the chance of needing more than
> >        * 4 nodes will still be extremely unlikely. When that happens,
> >        * we fall back to spinning on the lock directly without using
> >        * any MCS node. This is not the most elegant solution, but is
> >        * simple enough.
> >        */
> > -     if (unlikely(idx >= _Q_MAX_NODES || in_nmi())) {
> > +     if (unlikely(idx >= _Q_MAX_NODES || (in_nmi() && idx > 0))) {
> >               lockevent_inc(lock_no_node);
> >               RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19775799393

