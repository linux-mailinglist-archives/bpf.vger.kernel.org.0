Return-Path: <bpf+bounces-70526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC4CBC27AB
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 21:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80FA03C81FD
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 19:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FD5223DED;
	Tue,  7 Oct 2025 19:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqGDiKS/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8DA21C9FD
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 19:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759864480; cv=none; b=dx64jWcxSpH0Gi6hr+VYBmlp7d1ytAmADveYhgcY3priDeMLnf8JxRyl5wQBBqis6RsjMzkVq7WLqcq2RSYKgeEfs9x/bCAxilyzXa934EIowrMSG15JpQzF8ttF3Lx67kMvUVQAMoHea1zIyDEqQFu/oAq5LIgPT/s1ZB1kMbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759864480; c=relaxed/simple;
	bh=azvAIw0hCrzIMOHoH1D3NXgcuhhoO6rAXRdfxBp562A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mBe3J9EKaW63EO2iApOR5DDpqlQHMWyEp4jww1e/AgOjVaEBCPoKwp0Y1A5coXngq8v4/1Qlt8QViePMp2LVVCpck9YJEMkHQEgLeLZ8i3/YrpHo9m+8dsyYLUz63knVXzih6V+BSeBfz88G3cVTB0qTl0kRKNpBvVehNsZQ+qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqGDiKS/; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-afcb7a16441so1080318566b.2
        for <bpf@vger.kernel.org>; Tue, 07 Oct 2025 12:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759864477; x=1760469277; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mm/0CKA0qPzdsSpET+K/UsFEKbj7s19ub7PSTszF/14=;
        b=iqGDiKS/wnV54oy3vKB86FGZBbYHxtiOzBYHQtrK7PwO5kx0c0g/OFIrW3izDpQTXs
         5/SKv7U30EDr2UiubIfvFvc+9TnILy4zQdAGDjIf7wwwCFi2gRs9WgCJOo3L9XfnMZ6k
         DjgOzq3NmbKBHN5syJUNusUfi4uHST0DIR+bs0a/EF0W9yRkJXsB5zTpvYQnTMC7xG89
         keRJmfw2crgFU7m1I5S5UZbDGtx7jeo7Vt3e1vwfNNdiExaEMR8yR2+Y4lEZp9+Mu0S4
         b07TQd80qkV/oZ8aexvd/VSCPLbesc/17H22aoR8//rH4IzbGRM2x+/Y3BZhTEeYAVQa
         redA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759864477; x=1760469277;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mm/0CKA0qPzdsSpET+K/UsFEKbj7s19ub7PSTszF/14=;
        b=XXzYqInxt2Ztgw1KZY46NeMMjSIlUZENo0kKh4+jFTe1JCfvk0bftMRe31nFQMlFF5
         JJu5XWXJ2Yg09JKHKfR+V8sa4KW2GNMbN/3//hJSNTHxaIZ+79rjJ+nLeEOQb2HCU3oe
         PnCtN2+Dy/tKJ0AEpb97tbBeqRALV3f1z5yMY0BXKMcWq+qeov8MzCKvpsTKOr+v3zqU
         yIWOrXNuLbvsgKMmnSikpcmEZs9R+MDnGBrl6+1s2ENKXxjWKV8LTi3Yln6rghP7GqRe
         FcafE2aAIcDmohSXOms9L6SkYJPVHc15kLxvBN9usyAzaXTMlZ6tZi952e4wjBUu483j
         EAVg==
X-Gm-Message-State: AOJu0YwzB8vX3S0QUh+9mu9S2qS+qk13ju4mKK16PTOQT0m+Yk+Zufir
	b+5/GyeWgog3CT+0mjgPYg1ye9V/SI2D569GpbR8eMsA7F32WRonbW6pE4O9dfA+NtbRpq/yJ5G
	VOr/BB81yu+EKRO8xRhrq1CzpHIqfh40=
