Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2409345D497
	for <lists+bpf@lfdr.de>; Thu, 25 Nov 2021 07:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347454AbhKYGOl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Nov 2021 01:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347436AbhKYGMk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Nov 2021 01:12:40 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57C6C06175F;
        Wed, 24 Nov 2021 22:09:29 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id q16so4264309pgq.10;
        Wed, 24 Nov 2021 22:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WpxNPqXKQvidaY5SQ6bBlicFWfBxg4MtOjCEcbrjTZI=;
        b=mhCvr7C7AQ/d37bOMSEjmykiMiM7CGbYRgPlA7thXLkHtbcgXWc/YUnm9Y4L62fVql
         kohIqOirtAI6Vl1MDAt/khZVgGJYLuxwmaARcA2NSGV5m+HR27KOM874LtDTmH1n3hbX
         dDIMqo5yB71Kd8asOniD1uamIZjHS/1wFgAHJ5noR2hkxR7SuFwMiAOJvTLvbbh9C4GZ
         SHolBkl9anidSDm8PuD+wK9ojcCy4b926Nd9HktN0A2C79WVR3p8db6RDGdfFU3PZboX
         nepALZ4bpsO2ETsEydxcGeQq5hybV4v7e5s87nXSVx1BiblgKkgyYFSkrKQL2TCNP85T
         7kEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WpxNPqXKQvidaY5SQ6bBlicFWfBxg4MtOjCEcbrjTZI=;
        b=08i/Q9YeCEDCZBZpNY37Q/OEUwtaGTDdwmH+uqJY8ANuaGCuY/lU48OnRIGzFp8haA
         BSdIpVW4lgrK/YonXpAxkslRUoJUts1cRm+UuvQKe6S4/DB/a6aRQK9iGnPSWGnNjenJ
         w/06rURMsZLb+7x6sbfcEdBWMNHX2Z24vIRvAoXsNWtZ3RNgzRckv4uFPRTVLKrLBMea
         xBsEurl0viLtyYghCPZs9Hhbu4lMP1R3Ptc6TddNRt9By+nXKHebwrfTdP7L0eWiR54+
         OWpZgXp9WKl9u/AnJ4d96ewbm7zlPZiXrGGR66cZvoj/BMovm49cSDFvkQs4eU8vnvRc
         66zg==
X-Gm-Message-State: AOAM530GaU7O7J2hN6IV+zdET60ssxg0ThSRD2ek6V8tcpMVkpyOBpIX
        1pftAHnMfH3SkBX/5h73f2Q=
X-Google-Smtp-Source: ABdhPJwY1WGs91mS3xL0WBFSO5qbMKOp2jiEuP8A8KtG7Xyt49UfOENHhDk+YjoDQdGZcgY8tkmdgA==
X-Received: by 2002:a05:6a00:130c:b0:4a2:6c4c:55d0 with SMTP id j12-20020a056a00130c00b004a26c4c55d0mr12369910pfu.5.1637820569141;
        Wed, 24 Nov 2021 22:09:29 -0800 (PST)
Received: from smtpclient.apple ([139.226.50.8])
        by smtp.gmail.com with ESMTPSA id d15sm1755114pfl.126.2021.11.24.22.09.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Nov 2021 22:09:28 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH rfc 2/6] bpf: sched: add convenient helpers to identify
 sched entities
From:   Yafang Shao <laoar.shao@gmail.com>
In-Reply-To: <20210916162451.709260-3-guro@fb.com>
Date:   Thu, 25 Nov 2021 14:09:00 +0800
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1334F6BA-BAE1-4FF8-B84C-3C1AE733CA7A@gmail.com>
References: <20210915213550.3696532-1-guro@fb.com>
 <20210916162451.709260-1-guro@fb.com> <20210916162451.709260-3-guro@fb.com>
