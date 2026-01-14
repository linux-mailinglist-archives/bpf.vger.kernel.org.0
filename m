Return-Path: <bpf+bounces-78804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EB3D1BF2B
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 02:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05D35301D0DD
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 01:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F4C2E54BB;
	Wed, 14 Jan 2026 01:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fplx9l7m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4F72D46A1
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 01:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768354514; cv=none; b=gVqgq858On8keUT9y0UlsZIL3Fty97h81/oQ31asBH+3ygVF9h8kobM2J1QCjG1TbyjEo/aGwGKDDbvnwsgO+GdpqoXTWRltK4WIjY/xopWwYXrW/KUlZgw8j8Au/1kJNeBnWwMPF8hFMwWoJrGTuZvFZ0Zjii8kOgu4vOUoRY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768354514; c=relaxed/simple;
	bh=0PILchQj3J76ZAr261KJtaEQ2QxT7WEQn+1Ge6Oxu6A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZVzY3OVgVpe5mMpTbZPCZuiDqsXTOAvuQKH6kjuofFO/2FPbACe6uEP4a8YQO6pf/6VObW1Walat2L1AvNNVmejTKo0iOSj5l0q+dGA8qWCmGnbYKxn+iRXeTNm2ZSYJl+444bkwEjzj/qG4I6yL1lZxNobeJxtRscUtV7UrGgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fplx9l7m; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29f1bc40b35so88884935ad.2
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 17:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768354512; x=1768959312; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ieZaHREaNUdn6zv47XqVz3diRO7gdSg8y8kBpzF75Sk=;
        b=Fplx9l7mxDdNLK29OA1kIVFJuNMtbZxtldMkWzcWsDk4IvMbeAgRaymG+x3XoBDSRG
         2xyuDZ4fkhFOyrbvgLh7eq9xfUtoy6jR0D/YB/AClyB4tPYpP3m7yCgdSmlFfThYv4IG
         Z8gRB3Tj/qNcWYyMahGSuMgRaQ5RMqUtw9RcJHEaMBtH08wDNCrNKYzC4AutoD/RqJxI
         uG6/G7xxtlAVvw7Qyx14vMbwQxs193/965CtNjdFYnVGoFZJFIXiFw6JgOmswiIZu4nS
         EtZMjyPx+PyH1/7ezlXeiJnE6eg26aODGCnH6g7mFXK8anTz2VndAdJrk/3FDosavZRN
         AvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768354512; x=1768959312;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ieZaHREaNUdn6zv47XqVz3diRO7gdSg8y8kBpzF75Sk=;
        b=OYMYggrj2lYtQf0OVKUnJuyaNpVyOVgTzE0Dx6r/QWKmXnxajEDeYulP41Cq4tNyhZ
         Tq62TkSYMUq95Yqcziwxszovtt2vB91YMk7qxh0SyTCSrZi/gik2y7MG2ua+TPcAItVp
         MmhqxJ5PczqQFu6o5+msT28yfuMvD2GDysSwZKQ7rSPcbuLOaOXpQszmO8EYZ/p5H9D4
         a1jE50POxT17DOD6VTmCkNYfbGFzUhwpNMLmUrmxnjSW8Vml52S64eud9eifJVVxTiEo
         UPchbQhiCEru4Key8X2eivK9TpAn7gukm5P0sHx4K8JEAiUYY1QjTFV/iSSh2CNZSGwP
         aHCA==
X-Forwarded-Encrypted: i=1; AJvYcCVjXhMjl4dmVz0T3knIhayWpgm/onNL6H1F7ooCsbkituogmm9ZxHfTS4KUvGIy7Vp5mM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWxClvkrQdgZbXuwpHfgfsjdb2fUfAUGJ+yMQ/PTcQhl+AdeBV
	VRkWdv+9AWneYNtWX8sC3ZTdOSf4qohs17d32+ye8kE+5tFzXl6WBH7e
