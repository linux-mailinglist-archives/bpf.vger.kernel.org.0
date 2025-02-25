Return-Path: <bpf+bounces-52491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A041A43638
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 08:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76A893AB6D8
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 07:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4BC1DA634;
	Tue, 25 Feb 2025 07:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3qrDRGZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171FE2571CD
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 07:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740468902; cv=none; b=SXWt+QaLYLKQ+BtuWDItgjKiNLwWbv8FjP0NF4AbTcVBIRtf5Gl8DKAFS8xQ4arhjxAEWF8UhBBcyjhHSYUMpIn5wjUlgdQ6BRIV+GivEIToiF4vJpHjV7ZqlSchyboA+gcXQ787n4CiIBRWwAptcPV0DAD5C+kNELLsUNxsiDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740468902; c=relaxed/simple;
	bh=77ndAPwUHUTSOK6R+bUg6MMnCgUacXWSSxk7zf+yy/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nfb03/dNyyVHWS6s7zRl7aLG8WAGWykdXQdf5jPYS+jeyoI1yEGmaByZACLi5eBK3KYAwtF3OWsS5D/A85flnV+7p06d5EJyBDv1qupBi1BTS0WmSgeKwZpnJ165A7NzaOJ4Hwc8riq8tLcfb5X/7XzJCs48rN8plOlPkjXudaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3qrDRGZ; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6dd049b5428so51437236d6.2
        for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 23:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740468900; x=1741073700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FE9sflhhxrlb/j0eeqx/pHfgkX4WOWiCgumZyGIJlcQ=;
        b=h3qrDRGZmRM1bBCsGnZ/2MaFPeBzmCzkMWlbIRyYlfxc4iE00ZBK0prAvCPZYTAaib
         x9VMly36TlXuyM/HRRP3+/R+GFWfLuYjbzgTGCmZ9OnFoPqWDi9bm/HtBjkTr3rtDUN7
         VKI9GTbM3jLPxCecVeFQtv2A/WLqUC1cXThydJR7f+Mnw2Xbmv3H0XIbx/mBlokME8Wg
         koLXr6bEp+xZ0aUjIUMVKYSkt0Nbu7BLDo2RFCEDUK1W5jnbatWlSSY0W9alwb7iLgoA
         JgFCK+rZpECEvTQdwx0sPF72NkQQBXssKBEL+Fm/BhIXYcU33k2qaCaV2DG+FMDFnoZV
         0a1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740468900; x=1741073700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FE9sflhhxrlb/j0eeqx/pHfgkX4WOWiCgumZyGIJlcQ=;
        b=WVgQC5Lgc+yRVUZbsQXjgs5Lj+pJXjDuf6ARTLQNW7P/83qhmKTNT5xTh8BXlTbkau
         IB9BWZgpzHcRtMVtRM+qLQYh872b6aH31UHft45ItJosmDIycJZnvn0BMYYBjTtVZJXp
         fYZyOAPXJoo+1dc1wpu11a+B1AoZ3qIPXqv+vE6rxc5zxqO3GCmNw0eruAGRs3DeOGLN
         AEcZKKCVo9tFnsgjAbubofebjZ+j0UOonvJaA42V3wSXweENEdPPJ1NplZkiJMpnW2A6
         YiAcatQWWoleTWV4jaepWWvjd1md7DpvNv19bGd2pZJMq4rlqFS7hiF/g7h7SnDXdlZU
         sq7A==
X-Forwarded-Encrypted: i=1; AJvYcCXwTzN51eNi6ujiNgk/rSrguZ+bx91lcAB4BXA+KuZWfdgAq/3UKJ1URxMAeEqU6ZoL36k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGpoM3I21sbHwWy3qne6pKpTjNqWQjKjL0URf0O0OUrGX3Uett
	6guLbrR6GvOzMLrOk3HvPoLXyafh7a2vpsKRP4vM5uDGUcEtRLSREPzZ1cbvyhg870rwiTOHqfB
	yzx4Z6gRaxgyOj2GKjEVM7vnBzrU=
X-Gm-Gg: ASbGnctxKBmw5x8CpHlSXJmueqJ7waUK+LM/xZPcnTvDEMjI46sRc+0vrFyTH/vospv
	R2c3YabOnCNna2gB1gA2gtkoyNsl7+G4OEmfLbLMSkDSvArur/IsDuP+r21cG0sK7JU90P7VFWk
	9+olq4O9A=
X-Google-Smtp-Source: AGHT+IFDWBLWP0MgglZOVd4QL0jbYqQK/5cXerNbPMgV7Lr9ByGJ+JtfJxUFUsS1hlUzTPfqpyuk0IWuabchfBSMXIA=
X-Received: by 2002:a05:6214:5190:b0:6e6:6240:afb with SMTP id
 6a1803df08f44-6e6ae7c9e48mr243909386d6.3.1740468899890; Mon, 24 Feb 2025
 23:34:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224114606.3500-1-laoar.shao@gmail.com> <20250224114606.3500-2-laoar.shao@gmail.com>
 <CAADnVQKUYP8e_u5QWGHK_fi_LKyOO3voFkHyRLCuw9-qKiFmDQ@mail.gmail.com>
In-Reply-To: <CAADnVQKUYP8e_u5QWGHK_fi_LKyOO3voFkHyRLCuw9-qKiFmDQ@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 25 Feb 2025 15:34:21 +0800
X-Gm-Features: AQ5f1JquBrblQrHdHpCFPlrWnTE4sp0Tq-WsprxbTD3Fl8PoFngZuKNkS2wqJ3k
Message-ID: <CALOAHbCM_9NotV3UqeOiK-s_Cd-HAUS+1L834Di1Pw75iyTCOA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bpf: Reject attaching fexit to functions annotated
 with __noreturn
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 1:30=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Feb 24, 2025 at 3:46=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > +       } else if (prog->expected_attach_type =3D=3D BPF_TRACE_FEXIT &&
> > +                  btf_id_set_contains(&fexit_deny, btf_id)) {
> > +               verbose(env, "Attaching fexit to __noreturn functions i=
s rejected.\n");
> > +               return -EINVAL;
>
> Just realized that this needs to include
> prog->expected_attach_type =3D=3D BPF_MODIFY_RETURN
> since it's doing __bpf_tramp_enter() too.

I will add it.

>
> Also the list must only contain existing functions.
> Otherwise there are plenty of build warns:
>   BTFIDS  vmlinux
> WARN: resolve_btfids: unresolved symbol xen_start_kernel
> WARN: resolve_btfids: unresolved symbol xen_cpu_bringup_again
> WARN: resolve_btfids: unresolved symbol usercopy_abort
> WARN: resolve_btfids: unresolved symbol snp_abort
> WARN: resolve_btfids: unresolved symbol sev_es_terminate
> WARN: resolve_btfids: unresolved symbol rust_helper_BUG
> ...

I missed these warnings.
It looks like we need to add "#ifdef XXXX" to each function.
Alternatively, could we just compare the function name with
prog->aux->attach_func_name instead?

--
Regards
Yafang

