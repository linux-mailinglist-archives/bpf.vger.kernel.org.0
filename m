Return-Path: <bpf+bounces-12770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B35907D05A6
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 02:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40E60B2144C
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 00:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E126A2F43;
	Fri, 20 Oct 2023 00:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clB+zGYH"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898FC2F2D
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 00:04:08 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D243ECF;
	Thu, 19 Oct 2023 17:04:06 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40806e40fccso1733635e9.2;
        Thu, 19 Oct 2023 17:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697760245; x=1698365045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8rgHM7FZqxCqzn7vvq1TlUzERIDuJUAdkWJ8iiKEaQ=;
        b=clB+zGYHs/NktN3rp/F7A0O9ExdzxDeTRaNPZYA8jV6ipbr7wp26A/ErQXo5dubWNv
         bHv/L5/9szBRlfM1h32TLKkcDjRCHs4TdOqVFVykOfrnccpv1/FDTDicxNlk3oqxTWOy
         /uhyMqcVjYCDdKGLks1Ii5phG/9NNzMGq4fysaIDzjjHsNfGKubFycYDH8EKANBmUB1c
         U39m4VmKB/+fkh/4Nr84/sgyEAZ/6uuEQg58YBX6P112eCV4234++DdbzLaSs6BP6zuZ
         6focYJ9u+TshGLDXIOswUGLaaFSssoqndWRKGEykJgP0r35TOM0T5j1ohoMna3jgCKZW
         Ykvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697760245; x=1698365045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8rgHM7FZqxCqzn7vvq1TlUzERIDuJUAdkWJ8iiKEaQ=;
        b=P48ELnTxvJS/ex7uafSMfR4J2NTtnG8XzMrE8HxS0jny9aiA62wAxaEJ2UrBiMRT+8
         tkEwcrtEXcqTWq6tR0XVvCZO1VuF+IQmpk24Uv6EbZt8Wb2PVqvKOca1bPIXVZPo0N4j
         f6HRKj+VMW+GusAlRk5wztB9al4q/KBq7MzNQ2xWYuH9GUk2f/Gis7j/TByAueCJOfMU
         s3yF4T4cZAcJWDWu7aQLIT4/m719fvp8HaM6rPJPnX+crriqLMu/nQGn/4k7PVENaEJP
         6zeWlNlh+3+jK7P4f7Ws7yINTR9I2evtu6VOR4rFosO3cZZwxIxf4Da+aZ6NExqYV+mB
         ltJA==
X-Gm-Message-State: AOJu0Yy2b2PT9FBp+lDWLZ/hacm1Y7Jp4CR6iLLfpcFumy7pgfafpSC1
	H+zIrTlsyrFJ3Hm89C0/wYYOwq4PksAOcPonESo=
X-Google-Smtp-Source: AGHT+IHdv7lkZrt8UJ//L/e8bVOjECVyYtNV+uypimXs+1Cig9E/s9CPakUtlbdc2PIqiauWw253HPN30C5Hif1WiXQ=
X-Received: by 2002:a5d:5b1c:0:b0:323:2f54:b6cb with SMTP id
 bx28-20020a5d5b1c000000b003232f54b6cbmr342241wrb.8.1697760245097; Thu, 19 Oct
 2023 17:04:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018061746.111364-1-zhouchuyi@bytedance.com> <20231018061746.111364-9-zhouchuyi@bytedance.com>
In-Reply-To: <20231018061746.111364-9-zhouchuyi@bytedance.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 19 Oct 2023 17:03:53 -0700
Message-ID: <CAADnVQKafk_junRyE=-FVAik4hjTRDtThymYGEL8hGTuYoOGpA@mail.gmail.com>
Subject: Re: [RESEND PATCH bpf-next v6 8/8] selftests/bpf: Add tests for
 open-coded task and css iter
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2023 at 11:18=E2=80=AFPM Chuyi Zhou <zhouchuyi@bytedance.co=
m> wrote:
>
> +
> +SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
> +__failure __msg("css_task_iter is only allowed in bpf_lsm and bpf iter-s=
")
> +int BPF_PROG(iter_css_task_for_each)
> +{
> +       u64 cg_id =3D bpf_get_current_cgroup_id();
> +       struct cgroup *cgrp =3D bpf_cgroup_from_id(cg_id);
> +       struct cgroup_subsys_state *css;
> +       struct task_struct *task;
> +
> +       if (cgrp =3D=3D NULL)
> +               return 0;
> +       css =3D &cgrp->self;
> +
> +       bpf_for_each(css_task, task, css, CSS_TASK_ITER_PROCS) {
> +
> +       }
> +       bpf_cgroup_release(cgrp);
> +       return 0;
> +}

I think we should relax allowlist in patch 2 further.
Any sleepable is safe.
Allowlist is needed to avoid dead locking on css_set_lock.
Any lsm and any iter (even non-sleepable) and any sleepable
seems to be safe.

Then the above test would need s/fentry.s/fentry/ to stay relevant.

I would also add:

SEC("iter/cgroup")
int cgroup_id_printer(struct bpf_iter__cgroup *ctx)
{
        struct seq_file *seq =3D ctx->meta->seq;
        struct cgroup *cgrp =3D ctx->cgroup;

        /* epilogue */
        if (cgrp =3D=3D NULL) ..

        bpf_for_each(css_task, task, css, CSS_TASK_ITER_PROCS) {
           BPF_SEQ_PRINTF(); // something about task
        }

To demonstrate how new kfunc iter can be combined with cgroup iter and
it won't deadlock, though cgroup iter is not sleepable.

I've applied the current set. Pls send a follow up. Thanks

