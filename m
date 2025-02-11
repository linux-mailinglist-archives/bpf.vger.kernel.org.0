Return-Path: <bpf+bounces-51101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98239A30250
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 04:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94554188BDD6
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 03:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA8F1D54D1;
	Tue, 11 Feb 2025 03:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFij88ld"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0023214;
	Tue, 11 Feb 2025 03:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739245744; cv=none; b=gc9i7UFcuyFEgM+PT3AcOEgBBeHSlUThp5/fq9nlfsIq6lm9C+ODm3tkYpg9ok8OETNdLrCcIf/ybgTB+ZsaGruCIBdVskCdYMnnUAgfkSzydiZHnb19SIgTtzAmVJ8txbPUo4cN5ZUEU+rmUwgHZfXz82mXaQuSEEzlWizX3e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739245744; c=relaxed/simple;
	bh=CVLsmp1LRuNWzVp6hx4LTEb+q3YTAsfq6vaqfTvc2OY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lvh+D9sf0xiapDU1FjfA0XxVdeSvs9nbgWdb0IbBvZaXLE0BMAUMFDSzhA0egtj0SYxuoBeGpQs04h0pfm+s2UoAAmZzxQwqe8kqSckiHsryZ7Sh37kH+JHoBBAMNbfENWtoiIW9okg+KvngUjCC3WXwsK+rpvBKdLAtNbOExx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFij88ld; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4394036c0efso11824805e9.2;
        Mon, 10 Feb 2025 19:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739245740; x=1739850540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=koAuJ4PjXUiGGw43AdmoM6HX66pYKu8QZqYsy5ozR9k=;
        b=TFij88ldk1eE/waLPGotBg52XsxnD/zs0nsFlcc0eQn3ZDYGlGHbkI8okAjTyGjR5d
         1p1vD1lgC+x2Zk4Y1w8/XSMpLVZuJWyqxTnZm5iMY24h9pxS9tVsU87JpGom4/mq2+p9
         1HdjYENldUPbGE5msWPCwqnbpshMpG/X1+vyRRo59VUE4FUqalIGYvFw7mvvC7fdKkVX
         EsgjqrLXZUZpj41Vpj9trFir6fnQ9nHEZIMQpErHA3AQVBTxvX0MgK5JpjITjsjc5KbL
         gTA/ow/Ri4JPief4IrFFZKSwhUx3+/JtAVFMs5hYA+KZcIXZRjwjmLQy8CPrdPQd9eeV
         hk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739245740; x=1739850540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=koAuJ4PjXUiGGw43AdmoM6HX66pYKu8QZqYsy5ozR9k=;
        b=qjAU1DfFFZdp2yGWIBB4CRvLfVFV5BrSvssat+VW/s2UA0vfC5FK+xjhwUGE6DQyX2
         +oIuIsKujmqviMWptNAu5odTxenKJKJrtDa8WAX2AdKyXDKp3vjiP//2hO0y4PlJhSQ7
         AgVDlsTCDrToJ+awV1lSKLR58NbxbJVZsw4OBo7ZfelNMSomNpSq3HZkyzxAyjTqHEoL
         SXz9PZcBhlaNYkdNTHPT2MmTDQVPiR7BwOBn5swAmM0jJWlen5AfEhwaIc4xFf/yX8Ar
         p8QoPSzxYWRIs0hOsyV61vlOjVioOq7u+pfgZczPbMgkphIzinnNokxPizRQ/Lr3sgW8
         ByfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpcTP8o6k9Sk8Af0uruCWGTGz+iYNpXpvZBfkOLMXY6oWfYtoocekQb8eZEBUZGAycVhg=@vger.kernel.org, AJvYcCXT1xfDQm88s1PsiXTrRHWpgOJfCPwiPpY97mPMT1vmATb2mRxmuEd8WJRKL5zQUC0Atg97X2O1HXhluaS2@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8EjZRxjjeu7dsMBQLH8kI6eWKYyOt6aP3RbFqc9yLgKHTHJP+
	MfOwd30lhkHqP3s+nt3A2/Kt/W3A8htii6qcSNlYMFvpp+nkwtqOeMbpOHlXOF433KR6RpgoUzx
	RWziMgv3uz7HimT+kuy06Gs11a5Q=
