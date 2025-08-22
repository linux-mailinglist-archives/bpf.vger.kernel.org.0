Return-Path: <bpf+bounces-66306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D94B322A7
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 21:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAA4A5E151D
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 19:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162582C327A;
	Fri, 22 Aug 2025 19:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRq9tUey"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1321922A80D;
	Fri, 22 Aug 2025 19:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755890009; cv=none; b=Rf5pbd4/oLEGqxlsSg+SIIt7E6UDlKnDRMezP9Ag9FvjtO38JJzo190heBmYUse3YGvcEVF6a5hYB1qV9U9uhvgZ8EQd+HxHIAf2Zt71jFU2SZx56CvSC31hjxKbg8/6Vq+PHfBdxWd6dmMb4aD5M+ltsiBnMq/Zi6CezTmZsF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755890009; c=relaxed/simple;
	bh=N6dImaALuObS+QkyB0rlcYKt2AMCdlGKWH1Xuth9xBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vp1JmcAzQjz+9nHuLVjLzwryxCVV7S5Rpvv/ClJLWqy2rW1z6j8XcblERo0TKei1ef7pzbpLRj+luqyH/2wbsX64/2cXVVqpNmVRHLaC6GAjV9wZuUAHuMMjKpUDVvM7OO938Wk/VvAUT2VaIP/dHqotRKh5uwVKpeuEwFMUSks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRq9tUey; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e6cbb9956so2009624b3a.0;
        Fri, 22 Aug 2025 12:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755890006; x=1756494806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rr3B8IgoZsNGJK4dwioo7BrKX/zcrXN6T1bvaEXYCOM=;
        b=LRq9tUeyv1s9/HJDaLVyKldxhO0EHFYJexVgCR3ZvB8dor2VS3IRaljjjxGUAWx4Qz
         HVRDQ2U5IjwO+OYcFR/shD7x68dF5U3Mu0zVvZA4UJkA/vKWdNtXA+Cyra0VOllJMS5y
         cgfFsBtbFhYIJY/l7eznCzTPhuV1nDOKDTtW66RjkAGQLNgc2+OUfJzDdwLTrvkVFdnJ
         suUosvlia+qlMv0Z8NkdBw8Rab4OVZ8K96qWW+t5wHyTmXFf/v+Sk8Kk8Om/FUIT1N2B
         1/UHEKGYoCZT9KIerewlPimZnt0mdB14zzvE3wda4XN6y+JRu7RNXLnUr1xUblYRMWJ4
         BiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755890006; x=1756494806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rr3B8IgoZsNGJK4dwioo7BrKX/zcrXN6T1bvaEXYCOM=;
        b=AstSvZluvLs8USc772gsKNB8MuBJFJjPZYaBSCSCVyZSryDttta58saIyuakGJ18mV
         8xBDIbfeg6zdSY3t9ws11BZwqQP4ONrQ5Pdr5/dwlFbam1A5sET++8foTOOD8RmXj+DC
         fkQFcpbgtFfbqIGyQfhFf6ze8oVhIROlyP35xihaUihmRx/vxKL1z+rO3U9eq9Qrb2ey
         JJ6iktdGWfP+R1rVlbP6V/1Wj0Eze/uht3vAG7e0YcY8g8qTW1RaNMmbcODQ4JwIvR2h
         AxQ7bzWqMVIE33Q8Zh9LXoPuX7XZv1MF4QgFSqotUywbDW0QsCg776/w+69JaLHwoVHv
         SnPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdi7YqSRhJrOS0XrOn0HYKnultxQGzgULLPGTDnXPSduE8BkvyasVS+ODKYA7awtvuV2YNpCE7qjDuSkKT@vger.kernel.org, AJvYcCXYdQw9vrJaxr5Bgoo+JiJTfx43Hn9YdWp6rg1j8HbNMtZpJ4eixnCF9d1kMvBVLuc3heo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS+AYLjEZXUMGPNza2n8hpfbnTaoM+j4Tcfv0wUBSlx444SIez
	dufuFL/ba+S+l4L7FbTZP4z+y19Ooi3kJAqPlAKL3WqqSgG5Y8yNSGKx4lbiz8oXG/eOPXwiucm
	Z0EXT4nh+0b+1ctMNCjsQlVDfrVMSJ8s=
