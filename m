Return-Path: <bpf+bounces-66109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A09AB2E6A2
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 22:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 545CE166B09
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 20:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96472D0C8C;
	Wed, 20 Aug 2025 20:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArQDW3Y4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E089E24A067;
	Wed, 20 Aug 2025 20:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755721860; cv=none; b=K12/i7Qsp1UNfjhhpeJAJozh0MA16gVoKSmE2kyA2l88uXTMxOm6JLdogkeinY/pp+py5v3UMkJzhOKtmrZr9xhqoMTciFV0fl9pqvcERpUoSbqm7KvVf3IcOTUYLF7Iqqoq6+dS9Z2ZWPgEfAtZbVkT3+w3MDVc5m9hF9A3QMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755721860; c=relaxed/simple;
	bh=TtQfYxlR2mv1T4y5QtkkiywGjZL4FQ4ly23M+YYr96c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=todORJq3ikQ42eS903z2a1meEuVZ2uzJ3yOfK4G+laSfJs2Vfyjerzv4ro/2BhwTMh+glbe4xI045QTBLLA2F1kxpXLMzV98s+KCl4PLcDiqkO4e/HJQGjHIT1g8KyuTXwlpc2rBwzevWkOVmXod5CIpTOmEJMel2e8dQZdK+lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArQDW3Y4; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e2eb49b83so250315b3a.3;
        Wed, 20 Aug 2025 13:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755721858; x=1756326658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haFKTAbs5Tny8Vs6O0gC3BA+knNAjGzusbJ6lTT10ho=;
        b=ArQDW3Y4ClHJBJ+DIz2TvmANFXkFjSNk7VFsLbgAasOeix8uqBwByNKlJM+FA38rA2
         kxKHaMbXakOlPL50WDV/niszDtFUNTChmlhMd3vmy9ACdA203cWxQzr1p/1kYaTPCORU
         ECF37sHSXaxIOYCoO2qcpGgoZXoXPLtoexfvAuupItdbvdbs6UFZ0Y/52ZTL/tNqPBSW
         wjp8DXkxTj5xseYEtZ8klHZhEhxNX8DaqjN4hG9naJ8/zQa6/ZGRIZDqFRvEwNzuUe6j
         GTj2c4JAROXu96JwR+qPU8BtCDgCOd2d3XZ8r3KbGLW0H9iiDTg57/0+u12fE//YGglK
         VsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755721858; x=1756326658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haFKTAbs5Tny8Vs6O0gC3BA+knNAjGzusbJ6lTT10ho=;
        b=fnZf8hvi5R86+fvHqENxPDIU6oh1aLlzBDsKkXYL5C+Q7C0gHTp6Q9LsWMYByYNYHD
         rgEGS5PT31S+l6wLP3/3+Nk0T4gdLJ6T31JNNNM8acR7voJTXk1Evb7Ad8hTJnwhZ0VG
         jyiDwKLteSMQOCn4jEb5K6f8xfiBlHqBYI05ywqMJvZnpvPKYmqWlAUpVbzt+/F8epjH
         LJvpOgJF6bT4JOPyNzmHfeDVfdzWDiGe1owyAeuOG+B2zKXDFh9NtOCVYN9SgQUh2NXi
         /yY8/kF5GchhYaUAq8xovLT6mT5RI1c/xEqVqd7K9eBRhdk7NSPGijs4zTVnfXU+F4lZ
         zIEQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1hx6BZSyKPQntm8MI7/YI2QSl5nV+gm+rpWhKuIhIWCggpEOWPdN0LwCfiZFeqrr7tlOBuqPEhFU7jkcZ@vger.kernel.org, AJvYcCWEG2P/yrXOfrE+KLlAv0mmUGUe/aNTchM0Fu3AHrii0bT6jQdWPEBQArliPQCaqgBK2eg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpFf6TX/MWeCT+5p8uUX6i/KhvuPfEg0/KXHa0jyJae3WoET9g
	48rWYH73T/F/Da2xQRslVXT6s8jh6f1snN/+hbE+0OT4yx7HtNfXuxHnFHfUsS6+kxEh6ygtgdq
	d7g1LSLaIpBowHZFN9jZZWVzGIaUhB0ZuTA==
X-Gm-Gg: ASbGnctscRnDEHV43yyXDImKPZ7aDbrnGW+8ch9IbwXmjXyY6u14x0sznFhg1Y8XHBG
	8wvoYbVj+tPwPSdgjiW/l4kL6rg42Uq+qS7n8Uh2jMUXRg9OO4uCnxr6AT6aFMvih4N6E1UT4+F
	EkaGtKcnZfW/RKAhbvP1Ri5/iewrxWUosKDBH1Rd7TS2JZklfZwtGF3pZaoeuRE8ki1fIOvYg/u
	n1rV2XBHmuwGIhmP0R432Y=
X-Google-Smtp-Source: AGHT+IE5n0Bns28zygXbHS8e9bH4xWdkCx6MVM26q5cQEoplrKB/d0AEPiEfdzeB2dk2vflhRIZy7tPOCzcSq/xzovI=
X-Received: by 2002:a05:6a20:734d:b0:240:1b13:459f with SMTP id
 adf61e73a8af0-2431b7e8471mr5955796637.7.1755721857967; Wed, 20 Aug 2025
 13:30:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818170136.209169-1-roman.gushchin@linux.dev> <20250818170136.209169-14-roman.gushchin@linux.dev>
