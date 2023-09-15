Return-Path: <bpf+bounces-10178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAF27A26B4
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 20:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 408E91C20A73
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 18:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD7F18E09;
	Fri, 15 Sep 2023 18:58:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5202362
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 18:58:10 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FB32D6D
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 11:57:37 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31ff2ce9d4cso950921f8f.0
        for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 11:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694804256; x=1695409056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vEGyk9aimWeGVbqBDG5yx1Ea1IhyMQsNWatyoWMLY8=;
        b=dY9jggijZ+uU4ytjXw5vqNvsdoRFFYoR4wT+b2nYenO+ihE5BpwKiJjJ5OQggRUW+0
         0efTP4vGgelj4dko9e7ygo3nK3azUMfv698qZ730JytLdCR2zs5KocemkJ82BInsVLIr
         qvBQ2cSCND7hxwY/Ft/n4LcuWtnkaaC5RHCzbfjeqWrSV6A17ZfP9iI9R0mc4S2W1Jf3
         4pPoyDwhlKS4iFhYkcNtOF/GQLVLGZSlt2D6jKN+c7j6DPkDqgNvRf9URec/6fM5ikMf
         ZU0pCWe1Pp4GxsMMhN2U+wi4pmiyzdPwoguJaUKp8UmLDgFBr3ENlPp+cbtUPcJPNILu
         c7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694804256; x=1695409056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9vEGyk9aimWeGVbqBDG5yx1Ea1IhyMQsNWatyoWMLY8=;
        b=ZIqgxgB8JdFq3ADYjbOeBun0fy60eWSH14GtuuoqqSeWRERp4HtynSye6n8iZK0xqA
         RqRidUP6o8PlCzkvAgM7ITRR4rGC9Efeu1o5D3PR+qbAMNAg3ufVpFpxThzR68q9iYio
         qqeNLIC5iqKpqMD/34jg4MkQlhMC/Lg7N5ttTLH6z3uG+EFeOn9bj+QzDzw3thOwE4ld
         sBMBbLufnROkaQlEPWS8iRD3pWaU7vlTlJN3BBqS/m9o9/e9UBBOXmBhqdWnIYnt9HXN
         3iDPrA5zu93Iv9JpMs4dzB/WR3T9+sE0m3L+myWAB0tEA1/PTVzSCD0z+wJZhKctvU7C
         9IEw==
X-Gm-Message-State: AOJu0Yw2+/kfAc+b4WXvq3nFNHwHXoutAE+eJ/eB+CrfMwIT73cpWHp3
	cgHAxeK4pVEm/n1tvLGoeBIkULyjhW8upb6d7wB0nA==
X-Google-Smtp-Source: AGHT+IFlksvjyzSEvarhPqlfaj6XF/zIYj46uIyePCmqFCxffGT4/gGEPVHY7vFw4ORaKjihuFk0NLkrAPjPwY19wR4=
X-Received: by 2002:adf:a30d:0:b0:31f:fa38:425f with SMTP id
 c13-20020adfa30d000000b0031ffa38425fmr1227612wrb.9.1694804256023; Fri, 15 Sep
 2023 11:57:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230903142800.3870-1-laoar.shao@gmail.com> <qv2xdcsvb4brjsc7qx6ncxrudwusogdo4itzv4bx2perfjymwl@in7zaeymjiie>
 <CALOAHbB-PF1LjSAxoCdePN6Va4D+ufkeDmq8s3b0AGtfX5E-cQ@mail.gmail.com>
 <CAADnVQL+6PsRbNMo=8kJpgw1OTbdLG9epsup0q7La5Ffqj6g6A@mail.gmail.com>
 <CALOAHbBhOL9w+rnh_xkgZZBhxMpbrmLZWhm1X+ZeDLfxxt8Nrw@mail.gmail.com>
 <ZP93gUwf_nLzDvM5@mtj.duckdns.org> <CALOAHbC=yxSoBR=vok2295ejDOEYQK2C8LRjDLGRruhq-rDjOQ@mail.gmail.com>
In-Reply-To: <CALOAHbC=yxSoBR=vok2295ejDOEYQK2C8LRjDLGRruhq-rDjOQ@mail.gmail.com>
From: Hao Luo <haoluo@google.com>
Date: Fri, 15 Sep 2023 11:57:23 -0700
Message-ID: <CA+khW7hah317_beZ7QDA1R=sWi5q7TanRC+efMhivPKtWzbA4w@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/5] bpf, cgroup: Enable cgroup_array map on cgroup1
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 11, 2023 at 8:31=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Tue, Sep 12, 2023 at 4:24=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
> >
> > On Sun, Sep 10, 2023 at 11:17:48AM +0800, Yafang Shao wrote:
> > > To acquire the cgroup_id, we can resort to open coding, as exemplifie=
d below:
> > >
> > >     task =3D bpf_get_current_task_btf();
> > >     cgroups =3D task->cgroups;
> > >     cgroup =3D cgroups->subsys[cpu_cgrp_id]->cgroup;
> > >     key =3D cgroup->kn->id;
> >
> > You can't hardcode it to a specific controller tree like that. You eith=
er
> > stick with fd based interface or need also add something to identify th=
e
> > specifc cgroup1 tree.
>
> As pointed out by Alexei, I think we can introduce some
> cgroup_id-based kfuncs which can work for both cgroup1 and cgroup2.
>
> Something as follows (untested),
>
> __bpf_kfunc u64 bpf_current_cgroup_id_from_subsys(int subsys)
> {
>         struct cgroup *cgroup;
>
>         cgroup =3D task_cgroup(current, subsys);
>         if (!cgroup)
>             return 0;
>         return cgroup_id(cgroup);
> }
>

Can we also support checking arbitrary tasks, instead of just current?
I find myself often needing to find the cgroup only given a
task_struct. For example, when attaching to context switch, I want to
know whether the next task is under a cgroup. Having such a kfunc
would be very useful. It can also be used in task_iter programs.

Hao