X-Gm-Gg: ASbGnctwpzoFWpYYoD44ijGiF4ggWEAPEST+eJdKZQPZ92/ynEjuTvp5DqmlL82azL5
	qTHaslH6WisfJBwsgpN5ljMLjZOJ9jyXsZ12MmISpgfdyDUOYpQp6MBv221ts/7uupAs+d6Gco/
	iK3hfWtDXCURH1sIumpr5X0wpV/aqhAbnkzgFiQ8WRfcFsfs5wriHjmkE7uXZdsRhJq3RLFP4Xa
	Q3JB+3baCLJ8xQuiFm/6ag=
X-Google-Smtp-Source: AGHT+IEUPdhoet8jrQirt84K83hTVjP6JqmrH2DzXgXUSCCRt5gbEyubUQ/mDu940WXbEduf6lLFLnOX+JwZ67kpVA8=
X-Received: by 2002:a17:902:e84e:b0:240:1831:eede with SMTP id
 d9443c01a7336-2462ef4cc1amr47852345ad.32.1755890006207; Fri, 22 Aug 2025
 12:13:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
 <20250818170136.209169-14-roman.gushchin@linux.dev> <CAEf4BzaSLWB1xpCjX35oxg2ySvvgRvEmQ01PtXv+xEz-Zkz07w@mail.gmail.com>
 <87ect5lde2.fsf@linux.dev>
