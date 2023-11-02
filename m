Return-Path: <bpf+bounces-13917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 967BF7DECC6
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 07:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECB59281AEE
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 06:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBFB523D;
	Thu,  2 Nov 2023 06:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCu+yNfh"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9B95227
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 06:07:24 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6AB132
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 23:07:19 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32ded3eb835so353510f8f.0
        for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 23:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698905238; x=1699510038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIkZWKmFQ5oqRaAsrmwEBuDhLR7sppblrVwSZdVJytI=;
        b=fCu+yNfh6aOuDHefAT7D5JaQ5ttO3i0V3AphNx0mrOE1thcFiWV0XCMnGxaP+xuTcB
         2aQv0B1yVg7kFO+wjzZehHnNZ4ETJOZuoSyXQUVKL0urQDadFTuZNX/9Lc42c1qMvF53
         6PK44OL9mmVh/kMwPDMk7LaBdkV01w0/T+qfnTCzhZem9HhJPU4Gi92hwQOeLstNXt7g
         PrWRASkwuEMe9CNmvYURuHIKiInHQ00JaMQgNytPX0A2tD/5vOSmRZx7f4bKY81sd2HV
         bF4DY7HZJbm802gPMGL7H9QTaXd4yRtKdAfR8hVZ/ppru2EOaZidMgQtWwZq4le/pagI
         XyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698905238; x=1699510038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZIkZWKmFQ5oqRaAsrmwEBuDhLR7sppblrVwSZdVJytI=;
        b=mDjtsnd8AzAF/hWFRIo5O7XG5vgdQ6NzzAk4/SOrANk9XsWUaolMI4PqQiDcUqMfcJ
         zfk8NfwrRSwTMLel2kDrX7orIWIqa7AwwWCnLRA0VohcHT2YJqLoM8aR0V4hhC+uJAmc
         hwC5qVeICcOe99svdquccblWuNNj4M0/VipXB2C8MvbsZ1YTnxHtTpDZpoj/W1ZHNLij
         BlrEQmnACoyTTch8Y4CVZtNGDdaNTSZ2HNefMXYJsRz/ZXoLeUqY3wp3ViBQtrl3sujt
         cf20+4wXXEp8fmk/s2g8f5DXaRjaaS04ktLEww2YodrkmQUi4+DEpE6uFuZuRZuFqzIX
         noHA==
X-Gm-Message-State: AOJu0YxM0kNQStY3Xsg9rrLbK6xZkviWNOP5YoHoYHVztEJ1qeTeoLie
	BmhacP4gbTXNuVTl7dNLzxItrwEtgSgVqGy+PZc=
X-Google-Smtp-Source: AGHT+IHprjRXlSs1+9jgXhlIsq3zlGJQDwvCd78nqqWy7ARQ4loiPNSd6+Pt82CHJPGxu7+RalnqacZpKub36Lkwq9A=
X-Received: by 2002:adf:f212:0:b0:32d:6891:f819 with SMTP id
 p18-20020adff212000000b0032d6891f819mr12781250wro.41.1698905237324; Wed, 01
 Nov 2023 23:07:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231022154527.229117-1-zhouchuyi@bytedance.com>
 <20231022154527.229117-3-zhouchuyi@bytedance.com> <CAADnVQLGwn_x9CZmYX5K_6K5Y0SB7EjU5wfRUHRMdXhAvKEJVw@mail.gmail.com>
 <cfaf3363-51b9-40af-8993-9718d7edbaf7@bytedance.com> <CAADnVQLcw36TiEYXaoYDhEinygCQ86U5AKg-rJPsQj=KUu7Y2g@mail.gmail.com>
 <350dd3e5-3a34-42ba-85b9-ddb1a217c95e@bytedance.com> <bcdce26b-b5cf-4eb7-bf04-7507f5e0ac85@bytedance.com>
 <CAADnVQ+xaNK5vbGwrB25VvVTQhfQcCNHxqXCxBodrwpOvdkFWQ@mail.gmail.com> <e8e2ca00-dbfc-4a46-b154-692dcefbbee2@bytedance.com>