In-Reply-To: <20250818170136.209169-14-roman.gushchin@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 20 Aug 2025 13:30:43 -0700
X-Gm-Features: Ac12FXxN7EsA0M3L5RyQZ7vnsZhxapdSolyvYSTeykW7JzyuK6Qpizpy4PpCg1M
Message-ID: <CAEf4BzaSLWB1xpCjX35oxg2ySvvgRvEmQ01PtXv+xEz-Zkz07w@mail.gmail.com>
Subject: Re: [PATCH v1 13/14] sched: psi: implement bpf_psi_create_trigger() kfunc
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-mm@kvack.org, bpf@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Song Liu <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 10:06=E2=80=AFAM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
>
> Implement a new bpf_psi_create_trigger() bpf kfunc, which allows
> to create new psi triggers and attach them to cgroups or be
> system-wide.
>
> Created triggers will exist until the struct ops is loaded and
> if they are attached to a cgroup until the cgroup exists.
>
> Due to a limitation of 5 arguments, the resource type and the "full"
> bit are squeezed into a single u32.
>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  kernel/sched/bpf_psi.c | 84 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>
> diff --git a/kernel/sched/bpf_psi.c b/kernel/sched/bpf_psi.c
> index 2ea9d7276b21..94b684221708 100644
> --- a/kernel/sched/bpf_psi.c
> +++ b/kernel/sched/bpf_psi.c
> @@ -156,6 +156,83 @@ static const struct bpf_verifier_ops bpf_psi_verifie=
r_ops =3D {
>         .is_valid_access =3D bpf_psi_ops_is_valid_access,
>  };
>
> +__bpf_kfunc_start_defs();
> +
> +/**
> + * bpf_psi_create_trigger - Create a PSI trigger
> + * @bpf_psi: bpf_psi struct to attach the trigger to
> + * @cgroup_id: cgroup Id to attach the trigger; 0 for system-wide scope
> + * @resource: resource to monitor (PSI_MEM, PSI_IO, etc) and the full bi=
t.
> + * @threshold_us: threshold in us
> + * @window_us: window in us
> + *
> + * Creates a PSI trigger and attached is to bpf_psi. The trigger will be
> + * active unless bpf struct ops is unloaded or the corresponding cgroup
> + * is deleted.
> + *
> + * Resource's most significant bit encodes whether "some" or "full"
> + * PSI state should be tracked.
> + *
> + * Returns 0 on success and the error code on failure.
> + */
> +__bpf_kfunc int bpf_psi_create_trigger(struct bpf_psi *bpf_psi,
> +                                      u64 cgroup_id, u32 resource,
> +                                      u32 threshold_us, u32 window_us)
> +{
> +       enum psi_res res =3D resource & ~BPF_PSI_FULL;
> +       bool full =3D resource & BPF_PSI_FULL;
> +       struct psi_trigger_params params;
> +       struct cgroup *cgroup __maybe_unused =3D NULL;
> +       struct psi_group *group;
> +       struct psi_trigger *t;
> +       int ret =3D 0;
> +
> +       if (res >=3D NR_PSI_RESOURCES)
> +               return -EINVAL;
> +
> +#ifdef CONFIG_CGROUPS
> +       if (cgroup_id) {
> +               cgroup =3D cgroup_get_from_id(cgroup_id);
> +               if (IS_ERR_OR_NULL(cgroup))
> +                       return PTR_ERR(cgroup);
> +
> +               group =3D cgroup_psi(cgroup);
> +       } else
> +#endif
> +               group =3D &psi_system;

just a drive-by comment while skimming through the patch set: can't
you use IS_ENABLED(CONFIG_CGROUPS) and have a proper if/else with
proper {} ?

> +
> +       params.type =3D PSI_BPF;
> +       params.bpf_psi =3D bpf_psi;
> +       params.privileged =3D capable(CAP_SYS_RESOURCE);
> +       params.res =3D res;
> +       params.full =3D full;
> +       params.threshold_us =3D threshold_us;
> +       params.window_us =3D window_us;
> +
> +       t =3D psi_trigger_create(group, &params);
> +       if (IS_ERR(t))
> +               ret =3D PTR_ERR(t);
> +       else
> +               t->cgroup_id =3D cgroup_id;
> +
> +#ifdef CONFIG_CGROUPS
> +       if (cgroup)
> +               cgroup_put(cgroup);
> +#endif
> +
> +       return ret;
> +}
> +__bpf_kfunc_end_defs();
> +
> +BTF_KFUNCS_START(bpf_psi_kfuncs)
> +BTF_ID_FLAGS(func, bpf_psi_create_trigger, KF_TRUSTED_ARGS)
> +BTF_KFUNCS_END(bpf_psi_kfuncs)
> +
> +static const struct btf_kfunc_id_set bpf_psi_kfunc_set =3D {
> +       .owner          =3D THIS_MODULE,
> +       .set            =3D &bpf_psi_kfuncs,
> +};
> +
>  static int bpf_psi_ops_reg(void *kdata, struct bpf_link *link)
>  {
>         struct bpf_psi_ops *ops =3D kdata;
> @@ -238,6 +315,13 @@ static int __init bpf_psi_struct_ops_init(void)
>         if (!bpf_psi_wq)
>                 return -ENOMEM;
>
> +       err =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
> +                                       &bpf_psi_kfunc_set);

would this make kfunc callable from any struct_ops, not just this psi one?

> +       if (err) {
> +               pr_warn("error while registering bpf psi kfuncs: %d", err=
);
> +               goto err;
> +       }
> +
>         err =3D register_bpf_struct_ops(&bpf_psi_bpf_ops, bpf_psi_ops);
>         if (err) {
>                 pr_warn("error while registering bpf psi struct ops: %d",=
 err);
> --
> 2.50.1
>
>

