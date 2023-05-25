Return-Path: <bpf+bounces-1236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8D97111ED
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 19:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6382815BA
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 17:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDDC1DDC4;
	Thu, 25 May 2023 17:21:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0841D2A2
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 17:21:01 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A22518D
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 10:20:57 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-510dabb39aeso4254348a12.2
        for <bpf@vger.kernel.org>; Thu, 25 May 2023 10:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685035255; x=1687627255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7byuBC3VtepXVC4b5Mp3mFsXkNsUI9Y4CpT2bR9pYI=;
        b=f4wCSlb8TqasT1XxatuO2XbM+xuEf57TFofD9mdtPUv3UySf8RVEKGHKvWK+S9BPJi
         FP7AND6aidhwFPSzD1zexdLnZndVaiRHYB/npOHjRlbviCCoYfHJhT2/wNV3Poqop+vJ
         cKXQVF2YtnSOqtZrlj6tLwbI1vlrJEj8qJR2GIV5LAg/rIY+AszjInlUFlBMI79yGvXe
         9peKcPAOJc5l9f0aDKCQP1lF6FbueF45kNNeYPtIp9/eNwMcyCJoohdEM+YJy2h3D6k/
         KaKDToY9AhJOKRpBQGI16pm4pe/rb1J19oEPPOqhH1iVm18Lr/q9RU+uPjY6krk9V2S4
         PGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685035255; x=1687627255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g7byuBC3VtepXVC4b5Mp3mFsXkNsUI9Y4CpT2bR9pYI=;
        b=S1xM44/JVcJ4e4neoo3PwsfJhz7NwogS/L7teSHxZApIGHLuvR1/8WIyW8IFx84Pw2
         Zvk37bR1EYceshQ8GcmILAOK4MPinildqLvR+8xDqrb0w/8rRwrSi0P3N7Fp+1Rw8iSv
         c7TnifYs0q6jojMsN+PmbjPbIZtTqG7szRrw7b0NceOaubNJ44LZmeEWdNgShqr0Fnwd
         ux2jU4P20R80HSkr8WKhADycWFOoDEJ7tSmUEos9z3MRzPxFiAtUHrw6Fm2Tlpx7Wx3e
         ER/MAPxgPY3VyX+BpjPhUYuiEEAh+zFE7VTDwFKzmupdY9mKm0XwZIoInKYfFl2JUFo+
         IK/w==
X-Gm-Message-State: AC+VfDxuHjpmxDBJ/SOx6AVI76PW6pg1wM821RsVBdJiDvPHJSUVKvPG
	Tq754eN6VvCAfsBWHMONkd+XWFQiObWvfBDGA8Q=
X-Google-Smtp-Source: ACHHUZ5b8mjU7IOG/mMaEpHoziCFl82/bT7SbHvpjydfVRKaLddYTnamGrkZItmGfM2i45t8174cXhRkt4/NEeDoV/M=
X-Received: by 2002:a17:907:6e0e:b0:96f:baa4:cda7 with SMTP id
 sd14-20020a1709076e0e00b0096fbaa4cda7mr2296294ejc.68.1685035255452; Thu, 25
 May 2023 10:20:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230524225421.1587859-1-andrii@kernel.org> <20230524225421.1587859-4-andrii@kernel.org>
 <7f4071ff-70fd-eef2-9aa1-a0263b71dbbb@iogearbox.net>
In-Reply-To: <7f4071ff-70fd-eef2-9aa1-a0263b71dbbb@iogearbox.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 May 2023 10:20:43 -0700
Message-ID: <CAEf4BzbNR+u2fvp82+cd-SOAGOL8QM4QEf4XgUQgQ5mp89Hc5Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] bpf: don't require bpf_capable() for GET_INFO_BY_FD
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 25, 2023 at 6:14=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 5/25/23 12:54 AM, Andrii Nakryiko wrote:
> > The rest of BPF subsystem follows the rule that if process managed to
> > get BPF object FD, then it has an ownership of this object, and thus ca=
n
> > query any information about it, or update it. Doing something special i=
n
> > GET_INFO_BY_FD operation based on bpf_capable() goes against that
> > philosophy, so drop the check and unify the approach with the rest of
> > bpf() syscall.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >   kernel/bpf/syscall.c | 11 -----------
> >   1 file changed, 11 deletions(-)
> >
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 1d74c0a8d903..b07453ce10e7 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -4022,17 +4022,6 @@ static int bpf_prog_get_info_by_fd(struct file *=
file,
> >
> >       info.verified_insns =3D prog->aux->verified_insns;
> >
> > -     if (!bpf_capable()) {
> > -             info.jited_prog_len =3D 0;
> > -             info.xlated_prog_len =3D 0;
> > -             info.nr_jited_ksyms =3D 0;
> > -             info.nr_jited_func_lens =3D 0;
> > -             info.nr_func_info =3D 0;
> > -             info.nr_line_info =3D 0;
> > -             info.nr_jited_line_info =3D 0;
> > -             goto done;
> > -     }
>
> Isn't this leaking raw kernel pointers from JIT image this way for unpriv=
? I think that
> is the main reason why we guarded this (originally behind !capable(CAP_SY=
S_ADMIN)) back
> then..

Ah, ok, makes sense. We are protecting kernel from unpriv prog/user,
so the "if you have FD you can get info about object" rule doesn't
apply here.

>
> >       ulen =3D info.xlated_prog_len;
> >       info.xlated_prog_len =3D bpf_prog_insn_size(prog);
> >       if (info.xlated_prog_len && ulen) {
> >
>