X-Gm-Gg: AY/fxX7qIPn1ofeRCriFG119lArgzJhOTR70q6MKUoM4iJwcmIxLM5tPy71For/pct1
	+eIfJ2ti/sJ2izbifC5MOjEjST1htBKKXVyuBfAiZ7kRXXRbzL3n4z/Vfu8qWqSLnlI/Vic0798
	Gj/u6YeEFCtesdv9NNykVRE43FLUdIq3IiaUPYe5E5a/CmIFw+THezkulSv/aLzMoIRgoi+13Ml
	PEKvbZSpIVv4fkW1LpTexrR6cHTcs+bLqQeh4dTFsPpMV534U/STulvGY73TRtwO2uqgu/G9cSs
	JuK+DjgHspLBojByHIVP0hE3nJHcjfNYI56cGAVcSzbqfv+B1y2VYEBRZ7ux2ZL//h6SddR9mqP
	Xr8Xz6sc3am1baEHtiKN7IqamhSYgu2hUddIRGyuzp0GPfMJNvh4M70iUYuOy7TwRNimcXaCMSV
	HaQXaVBlW4ZtK2Qry4661HM0aoyTlfSonigjYAEoZ/
X-Received: by 2002:a17:902:d58a:b0:2a1:5d2:2e45 with SMTP id d9443c01a7336-2a599e7cc41mr11109465ad.59.1768354512488;
        Tue, 13 Jan 2026 17:35:12 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cd492fsm89974945ad.98.2026.01.13.17.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 17:35:12 -0800 (PST)
Message-ID: <b4a760ef828d40dac7ea6074d39452bb0dc82caa.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 03/10] bpf: Verifier support for
 KF_IMPLICIT_ARGS
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, Alan
 Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>,
 Jiri Kosina	 <jikos@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-input@vger.kernel.org,
 sched-ext@lists.linux.dev
Date: Tue, 13 Jan 2026 17:35:09 -0800
In-Reply-To: <c7e2a776-52f9-46ad-8422-3a9202bbd9f1@linux.dev>
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev>
	 <20260109184852.1089786-4-ihor.solodrai@linux.dev>
	 <952853dd064d5303a7e7ec8e58028e9ee88f2fad.camel@gmail.com>
	 <93ecdc25-aa5e-485b-8ff4-a9db3b585861@linux.dev>
	 <c7e2a776-52f9-46ad-8422-3a9202bbd9f1@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-01-13 at 15:48 -0800, Ihor Solodrai wrote:

[...]

> A follow up after a chat with Eduard.
>=20
> This change in check_kfunc_call() appears to be working:
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 092003cc7841..ff743335111c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13958,8 +13958,11 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>                 regs =3D branch->frame[branch->curframe]->regs;
> =20
>                 /* Clear r0-r5 registers in forked state */
> -               for (i =3D 0; i < CALLER_SAVED_REGS; i++)
> -                       mark_reg_not_init(env, regs, caller_saved[i]);
> +               for (i =3D 0; i < CALLER_SAVED_REGS; i++) {
> +                       u32 regno =3D caller_saved[i];
> +                       mark_reg_not_init(env, regs, regno);
> +                       regs[regno].subreg_def =3D DEF_NOT_SUBREG;
> +               }
> =20
>                 mark_reg_unknown(env, regs, BPF_REG_0);
>                 err =3D __mark_reg_s32_range(env, regs, BPF_REG_0, -MAX_E=
RRNO, -1);
>=20
> https://github.com/kernel-patches/bpf/actions/runs/20975419422
>=20
> Apparently, doing .subreg_def =3D DEF_NOT_SUBREG in mark_reg_not_init()
> breaks zero-extension tracking somewhere else.  But this is not
> directly relevant to the series.
>=20
> Eduard, Alexei, any concerns with this diff? Should I send a separate
> patch?

Imo this is acceptable to land this series but follow up investigation
is definitely needed. Either there is a bug and mark_reg_not_init() is
called in a context where upper 32-bits are still significant, or zero
extension related code can be improved to avoid patching in some cases.

Additional context for other reviewers, Ihor did two experiments:
- added '.subreg_def =3D DEF_NOT_SUBREG' to mark_reg_not_init(),
  which resulted in selftests failure;
- added '.subreg_def =3D DEF_NOT_SUBREG' as above, which worked fine.

Meaning that code in check_kfunc_call() is not a culprit.

