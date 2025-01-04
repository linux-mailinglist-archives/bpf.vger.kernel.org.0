Return-Path: <bpf+bounces-47881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30244A01688
	for <lists+bpf@lfdr.de>; Sat,  4 Jan 2025 20:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB1DC1632DB
	for <lists+bpf@lfdr.de>; Sat,  4 Jan 2025 19:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DCB1D5140;
	Sat,  4 Jan 2025 19:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="iPAxaxp3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D1C25949A
	for <bpf@vger.kernel.org>; Sat,  4 Jan 2025 19:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736018759; cv=none; b=TIFiqlolBDv11vfV/cRIsV/qbQxnXfMxiQcgVcrnf0pAlLjIYPj5e3Lcslkqn6m/iecbXQWgOA8JR4FeKegDeE7VWCf9vDLz3n1O7cqSFMaaNiOHlFCz3mjtkfF143yMIMvIxXZjguSv61UDYv8KdJXE3I39LA/gjgC6939xf70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736018759; c=relaxed/simple;
	bh=0ynlzI2B8EBa6O8mmLl5vxycMH46WiDZc31TyMfnmio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IKKbpmqWGKdPHWRlsjqHaofrKA3uNe4X5qcE7CRngyHEZafO6EbWil9T13bUZwH5tgEJ99+4HnrjcjSJgo9yhqYi6YFWT3Zp6y7vd/DksmVtN7xPamlKRliSO/g1N3SmQL7BUOoy0txte/jDr7qDOtDjvGMkrN3p++196UAQK9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=iPAxaxp3; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e3978c00a5aso17423222276.1
        for <bpf@vger.kernel.org>; Sat, 04 Jan 2025 11:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1736018757; x=1736623557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7uE1JJF/ZNSDrWmxe6BghG8L2pAQ+tXmTSuuhEugXY=;
        b=iPAxaxp3Dd57gB8KVEQ40Yf14smpFE3pCBLVwdLVsTvP0KCTVOrFCozjkBdLm+cIK2
         epLY4pt2OFhSG0W0tQb/2MpTrmLuLwuOn6kb53e/ITnPyFn1EStuCcTLre4Cm7LpiQR6
         E010+UtUae9X7LLf8eITRzQQtYB27EianR0gRkXONVfd9EvK7zfsL16Mz73gK/t6r/yk
         ryWGNUR/rAsbI8U2Nftu4mCPeXT2UT4TKMDbpKorDIS3uNxJzklVExuNW/NBDRgbbLlG
         wbGCHG45lPC1ZKOIt9iRn8s/DWfY2OYQSX8f1pVmz6nV65UAiK6y3H5m71xFtrsYq6+y
         3aPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736018757; x=1736623557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7uE1JJF/ZNSDrWmxe6BghG8L2pAQ+tXmTSuuhEugXY=;
        b=G5UroD+qDiCtLYfQglkGzpkW0AXm3tyUtrmQO+LU1dMxsT6FbogpB1ufRmXoNSQ59j
         6og4BaO6so8bTbAdD+mo2wNYOgfkk7DOjczXoMPNGrsQ9pRO0gFixFRSO6GfzvDH2EbH
         lsSKLcXjtOTkUmPcgWzCcUab21vjJttNccfUxT59ysL9okAKdqklFm51ddgJ/ZRXfgwp
         wSC3tdtqexJnUACF0Q8n6U494UD7BECvoBCT9lyKHtE1nktMZMprUgx4F4M1vxWxzyk3
         4xeM5/K6iV/PjphA3d6HN5GMnyQotnMfFK1mw7FFhK6jd7kl/vlYBgbyLaR4EMPmJc+r
         GnuQ==
X-Gm-Message-State: AOJu0Yxm00bMIZITxcFbCOUS5PIFePylENwJOa0Bgwpn9EXtT6HDgyjV
	0Zj25iRJVSfiVxkxgvKL/QOWo/ljz1i/A2i491NTVxtJCRcNWHy6suD9MLMusN3QVWGybAf5+v2
	erWulg8loZ8bDhkqJp6cZKSd8Okwb2IGNKuOP693bS550rks2d/zisWbJ
