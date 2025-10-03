Return-Path: <bpf+bounces-70341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A06CCBB7FC4
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 21:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37FBB4ED6B7
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 19:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D60521C194;
	Fri,  3 Oct 2025 19:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEKVbyGk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F62D1A9F9B
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 19:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759520039; cv=none; b=IzqScgV1yofVbzbwjZJWMrObJ1GpJd7dOc76dV7BA5cOHfFLBunlQ50byZKAIH4DNXMWbSylmDB2nOb/b0Vo4pSCHFq5DXr6Ez73AVTpYuLtFWYI+3Pc+kTffF15rJfYxkrM7s7riO7lSt0Azv57Lr+HuMeK0TAjm+Jh0VTd2Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759520039; c=relaxed/simple;
	bh=jC8eULY20ofIjKxdvLVRodI+igZO9E4aCs+AzlnAbdo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TS19ROPYnQxWTH9PRvoGu0Y7b8gJV5SdhyOjgnrqE22k3GVpP/VZp/mRTfOlZExgLTn9oL4nOgiV8Ciym1Zm5d9aH8d++6LeH1k1HjyqzFJxqjXCz3wjbcwSNgUAAlEdt1Gte1Vhws6z1lO3QH9SNS4OV4ST8By+mznTaFZ4veQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEKVbyGk; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-279e2554c8fso24215105ad.2
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 12:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759520037; x=1760124837; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KbXuS0HizFy+F4mpbvFwK4owwOp/bA81IBQeDuM9u6E=;
        b=NEKVbyGk51pQ6dWPVSquU+8uZcriMiSUxhtvfDuGySzvcUVkf1FyAFoGxU9Fmgyx6O
         R2v4rfdbEyxLc3sWS6fa5CQD9QOgh4OEfjOiOjeUteLkIisGFCLQ9Hi07bMH3r2R09ZN
         xaH4kQ//UEzX5IbPMkUPt4iV9wbC/8IZays0XhZ+QLyiccDe7lDbMoOOaq6SfAehlcpr
         Ga66063wDIf3wPXDkhb/j+4kq4qt4wraks4+wDljnS8mHPZ+TAY/B3LCTGtx8xRQQGK/
         8C7ugceDVe7nC6OwaEVtkS9A44Ckibpx0QAx1b40oLU6Hr+ZrwK/shDCAwnea4X8tIl3
         n7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759520037; x=1760124837;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KbXuS0HizFy+F4mpbvFwK4owwOp/bA81IBQeDuM9u6E=;
        b=QRNpYG0LK6QQHnf/JZmblKpJZbfIR+34p0d2krhF0Y+cNl6CHSf2RdixTcv8DxYNWl
         49mEAVDkt2kMOD8LFZCNsbw0/SfoS1qIn8jsIQ2iWYuKQMNVWwkHd7bDSqLaswGTEDFe
         e/FBhITcL0nMBlyXJjgqknezwhWQYJSk4NK3Kx6EAKdUFM7bcx5+2qQvUGZWvz2Vtug8
         +qghxKUjtX9b3TEdKWRDhukFpHhxNhiXkwQQHz1dFVTWfdIjCa6Nn2aH+Cu9UZpMnRsM
         jEN+s6DV6HUkPfMlvattJom/IG0L88xdV8iqKM9YvDjjF1l5Ob/gncE90XyM90HAmNkx
         n+eA==
X-Forwarded-Encrypted: i=1; AJvYcCX7TWhjJCB9nt+swv8Dgc0k5KrC7Ww3J024nbTe4CZw3UoI9EoGP1XVksOWl4ljLU+Maa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUQDiKIOEbvZFh0zniy1V56Cg1oHmztFAdNDsbEUNfpyhoKyWy
	epyH00bzTkxxzcoFhCI1r1vfV7BeLEV0GlYOgsqa3EJmhpDlykgpztlm
X-Gm-Gg: ASbGncuFCwqYiOiQkqV+j3COdguU4nqup4uVVsGoEADSX+c+pYesu5WhpAE7IHYeYVV
	wVAjwun4Wk4QUiyp3uKdya3y4sFgY9701GYfBykHqWbCZhSzrjr7qx2tr7wTu8Ty5wkcswu33/B
	QN5opM2Xq9lvsL60pQcriR/DzVBI+1i5tsUO6ppnAgfnHj/Kd0JS+JpJ5+l++EaUEWJmsqX615Z
	JaKaK0jFNs8ac2636ghromOdVJgzRmbC/kbPHO3bqXTHajLP29fm/fAXAVcCnAdz5YINSQKWuAE
	tenXjvmsLbpnKGo394fQUnrms/3lMC/Vdd7bd6B6UOqwQ08CtHHj1OOxAIbtVxjzlaqkoFghPjx
	8zX9FSYxyeJRWs5x8iEC/FYEpZ0MNmiksbon66zjtsYy/arDj4hbf0L6w2u7rt0zp3YveuBhqnL
	0DD90Z4Qg=