In-Reply-To: <87ect5lde2.fsf@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 Aug 2025 12:13:11 -0700
X-Gm-Features: Ac12FXx9rrxQeKRIUn_3zD-HDb8EfmIEokCwvI_1Ww7OzQe2cV8GAZE2sNvy5y0
Message-ID: <CAEf4BzbSw_0eDWwHsXiK3cPdZuPjs+TMvbXk-pa+_-JWF2jWmQ@mail.gmail.com>
Subject: Re: [PATCH v1 13/14] sched: psi: implement bpf_psi_create_trigger() kfunc
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-mm@kvack.org, bpf@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Song Liu <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 5:36=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> > On Mon, Aug 18, 2025 at 10:06=E2=80=AFAM Roman Gushchin
> > <roman.gushchin@linux.dev> wrote:
> >>
> >> Implement a new bpf_psi_create_trigger() bpf kfunc, which allows
> >> to create new psi triggers and attach them to cgroups or be
> >> system-wide.
> >>
> >> Created triggers will exist until the struct ops is loaded and
> >> if they are attached to a cgroup until the cgroup exists.
> >>
> >> Due to a limitation of 5 arguments, the resource type and the "full"
> >> bit are squeezed into a single u32.
> >>
> >> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> >> ---
> >>  kernel/sched/bpf_psi.c | 84 +++++++++++++++++++++++++++++++++++++++++=
+
> >>  1 file changed, 84 insertions(+)
> >>
> >> diff --git a/kernel/sched/bpf_psi.c b/kernel/sched/bpf_psi.c
> >> index 2ea9d7276b21..94b684221708 100644
> >> --- a/kernel/sched/bpf_psi.c
> >> +++ b/kernel/sched/bpf_psi.c
> >> @@ -156,6 +156,83 @@ static const struct bpf_verifier_ops bpf_psi_veri=
fier_ops =3D {
> >>         .is_valid_access =3D bpf_psi_ops_is_valid_access,
> >>  };
> >>
> >> +__bpf_kfunc_start_defs();
> >> +
> >> +/**
> >> + * bpf_psi_create_trigger - Create a PSI trigger
> >> + * @bpf_psi: bpf_psi struct to attach the trigger to
> >> + * @cgroup_id: cgroup Id to attach the trigger; 0 for system-wide sco=
pe
> >> + * @resource: resource to monitor (PSI_MEM, PSI_IO, etc) and the full=
 bit.
> >> + * @threshold_us: threshold in us
> >> + * @window_us: window in us
> >> + *
> >> + * Creates a PSI trigger and attached is to bpf_psi. The trigger will=
 be
> >> + * active unless bpf struct ops is unloaded or the corresponding cgro=
up
> >> + * is deleted.
> >> + *
> >> + * Resource's most significant bit encodes whether "some" or "full"
> >> + * PSI state should be tracked.
> >> + *
> >> + * Returns 0 on success and the error code on failure.
> >> + */
> >> +__bpf_kfunc int bpf_psi_create_trigger(struct bpf_psi *bpf_psi,
> >> +                                      u64 cgroup_id, u32 resource,
> >> +                                      u32 threshold_us, u32 window_us=
)
> >> +{
> >> +       enum psi_res res =3D resource & ~BPF_PSI_FULL;
> >> +       bool full =3D resource & BPF_PSI_FULL;
> >> +       struct psi_trigger_params params;
> >> +       struct cgroup *cgroup __maybe_unused =3D NULL;
> >> +       struct psi_group *group;
> >> +       struct psi_trigger *t;
> >> +       int ret =3D 0;
> >> +
> >> +       if (res >=3D NR_PSI_RESOURCES)
> >> +               return -EINVAL;
> >> +
> >> +#ifdef CONFIG_CGROUPS
> >> +       if (cgroup_id) {
> >> +               cgroup =3D cgroup_get_from_id(cgroup_id);
> >> +               if (IS_ERR_OR_NULL(cgroup))
> >> +                       return PTR_ERR(cgroup);
> >> +
> >> +               group =3D cgroup_psi(cgroup);
> >> +       } else
> >> +#endif
> >> +               group =3D &psi_system;
> >
> > just a drive-by comment while skimming through the patch set: can't
> > you use IS_ENABLED(CONFIG_CGROUPS) and have a proper if/else with
> > proper {} ?
>
> Fixed.
> It required defining cgroup_get_from_id() and cgroup_psi()
> for !CONFIG_CGROUPS, but I agree, it's much better.
> Thanks
>
> >
> >> +
> >> +       params.type =3D PSI_BPF;
> >> +       params.bpf_psi =3D bpf_psi;
> >> +       params.privileged =3D capable(CAP_SYS_RESOURCE);
> >> +       params.res =3D res;
> >> +       params.full =3D full;
> >> +       params.threshold_us =3D threshold_us;
> >> +       params.window_us =3D window_us;
> >> +
> >> +       t =3D psi_trigger_create(group, &params);
> >> +       if (IS_ERR(t))
> >> +               ret =3D PTR_ERR(t);
> >> +       else
> >> +               t->cgroup_id =3D cgroup_id;
> >> +
> >> +#ifdef CONFIG_CGROUPS
> >> +       if (cgroup)
> >> +               cgroup_put(cgroup);
> >> +#endif
> >> +
> >> +       return ret;
> >> +}
> >> +__bpf_kfunc_end_defs();
> >> +
> >> +BTF_KFUNCS_START(bpf_psi_kfuncs)
> >> +BTF_ID_FLAGS(func, bpf_psi_create_trigger, KF_TRUSTED_ARGS)
> >> +BTF_KFUNCS_END(bpf_psi_kfuncs)
> >> +
> >> +static const struct btf_kfunc_id_set bpf_psi_kfunc_set =3D {
> >> +       .owner          =3D THIS_MODULE,
> >> +       .set            =3D &bpf_psi_kfuncs,
> >> +};
> >> +
> >>  static int bpf_psi_ops_reg(void *kdata, struct bpf_link *link)
> >>  {
> >>         struct bpf_psi_ops *ops =3D kdata;
> >> @@ -238,6 +315,13 @@ static int __init bpf_psi_struct_ops_init(void)
> >>         if (!bpf_psi_wq)
> >>                 return -ENOMEM;
> >>
> >> +       err =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
> >> +                                       &bpf_psi_kfunc_set);
> >
> > would this make kfunc callable from any struct_ops, not just this psi
> > one?
>
> It will. Idk how big of a problem it is, given that the caller needs
> a trusted reference to bpf_psi.

Yes, I agree, probably not a big deal.

> Also, is there a simple way to constrain it? Wdyt?

We've talked about having the ability to restrict kfuncs to specific
struct_ops types, but I don't think we've ever made much progress on
this. So no, I don't think there is a simple way.

