Return-Path: <bpf+bounces-21089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D73847BF3
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 23:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9401A1F21AAC
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 22:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D308283A18;
	Fri,  2 Feb 2024 22:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAGuexhp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCE12943C
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 22:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706911394; cv=none; b=bWD51zgkAYU+YJskCc5a0CWl23HfAXRVZ/pXWV23cN2KHv0UxAAvBJX4cBxVnkTyk1SU0eQe4cgnKBiJ3HbCNoDSLywH77X7B9K8Mygx7vXsy2JmzqK/vosF7aw56AcgTR/UBZeIC3Ujo/GMdt8l4OG8SEO6U/SWZpwzhNlJWfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706911394; c=relaxed/simple;
	bh=Q3rAO8m3jpybskd9OmuFSwvr8SsAmSZjqARlIPSXgLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmyLpRmKN7xd5uQLPCDowVpY19afEHY1GKm4nk84OqIdUW5gYcstvQR5ZzifOG2zDXnbHBlcYTdwC5a34tH0VEhcmouuBQV+xW1QmkMJVcCUJHalsvXmxO72qHUdmy6Ifn+62kK748BCycVLNbg8uehDwP8gFE1EwV42c9Zq95o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAGuexhp; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6de2f8d6fb9so1916224b3a.1
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 14:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706911392; x=1707516192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrEr8SzBcIbbhO2jPACEG0wW3x6SaIBE1ZE+NF8xMOI=;
        b=dAGuexhpyT0awuGu6Yw74FMgDMYnfo4D4Egw0vBhdPOglqm5zfPotoPVVW/WUss1/e
         mcmt5GrhkbeGLCVE1IjAATb0YXTnjd1RfyW9+54fiYHINpPEMwKIlLnq9KrRTkVKODxv
         V1Xk/4lLMB4TJUEZWww07u0ye3gVGyiB+zkz1866HKppNzqAcUyxl/z5B9JuaznZKnJL
         r2BZUtMU8Si31BdKVS6yUtmFP+T5UZHJ37dKOffoBx7k4hweAeQK4v8Wle8qEMVJd4hD
         9Qz0ELsd69nimK2O3ynSztkqkv3PjdzV05cFPFCkn7XrFpKfYII4ua0REqYka2hTff0Y
         UOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706911392; x=1707516192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vrEr8SzBcIbbhO2jPACEG0wW3x6SaIBE1ZE+NF8xMOI=;
        b=TayHre1VPLbcmgQQqWfVUmHw97O5eNFPRK8ICXq6MEti7jiacTSvTPRRz6MOjyKwNu
         tN8WBzynxNoOQtUDWxzB6lah89NeNhrducA7AGnXcV1Az1Du6kdjb0ipjqSyO2mhhH6j
         5AjVKbPJ0sgfBXKIlppDKgcDuxs3NZNmnr4M+e6yzks/IN+s+sQNLsKENKfXcT0ke4QV
         CKvX9ALmLLsLM1x45Dfboqf/YLKRCDpaso9D4kXVMjvCle30a1e6z92RcoUuHdU62l1r
         rUSCNBcFNsNDl+nQSAvEm8di/5aBCP6+os3OZmY3XDYhPEUVBfwF+jl9LxhSpxNzzoXu
         laYg==
X-Gm-Message-State: AOJu0YyswiPnSoSGx9p7EdPU0DoI62KsRRkYDRurg+1KrOmKVZ3GGv3Y
	loVNyr4osGQT+1YEY7XHN9pXOU6pOG2yfacFLExJyuytPsp2+JjAg9/XVAQjYxaJhqlinddhGGl
	KkdhXbF8UbFZyEPPdw0pzaNusPelsx1Ol
