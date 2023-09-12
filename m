Return-Path: <bpf+bounces-9701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF1979C427
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 05:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 296531C20904
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 03:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876CE156CC;
	Tue, 12 Sep 2023 03:31:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453B94423
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 03:31:09 +0000 (UTC)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7081E6196;
	Mon, 11 Sep 2023 20:31:09 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-649edb3a3d6so23168156d6.0;
        Mon, 11 Sep 2023 20:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694489468; x=1695094268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9MZeZdeugBm4QxzIOrMKsGdKzrnk2bLq8bYUX0Gqf/Q=;
        b=eA59svIddRb5g3UiAPLSKDHjTiive/NSqInb2nNRW53/uWBgREnFN/qsoj1i5uf9Fn
         VaEa0fdUFEFg5AVdnxgtfv4arWNhp9bka2B3V9pekddbvkxBgLCECLAT6+ZbMpVIOVih
         UBvNgPUb1/FvyxKmeh7NdaoeuApfWm3aV6G4bJYZnnXHS8/qHySaa0cLERux5SycLBeI
         13pvyVH9sVOEhoNdyHRVCBDr5ri9cqx+retO7AzCNJYVgcagp79okWaMM0TXx31pk4c0
         zfdCv/cLM4UmZMFLAnYkmwDw/IMzRWIlKNsOYpkgvkQZmh6+qxQ22bM3f2bzAprFjtnF
         uWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694489468; x=1695094268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9MZeZdeugBm4QxzIOrMKsGdKzrnk2bLq8bYUX0Gqf/Q=;
        b=JZfUWewol1KdbxlH4OtIUDtx1ekr0mbvvbz5jtn3SepoaAtjpvYswubpcHmGV47Nni
         PE28FRureayKLuI+Otbgma9ANQX58ErkT4rn487knDYzZgsDu9NoP2DPOWXe9CyT01ES
         b8/xrbt8Lc9rbDsN0vN5AKPNKc/qtNnZWVsdincVRYfRn7cRGz7kIHUyYu9QS+xSNZzK
         sgQfQyUvIFxHbfZVDef6rICye3xggnup8UvRUF/WDRnos21tpYbA7nA4xGR22ZNlLTco
         x8VM3qnuaBV/WOuJ4WIS1/Ouxj1elT9qUnQr/bzOw0qrbNTW8zhxCP+1uUv154cPYL71
         Rmbw==
X-Gm-Message-State: AOJu0YxfvYsMzqIqVszMaNJo+pO2RRJePmMl5BXTF77x/xL690T6iUrI
	0JsaoRfNKKtARB00u+aNMFaTw5YVggctrjP6z8M=
X-Google-Smtp-Source: AGHT+IH5FPoTEv4lJflvPgVqTHyigiF0pn8LNcxR4N7h+fgA7kpjltLC27vMHJZ0E9E3YU9d4g/YfJoJwgkCBYAuifo=
X-Received: by 2002:a05:6214:501d:b0:63c:f325:bb03 with SMTP id
 jo29-20020a056214501d00b0063cf325bb03mr1885601qvb.8.1694489468523; Mon, 11
 Sep 2023 20:31:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230903142800.3870-1-laoar.shao@gmail.com> <qv2xdcsvb4brjsc7qx6ncxrudwusogdo4itzv4bx2perfjymwl@in7zaeymjiie>
 <CALOAHbB-PF1LjSAxoCdePN6Va4D+ufkeDmq8s3b0AGtfX5E-cQ@mail.gmail.com>
 <CAADnVQL+6PsRbNMo=8kJpgw1OTbdLG9epsup0q7La5Ffqj6g6A@mail.gmail.com>
 <CALOAHbBhOL9w+rnh_xkgZZBhxMpbrmLZWhm1X+ZeDLfxxt8Nrw@mail.gmail.com> <ZP93gUwf_nLzDvM5@mtj.duckdns.org>
In-Reply-To: <ZP93gUwf_nLzDvM5@mtj.duckdns.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 12 Sep 2023 11:30:32 +0800
Message-ID: <CALOAHbC=yxSoBR=vok2295ejDOEYQK2C8LRjDLGRruhq-rDjOQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/5] bpf, cgroup: Enable cgroup_array map on cgroup1
To: Tejun Heo <tj@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosryahmed@google.com>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 4:24=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> On Sun, Sep 10, 2023 at 11:17:48AM +0800, Yafang Shao wrote:
> > To acquire the cgroup_id, we can resort to open coding, as exemplified =
below:
> >
> >     task =3D bpf_get_current_task_btf();
> >     cgroups =3D task->cgroups;
> >     cgroup =3D cgroups->subsys[cpu_cgrp_id]->cgroup;
> >     key =3D cgroup->kn->id;
>
> You can't hardcode it to a specific controller tree like that. You either
> stick with fd based interface or need also add something to identify the
> specifc cgroup1 tree.

As pointed out by Alexei, I think we can introduce some
cgroup_id-based kfuncs which can work for both cgroup1 and cgroup2.

Something as follows (untested),

__bpf_kfunc u64 bpf_current_cgroup_id_from_subsys(int subsys)
{
        struct cgroup *cgroup;

        cgroup =3D task_cgroup(current, subsys);
        if (!cgroup)
            return 0;
        return cgroup_id(cgroup);
}

__bpf_kfunc struct cgroup *bpf_cgroup_from_subsys_id(u64 cgid, int subsys)
{
        struct cgroup_subsys_state *css =3D init_css_set.subsys[subsys];
        struct cgroup *subsys_root =3D css->cgroup;

        // We should introduce a new helper cgroup_get_from_subsys_id()
        // in the cgroup subsystem.
        return cgroup_get_from_subsys_id(subsys_root, cgid);
}

And change task_under_cgroup_hierarchy() as follows,

 static inline bool task_under_cgroup_hierarchy(struct task_struct *task,
                                               struct cgroup *ancestor)
 {
        struct css_set *cset =3D task_css_set(task);
-
-       return cgroup_is_descendant(cset->dfl_cgrp, ancestor);
+       struct cgroup *cgrp;
+       bool ret =3D false;
+
+       if (ancestor->root =3D=3D &cgrp_dfl_root)
+               return cgroup_is_descendant(cset->dfl_cgrp, ancestor);
+
+       cgroup_lock();
+       spin_lock_irq(&css_set_lock);
+       cgrp =3D task_cgroup_from_root(task, ancestor->root);
+       if (cgrp && cgroup_is_descendant(cgrp, ancestor))
+               ret =3D true;
+       spin_unlock_irq(&css_set_lock);
+       cgroup_unlock();
+       return ret;
 }

With the above changes, I think it can meet most use cases with BPF on cgro=
up1.
What do you think ?

--
Regards

Yafang

