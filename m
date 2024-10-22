Return-Path: <bpf+bounces-42737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C12759A9737
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 05:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 128C128329A
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 03:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B1F13B297;
	Tue, 22 Oct 2024 03:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFF786au"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807CB256D
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 03:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729568604; cv=none; b=aatBLNnSLnKiZu93wwcfxe+Vif6mcgUA/qXrmhKNK8sj4YYGreL8FF8tlUdJSY/sp1seZ/gV+XbOrPgt6IvQVgCZZJFrlVUnfpv2ntEfzo6YIxwfN0YiT4rT4/XURKdNxIWOpMY6CQBR8bnD5x7zOLvFqGabujukWGot00QjO5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729568604; c=relaxed/simple;
	bh=AUWXLJID5z0sxUD/n2Th3/YtV09Cz1NyV2kH2eG6Drg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hEc6edjp0iH9BQOrqhz+TJOIT23DH0PPXb4yAjx1R294xzBHvcy0m2Onh8cB6hl4ls+UHjDUWgBqYc2lE6MMBJz371Pf5WeptORsZ7cQrrNEAFCo+Pf9/D9olcg6iFY9tguHijHiTlOklYWGoKhztktqPp6EFUD8M2YsjhTGLIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFF786au; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4315839a7c9so56751985e9.3
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 20:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729568601; x=1730173401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGJuWA4JeXb4N9GLipe+6q6s/MxPTpGAOU5UTguQ20Y=;
        b=KFF786auivpilERYEVsbddYtQRnjB5V//XsAgZ9Ug2YMnZwGolmhcnfSxnMWiKbWXE
         K8GVQ1aDwMatUdxFdxQI8fgNozCnGz8fKANV0IP0/OVDIGfvjUoR9JX81xT6a4lg/qm9
         3FGnrhT/ahbYJa5qsxcla85cEd37fF6dZGBrBT51oDnXHAatu7z+sLrKWLdQyBmsmvNE
         yzgPGN3s1UhzvBK8Wx6J/d25fSfFSV+C+PJj1VYT+5OwDkBhoTa+Mg4AiJ5mM8BKa7wo
         IuCptgcb8NMd+khHo2IMXxNvMFtPDuySbq+C4syElYAFqyHbG7+5Trbza+PwrTYhjmf9
         ApyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729568601; x=1730173401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PGJuWA4JeXb4N9GLipe+6q6s/MxPTpGAOU5UTguQ20Y=;
        b=KGa6xKsAfh5ffc29Oef9c/ChbZbnE+ruUsISBPDWZzrxTUtMPWU409opXrX88L7cce
         xvG/TtP2BgVZWVbamOFN3Bul9PfQkXnahxcrHZbptZD/JLAffVQ4L92ExSkweR8+DT2y
         Z+kQZic6TdOuqTcBjRo9V5lWoIo348ivrs9bUirodMT6/bCflaWu32xFFucNV1Gm2894
         60DwxJh3IBOLHohuWLWPOZJhwkKIB0Tnrb5HIuMGiEsVIGmH/Y53UtnbPTNej5LN6LOK
         2qsTIqJxrtRu20C2IGYLqVcQ1mPP9kAt+dYbmtsITLoYyVT3qfkz0FIllH9wpM3cW0N1
         ug8A==
X-Gm-Message-State: AOJu0YxKPGLGLZl9g32FeWNLuHVtG+72Wm+ra37queQzfYD5HctT1t1m
	cwx+IW4P3xOYXlSlwQwjmr1Dp5UjaPrqSZ9MtiuX7hl44jEDyCs56W9ylkKCj5v6Dxh+7jnLlSh
	B3D/yzF6o54Os/ArZvCHQWWk+Ngo=
X-Google-Smtp-Source: AGHT+IFQY7vteDiNoC67l0ub3aT0Wpu1GvUMCZuPJ7/poYOpfn45WD7uXvuWLJ9+J6xGEj41IxgGno8liD5xAu5fJDg=
X-Received: by 2002:adf:a34e:0:b0:37d:4b73:24c0 with SMTP id
 ffacd0b85a97d-37eb4896bcemr8169880f8f.35.1729568600452; Mon, 21 Oct 2024
 20:43:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020191341.2104841-1-yonghong.song@linux.dev>
 <20241020191347.2105090-1-yonghong.song@linux.dev> <CAADnVQ+ZXMh_QKy0nd-n7my1SETroockPjpVVJOAWsE3tB_5sg@mail.gmail.com>
 <c6e5040b-9558-481f-b1fc-f77dc9ce90c1@linux.dev>
In-Reply-To: <c6e5040b-9558-481f-b1fc-f77dc9ce90c1@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 21 Oct 2024 20:43:08 -0700
Message-ID: <CAADnVQJCfiNEgrvf6GuaUadz6rDSNU6QB3grpOfk2-jQP6is4Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/9] bpf: Allow each subprog having stack size
 of 512 bytes
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 8:21=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> >>          for (int i =3D 0; i < env->subprog_cnt; i++) {
> >> -               if (!i || si[i].is_async_cb) {
> >> -                       ret =3D check_max_stack_depth_subprog(env, i);
> >> +               check_subprog =3D !i || (check_priv_stack ? si[i].is_c=
b : si[i].is_async_cb);
> > why?
> > This looks very suspicious.
>
> This is to simplify jit. For example,
>     main_prog   <=3D=3D=3D main_prog_priv_stack_ptr
>       subprog1  <=3D=3D=3D there is a helper which has a callback_fn
>                 <=3D=3D=3D for example bpf_for_each_map_elem
>
>         callback_fn
>           subprog2
>
> In callback_fn, we cannot simplify do
>     r9 +=3D stack_size_for_callback_fn
> since r9 may have been clobbered between subprog1 and callback_fn.
> That is why currently I allocate private_stack separately for callback_fn=
.
>
> Alternatively we could do
>     callback_fn_priv_stack_ptr =3D main_prog_priv_stack_ptr + off
> where off equals to (stack size tree main_prog+subprog1).
> I can do this approach too with a little more information in prog->aux.
> WDYT?

I see. I think we're overcomplicating the verifier just to
be able to do 'r9 +=3D stack' in the subprog.
The cases of async vs sync and directly vs kfunc/helper
(and soon with inlining of kfuncs) are getting too hard
to reason about.

I think we need to go back to the earlier approach
where every subprog had its own private stack and was
setting up r9 =3D my_priv_stack in the prologue.

I suspect it's possible to construct a convoluted subprog
that calls itself a limited amount of time and the verifier allows that.
I feel it will be easier to detect just that condition
in the verifier and fallback to the normal stack.

