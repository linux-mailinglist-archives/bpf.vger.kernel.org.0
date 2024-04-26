Return-Path: <bpf+bounces-27979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 765B18B40C1
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 22:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86231C22EB5
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 20:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC432260A;
	Fri, 26 Apr 2024 20:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdgdLWF0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BDC1BF2F
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 20:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714162849; cv=none; b=tPpJr7f2g2VoznE6WfS1FDEKFh9zdA6Are4cRr5sKXD8BeIsbUpE4CmyBDcyVBDXFAJAQXPu3CFSkHU84yUlgPIIC/UcuPVJhGCvxX0pjb/JSPUGvo57wq7nU/LkTMOXkR/UIlQe7fWP2g0RmAW/pPmuGD44VOxSvXrmu73JNZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714162849; c=relaxed/simple;
	bh=LFbNYzCXuxtW6BQZHUqKUelX1ujYRzkupwJOfTMTUHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQ9pL2S9tlGEZqlGph4N3hqs8TKTQis4azWmzif1LEK2wRH9Dk0emiuE1OzWyyuSOI2GYhAWT6sRC2OAgERAtTNAxjhCLnDrfOYaxbtmP1jMJoCvEt3qPvBcrz/+7fd062YJbsfE4IBOu2jgK88UX7tA1iESGB6eIHT/9RYCbb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdgdLWF0; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso2011617a12.0
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 13:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714162847; x=1714767647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkND1HldruIqIw3gO759O50zC++DComa+XTr4qiirBo=;
        b=OdgdLWF0YC17a2O6Gu7f5PKCAWOkvGlWxVOg2uLkkx0+6zDrTrk8oddBV8ygy+gd2H
         DXmYQZYZmp9sDr3InXAwmwTewRviCBZU1qKK62kVHJJMAlOTXc4xZ163j+2rZVBxvqwI
         w4CXoX8qqb3ocIq7Z0/d5pDDEGAjFuc7L49tgZphpjoA/4KgI6h2mVl1A4wyrgAtXSzy
         /l+7X5svIloyu1vu/CWXtnrvvNU+64qUWMPMzYzfLOxMFza17599LsndZBH/lDCPLdPb
         /zw1QGEjT8DWXNr6tdZOnlbox/PPTqvqhAZagbHIyEK9KBa3UJrdDVIm/+9dgIqQUzwm
         ybtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714162847; x=1714767647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rkND1HldruIqIw3gO759O50zC++DComa+XTr4qiirBo=;
        b=tdDxTvm/2akEGU13YSMVq+aVHykRKb+2NeYqvoh835P3GlEOYRIV1Ukp3GiY5Na4Fm
         2B+A32B6wAFSj95Pi/spNGe+4MA8kPGMvjGC5AfdFeGzYzO2tj6R2jWIxOooXRFRgJn/
         6IDvgE6pZgGGrwL4+NqjWCq6mtGTK5lGFKe/RA8WeR+7PIrgORWBzQhRir/VFWKs7vj3
         jo5ByyFig6ahxiRzJZ25g1lzc9UsEcgpgbdJZ6IX82VZiPxrFQ3RwUxy3nqtWdQhduI8
         1tDq/lmdboO5YneNNus6ORp3S/HWDWJiwVLIyhdApbKnlk6QWwsBAPDWXi9O7e2+vNrz
         rKFg==
X-Gm-Message-State: AOJu0YxZ+pN2LQDQV30ixii+hpzceerlQnBD5IoISug8wxLRC7jWqjJF
	yhvUlI9fXtJyOhmMAjxRXQ2ljKG67U7+UDxR7BBpkH4Hwtw+t9LfUJwVXrsMpRaIXux/rfx+6Ba
	QR42N2P10VOK915h3FbxLucGGDbM=
X-Google-Smtp-Source: AGHT+IEqZZo0fbCqFhDk/8oxSSfXMexnQGgIld2+8tmgAuzNQlui98Mq4CmjlPPXame35lccXcnGD98xnUHs5mG9cDA=
X-Received: by 2002:a17:90a:5d91:b0:2ac:2b02:e167 with SMTP id
 t17-20020a17090a5d9100b002ac2b02e167mr3827996pji.37.1714162847409; Fri, 26
 Apr 2024 13:20:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426185630.17938-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20240426185630.17938-1-alexei.starovoitov@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Apr 2024 13:20:34 -0700
Message-ID: <CAEf4BzZZWBsFh5zkaxGhMZ1TR+NdoWNxTnu8QizWoL+3zZGmcw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix verifier assumptions about socket->sk
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com, 
	liamwisehart@meta.com, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 11:56=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> The verifier assumes that 'sk' field in 'struct socket' is valid
> and non-NULL when 'socket' pointer itself is trusted and non-NULL.
> That may not be the case when socket was just created and
> passed to LSM socket_accept hook.
> Fix this verifier assumption and adjust tests.
>
> Reported-by: Liam Wisehart <liamwisehart@meta.com>
> Fixes: 6fcd486b3a0a ("bpf: Refactor RCU enforcement in the verifier.")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  kernel/bpf/verifier.c                         | 23 +++++++++++++++----
>  .../selftests/bpf/progs/local_storage.c       | 20 ++++++++--------
>  .../testing/selftests/bpf/progs/lsm_cgroup.c  |  8 +++++--
>  3 files changed, 35 insertions(+), 16 deletions(-)
>

Makes sense, but can you also fix up one of benchmark's programs, see
[0], veristat-based CI run caught success->failure change (in
bench_local_storage_create.bpf.o)

  [0] https://github.com/kernel-patches/bpf/actions/runs/8853140420/job/243=
13511057

pw-bot: cr

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4e474ef44e9c..c2780a5c396a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2368,6 +2368,8 @@ static void mark_btf_ld_reg(struct bpf_verifier_env=
 *env,
>         regs[regno].type =3D PTR_TO_BTF_ID | flag;
>         regs[regno].btf =3D btf;
>         regs[regno].btf_id =3D btf_id;
> +       if (type_may_be_null(flag))
> +               regs[regno].id =3D ++env->id_gen;
>  }
>
>  #define DEF_NOT_SUBREG (0)

[...]