To:     Roman Gushchin <guro@fb.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Sep 17, 2021, at 12:24 AM, Roman Gushchin <guro@fb.com> wrote:
>=20
> This patch adds 3 helpers useful for dealing with sched entities:
> u64 bpf_sched_entity_to_tgidpid(struct sched_entity *se);
> u64 bpf_sched_entity_to_cgrpid(struct sched_entity *se);
> long bpf_sched_entity_belongs_to_cgrp(struct sched_entity *se, u64 =
cgrpid);
>=20
> Sched entity is a basic structure used by the scheduler to represent
> schedulable objects: tasks and cgroups (if CONFIG_FAIR_GROUP_SCHED
> is enabled). It will be passed as an argument to many bpf hooks, so
> scheduler bpf programs need a convenient way to deal with it.
>=20
> bpf_sched_entity_to_tgidpid() and bpf_sched_entity_to_cgrpid() are
> useful to identify a sched entity in userspace terms (pid, tgid and
> cgroup id). bpf_sched_entity_belongs_to_cgrp() allows to check whether
> a sched entity belongs to sub-tree of a cgroup. It allows to write
> cgroup-specific scheduler policies even without enabling the cgroup
> cpu controller.
>=20
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
> include/uapi/linux/bpf.h       | 23 +++++++++++
> kernel/sched/bpf_sched.c       | 74 ++++++++++++++++++++++++++++++++++
> scripts/bpf_doc.py             |  2 +
> tools/include/uapi/linux/bpf.h | 23 +++++++++++
> 4 files changed, 122 insertions(+)
>=20
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 6dfbebb8fc8f..199e4a92820d 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -4900,6 +4900,26 @@ union bpf_attr {
> *		**-EINVAL** if *flags* is not zero.
> *
> *		**-ENOENT** if architecture does not support branch =
records.
> + *
> + * u64 bpf_sched_entity_to_tgidpid(struct sched_entity *se)
> + *	Description
> + *		Return task's encoded tgid and pid if the sched entity =
is a task.
> + *	Return
> + *		Tgid and pid encoded as tgid << 32 \| pid, if *se* is a =
task. (u64)-1 otherwise.
> + *
> + * u64 bpf_sched_entity_to_cgrpid(struct sched_entity *se)
> + *	Description
> + *		Return cgroup id if the given sched entity is a cgroup.
> + *	Return
> + *		Cgroup id, if *se* is a cgroup. (u64)-1 otherwise.
> + *
> + * long bpf_sched_entity_belongs_to_cgrp(struct sched_entity *se, u64 =
cgrpid)
> + *	Description
> + *		Checks whether the sched entity belongs to a cgroup or
> + *		it's sub-tree. It doesn't require a cgroup CPU =
controller
> + *		to be enabled.
> + *	Return
> + *		1 if the sched entity belongs to a cgroup, 0 otherwise.
> */
> #define __BPF_FUNC_MAPPER(FN)		\
> 	FN(unspec),			\
> @@ -5079,6 +5099,9 @@ union bpf_attr {
> 	FN(get_attach_cookie),		\
> 	FN(task_pt_regs),		\
> 	FN(get_branch_snapshot),	\
> +	FN(sched_entity_to_tgidpid),	\
> +	FN(sched_entity_to_cgrpid),	\
> +	FN(sched_entity_belongs_to_cgrp),	\
> 	/* */
>=20
> /* integer value in 'imm' field of BPF_CALL instruction selects which =
helper
> diff --git a/kernel/sched/bpf_sched.c b/kernel/sched/bpf_sched.c
> index 2f05c186cfd0..ead691dc6e85 100644
> --- a/kernel/sched/bpf_sched.c
> +++ b/kernel/sched/bpf_sched.c
> @@ -42,12 +42,86 @@ int bpf_sched_verify_prog(struct bpf_verifier_log =
*vlog,
> 	return 0;
> }
>=20
> +BPF_CALL_1(bpf_sched_entity_to_tgidpid, struct sched_entity *, se)
> +{
> +	if (entity_is_task(se)) {
> +		struct task_struct *task =3D task_of(se);
> +
> +		return (u64) task->tgid << 32 | task->pid;
> +	} else {
> +		return (u64) -1;
> +	}
> +}
> +
> +BPF_CALL_1(bpf_sched_entity_to_cgrpid, struct sched_entity *, se)
> +{
> +#ifdef CONFIG_FAIR_GROUP_SCHED
> +	if (!entity_is_task(se))
> +		return cgroup_id(se->cfs_rq->tg->css.cgroup);
> +#endif
> +	return (u64) -1;
> +}
> +
> +BPF_CALL_2(bpf_sched_entity_belongs_to_cgrp, struct sched_entity *, =
se,
> +	   u64, cgrpid)
> +{
> +#ifdef CONFIG_CGROUPS
> +	struct cgroup *cgrp;
> +	int level;
> +
> +	if (entity_is_task(se))
> +		cgrp =3D task_dfl_cgroup(task_of(se));
> +#ifdef CONFIG_FAIR_GROUP_SCHED
> +	else
> +		cgrp =3D se->cfs_rq->tg->css.cgroup;

It is incorrect.=20
It  should use se->my_q->tg->css.cgroup and some possible NULL check.  =
(for autogroup)
se->cfs_rq and se->my_q are different. se->my_q is the cfs_rq of this se =
itself, while the se->cfs_rq may be the parent.=20



> +#endif
> +
> +	for (level =3D cgrp->level; level; level--)
> +		if (cgrp->ancestor_ids[level] =3D=3D cgrpid)
> +			return 1;
> +#endif
> +	return 0;
> +}
> +
> +BTF_ID_LIST_SINGLE(btf_sched_entity_ids, struct, sched_entity)
> +
> +static const struct bpf_func_proto bpf_sched_entity_to_tgidpid_proto =
=3D {
> +	.func		=3D bpf_sched_entity_to_tgidpid,
> +	.gpl_only	=3D false,
> +	.ret_type	=3D RET_INTEGER,
> +	.arg1_type	=3D ARG_PTR_TO_BTF_ID,
> +	.arg1_btf_id	=3D &btf_sched_entity_ids[0],
> +};
> +
> +static const struct bpf_func_proto bpf_sched_entity_to_cgrpid_proto =3D=
 {
> +	.func		=3D bpf_sched_entity_to_cgrpid,
> +	.gpl_only	=3D false,
> +	.ret_type	=3D RET_INTEGER,
> +	.arg1_type	=3D ARG_PTR_TO_BTF_ID,
> +	.arg1_btf_id	=3D &btf_sched_entity_ids[0],
> +};
> +
> +static const struct bpf_func_proto =
bpf_sched_entity_belongs_to_cgrp_proto =3D {
> +	.func		=3D bpf_sched_entity_belongs_to_cgrp,
> +	.gpl_only	=3D false,
> +	.ret_type	=3D RET_INTEGER,
> +	.arg1_type	=3D ARG_PTR_TO_BTF_ID,
> +	.arg1_btf_id	=3D &btf_sched_entity_ids[0],
> +	.arg2_type	=3D ARG_ANYTHING,
> +};
> +
> static const struct bpf_func_proto *
> bpf_sched_func_proto(enum bpf_func_id func_id, const struct bpf_prog =
*prog)
> {
> 	switch (func_id) {
> 	case BPF_FUNC_trace_printk:
> 		return bpf_get_trace_printk_proto();
> +	case BPF_FUNC_sched_entity_to_tgidpid:
> +		return &bpf_sched_entity_to_tgidpid_proto;
> +	case BPF_FUNC_sched_entity_to_cgrpid:
> +		return &bpf_sched_entity_to_cgrpid_proto;
> +	case BPF_FUNC_sched_entity_belongs_to_cgrp:
> +		return &bpf_sched_entity_belongs_to_cgrp_proto;
> 	default:
> 		return NULL;
> 	}
> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
> index 00ac7b79cddb..84019ba5b67b 100755
> --- a/scripts/bpf_doc.py
> +++ b/scripts/bpf_doc.py
> @@ -548,6 +548,7 @@ class PrinterHelpers(Printer):
>           'struct socket',
>           'struct file',
>           'struct bpf_timer',
> +            'struct sched_entity',
>   ]
>   known_types =3D {
>           '...',
> @@ -596,6 +597,7 @@ class PrinterHelpers(Printer):
>           'struct socket',
>           'struct file',
>           'struct bpf_timer',
> +            'struct sched_entity',
>   }
>   mapped_types =3D {
>           'u8': '__u8',
> diff --git a/tools/include/uapi/linux/bpf.h =
b/tools/include/uapi/linux/bpf.h
> index 6dfbebb8fc8f..199e4a92820d 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -4900,6 +4900,26 @@ union bpf_attr {
> *		**-EINVAL** if *flags* is not zero.
> *
> *		**-ENOENT** if architecture does not support branch =
records.
> + *
> + * u64 bpf_sched_entity_to_tgidpid(struct sched_entity *se)
> + *	Description
> + *		Return task's encoded tgid and pid if the sched entity =
is a task.
> + *	Return
> + *		Tgid and pid encoded as tgid << 32 \| pid, if *se* is a =
task. (u64)-1 otherwise.
> + *
> + * u64 bpf_sched_entity_to_cgrpid(struct sched_entity *se)
> + *	Description
> + *		Return cgroup id if the given sched entity is a cgroup.
> + *	Return
> + *		Cgroup id, if *se* is a cgroup. (u64)-1 otherwise.
> + *
> + * long bpf_sched_entity_belongs_to_cgrp(struct sched_entity *se, u64 =
cgrpid)
> + *	Description
> + *		Checks whether the sched entity belongs to a cgroup or
> + *		it's sub-tree. It doesn't require a cgroup CPU =
controller
> + *		to be enabled.
> + *	Return
> + *		1 if the sched entity belongs to a cgroup, 0 otherwise.
> */
> #define __BPF_FUNC_MAPPER(FN)		\
> 	FN(unspec),			\
> @@ -5079,6 +5099,9 @@ union bpf_attr {
> 	FN(get_attach_cookie),		\
> 	FN(task_pt_regs),		\
> 	FN(get_branch_snapshot),	\
> +	FN(sched_entity_to_tgidpid),	\
> +	FN(sched_entity_to_cgrpid),	\
> +	FN(sched_entity_belongs_to_cgrp),	\
> 	/* */
>=20
> /* integer value in 'imm' field of BPF_CALL instruction selects which =
helper
> --=20
> 2.31.1
>=20
>=20

