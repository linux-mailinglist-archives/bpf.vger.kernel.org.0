Return-Path: <bpf+bounces-31550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 734F08FF8A9
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2024 02:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC1A7286E0E
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2024 00:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B7D1843;
	Fri,  7 Jun 2024 00:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUNJPI77"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCE21847
	for <bpf@vger.kernel.org>; Fri,  7 Jun 2024 00:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717720113; cv=none; b=ZF/20KSl3XR6VLCp2Q+qNFtRrI0rPkVQpg4PL6tK/ncMnq4IFmiFalAHvUxYwg0dwJcbcWg1gVekS5UTODCGa8QQXOM31HFtHYbY3ZAEnd6nvKmzMw9Zp/gzfRE15gU2BZBlgUSp9ur4gSSjsu4i7ma3nS2RlaXHLhSw8L71aNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717720113; c=relaxed/simple;
	bh=zp/6Q89eGqc9i1K7r791C6yLtc+duurgianE05aYZMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A/siZIAj99qwBKiq0pC9kfzHgUHiyV/GVtITu7iAzSnGP/s/JuO1+OhIrMG0c2Ce1AfooH/DcfcJHsf9IBfyMh2ycH4MTyZx7m6GyCVYyg0VBmWB7Z0cHil2/3w48q7n0dZ7XcRIu/rwCGIht+Mf/n7mraWSkfy7jg3YsPaR92o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUNJPI77; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42108856c33so15762415e9.1
        for <bpf@vger.kernel.org>; Thu, 06 Jun 2024 17:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717720110; x=1718324910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4manwvi6fBw4NBQ5pIYjKZD881Wgw+BZ3B57qFAc64=;
        b=GUNJPI77311YhPe+fcNDUiEqkcSYz+fuVC02zOFGhwmL2/gmtL12G7LDzm/9lQBxA0
         2IpoeuB4wZY/D+OCkuttriQugWFBmA7Hx1YVuD7roNsByTT3KOrg8Y7yU51HblbeSB9u
         FNOQJ4MWfox7AvGj7cv3O8x2ToPOpZKxGURg4Ms1FnGG0LkvUDNo0QCXso8UTtvDVWbE
         7pHmyABKu5bFqao84rmte6y+E23LLipiUlcpMO1/nw4NZi0z3Ilj9Kl+8uKNnICwXNNt
         Tg5Pao9JEpcERGktq0OB2sjjFYBeQ9Hr/tXqLn7d7TrXxYqGwELu7CXQ1GkLetcewsfb
         hchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717720110; x=1718324910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4manwvi6fBw4NBQ5pIYjKZD881Wgw+BZ3B57qFAc64=;
        b=cG8hjHG1E+sE8nBYjltLlV/zRSTnuTymBF6DagLU9nHSw0UvJDq81fbJBf8F36wkdl
         hMcyWGQICRVRl2Iq2qbIaEgUhBZtwfPHYC7JuMtEeYEYJwxk3x9DSqZ8yjeq4Q4hKqLa
         rOBZy8b7wHutuDBagzLJsiK1KiVK0jiSiJjtfVsTSp5oeJmOvzRg7+xg0owdv7HEcOLx
         TfZK+C6GeSj1DGo0jPndielFkFNfhIuW7MhRedgPpbCa5bQmzEQ9OIGkAFB1S06xpSSH
         x6sJpQfLbE80K3BmEXGrPt33DSbJG/XZR/dp/9sZV76/kZU87hAhvNUQTVGSSn94cYGi
         d72A==
X-Gm-Message-State: AOJu0Yz8ig2+vs3DXGyQbs6v8hPmnFnUcwRdU1IVBlzHZPA2PDLNvlVL
	ferFfl+KjIZB0WELpcL5uEE36+GrKNGbItERl6T71Fm5FKGBNlpbcBqecUzKD1XkM4E+FRKMhqI
	fCb7+iJtHGQIn2QjwYjQwcKB7qCk=
