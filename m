Return-Path: <bpf+bounces-15266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBEB7EF8AF
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 21:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFD121C2097F
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 20:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6F5E545;
	Fri, 17 Nov 2023 20:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/GYhF8S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DDBE5
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 12:30:33 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53e08b60febso3575268a12.1
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 12:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700253032; x=1700857832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jue7Il+ZHMDEBtP0iS78857Le/hhAwVj7Fm8Wwfqhcg=;
        b=i/GYhF8SyD2bSEjY5i34hUSpYdaLtzyaKtr2U4kIBTj9EG06xZH58LEbBKLHZEdsZG
         Ju1+MpEpRM6IQMWYBuvQpvUgCR+ijhJp2cdMEF5A4ciLhkt2rOK8rSaXEYNMBkXjXu/7
         0Kd7WfqBSZkzJIZxag1Q//ZEZF76ujuLpq/BEYM9tBq3giOZF9rEXYi/o+qA53X6VtOB
         +P+h/hxsNK9zSiXa8yDwCoFYD2jsc12pOE3ZinIiF7SChmBbmdRTCEJUjEylgyB5gsdX
         kppQRQoSEksFqchfVga73Ni03cZlBlf69/W3d+8Aw460KMmyjjmhkJ3m7M06z8fQbvu6
         SFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700253032; x=1700857832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jue7Il+ZHMDEBtP0iS78857Le/hhAwVj7Fm8Wwfqhcg=;
        b=qMyLZ0u6d5AlDoHDi9Ky2d8XqNfmF8tbbYNcTGBBkWiG63zT0YKH5dni/certYV2vL
         mt9DBHXMaj/3WLL5aP4UvjecAmstvGV6QvIudXGypInQWCy/tycX/mxcSCGcYRVWQt4s
         N2kGJalTbut6WIoLQQnNEfNXifhzNaogFhqA9TmDegyKcmfmXtgH1hjD3hcp3EE1Ktov
         0gQW0eN9VH3sW+uetYairSLJw4VxMEE+tz74FcYvGMIVJToqgIWvvaOyfUFUZQukNuAQ
         fao+5KJmaKdKPTOTZ1Gxxny/+gKzJ1hw86qvRO9nKrJzwaqSXz37jjXQ4LPshQhOELS8
         HSug==
X-Gm-Message-State: AOJu0YxwsZ5Zy/RL9hD5WR/VA4ZYnUYIBQa8Nba1hxQFc4VOw32BaOlN
	G2wqoV58GVnrBUtJST2Le98F2ToL6/mr0NBz5/E=
X-Google-Smtp-Source: AGHT+IEcFS11+/pMuuTd5EVdZ9ja+jwBsF4K2KGV54GTkDcIGRIHrlSzur5/zXjQmeRLdMlNs02TeAdVrNf4RztV06U=
X-Received: by 2002:a17:906:739d:b0:9c7:fd91:4309 with SMTP id
 f29-20020a170906739d00b009c7fd914309mr197568ejl.0.1700253031469; Fri, 17 Nov
 2023 12:30:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116021803.9982-1-eddyz87@gmail.com> <20231116021803.9982-11-eddyz87@gmail.com>
 <CAEf4BzbP9rh1Qb1eyANQn4yrR78q1+VL5R=GGyJihpaZJui0tA@mail.gmail.com> <beafc54c685e26b0ac5776f5cc81a0bf7dff3775.camel@gmail.com>
In-Reply-To: <beafc54c685e26b0ac5776f5cc81a0bf7dff3775.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 17 Nov 2023 15:30:20 -0500
Message-ID: <CAEf4BzYhfSE_XB2r+X8RGUZ8x37p_1GQk76v_WrkzRqbNZcAmQ@mail.gmail.com>
Subject: Re: [PATCH bpf 10/12] bpf: keep track of max number of bpf_loop
 callback iterations
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com, awerner32@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 1:53=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2023-11-17 at 11:47 -0500, Andrii Nakryiko wrote:
> [...]
> > > @@ -10479,8 +10481,14 @@ static int check_helper_call(struct bpf_veri=
fier_env *env, struct bpf_insn *insn
> > >                 break;
> > >         case BPF_FUNC_loop:
> > >                 update_loop_inline_state(env, meta.subprogno);
> > > -               err =3D push_callback_call(env, insn, insn_idx, meta.=
subprogno,
> > > -                                        set_loop_callback_state);
> > > +               if (env->log.level & BPF_LOG_LEVEL2)
> > > +                       verbose(env, "frame%d callback_depth=3D%u\n",
> > > +                               env->cur_state->curframe, cur_func(en=
v)->callback_depth);
> >
> > btw, is this a debugging leftover or intentional? If the latter, why
> > is it done only for bpf_loop()? Maybe push_callback_call() be a better
> > place for it?
>
> Intentional...
>
> >
> > > +               if (cur_func(env)->callback_depth < regs[BPF_REG_1].u=
max_value)
> > > +                       err =3D push_callback_call(env, insn, insn_id=
x, meta.subprogno,
> > > +                                                set_loop_callback_st=
ate);
> > > +               else
> > > +                       cur_func(env)->callback_depth =3D 0;
> >
> > I guess it's actually a bit more interesting to know that we stopped
> > iterating because umax is reached. But I'm actually not sure whether
> > we should be adding these logs at all, though I don't have a strong
> > preference.
>
> ... it is not obvious to infer current depth looking at the log, so I
> think something should be printed. Note about stopped iteration sounds
> good, and it could be placed here, not in the push_callback_call(), e.g.:
>
>                if (cur_func(env)->callback_depth < regs[BPF_REG_1].umax_v=
alue)
>                        err =3D push_callback_call(env, insn, insn_idx, me=
ta.subprogno,
>                                                 set_loop_callback_state);
>                else {
>                        cur_func(env)->callback_depth =3D 0;
>                        if (env->log.level & BPF_LOG_LEVEL2)
>                                verbose(env, "bpf_loop iteration limit rea=
ched\n");
>                }
>
> wdyt?
>
>

Sure, I don't mind.