In-Reply-To: <e8e2ca00-dbfc-4a46-b154-692dcefbbee2@bytedance.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 1 Nov 2023 23:07:06 -0700
Message-ID: <CAADnVQLZ4HJZdYOO5EH7o80qB7TfRbv08WwaVVu_cO_ME9i3OQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add test for css_task iter
 combining with cgroup iter
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 7:41=E2=80=AFPM Chuyi Zhou <zhouchuyi@bytedance.com=
> wrote:
>
> Hello,
>
> =E5=9C=A8 2023/11/1 06:06, Alexei Starovoitov =E5=86=99=E9=81=93:
> > On Tue, Oct 31, 2023 at 4:38=E2=80=AFAM Chuyi Zhou <zhouchuyi@bytedance=
.com> wrote:
> >>
> >>
> >> So, maybe another possible solution is:
> >>
> >> diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
> >> index 209e5135f9fb..72a6778e3fba 100644
> >> --- a/kernel/bpf/cgroup_iter.c
> >> +++ b/kernel/bpf/cgroup_iter.c
> >> @@ -282,7 +282,7 @@ static struct bpf_iter_reg bpf_cgroup_reg_info =3D=
 {
> >>           .ctx_arg_info_size      =3D 1,
> >>           .ctx_arg_info           =3D {
> >>                   { offsetof(struct bpf_iter__cgroup, cgroup),
> >> -                 PTR_TO_BTF_ID_OR_NULL },
> >> +                 PTR_TO_BTF_ID_OR_NULL | MEM_RCU },
> >>           },
> >>           .seq_info               =3D &cgroup_iter_seq_info,
> >>    };
> >> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> >> index 59e747938bdb..4fd3f734dffd 100644
> >> --- a/kernel/bpf/task_iter.c
> >> +++ b/kernel/bpf/task_iter.c
> >> @@ -706,7 +706,7 @@ static struct bpf_iter_reg task_reg_info =3D {
> >>           .ctx_arg_info_size      =3D 1,
> >>           .ctx_arg_info           =3D {
> >>                   { offsetof(struct bpf_iter__task, task),
> >> -                 PTR_TO_BTF_ID_OR_NULL },
> >> +                 PTR_TO_BTF_ID_OR_NULL | PTR_TRUSTED },
> >
> > Yep. That looks good.
> > bpf_cgroup_reg_info -> cgroup is probably PTR_TRUSTED too.
> > Not sure... why did you go with MEM_RCU there ?
>
> hmm...
>
> That is because in our previous discussion, you suggested we'd better
> add BTF_TYPE_SAFE_RCU_OR_NULL(struct bpf_iter__cgroup) {...}

I mentioned that because we don't have
BTF_TYPE_SAFE_TRUSTED_OR_NULL.

and cgroup pointer can be NULL, but since you found a cleaner way
we can do PTR_TO_BTF_ID_OR_NULL | PTR_TRUSTED.

> I didn't think too much about it. But I noticed that we only use
> cgroup_mutex to protect the iteration in cgroup_iter.c.
>
> Looking at cgroup_kn_lock_live() in kernel/cgroup/cgroup.c, it would use
> cgroup_tryget()/cgroup_is_dead() to check whether the cgrp is 'dead'.
> cgroup_tryget() seems is equal to bpf_cgroup_acquire(). So, maybe let's
> return a 'rcu' cgrp pointer. If BPF Prog want stronger guarantee of
> cgrp, just use bpf_cgroup_acquire().

and that would be misleading.
MEM_RCU means that the pointer is valid, but it could have refcnt =3D=3D 0,
while PTR_TRUSTED means that it's good to use as-is.

Here cgroup pointer is trusted. It's not a dead cgroup.
See kernel/bpf/cgroup_iter.c __cgroup_iter_seq_show().
bpf prog doesn't need to call bpf_cgroup_acquire.