X-Google-Smtp-Source: AGHT+IGCnIkK69u9ZqownqIsAKCq84L9cWe6lJul5BFJPn1hBTycyRrg2j747culS2IIbM68O4TcA4mIWljwZapJdvk=
X-Received: by 2002:a05:600c:1c27:b0:420:1a72:69dd with SMTP id
 5b1f17b1804b1-42164a0c1d4mr9820875e9.10.1717720110072; Thu, 06 Jun 2024
 17:28:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606005425.38285-1-alexei.starovoitov@gmail.com>
 <20240606005425.38285-2-alexei.starovoitov@gmail.com> <6dbfd5e14ffbf9d828d63c5855f9bb783ac2506a.camel@gmail.com>
 <CAADnVQ+KFoNW-yJCa5fFmNzXjoEN4ECvPeQ1YoCeSZpyR9uO5Q@mail.gmail.com>
 <098d570be9bb15fc804355851b4b99837f18c664.camel@gmail.com> <0f197e908df8b33187a6c9a8da34457cb01a746e.camel@gmail.com>
In-Reply-To: <0f197e908df8b33187a6c9a8da34457cb01a746e.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 6 Jun 2024 17:28:18 -0700
Message-ID: <CAADnVQK79WDjRrzT9MsGpkEQwWeo7VvCR2XSX0GUb94=U+5VcQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 2/3] bpf: Relax precision marking in open
 coded iters and may_goto loop.
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 4:39=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Thu, 2024-06-06 at 15:19 -0700, Eduard Zingerman wrote:
>
> [...]
>
> > For the following C code:
> >
> >     long arr1[1024];
> >
> >     SEC("socket")
> >     __success
> >     int test1(const void *ctx)
> >     {
> >         long i;
> >
> >         for (i =3D 0; i < 1024 && can_loop; i++)
> >                 arr1[i] =3D i;
> >         return 0;
> >     }
> >
> > clang generates the following BPF code:
> >
> > 0000000000000340 <test1>:
> >      104:       r1 =3D 0x0
> >      105:       r2 =3D 0x0 ll
> >
> > 0000000000000358 <LBB28_1>:
> >      107:       may_goto +0x4 <LBB28_3>
> >      108:       *(u64 *)(r2 + 0x0) =3D r1
> >      109:       r2 +=3D 0x8
> >      110:       r1 +=3D 0x1
> >      111:       if r1 !=3D 0x400 goto -0x5 <LBB28_1>
> >
> > 0000000000000380 <LBB28_3>:
> >      112:       w0 =3D 0x0
> >      113:       exit
>
> [...]
>
> I've also took a look why the same program could be verified w/o
> can_loop, but fails with can_loop (with this series applied):
>
> 0000000000000358 <LBB28_1>:
>      107:       may_goto +0x4 <LBB28_3>
>      108:       *(u64 *)(r2 + 0x0) =3D r1
>      109:       r2 +=3D 0x8
>      110:       r1 +=3D 0x1
>      111:       if r1 !=3D 0x400 goto -0x5 <LBB28_1>
>                    ^^
>     r1 is no longer marked precise,
>     thus maybe_widen_reg() forgets the range for it
>     when widen_imprecise_scalars() is called from
>     may_goto processing logic.
>
> As a result, verifier enumerates states
> {r2=3D0P,r1=3Dscalar()}, {r2=3D8P,r1=3Dscalar()}, {r2=3D16P,r1=3Dscalar()=
}, ...
> eventually hitting the value of r2 that does not fit in 'arr1' bounds.

That's correct.
As I was arguing couple emails ago the existing
maybe_widen_reg() logic is just as damaging heuristic
as this new widen_reg() logic.

With this hack:
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 79e356ac02ab..23892759f05e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7928,7 +7928,7 @@ static void maybe_widen_reg(struct bpf_verifier_env *=
env,
                return;
        if (rold->precise || rcur->precise || regs_exact(rold, rcur, idmap)=
)
                return;
-       __mark_reg_unknown(env, rcur);
+//     __mark_reg_unknown(env, rcur);
 }

the above test is passing.
Though widen_reg() widened the range the bounded loop logic still works.
The loop now looks like
r1=3D[1,999] r2=3D8
r1=3D[2,999] r2=3D16
..
and eventually the verifier goes to check all 1k iterations of the loop
and passes.

Should I disable old maybe_widen_reg() when new widen_reg() kicks in? ;)

My point is that we had good and bad heuristics. The new one
helps arena. Is it perfect? No. But based on this particular
test it's arguable which one is worse.

Anyway, I think I'm going to tighten it a bit more.

pw-bot: cr