X-Gm-Gg: ASbGnctpDSJVajjZu/TS14yV4bibeBuwvrUeG/FPXKmt8+Cc1hqZaxCNspSNS6bUUVE
	hZEIXJvKCAZJxPuBKNSr7o52vZZAlO1ulbUDIqrmtzeujt1DfNNw2/hoOczJTK71G43yTASzBPf
	CvXtuNM0CvfBQlwIairIiwr6VJzYP6
X-Google-Smtp-Source: AGHT+IGAmMbZArySpF13CgRirtAx57Tj9W3Hx1S2Z/fIEOqtibbAz2fZiNPQHk05WAGCVpWpqHwCay/XE2vMDVqm3Lg=
X-Received: by 2002:a05:600c:5103:b0:439:5529:33e0 with SMTP id
 5b1f17b1804b1-439552935afmr1088415e9.27.1739245740316; Mon, 10 Feb 2025
 19:49:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB5080261D024B49D26F3FFF0099F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080EDA5E2E2FDB96C98F72F99F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQJZnNj3KGcy-MKz_F2KEiKWGpXchxVx1zuGA-5g3SO=HQ@mail.gmail.com> <AM6PR03MB5080933CC30F9105A617351E99F22@AM6PR03MB5080.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB5080933CC30F9105A617351E99F22@AM6PR03MB5080.eurprd03.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 10 Feb 2025 19:48:49 -0800
X-Gm-Features: AWEUYZlJpW3k_r9bG4pY3030cMGys1WZqAjGgfdZmDSYDCZDE5mqhbIrmQ8YZFw
Message-ID: <CAADnVQ+BmPeDxZUJ51qBQjK+yMSVkVLR2maSbe03tr+8T+Qnqw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 6/8] sched_ext: Add filter for scx_kfunc_ids_unlocked
To: Juntong Deng <juntong.deng@outlook.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, changwoo@igalia.com, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 3:40=E2=80=AFPM Juntong Deng <juntong.deng@outlook.=
com> wrote:
>
> On 2025/2/8 03:37, Alexei Starovoitov wrote:
> > On Wed, Feb 5, 2025 at 11:35=E2=80=AFAM Juntong Deng <juntong.deng@outl=
ook.com> wrote:
> >>
> >> This patch adds filter for scx_kfunc_ids_unlocked.
> >>
> >> The kfuncs in the scx_kfunc_ids_unlocked set can be used in init, exit=
,
> >> cpu_online, cpu_offline, init_task, dump, cgroup_init, cgroup_exit,
> >> cgroup_prep_move, cgroup_cancel_move, cgroup_move, cgroup_set_weight
> >> operations.
> >>
> >> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> >> ---
> >>   kernel/sched/ext.c | 30 ++++++++++++++++++++++++++++++
> >>   1 file changed, 30 insertions(+)
> >>
> >> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> >> index 7f039a32f137..955fb0f5fc5e 100644
> >> --- a/kernel/sched/ext.c
> >> +++ b/kernel/sched/ext.c
> >> @@ -7079,9 +7079,39 @@ BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq, K=
F_RCU)
> >>   BTF_ID_FLAGS(func, scx_bpf_dispatch_vtime_from_dsq, KF_RCU)
> >>   BTF_KFUNCS_END(scx_kfunc_ids_unlocked)
> >>
> >> +static int scx_kfunc_ids_unlocked_filter(const struct bpf_prog *prog,=
 u32 kfunc_id)