X-Gm-Gg: ASbGncsAjoW2AruZkmSYe76x01OepNcav+xE672xFvrXpdb1kGRIRnJ5LlF4kdETzIu
	81uChLxRwSTqL4AAB9LumpRD6dZOujjYxUl/lq7W9BvGIpuoOegngMrS0Fd6CynfKGwyKAQ31P1
	QIGPrwGeY5DE98g+GlxzFRrDrdWaPkQENpjBllaSy2my+C0fZuPNo4BoliPgr5S/QYcIAC7hBxG
	a9u5EhBlnlSggiYO5KzNdGCmiPqYdj65X1NivzDDzklwQ2VN7ygQXhVw/LzzdRTW8HQvLvyk0Ad
	e4VLEcdkE8GfQVTHITGN5R7s1xRIdmML
X-Google-Smtp-Source: AGHT+IG9kBpYS8a1EkYusN99hrgyLaqHJPT3eMnewHFS8k03kT8Q+XK22A00rqQL8BEofKmv+VhmywLFq3n7igfXONg=
X-Received: by 2002:a17:907:7f0b:b0:b09:c230:12dc with SMTP id
 a640c23a62f3a-b50aa48d330mr93620866b.8.1759864476822; Tue, 07 Oct 2025
 12:14:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007014310.2889183-1-memxor@gmail.com> <20251007014310.2889183-2-memxor@gmail.com>
 <340fce3310df92a9a2cefb25e3eb2781424958e0.camel@gmail.com>
In-Reply-To: <340fce3310df92a9a2cefb25e3eb2781424958e0.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 7 Oct 2025 21:14:00 +0200
X-Gm-Features: AS18NWDXgAkxul8mkRI2q28dy2e-oFXczWlPtMHrXny7vgcfdcdktz9x_IBB_yA
Message-ID: <CAP01T75XqJZa5PCtWm29W3+G5y04ok5F7zM4Q-ge_z2kORuJ0Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Fix sleepable context for async callbacks
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Oct 2025 at 21:09, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Tue, 2025-10-07 at 01:43 +0000, Kumar Kartikeya Dwivedi wrote:
> > Fix the BPF verifier to correctly determine the sleepable context of
> > async callbacks based on the async primitive type rather than the arming
> > program's context.
> >
> > The bug is in in_sleepable() which uses OR logic to check if the current
> > execution context is sleepable. When a sleepable program arms a timer
> > callback, the callback's state correctly has in_sleepable=false, but
> > in_sleepable() would still return true due to env->prog->sleepable being
> > true. This incorrectly allows sleepable helpers like
> > bpf_copy_from_user() inside timer callbacks when armed from sleepable
> > programs, even though timer callbacks always execute in non-sleepable
> > context.
> >
> > Fix in_sleepable() to rely solely on env->cur_state->in_sleepable, and
> > initialize state->in_sleepable to env->prog->sleepable in
> > do_check_common() for the main program entry. This ensures the sleepable
> > context is properly tracked per verification state rather than being
> > overridden by the program's sleepability.
> >
> > The env->cur_state NULL check in in_sleepable() was only needed for
> > do_misc_fixups() which runs after verification when env->cur_state is
> > set to NULL. Update do_misc_fixups() to use env->prog->sleepable
> > directly for the storage_get_function check, and remove the redundant
> > NULL check from in_sleepable().
> >
> > Introduce is_async_cb_sleepable() helper to explicitly determine async
> > callback sleepability based on the primitive type:
> >   - bpf_timer callbacks are never sleepable
> >   - bpf_wq and bpf_task_work callbacks are always sleepable
> >
> > Add verifier_bug() check to catch unhandled async callback types,
> > ensuring future additions cannot be silently mishandled. Move the
> > is_task_work_add_kfunc() forward declaration to the top alongside other
> > callback-related helpers.
> >
> > Finally, update push_async_cb() to adjust to the new changes.
> >
> > Fixes: 81f1d7a583fa ("bpf: wq: add bpf_wq_set_callback_impl")
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
> > @@ -22483,7 +22495,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
> >               }
> >
> >               if (is_storage_get_function(insn->imm)) {
> > -                     if (!in_sleepable(env) ||
> > +                     if (!env->prog->sleepable ||
>
> This is not exactly correct.
> I think that this and the second patch need to be squashed.

I was mostly trying to reduce it to what it would evaluate to.
env->cur_state is always false, so the only check that matters is this one.
And we fix it separately in the next one. Unless I missed something.

>
> >                           env->insn_aux_data[i + delta].storage_get_func_atomic)
> >                               insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_ATOMIC);
> >                       else
>
> [...]