X-Google-Smtp-Source: AGHT+IEJbEpmSAOuvy+maDbJJTBn7QBjIt8eE6x6ryZKbZlcVVqhKRYeis/Yx4v00+eOdcT2pMlvCGZnWZfuN8wl7Tc=
X-Received: by 2002:a62:fb14:0:b0:6db:b355:892d with SMTP id
 x20-20020a62fb14000000b006dbb355892dmr6923425pfm.2.1706911391479; Fri, 02 Feb
 2024 14:03:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131145454.86990-1-laoar.shao@gmail.com> <20240131145454.86990-3-laoar.shao@gmail.com>
In-Reply-To: <20240131145454.86990-3-laoar.shao@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 2 Feb 2024 14:02:58 -0800
Message-ID: <CAEf4BzZ6LGYSQocavFoLLDNnEHzeENfX1HYF=DU7rcpbT+moSw@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 2/4] bpf, docs: Add document for cpumask iter
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, tj@kernel.org, void@manifault.com, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 6:55=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> This patch adds the document for the newly added cpumask iterator
> kfuncs.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>


>  Documentation/bpf/cpumasks.rst | 60 ++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>
> diff --git a/Documentation/bpf/cpumasks.rst b/Documentation/bpf/cpumasks.=
rst
> index b5d47a04da5d..5cedd719874c 100644
> --- a/Documentation/bpf/cpumasks.rst
> +++ b/Documentation/bpf/cpumasks.rst
> @@ -372,6 +372,66 @@ used.
>  .. _tools/testing/selftests/bpf/progs/cpumask_success.c:
>     https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree=
/tools/testing/selftests/bpf/progs/cpumask_success.c
>
> +3.3 cpumask iterator
> +--------------------
> +
> +The cpumask iterator facilitates the iteration of per-CPU data, includin=
g
> +runqueues, system_group_pcpu, and other such structures. To leverage the=
 cpumask
> +iterator, one can employ the bpf_for_each() macro.
> +
> +Here's an example illustrating how to determine the number of running ta=
sks on
> +each CPU.
> +
> +.. code-block:: c
> +
> +        /**
> +         * Here's an example demonstrating the functionality of the cpum=
ask iterator.
> +         * We retrieve the cpumask associated with the specified pid, it=
erate through
> +         * its elements, and ultimately expose per-CPU data to userspace=
 through a
> +         * seq file.
> +         */
> +        const struct rq runqueues __ksym __weak;
> +        u32 target_pid;
> +
> +        SEC("iter/cgroup")
> +        int BPF_PROG(cpu_cgroup, struct bpf_iter_meta *meta, struct cgro=
up *cgrp)
> +        {
> +                u32 nr_running =3D 0, nr_cpus =3D 0, nr_null_rq =3D 0;
> +                struct task_struct *p;
> +                struct rq *rq;
> +                int *cpu;
> +
> +                /* epilogue */
> +                if (cgrp =3D=3D NULL)
> +                        return 0;
> +
> +                p =3D bpf_task_from_pid(target_pid);
> +                if (!p)
> +                        return 1;
> +
> +                BPF_SEQ_PRINTF(meta->seq, "%4s %s\n", "CPU", "nr_running=
");
> +                bpf_for_each(cpumask, cpu, p->cpus_ptr) {
> +                        rq =3D (struct rq *)bpf_per_cpu_ptr(&runqueues, =
*cpu);
> +                        if (!rq) {
> +                                nr_null_rq +=3D 1;
> +                                continue;
> +                        }
> +                        nr_cpus +=3D 1;
> +
> +                        if (!rq->nr_running)
> +                                continue;
> +
> +                        nr_running +=3D rq->nr_running;
> +                        BPF_SEQ_PRINTF(meta->seq, "%4u %u\n", *cpu, rq->=
nr_running);
> +                }
> +                BPF_SEQ_PRINTF(meta->seq, "Summary: nr_cpus %u, nr_runni=
ng %u, nr_null_rq %u\n",
> +                               nr_cpus, nr_running, nr_null_rq);
> +
> +                bpf_task_release(p);
> +                return 0;
> +        }
> +
> +----
>
>  4. Adding BPF cpumask kfuncs
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> --
> 2.39.1
>