X-Gm-Gg: ASbGncthzQVVPynxofqXW8rScWpfXuUNpAagK5fpAZcUu3B8FTzt4hp2V/TU8nfD7Am
	5XFjwIioxJq6Hy4Bl0WS3VGHaxLseCYAAhqh8
X-Google-Smtp-Source: AGHT+IGwENfN6Yp7BbHGuvXXCO6mQHvh8J9oHA9zNrm5BXvGNeTi45/PP39m1KmMsKvQgDUVDeVsiMemQ097pvneepE=
X-Received: by 2002:a05:690c:490c:b0:6e3:323f:d8fb with SMTP id
 00721157ae682-6f3f81152c3mr387809687b3.14.1736018756639; Sat, 04 Jan 2025
 11:25:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250101203731.1651981-1-emil@etsalapatis.com>
 <20250101203731.1651981-2-emil@etsalapatis.com> <ac3eda5992a9fbee296abcbc917d5521da0be83c.camel@gmail.com>
In-Reply-To: <ac3eda5992a9fbee296abcbc917d5521da0be83c.camel@gmail.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Sat, 4 Jan 2025 14:25:46 -0500
Message-ID: <CABFh=a66Fk70ipHbrq+Jh-hA33vHq0fOJd+R9=1tRA1t212CzQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] bpf: Allow bpf_for/bpf_repeat calls while holding a spinlock
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 2, 2025 at 1:02=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Wed, 2025-01-01 at 15:37 -0500, Emil Tsalapatis wrote:
> >  Add the bpf_iter_num_* kfuncs called by bpf_for in special_kfunc_list,
> >  and allow the calls even while holding a spin lock.
> >
> > Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
> > ---
>
> Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
> > @@ -19048,7 +19066,7 @@ static int do_check(struct bpf_verifier_env *en=
v)
> >                               if (env->cur_state->active_locks) {
> >                                       if ((insn->src_reg =3D=3D BPF_REG=
_0 && insn->imm !=3D BPF_FUNC_spin_unlock) ||
> >                                           (insn->src_reg =3D=3D BPF_PSE=
UDO_KFUNC_CALL &&
> > -                                          (insn->off !=3D 0 || !is_bpf=
_graph_api_kfunc(insn->imm)))) {
> > +                                          (insn->off !=3D 0 || !kfunc_=
spin_allowed(insn->imm)))) {
> >                                               verbose(env, "function ca=
lls are not allowed while holding a lock\n");
> >                                               return -EINVAL;
> >                                       }
>
>
> Nit: technically, 'bpf_loop' is a helper function independent of iter_num=
 API.
>      I suggest to change the name to is_bpf_iter_num_api_kfunc.
>      Also, if we decide that loops are ok with spin locks,
>      the condition above should be adjusted to allow calls to bpf_loop,
>      e.g. to make the following test work:
>

(Sorry for the duplicate, accidentally didn't send the email in plaintext)

Will do, bpf_iter_num_api_kfunc is more reasonable. For bpf_loops
AFAICT we would need to ensure the callback cannot sleep,
which would need extra checks/changes to the verifier compared to
bpf_for. IMO we can deal with it in a separate patch if we think
allowing it is a good idea.

> --- 8< -------------------------------------
> static int loop_cb(__u64 index, void *ctx)
> {
>         return 0;
> }
>
> SEC("tc")
> __success __failure_unpriv __msg_unpriv("")
> __retval(0)
> int bpf_loop_inside_locked_region2(void)
> {
>         const int zero =3D 0;
>         struct val *val;
>
>         val =3D bpf_map_lookup_elem(&map_spin_lock, &zero);
>         if (!val)
>                 return -1;
>
>         bpf_spin_lock(&val->l);
>         bpf_loop(10, loop_cb, NULL, 0);
>         bpf_spin_unlock(&val->l);
>
>         return 0;
> }
> ------------------------------------- >8 ---
>
>
>