> >> +{
> >> +       u32 moff;
> >> +
> >> +       if (!btf_id_set8_contains(&scx_kfunc_ids_unlocked, kfunc_id) |=
|
> >> +           prog->aux->st_ops !=3D &bpf_sched_ext_ops)
> >> +               return 0;
> >> +
> >> +       moff =3D prog->aux->attach_st_ops_member_off;
> >> +       if (moff =3D=3D offsetof(struct sched_ext_ops, init) ||
> >> +           moff =3D=3D offsetof(struct sched_ext_ops, exit) ||
> >> +           moff =3D=3D offsetof(struct sched_ext_ops, cpu_online) ||
> >> +           moff =3D=3D offsetof(struct sched_ext_ops, cpu_offline) ||
> >> +           moff =3D=3D offsetof(struct sched_ext_ops, init_task) ||
> >> +           moff =3D=3D offsetof(struct sched_ext_ops, dump))
> >> +               return 0;
> >> +
> >> +#ifdef CONFIG_EXT_GROUP_SCHED
> >> +       if (moff =3D=3D offsetof(struct sched_ext_ops, cgroup_init) ||
> >> +           moff =3D=3D offsetof(struct sched_ext_ops, cgroup_exit) ||
> >> +           moff =3D=3D offsetof(struct sched_ext_ops, cgroup_prep_mov=
e) ||
> >> +           moff =3D=3D offsetof(struct sched_ext_ops, cgroup_cancel_m=
ove) ||
> >> +           moff =3D=3D offsetof(struct sched_ext_ops, cgroup_move) ||
> >> +           moff =3D=3D offsetof(struct sched_ext_ops, cgroup_set_weig=
ht))
> >> +               return 0;
> >> +#endif
> >> +       return -EACCES;
> >> +}
> >> +
> >>   static const struct btf_kfunc_id_set scx_kfunc_set_unlocked =3D {
> >>          .owner                  =3D THIS_MODULE,
> >>          .set                    =3D &scx_kfunc_ids_unlocked,
> >> +       .filter                 =3D scx_kfunc_ids_unlocked_filter,
> >>   };
> >
> > why does sched-ext use so many id_set-s ?
> >
> >          if ((ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OP=
S,
> >                                               &scx_kfunc_set_select_cpu=
)) ||
> >              (ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OP=
S,
> >
> > &scx_kfunc_set_enqueue_dispatch)) ||
> >              (ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OP=
S,
> >                                               &scx_kfunc_set_dispatch))=
 ||
> >              (ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OP=
S,
> >                                               &scx_kfunc_set_cpu_releas=
e)) ||
> >              (ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OP=
S,
> >                                               &scx_kfunc_set_unlocked))=
 ||
> >
> > Can they all be rolled into one id_set then
> > the patches 2-6 will be collapsed into one patch and
> > one filter callback that will describe allowed hook/kfunc combinations?
>
> Yes, I agree that it would be ideal to put all kfuncs in the one id_set,
> but I am not sure that this is better in implementation.
>
> For filters, the only kfunc-related information that can be known is
> the kfunc_id.
>
> kfunc_id is not a stable value, for example, when we add a new kfunc to
> the kernel, it may cause the kfunc_id of other kfuncs to change.
>
> A simple experiment is to add a bpf_task_from_aaa kfunc, and then we
> will find that the kfunc_id of bpf_task_from_pid has changed.
>
> This means that it is simple for us to implement kfuncs grouping via
> id_set because we only need to check if kfunc_id exists in a specific
> id_set, we do not need to care about what kfunc_id is.
>
> But if we implement grouping only in the filter, we may need to first
> get the btf type of the corresponding kfunc based on the kfunc_id via
> btf_type_by_id, and then further get the kfunc name, and then group
> based on the kfunc name in the filter, which seems more complicated.

I didn't mean to extract kfunc name as a string and do strcmp() on it.
That's a non-starter.
I imagined verifier-like approach of enum+set+list
where enum has all kfunc names,
set gives efficient btf_id_set8_contains() access,
and list[KF_bpf_foo] gives func_id to compare with.

But if the current break down of scx_kfunc_set_* fits well
with per struct_ops hook filtering then keep it.
But please think of a set approach for moff as well to avoid
+           moff =3D=3D offsetof(struct sched_ext_ops, exit) ||
+           moff =3D=3D offsetof(struct sched_ext_ops, cpu_online) ||
+           moff =3D=3D offsetof(struct sched_ext_ops, cpu_offline) ||

Then it will be:
if (btf_id_set8_contains(&scx_kfunc_ids_unlocked, kfunc_id) ...
&& moff_set_containts(.._unlocked, moff)) // allow

There is SCX_OP_IDX(). Maybe it can be used to populate a set.

Something like this:
static const u32 ops_flags[] =3D {
  [SCX_OP_IDX(cpu_online)] =3D KF_UNLOCKED,
  ..
};

if (btf_id_set8_contains(&scx_kfunc_ids_unlocked, kfunc_id) &&
    (ops_flags[moff / sizeof(void (*)(void))] & KF_UNLOCKED)) // allow

