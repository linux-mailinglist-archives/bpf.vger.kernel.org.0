Return-Path: <bpf+bounces-14669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD157E7688
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 02:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 069491F20CC4
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 01:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90F1A5F;
	Fri, 10 Nov 2023 01:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYb0dlT5"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B660A46
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 01:26:56 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D690D2715
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 17:26:55 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32d9effe314so870806f8f.3
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 17:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699579613; x=1700184413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zltnd/x0K0Pqng2+0I9WPhScNQY1pxR8vIfnXScmqWs=;
        b=gYb0dlT5TaXL/yFaPB9xJBvr7JJOEzWW8QRDhjfszLsAeV9Tj216kZfxcrY0rUuJzJ
         QQapTkEEAuqVj0AnljLhx6Nlh0mSRmLR2Jvcr62J+mdiRrLR57je9u23NV6Y4SzB4qVW
         uC/YYfeKTM5EXp+CTxD11SGLJS/sCjKwM2C14m5nEbGp8dx+z4n3DEZ8/hbico3PdrL+
         yatD2B1m7eEzWeCZ/Gi/IGjbIklC19yRvzuqSb0Hl7+qz5nN0LEOlr/B4n0JKvheTIaK
         nMk/9y9g8HJV/ZmWpDKxlCm9wf/1WR83rMFBP83i3MwVdHJhSbsPQ+6HPrZ1xlEBZiXN
         uI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699579613; x=1700184413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zltnd/x0K0Pqng2+0I9WPhScNQY1pxR8vIfnXScmqWs=;
        b=AKlSPFZeunO9FmJRtSl9lkuC3Yeyg0JPMsbwFQvxbCf04Bq7GuHQz1rADUrtAbqv4H
         Lc9Vemaf62G7smIs+iEiQ8d51tIFcHE4Tef+yBiarBFiUK0TaWQhn1Fn/yY/ye2vqvaN
         8vwikfyblDUTInaOcTtrMhKYhQxBGuNDkURFNeop48MT3DSjc9odsd4T7jKGZCbqi+6S
         7UfuUTXt1va+9Mhmrfm0A7jKJIZ5Sk2iXCeAxbb1JIVFVYNZljw2jw2rRQvuGdKUp518
         DoeUlplt22bJAZZmtfAtJ1LW3Pp03L7EzmlryyUQnzEn7nX5MC8J0Xe0YegsbTfLYGZV
         rvyA==
X-Gm-Message-State: AOJu0YxugARC9BbCqxyNOmAcKd4sm7gSe7YRP0BG4GqrsGmIJZqzRFJ7
	dv09buQfVJmQNw81DUXvekjjio7Y2WDnXZvkDXU=
X-Google-Smtp-Source: AGHT+IFZn2Lrff+TV8HBttQop8Gqx4+CxXzg92PzgGp5zdFIt+vJ6fDGlv5sZ96+p70liJ2jwskTgMKz0Fl9HAouv5E=
X-Received: by 2002:adf:f506:0:b0:32d:9ed0:c31a with SMTP id
 q6-20020adff506000000b0032d9ed0c31amr5218297wro.64.1699579612575; Thu, 09 Nov
 2023 17:26:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231108231152.3583545-1-andrii@kernel.org> <20231108231152.3583545-4-andrii@kernel.org>
In-Reply-To: <20231108231152.3583545-4-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Nov 2023 17:26:40 -0800
Message-ID: <CAADnVQKQ5TGGwGuaO0eghhnLRFZOVgLE7Hume8uPAvbo-AwA5g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: fix control-flow graph checking in
 privileged mode
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Hao Sun <sunhao.th@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 8, 2023 at 3:12=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org> =
wrote:
>
>
> @@ -15622,11 +15619,11 @@ static int visit_insn(int t, struct bpf_verifie=
r_env *env)
>                 /* conditional jump with two edges */
>                 mark_prune_point(env, t);
>
> -               ret =3D push_insn(t, t + 1, FALLTHROUGH, env, true);
> +               ret =3D push_insn(t, t + 1, FALLTHROUGH | CONDITIONAL, en=
v);
>                 if (ret)
>                         return ret;
>
> -               return push_insn(t, t + insn->off + 1, BRANCH, env, true)=
;
> +               return push_insn(t, t + insn->off + 1, BRANCH | CONDITION=
AL, env);

If I'm reading this correctly, after the first conditional jmp
both fallthrough and branch become sticky with the CONDITIONAL flag.
So all processing after first 'if a =3D=3D b' insn is running
with loop_ok=3D=3Dtrue.
If so, all this complexity is not worth it. Let's just remove 'loop_ok' fla=
g.

Also
if (ret) return ret;
in the above looks like an existing bug.
It probably should be if (ret < 0) return ret;
Otherwise it's probably possible to craft a prog where fallthrough
is explored and in such case the branch target will be ignored.
Not a safety issue, since the verifier will walk that path anyway,
but a bug in check_cfg nevertheless.