X-Google-Smtp-Source: AGHT+IGhzlFwsTVF07HMKSDtQ97xfo6sP/E2JUVj6J0pXGa3Q9iG7uJR/lmL8+dTHqPSQUCZP5RR9Q==
X-Received: by 2002:a17:902:e952:b0:246:7a43:3f66 with SMTP id d9443c01a7336-28e9a5435d5mr46839505ad.7.1759520037519;
        Fri, 03 Oct 2025 12:33:57 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2a3b:74c8:31da:d808? ([2620:10d:c090:500::4:e149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d110d16sm58017475ad.19.2025.10.03.12.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 12:33:57 -0700 (PDT)
Message-ID: <ad9f22c83c1585d521df4160dd71af6b06df411e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: verifier: refactor bpf_wq handling
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Fri, 03 Oct 2025 12:33:55 -0700
In-Reply-To: <f3fd1043-6696-454d-bafd-9d1a84a937c5@gmail.com>
References: <20251001132252.385398-1-mykyta.yatsenko5@gmail.com>
	 <6b2b44ddbec88ae4690b4eae33b712642b73db4c.camel@gmail.com>
	 <f3fd1043-6696-454d-bafd-9d1a84a937c5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-03 at 20:17 +0100, Mykyta Yatsenko wrote:
> On 10/1/25 19:50, Eduard Zingerman wrote:
> > On Wed, 2025-10-01 at 14:22 +0100, Mykyta Yatsenko wrote:
> > > From: Mykyta Yatsenko <yatsenko@meta.com>
> > >
> > > Move bpf_wq map-field validation into the common helper by adding a
> > > BPF_WORKQUEUE case that maps to record->wq_off, and switch
> > > process_wq_func() to use it instead of doing its own offset math.
> > >
> > > This de-duplicates logic with other internal structs (task_work, time=
r),
> > > keeps error reporting consistent, and makes future changes to the lay=
out
> > > handling centralized.
> > >
> > > Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> > > ---
> > Note to reviewers: technically, this makes the check stricter,
> > but no new correct BPF programs would be rejected.
> > The cases that are checked by check_map_field_pointer,
> > but which were not checked before this patch:
> > - reg value is a constant
> > - corresponding map has BTF
> > - map record has BPF_WORKQUEUE field
> >
> > Not sure if ignoring one of these checks could lead to invalid memory
> > access at runtime. I'd add fixes tag (and maybe a test), so that this
> > commit could be grabbed for backporing:
> >
> > Fixes: d940c9b94d7e ("bpf: add support for KF_ARG_PTR_TO_WORKQUEUE")
> >
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> >
> > [...]
> I tried to trigger some of these error conditions:
> - map record has no bpf_wq: this errors out earlier: arg#%d doesn't
> point to a map value
> - corresponding map has no BTF: I think to create a map without BTF
> I need an older libbpf version, not 100% sure how to do this

BPF programs can be defined w/o libbpf.
Here is a recent example:
https://lore.kernel.org/bpf/20250930125111.1269861-1-a.s.protopopov@gmail.c=
om/T/#m055919e0dd8ca15af3749bae6f9cbd2b13e4945f
test cases there define a short program and pass a map w/o BTF to it.

> - reg value is not constant - this one I don't know how to trigger.
> Given all this, let's keep this simple and not add fixes tag, it does
> not look like we are
> actually fixing anything.

 static int process_wq_func(struct bpf_verifier_env *env, int regno,
                            struct bpf_kfunc_call_arg_meta *meta)
 {
         struct bpf_reg_state *regs =3D cur_regs(env), *reg =3D &regs[regno=
];
         struct bpf_map *map =3D reg->map_ptr;
         u64 val =3D reg->var_off.value;

         if (map->record->wq_off !=3D val + reg->off) {
	     ^^^^^^^^^^^            ^^^^^^^^^^^^^^=20
	     |                      reg->off is 0, but 'val' is under attacker con=
trol,
	     |                      all is necessary is to conjure a tnum with kno=
wn bits
	     |                      corresponding to wq_off value.
	     |
	  This can be NULL, so there is a potential null pointer dereference

                 verbose(private_data: env, fmt: "off %lld doesn't point to=
 'struct bpf_wq' that is at %d\n",
                         val + reg->off, map->record->wq_off);
                 return -EINVAL;
         }
         meta->map.uid =3D reg->map_uid;
         meta->map.ptr =3D map;
         return 0;
 }

