Return-Path: <bpf+bounces-44444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AA79C2FFC
	for <lists+bpf@lfdr.de>; Sun, 10 Nov 2024 00:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF8652822CF
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 23:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAB01A08B8;
	Sat,  9 Nov 2024 23:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRVDPz+i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3D08C07
	for <bpf@vger.kernel.org>; Sat,  9 Nov 2024 23:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731193392; cv=none; b=AFH7P+0xvOe7Ayd95lSTQeqEa4YmTBuB1oWnyxNPEoxMYx65Jq84gjDvX3LNEABynL4CIFIcAEieRCU3aHIrlcrhxickP3K9bDbh+h2imRFv+1mG41DrH7ho+7NpPPngl0G3+EE2UdE9pywfQbCLmOY2Sh+iRYiyZcwcG6501LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731193392; c=relaxed/simple;
	bh=6DKHaOdc2TVCtD8hDcKjpooidcxule2FsNLFRhtnB90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mquvf9vanKJeHqGfJc72PB3E6lJO0x/czf0rQEeLzuQ8rqHfit4zByeIsVjPVgVMxgDJLp+ygna49l/TqWvEnwBbjC4GAW7MNjZswlDdwCQW5ogSeizXt0jmBipK6gVxY+jfxno9oxaxJpXW28VYm3RVnT5H9I9nCjTFLORyDTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRVDPz+i; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d4821e6b4so2340337f8f.3
        for <bpf@vger.kernel.org>; Sat, 09 Nov 2024 15:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731193389; x=1731798189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHRS9za8DyW46N9AnZhs2oD7nptMMy34u1OnNKURyZ8=;
        b=JRVDPz+iQEk2qjQumwSF919i4Hce38y/hHPeL40RT/y74FKU6TadMy57EpdKwQTDQ/
         TrowD7U4QZ65xQ6gmyGDmGv4Ye1Z9g+Ig8KSDasnsWO+nDkJyszPQHpQ3/U4dKSWPi8w
         T4Mqdjnzkl39NCoGYzszOo1llJwQv8nTPLKC5t056b2BOpY98gCCAeNQEJ/f86NZB9l3
         fx61g+AT8CdONFAj/Lv84qb7CDAsjbWdU3LwDBYlHLCefSDHgj/jj8nf/aWP0Cjqia+7
         jK28c/UflUQooxlYuduNfPwzzYDDG3KIkxxaaBHbCj6ppMke8uZhMCPj3NYfOAfqm6Lq
         Fy+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731193389; x=1731798189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHRS9za8DyW46N9AnZhs2oD7nptMMy34u1OnNKURyZ8=;
        b=E0ulq/Vlog/Z4w0AXfcGp+7dWekjjDaHigAy3zB/frRTCyD4/5B//Pj5S2xZ+pZWmR
         pSzXm2SUi5+hIJQCJUV0VARbqErm3SwTnx6XW+3ZPb793l45U4YGNx195dySNMeBuFYX
         VMXwfkrE9xzfvy70bnAMy6PMVXPdDXrUkVuN5itVOlRu8oc5UiYszFo2+mpVOQFgiyx3
         iGCpv52EvvRLUa8cmNy/b/23vzZ2JHGrC1CKa5QkmcS7ovBRkDLrKPF4ek32wqQAm180
         4K93ipHQnsHLt/Lgn8Ibv6sonwXNSJojWLR+9XsvV9A09jKc3Zry5QAJudOduinwO2G9
         82xQ==
X-Gm-Message-State: AOJu0YzKEPPubmzM3rCoiEsbyAsbgeAdwcZbep7sHfKi+IxXJgRzIE3o
	wJ0l4zyP32UXv0PvFCZo41goT8OPhj/L/gGLiS+tY5J5CYdaPx1K5/Aiiy9U8YdyWqwwT0hpH+6
	EBPJi1I7u/k5kOrWjykkahfoC6Do=
X-Google-Smtp-Source: AGHT+IEvbuNsNb6QW91PxtFUE13QE3r31FFC+O9V6ClSP6c1A8O4rGYVWTcRDYifwtJEpK5npKJtVnkndlzXdfm++xM=
X-Received: by 2002:a05:6000:1564:b0:381:d014:9be0 with SMTP id
 ffacd0b85a97d-381f186c6a3mr6674501f8f.17.1731193388859; Sat, 09 Nov 2024
 15:03:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109225243.2306756-1-memxor@gmail.com> <20241109225243.2306756-2-memxor@gmail.com>
In-Reply-To: <20241109225243.2306756-2-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 9 Nov 2024 15:02:57 -0800
Message-ID: <CAADnVQK_qEsdjvp=n0vLAX3hRJCBL=YRFduaz-rxHZ-3VqAijg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/2] bpf: Refactor active lock management
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 9, 2024 at 2:52=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
> +               err =3D acquire_lock_state(env, env->insn_idx, REF_TYPE_L=
OCK, reg->id, ptr);
> +               if (err < 0) {
> +                       verbose(env, "Failed to acquire lock state\n");
> +                       return err;
> +               }
> +               /* It is not safe to allow multiple bpf_spin_lock calls, =
so
> +                * disallow them until this lock has been unlocked.
> +                */
> +               cur->active_locks++;

One more thing as suggested earlier...

pls move active_locks++ into acquire_lock_state().

>         } else {
>                 void *ptr;
>
> @@ -7786,20 +7856,18 @@ static int process_spin_lock(struct bpf_verifier_=
env *env, int regno,
>                 else
>                         ptr =3D btf;
>
> -               if (!cur->active_lock.ptr) {
> +               if (!cur->active_locks) {
>                         verbose(env, "bpf_spin_unlock without taking a lo=
ck\n");
>                         return -EINVAL;
>                 }
> -               if (cur->active_lock.ptr !=3D ptr ||
> -                   cur->active_lock.id !=3D reg->id) {
> +
> +               if (release_lock_state(cur_func(env), REF_TYPE_LOCK, reg-=
>id, ptr)) {
>                         verbose(env, "bpf_spin_unlock of different lock\n=
");
>                         return -EINVAL;
>                 }
>
>                 invalidate_non_owning_refs(env);
> -
> -               cur->active_lock.ptr =3D NULL;
> -               cur->active_lock.id =3D 0;
> +               cur->active_locks--;

And similar with decrement.
imo it's cleaner this way.

The rest looks good.

Patch 2 is a nice cleanup. Thanks!

